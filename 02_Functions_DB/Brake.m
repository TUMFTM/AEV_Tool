function [Brake_selection] = Brake(Tyre_selection,wheelbase,FAWL,RAWL,FSM,RSM,p)

% Tyre_selection from function Wheel.m
% vehicle length in meters
% FAWL/RAWL mass per axle in kg of SRT module including passangers and luggage (for more
% information see Wheel.m)
% FSM load front per wheel
% RSM load rear per wheel
% p Index for fully laden + 25%
% 50:50 axle load

% Required brake and brake torque
xpp = 5; % min deccelaration in m/s2;
cgh = 1; % Center of gravity height in m

Fb = struct('max_brake_force_front',[],'max_brake_force_rear',[]); % max brake force
Mb = struct('max_torque_front',[],'max_torque_rear',[]); % max brake torque

Fb.max_brake_front = 9.81*(FAWL)*(xpp/9.81)+(FAWL+RAWL)*xpp*(cgh/wheelbase)*(xpp/9.81); % in N
Fb.max_brake_rear = 9.81*(RAWL)*(xpp/9.81)+(FAWL+RAWL)*xpp*(cgh/wheelbase)*(xpp/9.81); % in N

Mb = Fb.max_brake_front*((Tyre_selection.outside_diameter/2)/1000); % in Nm
Mb = Fb.max_brake_rear*((Tyre_selection.outside_diameter/2)/1000); % in Nm

% Possible brake torque
% Load Data from Database
DBConnection; % calls script for the data base connection


% Brake selection
Brake_selection = [];
i=1;
while i<length(Brakes)
    if Brakes(i).braking_torque > 0 && (Brakes(i).rim_size == Tyre_selection.rim_size) % Brake selection if max. torque is available
        Brake_selection = Brakes(i);
    end
    
    i = i+1;
end


% Delete empty rows from Brake_selection
i = 1;

while i<=length(Brake_selection)
    if isempty(Brake_selection(i).brake_id)
        Brake_selection(i) = [];
        i = 1;
        
    else i = i+1;
    end
    
end

% Smallest barke torque selection

Afields = fieldnames(Brake_selection);
Acell = struct2cell(Brake_selection);
sz = size(Acell);


% Convert to a matrix
Acell = reshape(Acell, sz(1), []);      % Px(MxN)

% Make each field a column
Acell = Acell';                         % (MxN)xP

% Sort by field 3 "braking_torque"
Acell = sortrows(Acell, 3);

% Put back into original cell array format
Acell = reshape(Acell', sz);

% Convert to Struct
Brake_selection = cell2struct(Acell, Afields, 1);

% Select brake with smallest torque
Brake_selection = Brake_selection(1);



% Alternativ calculation if max torque of brake is unkown
if isempty(Brake_selection)
    
    eta = 0.95; % efficiency of the brake system
    p = 8; % pneumatic pressure of the brake system in N/mm2
    mu = 0.4; % friction coefficient brake disc / brake pads
    
    j = 1;
    Fsp = []; % clamping force of the caliper
    Fu = []; % circumferential force
    
    while j <= length(Brakes)
        Fsp(j) = eta*p*Brakes(j).pad_surface_area*100; % pad_surface_area in cm2 -> mm2
        Fu(j) = 2*mu*Fsp(j);
        
        % inner diameter of brake disc must be in the database!
        M(j) = Fu(j)*(2/3)*((((Brakes(j).disc_diameter)^3) - ((Brakes(j).disc_inner_diameter)^3))/(((Brakes(j).disc_diameter)^2) - ((Brakes(j).disc_inner_diameter)^2))); % calculated brake torque
        
        if M > Mb % M calculated brake torque > Mb required torque
            Brake_selection(j) = Brakes(j);
        end
        j = j+1;
    end
    
    % Brake_selection with rim size and brake torque
    % Smallest rim size
    
    Afields = fieldnames(Brake_selection);
    Acell = struct2cell(Brake_selection);
    sz = size(Acell);
    
    
    % Convert to a matrix
    Acell = reshape(Acell, sz(1), []);      % Px(MxN)
    
    % Make each field a column
    Acell = Acell';                         % (MxN)xP
    
    % Sort by field 3 "rim_size"
    Acell = sortrows(Acell, 9);
    
    % Put back into original cell array format
    Acell = reshape(Acell', sz);
    
    % Convert to Struct
    Brake_selection = cell2struct(Acell, Afields, 1);
    
    
    i = 1;
    
    while i <= length(Brake_selection)
        
        if Brake_selection(i).rim_size == Tyre_selection(i).rim_size
            Brake_selection = Brake_selection(i);
            break
        end
    end
    
end

end