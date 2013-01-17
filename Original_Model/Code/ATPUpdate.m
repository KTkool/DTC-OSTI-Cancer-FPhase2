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
%
%    Original code written by A-team
   
function [ATP] = ATPUpdate(params, Glucose, Oxygen, Drug, State)
%% Update the ATP matrix with both aerobic and anaerobic processes.

% The following equations can be found on (Smallbone et al., Page 711)

% State : A State matrix of size NxM with entries from 0 to 8
% Glucose : A Glucose matrix of size NxM. \phi_g
% Oxygen : A matrix of size NxM. \phi_c = C = c (because C_X = 1)

% \phi_a = c + n(\phi_g -c) . But here c = C/Cx and Cx = 1.
% Also, n = 2/params.na

k_matrix = zeros(params.height, params.width);

% Select glycolytic cells (even state numbers).
mask1 = logical((mod(State,2) == 0) .* (State > 0));

% Modified k-matrix depending on new parameterisation of drug 
% k_new = k_old ( concentration *(alpha -1) + 1)
k_matrix = params.k * (Drug * (params.alpha - 1) + 1);

phiGlucose = zeros(params.height, params.width);
phiGlucose = Glucose;

if(max(max(Drug)) > 0) % If the drug is present in the simulation replace with the new phiGlucose, modified k
    phiGlucose(mask1) = k_matrix(mask1) .* Glucose(mask1);
else
    phiGlucose(mask1) = params.k * Glucose(mask1);
end

phi_h = phiGlucose - Oxygen;
phi_h(State == 0) = 0;

mask2 = phi_h >= 0;

% Implement equation 11
% Select oxygen for all live cells and use phi_h from above to
% update ATP production matrix.
ATP = (Oxygen .* (State ~=0)) + 2/(params.na) * (mask2 .* phi_h);