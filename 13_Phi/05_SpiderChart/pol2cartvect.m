function [x,y,z] = pol2cartvect(th,r,z) 
if size(th,1) == size(r,1) && size(th,2) == size(r,2) 
x = r.*cos(th); y = r.*sin(th); 
else 
x = r*cos(th); y = r*sin(th); 
end 