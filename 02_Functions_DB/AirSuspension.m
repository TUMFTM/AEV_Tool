function [AirSuspension_selection] = AirSuspension(m_SRT,number_person)
%%
% m_SRT mass: of vehicle in kg
% m_person mass: per person in kg (in Singapore 57.7 kg)
% number_person: number of people in vehicle
% m_luggage: 4 kg per person

m_person = 57.7;
m_luggage = 4;



%% Mass configurations vehicle (unladen, unladen +25% payload, unladen +50% payload, Fully laden, Laden + 25% Payload)
% FAWL: Front Axle Weight Laden
% FAWUL: Front Axle Weight Unladen
% RAWL: Rear Axle Weight Laden
% RAWUL: Rear Axle Weight Unladen

FAWL = (m_SRT + number_person*(m_person + m_luggage))/2;
FAWUL = m_SRT/2;

RAWL = (m_SRT + number_person*(m_person + m_luggage))/2;
RAWUL = m_SRT/2;


% Pay Load (Front: Fpl || Rear: Rpl) starts with Unladen to Fully Laden*n in j steps
j = 0.25;
n = 1.25;

Fpl = struct('Loads_Front', FAWL - FAWUL);
Rpl = struct('Loads_Rear', RAWL - FAWUL);
i=2;
while j<=n
    Fpl(i).Loads_Front = FAWUL + j*Fpl(1).Loads_Front;
    Rpl(i).Loads_Rear = RAWUL + j*Rpl(1).Loads_Rear;
    j=0.25;
    j=j*i;
    i=i+1;
end

% Unsprung mass FVSM Front and RVSM Rear
FUSM = 165; %!!!Hardcoded!!!
RUSM = 165; %!!!Hardcoded!!!

%Sprung mass FSM Front / RSM Rear per wheel
FSM = struct('Sprung_Loads_Front', (Fpl(1).Loads_Front - FUSM)/2);
RSM = struct('Sprung_Loads_Rear', (Rpl(1).Loads_Rear - RUSM)/2);
i=2;
while i<= length(Fpl(1,:))
    FSM(i).Sprung_Loads_Front = ((Fpl(i).Loads_Front - FUSM)/2)*2.20462; % in lbs
    RSM(i).Sprung_Loads_Rear = ((Rpl(i).Loads_Rear - RUSM)/2)*2.20462; % in lbs
    i=i+1;
end

%Index for fully laden +25%
p = length(FSM(1,:));

% Load Data from Database
DBConnection; % calls script for the data base connection

%###Suspension Selection###%
% Selection criteria:
% 1. Load
% 2. Suspension travel min. 180mm (7.07in)
% 3. Isolation effectivness
% 4. Best natural frequency (close to 1Hz)

% Front = Rear; #calculation for fully laden + 25%#

i = 1; % 1. and 2. Loop Load selection @ 40 PSIG, @ 60 PSIG , @ 80 PSIG


while i<=length(AirSpring)
    
    if (AirSpring(i).load_40psig > FSM(p).Sprung_Loads_Front) && ((AirSpring(i).design_height - AirSpring(i).min_height)>= 7.07)
        load_selection(i) = AirSpring(i);
        
    elseif (AirSpring(i).load_60psig > FSM(p).Sprung_Loads_Front) && ((AirSpring(i).design_height - AirSpring(i).min_height)>= 7.07)
        load_selection(i) = AirSpring(i);
        
    elseif (AirSpring(i).load_80psig > FSM(p).Sprung_Loads_Front) && ((AirSpring(i).design_height - AirSpring(i).min_height)>= 7.07)
        load_selection(i) = AirSpring(i);
    end
    
    i = i+1;
end

% Delete empty rows from load_selection
i = 1;

while i<=length(load_selection)
    if isempty(load_selection(i).style_number)
        load_selection(i) = [];
        i = 1;
        
    else i = i+1;
    end
    
end


% Overall Load smallest spring selection

Afields = fieldnames(load_selection);
Acell = struct2cell(load_selection);
sz = size(Acell);


% Convert to a matrix
Acell = reshape(Acell, sz(1), []);      % Px(MxN)

% Make each field a column
Acell = Acell';                         % (MxN)xP

