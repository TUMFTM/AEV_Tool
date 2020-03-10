%function for calculating tire and rim configuration
function [t_tire] = calc_tire (d_tire, d_rim)

%convert d_rim from inch in mm (1 inch = 25.4mm)
d_rim = d_rim * 25.4;

%calculation of tire thickness
t_tire = (d_tire - d_rim)/2;


end
