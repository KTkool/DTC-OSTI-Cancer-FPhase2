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

function [TotalNumber] = StatePlot(StateMatrix)
%Gets the total number of cells of each type, given a state matrix and
%outputs them in a matrix

setParams;

%Take in variableMatrix which is continuous matrix of values from
%simulation

%size_eachIter is the size of each iteration
sizeeachIter = params.height * params.width;

%Get the total size of the input matrix
[m,n] = size(StateMatrix);
MatrixArea = m*n;

%Calculate the number of iterations used to generate that matrix
Niter = MatrixArea / sizeeachIter;


%Reshape the matrix into a vector so that we can easily look through it to find our
%desired parameters
VariableVector = reshape(StateMatrix, 1, MatrixArea);

%loops through the vector for each iteration number,
%assigns total cell count for each type 1-8 in an array
for(i = 1:1:Niter)
    for(j = 1:1:8)
        TotalNumber(j, i) = sum(logical((VariableVector(1, 1 + (i-1)*sizeeachIter:i*sizeeachIter) == j)));
    end
    %5 and 7 are both same type so add together
    TotalNumber(5,i) = TotalNumber(5, i) + TotalNumber(7, i);
    
end




