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
   
%run simulation, number of iterations, visualisation option. n=every
%iterations, 0=no vis. 

function [ y ] = RunSimulation(Niter,SeedMutation,VisEveryNIter,SaveEveryNIter,params,savename)

%Initialise the matrices
[State,ATP,Glucose,Oxygen,Hydrogen] = InitialiseProblem(params);

if(SeedMutation==1)
    State(params.height,floor(params.width/2))=5;
end

if(VisEveryNIter~=0)
    screen_size = get(0, 'ScreenSize');
    h = figure('Position', [0 0 screen_size(3) screen_size(4)]);
    textHandle = text(0,0,'');
end

%Preallocate space for output
StateOutput= State;
GlucoseOutput= Glucose;
OxygenOutput= Oxygen;
HydrogenOutput= Hydrogen;
ATPOutput= ATP;

for i=1:Niter  

    
    
    %Start each iteration with a state update : cells can die, be quiescent
    %or divide with a probability of mutating
    State = StateUpdate(params, State, ATP, Oxygen, Hydrogen, Glucose);
    %Steady state diffusion of diffusive species
    Glucose = Diffusion(params,State,0);
    Oxygen = Diffusion(params,State,1);
    Hydrogen = Protons(params,State,Glucose,Oxygen);
    %ATP produced by live cells
    ATP = ATPUpdate(params, Glucose, Oxygen, State);
   
    if(mod(i,SaveEveryNIter)==0)
        StateOutput = [StateOutput; State];
        GlucoseOutput = [GlucoseOutput; Glucose];
        OxygenOutput = [OxygenOutput;Oxygen];
        HydrogenOutput = [HydrogenOutput;Hydrogen];
        ATPOutput = [ATPOutput;ATP];
    
    end
    
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
    
    if(mod(i,VisEveryNIter)==0)
    delete(textHandle);
    textHandle = Visualisation(params,i,textHandle,State,ATP,Glucose,Oxygen,Hydrogen);
    set(h,'Renderer','zbuffer') %Fix windows 7 transparency problem.
    M(i)=getframe(gcf); %leaving gcf out crops the frame
    end
    %StateOutput=StateOutput';
    
    save((savename),'StateOutput','GlucoseOutput','ATPOutput','OxygenOutput','HydrogenOutput','Niter')
    
end

