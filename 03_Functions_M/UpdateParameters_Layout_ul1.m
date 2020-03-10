% Update parameter values in SRT_2030.CATProduct
% Write calculated parameters in txt.file

function UpdateParameters_Layout_ul1 (n_ul1_rear, n_ul1_window, n_ul1_door, w_rest_gap_window_ul1, w_rest_gap_rear_ul1, w_rest_gap_door_ul1, lay_urban1, lay_urban2, lay_coach, seat_ul1_front, seat_ul1_rear, seat_ul1_door_rear, seat_ul1_door_front, pattern_seat_ul1_front, pattern_seat_ul1_rear, pattern_seat_ul1_door_rear, pattern_seat_ul1_door_front)

global path_base

fid = fopen([path_base '06_Exchange\CAD_Model_Parameter_Table.txt'], 'rt');
colnames = fgetl(fid);
colvals = fscanf(fid, '%f', [1 inf]);
colmat = fgetl(fid);
fclose(fid);


% Set colvals (integer, doubles...)
colvals(65) = n_ul1_rear;
colvals(66) = n_ul1_window;
colvals(67) = n_ul1_door;

colvals(77) = w_rest_gap_window_ul1;
colvals(78) = w_rest_gap_rear_ul1;
colvals(79) = w_rest_gap_door_ul1;


% Convert Strings
colmat_array = strsplit(colmat); % split strings

colmat_array(46) = {lay_urban1};
colmat_array(47) = {lay_urban2};
colmat_array(48) = {lay_coach};

colmat_array(49) = {seat_ul1_front};
colmat_array(50) = {seat_ul1_rear};
colmat_array(51) = {seat_ul1_door_rear};
colmat_array(52) = {seat_ul1_door_front};

colmat_array(58) = {pattern_seat_ul1_front};
colmat_array(59) = {pattern_seat_ul1_rear};
colmat_array(60) = {pattern_seat_ul1_door_rear};
colmat_array(61) = {pattern_seat_ul1_door_front};


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
fprintf(fid, '%g\t', colvals(1:end-1));
fprintf(fid, '%g\t', colvals(end));
fprintf(fid, '%s', colmat(1:end));

fclose(fid);

end

