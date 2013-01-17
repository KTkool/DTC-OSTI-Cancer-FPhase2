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
   
function [State,ATP,Glucose,Oxygen,Hydrogen] = InitialiseProblem(params)
%% Initialise the problem using the params structure
% Input : params, a structure with the following fields (values taken from Smallbone et al., 2007) :
%    params.k : glycolytic rate (e.g. k = 10)
%    params.ht : tumour cell acidity threshold (should be 8.6 10^3)
%    params.hn : normal cell acidity thereshold (should be 9.3 10^2)
%    params.pa : Adaptation rate (10^-3)
%    params.width : Width of the grid (50)
%    params.height : Height of the grid 
%    params.na : Number of ATP molecules produced during complete oxydation
%    (Eq (1) of the paper). Typically 36
%    params.a0 : Minimum ATP for a cell to survive. Typically 0.1
%    params.dg : 1/dg^2, where dg is the diffusion coefficient for glucose. (dg=1.3*10^2)
%    params.dc : 1/dc^2, where dc is the diffusion coefficient for oxygen. (dc=5)

% A cell can have one of 9 states : Empty or up to 3 mutations:
% hyperplastic, acid-resitant, glycolytic.
% In this implementation the state of the cell is described by a number
% between 0 and 8.
% 0 : Empty
% 1 : Normal
% x : decimal representation of the binary number described by
% Hyperplastic acid-resistant glycolytic plus one.
% For example, if the cell is hyperplastic and glycolytic it is
%     101 --> 5 + 1 = 6

% Initialise by setting a layer of normal cells. The rest is empty.
State = zeros(params.height,params.width);
State(params.height,:) = 1; %Start with normal cells 000 + 1

% Initial conditions
ATP = zeros(params.height,params.width);
ATP(params.height,:) = 1;

Glucose = zeros(params.height,params.width);
Glucose(params.height,:) = 1;

Oxygen = zeros(params.height,params.width);
Oxygen(params.height,:) = 1;

Hydrogen = zeros(params.height,params.width);
Hydrogen(params.height,:) = 0;

end

