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


% Input : params, a structure with the following fields :
%    params.k : glycolytic rate (e.g. k = 10)
%    params.ht : tumour cell acidity threshold (should be 8.6 10^3)
%    params.hn : normal cell acidity thereshold (should be 9.3 10^2)
%    params.pa : Adaptation rate (10^-3)
%    params.width : Width of the grid (50)
%    params.height : Height of the grid 
%    params.na : Number of ATP molecules produced during complete oxydation
%    (Eq (1) of the paper). Typically 36
%    params.a0 : Minimum ATP for a cell to survive. Typically 0.1
%    params.dg : 1/dg^2, where dg is diffusion coefficient for glucose. (1.3*10^2)
%    params.dc : 1/dc^2, where dc is the diffusion coefficient for oxygen.
%    params.dd : 1/dd^2, where dd is the diffusion coeff of the drug
%    molecule
%    params.alpha : efficiency of the drug molecule (default 1)

params.k = 10;
params.ht = 8600;
params.hn = 930;
params.pa = 0.001;
params.width = 50;
params.height = 35;
params.na = 36;
params.a0 = 0.2;
params.dg = 1/130^2;
params.dc = 1/25;
params.dd = 4.5*10^-4; %Different to report since reduced by factor stated in Smallbone et al. Also = 1/dd^2
params.alpha = 1;
