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
   
function [ y ] = DivideStatus(params, ATP)
    %Creates a matrix to hold the division status of each cell (1=divide).
    %Equation 4 on page 707, Smallbone et al. .
    
    p = zeros(params.height, params.width);
    mask = logical((ATP > params.a0) .* (ATP < 1));    
    p( mask ) = (ATP(mask) - params.a0) / (1 - params.a0);
    p( ATP >= 1 ) = 1;
    u = rand(params.height, params.width);
    
    %Return a matrix with ones and zeros : Insert 1s if p > u and 0s when p < 0 .
    % 1 for division, 0 for quiescence.
    y = (p > u);
    
end