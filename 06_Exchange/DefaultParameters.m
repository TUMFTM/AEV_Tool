% Default parameter values for SRT_2030.CATProduct

fid = fopen('CAD_Model_Parameter_Table_org.txt', 'rt');
colnames = fgetl(fid);
colvals = fscanf(fid, '%f', [1 inf]);
colmat = fgetl(fid);
fclose(fid);

fid = fopen('T:\04_Cluster_C\500_SRT\033_SRT Package\Parametric Model\AEV_Tool\06_Exchange\CAD_Model_Parameter_Table.txt', 'wt');
fprintf(fid, '%s\n', colnames);
fprintf(fid, '%g\t', colvals(1:end-1));
fprintf(fid, '%g\t', colvals(end));
fprintf(fid, '%s', colmat(1:end));

fclose(fid);
clear all;