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
function [Drug] = InitialiseDrug(params)
%Function which will set up the drug matrix and output the calculated
%drug diffused through the simulation

Drug = zeros(params.height, params.width);

%Place drug along bottom of simulation with value 1;
Drug(params.height, :) = 1;

%Solve using Diffusion, given species == 2 (drug)
Drug = Diffusion(params, Drug, 2);

end