% Sort by field 14 "Max_Diameter"
Acell = sortrows(Acell, 14);

% Put back into original cell array format
Acell = reshape(Acell', sz);

% Convert to Struct
load_selection = cell2struct(Acell, Afields, 1);

% Select first 3 elements
if length(load_selection(1,:))<3
    
else
    load_selection = [load_selection(1),load_selection(2),load_selection(3)];
end

% 3. Isolation effectivness
Iso_eff_selection = load_selection;
i = 1;
while i<=length(load_selection)
    
    Iso_eff_400 = 100 - load_selection(i).isolation_400cpm; % Isolation effectivness @ 400 cpm
    Iso_eff_800 = 100 - load_selection(i).isolation_800cpm; % Isolation effectivness @ 800 cpm
    Iso_eff_1500 = 100 - load_selection(i).isolation_1500cpm; % Isolation effectivness @ 1500 cpm
    
    % Average percentage of vibriation transmission - small value is
    % better -> less vibration transmission. Vehicle related vibrations < 30Hz
    % (1680 cpm)
    
    Iso_eff_average = (Iso_eff_400 + Iso_eff_800 + Iso_eff_1500)/3; % Average Isolation effectivness from 400 cpm to 1500 cpm
    
    Iso_eff_selection(i).Isolation_effectivness_average = Iso_eff_average;
    i = i+1;
end

% Isolation effectivness smallest value selection

Afields = fieldnames(Iso_eff_selection);
Acell = struct2cell(Iso_eff_selection);
sz = size(Acell);


% Convert to a matrix
Acell = reshape(Acell, sz(1), []);      % Px(MxN)

% Make each field a column
Acell = Acell';                         % (MxN)xP

% Sort by field 15 "Isolation_effectivness_average"
Acell = sortrows(Acell, 15);

% Put back into original cell array format
Acell = reshape(Acell', sz);

% Convert to Struct
Iso_eff_selection = cell2struct(Acell, Afields, 1);

% Select first 2 elements
if length(Iso_eff_selection(:))<2
    
else
    Iso_eff_selection = [Iso_eff_selection(1),Iso_eff_selection(2)];
end

% Preselection of lowest possible pressure level
default_load = [];
default_pressure = [];

i = 1;
while i<=length(Iso_eff_selection)
    
    if Iso_eff_selection(i).load_40psig > FSM(p).Sprung_Loads_Front
        
        default_load(i) = Iso_eff_selection(i).load_40psig;
        default_pressure(i) = 40; % 40 PSIG
        
    elseif Iso_eff_selection(i).load_60psig > FSM(p).Sprung_Loads_Front
        
        default_load(i) = Iso_eff_selection(i).load_60psig;
        default_pressure(i) = 60; % 60 PSIG
        
    else
        
        default_load(i) = Iso_eff_selection(i).load_80psig;
        default_pressure(i) = 80; % 80 PSIG
        
    end
    
    i = i+1;
end

% Calculation of the effective area and required pressure

i = 1;
while i<=length(default_load)
    
    Iso_eff_selection(i).effective_area_design_height = default_load(i)/default_pressure(i); % calculation of the effective area at design hight with default values from table
    Iso_eff_selection(i).required_pressure = FSM(p).Sprung_Loads_Front/Iso_eff_selection(i).effective_area_design_height; % calculation of the required pressure
    
    i = i+1;
end

% Calculation of the dynamic spring rate
p_force_table = []; % Vector to find the pressure value to interpolate with


i = 1; % Loop number of springs
j = 1; % Loop force table
K_selection = Iso_eff_selection; % Struct for vertical spring rate selection

while i<=length(Iso_eff_selection)
    
    p_force_table = [abs(20 - Iso_eff_selection(i).required_pressure); abs(40 - Iso_eff_selection(i).required_pressure); abs(60 - Iso_eff_selection(i).required_pressure); abs(80 - Iso_eff_selection(i).required_pressure); abs(100 - Iso_eff_selection(i).required_pressure)];
    [p_force_table,I] = min(p_force_table); % select pressure level in force table
    
    height_Ac = Iso_eff_selection(i).design_height - 0.5; % assembly height 1/2 inch below design height
    height_Ae = Iso_eff_selection(i).design_height + 0.5; % assembly height 1/2 inch above design height
    
    trigger_Ac = 0;
    trigger_Ae = 0;
    
    switch  I % Case 1: 20 PSIG Case 2: 40 PSIG Case 3: 60 PSIG Case 4: 80 PSIG Case 5: 100 PSIG
        
        
        case 1 % pressure level @ 20 PSIG
            
            while j <= length(Iso_eff_selection(i).ForceTable)% check if height_Ac = assembly height
                
                % Height and Volume
                if height_Ac == Iso_eff_selection(i).ForceTable(j).Assembly_Height % Ac loop
                    
                    Ac = Iso_eff_selection(i).ForceTable(j).Pounds_Force_20_PSIG/20; % Effective Area at 1/2 inch below design height
                    trigger_Ac = 1;
                    
                    Vc = Iso_eff_selection(i).ForceTable(j).Volume_100_PSIG; % Vc at 1/2 inch below design height
                end
                
                if height_Ae == Iso_eff_selection(i).ForceTable(j).Assembly_Height % Ae loop
                    
                    Ae = Iso_eff_selection(i).ForceTable(j).Pounds_Force_20_PSIG/20; % Effective Area at 1/2 inch above design height
                    trigger_Ae = 1;
                    
                    Ve = Iso_eff_selection(i).ForceTable(j).Volume_100_PSIG; % Vc at 1/2 inch above design height
                end
                
                a_Ace(j) = Iso_eff_selection(i).ForceTable(j).Assembly_Height; % Assembly Height values
                
                j = j+1;
            end
            
            if trigger_Ac == 0 % if Ac/Ae =~ assembly height --> interpolation
                
                % find limits for height and volume interpolation
                
                b_Ac = height_Ac;
                d_Ac = sort(abs(b_Ac - a_Ace));
                lowest_Ac = find(abs(b_Ac - a_Ace) == d_Ac(1));
                sec_lowest_Ac = find(abs(b_Ac - a_Ace) == d_Ac(2));
                
                % Ac height interpolation
                Ac = (Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Pounds_Force_20_PSIG + ((Iso_eff_selection(i).ForceTable(lowest_Ac(1)).Pounds_Force_20_PSIG - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Pounds_Force_20_PSIG)/(Iso_eff_selection(i).ForceTable(lowest_Ac(1)).Assembly_Height - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Assembly_Height))*(height_Ac - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Assembly_Height))/20;
                
                % Vc volume interpolation
                Vc = (Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Volume_100_PSIG + ((Iso_eff_selection(i).ForceTable(lowest_Ac(1)).Volume_100_PSIG - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Volume_100_PSIG)/(Iso_eff_selection(i).ForceTable(lowest_Ac(1)).Assembly_Height - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Assembly_Height))*(height_Ac - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Assembly_Height));
                
            end
            
            if trigger_Ae == 0 % if Ac/Ae =~ assembly height --> interpolation
                
                % find limits for height interpolation
                
                b_Ae = height_Ae;
                d_Ae = sort(abs(b_Ae - a_Ace));
                lowest_Ae = find(abs(b_Ae - a_Ace) == d_Ae(1));
                sec_lowest_Ae = find(abs(b_Ae - a_Ace) == d_Ae(2));
                
                % Ae height interpolation
                Ae = (Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Pounds_Force_20_PSIG + ((Iso_eff_selection(i).ForceTable(lowest_Ae(1)).Pounds_Force_20_PSIG - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Pounds_Force_20_PSIG)/(Iso_eff_selection(i).ForceTable(lowest_Ae(1)).Assembly_Height - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Assembly_Height))*(height_Ae - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Assembly_Height))/20;
                
                % Ve volume interpolation
                Ve = (Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Volume_100_PSIG + ((Iso_eff_selection(i).ForceTable(lowest_Ae(1)).Volume_100_PSIG - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Volume_100_PSIG)/(Iso_eff_selection(i).ForceTable(lowest_Ae(1)).Assembly_Height - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Assembly_Height))*(height_Ae - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Assembly_Height));
                
            end
            
            
        case 2 % pressure level @ 40 PSIG
            
            while j <= length(Iso_eff_selection(i).ForceTable)% check if height_Ac = assembly height
                
                % Height and Volume
                if height_Ac == Iso_eff_selection(i).ForceTable(j).Assembly_Height % Ac loop
                    
                    Ac = Iso_eff_selection(i).ForceTable(j).Pounds_Force_40_PSIG/40; % Effective Area at 1/2 inch below design height
                    trigger_Ac = 1;
                    
                    Vc = Iso_eff_selection(i).ForceTable(j).Volume_100_PSIG; % Vc at 1/2 inch below design height
                end
                
                if height_Ae == Iso_eff_selection(i).ForceTable(j).Assembly_Height % Ae loop
                    
                    Ae = Iso_eff_selection(i).ForceTable(j).Pounds_Force_40_PSIG/40; % Effective Area at 1/2 inch above design height
                    trigger_Ae = 1;
                    
                    Ve = Iso_eff_selection(i).ForceTable(j).Volume_100_PSIG; % Vc at 1/2 inch above design height
                end
                
                a_Ace(j) = Iso_eff_selection(i).ForceTable(j).Assembly_Height; % Assembly Height values
                
                j = j+1;
            end
            
            if trigger_Ac == 0 % if Ac/Ae =~ assembly height --> interpolation
                
                % find limits for height and volume interpolation
                
                b_Ac = height_Ac;
                d_Ac = sort(abs(b_Ac - a_Ace));
                lowest_Ac = find(abs(b_Ac - a_Ace) == d_Ac(1));
                sec_lowest_Ac = find(abs(b_Ac - a_Ace) == d_Ac(2));
                
                % Ac height interpolation
                Ac = (Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Pounds_Force_40_PSIG + ((Iso_eff_selection(i).ForceTable(lowest_Ac(1)).Pounds_Force_40_PSIG - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Pounds_Force_40_PSIG)/(Iso_eff_selection(i).ForceTable(lowest_Ac(1)).Assembly_Height - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Assembly_Height))*(height_Ac - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Assembly_Height))/40;
                
                % Vc volume interpolation
                Vc = (Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Volume_100_PSIG + ((Iso_eff_selection(i).ForceTable(lowest_Ac(1)).Volume_100_PSIG - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Volume_100_PSIG)/(Iso_eff_selection(i).ForceTable(lowest_Ac(1)).Assembly_Height - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Assembly_Height))*(height_Ac - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Assembly_Height));
                
            end
            
            if trigger_Ae == 0 % if Ac/Ae =~ assembly height --> interpolation
                
                % find limits for height interpolation
                
                b_Ae = height_Ae;
                d_Ae = sort(abs(b_Ae - a_Ace));
                lowest_Ae = find(abs(b_Ae - a_Ace) == d_Ae(1));
                sec_lowest_Ae = find(abs(b_Ae - a_Ace) == d_Ae(2));
                
                % Ae height interpolation
                Ae = (Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Pounds_Force_40_PSIG + ((Iso_eff_selection(i).ForceTable(lowest_Ae(1)).Pounds_Force_40_PSIG - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Pounds_Force_40_PSIG)/(Iso_eff_selection(i).ForceTable(lowest_Ae(1)).Assembly_Height - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Assembly_Height))*(height_Ae - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Assembly_Height))/40;
                
                % Ve volume interpolation
                Ve = (Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Volume_100_PSIG + ((Iso_eff_selection(i).ForceTable(lowest_Ae(1)).Volume_100_PSIG - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Volume_100_PSIG)/(Iso_eff_selection(i).ForceTable(lowest_Ae(1)).Assembly_Height - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Assembly_Height))*(height_Ae - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Assembly_Height));
                
            end
            
        case 3 % pressure level @ 60 PSIG
            
            while j <= length(Iso_eff_selection(i).ForceTable)% check if height_Ac = assembly height
                
                % Height and Volume
                if height_Ac == Iso_eff_selection(i).ForceTable(j).Assembly_Height % Ac loop
                    
                    Ac = Iso_eff_selection(i).ForceTable(j).Pounds_Force_60_PSIG/60; % Effective Area at 1/2 inch below design height
                    trigger_Ac = 1;
                    
                    Vc = Iso_eff_selection(i).ForceTable(j).Volume_100_PSIG; % Vc at 1/2 inch below design height
                end
                
                if height_Ae == Iso_eff_selection(i).ForceTable(j).Assembly_Height % Ae loop
                    
                    Ae = Iso_eff_selection(i).ForceTable(j).Pounds_Force_60_PSIG/60; % Effective Area at 1/2 inch above design height
                    trigger_Ae = 1;
                    
                    Ve = Iso_eff_selection(i).ForceTable(j).Volume_100_PSIG; % Vc at 1/2 inch above design height
                end
                
                a_Ace(j) = Iso_eff_selection(i).ForceTable(j).Assembly_Height; % Assembly Height values
                
                j = j+1;
            end
            
            if trigger_Ac == 0 % if Ac/Ae =~ assembly height --> interpolation
                
                % find limits for height and volume interpolation
                
                b_Ac = height_Ac;
                d_Ac = sort(abs(b_Ac - a_Ace));
                lowest_Ac = find(abs(b_Ac - a_Ace) == d_Ac(1));
                sec_lowest_Ac = find(abs(b_Ac - a_Ace) == d_Ac(2));
                
                % Ac height interpolation
                Ac = (Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Pounds_Force_60_PSIG + ((Iso_eff_selection(i).ForceTable(lowest_Ac(1)).Pounds_Force_60_PSIG - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Pounds_Force_60_PSIG)/(Iso_eff_selection(i).ForceTable(lowest_Ac(1)).Assembly_Height - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Assembly_Height))*(height_Ac - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Assembly_Height))/60;
                
                % Vc volume interpolation
                Vc = (Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Volume_100_PSIG + ((Iso_eff_selection(i).ForceTable(lowest_Ac(1)).Volume_100_PSIG - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Volume_100_PSIG)/(Iso_eff_selection(i).ForceTable(lowest_Ac(1)).Assembly_Height - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Assembly_Height))*(height_Ac - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Assembly_Height));
                
            end
            
            if trigger_Ae == 0 % if Ac/Ae =~ assembly height --> interpolation
                
                % find limits for height interpolation
                
                b_Ae = height_Ae;
                d_Ae = sort(abs(b_Ae - a_Ace));
                lowest_Ae = find(abs(b_Ae - a_Ace) == d_Ae(1));
                sec_lowest_Ae = find(abs(b_Ae - a_Ace) == d_Ae(2));
                
                % Ae height interpolation
                Ae = (Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Pounds_Force_60_PSIG + ((Iso_eff_selection(i).ForceTable(lowest_Ae(1)).Pounds_Force_60_PSIG - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Pounds_Force_60_PSIG)/(Iso_eff_selection(i).ForceTable(lowest_Ae(1)).Assembly_Height - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Assembly_Height))*(height_Ae - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Assembly_Height))/60;
                
                % Ve volume interpolation
                Ve = (Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Volume_100_PSIG + ((Iso_eff_selection(i).ForceTable(lowest_Ae(1)).Volume_100_PSIG - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Volume_100_PSIG)/(Iso_eff_selection(i).ForceTable(lowest_Ae(1)).Assembly_Height - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Assembly_Height))*(height_Ae - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Assembly_Height));
                
            end
            
        case 4 % pressure level @ 80 PSIG
            
            while j <= length(Iso_eff_selection(i).ForceTable)% check if height_Ac = assembly height
                
                % Height and Volume
                if height_Ac == Iso_eff_selection(i).ForceTable(j).Assembly_Height % Ac loop
                    
                    Ac = Iso_eff_selection(i).ForceTable(j).Pounds_Force_80_PSIG/80; % Effective Area at 1/2 inch below design height
                    trigger_Ac = 1;
                    
                    Vc = Iso_eff_selection(i).ForceTable(j).Volume_100_PSIG; % Vc at 1/2 inch below design height
                end
                
                if height_Ae == Iso_eff_selection(i).ForceTable(j).Assembly_Height % Ae loop
                    
                    Ae = Iso_eff_selection(i).ForceTable(j).Pounds_Force_80_PSIG/80; % Effective Area at 1/2 inch above design height
                    trigger_Ae = 1;
                    
                    Ve = Iso_eff_selection(i).ForceTable(j).Volume_100_PSIG; % Vc at 1/2 inch above design height
                end
                
                a_Ace(j) = Iso_eff_selection(i).ForceTable(j).Assembly_Height; % Assembly Height values
                
                j = j+1;
            end
            
            if trigger_Ac == 0 % if Ac/Ae =~ assembly height --> interpolation
                
                % find limits for height and volume interpolation
                
                b_Ac = height_Ac;
                d_Ac = sort(abs(b_Ac - a_Ace));
                lowest_Ac = find(abs(b_Ac - a_Ace) == d_Ac(1));
                sec_lowest_Ac = find(abs(b_Ac - a_Ace) == d_Ac(2));
                
                % Ac height interpolation
                Ac = (Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Pounds_Force_80_PSIG + ((Iso_eff_selection(i).ForceTable(lowest_Ac(1)).Pounds_Force_80_PSIG - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Pounds_Force_80_PSIG)/(Iso_eff_selection(i).ForceTable(lowest_Ac(1)).Assembly_Height - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Assembly_Height))*(height_Ac - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Assembly_Height))/80;
                
                % Vc volume interpolation
                Vc = (Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Volume_100_PSIG + ((Iso_eff_selection(i).ForceTable(lowest_Ac(1)).Volume_100_PSIG - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Volume_100_PSIG)/(Iso_eff_selection(i).ForceTable(lowest_Ac(1)).Assembly_Height - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Assembly_Height))*(height_Ac - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Assembly_Height));
                
            end
            
            if trigger_Ae == 0 % if Ac/Ae =~ assembly height --> interpolation
                
                % find limits for height interpolation
                
                b_Ae = height_Ae;
                d_Ae = sort(abs(b_Ae - a_Ace));
                lowest_Ae = find(abs(b_Ae - a_Ace) == d_Ae(1));
                sec_lowest_Ae = find(abs(b_Ae - a_Ace) == d_Ae(2));
                
                % Ae height interpolation
                Ae = (Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Pounds_Force_80_PSIG + ((Iso_eff_selection(i).ForceTable(lowest_Ae(1)).Pounds_Force_80_PSIG - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Pounds_Force_80_PSIG)/(Iso_eff_selection(i).ForceTable(lowest_Ae(1)).Assembly_Height - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Assembly_Height))*(height_Ae - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Assembly_Height))/80;
                
                % Ve volume interpolation
                Ve = (Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Volume_100_PSIG + ((Iso_eff_selection(i).ForceTable(lowest_Ae(1)).Volume_100_PSIG - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Volume_100_PSIG)/(Iso_eff_selection(i).ForceTable(lowest_Ae(1)).Assembly_Height - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Assembly_Height))*(height_Ae - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Assembly_Height));
                
            end
            
        case 5 % pressure level @ 100 PSIG
            
            while j <= length(Iso_eff_selection(i).ForceTable)% check if height_Ac = assembly height
                
                % Height and Volume
                if height_Ac == Iso_eff_selection(i).ForceTable(j).Assembly_Height % Ac loop
                    
                    Ac = Iso_eff_selection(i).ForceTable(j).Pounds_Force_100_PSIG/100; % Effective Area at 1/2 inch below design height
                    trigger_Ac = 1;
                    
                    Vc = Iso_eff_selection(i).ForceTable(j).Volume_100_PSIG; % Vc at 1/2 inch below design height
                end
                
                if height_Ae == Iso_eff_selection(i).ForceTable(j).Assembly_Height % Ae loop
                    
                    Ae = Iso_eff_selection(i).ForceTable(j).Pounds_Force_100_PSIG/100; % Effective Area at 1/2 inch above design height
                    trigger_Ae = 1;
                    
                    Ve = Iso_eff_selection(i).ForceTable(j).Volume_100_PSIG; % Vc at 1/2 inch above design height
                end
                
                a_Ace(j) = Iso_eff_selection(i).ForceTable(j).Assembly_Height; % Assembly Height values
                
                j = j+1;
            end
            
            if trigger_Ac == 0 % if Ac/Ae =~ assembly height --> interpolation
                
                % find limits for height and volume interpolation
                
                b_Ac = height_Ac;
                d_Ac = sort(abs(b_Ac - a_Ace));
                lowest_Ac = find(abs(b_Ac - a_Ace) == d_Ac(1));
                sec_lowest_Ac = find(abs(b_Ac - a_Ace) == d_Ac(2));
                
                % Ac height interpolation
                Ac = (Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Pounds_Force_100_PSIG + ((Iso_eff_selection(i).ForceTable(lowest_Ac(1)).Pounds_Force_100_PSIG - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Pounds_Force_100_PSIG)/(Iso_eff_selection(i).ForceTable(lowest_Ac(1)).Assembly_Height - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Assembly_Height))*(height_Ac - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Assembly_Height))/100;
                
                % Vc volume interpolation
                Vc = (Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Volume_100_PSIG + ((Iso_eff_selection(i).ForceTable(lowest_Ac(1)).Volume_100_PSIG - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Volume_100_PSIG)/(Iso_eff_selection(i).ForceTable(lowest_Ac(1)).Assembly_Height - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Assembly_Height))*(height_Ac - Iso_eff_selection(i).ForceTable(sec_lowest_Ac(1)).Assembly_Height));
                
            end
            
            if trigger_Ae == 0 % if Ac/Ae =~ assembly height --> interpolation
                
                % find limits for height interpolation
                
                b_Ae = height_Ae;
                d_Ae = sort(abs(b_Ae - a_Ace));
                lowest_Ae = find(abs(b_Ae - a_Ace) == d_Ae(1));
                sec_lowest_Ae = find(abs(b_Ae - a_Ace) == d_Ae(2));
                
                % Ae height interpolation
                Ae = (Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Pounds_Force_100_PSIG + ((Iso_eff_selection(i).ForceTable(lowest_Ae(1)).Pounds_Force_100_PSIG - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Pounds_Force_100_PSIG)/(Iso_eff_selection(i).ForceTable(lowest_Ae(1)).Assembly_Height - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Assembly_Height))*(height_Ae - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Assembly_Height))/100;
                
                % Ve volume interpolation
                Ve = (Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Volume_100_PSIG + ((Iso_eff_selection(i).ForceTable(lowest_Ae(1)).Volume_100_PSIG - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Volume_100_PSIG)/(Iso_eff_selection(i).ForceTable(lowest_Ae(1)).Assembly_Height - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Assembly_Height))*(height_Ae - Iso_eff_selection(i).ForceTable(sec_lowest_Ae(1)).Assembly_Height));
                
            end
            
    end
    
    % Calculation of K: Vertical Spring rate in lbs/inch
    V1 = Iso_eff_selection(i).volume_100psig; % Internal Volume at design height in in^3
    
    
    K_selection(i).Vertical_Spring_Rate = ((K_selection(i).required_pressure + 14.7)*(Ac*((V1/Vc)^1.38) - Ae*((V1/Ve)^1.38)) - 14.7*(Ac - Ae)); % in lbs/inch
    
    K_selection(i).Natural_frequency = (188*sqrt(K_selection(i).Vertical_Spring_Rate/FSM(p).Sprung_Loads_Front))*0.01666666666; % in Hz
    K_selection(i).Diff_to_1Hz = abs(1 - K_selection(i).Natural_frequency);
    
    
    j = 1;
    i = i+1;
end

AirSuspension_selection = K_selection;


% Vertical Spring Rate smallest value selection

Afields = fieldnames(AirSuspension_selection);
Acell = struct2cell(AirSuspension_selection);
sz = size(Acell);


% Convert to a matrix
Acell = reshape(Acell, sz(1), []);      % Px(MxN)

% Make each field a column
Acell = Acell';                         % (MxN)xP

% Sort by field 15 "Differnce to 1Hz"
Acell = sortrows(Acell, 20);

% Put back into original cell array format
Acell = reshape(Acell', sz);

% Convert to Struct
Iso_eff_selection = cell2struct(Acell, Afields, 1);

% Select closest frequency to 1 Hz
AirSuspension_selection = [AirSuspension_selection(1)];
%%
%%

end