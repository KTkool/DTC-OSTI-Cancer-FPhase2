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
   
function [ T_s ] = RunSimulation(Niter,VisEveryNIter, SeedMutation,drug_opt, params)
%Function which runs the simulation, given number of iterations,
%visualisation output every # of iterations, seeding a mutation option,
%whether drugs are used


%Initialise the matrices

[State,ATP,Glucose,Oxygen,Hydrogen] = InitialiseProblem(params);

%If a drug option has been selected then initialise the matrix, otherwise
%leave it with zeros everywhere
if(drug_opt ==1)
     Drug = InitialiseDrug(params);
else
    Drug = zeros(params.height, params.width);
end


%If seed a mutation with 1, place a mutant at the bottom center of the
%simulation initially.
if(SeedMutation==1)
    params.pa=0;
    State(params.height,floor(params.width/2))=5;
end


%If this is selected (>0) then initialises the output figure.
if(VisEveryNIter~=0)
    screen_size = get(0, 'ScreenSize');
     h = figure('Position', [0 0 screen_size(3) screen_size(4)]);
   textHandle = text(0,0,'');
end


T_s = zeros(8, 1);

for i=1:Niter
   
    
    %Start each iteration with a state update : cells can die, be quiescent
    %or divide with a probability of mutating
    
    %Instead of simply plotting State we display only some important properties
    %of the cells:
    %Normal ; Hyperplastic ; Hyperlastic-Glycolytic ; And
    %Hyperlastic-Glycolytic-Acid Resistant
    %Normal : 1                 blue
    %Hyperplastic : 5 ; 7       cyan
    %Hyperplastic-Gly : 6       yellow
    %Hyperplastic-Gly-AR : 8    orange
    %Anything else : 2 ; 3; 4   brown
    % empty : 0                 dark blue
    
    State = StateUpdate(params, State, ATP, Oxygen, Hydrogen, Glucose);
    %puts output from StatePlot (gives number of cells of each type) into an array
    T = StatePlot(State);
    %Adds this to an iterative array each time
    T_s = [T_s T];
   
    %delete T to save memory
    clear T; 
    
    %Steady state diffusion of diffusive species
    Glucose = Diffusion(params,State,0);
    
    
    Oxygen = Diffusion(params,State,1);
    
    
    Hydrogen = Protons(params,State,Glucose,Oxygen);
    
    
    %ATP produced by live cells
    ATP = ATPUpdate(params, Glucose, Oxygen, Drug, State);
    
   
    %if selected, shows simulation every VisEveryNIter iterations.
    if(mod(i,VisEveryNIter)==0)
    delete(textHandle);
    textHandle = Visualisation(params,i,textHandle,State,ATP,Glucose,Oxygen,Drug);
    set(h,'Renderer','zbuffer') %Fix windows 7 transparency problem.
    M(i)=getframe(gcf); %leaving gcf out crops the frame
    end
    
    %save((savename),'StateOutput','GlucoseOutput','ATPOutput','OxygenOutput','HydrogenOutput','Niter');
    
end

