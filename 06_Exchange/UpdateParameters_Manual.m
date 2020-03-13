% Update parameter values in SRT_2030.CATProduct
% Write calculated parameters in txt.file


function UpdateParameters_Manual(l_overall, w_overall, h_overall, gc, h_ac, h_r, h_door, d_tire, wb, w_door, w_tire, t_tire, a_front, a_rear, t_rim, d_axis, t_axis, da_bdisc, di_bdisc, t_bdisc, t_body, h_lift, V_bat, h_bat_cell, t_bat_box, h_bat_el, t_floor, l_ac, w_ac, d_bat_cell, h_lidar, d_lidar, t_door, t_window, l_motor, d_motor, l_trans, w_trans, l_inv, w_inv, h_inv, t_frame, h_frame, d_spring, h_spring, w_wcarrier, t_aarm, d_aarm, d_damper, l_wcarrier, l_air_tank, d_air_tank, t_air_tank, d_compressor, t_compressor, l_compressor, h_seat, w_seat, l_seat, t_seat, h_backrest, l_leg_clearance, w_seat_gap, l_cooler, h_cooler, t_cooler, h_floor, h_window_shoulder, h_curb, l_ramp, w_ramp, t_ramp, h_window, mat_wh, mat_body, mat_door, mat_window, mat_floor, mat_frame, mat_ramp, mat_ac, mat_lidar, mat_seat, mat_bat_box, mat_bat_cell, mat_motor, mat_trans, mat_inv, mat_cooler, mat_tire, mat_rim, mat_bdisc, mat_bpad, mat_bcaliper, mat_axis, mat_wcarrier, mat_aarm, mat_spring, mat_damper, mat_air_tank, mat_compressor, drivetrain_center_rear, drivetrain_dual_all, cooler_all, motor_all, trans_all, inv_all, ramp_in, ramp_out, street)

global path_base

fid = fopen([path_base '06_Exchange\CAD_Model_Parameter_Table.txt'], 'rt');
colnames = fgetl(fid);
colvals = fscanf(fid, '%f', [1 inf]);
colmat = fgetl(fid);
fclose(fid);


% Set colvals (integer, doubles...)
colvals(1) = l_overall;
colvals(2) = w_overall;
colvals(3) = h_overall;
colvals(4) = gc;
colvals(5) = h_ac;
colvals(6) = h_r;
colvals(7) = h_door;
colvals(8) = d_tire;
colvals(9) = wb;
colvals(10) = w_door;
colvals(11) = w_tire;
colvals(12) = t_tire;
colvals(13) = a_front;
colvals(14) = a_rear;
colvals(15) = t_rim;
colvals(16) = d_axis;
colvals(17) = t_axis;
colvals(18) = da_bdisc;
colvals(19) = di_bdisc;
colvals(20) = t_bdisc;
colvals(21) = t_body;
colvals(22) = h_lift;
colvals(23) = V_bat;
colvals(24) = h_bat_cell;
colvals(25) = t_bat_box;
colvals(26) = h_bat_el;
colvals(27) = t_floor;
colvals(28) = l_ac;
colvals(29) = w_ac;
%colvals(30)= A_bat_cell; %not in use (can be used for barrerty calculation)
colvals(31) = d_bat_cell;
colvals(32) = h_lidar;
colvals(33) = d_lidar;
colvals(34) = t_door;
colvals(35) = t_window;
colvals(36) = l_motor;
colvals(37) = d_motor;
colvals(38) = l_trans;
colvals(39) = w_trans;
colvals(40) = l_inv;
colvals(41) = w_inv;
colvals(42) = h_inv;
colvals(43) = t_frame;
colvals(44) = h_frame;
colvals(45) = d_spring;
colvals(46) = h_spring;
colvals(47) = w_wcarrier;
colvals(48) = t_aarm;
colvals(49) = d_aarm;
colvals(50) = d_damper;
colvals(51) = l_wcarrier;
colvals(52) = l_air_tank;
colvals(53) = d_air_tank;
colvals(54) = t_air_tank;
colvals(55) = d_compressor;
colvals(56) = t_compressor;
colvals(57) = l_compressor;
colvals(58) = h_seat;
colvals(59) = w_seat;
colvals(60) = l_seat;
colvals(61) = t_seat;
colvals(62) = h_backrest;
colvals(63) = l_leg_clearance;
colvals(64) = w_seat_gap;
colvals(83) = l_cooler;
colvals(84) = h_cooler;
colvals(85) = t_cooler;
colvals(86) = h_floor;
colvals(87) = h_window_shoulder;
colvals(88) = h_curb;
colvals(89) = l_ramp;
colvals(90) = w_ramp;
colvals(91) = t_ramp;
colvals(92) = h_window;

% Convert Strings
colmat_array = strsplit(colmat); % split strings

