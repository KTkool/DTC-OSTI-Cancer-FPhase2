% Copyright 2013 A-team
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
   
function [updated] = Protons(params,State, Glucose, Oxygen)

% updates the concentration of protons.
% the state of the cell influences uptake

N = params.width;
M = params.height;

% We approach this by solving a system of linear equations Matrix * x = b

%% setting up the Matrix 

% We start by setting up the matrix as if we were in an infinite field
% We will need to replace some of the entries later to account for
% boundaries

% this is sort of a tridiagonal matrix, just with 5 diagonals
% main diagonal
va = -4*ones(1,N*M);
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

% FIXME? : Remove this condition to allow
% Acidic resistant cells to have an advantage
% over the other cells. Otherwise it is just 
% impossible to go throught the basement
%membrane
% constant concentration at the bottom
%Matrix(N*(M-1)+1:N*M,:)=0;
%for i=1:N
%    Matrix(N*(M-1)+i,N*(M-1)+i)=1;    
%end

% the difference stencil is not adapted to simulate drainage into the vasculature.
% i.e. the constant layer of 0 is moved one line below the plot.


% periodic boundary conditions
% all cells in the right hand boundary
for j=2:M-1
    Matrix(j*N,j*N+1)=0;
    %rather than the  one later we want N-1 earlier
    % you need to set up Matrix yourself to make sense of this
    Matrix(j*N,(j-1)*N+1)=1;
end

%all cells in the left hand boundary
for j=1:M-2
    Matrix(j*N+1,j*N)=0;
    %rather than the one one earlier we want N-1 later
    % you need to set up Matrix yourself to make sense of this
    Matrix(j*N+1,(j+1)*N)=1;
end


%% solving the system

states = reshape(State', 1, []);
% glucose uptake by cells (phi_g)
phi_g = reshape(Glucose',1,[]);    % normal cells
phi_g(logical((states==2) + (states==4) + (states==6) + (states==8))) = ...
    params.k*phi_g(logical((states==2) + (states==4) + (states==6) + (states==8))); % glycolytic cells
phi_g(states==0) = 0;   % vacant cells

% oxygen uptake c
c = reshape(Oxygen',1,[]);
c(states==0) = 0;

% creating the right hand side b of  Matrix * x = b .
b2 = (c - phi_g)';
b2(1:N) = 0;
% b2(end - N + 1:end) = 0;
RHS = b2;
SMatrix = sparse(Matrix);
x = SMatrix\RHS;

%% getting the updated Matrix out
% transforming the vector x into a matrix which can be overlayed with the
% Cellular Automata.
temp = reshape(x,N,M);
updated = temp';
