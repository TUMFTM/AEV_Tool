% Update parameter values in SRT_2030.CATProduct
% Write calculated parameters in txt.file

function UpdateParameters_Layout_cl1(n_cl1_rear, n_cl1_window, n_cl1_door, w_rest_gap_rear_cl1, w_rest_gap_window_cl1, w_rest_gap_door_cl1, lay_urban1, lay_urban2, lay_coach, seat_cl1_door)

global path_base

fid = fopen([path_base '06_Exchange\CAD_Model_Parameter_Table.txt'], 'rt');
colnames = fgetl(fid);
colvals = fscanf(fid, '%f', [1 inf]);
colmat = fgetl(fid);
fclose(fid);


% Set colvals (integer, doubles...)

colvals(68) = n_cl1_rear;
colvals(69) = n_cl1_window;
colvals(70) = n_cl1_door;

colvals(74) = w_rest_gap_rear_cl1;
colvals(75) = w_rest_gap_window_cl1;
colvals(76) = w_rest_gap_door_cl1;


% Convert Strings
colmat_array = strsplit(colmat); % split strings

colmat_array(46) = {lay_urban1};
colmat_array(47) = {lay_urban2};
colmat_array(48) = {lay_coach};

colmat_array(57) = {seat_cl1_door};

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