colmat_array(1) = {mat_wh};
colmat_array(2) = {mat_body};
colmat_array(3) = {mat_door};
colmat_array(4) = {mat_window};
colmat_array(5) = {mat_floor};
colmat_array(6) = {mat_frame};
colmat_array(7) = {mat_ramp};
colmat_array(8) = {mat_ramp};
colmat_array(9) = {mat_ac};
colmat_array(10) = {mat_lidar};
colmat_array(11) = {mat_seat};
colmat_array(12) = {mat_seat};
colmat_array(13) = {mat_seat};
colmat_array(14) = {mat_seat};
colmat_array(15) = {mat_seat};
colmat_array(16) = {mat_seat};
colmat_array(17) = {mat_seat};
colmat_array(18) = {mat_seat};
colmat_array(19) = {mat_seat};
colmat_array(20) = {mat_seat};
colmat_array(21) = {mat_seat};
colmat_array(22) = {mat_seat};
colmat_array(23) = {mat_seat};
colmat_array(24) = {mat_bat_box};
colmat_array(25) = {mat_bat_cell};
colmat_array(26) = {mat_motor};
colmat_array(27) = {mat_trans};
colmat_array(28) = {mat_inv};
colmat_array(29) = {mat_cooler};
colmat_array(30) = {mat_motor};
colmat_array(31) = {mat_trans};
colmat_array(32) = {mat_inv};
colmat_array(33) = {mat_tire};
colmat_array(34) = {mat_rim};
colmat_array(35) = {mat_bdisc};
colmat_array(36) = {mat_bpad};
colmat_array(37) = {mat_bcaliper};
colmat_array(38) = {mat_axis};
colmat_array(39) = {mat_axis};
colmat_array(40) = {mat_wcarrier};
colmat_array(41) = {mat_aarm};
colmat_array(42) = {mat_spring};
colmat_array(43) = {mat_damper};
colmat_array(44) = {mat_air_tank};
colmat_array(45) = {mat_compressor};

colmat_array(66) = {drivetrain_center_rear};
colmat_array(67) = {drivetrain_dual_all};
colmat_array(68) = {cooler_all};
colmat_array(69) = {motor_all};
colmat_array(70) = {trans_all};
colmat_array(71) = {inv_all};
colmat_array(72) = {ramp_in};
colmat_array(73) = {ramp_out};
colmat_array(74) = {street};

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

