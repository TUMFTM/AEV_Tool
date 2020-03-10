%#####MAIN function for Selection and Sizing####%
%######################################%
%######################################%

function [AirSuspension_selection,Tyre_selection,Brake_selection,l_overall,w_overall,h_overall,wb,vehicle_mass,number_person] = Chassis(l_overall,w_overall,h_overall,wb,vehicle_mass,number_person)

global path_base

m_SRT = vehicle_mass; % in kg
vehicle_length = l_overall/1000;% in m
vehicle_width = w_overall/1000; % in m
wheelbase = wb/1000; % in m

% AirSuspension selection
[AirSuspension_selection] = AirSuspension(m_SRT,number_person);

% Wheel selection
[Tyre_selection,FSM,RSM,FAWL,RAWL,p] = Wheel(m_SRT,number_person);

% Brake selection
[Brake_selection] = Brake(Tyre_selection,wheelbase,FAWL,RAWL,FSM,RSM,p);

check = 'db'; % check if this function was executed
save([ path_base '10_Results\Components\Selection.mat'],'AirSuspension_selection','Brake_selection','Tyre_selection','vehicle_length','vehicle_width','wheelbase','FAWL','h_overall','check','l_overall','w_overall','h_overall','wb');

end

