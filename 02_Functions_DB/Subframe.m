
global path_base

% Load Parametric Data
load Parametric_data;
% Load Selection
load('Selection','AirSuspension_selection','Brake_selection','Tyre_selection','vehicle_length','vehicle_width','wheelbase','FAWL');

%% Set Parameters for MBS simulation
%Wheel
wheel.tire.innerradius = ((Tyre_selection.outside_diameter/2)-Tyre_selection.aspect_ratio)/10; % in cm
wheel.tire.outerradius = (Tyre_selection.outside_diameter/2)/10; % in cm
wheel.tire.width = (Tyre_selection.width)/10; % in cm
wheel.tire.density = 910; % From CATIA V5

% Hub
wheel.hub.outerradius = (Tyre_selection.rim_size*2.54)/2; % in cm
wheel.hub.density = 7860; % From CATIA V5

% Brake and Shaft
wheel.disc.radius = (Brake_selection.disc_diameter/2)/10; % in cm
wheel.disc.thickness = (Brake_selection.disc_thickness)/10; % in cm

% Chassis
% Upper Wishbone
dwb.uwb.longlength = (AirSuspension_selection.max_diameter/2)*2.54 + 5; % in cm
dwb.uwb.shortlength = dwb.uwb.longlength - 10;

% Lower Wishbone
dwb.lwb.longlength = dwb.uwb.longlength + 11;
dwb.lwb.shortlength = dwb.uwb.longlength;

%Frame
dwb.chassis.frame.longlength = vehicle_width*100 - (AirSuspension_selection.max_diameter*2.54 + 5 + (Tyre_selection.width/10))*2; % in cm
dwb.chassis.frame.shortlength = dwb.chassis.frame.longlength-25; % in cm
dwb.chassis.frame.density = 2710; % From CATIA V5

%Damper and Spring
dwb.lwb.damperbracket.offset = dwb.lwb.longlength - 25;
dwb.springdamp.k = AirSuspension_selection.Vertical_Spring_Rate*175.126835*1.5; % N/m
dwb.springdamp.b = 3000; % Ns/m

%Steering
dwb.chassis.steering.rack.rod.length = dwb.chassis.frame.longlength+20+(dwb.lwb.longlength - dwb_ov.lwb.longlength)*2;

% Update Parametric Data
save([path_base '02_Functions_DB\01_Suspension_Model\Parametric_data.mat','color','density','dwb','dwb_ov','mp','platform','pr','wheel']);


% Load Data for Simulink model
% filename = ([path_base '10_Results\Simulink\Link_forces.mat']);
VehicleDynamicsInitialization; % Preload Function

%Start Simulink
warning ('off','all');
options = simset('SrcWorkspace','current');
sim('VehicleDynamics3D',[],options);


%Load Simulink results
load('Link_forces','l_force');

% Calculate Bendeing Stress of links
% Cut off start squence
link_force_z = getsampleusingtime(l_force,10,30);
M = abs(dwb.lwb.longlength*10*max(l_force.data)); % in Nmm

d = 1; % inner diameter of a link in mm
D = d*1.5; % outer diameter of a link in mm
sigma_bw = 540; % N/mm^2
W = (pi/32)*((D^4-d^4)/D); % Moment of resistance in mm^3
sigma = M/W; % Bending stress in N/mm^2

% find min diameter of link
while sigma > sigma_bw
    d = d+1;
    D = d*1.5; % outer diameter of a link in mm
    W = (pi/32)*((D^4-d^4)/D); % Moment of resistance in mm^3
    sigma = M/W; % Bending stress in N/mm^2
end

% Parametric Data for CAD model
t_aarm = (D-d)/2;
d_aarm = D/2;
mat_aarm = 'Steel';

save([path_base '10_Results\Components\Link_selection.mat'],'t_aarm','d_aarm','mat_aarm');

