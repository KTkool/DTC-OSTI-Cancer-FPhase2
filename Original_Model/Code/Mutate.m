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
   
function [ y ] = Mutate(params, parentState)
      % returns state value of cells newly created by cell division
      % one mutation can occur randomly in each daughter cell
      % 

    y = parentState;
    u = rand(1);
    
    % preparing conversion of State to binary
    parentState = parentState - 1;
    
    % Convert back to binary
    binaryCoeffs = [ mod(floor(parentState/4),2) mod(floor(parentState/2),2) mod(parentState,2)];
    
    % randomly pick one of the three mutations with likelihood pa
    if(params.pa > u)
        bitPosition = randsample(3,1);
        binaryCoeffs(bitPosition) = mod(binaryCoeffs(bitPosition) + 1,2);
	% convert back to decimal
        y = binaryCoeffs(1)*4 + binaryCoeffs(2)*2 + binaryCoeffs(3) + 1;
    end
    
end
