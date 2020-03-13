% Update parameter values in SRT_2030.CATProduct
function UpdateParameters_DB(AirSuspension_selection,Tyre_selection,Brake_selection,l_overall,w_overall,h_overall,wb,mbs_exe)

global path_base

fid = fopen([path_base '06_Exchange\CAD_Model_Parameter_Table.txt'], 'rt');
colnames = fgetl(fid);
colvals = fscanf(fid, '%f', [1 inf]);
colmat = fgetl(fid);
fclose(fid);

% Define Parameters
% Deactivate seating concepts
lay_urban1 = cellstr('false');
lay_urban2 = cellstr('false');
lay_coach = cellstr('false'); % !!!
wb = (l_overall - wb)/2; % for CAD model

%Deactivate unnecessary components in CAD model
drivetrain_center_rear = cellstr('false');
drivetrain_dual_all = cellstr('true');
cooler_all = cellstr('false');
motor_all = cellstr('false');
trans_all = cellstr('false');
inv_all = cellstr('false');
ramp_in = cellstr('true');
ramp_out = cellstr('false');
street = cellstr('false');

d_tire = Tyre_selection.outside_diameter;
w_tire = Tyre_selection.width;
t_tire = (Tyre_selection.outside_diameter - Tyre_selection.rim_size*25.4)/2; % in mm
da_bdisc = Brake_selection.disc_diameter;
di_bdisc = Brake_selection.disc_diameter*0.2; % ???
t_bdisc = Brake_selection.disc_thickness;
d_spring = AirSuspension_selection.max_diameter*25.4;
h_spring = AirSuspension_selection.design_height*25.4;



% Set colvals
colvals(1) = l_overall;
colvals(2) = w_overall;
colvals(3) = h_overall;
colvals(7) = 0.7*h_overall; % CAD Requirement
colvals(8) = d_tire;
colvals(9) = wb;
colvals(10) = 0.3*l_overall; % CAD Requirement
colvals(11) = w_tire;
colvals(12) = t_tire;
colvals(18) = da_bdisc;
colvals(19) = di_bdisc;
colvals(20) = t_bdisc;
colvals(45) = d_spring;
colvals(46) = h_spring;


if mbs_exe ==1 % check if multibody simulation was executed
    load ('Link_selection','t_aarm','d_aarm','mat_aarm');
    
    colvals(48) = t_aarm;
    colvals(49) = d_aarm;
    
else
    
    t_aarm = 10;
    d_aarm = 30;
    
    colvals(48) = t_aarm; % Default value aarm thickness
    colvals(49) = d_aarm; % Default value aarm diameter
    
end

save ([path_base '10_Results\Components\Link_selection.mat'],'t_aarm','d_aarm');

%Convert Strings
colmat_array = strsplit(colmat); % split strings

colmat_array(46) = lay_urban1;
colmat_array(47) = lay_urban2;
colmat_array(48) = lay_coach;

colmat_array(66) = drivetrain_center_rear;
colmat_array(67) = drivetrain_dual_all;
colmat_array(68) = cooler_all;
colmat_array(69) = motor_all;
colmat_array(70) = trans_all;
colmat_array(71) = inv_all;
colmat_array(72) = ramp_in;
colmat_array(73) = ramp_out;
colmat_array(74) = street;

colmat = strcat(colmat_array{1,1},{'	'}); % insert tab

% fill the array with the strings and tabs
i = 2;
while i<=(length(colmat_array)-1)
    colmat_loop = strcat(colmat,colmat_array{1,i},{'	'}); % insert tab
    colmat = colmat_loop;
    i = i+1;
end
colmat_cell = strcat(colmat,colmat_array{end});
colmat = char(colmat_cell);


fid = fopen([path_base '06_Exchange\CAD_Model_Parameter_Table.txt'], 'wt');
fprintf(fid, '%s\n', colnames);
fprintf(fid, '%g\t', colvals(1:end));
fprintf(fid, '%s', colmat(1:end));

fclose(fid);

end