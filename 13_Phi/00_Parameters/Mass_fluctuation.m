
%% this script initializes a passenger fluctuation cycle based on the BRT
%cycle

median_load = 0.6; %load in percent of maximum load

load('C:\Users\sebastian.krapf\Documents\08_LDS\00_Parameters\BRT_Beijing.mat');
dc_mass = 0*dc.time; %init

%% model passenger access and exit when vehicle speed = 0
dc_mass(1:95) = 0.5;
dc_mass(95:209) = 0.2;
dc_mass(209:320) = 0.9;
dc_mass(320:500) = 0.5;
dc_mass(500:593) = 0.1;
dc_mass(593:693) = 0.3;
dc_mass(693:797) = 0.8;
dc_mass(797:902) = 0.5;
dc_mass(902:1122) = 0.9;
dc_mass(1122:end) = 0.3;

%% scale to desired median load
mean_load_is = mean(dc_mass);
dc_mass = dc_mass*median_load/mean_load_is;

%% plot
plot(dc_mass)