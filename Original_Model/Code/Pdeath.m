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
   
function [ y ] = Pdeath(params,State,Hydrogen)
    % create a matrix of 0s and 1s determining cell death from low pH
    % (acidic) -- equation 3 in Smallbone et al, 2007.
        
    p = zeros(params.height, params.width);
    
    % if cells are not acid-resistant and proton concentration is below pH threshold for cells without
    % acid-resistance (hn), calculate probability of survival for these cells.
    mask = logical((Hydrogen < params.hn)  .*  (( State == 1) + (State == 2) + (State == 5) + (State == 6))); 
    p(mask) = Hydrogen(mask) / params.hn;
    
    %if [hydrogen] higher than threshold (hn), kill cells with certainty
    mask = logical((Hydrogen >= params.hn)  .*  (( State == 1) + (State == 2) + (State == 5) + (State == 6))); 
    p(mask) = 1;
    
    % if cells are acid-resistant and proton concentration is below pH threshold for cells with
    % acid-resistance (ht), calculate probability of survival for these cells.
    mask = logical((Hydrogen < params.ht)  .*  (( State == 3) + (State == 4) + (State == 7) + (State == 8)));
    p( mask ) = Hydrogen(mask) / params.ht;
    
    %if [hydrogen] higher than threshold (ht), kill cells with certainty
    mask = logical((Hydrogen >= params.ht)  .*  (( State == 3) + (State == 4) + (State == 7) + (State == 8)));
    p( mask ) = 1;
    
    y = p;
    
end
