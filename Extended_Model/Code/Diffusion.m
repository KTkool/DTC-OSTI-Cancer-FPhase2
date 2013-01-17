% Copyright 2013 Kathryn Atwell, Adam Berrington, Lucy Hutchinson, Ronja Woloszczuk, Islom Nazarov 
%    Licensed under the Apache License, Version 2.0 (the "License");
%    you may not use this file except in compliance with the License.
%    You may obtain a copy of the License at
% 
%        http://www.apache.org/licenses/LICENSE-2.0
% 
%    Unless required by applicable law or agreed to in writing, software
%    distributed under the License is distributed on an "AS IS" BASIS,
%    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%    See the License for the specific language governing permissions and
%    limitations under the License.
   
function [updated] = Diffusion(params,State,species)

% updates the concentration of diffusive species.
% d^2 * grad^2(x) - phi_x = 0
% the state of the cell influences uptake

% type of diffusive species: 0 - Glucose; 1 - Oxygen
% this is necessary to specify the correct diffusion coefficient

N = params.width;
M = params.height;

% The diffusion is approximated using a finite difference method.
% We approach this by solving a system of linear equations 
%                   Matrix * x = b ,
% where x is a vector representing the concentrations, and Matrix defines
% the linear equations.

%% setting up the Matrix 

% We start by setting up the matrix as if we were in an infinite field
% We will need to replace some of the entries later to account for
% boundaries.


% this is sort of a tridiagonal matrix, just with 5 diagonals
va = -4*ones(1,N*M);
states = reshape(State', 1, []); %transforms matrix into vector (like x)

% creating the main diagonal of Matrix
if species == 0; % for glucose, see above
    
    % glucose uptake by cells (phi_g)
    phi_g = ones(1,N*M);    % normal cells
    phi_g(logical(mod(states,2)==0)) = params.k; % glycolytic cells
    phi_g(states==0) = 0;   % vacant cells
    vec_delta = params.dg*phi_g; % refer to eqn 16 on page 712 of Smallbone et al. ???
end

if species == 1; % for oxygen, see above
                                                                                                                                                                                                                                                                                                    
    % oxygen uptake c -I am sorry about this, but it is c in the paper.
    c = ones(1,N*M);
    c(states==0) = 0;
    vec_delta = params.dc*c;
end

% creating Matrix
% main diagonal
va = va - vec_delta;
M1a = diag(va);
% off diagonal for left and right element of the difference stencil
vb = ones(1,N*M-1);
M1b = diag(vb,1) + diag(vb,-1);
% other two diagonals for top and bottom element of the difference stencil
vc = ones(1,N*(M-1));
M1c = diag(vc,N) + diag(vc,-N);
% the entire Matrix
Matrix = M1a + M1b + M1c;

% zero flux boundary condition at the top
Matrix(1:N,:)=0;
for i=1:N
    Matrix(i,i) = 1;
    Matrix(i, i+N ) = -1;
end

% constant concentration at the bottom
Matrix(N*(M-1)+1:N*M,:)=0;
for i=1:N
    Matrix(N*(M-1)+i,N*(M-1)+i)=1;    
end


% periodic boundary conditions
% all cells in the right hand boundary
for j=2:M-1
    Matrix(j*N,j*N+1)=0;
    % rather than the one one later we want N-1 earlier
    % you need to set up Matrix yourself to make sense of this
    Matrix(j*N,(j-1)*N+1)=1;
end

% all cells in the left hand boundary
for j=1:M-2
    Matrix(j*N+1,j*N)=0;
    % rather than the one one earlier we want N-1 later
    Matrix(j*N+1,(j+1)*N)=1;
end


%% solving the system

% creating the right hand side b of  Matrix * x = b .
b1 = zeros(N*(M-1),1);
b2 = ones(N,1); % constant concentration near membrane
b = [b1;b2];

SMatrix = sparse(Matrix);
x = SMatrix\b;

%% getting the updated Matrix out
% transforming the vector x into a matrix which can be overlayed with the
% Cellular Automata.
temp = reshape(x,N,M);
updated = temp';


