function [Weighted, eff_ov,e] = VISUALIZE_load_points_FR_180226(eff_n, eff_T, eff,n,T,i_gear)
%VISUALIZATION_LOAD_POINTS takes motor speed and torque as the raw 
%simulation data and draws a diagram with all load points

%Author: Sebastian Krapf
%13/12/2017
%adapted: 26/02/18

%% calculate efficiency at each point
% create meshgrid with desired resolution (needed f. (extra-)interpolation)
[xData,yData] = ndgrid(eff_n, eff_T);

% map interpolation
F = griddedInterpolant(xData,yData,eff','linear','none'); 
eff_ov = F( n, abs(T));
e = eff_ov;
eff_ov = eff_ov(eff_ov>0);
eff_ov = mean(eff_ov); %overall mean efficiency

%% find load points that appear multiple times
n_grid = max(eff_n)/50; 
T_grid = max(eff_T)/50; 
n = round(n/n_grid,0)*n_grid; %cluster load point (grid is 50 of max. of axis)
T = round(T/T_grid,0)*T_grid; %cluster load point (grid is 50 of max. of axis)

%only positive or zero power:
% iT = find(T>=0);
% n = n(iT);
% T = T(iT);

% sort to find multiple appearance
A = [n T i_gear];
[Weighted,~,ic] = unique(A,'rows');
for i = 1:max(ic)
    ib = ic(ic==i);
    Weighted(i,4) = min([ 50, numel(ib)]); %max. weight is 20
end

%% draw diagram
v = [0.5, 0.7, 0.8, 0.85, 0.9:0.02:0.98, 0.99, 1];
cm = colormap(gca,(summer(max(Weighted(:,3))))); %colormap for load points
% cstep = (length(cm)-1)/(max(Weighted(:,3)-1));
% col = cm(1:cstep:length(cm),:);
col = cm;
cm = colormap(gca,(flipud(hot(64)))); %colormap for the efficiency map
mark = {'o', 's', 'd', 'v', '*', 'h'};

hold off;
contourf(eff_n*60/2/pi, eff_T, eff, v,'ShowText','on');
hold on;
contourf(eff_n*60/2/pi, fliplr(-eff_T), flipud(eff), v,'ShowText','on');
caxis([0 1]);

weight_fac = 10;

for i = 1:max(Weighted(:,3))
    id = Weighted(:,3)==i;
    Weighted_gear{i} = Weighted(id,:);

    scatter(Weighted_gear{i}(:,1)*60/2/pi,Weighted_gear{i}(:,2),weight_fac*Weighted_gear{i}(:,4),col(i,:),mark{i},'MarkerFaceColor',col(i,:));
end

end

% hold off

