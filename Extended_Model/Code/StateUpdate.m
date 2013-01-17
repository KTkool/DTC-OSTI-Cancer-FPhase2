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
   
function State = StateUpdate(params, State, ATP, Oxygen, Hydrogen, Glucose)
    
    % death from low ATP
    State(ATP < params.a0) = 0;
    
    % death from low pH
    u = rand(params.height, params.width);
    State( Pdeath(params,State,Hydrogen) > u ) = 0;
    
    % Death from non-hyperplasticity
    % FIXME: Does not work for some reason :( WHY?!!
    % Mask returns locations of non-hyperplastic cells but ...
    mask = logical((State == 1) + (State == 2) + (State == 3) + (State == 4)+(State == 9) + (State == 10) + (State == 11) + (State == 12));
    % the following line does not kill them, to fix this we added
    % lines 74 - 86 below.
    State(mask(1:params.height -1,:)) = 0;
    
    % Establish division or quiescence
    liveCells = (State ~= 0);
    mask = liveCells .* DivideStatus(params, ATP); % find live cells that will divide
	[rows, cols] = find(mask);
    % wrap around the y axis
    v = [ params.width 1:params.width 1 ];
    function [ y ] = yW(n)
      y = v(n + 1);
    end
    
    % update - reproduction step (randomly select rows and columns)
    IX = randperm(length(rows));
    rows = rows(IX);
    cols = cols(IX);
    
    for k = 1:length(rows)
            x = rows(k);
            y = cols(k);
            
            % unnecessary initialisations?
            tmpOq2 = zeros(3,1);
            isPositionAvailable = zeros(3,1);
            positionCell = {[], [], []};
            
            % look for oxygen concentrations surrounding cell
            % bottom row
            if ( x == params.height )
		% look for empty space
                isPositionAvailable = [ (State(x-1, y)==0),  (State(x, yW(y-1))==0),  (State(x, yW(y+1))==0) ];
		% this is needed to place daughter cells in space with highest available oxygen
                tmpO2 = [ Oxygen(x-1, y)  Oxygen(x, yW(y-1))  Oxygen(x, yW(y+1)) ];
                positionCell = { [x-1,y], [x, yW(y-1)], [x, yW(y+1)] };
            % top row
            elseif ( x == 1 )
                isPositionAvailable = [ (State(x, yW(y-1))==0),  (State(x, yW(y+1))==0),  (State(x+1, y)==0) ];
                tmpO2 = [  Oxygen(x, yW(y-1))  Oxygen(x, yW(y+1))  Oxygen(x+1, y) ];
                positionCell = { [x, yW(y-1)], [x, yW(y+1)], [x+1, y] };
            % all others
            else    
                isPositionAvailable = [ (State(x-1, y)==0),  (State(x, yW(y-1))==0),  (State(x, yW(y+1))==0),  (State(x+1, y)==0) ];
                tmpO2 = [ Oxygen(x-1, y)  Oxygen(x, yW(y-1))  Oxygen(x, yW(y+1))  Oxygen(x+1, y) ];
                positionCell = { [x-1,y], [x, yW(y-1)], [x, yW(y+1)], [x+1, y] };
            end

            availables = find(isPositionAvailable);
            if (isempty(availables))
                continue;
            end;
            
            % index for the max oxygen of available neighbours. chooses one
            % at random if there are multiple.
            maxO2 = max(tmpO2(availables));  
            indices = find(tmpO2(availables) == maxO2);
            maxO2Position = indices(randsample(length(indices),1));
            a = positionCell{availables(maxO2Position)};
            
            % cf. comment line 24,
            % fix lack of death from non-hyperplasticity above basement
            % membrane by not allowing non-hyperplastic cells to divide
            m = Mutate(params,State(x,y));
            if ((a(1) < params.height) && ((m == 1) || (m == 2) || (m == 3) || (m ==4)||(m == 9) || (m == 10) || (m == 11) || (m ==12)))
                State(a(1),a(2)) = 0;
            else
                State(a(1),a(2)) = Mutate(params, State(x,y)); % update 1st daughter cell  
            end;
            
            m = Mutate(params, State(x,y));
            if ((x < params.height) && ((m == 1) || (m == 2) || (m == 3) || (m ==4) || (m == 9) || (m == 10) || (m == 11) || (m ==12)))
                State(x,y) = 0;
            else
                State(x,y) = Mutate(params, State(x,y));  % update 2nd daughter cell  
            end;
     
    end

    
    
    
    
    
end
