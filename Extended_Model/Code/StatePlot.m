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

%Script which will plot the relative cell types increase and decrease over
%time

function [TotalNumber] = StatePlot1(StateMatrix)
setParams;

%Take in variableMatrix which is continuous matrix of values from
%simulation

StateMatrix=StateMatrix';

%size_eachIter is the size of each iteration
sizeeachIter = params.height * params.width;

%Get the total size of the input matrix
[m,n] = size(StateMatrix);
MatrixArea = m*n;

%Calculate the number of iterations used to generate that matrix
Niter = MatrixArea / sizeeachIter;


%Reshape the matrix into a vector so that we can easily look through it to find our
%desired parameters
StateVector = reshape(StateMatrix, 1, MatrixArea);
GlucoseVector = reshape(StateMatrix, 1, MatrixArea);
OxygenVector = reshape(StateMatrix, 1, MatrixArea);
ATPVector = reshape(StateMatrix, 1, MatrixArea);
HydrogenVector = reshape(StateMatrix, 1, MatrixArea);

%loops through the vector for each iteration number,
%assigns total cell count for each type 1-8 in an array
for(i = 1:1:Niter)
    for(j = 1:1:16)
        
        TotalNumber(j, i) = sum(logical((StateVector(1, 1 + (i-1)*sizeeachIter:i*sizeeachIter) == j)));
        
    end
    GlucoseAvg(i) = sum((GlucoseVector(1 + (i-1)*sizeeachIter:i*sizeeachIter)));
    OxygenAvg(i) = sum((OxygenVector(1 + (i-1)*sizeeachIter:i*sizeeachIter)));
    ATPAvg(i) = sum((ATPVector(1 + (i-1)*sizeeachIter:i*sizeeachIter)));
    HydrogenAvg(i) = sum((HydrogenVector(1 + (i-1)*sizeeachIter:i*sizeeachIter)));
    %5 and 7 are both same type so add together
    Normal(1,i) = TotalNumber(1, i);
    NonHyplMutant(1,i)=TotalNumber(2,i)+ TotalNumber(3, i)+ TotalNumber(4, i) + TotalNumber(9, i) + TotalNumber(10, i)+TotalNumber(11, i)+TotalNumber(12, i);
    HyplOnly(1,i)= TotalNumber(5, i) + TotalNumber(13, i);
    HyplGly(1,i)= TotalNumber(6, i) + TotalNumber(14, i);
    HyplAR(1,i)= TotalNumber(7, i)+TotalNumber(15, i);
    HyplGlyAR(1,i) = TotalNumber(8, i) + TotalNumber(16, i);
    HyplGlyAR(2,i) = TotalNumber(16, i)/HyplGlyAR(1,i) ;
    
     %Normalise all the values with the total number of cells
    %TotalNumber(:,i) = TotalNumber(:,i)/sum(TotalNumber(:,i));
end

subplot(1,2,1)
iterations = 1:1:Niter;
plot(iterations, Normal, 'b' , iterations, NonHyplMutant, 'c' , iterations, HyplOnly, 'k' ,  iterations, HyplGly, 'g',   iterations, HyplAR, 'r', iterations, HyplGlyAR(1,:), 'm','LineWidth',2);
xlabel('iterations #');
ylabel('number of cells');
title('Cell Types')
legend('Normal Cells', 'non-Hyperplas mutant', 'Hyperplas only', 'Hyperplas-Gly', 'Hyperplas-AR', 'HyplGlyAR');

subplot(1,2,2)
plot(iterations, HyplGlyAR(2,:),'LineWidth',2)
xlabel('iterations #');
ylabel('Fraction')
title('Fraction of Hyperplas-Gly-AR with Mutator');