% colvals(1) = l_overall;
% colvals(2) = w_overall;
% colvals(3) = h_overall;
% colvals(4) = gc;
% colvals(5) = h_ac;
% colvals(6) = h_r;
% colvals(7) = h_door;
% colvals(8) = d_tire;
% colvals(9) = wb;
% colvals(10) = w_door;
% colvals(11) = w_tire;
% colvals(12) = t_tire;
% colvals(13) = a_front;
% colvals(14) = a_rear;
% colvals(15) = t_rim;
% colvals(16) = d_axis;
% colvals(17) = t_axis;
% colvals(18) = da_bdisc;
% colvals(19) = di_bdisc;
% colvals(20) = t_bdisc;
% colvals(21) = t_body;
% colvals(22) = h_lift;
% colvals(23) = V_bat;
% colvals(24) = h_bat_cell;
% colvals(25) = t_bat_box;
% colvals(26) = h_bat_el;
% colvals(27) = t_floor;
% colvals(28) = l_ac;
% colvals(29) = w_ac;
% colvals(30) = A_bat_cell;    not in use anymore!
% colvals(31) = d_bat_cell;
% colvals(32) = h_lidar;
% colvals(33) = d_lidar;
% colvals(34) = t_door;
% colvals(35) = t_window;
% colvals(36) = l_motor;
% colvals(37) = d_motor;
% colvals(38) = l_trans;
% colvals(39) = w_trans;
% colvals(40) = l_inv;
% colvals(41) = w_inv;
% colvals(42) = h_inv;
% colvals(43) = t_frame;
% colvals(44) = h_frame;
% colvals(45) = d_spring;
% colvals(46) = h_spring;
% colvals(47) = w_wcarrier;
% colvals(48) = t_aarm;
% colvals(49) = d_aarm;
% colvals(50) = d_damper;
% colvals(51) = l_wcarrier;
% colvals(52) = l_air_tank;
% colvals(53) = d_air_tank;
% colvals(54) = t_air_tank;
% colvals(55) = d_compressor;
% colvals(56) = t_compressor;
% colvals(57) = l_compressor;
% colvals(58) = h_seat;
% colvals(59) = w_seat;
% colvals(60) = l_seat;
% colvals(61) = t_seat;
% colvals(62) = h_backrest;
% colvals(63) = l_leg_clearance;
% colvals(64) = w_seat_gap;
% 
% colvals(65) = n_ul1_rear;
% colvals(66) = n_ul1_window;
% colvals(67) = n_ul1_door;
% colvals(68) = n_cl1_rear;
% colvals(69) = n_cl1_window;
% colvals(70) = n_cl1_door;
% colvals(71) = n_ul2_rear;
% colvals(72) = n_ul2_window;
% colvals(73) = n_ul2_door;
% colvals(74) = w_rest_gap_rear_cl1;
% colvals(75) = w_rest_gap_window_cl1;
% colvals(76) = w_rest_gap_door_cl1;
% colvals(77) = w_rest_gap_window_ul1;
% colvals(78) = w_rest_gap_rear_ul1;
% colvals(79) = w_rest_gap_door_ul1;
% colvals(80) = w_rest_gap_door_ul2;
% colvals(81) = w_rest_gap_window_ul2;
% colvals(82) = w_rest_gap_rear_ul2;
% 
% colvals(83) = l_cooler;
% colvals(84) = h_cooler;
% colvals(85) = t_cooler;
% colvals(86) = h_floor;
% colvals(87) = h_window_shoulder;
% colvals(88) = h_curb;
% colvals(89) = l_ramp;
% colvals(90) = w_ramp;
% colvals(91) = t_ramp;
% colvals(92) = h_window;
% 
% colmat_array(1) = {mat_wh};
% colmat_array(2) = {mat_body};
% colmat_array(3) = {mat_door};
% colmat_array(4) = {mat_window};
% colmat_array(5) = {mat_floor};
% colmat_array(6) = {mat_frame};
% colmat_array(7) = {mat_ramp_in};
% colmat_array(8) = {mat_ramp_out};
% colmat_array(9) = {mat_ac};
% colmat_array(10) = {mat_lidar};
% colmat_array(11) = {mat_seat};
% colmat_array(12) = {mat_seat};
% colmat_array(13) = {mat_seat};
% colmat_array(14) = {mat_seat};
% colmat_array(15) = {mat_seat};
% colmat_array(16) = {mat_seat};
% colmat_array(17) = {mat_seat};
% colmat_array(18) = {mat_seat};
% colmat_array(19) = {mat_seat};
% colmat_array(20) = {mat_seat};
% colmat_array(21) = {mat_seat};
% colmat_array(22) = {mat_seat};
% colmat_array(23) = {mat_seat};
% colmat_array(24) = {mat_bat_box};
% colmat_array(25) = {mat_bat_cell};
% colmat_array(26) = {mat_motor};
% colmat_array(27) = {mat_trans};
% colmat_array(28) = {mat_inv};
% colmat_array(29) = {mat_cooler};
% colmat_array(30) = {mat_motor};
% colmat_array(31) = {mat_trans};
% colmat_array(32) = {mat_inv};
% colmat_array(33) = {mat_cooler};
% colmat_array(34) = {mat_tire};
% colmat_array(35) = {mat_rim};
% colmat_array(36) = {mat_bdisc};
% colmat_array(37) = {mat_bpad};
% colmat_array(38) = {mat_bcaliper};
% colmat_array(39) = {mat_axis};
% colmat_array(40) = {mat_axis};
% colmat_array(41) = {mat_wcarrier};
% colmat_array(42) = {mat_aarm};
% colmat_array(43) = {mat_spring};
% colmat_array(44) = {mat_damper};
% colmat_array(45) = {mat_air_tank};
% colmat_array(46) = {mat_compressor};
% 
% colmat_array(47) = {lay_urban1};
% colmat_array(48) = {lay_urban2};
% colmat_array(49) = {lay_coach};
% colmat_array(50) = {seat_ul1_front};
% colmat_array(51) = {seat_ul1_rear};
% colmat_array(52) = {seat_ul1_door_rear};
% colmat_array(53) = {seat_ul1_door_front};
% colmat_array(54) = {seat_ul2_door_front};
% colmat_array(55) = {seat_ul2_front};
% colmat_array(56) = {seat_ul2_door_rear};
% colmat_array(57) = {seat_ul2_rear};
% colmat_array(58) = {seat_cl1_door};
% colmat_array(59) = {pattern_seat_ul1_front};
% colmat_array(60) = {pattern_seat_ul1_rear};
% colmat_array(61) = {pattern_seat_ul1_door_rear};
% colmat_array(62) = {pattern_seat_ul1_door_front};
% colmat_array(63) = {pattern_seat_ul2_door_front};
% colmat_array(64) = {pattern_seat_ul2_front};
% colmat_array(65) = {pattern_seat_ul2_door_rear};
% colmat_array(66) = {pattern_seat_ul2_rear};
% 
% colmat_array(67) = {drivetrain_center_rear};
% colmat_array(68) = {drivetrain_dual_all};
% colmat_array(69) = {cooler_all};
% colmat_array(70) = {motor_all};
% colmat_array(71) = {trans_all};
% colmat_array(72) = {inv_all};
% colmat_array(73) = {ramp_in};
% colmat_array(74) = {ramp_out};
% colmat_array(75) = {street};
% 
% 167 in total