%% Example Script %%% 
% Clear workspace 
close all; 
clearvars; 
clc; 

% Point properties 
num_of_points = 6; 
row_of_points = 3; 

% % Random data 
P = rand(row_of_points, num_of_points); 
% Random data 
% First row is the maximum value, second row is the minimum value
% Third row is the main value
P = [70 12 200 100 400 40;30 6 150 0 0 20;30 6 170 66 192 20]; 

% % Scale points by a factor 
% P(:, 2) = P(:, 2) * 2; 
% P(:, 3) = P(:, 3) * 3; 
% P(:, 4) = P(:, 4) * 4; 
% P(:, 5) = P(:, 5) * 5; 

% % Make random values negative 
% P(1:3, 3) = P(1:3, 3) * -1; 
% P(:, 5) = P(:, 5) * -1; 

% Create generic labels 
P_labels = cell(num_of_points, 1); 

% for ii = 1:num_of_points 
% P_labels{ii} = sprintf('Label %i', ii); 
% end 
P_labels{1} = sprintf('Number of Passengers \n(30 - 70)');
% P_labels{1} = [sprintf('Number of Passengers') newline '(30 - 70)'];
% P_labels{2} = [sprintf('Length') newline '(6m - 12m)'];
% P_labels{3} = [sprintf('Cost') newline '(150k - 200k SGD)'];
% P_labels{4} = [sprintf('Energy Consumption') newline '(0kWh/100km - 100kWh/100km)'];
% P_labels{5} = [sprintf('Range') newline '(0-400km)'];
% P_labels{6} = [sprintf('Seats') newline '(20-40)'];

P_labels{2} = sprintf('Length \n(6m - 12m)');
P_labels{3} = sprintf('Cost \n(150k - 200k SGD)');
P_labels{4} = sprintf('Energy Consumption \n(0kWh/100km - 100kWh/100km)');
P_labels{5} = sprintf('Range \n(0-400km)');
P_labels{6} = sprintf('Seats \n(20-40)');


% Figure properties 
figure('units', 'normalized', 'outerposition', [0 0.05 1 0.95]); 

% Axes properties 
axes_interval = 2; 
axes_precision = 1;

% Spider plot 
spider_plot(P, P_labels, axes_interval, axes_precision,... 
'Marker', 'o',... 
'LineStyle', '-',... 
'LineWidth', 2,... 
'MarkerSize', 5); 

% Title properties 
title('DART',... 
'Fontweight', 'bold',... 
'FontSize', 12); 

% Legend properties 
% legend('show', 'Location', 'southoutside');
