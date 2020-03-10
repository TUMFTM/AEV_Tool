% Update parameter values in SRT_2030.CATProduct
% Write calculated parameters in txt.file

function UpdateParameters_Layout_ul2 (n_ul2_rear, n_ul2_window, n_ul2_door, w_rest_gap_door_ul2, w_rest_gap_window_ul2, w_rest_gap_rear_ul2, lay_urban1, lay_urban2, lay_coach, seat_ul2_door_front, seat_ul2_front, seat_ul2_door_rear, seat_ul2_rear, pattern_seat_ul2_door_front, pattern_seat_ul2_front, pattern_seat_ul2_door_rear, pattern_seat_ul2_rear)

global path_base

fid = fopen([path_base '06_Exchange\CAD_Model_Parameter_Table.txt'], 'rt');
colnames = fgetl(fid);
colvals = fscanf(fid, '%f', [1 inf]);
colmat = fgetl(fid);
fclose(fid);


% Set colvals (integer, doubles...)

colvals(71) = n_ul2_rear;
colvals(72) = n_ul2_window;
colvals(73) = n_ul2_door;

colvals(80) = w_rest_gap_door_ul2;
colvals(81) = w_rest_gap_window_ul2;
colvals(82) = w_rest_gap_rear_ul2;


% Convert Strings
colmat_array = strsplit(colmat); % split strings

colmat_array(46) = {lay_urban1};
colmat_array(47) = {lay_urban2};
colmat_array(48) = {lay_coach};

colmat_array(53) = {seat_ul2_door_front};
colmat_array(54) = {seat_ul2_front};
colmat_array(55) = {seat_ul2_door_rear};
colmat_array(56) = {seat_ul2_rear};

colmat_array(62) = {pattern_seat_ul2_door_front};
colmat_array(63) = {pattern_seat_ul2_front};
colmat_array(64) = {pattern_seat_ul2_door_rear};
colmat_array(65) = {pattern_seat_ul2_rear};

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

