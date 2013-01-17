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

function [] = RunTwoParameterSets(Variable)
%Carries out simulation, movie making and then play back side by side for two parameter sets. Input string specifies the variable to plot, the two parameter sets to use are initialised by the scripts setParams and setNewParams.

%Initialse the parameters to default values and save output matrices
setParams;
RunSimulation(100,1,0,1,params,'output1.mat');

%Make and save movie
load('output1.mat')
if(strcmpi(Variable,'State')==1)
    MakeMovie(StateOutput,Variable,params,'MovieNormal.avi');
elseif((strcmpi(Variable,'ATP')==1))
    MakeMovie(ATPOutput,Variable,params,'MovieNormal.avi');
elseif((strcmpi(Variable,'Glucose')==1))
    MakeMovie(GlucoseOutput,Variable,params,'MovieNormal.avi')
elseif((strcmpi(Variable,'Oxygen')==1))
    MakeMovie(OxygenOutput,Variable,params,'MovieNormal.avi')
elseif((strcmpi(Variable,'Hydrogen')==1))
    MakeMovie(HydrogenOutput,Variable,params,'MovieNormal.avi')
end

%Initialse the parameters to alternative values and save output matrices
setNewParams;
RunSimulation(100,1,0,1,params,'output2.mat');
load('output2.mat')
if(strcmpi(Variable,'State')==1)
    MakeMovie(StateOutput,Variable,params,'MovieNew.avi');
elseif((strcmpi(Variable,'ATP')==1))
    MakeMovie(ATPOutput,Variable,params,'MovieNew.avi');
elseif((strcmpi(Variable,'Glucose')==1))
    MakeMovie(GlucoseOutput,Variable,params,'MovieNew.avi')
elseif((strcmpi(Variable,'Oxygen')==1))
    MakeMovie(OxygenOutput,Variable,params,'MovieNew.avi')
elseif((strcmpi(Variable,'Hydrogen')==1))
    MakeMovie(HydrogenOutput,Variable,params,'MovieNew.avi')
end

Play2Movies('MovieNormal.avi','MovieNew.avi');