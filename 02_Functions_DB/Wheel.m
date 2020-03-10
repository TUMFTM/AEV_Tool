function [Tyre_selection,FSM,RSM,FAWL,RAWL,p] = Wheel(m_SRT,number_person)
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
% in kg

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
FUSM = 100; %!!!Hardcoded!!!
RUSM = 100; %!!!Hardcoded!!!

%Sprung mass FSM Front / RSM Rear per wheel
FSM = struct('Sprung_Loads_Front', (Fpl(1).Loads_Front - FUSM)/2);
RSM = struct('Sprung_Loads_Rear', (Rpl(1).Loads_Rear - RUSM)/2);
i=2;
while i<= length(Fpl(1,:))
    FSM(i).Sprung_Loads_Front = ((Fpl(i).Loads_Front - FUSM)/2); % in kg
    RSM(i).Sprung_Loads_Rear = ((Rpl(i).Loads_Rear - RUSM)/2); % in kg
    i=i+1;
end

%Index for fully laden +25%
p = length(FSM(1,:));

%% Tyre Selection
% Load Data from Database
DBConnection; % calls script for the data base connection
% 50:50 axle load!

i =1;
while i<=length(Tyre)
    
    if (Tyre(i).load_min_P > FSM(p).Sprung_Loads_Front)
        load_selection(i) = Tyre(i);
    end
    
    i = i+1;
end

% Delete empty rows from load_selection
i = 1;

while i<=length(load_selection)
    if isempty(load_selection(i).tyre_id)
        load_selection(i) = [];
        i = 1;
        
    else i = i+1;
    end
    
end

% Smallest Rim Size selection

Afields = fieldnames(load_selection);
Acell = struct2cell(load_selection);
sz = size(Acell);


% Convert to a matrix
Acell = reshape(Acell, sz(1), []);      % Px(MxN)

% Make each field a column
Acell = Acell';                         % (MxN)xP

% Sort by field 5 "rim_size"
Acell = sortrows(Acell, 5);

% Put back into original cell array format
Acell = reshape(Acell', sz);

% Convert to Struct
load_selection = cell2struct(Acell, Afields, 1);

% Select all Tyres with smallest Rim Size

% Delete rows with bigger Tyre Sizes from load_selection
min_rim_size = load_selection(1).rim_size;
i = 2;

while i<=length(load_selection)
    if load_selection(i).rim_size > min_rim_size
        load_selection(i) = [];
        i = 1;
    end
    i = i+1;
end

% Smallest Tyre Width Selection
Afields = fieldnames(load_selection);
Acell = struct2cell(load_selection);
sz = size(Acell);


% Convert to a matrix
Acell = reshape(Acell, sz(1), []);      % Px(MxN)

% Make each field a column
Acell = Acell';                         % (MxN)xP

% Sort by field 5 "width"
Acell = sortrows(Acell, 2);

% Put back into original cell array format
Acell = reshape(Acell', sz);

% Convert to Struct
load_selection = cell2struct(Acell, Afields, 1);

Tyre_selection = load_selection(1);

end