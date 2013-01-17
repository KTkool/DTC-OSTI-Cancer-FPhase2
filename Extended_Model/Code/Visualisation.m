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
   
function textHandle = Visualisation(params,iterations,textHandle,State,ATP,Glucose,Oxygen,Hydrogen)
%% Creates a subplot to visualise the state of the different variables.
% Display the State with colors.
% Display the other continuous variables using heatmaps

%Instead of simply plotting State we display only some important properties
%of the cells:
%Normal ; Hyperplastic ; Hyperlastic-Glycolytic ; and
%Hyperlastic-Glycolytic-Acid Resistant

%Empty : 0                  dark blue
%Normal : 1                 blue
%Hyperplastic : 5 ; 7       cyan
%Hyperplastic-Gly : 6       yellow
%Hyperplastic-Gly-AR : 8    orange
%Anything else : 2 ; 3; 4   brown


                                                % see toDisplay below
epty = (State == 0);                            
normal = logical((State == 1));  
nonhypl = logical((State==2)+(State==3)+(State==4)+(State==9)+(State==10)+(State==11)+(State==12));
hyplonly = logical((State == 5) + (State == 13));    
hyplgly = logical((State == 6)+(State == 14));              
hyplar = logical((State == 7)+(State == 15));
hyplglyar = logical((State == 8)+(State == 16));  

toDisplay = 5*ones(params.height, params.width);
toDisplay(epty) = 0;
toDisplay(normal) = 1;
toDisplay(nonhypl) = 2;
toDisplay(hyplonly) = 3;
toDisplay(hyplgly) = 4;
toDisplay(hyplar) = 5;
toDisplay(hyplglyar) = 6;

subplot(3,2,1);
imagesc(toDisplay,[0 6]);
title('State Matrix');
colorbar;

%Draw the legend and #iterations
pos1 = 0.0125 + 0.05;
inc = 0.125 ;
subplot(3,2,2,'Color','none');
axis off;
rectangle('Position',[0,-0.2,1,1.2]);

s = sprintf('Iteration # %d',iterations);

text(0.1,pos1 + 0.05 - inc,'Empty')
h = rectangle('Position',[0.02,pos1-inc,0.05,0.1]);
set(h,'facecolor',  [0,0.1797,0.7188]);

text(0.1,pos1 + 0.05,'Normal')
h = rectangle('Position',[0.02,pos1,0.05,0.1]);
set(h,'facecolor', [0    0.2383    0.9570]);

text(0.1,pos1 + 0.05 + inc,'Non-Hyperplastic Mutated')
h = rectangle('Position',[0.02,pos1+inc,0.05,0.1]);
set(h,'facecolor', [0.4375    0.8555    0.9961]);

text(0.1,pos1 + 0.05 + inc*2,'Hyperplastic')
h = rectangle('Position',[0.02,pos1 + 2*inc,0.05,0.1]);
set(h,'facecolor', [ 0.5781    0.9961    0.4375]);

text(0.1,pos1 + 0.05 + inc*3,'Hyperplastic - Glycolytic')
h = rectangle('Position',[0.02,pos1 + inc*3,0.05,0.1]);
set(h,'facecolor', [0.9961    0.5977         0]);

text(0.1,pos1 + 0.05 +inc*4,'Hyperplastic - Acid Resistant') 
h = rectangle('Position',[0.02,pos1 + inc*4,0.05,0.1]);
set(h,'facecolor', [0.9961    0.1016         0]);

text(0.1,pos1 + 0.05 + inc*5,'Hyperplastic - Glycolytic - Acid Resistant')
h = rectangle('Position',[0.02,pos1 + inc*5,0.05,0.1]);
set(h,'facecolor', [ 0.6367         0         0]);


%Titles for all other subplots
textHandle = text(0.1,pos1 + 0.05 + inc*6,s);

subplot(3,2,3);
imagesc(ATP, [0 2]);
title('ATP Matrix');
colorbar;

subplot(3,2,4);
imagesc(Glucose);
title('Glucose Matrix');
colorbar;
caxis([0.5,1]);

subplot(3,2,5);
imagesc(Oxygen);
title('Oxygen Matrix');
colorbar;
caxis([0.1,1]);

plot_hydrogen= log10(Hydrogen);

subplot(3,2,6);
imagesc(plot_hydrogen);
title('Hydrogen Matrix');
colorbar;
caxis([0,7]);

