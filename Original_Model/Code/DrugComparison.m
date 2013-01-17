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


function [T_drug] = DrugComparison(desired_alpha, number_of_runs, iterations_per_run, image_every_iteration)
%RUNS 2 SIMULATIONS TO COMPARE THE EFFECT OF A DRUG: Simulations run and
%average over number_of_runs for iterations_per_run iterations for each.
%User can select a value for when images should be shown -
%image_every_iteration.
%Will simulate empty drug model and a drug with alpha value desired_alpha,
%and average results then plot the total cell concentrations


%Initialising
T_norm = zeros(8, iterations_per_run+1);
T_drug = zeros(8, iterations_per_run+1);


for(i = 1:1:number_of_runs)
%Get default value for params struct
setParams;
%save the normal simulation values to T_norm
T_norm = T_norm + RunSimulation(iterations_per_run,image_every_iteration,  0, 0, params);

%modify alpha
params.alpha = desired_alpha;
%save to T_drug
T_drug = T_drug + RunSimulation(iterations_per_run,image_every_iteration, 0, 1, params);

end

%Average the resulting matrices
T_norm = T_norm/number_of_runs;
T_drug = T_drug/number_of_runs;


%Plot them side by side
iterations = 1:1:iterations_per_run+1;
subplot(1,2,1);
plot(iterations, T_norm(1,:),'b' , iterations, T_norm(5,:), 'c', iterations, T_norm(6,:), 'y' , iterations, T_norm(8,:), 'r', 'LineWidth', 2);
subplot(1,2,2);
plot(iterations, T_drug(1,:),'b' , iterations, T_drug(5,:), 'c', iterations, T_drug(6,:), 'y' , iterations, T_drug(8,:), 'r','LineWidth', 2);

xlabel('Iterations')
ylabel('Total Cell Count')
legend('Normal', 'Hyp','Hyp-Gly','Hyp-Gly-AR');
graph_text = num2str(desired_alpha);
title(graph_text);

end




