 function varargout = TUMCREATE(varargin)

%%%%%%%%%%%%%%% AEV TOOL %%%%%%%%%%%%%%%
% Output     |  Unit |     Descriptiion
%----------------------------------------
% list available seperately 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%FILE PATH%%%%%%%%%%%%%%%%%%
FN_RUN = 'TUMCREATE'; %file name run script
global path_base
path_base = mfilename('fullpath');
path_base = erase(path_base,FN_RUN);
% addpath(genpath(path_base));

%% TUMCREATE GUI Settings:

% Color: Blue [0.22 0.48 0.69], Green [0.06 0.66 0.53]

%% Panels Name:
% Sizing: uip_sizing (Workstation)
% Start Page: uip_StartPage (Configuration Mode)
% Visualization of Manual Mode: uip_M_Visualization
% Analysis Automated Mode: uip_Automated_Analysis
% Energy Consumption: uip_EnergyConsumption
    % Cost Estimation: uip_CostEstimation
    % Vehicle Concept: uip_VC
% DART Overview: uip_DART (Overvie DART - Start Page)
% Manual Mode: uip_ManualMode
    % Vehicle Specification: uip_M_VehicleSpecification
    % Powertrain: uip_M_Powertrain
    % Suspension: uip_M_Suspension
    % Chassis: uip_M_Chassis
    % Electronics: uip_M_Electronics
% Progress line Manual Mode: uip_M_Config
% Autoamted Mode: uip_Automated
    % Visualization: uip_Automated_Visualization
% Progress Line Automated Mode: uip_ConfigurationProgress_Automated

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TUMCREATE_OpeningFcn, ...
                   'gui_OutputFcn',  @TUMCREATE_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before TUMCREATE is made visible.
function TUMCREATE_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TUMCREATE (see VARARGIN)

% Choose default command line output for TUMCREATE
handles.output = hObject;
clc
evalin('base','clear all');     % clear workspace

global path_base

%% Preparation for customer survey
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Statistic_NoP = load([path_base '13_Phi\03_Statistics\Statistic_NoP']);       
% Statistic_VS = load([path_base '13_Phi\03_Statistics\Statistic_VS']);
% Statistic_Motor = load([path_base '13_Phi\03_Statistics\Statistic_Motor']);
% assignin('base','Statistic_NoP',Statistic_NoP);
% assignin('base','Statistic_VS',Statistic_VS);
% assignin('base','Statistic_Motor',Statistic_Motor);
% Statistic = load([path_base '13_Phi\03_Statistics\Statistic.mat']);
% assignin('base','Statistic',Statistic);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Load Database
[~,~,HVAC_Data] = xlsread('HVAC_updated_1.xlsx');       % Vehicle Spec, Powertrain and HVAC Database in one
assignin('base','HVAC_Data',HVAC_Data);                 % Store on the main workspace
% clearvars -except HVAC_Data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       Initialization          %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This part defines the first loading section all
% necessary objects are defined, therefore

%% Resolution
axes(handles.ax_Laptop)                     % Laptop image, when selecting workingstation
imshow('Laptop.jpg')
axes(handles.ax_Demonstrator)               % Demonstrator image, when selecting workingstation
imshow('Demonstrator.jpg')

%% Currency
set(handles.tb_CE_SGD,'Value',0.0);         % SGD = false
set(handles.tb_CE_Euro,'Value',1.0);        % Euro = true

%% Start Page
axes(handles.ax_Logo)
imshow('TUMCREATE_Logo_Color_1.jpg')        % TUMCREATE Logo

% axes(handles.ax_NRF)
% imshow('NationalResearchFoundation.png')
axes(handles.ax_TUM)
imshow('NTU_Logo.jpg')
axes(handles.ax_NTU)
imshow('TUM_Logo.png')
% axes(handles.ax_TUMASIA)
% imshow('TUMAsia.png')

set(handles.uip_ConfigurationProgress_Automated,'Visible','off')
bg_Vizu = imread('slider-right.jpg');
bg_Vizu_resize = imresize(bg_Vizu,1/2);
set(handles.pb_Visualization,'CData',bg_Vizu_resize)

% StartPage Button (Home Button, first Button)
Start_Page = imread('StartPage.jpg');
Start_Page_resize = imresize(Start_Page,1/15);
set(handles.pb_StartPage,'CData',Start_Page_resize)

% Presentation Button (Second Button) 
Presentation_Page = imread('Presentation_icon.jpg');
Presentation_Page_resize = imresize(Presentation_Page,1/30);
set(handles.pb_Presentation,'CData',Presentation_Page_resize)

% Delete Button (Third Button)
Delete_Page = imread('delete.jpg');
Delete_Page_resize = imresize(Delete_Page,1/4);
set(handles.pb_delete,'CData',Delete_Page_resize)

% Buttons Arrow 
bg_image = imread('slider-right.jpg');
bg_image_resize = imresize(bg_image,1/4);
set(handles.p_Manual,'CData',bg_image_resize);
set(handles.p_Automated,'CData',bg_image_resize);
set(handles.p_Demo,'CData',bg_image_resize);

%% Automated Mode
set(handles.uip_Automated,'Visible','off');

% Vehicle Specifications
set(handles.uip_VehicleSpecification,'Visible','on');
set(handles.tb_Coach,'Value',0.0);
set(handles.tb_30,'Value',0.0);
set(handles.tb_SA_standing,'Value',0.0);
set(handles.slider1,'Enable','off');
set(handles.pb_NoP_ind,'Enable','off');

% Powertrain
set(handles.uip_Powertrain,'Visible','off');
set(handles.rb_PT_1,'Value',0.0,'Enable','off');
set(handles.rb_PT_2,'Value',0.0,'Enable','off');
set(handles.rb_PT_3,'Value',0.0,'Enable','off');
set(handles.rb_PT_4,'Value',0.0,'Enable','off');

% Overview
axes(handles.ax_Powertrain1)
imshow('Powertrain_base.jpg')

% Chassis
set(handles.uip_Chassis,'Visible','off');
set(handles.rb_Ch_Database_standard,'Enable','on');
set(handles.rb_Ch_Database_Addelete,'Enable','on','Value',0.0);
set(handles.rb_Ch_Database_Add_FromMatlab,'Enable','on','Value',0.0);
set(handles.pb_Ch_Database,'Enable','off');
set(handles.pb_Ch_UpdateDatabase,'Enable','off');
set(handles.txt_Ch_Enter,'Enable','off');
set(handles.ed_Ch_EnterDatabase,'Enable','off');
set(handles.pb_Ch_Continue,'Enable','off');
set(handles.pm_DatabaseComponents,'Enable','off');
set(handles.pb_Ch_Sizing,'Value',0.0);


%% Cooling
set(handles.uip_Cooling,'Visible','off');
set(handles.tb_HVAC_Eva_1core,'Value',0.0);
set(handles.tb_HVAC_Eva_2core,'Value',0.0);
set(handles.tb_HVAC_Cond_1core,'Value',0.0);
set(handles.tb_HVAC_Cond_2core,'Value',0.0);
set(handles.tb_HVAC_Rad_1Ch,'Value',0.0);
set(handles.tb_HVAC_Rad_2Ch,'Value',0.0);
set(handles.tb_HVAC_Rad_3Ch,'Value',0.0);
set(handles.pb_HVAC_Eva_sizing,'Value',0.0);
set(handles.pb_HVAC_Cond_sizing,'Value',0.0);
set(handles.pb_HVAC_Rad_sizing,'Value',0.0);

axes(handles.ax_Cooling)
imshow('AirCondition.jpg')

% Automated Vizualisation
set(handles.uip_Automated_Visualization,'Visible','off');

% Play Button for the Visualization
Play = imread('Play_Button.jpg');
Play_resize = imresize(Play,1/10);
set(handles.pb_Play,'CData',Play_resize)

set(handles.uip_Automated_Analysis,'Visible','off');

% Vehicle Specification - Info Seating Layout
set(handles.uip_Automated_Info_Seating,'Visible','off');
set(handles.uip_Automated_Info_Standing,'Visible','off');
set(handles.uip_Automated_Info_2Zone,'Visible','off');

axes(handles.ax_Info_2Zone_CityBus)
imshow('Urban2_Layout_Screenshot.jpg')
% axes(handles.ax_Info_2Zone_ShuttleBus)
% imshow('Urban2_Layout_Screenshot.jpg')
axes(handles.ax_Info_Seating)
imshow('Coach_Layout_screenshot.jpg')
axes(handles.ax_Info_Standing)
imshow('Urban1_Layout_Screenshot.jpg')

%% Cost Estimation
% Forward Arrow
bg_image1 = imread('slider-right.jpg');
bg_image_resize1 = imresize(bg_image1,1/6);
set(handles.pb_PT_forward1,'CData',bg_image_resize1)
set(handles.pb_PT_forward2,'CData',bg_image_resize1)
set(handles.pb_Chassis_forward1,'CData',bg_image_resize1)
set(handles.pb_Chassis_forward2,'CData',bg_image_resize1)
% Return Arrow
bg_image_return = imread('return_blue.jpg');
bg_image_return_resize = imresize(bg_image_return,1/40);
set(handles.pb_return_Chassis_SL,'CData',bg_image_return_resize)
set(handles.pb_return_PT_SL,'CData',bg_image_return_resize)
% Backward Arrow
bg_image2 = imread('slider-left.jpg');
bg_image_resize2 = imresize(bg_image2,1/6);
set(handles.pb_PT_backward2,'CData',bg_image_resize2)
set(handles.pb_PT_backward3,'CData',bg_image_resize2)

%% Motor Arrow Forward
set(handles.pb_Motor_forward_Front1,'CData',bg_image_resize1)
set(handles.pb_Motor_forward_Back1,'CData',bg_image_resize1)
set(handles.pb_Motor_forward_Back2,'CData',bg_image_resize1)
set(handles.pb_Motor_forward_Front2,'CData',bg_image_resize1)

% Motor uip's
set(handles.uip_MotorEff_Front1,'Visible','on');
set(handles.uip_MotorEff_Back2,'Visible','off');
set(handles.uip_MotorEff_Front2,'Visible','off');
set(handles.uip_MotorEff_Back1,'Visible','off');

%% Manual Mode
set(handles.uip_ManualMode,'Visible','off');
% Images
axes(handles.ax_M_VehicleSpecs)
imshow('Seating_Layouts.png')

axes(handles.ax_M_Powertrain)
imshow('Powertrain.png')

axes(handles.ax_M_Suspension)
imshow('Suspension.png')

axes(handles.ax_M_Chassis)
imshow('Chassis.png')

% Configuration Progress
set(handles.uip_M_Config,'Visible','off')
bg_Vizu_M = imread('slider-right.jpg');
bg_Vizu_resize_M = imresize(bg_Vizu_M,1/2);
set(handles.pb_M_Vizualisation,'CData',bg_Vizu_resize_M)

%% Visualization
set(handles.uip_M_Visualization,'Visible','off');

bg_Vizu_back = imread('slider-left.jpg');
bg_Vizu_back_resize = imresize(bg_Vizu_back,1/3);
set(handles.pb_M_Visu_back,'CData',bg_Vizu_back_resize)
set(handles.pb_Concept_Back,'CData',bg_Vizu_back_resize)    %Back Button Automated Concept Mode

%% DART (Overview of he DART Configuration)
set(handles.uip_DART,'Visible','off');

set(handles.pb_DART_ISO,'CData',imresize(imread('DART_ISO.jpg'),1/3))
set(handles.pb_DART_Side,'CData',imresize(imread('DART_Side.jpg'),1/3))
set(handles.pb_DART_Front,'CData',imresize(imread('DART_Front.jpg'),1/3))
set(handles.pb_DART_Seats,'CData',imresize(imread('DART_Interior.jpg'),1/3))

set(handles.pb_Dart_Arrow_1,'CData',bg_image_resize1)
set(handles.pb_Dart_Arrow_2,'CData',bg_image_resize1)

%% Delete - white covers are defined to covedifferent chart when deleting 
set(handles.uip_cover_Battery,'Visible','off');
set(handles.uip_cover_DriveCycle,'Visible','off');
set(handles.uip_cover_EnergyLoss,'Visible','off');
set(handles.uip_cover_Motor,'Visible','off');
set(handles.uip_cover_Motor_Text,'Visible','off');
set(handles.uip_cover_EnergyLoss_text,'Visible','off');

%% Vehicle Concept Automated Mode
Concept = 1;                                            % Cocnept 1 is the Standard Concept
assignin('base','Concept',Concept)

% Arrow Comparison
set(handles.pb_VC_next1,'CData',bg_image_resize1)
set(handles.pb_VC_next2,'CData',bg_image_resize1)

%% Spider Chart

% Point properties 
num_of_points = 6; 
row_of_points = 3; 

% % Random data 
P = rand(row_of_points, num_of_points); 
% Random data 
% First row is the maximum value, second row is the minimum value
% Third row is the main value
P = [70 15 240 180 400 60;30 5 80 0 0 0;30 6 170/1.6 66 192 20];            % Configuration of the DART 
 
% Create generic labels 
P_labels = cell(num_of_points, 1); 

% for ii = 1:num_of_points 
% P_labels{ii} = sprintf('Label %i', ii); 
% end 
P_labels{1} = sprintf('Number of \nPassengers \n(30 - 70)');
P_labels{2} = sprintf('Length \n(5m - 15m)');
P_labels{3} = sprintf('Cost \n(80k - 240k €)');
P_labels{4} = sprintf('E. Consumption \n(0kWh/100km - \n180kWh/100km)');
P_labels{5} = sprintf('Range \n(0-400km)');
P_labels{6} = sprintf('Seats \n(0-60)');

% Figure properties 
axes(handles.ax_spiderchart_1)
% figure('units', 'normalized', 'outerposition', [0 0.05 1 0.95]); 

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

% Images
set(handles.image_DART_ISO,'CData',imresize(imread('DART_ISO.jpg'),1/3))
set(handles.image_DART_SIDE,'CData',imresize(imread('DART_Side.jpg'),3/10))
set(handles.image_DART_FRONT,'CData',imresize(imread('DART_Front.jpg'),1/3))
set(handles.image_DART_TOP,'CData',imresize(imread('DART_Interior.jpg'),3/10))

% Point properties 
num_of_points = 6; 
row_of_points = 3; 

% % Random data 
P = rand(row_of_points, num_of_points); 
% Random data 
% First row is the maximum value, second row is the minimum value
% Third row is the main value
P = [70 15 240 180 400 60;30 5 80 0 0 0;30 6 170/1.6 66 192 20];            % Configuration of the DART for Comparison part
 
% Create generic labels 
P_labels = cell(num_of_points, 1); 

% for ii = 1:num_of_points 
% P_labels{ii} = sprintf('Label %i', ii); 
% end 
P_labels{1} = sprintf('Number of \nPassengers \n(30 - 70)');
P_labels{2} = sprintf('Length \n(5m - 15m)');
P_labels{3} = sprintf('Cost \n(80k - 240k €)');
P_labels{4} = sprintf('E. Consumption \n(0kWh/100km - \n180kWh/100km)');
P_labels{5} = sprintf('Range \n(0-400km)');
P_labels{6} = sprintf('Seats \n(0-60)');


% Figure properties 
axes(handles.ax_spiderchart_1_C)
% figure('units', 'normalized', 'outerposition', [0 0.05 1 0.95]); 

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

% Spider Chart Total

cb_dart = 0
assignin('base','cb_dart',cb_dart)
cb_concept1 = 0
assignin('base','cb_concept1',cb_concept1)
set(handles.cb_concept1,'Enable','off');
cb_concept2 = 0
assignin('base','cb_concept2',cb_concept2)
set(handles.cb_concept2,'Enable','off');

%% Powertrain Additional Simulation
axes(handles.ax_Topology)
imshow('Powertrain_base.jpg')
set(handles.uip_Powertrain_Simulation,'Visible','off')

% Motor Topology
% Activation
set(handles.ch_FR_ac,'Value',0.0)
set(handles.ch_RR_ac,'Value',0.0)
set(handles.ch_FL_ac,'Value',0.0)
set(handles.ch_RL_ac,'Value',0.0)
% Motor Type and Power
set(handles.pop_FR_Type,'Enable','off')
set(handles.pop_RR_Type,'Enable','off')
set(handles.pop_FL_Type,'Enable','off')
set(handles.pop_RL_Type,'Enable','off')
set(handles.pop_FR_Power,'Enable','off')
set(handles.pop_RR_Power,'Enable','off')
set(handles.pop_FL_Power,'Enable','off')
set(handles.pop_RL_Power,'Enable','off')
% Transmission
set(handles.rb_F1,'Value',1.0)          %Front
set(handles.rb_F2,'Value',0.0)          %Front
set(handles.rb_F4,'Value',0.0)          %Front
set(handles.rb_F6,'Value',0.0)          %Front

set(handles.rb_R1,'Value',1.0)          %Rear
set(handles.rb_R2,'Value',0.0)          %Rear
set(handles.rb_R4,'Value',0.0)          %Rear
set(handles.rb_R6,'Value',0.0)          %Rear

% Setting the default values
CYCLE = 'BRT_Beijing.mat';
assignin('base','CYCLE',CYCLE)

FA1 = '';
FA2 = '';
RA1 = '';
RA2 = '';
assignin('base','FA1',FA1)
assignin('base','FA2',FA2)
assignin('base','RA1',RA1)
assignin('base','RA2',RA2)

Z_gears_FA = 1;
Z_gears_RA = 1;
assignin('base','Z_gears_RA',Z_gears_RA)
assignin('base','Z_gears_FA',Z_gears_FA)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TUMCREATE wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TUMCREATE_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%% Make it GUI Fullsize - run WindowsAPI.m for the first time
WindowAPI(gcf, 'Position', 'full')          % making Full Screen
WindowAPI(gcf, 'Button', 'off');            % Invisible Delete Button
% set(gcf,'Units','Normalized')

% --- Executes on button press in pb_Demonstrator.
function pb_Demonstrator_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Demonstrator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uip_sizing,'Visible','off')

% --- Executes on button press in pb_Laptop.
function pb_Laptop_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Laptop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Changes the Font Size and Image Size to Laptop Version
set(handles.txt_M_Config_VS,'FontSize',18)
set(handles.pb_VS_m,'FontSize',12)
set(handles.pb_VerhicleSpecification,'FontSize',12)
set(handles.tb_Concept1,'FontSize',9)
set(handles.tb_Concept2,'FontSize',9)
set(handles.tb_SA_seats,'FontSize',9)
set(handles.tb_SA_standing,'FontSize',9)
set(handles.tb_SA_2zones,'FontSize',9)
set(handles.pb_Automated_Visualization,'FontSize',14)
set(handles.txt_HVAC_Comp,'FontSize',10)
set(handles.txt_OV_HVAC_Com,'FontSize',11)
set(handles.txt_OV_Ch_1,'FontSize',10)
set(handles.txt_OV_Ch_2,'FontSize',10)
set(handles.txt_OV_Ch_3,'FontSize',10)
set(handles.txt_OV_Ch_4,'FontSize',10)
set(handles.pb_EnergyConsumption,'FontSize',13)
set(handles.pb_CostEstimation,'FontSize',15)
set(handles.pb_VehicleConcept,'FontSize',15)
set(handles.tb_VC1,'FontSize',10)
set(handles.tb_VC2,'FontSize',10)
set(handles.txt_concept_energy,'FontSize',10)
set(handles.txt_Cost_Control,'FontSize',10)
set(handles.txt_concept_energy,'FontSize',9)
set(handles.txt_Cost_Contactor,'FontSize',9)
set(handles.pb_visualize_property,'FontSize',12)
set(handles.pb_visualize_property2,'FontSize',12)
set(handles.txt_Config_VS,'FontSize',15)
set(handles.uip_sizing,'Visible','off')

% --- Executes on button press in p_Manual.
function p_Manual_Callback(hObject, eventdata, handles)
% hObject    handle to p_Manual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%FILE PATH%%%%%%%%%%%%%%%%%%
FN_RUN = 'TUMCREATE'; %file name run script
global path_base
path_base = mfilename('fullpath');
path_base = erase(path_base,FN_RUN);
% addpath(genpath(path_base));

set(handles.txt_Mode,'String','Manual Mode');
% uip Pages setting
set(handles.uip_StartPage,'Visible','off');
set(handles.uip_ManualMode,'Visible','on');
set(handles.uip_M_Config,'Visible','on')

set(handles.uip_ConfigurationProgress_Automated,'Visible','off')
set(handles.uip_Automated_Analysis,'Visible','off');
set(handles.uip_M_Visualization,'Visible','off');
set(handles.uip_Automated,'Visible','off');
set(handles.uip_M_Visualization,'Visible','off');

% --- Executes on button press in p_Demo.
function p_Demo_Callback(hObject, eventdata, handles)
% hObject    handle to p_Demo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uip_DART,'Visible','on');
set(handles.txt_Mode,'String','DART');
set(handles.uip_StartPage,'Visible','off');

set(handles.uip_ConfigurationProgress_Automated,'Visible','off')
set(handles.uip_Automated_Analysis,'Visible','off');
set(handles.uip_M_Visualization,'Visible','off');
set(handles.uip_Automated,'Visible','off');
set(handles.uip_M_Visualization,'Visible','off');
set(handles.uip_ManualMode,'Visible','off');
set(handles.uip_M_Config,'Visible','off')

% --- Executes on button press in p_Automated.
function p_Automated_Callback(hObject, eventdata, handles)
% hObject    handle to p_Automated (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%FILE PATH%%%%%%%%%%%%%%%%%%
FN_RUN = 'TUMCREATE'; %file name run script
global path_base
path_base = mfilename('fullpath');
path_base = erase(path_base,FN_RUN);
% addpath(genpath(path_base));

set(handles.txt_Mode,'String','Automated Mode');
% uip Pages setting
set(handles.uip_StartPage,'Visible','off');
set(handles.uip_Automated,'Visible','on');
set(handles.uip_ConfigurationProgress_Automated,'Visible','on');

set(handles.uip_ManualMode,'Visible','off');
set(handles.uip_M_Config,'Visible','off')
set(handles.uip_M_Visualization,'Visible','off');
set(handles.uip_Automated_Analysis,'Visible','off');

% --- Executes on button press in tb_Concept1.
function tb_Concept1_Callback(hObject, eventdata, handles)
% hObject    handle to tb_Concept1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tb_Concept1

Concept = 1;
assignin('base','Concept',Concept)
set(handles.tb_Concept1,'BackgroundColor',[0.06 0.66 0.53]);
set(handles.tb_Concept2,'BackgroundColor',[0.9 0.9 0.9]);

% --- Executes on button press in tb_Concept2.
function tb_Concept2_Callback(hObject, eventdata, handles)
% hObject    handle to tb_Concept2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tb_Concept2

Concept = 2;
assignin('base','Concept',Concept)
set(handles.tb_Concept2,'BackgroundColor',[0.06 0.66 0.53]);
set(handles.tb_Concept1,'BackgroundColor',[0.9 0.9 0.9]);


% --- Executes on button press in pb_VerhicleSpecification.
function pb_VerhicleSpecification_Callback(hObject, eventdata, handles)
% hObject    handle to pb_VerhicleSpecification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

%% Page Callback
set(handles.uip_VehicleSpecification,'Visible','on');
set(handles.uip_Powertrain,'Visible','off');
set(handles.uip_Chassis,'Visible','off');
set(handles.uip_Cooling,'Visible','off');
set(handles.uip_Automated_Visualization,'Visible','off');
set(handles.uip_Powertrain_Simulation,'Visible','off');

% --- Executes on button press in pb_Chassis.
function pb_Chassis_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Chassis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

%% Page Callback
set(handles.uip_VehicleSpecification,'Visible','off');
set(handles.uip_Powertrain,'Visible','off');
set(handles.uip_Chassis,'Visible','on');
set(handles.uip_Cooling,'Visible','off');
set(handles.uip_Automated_Visualization,'Visible','off');
set(handles.uip_Powertrain_Simulation,'Visible','off');

%% Databas Connection
run DBConnection
assignin('base','AirSpring',AirSpring)
assignin('base','Brakes',Brakes)
assignin('base','Tyre',Tyre)

%% Wheelbase Calculation
NoP = evalin('base','NoP')      % Number of Passengers in []
llen = evalin('base','llen')    % vehicle length in [mm]

if exist ('NoP') && exist ('llen')
    
    syms p1 p2 p3
    % Coeffiecent of polynomial regression (Degree:2, R-square: 0.9981)    
    p1 = 5.682e-06
    p2 = 0.7677
    p3 = -562.4
    
    wb = floor(p1*(llen^2) + p2*llen + p3)
    assignin('base','wb',wb)
    
    txtWb = sprintf('%s',wb);
    set(handles.txt_OV_Ch_Wheelbase_Ed,'String',txtWb,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_Ch_Wheelbase,'FontWeight','bold','ForegroundColor','k');

end

%% Number of seats calculation
% Parameters
tb_SA_2zones = evalin('base','tb_SA_2zones');
tb_SA_seats = evalin('base','tb_SA_seats');
tb_SA_standing = evalin('base','tb_SA_standing');
wb = double(wb);

llleenn = evalin('base','llleenn');
llleenn = double(llleenn);
l_overall = llleenn; 

wb = (l_overall - wb)/2;       % different wheelbase definition Phi und Manfred
                               % wb in this case is the distance between
                               % the wheels
t_body = 5;
t_seat = 40;
l_seat = 400;
l_leg_clearance = 300;
w_door = 1800;
d_tire = 767;
w_overall = 2700;
w_tire = 215;
d_spring = 300;
w_seat_gap = 50;
w_seat = 400;

%seats calculation
if tb_SA_seats == 1
    
% Calculation of potential seating area dimension

l_cl1_window = l_overall - 2*(t_body + t_seat + (l_seat/2) + 50 + l_leg_clearance + l_seat + t_seat); % l_overall - 2*(wb + (d_tire * 2/3)) + (l_seat + t_seat)Distance between front and rear wheelhouse plus one seat that sits on the wheelhouse
l_cl1_door = ((l_overall - w_door - (2* wb) - (d_tire * 4/3))/2) + (l_seat + t_seat); %Distance between front and rear wheelhouse and door plus one seat that sits on the wheelhouse
l_cl1_rear = w_overall - 2*(t_body + w_tire + d_spring + 50); %Distance between left and right wheelhouse, 50 is distance between tire and air spring

% Number of seats CL1, floor = round down to get integer
n_cl1_window = floor(l_cl1_window / (t_seat + l_seat + l_leg_clearance));
n_cl1_door = floor(l_cl1_door / (t_seat + l_seat + l_leg_clearance));
n_cl1_rear = floor(l_cl1_rear / (w_seat + (2* w_seat_gap)));
n_cl1_seats = 2 * (n_cl1_window + 2 * n_cl1_door + n_cl1_rear); %Multiplication by 2 because of two seats in a row
num_seats = n_cl1_seats;

else if tb_SA_standing == 1
    
    % Calculation of potential seating area dimension
l_ul1_window = l_overall - 2*(wb + (d_tire * 2/3));              % Distance between front and rear wheelhouse
l_ul1_door = (l_overall - w_door - (2* wb) - (d_tire * 4/3))/2;  % Distance between front and rear wheelhouse and door
l_ul1_rear = w_overall - 2*(t_body + w_tire + d_spring + 50);    % Distance between left and right wheelhouse, 50 is distance between tire and air spring

% Number of seats UL1, floor = round down to get integer
n_ul1_window = floor(l_ul1_window / (w_seat + (2* w_seat_gap)));  % Calculating number of seats window row in UL1
n_ul1_door = floor(l_ul1_door / (w_seat + (2* w_seat_gap)));      % Calculating number of seats door row in UL1
n_ul1_rear = floor(l_ul1_rear / (w_seat + (2* w_seat_gap)));      % Calculating number of seats front and rear row in UL1
n_ul1_seats = n_ul1_window + 2 * n_ul1_door + 2 * n_ul1_rear;     % Calculating total number of seats in UL1
num_seats = n_ul1_seats;

else if tb_SA_2zones == 1
            
% Calculation of potential seating area dimensions
l_ul2_window = l_overall - 2*(t_body + t_seat + (l_seat/2) + 50);
l_ul2_door = (l_overall - 2*((w_door/2) +t_body + t_seat + (l_seat/2) + 50))/2;
l_ul2_rear = w_overall - 2*(t_body + t_seat + l_leg_clearance + l_seat + 50);

% Number of seats UL2, round down to get integer
n_ul2_window = floor(l_ul2_window / (w_seat + (2* w_seat_gap)));
n_ul2_door = floor(l_ul2_door / (w_seat + (2* w_seat_gap)));
n_ul2_rear = floor(l_ul2_rear / (w_seat + (2* w_seat_gap)));
n_ul2_seats = n_ul2_window + (2 * n_ul2_door) + (2 * n_ul2_rear);
num_seats = n_ul2_seats;

        end
    end
end
assignin('base','num_seats',num_seats)


% --- Executes on button press in pb_Cooling.
function pb_Cooling_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Cooling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

%% Page Callback
set(handles.uip_VehicleSpecification,'Visible','off');
set(handles.uip_Powertrain,'Visible','off');
set(handles.uip_Chassis,'Visible','off');
set(handles.uip_Cooling,'Visible','on');
set(handles.uip_Automated_Visualization,'Visible','off');
set(handles.uip_Powertrain_Simulation,'Visible','off');

syms l_column w_column h_column Temp_column Cooling_column 

l_column = 13;              % Length Compressor
w_column = 14;              % Width Compressor
h_column = 15;              % Height Compressor
Temp_column = 10;           % Temperature Compressor
Cooling_column = 12;        % Cooling Demand Compressor
Comp_Typ = 16;              % Typ Compressor

NoP = evalin('base','NoP');
HVAC_Data = evalin('base','HVAC_Data');

%% Compressor Selection from Database

if handles.tb_Coach.Value == true 
    
    rowpt=3;
            
else if handles.tb_Citybus.Value == true && handles.tb_SA_2zones.Value == true
        
    rowpt=17;
    
else if handles.tb_Shuttlebus.Value == true && handles.tb_SA_2zones.Value == true
    
    rowpt=31;
    
else if (handles.tb_Shuttlebus.Value == true || handles.tb_Citybus.Value ==  true)...
            && handles.tb_SA_standing.Value == true
        
    rowpt=45;
    
          end
       end
    end
end
                   
    switch true
        
        case (NoP>=30 && NoP<34)
            
            row_pt = rowpt;
            
        case (NoP>=34 && NoP<38)
    
            row_pt = rowpt+1;
            
        case (NoP>=38 && NoP<42)
            
            row_pt = rowpt+2;
            
        case (NoP>=42 && NoP<46)
            
            row_pt = rowpt+3;
            
        case (NoP>=46 && NoP<50)
            
            row_pt = rowpt+4;
            
        case (NoP>=50 && NoP<54)
            
            row_pt = rowpt+5;
            
        case (NoP>=54 && NoP<58)
            
            row_pt = rowpt+6;
            
        case (NoP>=58 && NoP<62)
            
            row_pt = rowpt+7;
            
        case (NoP>=62 && NoP<66)
            
            row_pt = rowpt+8;
            
        case (NoP>=66 && NoP<70)
            
            row_pt = rowpt+9;
            
        otherwise
            
            row_pt = rowpt+10;
            
    end

assignin('base','row_pt',row_pt)        % row in the database for calculation battery performance

%% Sizing Compressor (only one model)
l_comp = floor(cell2mat(HVAC_Data(row_pt,l_column)));       % length of Compressor              
w_comp = floor(cell2mat(HVAC_Data(row_pt,w_column)));       % width of comptessor           
h_comp = floor(cell2mat(HVAC_Data(row_pt,h_column)));       % height of compressor           
typ = HVAC_Data(row_pt,Comp_Typ);

% Cabin temperature and Energy Consumption of HVAC
Temp_cabine = roundn(cell2mat(HVAC_Data(row_pt,Temp_column)),-2);      
Energy_HVAC = roundn(cell2mat(HVAC_Data(row_pt,Cooling_column)),-2);   
   
assignin('base','l_comp',l_comp)
assignin('base','w_comp',w_comp)
assignin('base','h_comp',h_comp)
assignin('base','Temp_cabine',Temp_cabine)
assignin('base','Energy_HVAC',Energy_HVAC)

txtComp = sprintf('%s x %s x %s',num2str(l_comp),num2str(w_comp),num2str(h_comp));
Typ_comp = typ;
 
set(handles.txt_OV_HVAC_Com_Ed,'String',txtComp,'FontWeight','bold','ForegroundColor','k');
set(handles.txt_OV_HVAC_Com,'FontWeight','bold','ForegroundColor','k');
set(handles.txt_OV_HVAC_Com_Ad,'String',Typ_comp,'FontWeight','bold','ForegroundColor','k');
    

if (handles.tb_HVAC_Eva_1core.Value == true || handles.tb_HVAC_Eva_2core.Value == true)...
        && (handles.tb_HVAC_Cond_1core.Value == true || handles.tb_HVAC_Cond_2core.Value == true)...
        && (handles.tb_HVAC_Rad_1Ch.Value == true || handles.tb_HVAC_Rad_2Ch.Value == true...
        || handles.tb_HVAC_Rad_3Ch.Value == true)
    
    txtTemp = sprintf('%.5s°C',num2str(Temp_cabine));
    set(handles.txt_OV_HVAC_temp,'String',txtTemp,'FontWeight','bold','ForegroundColor','k');
    
end  

if (handles.tb_HVAC_Eva_1core.Value == true || handles.tb_HVAC_Eva_2core.Value == true)...
        && (handles.tb_HVAC_Cond_1core.Value == true || handles.tb_HVAC_Cond_2core.Value == true)...
        && (handles.tb_HVAC_Rad_1Ch.Value == true || handles.tb_HVAC_Rad_2Ch.Value == true...
        || handles.tb_HVAC_Rad_3Ch.Value == true)
    
    txtEn = sprintf('%.5skW',num2str(Energy_HVAC));
    set(handles.txt_OV_HVAC_energy,'String',txtEn,'FontWeight','bold','ForegroundColor','k');

end    

% --- Executes on button press in tb_Coach.
function tb_Coach_Callback(hObject, eventdata, handles)
% hObject    handle to tb_Coach (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tb_Coach
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

set(handles.txt_OV_VC_ed,'String','Coach','FontWeight','bold');
set(handles.txt_OV_VC,'FontWeight','bold','ForegroundColor','k');
set(handles.tb_SA_standing,'Enable','off','Value',0.0);
set(handles.tb_SA_2zones,'Enable','off','Value',0.0);
set(handles.txt_OV_SA_ed,'String','Coach Layout','FontWeight','bold');
set(handles.txt_OV_SA,'FontWeight','bold','ForegroundColor','k');
set(handles.tb_SA_seats,'Enable','on');
    
VS = 'Coach';
assignin('base','VS',VS)

%% For Statistic
% Stat_VS = 1;
% assignin('base','Stat_VS',Stat_VS)

% --- Executes on button press in tb_Citybus.
function tb_Citybus_Callback(hObject, eventdata, handles)
% hObject    handle to tb_Citybus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tb_Citybus
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

 set(handles.txt_OV_VC_ed,'String','City Bus','FontWeight','bold');
 set(handles.txt_OV_VC,'FontWeight','bold','ForegroundColor','k');
 set(handles.tb_SA_standing,'Enable','on');
 set(handles.tb_SA_2zones,'Enable','on');
 set(handles.tb_SA_seats,'Enable','off');
 set(handles.tb_SA_seats,'Value',0.0);
    
 VS = 'City Bus';
 assignin('base','VS',VS)
 
%% For Statistic
% Stat_VS = 2;
% assignin('base','Stat_VS',Stat_VS)
 
% --- Executes on button press in tb_Shuttlebus.
function tb_Shuttlebus_Callback(hObject, eventdata, handles)
% hObject    handle to tb_Shuttlebus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tb_Shuttlebus
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

set(handles.txt_OV_VC_ed,'String','Shuttle Bus','FontWeight','bold');
set(handles.txt_OV_VC,'FontWeight','bold','ForegroundColor','k');
set(handles.tb_SA_standing,'Enable','on');
set(handles.tb_SA_2zones,'Enable','on');
set(handles.tb_SA_seats,'Enable','off');
set(handles.tb_SA_seats,'Value',0.0);   
        
VS = 'Shuttle Bus';
assignin('base','VS',VS)

%% For Statistic
% Stat_VS = 3;
% assignin('base','Stat_VS',Stat_VS)

% --- Executes on button press in tb_30.
function tb_30_Callback(hObject, eventdata, handles)
% hObject    handle to tb_30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tb_30
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

set(handles.txt_OV_NoP_ed,'String','30','FontWeight','bold');
set(handles.txt_OV_NoP,'FontWeight','bold','ForegroundColor','k');
NoP = 30;
assignin('base','NoP',NoP)

% --- Executes on button press in tb_40.
function tb_40_Callback(hObject, eventdata, handles)
% hObject    handle to tb_40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tb_40
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

set(handles.txt_OV_NoP_ed,'String','40','FontWeight','bold');
set(handles.txt_OV_NoP,'FontWeight','bold','ForegroundColor','k');
NoP = 40;
assignin('base','NoP',NoP)


% --- Executes on button press in tb_50.
function tb_50_Callback(hObject, eventdata, handles)
% hObject    handle to tb_50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tb_50
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

set(handles.txt_OV_NoP_ed,'String','50','FontWeight','bold');
set(handles.txt_OV_NoP,'FontWeight','bold','ForegroundColor','k');
NoP = 50;
assignin('base','NoP',NoP)


% --- Executes on button press in tb_60.
function tb_60_Callback(hObject, eventdata, handles)
% hObject    handle to tb_60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tb_60
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

set(handles.txt_OV_NoP_ed,'String','60','FontWeight','bold');
set(handles.txt_OV_NoP,'FontWeight','bold','ForegroundColor','k');
NoP = 60;
assignin('base','NoP',NoP)


% --- Executes on button press in tb_70.
function tb_70_Callback(hObject, eventdata, handles)
% hObject    handle to tb_70 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tb_70
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

set(handles.txt_OV_NoP_ed,'String','70','FontWeight','bold');
set(handles.txt_OV_NoP,'FontWeight','bold','ForegroundColor','k');
NoP = 70;
assignin('base','NoP',NoP)

% --- Executes on button press in chk_NoP.
function chk_NoP_Callback(hObject, eventdata, handles)
% hObject    handle to chk_NoP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chk_NoP
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

% Selection if slider is true or not
if handles.chk_NoP.Value == true
    
    set(handles.tb_30,'Enable','off','Value',0.0);
    set(handles.tb_40,'Enable','off','Value',0.0);
    set(handles.tb_50,'Enable','off','Value',0.0);
    set(handles.tb_60,'Enable','off','Value',0.0);
    set(handles.tb_70,'Enable','off','Value',0.0);
    set(handles.slider1,'Enable','on');
    set(handles.pb_NoP_ind,'Enable','on');

else if handles.chk_NoP.Value == false
    
    set(handles.tb_30,'Enable','on');
    set(handles.tb_40,'Enable','on');
    set(handles.tb_50,'Enable','on');
    set(handles.tb_60,'Enable','on');
    set(handles.tb_70,'Enable','on');
    set(handles.slider1,'Enable','off');
    set(handles.pb_NoP_ind,'Enable','off');
    
    end
end

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

sliderNoP = round(get(hObject,'Value'));
assignin('base','NoP',sliderNoP);
set(handles.pb_NoP_ind,'String',num2str(sliderNoP));

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in pb_NoP_ind.
function pb_NoP_ind_Callback(hObject, eventdata, handles)
% hObject    handle to pb_NoP_ind (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

sliderNoP = evalin('base','NoP')
set(handles.txt_OV_NoP_ed,'String',num2str(sliderNoP),'FontWeight','bold');
set(handles.txt_OV_NoP,'FontWeight','bold','ForegroundColor','k');

% --- Executes on button press in tb_SA_seats.
function tb_SA_seats_Callback(hObject, eventdata, handles)
% hObject    handle to tb_SA_seats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tb_SA_seats
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

set(handles.txt_OV_SA_ed,'String','Coach Layout','FontWeight','bold');
set(handles.txt_OV_SA,'FontWeight','bold','ForegroundColor','k');

%% For Visualization
tb_SA_standing = 0;
tb_SA_2zones = 0;
tb_SA_seats = 1;

assignin('base','tb_SA_standing',tb_SA_standing);
assignin('base','tb_SA_2zones',tb_SA_2zones);
assignin('base','tb_SA_seats',tb_SA_seats);

% --- Executes on button press in tb_SA_standing.
function tb_SA_standing_Callback(hObject, eventdata, handles)
% hObject    handle to tb_SA_standing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tb_SA_standing
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

set(handles.txt_OV_SA_ed,'String','Urban 1 Layout','FontWeight','bold');
set(handles.txt_OV_SA,'FontWeight','bold','ForegroundColor','k');

%% For Visualization
tb_SA_standing = 1;
tb_SA_2zones = 0;
tb_SA_seats = 0;

assignin('base','tb_SA_standing',tb_SA_standing);
assignin('base','tb_SA_2zones',tb_SA_2zones);
assignin('base','tb_SA_seats',tb_SA_seats);

% --- Executes on button press in tb_SA_2zones.
function tb_SA_2zones_Callback(hObject, eventdata, handles)
% hObject    handle to tb_SA_2zones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tb_SA_2zones
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

set(handles.txt_OV_SA_ed,'String','Urban 2 Layout','FontWeight','bold');
set(handles.txt_OV_SA,'FontWeight','bold','ForegroundColor','k');
    

%% For Visualization
tb_SA_standing = 0;
tb_SA_2zones = 1;
tb_SA_seats = 0;

assignin('base','tb_SA_standing',tb_SA_standing);
assignin('base','tb_SA_2zones',tb_SA_2zones);
assignin('base','tb_SA_seats',tb_SA_seats);

% --- Executes on button press in pb_info_seats.
function pb_info_seats_Callback(hObject, eventdata, handles)
% hObject    handle to pb_info_seats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pb_info_seats
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

set(handles.uip_Automated_Info_Seating,'Visible','on');
set(handles.uip_Automated_Info_Standing,'Visible','off');
set(handles.uip_Automated_Info_2Zone,'Visible','off');


% --- Executes on button press in pb_calculate.
function pb_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pb_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

syms l_cabine w_cabine d_leg d_gap w_door l_seat w_seat w_height NoP d_wheelhouse a_passenger a_area1 a_area2 a_area3 
sym a
sym b
sym c
sym d
sym llen

% Parameter
w_cabine = 2590
d_leg = 300
d_gap = 50
w_door = 1500
l_seat = 440
w_seat = 400
w_height = 2200
d_wheelhouse = 767
a_passenger = 333000
    
% % Coefficent for exponential regression
% a = 2.831e-13
% b = 0.002474
% c = 2350
% d = 8.001e-05
    
assignin('base','w_cabine',w_cabine)
assignin('base','d_leg',d_leg)
assignin('base','d_gap',d_gap)
assignin('base','w_door',w_door)
assignin('base','l_seat',l_seat)
assignin('base','w_seat',w_seat)
assignin('base','a_area1',a_area1)
assignin('base','a_area2',a_area2)
assignin('base','a_area3',a_area3)
assignin('base','d_wheelhouse',d_wheelhouse)
    
NoP = evalin('base','NoP')

%% calculation of the vehicle length in [mm]

if handles.tb_Coach.Value == true

    eqn = NoP == 2*(l_cabine-l_seat-d_leg)/(l_seat+d_leg )+w_cabine/(w_seat+d_gap)...
        +2*(1/2*(l_cabine-w_door )-(l_seat+d_leg))/(l_seat+d_leg )+2*(1/2*(l_cabine+w_door ))...
        /(l_seat+d_leg)
    llen=floor(solve(eqn,l_cabine))
    llen=llen+110
    
    database_option = 1;    %placeholder for Cost Estimation
  
else if handles.tb_Shuttlebus.Value == true && handles.tb_SA_2zones.Value == true
        
    eqn = NoP == (((l_cabine*w_cabine)-2*(l_seat+d_leg)*w_cabine-4*d_wheelhouse*(d_wheelhouse/2)...
        -w_door*(w_door/2))/a_passenger)+10     
    llen=floor(solve(eqn,l_cabine))
    llen=llen+110
    
    database_option = 3;    %placeholder for Cost Estimation
    
else if handles.tb_Shuttlebus.Value == true && handles.tb_SA_standing.Value == true
        
    eqn = NoP == ((l_cabine*w_cabine)-4*d_wheelhouse*(d_wheelhouse/2)-w_door*(w_door/2))...
        /a_passenger
    llen=floor(solve(eqn,l_cabine))
    llen=llen+110
    
    database_option = 4;    %placeholder for Cost Estimation
   
else if handles.tb_Citybus.Value == true && handles.tb_SA_standing.Value == true
    
    eqn = NoP == ((l_cabine*w_cabine)-4*d_wheelhouse*(d_wheelhouse/2)-w_door*(w_door/2))...
        /a_passenger
    llen=floor(solve(eqn,l_cabine))
    llen=llen+110
      
    database_option = 4;    %placeholder for Cost Estimation
    
else if handles.tb_Citybus.Value == true && handles.tb_SA_2zones.Value == true
        
    a_area1 = (l_cabine-2*(l_seat+d_leg))*(l_seat+d_leg)
    a_area2 = (w_cabine-2*(l_seat+d_leg))*(l_seat+d_leg)
    a_area3 = (l_cabine/2-w_door/2-(l_seat+d_leg))*(l_seat+d_leg)
    eqn = NoP == (l_cabine-2*(l_seat+d_leg))/(w_seat+d_gap)+2*(l_cabine/2-w_door/2-...
        (l_seat+d_leg))/(w_seat+d_gap)+4+((l_cabine*w_cabine-a_area1-2*a_area2-2*a_area3-...
        w_door*w_door/2-4*(l_seat+d_leg)^2)/a_passenger)
    llen=floor(solve(eqn,l_cabine))
    llen=llen+110
          
    database_option = 2;    %placeholder for Cost Estimation
        
                end
            end
        end
    end
end

llleenn = llen + 500;       %Fake Length

X=sprintf('%s x 2700 x 3100',llleenn);
set(handles.txt_OV_VehicleDimension_ed,'String',X,'FontWeight','bold','ForegroundColor','k');
set(handles.txt_OV_VehicleDimension,'FontWeight','bold','ForegroundColor','k');
assignin('base','database_option',database_option)
assignin('base','llleenn',llleenn)

%% mass calculation without powertrain in [kg]
% Coefficent for exponential regression
a_mass = 2.831e-13
b_mass = 0.002474
c_mass = 2350
d_mass = 8.001e-05

mass = floor(a_mass*exp(b_mass*llen) + c_mass*exp(d_mass*llen))         % exponential regression
assignin('base','mass',mass)
assignin('base','llen',llen)
Y = sprintf('%s',mass);
set(handles.txt_OV_VehicleMass_ed,'String',Y,'FontWeight','bold','ForegroundColor','k');
set(handles.txt_OV_VehicleMass,'FontWeight','bold','ForegroundColor','k');

if (handles.tb_Coach.Value == true && exist ('NoP')) || (handles.tb_Citybus.Value == true...
        && exist ('NoP') && (handles.tb_SA_standing.Value == true || handles.tb_SA_2zones.Value == true))...
        || (handles.tb_Shuttlebus.Value == true && exist ('NoP') && (handles.tb_SA_standing.Value == true...
        || handles.tb_SA_2zones.Value == true))
    
    set(handles.txt_Config_VS,'BackgroundColor',[0.06 0.66 0.53])
    VehicleSpecification = 1,
    assignin('base','VehicleSpecification',VehicleSpecification)
    
end

% --- Executes on button press in pb_OV_Benchmark.
function pb_OV_Benchmark_Callback(hObject, eventdata, handles)
% hObject    handle to pb_OV_Benchmark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

%% Compare Concept with Benchmark vehicle
hold off
NoP = evalin('base','NoP')
llen = evalin('base','llen')
B_llen=[3928 4750 3920 6000 2700 3900 4500 12100];
B_NoP=[12 15 12 24 10 12 12 31];
axes(handles.ax_Benchmark)
plot(B_llen,B_NoP,'kx')
grid on
xlabel('length in mm','FontSize',14,'FontWeight','bold')
ylabel('Number of Passengers','FontSize',14,'FontWeight','bold')
%title('Comparison of configuration with other benchmark buses','FontSize',12,'FontWeight','bold')
text(B_llen(1),B_NoP(1),'EZ10, Olli, AGV ','FontSize',10,'Color','black','HorizontalAlignment','right')
text(B_llen(2),B_NoP(2),' Navya','FontSize',10,'Color','black','HorizontalAlignment','left')
text(B_llen(4),B_NoP(4),' Rivium','FontSize',10,'Color','black','HorizontalAlignment','left')
text(B_llen(5),B_NoP(5),' NEXT','FontSize',10,'Color','black','HorizontalAlignment','left')
text(B_llen(7),B_NoP(7),' M2B8','FontSize',10,'Color','black','HorizontalAlignment','left')
text(B_llen(8),B_NoP(8),' Future MB','FontSize',10,'Color','black','HorizontalAlignment','left')

hold on
plot(double(llen),NoP,'rx')
text(double(llen),NoP,' TUMCREATE','FontSize',12,'Color','red','HorizontalAlignment','left')

set(gca,'YLim',[5 75],'YTick',[5:10:75]);

% --- Executes on button press in pb_Powertrain.
function pb_Powertrain_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Powertrain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

%% Page Callback
set(handles.uip_VehicleSpecification,'Visible','off');
set(handles.uip_Powertrain,'Visible','on');
set(handles.uip_Chassis,'Visible','off');
set(handles.uip_Cooling,'Visible','off');
set(handles.uip_Automated_Visualization,'Visible','off');
set(handles.uip_Powertrain_Simulation,'Visible','off');

%% Calculation of the Powertrain
Cost1Inve = 843;
Cost1Moto = 820;
Cost1Trans = 201;

Bat_serial = 95;
Pmax1_Inverter = 93;
Pmax2_Inverter = 50;

Cost2Inve = 520;
Cost2Moto = 557;


if handles.tb_Coach.Value == true 
    
    rowpt=3;
        
else if handles.tb_Citybus.Value == true && handles.tb_SA_2zones.Value == true
        
    rowpt=17;
    
else if handles.tb_Shuttlebus.Value == true && handles.tb_SA_2zones.Value == true
    
    rowpt=31;
    
else if (handles.tb_Shuttlebus.Value == true || handles.tb_Citybus.Value ==  true)...
            && handles.tb_SA_standing.Value == true
        
    rowpt=45;
    
          end
       end
    end
end
            
    NoP = evalin('base','NoP');
    HVAC_Data = evalin('base','HVAC_Data');
       
    switch true
        
        case (NoP>=30 && NoP<34)
            
            row_pt = rowpt;
            
        case (NoP>=34 && NoP<38)
    
            row_pt = rowpt+1;
            
        case (NoP>=38 && NoP<42)
            
            row_pt = rowpt+2;
            
        case (NoP>=42 && NoP<46)
            
            row_pt = rowpt+3;
            
        case (NoP>=46 && NoP<50)
            
            row_pt = rowpt+4;
            
        case (NoP>=50 && NoP<54)
            
            row_pt = rowpt+5;
            
        case (NoP>=54 && NoP<58)
            
            row_pt = rowpt+6;
            
        case (NoP>=58 && NoP<62)
            
            row_pt = rowpt+7;
            
        case (NoP>=62 && NoP<66)
            
            row_pt = rowpt+8;
            
        case (NoP>=66 && NoP<70)
            
            row_pt = rowpt+9;
            
        otherwise
            
            row_pt = rowpt+10;
            
    end
    
    % initalization
    set(handles.rb_PT_1,'Enable','on');
    set(handles.rb_PT_2,'Enable','on');
    set(handles.rb_PT_3,'Enable','on');
    set(handles.rb_PT_4,'Enable','on');         
       
    %1 Motor per Axle 300km
    E1Consumption300 = floor(cell2mat(HVAC_Data(row_pt,52)));         % Energy Consumption
    E1Bat300 = floor(cell2mat(HVAC_Data(row_pt,53)));                 % Energy Battery
    Cost1B300 = floor(cell2mat(HVAC_Data(row_pt,54)));                % Cost of the Battery
    Bat1_parallel300 = floor(cell2mat(HVAC_Data(row_pt,62)));         % number of parallel Cell
    Cost1All300 = floor(cell2mat(HVAC_Data(row_pt,66)));              % Total Cost Powertrain (Drivetrain)
    PowPT1 = 254;                                                     % Power Powertrain
    PowPT1PS = 345;                                                   % 1kW = 1,36 PS
    
    Cost1Inverter300_1 = floor(cell2mat(HVAC_Data(row_pt,55)));       % Cost Inverter
    Cost1Inverter300_2 = floor(cell2mat(HVAC_Data(row_pt,56)));       % Cost Inverter
    Cost1Motor300_1 = floor(cell2mat(HVAC_Data(row_pt,57)));          % Cost Motor
    Cost1Motor300_2 = floor(cell2mat(HVAC_Data(row_pt,58)));          % Cost Motor
    Cost1Trans300_1 = floor(cell2mat(HVAC_Data(row_pt,59)));          % Cost Transmission
    Cost1Trans300_2 = floor(cell2mat(HVAC_Data(row_pt,60)));          % Cost Transmission
    
    assignin('base','Cost1B300',Cost1B300)
    assignin('base','Cost1Inverter300_1',Cost1Inverter300_1)
    assignin('base','Cost1Inverter300_2',Cost1Inverter300_2)
    assignin('base','Cost1Motor300_1',Cost1Motor300_1)
    assignin('base','Cost1Motor300_2',Cost1Motor300_2)
    assignin('base','Cost1Trans300_1',Cost1Trans300_1)
    assignin('base','Cost1Trans300_2',Cost1Trans300_2)
    assignin('base','Cost1All300',Cost1All300)
    assignin('base','Bat1_parallel300',Bat1_parallel300)
    assignin('base','E1Consumption300',E1Consumption300)    %for Spider Chart

    
    
    %1 Motor per Axle 400km
    E1Consumption400 = floor(cell2mat(HVAC_Data(row_pt,71)));
    E1Bat400 = floor(cell2mat(HVAC_Data(row_pt,72)));
    Cost1B400 = floor(cell2mat(HVAC_Data(row_pt,73)));
    Bat1_parallel400 = floor(cell2mat(HVAC_Data(row_pt,81)));
    Cost1All400 = floor(cell2mat(HVAC_Data(row_pt,85)));
    
    Cost1Inverter400_1 = floor(cell2mat(HVAC_Data(row_pt,74)));
    Cost1Inverter400_2 = floor(cell2mat(HVAC_Data(row_pt,75)));
    Cost1Motor400_1 = floor(cell2mat(HVAC_Data(row_pt,76)));
    Cost1Motor400_2 = floor(cell2mat(HVAC_Data(row_pt,77)));
    Cost1Trans400_1 = floor(cell2mat(HVAC_Data(row_pt,78)));
    Cost1Trans400_2 = floor(cell2mat(HVAC_Data(row_pt,79)));
   
    assignin('base','Cost1B400',Cost1B400)
    assignin('base','Cost1Inverter400_1',Cost1Inverter400_1)
    assignin('base','Cost1Inverter400_2',Cost1Inverter400_2)
    assignin('base','Cost1Motor400_1',Cost1Motor400_1)
    assignin('base','Cost1Motor400_2',Cost1Motor400_2)
    assignin('base','Cost1Trans400_1',Cost1Trans400_1)
    assignin('base','Cost1Trans400_2',Cost1Trans400_2)
    assignin('base','Bat1_parallel400',Bat1_parallel400)
    assignin('base','Cost1All400',Cost1All400)
    assignin('base','E1Consumption400',E1Consumption400)    %for Spider Chart
    
    %2 Motor per Axle 300km
    E2Consumption300 = floor(cell2mat(HVAC_Data(row_pt,90)));
    E2Bat300 = floor(cell2mat(HVAC_Data(row_pt,91)));
    Cost2B300 = floor(cell2mat(HVAC_Data(row_pt,92)));
    Bat2_parallel300 = floor(cell2mat(HVAC_Data(row_pt,106)));
    Cost2All300 = floor(cell2mat(HVAC_Data(row_pt,110)));
    Cost2Trans300 = floor(cell2mat(HVAC_Data(row_pt,101)));
    PowPT2 = 276;
    PowPT2PS = 375; % 1kW = 1,36 PS
    
    
    Cost2Inverter300_1 = floor(cell2mat(HVAC_Data(row_pt,93)));
    Cost2Inverter300_2 = floor(cell2mat(HVAC_Data(row_pt,94)));
    Cost2Inverter300_3 = floor(cell2mat(HVAC_Data(row_pt,95)));
    Cost2Inverter300_4 = floor(cell2mat(HVAC_Data(row_pt,96)));
    Cost2Motor300_1 = floor(cell2mat(HVAC_Data(row_pt,97)));
    Cost2Motor300_2 = floor(cell2mat(HVAC_Data(row_pt,98)));
    Cost2Motor300_3 = floor(cell2mat(HVAC_Data(row_pt,99)));
    Cost2Motor300_4 = floor(cell2mat(HVAC_Data(row_pt,100)));    
    Cost2Trans300_1 = floor(cell2mat(HVAC_Data(row_pt,101)));
    Cost2Trans300_2 = floor(cell2mat(HVAC_Data(row_pt,102)));
    Cost2Trans300_3 = floor(cell2mat(HVAC_Data(row_pt,103)));
    Cost2Trans300_4 = floor(cell2mat(HVAC_Data(row_pt,104)));
    
    assignin('base','Cost2Inverter300_1',Cost2Inverter300_1)
    assignin('base','Cost2Inverter300_2',Cost2Inverter300_2)
    assignin('base','Cost2Inverter300_3',Cost2Inverter300_3)
    assignin('base','Cost2Inverter300_4',Cost2Inverter300_4)
    
    assignin('base','Cost2Motor300_1',Cost2Motor300_1)
    assignin('base','Cost2Motor300_2',Cost2Motor300_2)
    assignin('base','Cost2Motor300_3',Cost2Motor300_3)
    assignin('base','Cost2Motor300_4',Cost2Motor300_4)
        
    assignin('base','Cost2Trans300_1',Cost2Trans300_1)
    assignin('base','Cost2Trans300_2',Cost2Trans300_2)
    assignin('base','Cost2Trans300_3',Cost2Trans300_3)
    assignin('base','Cost2Trans300_4',Cost2Trans300_4)
    
    assignin('base','Cost2All300',Cost2All300)
    assignin('base','Cost2B300',Cost2B300)
    assignin('base','Bat2_parallel300',Bat2_parallel300)
    
    assignin('base','E2Consumption300',E2Consumption300)    %for Spider Chart
    
    %2 Motor per Axle 400km
    E2Consumption400 = floor(cell2mat(HVAC_Data(row_pt,115)));
    E2Bat400 = floor(cell2mat(HVAC_Data(row_pt,116)));
    Cost2B400 = floor(cell2mat(HVAC_Data(row_pt,117)));
    Bat2_parallel400 = floor(cell2mat(HVAC_Data(row_pt,131)));
    Cost2All400 = floor(cell2mat(HVAC_Data(row_pt,135)));
    Cost2Trans400 = floor(cell2mat(HVAC_Data(row_pt,126)));
    
    Cost2Inverter400_1 = floor(cell2mat(HVAC_Data(row_pt,118)));
    Cost2Inverter400_2 = floor(cell2mat(HVAC_Data(row_pt,119)));
    Cost2Inverter400_3 = floor(cell2mat(HVAC_Data(row_pt,120)));
    Cost2Inverter400_4 = floor(cell2mat(HVAC_Data(row_pt,121)));
    Cost2Motor400_1 = floor(cell2mat(HVAC_Data(row_pt,122)));
    Cost2Motor400_2 = floor(cell2mat(HVAC_Data(row_pt,123)));
    Cost2Motor400_3 = floor(cell2mat(HVAC_Data(row_pt,124)));
    Cost2Motor400_4 = floor(cell2mat(HVAC_Data(row_pt,125)));    
    Cost2Trans400_1 = floor(cell2mat(HVAC_Data(row_pt,126)));
    Cost2Trans400_2 = floor(cell2mat(HVAC_Data(row_pt,127)));
    Cost2Trans400_3 = floor(cell2mat(HVAC_Data(row_pt,128)));
    Cost2Trans400_4 = floor(cell2mat(HVAC_Data(row_pt,129)));
    
    assignin('base','Cost2Inverter400_1',Cost2Inverter400_1)
    assignin('base','Cost2Inverter400_2',Cost2Inverter400_2)
    assignin('base','Cost2Inverter400_3',Cost2Inverter400_3)
    assignin('base','Cost2Inverter400_4',Cost2Inverter400_4)
    
    assignin('base','Cost2Motor400_1',Cost2Motor400_1)
    assignin('base','Cost2Motor400_2',Cost2Motor400_2)
    assignin('base','Cost2Motor400_3',Cost2Motor400_3)
    assignin('base','Cost2Motor400_4',Cost2Motor400_4)
        
    assignin('base','Cost2Trans400_1',Cost2Trans400_1)
    assignin('base','Cost2Trans400_2',Cost2Trans400_2)
    assignin('base','Cost2Trans400_3',Cost2Trans400_3)
    assignin('base','Cost2Trans400_4',Cost2Trans400_4)
    
    assignin('base','Cost2All400',Cost2All400)
    assignin('base','Cost2B400',Cost2B400)
    assignin('base','Bat2_parallel400',Bat2_parallel400)
    
    assignin('base','E2Consumption400',E2Consumption400)    %for Spider Chart
    
    % Battery Capacity
    Bat1Cap300 = E1Bat300*2.5;  %1 Motor per Axle 300km
    Bat1Cap400 = E1Bat400*2.5;  %1 Motor per Axle 400km
    Bat2Cap300 = E2Bat300*2.5;  %2 Motor per Axle 300km
    Bat2Cap400 = E2Bat400*2.5;  %2 Motor per Axle 400km
    
%% selection options of powertrain    
txtPT1300 = sprintf('%s Ah, %s kW (%s PS), 300 km, %s kWh/100 km ',num2str(Bat1Cap300),num2str(PowPT1),num2str(PowPT1PS),num2str(E1Consumption300));
txtPT1300_Cost = sprintf('Price Powertrain: %s € / %s SGD',num2str(Cost1All300),num2str(floor(Cost1All300*1.6)));

set(handles.rb_PT_1,'String',txtPT1300,'FontWeight','bold','ForegroundColor','k');
set(handles.txt_PT1,'String',txtPT1300_Cost,'FontWeight','bold','ForegroundColor','k');

txtPT1400 = sprintf('%s Ah, %s kW (%s PS), 400 km, %s kWh/100 km ',num2str(Bat1Cap400),num2str(PowPT1),num2str(PowPT1PS),num2str(E1Consumption400));
txtPT1400_Cost = sprintf('Price Powertrain: %s € / %s SGD',num2str(Cost1All400),num2str(floor(Cost1All400*1.6)));

set(handles.rb_PT_2,'String',txtPT1400,'FontWeight','bold','ForegroundColor','k');
set(handles.txt_PT2,'String',txtPT1400_Cost,'FontWeight','bold','ForegroundColor','k');

txtPT2300 = sprintf('%s Ah, %s kW (%s PS), 300 km, %s kWh/100 km ',num2str(Bat2Cap300),num2str(PowPT2),num2str(PowPT2PS),num2str(E2Consumption300));
txtPT2300_Cost = sprintf('Price Powertrain: %s € / %s SGD',num2str(Cost2All300),num2str(floor(Cost2All300*1.6)));

set(handles.rb_PT_3,'String',txtPT2300,'FontWeight','bold','ForegroundColor','k');
set(handles.txt_PT3,'String',txtPT2300_Cost,'FontWeight','bold','ForegroundColor','k');

txtPT2400 = sprintf('%s Ah, %s kW (%s PS), 400 km, %s kWh/100 km ',num2str(Bat2Cap400),num2str(PowPT2),num2str(PowPT2PS),num2str(E2Consumption400));
txtPT2400_Cost = sprintf('Price Powertrain: %s € / %s SGD',num2str(Cost2All400),num2str(floor(Cost2All400*1.6)));

set(handles.rb_PT_4,'String',txtPT2400,'FontWeight','bold','ForegroundColor','k');
set(handles.txt_PT4,'String',txtPT2400_Cost,'FontWeight','bold','ForegroundColor','k');

%% mass calculation with powertrain in [kg]
llen = evalin('base','llen')
mass = evalin('base','mass')
sym pt1
sym pt2
sym pt3
sym llen
pt1 = 1.157e-05;
pt2 = 0.459;
pt3 = -505.1;

mass_PT = floor(pt1*llen^2 + pt2*llen + pt3);           % in kg

assignin('base','mass_PT',mass_PT)
mass_ALL = mass + mass_PT;
assignin('base','mass_ALL',mass_ALL)

% --- Executes on button press in rb_PT_1.
function rb_PT_1_Callback(hObject, eventdata, handles)
% hObject    handle to rb_PT_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_PT_1
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

%% Pre-setting
set(handles.rb_PT_1,'Value',1.0);
set(handles.rb_PT_2,'Value',0.0);
set(handles.rb_PT_3,'Value',0.0);
set(handles.rb_PT_4,'Value',0.0);
set(handles.txt_Config_PT,'BackgroundColor',[0.06 0.66 0.53])

mass_ALL = evalin('base','mass_ALL');

%% Powertrain Overview
axes(handles.ax_Powertrain1)
imshow('2Motor.jpg')

set(handles.txt_OV_PT_Motor,'String','Motor: Horlbeck PSM, 127kW, 1543rpm, 573Nm')

Bat1_parallel300 = evalin('base','Bat1_parallel300')
set(handles.txt_OV_PT_nparallel,'String',num2str(Bat1_parallel300));
set(handles.txt_OV_PT_nserial,'String','95');
set(handles.txt_OV_PT_PInverter,'String','93');
set(handles.txt_OV_VehicleMassALL,'FontWeight','bold','ForegroundColor','k');
Mass_ALL = sprintf('%s',mass_ALL);
set(handles.txt_OV_VehicleMassALL_ed,'String',Mass_ALL,'FontWeight','bold','ForegroundColor','k');

%% Cost Estimation
Cost1B300 = evalin('base','Cost1B300');
Cost1Inverter300_1 = evalin('base','Cost1Inverter300_1');
Cost1Inverter300_2 = evalin('base','Cost1Inverter300_2');
Cost1Motor300_1 = evalin('base','Cost1Motor300_1');
Cost1Motor300_2 = evalin('base','Cost1Motor300_2');
Cost1Trans300_1 = evalin('base','Cost1Trans300_1');
Cost1Trans300_2 = evalin('base','Cost1Trans300_2');
Cost1All300 = evalin('base','Cost1All300');

% set(handles.txt_CE_Component,'Visible','on')
% set(handles.txt_CE_Per,'Visible','on')
% set(handles.txt_CE_NoC,'Visible','on')
% set(handles.txt_CE_Cost,'Visible','on')

% Running Rabbit for powertrain selection
rabbit = 100;
assignin('base','rabbit',rabbit)

%pie chart
Cost1Inverter300 = Cost1Inverter300_1+Cost1Inverter300_2;   % assignin('base','aaa',Cost1Inverter300)
Cost1Motor300 = Cost1Motor300_1+Cost1Motor300_2;
Cost1Trans300 = Cost1Trans300_1+Cost1Trans300_2; 
Percent_1B300 = round((Cost1B300/Cost1All300)*100*100)/100;
Percent_1Inv300 = round((Cost1Inverter300/Cost1All300)*100*100)/100;
Percent_1Mot300 = round((Cost1Motor300/Cost1All300)*100*100)/100;
Percent_1Trans300 = round((Cost1Trans300/Cost1All300)*100*100)/100;
axes(handles.ax_Powertrain2)
labels = {'','','',''};
pie([Cost1B300 Cost1Inverter300 Cost1Motor300 Cost1Trans300],labels) 
colormap(handles.ax_Powertrain2,[0 0.45 0.74;1 0 0;0.47 0.67 0.19;1 1 0])
set(handles.txt_CE_Color_Battery,'BackgroundColor',[0.22 0.48 0.69])
set(handles.txt_CE_Color_Inverter,'BackgroundColor',[1 0 0])
set(handles.txt_CE_Color_Motor,'BackgroundColor',[0.47 0.67 0.19])
set(handles.txt_CE_Color_Transmission,'BackgroundColor',[1 1 0])
set(handles.txt_CE_Component_Battery,'String','Battery')
set(handles.txt_CE_Component_Inverter,'String','Inverter')
set(handles.txt_CE_Component_Motor,'String','Motor')
set(handles.txt_CE_Component_Transmission,'String','Transmission')
set(handles.txt_CE_Per_Battery,'String',num2str(Percent_1B300))
set(handles.txt_CE_Per_Inverter,'String',num2str(Percent_1Inv300))
set(handles.txt_CE_Per_Motor,'String',num2str(Percent_1Mot300))
set(handles.txt_CE_Per_Transmission,'String',num2str(Percent_1Trans300))
set(handles.txt_CE_NoC_Battery,'String','1')
set(handles.txt_CE_NoC_Inverter,'String','2')
set(handles.txt_CE_NoC_Motor,'String','2')
set(handles.txt_CE_NoC_Transmission,'String','2')
set(handles.txt_CE_Cost_Battery,'String',num2str(Cost1B300))
set(handles.txt_CE_Cost_Inverter,'String',num2str(Cost1Inverter300))
set(handles.txt_CE_Cost_Motor,'String',num2str(Cost1Motor300))
set(handles.txt_CE_Cost_Transmission,'String',num2str(Cost1Trans300))


% --- Executes on button press in rb_PT_2.
function rb_PT_2_Callback(hObject, eventdata, handles)
% hObject    handle to rb_PT_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_PT_2
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

%% Pre-setting
set(handles.rb_PT_1,'Value',0.0);
set(handles.rb_PT_2,'Value',1.0);
set(handles.rb_PT_3,'Value',0.0);
set(handles.rb_PT_4,'Value',0.0);
set(handles.txt_Config_PT,'BackgroundColor',[0.06 0.66 0.53])
mass_ALL = evalin('base','mass_ALL');

%% Powertrain Overview
axes(handles.ax_Powertrain1)
imshow('2Motor.jpg')

set(handles.txt_OV_PT_Motor,'String','Motor: Horlbeck PSM, 127kW, 1543rpm, 573Nm')

Bat1_parallel400 = evalin('base','Bat1_parallel400')
set(handles.txt_OV_PT_nparallel,'String',num2str(Bat1_parallel400));
set(handles.txt_OV_PT_nserial,'String','95')
set(handles.txt_OV_PT_PInverter,'String','93')
set(handles.txt_OV_VehicleMassALL,'FontWeight','bold','ForegroundColor','k');
Mass_ALL = sprintf('%s',mass_ALL);
set(handles.txt_OV_VehicleMassALL_ed,'String',Mass_ALL,'FontWeight','bold','ForegroundColor','k');

%% Cost Estimation
Cost1B400 = evalin('base','Cost1B400');
Cost1Inverter400_1 = evalin('base','Cost1Inverter400_1');
Cost1Inverter400_2 = evalin('base','Cost1Inverter400_2');
Cost1Motor400_1 = evalin('base','Cost1Motor400_1');
Cost1Motor400_2 = evalin('base','Cost1Motor400_2');
Cost1Trans400_1 = evalin('base','Cost1Trans400_1');
Cost1Trans400_2 = evalin('base','Cost1Trans400_2');
Cost1All400 = evalin('base','Cost1All400');

% set(handles.txt_CE_Component,'Visible','on')
% set(handles.txt_CE_Per,'Visible','on')
% set(handles.txt_CE_NoC,'Visible','on')
% set(handles.txt_CE_Cost,'Visible','on')

% Running Rabbit
rabbit = 101;
assignin('base','rabbit',rabbit)

%pie chart
Cost1Inverter400 = Cost1Inverter400_1+Cost1Inverter400_2;   % assignin('base','aaa',Cost1Inverter300)
Cost1Motor400 = Cost1Motor400_1+Cost1Motor400_2;
Cost1Trans400 = Cost1Trans400_1+Cost1Trans400_2; 
Percent_1B400 = round((Cost1B400/Cost1All400)*100*100)/100;
Percent_1Inv400 = round((Cost1Inverter400/Cost1All400)*100*100)/100;
Percent_1Mot400 = round((Cost1Motor400/Cost1All400)*100*100)/100;
Percent_1Trans400 = round((Cost1Trans400/Cost1All400)*100*100)/100;
axes(handles.ax_Powertrain2)

labels = {'','','',''};
pie([Cost1B400 Cost1Inverter400 Cost1Motor400 Cost1Trans400],labels) 
colormap(handles.ax_Powertrain2,[0 0.45 0.74;1 0 0;0.47 0.67 0.19;1 1 0])
set(handles.txt_CE_Color_Battery,'BackgroundColor',[0.22 0.48 0.69])
set(handles.txt_CE_Color_Inverter,'BackgroundColor',[1 0 0])
set(handles.txt_CE_Color_Motor,'BackgroundColor',[0.47 0.67 0.19])
set(handles.txt_CE_Color_Transmission,'BackgroundColor',[1 1 0])
set(handles.txt_CE_Component_Battery,'String','Battery')
set(handles.txt_CE_Component_Inverter,'String','Inverter')
set(handles.txt_CE_Component_Motor,'String','Motor')
set(handles.txt_CE_Component_Transmission,'String','Transmission')
set(handles.txt_CE_Per_Battery,'String',num2str(Percent_1B400))
set(handles.txt_CE_Per_Inverter,'String',num2str(Percent_1Inv400))
set(handles.txt_CE_Per_Motor,'String',num2str(Percent_1Mot400))
set(handles.txt_CE_Per_Transmission,'String',num2str(Percent_1Trans400))
set(handles.txt_CE_NoC_Battery,'String','1')
set(handles.txt_CE_NoC_Inverter,'String','2')
set(handles.txt_CE_NoC_Motor,'String','2')
set(handles.txt_CE_NoC_Transmission,'String','2')
set(handles.txt_CE_Cost_Battery,'String',num2str(Cost1B400))
set(handles.txt_CE_Cost_Inverter,'String',num2str(Cost1Inverter400))
set(handles.txt_CE_Cost_Motor,'String',num2str(Cost1Motor400))
set(handles.txt_CE_Cost_Transmission,'String',num2str(Cost1Trans400))


% --- Executes on button press in rb_PT_3.
function rb_PT_3_Callback(hObject, eventdata, handles)
% hObject    handle to rb_PT_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_PT_3
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

%% Pre-setting
set(handles.rb_PT_1,'Value',0.0);
set(handles.rb_PT_2,'Value',0.0);
set(handles.rb_PT_3,'Value',1.0);
set(handles.rb_PT_4,'Value',0.0);
set(handles.txt_Config_PT,'BackgroundColor',[0.06 0.66 0.53])
mass_ALL = evalin('base','mass_ALL');

%% Powertrain Overview
axes(handles.ax_Powertrain1)
imshow('4Motor.jpg')

set(handles.txt_OV_PT_Motor,'String','Motor: Horlbeck PSM, 69kW, 3096rpm, 155Nm')

Bat2_parallel300 = evalin('base','Bat2_parallel300')
set(handles.txt_OV_PT_nparallel,'String',num2str(Bat2_parallel300));
set(handles.txt_OV_PT_nserial,'String','95')
set(handles.txt_OV_PT_PInverter,'String','50')
set(handles.txt_OV_VehicleMassALL,'FontWeight','bold','ForegroundColor','k');
Mass_ALL = sprintf('%s',mass_ALL);
set(handles.txt_OV_VehicleMassALL_ed,'String',Mass_ALL,'FontWeight','bold','ForegroundColor','k');

%% Cost Estimation
Cost2B300 = evalin('base','Cost2B300');
Cost2Inverter300_1 = evalin('base','Cost2Inverter300_1');
Cost2Inverter300_2 = evalin('base','Cost2Inverter300_2');
Cost2Inverter300_3 = evalin('base','Cost2Inverter300_3');
Cost2Inverter300_4 = evalin('base','Cost2Inverter300_4');
Cost2Motor300_1 = evalin('base','Cost2Motor300_1');
Cost2Motor300_2 = evalin('base','Cost2Motor300_1');
Cost2Motor300_3 = evalin('base','Cost2Motor300_1');
Cost2Motor300_4 = evalin('base','Cost2Motor300_1');
Cost2Trans300_1 = evalin('base','Cost2Trans300_1');
Cost2Trans300_2 = evalin('base','Cost2Trans300_1');
Cost2Trans300_3 = evalin('base','Cost2Trans300_1');
Cost2Trans300_4 = evalin('base','Cost2Trans300_1');
Cost2All300 = evalin('base','Cost2All300');

% set(handles.txt_CE_Component,'Visible','on')
% set(handles.txt_CE_Per,'Visible','on')
% set(handles.txt_CE_NoC,'Visible','on')
% set(handles.txt_CE_Cost,'Visible','on')

% Running Rabbit
rabbit = 102;
assignin('base','rabbit',rabbit)

%pie chart
Cost2Inverter300 = Cost2Inverter300_1+Cost2Inverter300_2+Cost2Inverter300_3+Cost2Inverter300_4;   
Cost2Motor300 = Cost2Motor300_1+Cost2Motor300_2+Cost2Motor300_3+Cost2Motor300_4;
Cost2Trans300 = Cost2Trans300_1+Cost2Trans300_2+Cost2Trans300_3+Cost2Trans300_4; 
Percent_2B300 = round((Cost2B300/Cost2All300)*100*100)/100;
Percent_2Inv300 = round((Cost2Inverter300/Cost2All300)*100*100)/100;
Percent_2Mot300 = round((Cost2Motor300/Cost2All300)*100*100)/100;
Percent_2Trans300 = round((Cost2Trans300/Cost2All300)*100*100)/100;
axes(handles.ax_Powertrain2)

labels = {'','','',''};
pie([Cost2B300 Cost2Inverter300 Cost2Motor300 Cost2Trans300],labels) 
colormap(handles.ax_Powertrain2,[0 0.45 0.74;1 0 0;0.47 0.67 0.19;1 1 0])
set(handles.txt_CE_Color_Battery,'BackgroundColor',[0.22 0.48 0.69])
set(handles.txt_CE_Color_Inverter,'BackgroundColor',[1 0 0])
set(handles.txt_CE_Color_Motor,'BackgroundColor',[0.47 0.67 0.19])
set(handles.txt_CE_Color_Transmission,'BackgroundColor',[1 1 0])
set(handles.txt_CE_Component_Battery,'String','Battery')
set(handles.txt_CE_Component_Inverter,'String','Inverter')
set(handles.txt_CE_Component_Motor,'String','Motor')
set(handles.txt_CE_Component_Transmission,'String','Transmission')
set(handles.txt_CE_Per_Battery,'String',num2str(Percent_2B300))
set(handles.txt_CE_Per_Inverter,'String',num2str(Percent_2Inv300))
set(handles.txt_CE_Per_Motor,'String',num2str(Percent_2Mot300))
set(handles.txt_CE_Per_Transmission,'String',num2str(Percent_2Trans300))
set(handles.txt_CE_NoC_Battery,'String','1')
set(handles.txt_CE_NoC_Inverter,'String','4')
set(handles.txt_CE_NoC_Motor,'String','4')
set(handles.txt_CE_NoC_Transmission,'String','4')
set(handles.txt_CE_Cost_Battery,'String',num2str(Cost2B300))
set(handles.txt_CE_Cost_Inverter,'String',num2str(Cost2Inverter300))
set(handles.txt_CE_Cost_Motor,'String',num2str(Cost2Motor300))
set(handles.txt_CE_Cost_Transmission,'String',num2str(Cost2Trans300))


% --- Executes on button press in rb_PT_4.
function rb_PT_4_Callback(hObject, eventdata, handles)
% hObject    handle to rb_PT_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_PT_4
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

%% Pre-setting
set(handles.rb_PT_1,'Value',0.0);
set(handles.rb_PT_2,'Value',0.0);
set(handles.rb_PT_3,'Value',0.0);
set(handles.rb_PT_4,'Value',1.0);
set(handles.txt_Config_PT,'BackgroundColor',[0.06 0.66 0.53])
mass_ALL = evalin('base','mass_ALL');

%% Powertrain Overview
axes(handles.ax_Powertrain1)
imshow('4Motor.jpg')

set(handles.txt_OV_PT_Motor,'String','Motor: Horlbeck PSM, 69kW, 3096rpm, 155Nm')

Bat2_parallel400 = evalin('base','Bat2_parallel400')
set(handles.txt_OV_PT_nparallel,'String',num2str(Bat2_parallel400));
set(handles.txt_OV_PT_nserial,'String','95')
set(handles.txt_OV_PT_PInverter,'String','50')
set(handles.txt_OV_VehicleMassALL,'FontWeight','bold','ForegroundColor','k');
Mass_ALL = sprintf('%s',mass_ALL);
set(handles.txt_OV_VehicleMassALL_ed,'String',Mass_ALL,'FontWeight','bold','ForegroundColor','k');

%% Cost Estimation
Cost2B400 = evalin('base','Cost2B400');
Cost2Inverter400_1 = evalin('base','Cost2Inverter400_1');
Cost2Inverter400_2 = evalin('base','Cost2Inverter400_2');
Cost2Inverter400_3 = evalin('base','Cost2Inverter400_3');
Cost2Inverter400_4 = evalin('base','Cost2Inverter400_4');
Cost2Motor400_1 = evalin('base','Cost2Motor400_1');
Cost2Motor400_2 = evalin('base','Cost2Motor400_1');
Cost2Motor400_3 = evalin('base','Cost2Motor400_1');
Cost2Motor400_4 = evalin('base','Cost2Motor400_1');
Cost2Trans400_1 = evalin('base','Cost2Trans400_1');
Cost2Trans400_2 = evalin('base','Cost2Trans400_1');
Cost2Trans400_3 = evalin('base','Cost2Trans400_1');
Cost2Trans400_4 = evalin('base','Cost2Trans400_1');
Cost2All400 = evalin('base','Cost2All400');

% set(handles.txt_CE_Component,'Visible','on')
% set(handles.txt_CE_Per,'Visible','on')
% set(handles.txt_CE_NoC,'Visible','on')
% set(handles.txt_CE_Cost,'Visible','on')

% Running Rabbit
rabbit = 103;
assignin('base','rabbit',rabbit)

%pie chart
Cost2Inverter400 = Cost2Inverter400_1+Cost2Inverter400_2+Cost2Inverter400_3+Cost2Inverter400_4;   
Cost2Motor400 = Cost2Motor400_1+Cost2Motor400_2+Cost2Motor400_3+Cost2Motor400_4;
Cost2Trans400 = Cost2Trans400_1+Cost2Trans400_2+Cost2Trans400_3+Cost2Trans400_4; 
Percent_2B400 = round((Cost2B400/Cost2All400)*100*100)/100;
Percent_2Inv400 = round((Cost2Inverter400/Cost2All400)*100*100)/100;
Percent_2Mot400 = round((Cost2Motor400/Cost2All400)*100*100)/100;
Percent_2Trans400 = round((Cost2Trans400/Cost2All400)*100*100)/100;
axes(handles.ax_Powertrain2)

labels = {'','','',''};
pie(handles.ax_Powertrain2,[Cost2B400 Cost2Inverter400 Cost2Motor400 Cost2Trans400],labels) 
colormap(handles.ax_Powertrain2,[0 0.45 0.74;1 0 0;0.47 0.67 0.19;1 1 0])
set(handles.txt_CE_Color_Battery,'BackgroundColor',[0.22 0.48 0.69])
set(handles.txt_CE_Color_Inverter,'BackgroundColor',[1 0 0])
set(handles.txt_CE_Color_Motor,'BackgroundColor',[0.47 0.67 0.19])
set(handles.txt_CE_Color_Transmission,'BackgroundColor',[1 1 0])
set(handles.txt_CE_Component_Battery,'String','Battery')
set(handles.txt_CE_Component_Inverter,'String','Inverter')
set(handles.txt_CE_Component_Motor,'String','Motor')
set(handles.txt_CE_Component_Transmission,'String','Transmission')
set(handles.txt_CE_Per_Battery,'String',num2str(Percent_2B400))
set(handles.txt_CE_Per_Inverter,'String',num2str(Percent_2Inv400))
set(handles.txt_CE_Per_Motor,'String',num2str(Percent_2Mot400))
set(handles.txt_CE_Per_Transmission,'String',num2str(Percent_2Trans400))
set(handles.txt_CE_NoC_Battery,'String','1')
set(handles.txt_CE_NoC_Inverter,'String','4')
set(handles.txt_CE_NoC_Motor,'String','4')
set(handles.txt_CE_NoC_Transmission,'String','4')
set(handles.txt_CE_Cost_Battery,'String',num2str(Cost2B400))
set(handles.txt_CE_Cost_Inverter,'String',num2str(Cost2Inverter400))
set(handles.txt_CE_Cost_Motor,'String',num2str(Cost2Motor400))
set(handles.txt_CE_Cost_Transmission,'String',num2str(Cost2Trans400))

% --- Executes on button press in rb_Ch_Database_standard.
function rb_Ch_Database_standard_Callback(hObject, eventdata, handles)
% hObject    handle to rb_Ch_Database_standard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_Ch_Database_standard
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

%% not relevant

set(handles.pb_Ch_Database,'Enable','off');
set(handles.pb_Ch_UpdateDatabase,'Enable','off');
set(handles.txt_Ch_Enter,'Enable','off');
set(handles.ed_Ch_EnterDatabase,'Enable','off');
set(handles.pb_Ch_Continue,'Enable','off');
set(handles.pm_DatabaseComponents,'Enable','off');

% --- Executes on button press in rb_Ch_Database_Addelete.
function rb_Ch_Database_Addelete_Callback(hObject, eventdata, handles)
% hObject    handle to rb_Ch_Database_Addelete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_Ch_Database_Addelete
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

%% not relevant

set(handles.pb_Ch_Database,'Enable','on');
set(handles.pb_Ch_UpdateDatabase,'Enable','on');
set(handles.txt_Ch_Enter,'Enable','off');
set(handles.ed_Ch_EnterDatabase,'Enable','off');
set(handles.pb_Ch_Continue,'Enable','off');
set(handles.pm_DatabaseComponents,'Enable','off');

% --- Executes on button press in rb_Ch_Database_Add_FromMatlab.
function rb_Ch_Database_Add_FromMatlab_Callback(hObject, eventdata, handles)
% hObject    handle to rb_Ch_Database_Add_FromMatlab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_Ch_Database_Add_FromMatlab
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

%% not relevant

set(handles.pb_Ch_Database,'Enable','off');
set(handles.pb_Ch_UpdateDatabase,'Enable','off');
set(handles.txt_Ch_Enter,'Enable','on');
set(handles.ed_Ch_EnterDatabase,'Enable','on');
set(handles.pb_Ch_Continue,'Enable','on');
set(handles.pm_DatabaseComponents,'Enable','on');

% --- Executes on button press in pb_mbs.
function pb_mbs_Callback(hObject, eventdata, handles)
% hObject    handle to pb_mbs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_Ch_Sizing.
function pb_Ch_Sizing_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Ch_Sizing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

llen = evalin('base','llen');
wb = evalin('base','wb');
mass = evalin('base','mass');
NoP = evalin('base','NoP');

%initialisation
l_overall = double(llen);
w_overall = 2700;
h_overall = 3100; 
vehicle_mass = double(mass);
number_person = NoP;
wb = double(wb);

assignin('base','l_overall',l_overall)
assignin('base','w_overall',w_overall)
assignin('base','h_overall',h_overall)
assignin('base','vehicle_mass',vehicle_mass)
assignin('base','number_person',number_person)
assignin('base','wb',wb)

mbs_exe = get(handles.pb_mbs,'Value'); % check if MBS is required

if isempty(l_overall) || isempty(w_overall) || isempty(h_overall)...
        || isempty(wb) || isempty(vehicle_mass) || isempty(number_person)
    h = warndlg('Please enter all required fields');
else
    %close(GUI_Component_Selection_Database);
    [AirSuspension_selection,Tyre_selection,Brake_selection,l_overall,w_overall,...
        h_overall,wb,vehicle_mass,number_person] = Chassis(l_overall,w_overall,h_overall,wb,vehicle_mass,number_person)
    
    assignin('base','AirSuspension_selection',AirSuspension_selection)
    assignin('base','Tyre_selection',Tyre_selection)
    assignin('base','Brake_selection',Brake_selection)
       
    % Write parameter values in txt file
    UpdateParameters_DB(AirSuspension_selection,Tyre_selection,Brake_selection,...
        l_overall,w_overall,h_overall,wb,mbs_exe);
     
end

    set(handles.txt_Config_CH,'BackgroundColor',[0.06 0.66 0.53])


% --- Executes on button press in pb_HVAC_cabineTemp.
function pb_HVAC_cabineTemp_Callback(hObject, eventdata, handles)
% hObject    handle to pb_HVAC_cabineTemp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

Temp_cabine = evalin('base','Temp_cabine');

if (handles.tb_HVAC_Eva_1core.Value == true || handles.tb_HVAC_Eva_2core.Value == true)...
        && (handles.tb_HVAC_Cond_1core.Value == true || handles.tb_HVAC_Cond_2core.Value == true)...
        && (handles.tb_HVAC_Rad_1Ch.Value == true || handles.tb_HVAC_Rad_2Ch.Value == true...
        || handles.tb_HVAC_Rad_3Ch.Value == true) && (handles.pb_HVAC_Energy.Value == true)

    txtTemp = sprintf('%.5s°C',num2str(Temp_cabine));
    set(handles.txt_OV_HVAC_temp,'String',txtTemp,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_Config_HVAC,'BackgroundColor',[0.06 0.66 0.53])
    Cooling = 1;
    assignin('base','Cooling',Cooling)
    
else if (handles.tb_HVAC_Eva_1core.Value == true || handles.tb_HVAC_Eva_2core.Value == true)...
            && (handles.tb_HVAC_Cond_1core.Value == true || handles.tb_HVAC_Cond_2core.Value == true)...
            && (handles.tb_HVAC_Rad_1Ch.Value == true || handles.tb_HVAC_Rad_2Ch.Value == true...
            || handles.tb_HVAC_Rad_3Ch.Value == true)
    
    txtTemp = sprintf('%.5s°C',num2str(Temp_cabine));
    set(handles.txt_OV_HVAC_temp,'String',txtTemp,'FontWeight','bold','ForegroundColor','k');
    
    end    
end 

% --- Executes on button press in pb_HVAC_Energy.
function pb_HVAC_Energy_Callback(hObject, eventdata, handles)
% hObject    handle to pb_HVAC_Energy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

Energy_HVAC = evalin('base','Energy_HVAC');


if (handles.tb_HVAC_Eva_1core.Value == true || handles.tb_HVAC_Eva_2core.Value == true)...
        && (handles.tb_HVAC_Cond_1core.Value == true || handles.tb_HVAC_Cond_2core.Value == true)...
        && (handles.tb_HVAC_Rad_1Ch.Value == true || handles.tb_HVAC_Rad_2Ch.Value == true...
        || handles.tb_HVAC_Rad_3Ch.Value == true) && (handles.pb_HVAC_cabineTemp.Value == true)

    txtEn = sprintf('%.5skW',num2str(Energy_HVAC));
    set(handles.txt_OV_HVAC_energy,'String',txtEn,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_Config_HVAC,'BackgroundColor',[0.06 0.66 0.53])
    Cooling = 1;
    assignin('base','Cooling',Cooling)

else if (handles.tb_HVAC_Eva_1core.Value == true || handles.tb_HVAC_Eva_2core.Value == true)...
            && (handles.tb_HVAC_Cond_1core.Value == true || handles.tb_HVAC_Cond_2core.Value == true)...
            && (handles.tb_HVAC_Rad_1Ch.Value == true || handles.tb_HVAC_Rad_2Ch.Value == true...
            || handles.tb_HVAC_Rad_3Ch.Value == true)
    
    txtEn = sprintf('%.5skW',num2str(Energy_HVAC));
    set(handles.txt_OV_HVAC_energy,'String',txtEn,'FontWeight','bold','ForegroundColor','k');
      
    end 
end  


% --- Executes on button press in tb_HVAC_Rad_1Ch.
function tb_HVAC_Rad_1Ch_Callback(hObject, eventdata, handles)
% hObject    handle to tb_HVAC_Rad_1Ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

syms l_rad1 w_rad1 h_rad1

%% Dimension of Radiator 1 Channel
l_column_rad1 = 35;         % Length Radiator 1 Channel
w_column_rad1 = 36;         % Width Radiator 1 Channel
h_column_rad1 = 37;         % Height Radiator 1 Channel

NoP = evalin('base','NoP');
HVAC_Data = evalin('base','HVAC_Data');

%% Radiator 1 Channel Selection from Database

if handles.tb_Coach.Value == true 
    
    rowpt=3;
        
else if handles.tb_Citybus.Value == true && handles.tb_SA_2zones.Value == true
        
    rowpt=17;
    
else if handles.tb_Shuttlebus.Value == true && handles.tb_SA_2zones.Value == true
    
    rowpt=31;
    
else if (handles.tb_Shuttlebus.Value == true || handles.tb_Citybus.Value ==  true)...
            && handles.tb_SA_standing.Value == true
        
    rowpt=45;
    
          end
       end
    end
end
                   
    switch true
        
        case (NoP>=30 && NoP<34)
            
            row_pt = rowpt;
            
        case (NoP>=34 && NoP<38)
    
            row_pt = rowpt+1;
            
        case (NoP>=38 && NoP<42)
            
            row_pt = rowpt+2;
            
        case (NoP>=42 && NoP<46)
            
            row_pt = rowpt+3;
            
        case (NoP>=46 && NoP<50)
            
            row_pt = rowpt+4;
            
        case (NoP>=50 && NoP<54)
            
            row_pt = rowpt+5;
            
        case (NoP>=54 && NoP<58)
            
            row_pt = rowpt+6;
            
        case (NoP>=58 && NoP<62)
            
            row_pt = rowpt+7;
            
        case (NoP>=62 && NoP<66)
            
            row_pt = rowpt+8;
            
        case (NoP>=66 && NoP<70)
            
            row_pt = rowpt+9;
            
        otherwise
            
            row_pt = rowpt+10;
            
    end
    
l_rad1 = floor(cell2mat(HVAC_Data(row_pt,l_column_rad1)));      % length radiator n [mm]
w_rad1 = floor(cell2mat(HVAC_Data(row_pt,w_column_rad1)));      % width radiator in [mm]
h_rad1 = floor(cell2mat(HVAC_Data(row_pt,h_column_rad1)));      % height radiator in [mm]

assignin('base','l_rad1',l_rad1);
assignin('base','w_rad1',w_rad1);
assignin('base','h_rad1',h_rad1);

% --- Executes on button press in tb_HVAC_Rad_2Ch.
function tb_HVAC_Rad_2Ch_Callback(hObject, eventdata, handles)
% hObject    handle to tb_HVAC_Rad_2Ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

syms l_column_rad2 w_column_rad2 h_column_rad2 

%% Dimension of Radiator 2 Channel
l_column_rad2 = 39;         % Length Radiator 2 Channel
w_column_rad2 = 40;         % Width Radiator 2 Channel
h_column_rad2 = 41;         % Height Radiator 2 Channel

NoP = evalin('base','NoP');
HVAC_Data = evalin('base','HVAC_Data');

%% Radiator 2 Channel Selection from Database

if handles.tb_Coach.Value == true 
    
    rowpt=3;
        
else if handles.tb_Citybus.Value == true && handles.tb_SA_2zones.Value == true
        
    rowpt=17;
    
else if handles.tb_Shuttlebus.Value == true && handles.tb_SA_2zones.Value == true
    
    rowpt=31;
    
else if (handles.tb_Shuttlebus.Value == true || handles.tb_Citybus.Value ==  true)...
            && handles.tb_SA_standing.Value == true
        
    rowpt=45;
    
          end
       end
    end
end
                   
    switch true
        
        case (NoP>=30 && NoP<34)
            
            row_pt = rowpt;
            
        case (NoP>=34 && NoP<38)
    
            row_pt = rowpt+1;
            
        case (NoP>=38 && NoP<42)
            
            row_pt = rowpt+2;
            
        case (NoP>=42 && NoP<46)
            
            row_pt = rowpt+3;
            
        case (NoP>=46 && NoP<50)
            
            row_pt = rowpt+4;
            
        case (NoP>=50 && NoP<54)
            
            row_pt = rowpt+5;
            
        case (NoP>=54 && NoP<58)
            
            row_pt = rowpt+6;
            
        case (NoP>=58 && NoP<62)
            
            row_pt = rowpt+7;
            
        case (NoP>=62 && NoP<66)
            
            row_pt = rowpt+8;
            
        case (NoP>=66 && NoP<70)
            
            row_pt = rowpt+9;
            
        otherwise
            
            row_pt = rowpt+10;
            
    end
    
l_rad2 = floor(cell2mat(HVAC_Data(row_pt,l_column_rad2)));
w_rad2 = floor(cell2mat(HVAC_Data(row_pt,w_column_rad2)));
h_rad2 = floor(cell2mat(HVAC_Data(row_pt,h_column_rad2)));

assignin('base','l_rad2',l_rad2);   % length in [mm]
assignin('base','w_rad2',w_rad2);   % width in [mm]
assignin('base','h_rad2',h_rad2);   % height in [mm]


% --- Executes on button press in pb_HVAC_Rad_sizing.
function pb_HVAC_Rad_sizing_Callback(hObject, eventdata, handles)
% hObject    handle to pb_HVAC_Rad_sizing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

% display in overview
NoP = evalin('base','NoP')

if handles.tb_HVAC_Rad_1Ch.Value == true && exist ('NoP')

    l_rad1 = evalin('base','l_rad1')
    w_rad1 = evalin('base','w_rad1')
    h_rad1 = evalin('base','h_rad1')
    
    txtRad = sprintf('%s x %s x %s',num2str(l_rad1),num2str(w_rad1),num2str(h_rad1));
    
    set(handles.txt_OV_HVAC_Rad_Ed,'String',txtRad,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_HVAC_Rad,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_HVAC_Rad_Ad,'String','1 Channel','FontWeight','bold','ForegroundColor','k');

else if handles.tb_HVAC_Rad_2Ch.Value == true && exist ('NoP')
        
    l_rad2 = evalin('base','l_rad2')
    w_rad2 = evalin('base','w_rad2')
    h_rad2 = evalin('base','h_rad2')
        
    txtRad = sprintf('%s x %s x %s',num2str(l_rad2),num2str(w_rad2),num2str(h_rad2));
    
    set(handles.txt_OV_HVAC_Rad_Ed,'String',txtRad,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_HVAC_Rad,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_HVAC_Rad_Ad,'String','2 Channel','FontWeight','bold','ForegroundColor','k');
    
else if handles.tb_HVAC_Rad_3Ch.Value == true && exist ('NoP')
    
    l_rad3 = evalin('base','l_rad3')
    w_rad3 = evalin('base','w_rad3')
    h_rad3 = evalin('base','h_rad3')    
        
    txtRad = sprintf('%s x %s x %s',num2str(l_rad3),num2str(w_rad3),num2str(h_rad3));
    
    set(handles.txt_OV_HVAC_Rad_Ed,'String',txtRad,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_HVAC_Rad,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_HVAC_Rad_Ad,'String','3 Channel','FontWeight','bold','ForegroundColor','k');    
       
        end
    end
end


% --- Executes on button press in tb_HVAC_Rad_3Ch.
function tb_HVAC_Rad_3Ch_Callback(hObject, eventdata, handles)
% hObject    handle to tb_HVAC_Rad_3Ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

syms l_rad3 w_rad3 h_rad3

%% Dimension of Radiator 3 Channel
l_column_rad3 = 43;         % Length Radiator 3 Channel
w_column_rad3 = 44;         % Width Radiator 3 Channel
h_column_rad3 = 45;         % Height Radiator 3 Channel

NoP = evalin('base','NoP');
HVAC_Data = evalin('base','HVAC_Data');

%% Radiator 3 Channel Selection from Database

if handles.tb_Coach.Value == true 
    
    rowpt=3;
        
else if handles.tb_Citybus.Value == true && handles.tb_SA_2zones.Value == true
        
    rowpt=17;
    
else if handles.tb_Shuttlebus.Value == true && handles.tb_SA_2zones.Value == true
    
    rowpt=31;
    
else if (handles.tb_Shuttlebus.Value == true || handles.tb_Citybus.Value ==  true)...
            && handles.tb_SA_standing.Value == true
        
    rowpt=45;
    
          end
       end
    end
end
                   
    switch true
        
        case (NoP>=30 && NoP<34)
            
            row_pt = rowpt;
            
        case (NoP>=34 && NoP<38)
    
            row_pt = rowpt+1;
            
        case (NoP>=38 && NoP<42)
            
            row_pt = rowpt+2;
            
        case (NoP>=42 && NoP<46)
            
            row_pt = rowpt+3;
            
        case (NoP>=46 && NoP<50)
            
            row_pt = rowpt+4;
            
        case (NoP>=50 && NoP<54)
            
            row_pt = rowpt+5;
            
        case (NoP>=54 && NoP<58)
            
            row_pt = rowpt+6;
            
        case (NoP>=58 && NoP<62)
            
            row_pt = rowpt+7;
            
        case (NoP>=62 && NoP<66)
            
            row_pt = rowpt+8;
            
        case (NoP>=66 && NoP<70)
            
            row_pt = rowpt+9;
            
        otherwise
            
            row_pt = rowpt+10;
            
    end
    
l_rad3 = floor(cell2mat(HVAC_Data(row_pt,l_column_rad3)));
w_rad3 = floor(cell2mat(HVAC_Data(row_pt,w_column_rad3)));
h_rad3 = floor(cell2mat(HVAC_Data(row_pt,h_column_rad3)));

assignin('base','l_rad3',l_rad3);
assignin('base','w_rad3',w_rad3);
assignin('base','h_rad3',h_rad3);

% --- Executes on button press in tb_HVAC_Cond_1core.
function tb_HVAC_Cond_1core_Callback(hObject, eventdata, handles)
% hObject    handle to tb_HVAC_Cond_1core (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

syms l_cond1 w_cond1 h_cond1

%% Dimension of Condenser 1 Core
l_column_cond1 = 19;         % Length Condenser 1 Core
w_column_cond1 = 20;         % Width Condenser 1 Core
h_column_cond1 = 21;         % Height Condenser 1 Core

NoP = evalin('base','NoP');
HVAC_Data = evalin('base','HVAC_Data');

%% Condenser 1 Core Selection from Database

if handles.tb_Coach.Value == true 
    
    rowpt=3;
        
else if handles.tb_Citybus.Value == true && handles.tb_SA_2zones.Value == true
        
    rowpt=17;
    
else if handles.tb_Shuttlebus.Value == true && handles.tb_SA_2zones.Value == true
    
    rowpt=31;
    
else if (handles.tb_Shuttlebus.Value == true || handles.tb_Citybus.Value ==  true)...
            && handles.tb_SA_standing.Value == true
        
    rowpt=45;
    
          end
       end
    end
end
                   
    switch true
        
        case (NoP>=30 && NoP<34)
            
            row_pt = rowpt;
            
        case (NoP>=34 && NoP<38)
    
            row_pt = rowpt+1;
            
        case (NoP>=38 && NoP<42)
            
            row_pt = rowpt+2;
            
        case (NoP>=42 && NoP<46)
            
            row_pt = rowpt+3;
            
        case (NoP>=46 && NoP<50)
            
            row_pt = rowpt+4;
            
        case (NoP>=50 && NoP<54)
            
            row_pt = rowpt+5;
            
        case (NoP>=54 && NoP<58)
            
            row_pt = rowpt+6;
            
        case (NoP>=58 && NoP<62)
            
            row_pt = rowpt+7;
            
        case (NoP>=62 && NoP<66)
            
            row_pt = rowpt+8;
            
        case (NoP>=66 && NoP<70)
            
            row_pt = rowpt+9;
            
        otherwise
            
            row_pt = rowpt+10;
            
    end
    
l_cond1 = floor(cell2mat(HVAC_Data(row_pt,l_column_cond1)));
w_cond1 = floor(cell2mat(HVAC_Data(row_pt,w_column_cond1)));
h_cond1 = floor(cell2mat(HVAC_Data(row_pt,h_column_cond1)));

assignin('base','l_cond1',l_cond1);
assignin('base','w_cond1',w_cond1);
assignin('base','h_cond1',h_cond1);


% --- Executes on button press in tb_HVAC_Cond_2core.
function tb_HVAC_Cond_2core_Callback(hObject, eventdata, handles)
% hObject    handle to tb_HVAC_Cond_2core (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

syms l_cond2 w_cond2 h_cond2

%% Dimension of Condenser 2 Core
l_column_cond2 = 23;         % Length Condenser 2 Core
w_column_cond2 = 24;         % Width Condenser 2 Core
h_column_cond2 = 25;         % Height Condenser 2 Core

NoP = evalin('base','NoP');
HVAC_Data = evalin('base','HVAC_Data');

%% Condenser 2 Core Selection from Database

if handles.tb_Coach.Value == true 
    
    rowpt=3;
        
else if handles.tb_Citybus.Value == true && handles.tb_SA_2zones.Value == true
        
    rowpt=17;
    
else if handles.tb_Shuttlebus.Value == true && handles.tb_SA_2zones.Value == true
    
    rowpt=31;
    
else if (handles.tb_Shuttlebus.Value == true || handles.tb_Citybus.Value ==  true)...
            && handles.tb_SA_standing.Value == true
        
    rowpt=45;
    
          end
       end
    end
end
                   
    switch true
        
        case (NoP>=30 && NoP<34)
            
            row_pt = rowpt;
            
        case (NoP>=34 && NoP<38)
    
            row_pt = rowpt+1;
            
        case (NoP>=38 && NoP<42)
            
            row_pt = rowpt+2;
            
        case (NoP>=42 && NoP<46)
            
            row_pt = rowpt+3;
            
        case (NoP>=46 && NoP<50)
            
            row_pt = rowpt+4;
            
        case (NoP>=50 && NoP<54)
            
            row_pt = rowpt+5;
            
        case (NoP>=54 && NoP<58)
            
            row_pt = rowpt+6;
            
        case (NoP>=58 && NoP<62)
            
            row_pt = rowpt+7;
            
        case (NoP>=62 && NoP<66)
            
            row_pt = rowpt+8;
            
        case (NoP>=66 && NoP<70)
            
            row_pt = rowpt+9;
            
        otherwise
            
            row_pt = rowpt+10;
            
    end
    
l_cond2 = floor(cell2mat(HVAC_Data(row_pt,l_column_cond2)));
w_cond2 = floor(cell2mat(HVAC_Data(row_pt,w_column_cond2)));
h_cond2 = floor(cell2mat(HVAC_Data(row_pt,h_column_cond2)));

assignin('base','l_cond2',l_cond2);     
assignin('base','w_cond2',w_cond2);
assignin('base','h_cond2',h_cond2);


% --- Executes on button press in pb_HVAC_Cond_sizing.
function pb_HVAC_Cond_sizing_Callback(hObject, eventdata, handles)
% hObject    handle to pb_HVAC_Cond_sizing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

% display in overview
NoP = evalin('base','NoP')

if handles.tb_HVAC_Cond_1core.Value == true && exist ('NoP')
    
    l_cond1 = evalin('base','l_cond1')
    w_cond1 = evalin('base','w_cond1')
    h_cond1 = evalin('base','h_cond1')
    
    txtCond = sprintf('%s x %s x %s',num2str(l_cond1),num2str(w_cond1),num2str(h_cond1));
    
    set(handles.txt_OV_HVAC_Cond_Ed,'String',txtCond,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_HVAC_Cond,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_HVAC_Cond_Ad,'String','1 Core','FontWeight','bold','ForegroundColor','k');
    
else if handles.tb_HVAC_Cond_2core.Value == true && exist ('NoP')
        
    l_cond2 = evalin('base','l_cond2')
    w_cond2 = evalin('base','w_cond2')
    h_cond2 = evalin('base','h_cond2')
    
    txtCond = sprintf('%s x %s x %s',num2str(l_cond2),num2str(w_cond2),num2str(h_cond2));
    
    set(handles.txt_OV_HVAC_Cond_Ed,'String',txtCond,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_HVAC_Cond,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_HVAC_Cond_Ad,'String','2 Core','FontWeight','bold','ForegroundColor','k');
   
    end
end


% --- Executes on button press in tb_HVAC_Eva_1core.
function tb_HVAC_Eva_1core_Callback(hObject, eventdata, handles)
% hObject    handle to tb_HVAC_Eva_1core (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

syms l_column_eva1 w_column_eva1 h_column_eva1 

%% Dimension of Evaporator 1 Core
l_column_eva1 = 27;         % Length Evpaorator 1 Core
w_column_eva1 = 28;         % Width Evaporator 1 Core
h_column_eva1 = 29;         % Height Evaporator 1 Core

NoP = evalin('base','NoP');
HVAC_Data = evalin('base','HVAC_Data');

%% Evaporator 1 Core Selection from Database

if handles.tb_Coach.Value == true 
    
    rowpt=3;
        
else if handles.tb_Citybus.Value == true && handles.tb_SA_2zones.Value == true
        
    rowpt=17;
    
else if handles.tb_Shuttlebus.Value == true && handles.tb_SA_2zones.Value == true
    
    rowpt=31;
    
else if (handles.tb_Shuttlebus.Value == true || handles.tb_Citybus.Value ==  true)...
            && handles.tb_SA_standing.Value == true
        
    rowpt=45;
    
          end
       end
    end
end
                   
    switch true
        
        case (NoP>=30 && NoP<34)
            
            row_pt = rowpt;
            
        case (NoP>=34 && NoP<38)
    
            row_pt = rowpt+1;
            
        case (NoP>=38 && NoP<42)
            
            row_pt = rowpt+2;
            
        case (NoP>=42 && NoP<46)
            
            row_pt = rowpt+3;
            
        case (NoP>=46 && NoP<50)
            
            row_pt = rowpt+4;
            
        case (NoP>=50 && NoP<54)
            
            row_pt = rowpt+5;
            
        case (NoP>=54 && NoP<58)
            
            row_pt = rowpt+6;
            
        case (NoP>=58 && NoP<62)
            
            row_pt = rowpt+7;
            
        case (NoP>=62 && NoP<66)
            
            row_pt = rowpt+8;
            
        case (NoP>=66 && NoP<70)
            
            row_pt = rowpt+9;
            
        otherwise
            
            row_pt = rowpt+10;
            
    end

l_eva1 = floor(cell2mat(HVAC_Data(row_pt,l_column_eva1)));
w_eva1 = floor(cell2mat(HVAC_Data(row_pt,w_column_eva1)));
h_eva1 = floor(cell2mat(HVAC_Data(row_pt,h_column_eva1)));
    
assignin('base','l_eva1',l_eva1);
assignin('base','w_eva1',w_eva1);
assignin('base','h_eva1',h_eva1);


% --- Executes on button press in tb_HVAC_Eva_2core.
function tb_HVAC_Eva_2core_Callback(hObject, eventdata, handles)
% hObject    handle to tb_HVAC_Eva_2core (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

syms l_column_eva2 w_column_eva2 h_column_eva2 

%% Dimension of Evaporator 2 Core
l_column_eva2 = 31;
w_column_eva2 = 32;
h_column_eva2 = 33;

NoP = evalin('base','NoP');
HVAC_Data = evalin('base','HVAC_Data');

%% Evaporator 1 Core Selection from Database
if handles.tb_Coach.Value == true 
    
    rowpt=3;
        
else if handles.tb_Citybus.Value == true && handles.tb_SA_2zones.Value == true
        
    rowpt=17;
    
else if handles.tb_Shuttlebus.Value == true && handles.tb_SA_2zones.Value == true
    
    rowpt=31;
    
else if (handles.tb_Shuttlebus.Value == true || handles.tb_Citybus.Value ==  true)...
            && handles.tb_SA_standing.Value == true
        
    rowpt=45;
    
          end
       end
    end
end
                   
    switch true
        
        case (NoP>=30 && NoP<34)
            
            row_pt = rowpt;
            
        case (NoP>=34 && NoP<38)
    
            row_pt = rowpt+1;
            
        case (NoP>=38 && NoP<42)
            
            row_pt = rowpt+2;
            
        case (NoP>=42 && NoP<46)
            
            row_pt = rowpt+3;
            
        case (NoP>=46 && NoP<50)
            
            row_pt = rowpt+4;
            
        case (NoP>=50 && NoP<54)
            
            row_pt = rowpt+5;
            
        case (NoP>=54 && NoP<58)
            
            row_pt = rowpt+6;
            
        case (NoP>=58 && NoP<62)
            
            row_pt = rowpt+7;
            
        case (NoP>=62 && NoP<66)
            
            row_pt = rowpt+8;
            
        case (NoP>=66 && NoP<70)
            
            row_pt = rowpt+9;
            
        otherwise
            
            row_pt = rowpt+10;
            
    end

    
l_eva2 = floor(cell2mat(HVAC_Data(row_pt,l_column_eva2)));
w_eva2 = floor(cell2mat(HVAC_Data(row_pt,w_column_eva2)));
h_eva2 = floor(cell2mat(HVAC_Data(row_pt,h_column_eva2)));
    
assignin('base','l_eva2',l_eva2);
assignin('base','w_eva2',w_eva2);
assignin('base','h_eva2',h_eva2);


% --- Executes on button press in pb_HVAC_Eva_sizing.
function pb_HVAC_Eva_sizing_Callback(hObject, eventdata, handles)
% hObject    handle to pb_HVAC_Eva_sizing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

% display in overview
NoP = evalin('base','NoP')

if handles.tb_HVAC_Eva_1core.Value == true && exist ('NoP')
    
    l_eva1 = evalin('base','l_eva1')
    w_eva1 = evalin('base','w_eva1')
    h_eva1 = evalin('base','h_eva1')
    
    txtEva = sprintf('%s x %s x %s',num2str(l_eva1),num2str(w_eva1),num2str(h_eva1));
    
    set(handles.txt_OV_HVAC_Eva_Ed,'String',txtEva,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_HVAC_Eva,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_HVAC_Eva_Ad,'String','1 Core','FontWeight','bold','ForegroundColor','k');
    
else if handles.tb_HVAC_Eva_2core.Value == true && exist ('NoP')
        
    l_eva2 = evalin('base','l_eva2')
    w_eva2 = evalin('base','w_eva2')
    h_eva2 = evalin('base','h_eva2')
    
    txtEva = sprintf('%s x %s x %s',num2str(l_eva2),num2str(w_eva2),num2str(h_eva2));
    
    set(handles.txt_OV_HVAC_Eva_Ed,'String',txtEva,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_HVAC_Eva,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_HVAC_Eva_Ad,'String','2 Core','FontWeight','bold','ForegroundColor','k');
   
    end
end


% --- Executes on button press in pb_OV_Powertrain.
function pb_OV_Powertrain_Callback(hObject, eventdata, handles)
% hObject    handle to pb_OV_Powertrain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

%% Page Callback
set(handles.uip_OV_Powertrain,'Visible','on');
set(handles.uip_OV_Chassis,'Visible','off');
set(handles.uip_OV_HVAC,'Visible','off');


% --- Executes on button press in pb_OV_Chassis.
function pb_OV_Chassis_Callback(hObject, eventdata, handles)
% hObject    handle to pb_OV_Chassis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

%% Page Callback
set(handles.uip_OV_Powertrain,'Visible','off');
set(handles.uip_OV_Chassis,'Visible','on');
set(handles.uip_OV_HVAC,'Visible','off');

% --- Executes on button press in pb_OV_HVAC.
function pb_OV_HVAC_Callback(hObject, eventdata, handles)
% hObject    handle to pb_OV_HVAC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

%% Page Callback
set(handles.uip_OV_Powertrain,'Visible','off');
set(handles.uip_OV_Chassis,'Visible','off');
set(handles.uip_OV_HVAC,'Visible','on');

% --- Executes on selection change in pm_OC_Ch.
function pm_OC_Ch_Callback(hObject, eventdata, handles)
% hObject    handle to pm_OC_Ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_OC_Ch contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_OC_Ch
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

%% chassis selection, display the sizing results in overview
contents=cellstr(get(hObject,'String'));
pop_choice=contents{get(hObject,'Value')};
pop_choice

AirSuspension_selection = evalin('base','AirSuspension_selection');
Brake_selection = evalin('base','Brake_selection');
Tyre_selection = evalin('base','Tyre_selection');

if(strcmp(pop_choice,'Air Suspension')) && handles.pb_Ch_Sizing.Value == true
    
    set(handles.txt_OV_Ch_1,'String','Design Height in inch','FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_Ch_1_ed,'String',AirSuspension_selection.design_height,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_Ch_2,'String','Maximum Diameter in inch','FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_Ch_2_ed,'String',AirSuspension_selection.max_diameter,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_Ch_3,'String','Vertical Spring Rate in ibs/inch','FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_Ch_3_ed,'String',AirSuspension_selection.Vertical_Spring_Rate,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_Ch_4,'String','Natural Frequency in Hz','FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_Ch_4_ed,'String',AirSuspension_selection.Natural_frequency,'FontWeight','bold','ForegroundColor','k');
    
else if (strcmp(pop_choice,'Brake')) && handles.pb_Ch_Sizing.Value == true
    
    set(handles.txt_OV_Ch_1,'String','Maximum Brake Torque in Nm','FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_Ch_1_ed,'String',Brake_selection.braking_torque,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_Ch_2,'String','Brake Disc Diameter in mm','FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_Ch_2_ed,'String',Brake_selection.disc_diameter,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_Ch_3,'String','Pad Surface Area in mm²','FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_Ch_3_ed,'String',Brake_selection.pad_surface_area,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_Ch_4,'String','Rim Size','FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_Ch_4_ed,'String',Brake_selection.rim_size,'FontWeight','bold','ForegroundColor','k');
    
else if (strcmp(pop_choice,'Tyre')) && handles.pb_Ch_Sizing.Value == true
        
    set(handles.txt_OV_Ch_1,'String','Nominal Width','FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_Ch_1_ed,'String',Tyre_selection.width,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_Ch_2,'String','Aspect Ratio','FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_Ch_2_ed,'String',Tyre_selection.aspect_ratio,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_Ch_3,'String','Construction','FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_Ch_3_ed,'String',Tyre_selection.construction,'FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_Ch_4,'String','Rim Size','FontWeight','bold','ForegroundColor','k');
    set(handles.txt_OV_Ch_4_ed,'String',Tyre_selection.rim_size,'FontWeight','bold','ForegroundColor','k');
    
        end
    end
end

% --- Executes during object creation, after setting all properties.
function pm_OC_Ch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_OC_Ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_Visualization.
function pb_Visualization_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Visualization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%
%%% Autoamted Mode %%%
%%%%%%%%%%%%%%%%%%%%%%

%% 2nd load session
% load all selections in this phase 


% load powertrain arrays
global path_base

currency_rabbit = 1;
assignin('base','currency_rabbit',currency_rabbit)

HVAC_Data = evalin('base','HVAC_Data');
row_pt = evalin('base','row_pt');
matfile_index = cell2mat(HVAC_Data(row_pt,136));
matfile_index = sprintf('%s.mat',num2str(matfile_index));    %Matfile

Cooling = evalin('base','Cooling');
VehicleSpecification = evalin('base','VehicleSpecification')

l_overall = evalin('base','l_overall')
NoP = evalin('base','NoP')
VS = evalin('base','VS')

set(handles.txt_CE_PT_VehicleSpec,'String',VS)
set(handles.txt_CE_PT_NoP,'String',num2str(NoP))
set(handles.txt_CE_PT_VehicleLength,'String',l_overall)

set(handles.txt_slider_PT_Length,'String',l_overall)
set(handles.txt_slider_PT_NoP,'String',NoP)
set(handles.slider_PT,'Value',l_overall)
set(handles.txt_CE_Chassis_VehicleLength,'String',l_overall)

rabbit = evalin('base','rabbit')        % Control Variable

if rabbit == 100
    
    Cost1B300 = evalin('base','Cost1B300');
    Cost1Inverter300_1 = evalin('base','Cost1Inverter300_1');
    Cost1Inverter300_2 = evalin('base','Cost1Inverter300_2');
    Cost1Motor300_1 = evalin('base','Cost1Motor300_1');
    Cost1Motor300_2 = evalin('base','Cost1Motor300_2');
    Cost1Trans300_1 = evalin('base','Cost1Trans300_1');
    Cost1Trans300_2 = evalin('base','Cost1Trans300_2');
    Cost1All300 = evalin('base','Cost1All300');

    set(handles.txt_slider_PT_Cost,'String',Cost1All300)
    set(handles.txt_slider_PT_Battery,'String',round((Cost1B300*100/Cost1All300)*100)/100)

    %Relevant Specification
    set(handles.txt_CE_PT_MotorAxle,'String','1 Motor')
    set(handles.txt_CE_PT_Motor,'String','Horlbeck PSM, 127kW, 1543rpm, 573Nm')
    set(handles.txt_TotalCostDrivetrain,'String',num2str(Cost1All300))
    set(handles.txt_slider_PT_Cost,'String',num2str(Cost1All300))
    
    %pie chart
    Cost1Inverter300 = Cost1Inverter300_1+Cost1Inverter300_2;   
    assignin('base','Cost1Inverter300',Cost1Inverter300)
    Cost1Motor300 = Cost1Motor300_1+Cost1Motor300_2;
    assignin('base','Cost1Motor300',Cost1Motor300)
    Cost1Trans300 = Cost1Trans300_1+Cost1Trans300_2;
    assignin('base','Cost1Trans300',Cost1Trans300)
    Percent_1B300 = round((Cost1B300/Cost1All300)*100*100)/100;
    Percent_1Inv300 = round((Cost1Inverter300/Cost1All300)*100*100)/100;
    Percent_1Mot300 = round((Cost1Motor300/Cost1All300)*100*100)/100;
    Percent_1Trans300 = round((Cost1Trans300/Cost1All300)*100*100)/100;
    axes(handles.ax_CE_PT_Drivetrain3)
    labels = {'','','',''};
    explode = [1 0 0 0];
    pie([Cost1B300 Cost1Inverter300 Cost1Motor300 Cost1Trans300],explode,labels) 
    colormap(handles.ax_CE_PT_Drivetrain3,[0 0.45 0.74;1 0 0;0.47 0.67 0.19;1 1 0])

    axes(handles.ax_CE_PT_Drivetrain4)
    labels = {'','','','','',''};
    % explode = [1 1 1 1 1 1];
    pie([Cost1Inverter300_1 Cost1Inverter300_2 Cost1Motor300_1 Cost1Motor300_2 Cost1Trans300_1 Cost1Trans300_2],labels)
    colormap(gca,[1 0 0;1 0 0;0.47 0.67 0.19;0.47 0.67 0.19;1 1 0;1 1 0])

    set(handles.txt_CE_Color_Battery,'BackgroundColor',[0.22 0.48 0.69])
    set(handles.txt_CE_Color_Inverter,'BackgroundColor',[1 0 0])
    set(handles.txt_CE_Color_Motor,'BackgroundColor',[0.47 0.67 0.19])
    set(handles.txt_CE_Color_Transmission,'BackgroundColor',[1 1 0])
    set(handles.txt_CE_Component_Battery,'String','Battery')
    set(handles.txt_CE_Component_Inverter,'String','Inverter')
    set(handles.txt_CE_Component_Motor,'String','Motor')
    set(handles.txt_CE_Component_Transmission,'String','Transmission')
    set(handles.txt_CE_Per_Battery,'String',num2str(Percent_1B300))
    set(handles.txt_CE_Per_Inverter,'String',num2str(Percent_1Inv300))
    set(handles.txt_CE_Per_Motor,'String',num2str(Percent_1Mot300))
    set(handles.txt_CE_Per_Transmission,'String',num2str(Percent_1Trans300))
    set(handles.txt_CE_NoC_Battery,'String','1')
    set(handles.txt_CE_NoC_Inverter,'String','2')
    set(handles.txt_CE_NoC_Motor,'String','2')
    set(handles.txt_CE_NoC_Transmission,'String','2')
    set(handles.txt_CE_Cost_Battery,'String',num2str(Cost1B300))
    set(handles.txt_CE_Cost_Inverter,'String',num2str(Cost1Inverter300))
    set(handles.txt_CE_Cost_Motor,'String',num2str(Cost1Motor300))
    set(handles.txt_CE_Cost_Transmission,'String',num2str(Cost1Trans300))
    
    % Cost Estimation Powertrain 1
    set(handles.txt_CE_Cost_Battery_1,'String',num2str(Cost1B300))
    set(handles.txt_CE_Cost_Inverter_1,'String',num2str(Cost1Inverter300))
    set(handles.txt_CE_Cost_Motor_1,'String',num2str(Cost1Motor300))
    set(handles.txt_CE_Cost_Transmission_1,'String',num2str(Cost1Trans300))
     
    % Cost Estimation Powertrain 3
    set(handles.txt_CE_Cost_Battery_2,'String',num2str(Cost1B300))
    set(handles.txt_CE_Cost_Inverter_2,'String',num2str(Cost1Inverter300))
    set(handles.txt_CE_Cost_Motor_2,'String',num2str(Cost1Motor300))
    set(handles.txt_CE_Cost_Transmission_2,'String',num2str(Cost1Trans300))

    c1 = Cost1Inverter300;      %Cost Inverter 
    c2 = Cost1Motor300;         %Cost Motor
    c3 = Cost1Trans300;         %Cost Transmission
    c4 = Cost1B300;             %Cost Battery
    
    % load Powertrain Database
    Powertrain_Data = load([path_base '13_Phi\01_EnergyConsumption\300km1Motor\' matfile_index]);

else if rabbit == 101
        
    Cost1B400 = evalin('base','Cost1B400');
    Cost1Inverter400_1 = evalin('base','Cost1Inverter400_1');
    Cost1Inverter400_2 = evalin('base','Cost1Inverter400_2');
    Cost1Motor400_1 = evalin('base','Cost1Motor400_1');
    Cost1Motor400_2 = evalin('base','Cost1Motor400_2');
    Cost1Trans400_1 = evalin('base','Cost1Trans400_1');
    Cost1Trans400_2 = evalin('base','Cost1Trans400_2');
    Cost1All400 = evalin('base','Cost1All400');
    
    %Relevant Specification
    set(handles.txt_CE_PT_MotorAxle,'String','1 Motor')
    set(handles.txt_CE_PT_Motor,'String','Horlbeck PSM, 127kW, 1543rpm, 573Nm')
    set(handles.txt_slider_PT_Cost,'String',num2str(Cost1All400))
    set(handles.txt_TotalCostDrivetrain,'String',num2str(Cost1All400))
    
    %pie chart
    Cost1Inverter400 = Cost1Inverter400_1+Cost1Inverter400_2;
    Cost1Motor400 = Cost1Motor400_1+Cost1Motor400_2;
    Cost1Trans400 = Cost1Trans400_1+Cost1Trans400_2; 
    Percent_1B400 = round((Cost1B400/Cost1All400)*100*100)/100;
    Percent_1Inv400 = round((Cost1Inverter400/Cost1All400)*100*100)/100;
    Percent_1Mot400 = round((Cost1Motor400/Cost1All400)*100*100)/100;
    Percent_1Trans400 = round((Cost1Trans400/Cost1All400)*100*100)/100;
    axes(handles.ax_CE_PT_Drivetrain3)

    labels = {'','','',''};
    pie([Cost1B400 Cost1Inverter400 Cost1Motor400 Cost1Trans400],labels) 
    colormap(gca,[0 0.45 0.74;1 0 0;0.47 0.67 0.19;1 1 0])
    
    axes(handles.ax_CE_PT_Drivetrain4)
    labels = {'','','','','',''};
    % explode = [1 1 1 1 1 1];
    pie([Cost1Inverter400_1 Cost1Inverter400_2 Cost1Motor400_1 Cost1Motor400_2 Cost1Trans400_1 Cost1Trans400_2],labels)
    colormap(gca,[1 0 0;1 0 0;0.47 0.67 0.19;0.47 0.67 0.19;1 1 0;1 1 0])
    
    set(handles.txt_CE_Color_Battery,'BackgroundColor',[0.22 0.48 0.69])
    set(handles.txt_CE_Color_Inverter,'BackgroundColor',[1 0 0])
    set(handles.txt_CE_Color_Motor,'BackgroundColor',[0.47 0.67 0.19])
    set(handles.txt_CE_Color_Transmission,'BackgroundColor',[1 1 0])
    set(handles.txt_CE_Component_Battery,'String','Battery')
    set(handles.txt_CE_Component_Inverter,'String','Inverter')
    set(handles.txt_CE_Component_Motor,'String','Motor')
    set(handles.txt_CE_Component_Transmission,'String','Transmission')
    set(handles.txt_CE_Per_Battery,'String',num2str(Percent_1B400))
    set(handles.txt_CE_Per_Inverter,'String',num2str(Percent_1Inv400))
    set(handles.txt_CE_Per_Motor,'String',num2str(Percent_1Mot400))
    set(handles.txt_CE_Per_Transmission,'String',num2str(Percent_1Trans400))
    set(handles.txt_CE_NoC_Battery,'String','1')
    set(handles.txt_CE_NoC_Inverter,'String','2')
    set(handles.txt_CE_NoC_Motor,'String','2')
    set(handles.txt_CE_NoC_Transmission,'String','2')
    set(handles.txt_CE_Cost_Battery,'String',num2str(Cost1B400))
    set(handles.txt_CE_Cost_Inverter,'String',num2str(Cost1Inverter400))
    set(handles.txt_CE_Cost_Motor,'String',num2str(Cost1Motor400))
    set(handles.txt_CE_Cost_Transmission,'String',num2str(Cost1Trans400))
    
    % Cost Estimation Powertrain 1
    set(handles.txt_CE_Cost_Battery_1,'String',num2str(Cost1B400))
    set(handles.txt_CE_Cost_Inverter_1,'String',num2str(Cost1Inverter400))
    set(handles.txt_CE_Cost_Motor_1,'String',num2str(Cost1Motor400))
    set(handles.txt_CE_Cost_Transmission_1,'String',num2str(Cost1Trans400))

    % Cost Estimation Powertrain 3
    set(handles.txt_CE_Cost_Battery_2,'String',num2str(Cost1B400))
    set(handles.txt_CE_Cost_Inverter_2,'String',num2str(Cost1Inverter400))
    set(handles.txt_CE_Cost_Motor_2,'String',num2str(Cost1Motor400))
    set(handles.txt_CE_Cost_Transmission_2,'String',num2str(Cost1Trans400))

    c1 = Cost1Inverter400;      %Cost Inverter 
    c2 = Cost1Motor400;         %Cost Motor
    c3 = Cost1Trans400;         %Cost Transmission
    c4 = Cost1B400;             %Cost Battery
    
    % load Powertrain Database
    Powertrain_Data = load([path_base '13_Phi\01_EnergyConsumption\400km1Motor\' matfile_index]);
    
else if rabbit == 102
            
    Cost2B300 = evalin('base','Cost2B300');
    Cost2Inverter300_1 = evalin('base','Cost2Inverter300_1');
    Cost2Inverter300_2 = evalin('base','Cost2Inverter300_2');
    Cost2Inverter300_3 = evalin('base','Cost2Inverter300_3');
    Cost2Inverter300_4 = evalin('base','Cost2Inverter300_4');
    Cost2Motor300_1 = evalin('base','Cost2Motor300_1');
    Cost2Motor300_2 = evalin('base','Cost2Motor300_1');
    Cost2Motor300_3 = evalin('base','Cost2Motor300_1');
    Cost2Motor300_4 = evalin('base','Cost2Motor300_1');
    Cost2Trans300_1 = evalin('base','Cost2Trans300_1');
    Cost2Trans300_2 = evalin('base','Cost2Trans300_1');
    Cost2Trans300_3 = evalin('base','Cost2Trans300_1');
    Cost2Trans300_4 = evalin('base','Cost2Trans300_1');
    Cost2All300 = evalin('base','Cost2All300');

    %Relevant Specification
    set(handles.txt_CE_PT_MotorAxle,'String','2 Motor')
    set(handles.txt_CE_PT_Motor,'String','Horlbeck PSM, 69kW, 3096rpm, 155Nm')
    set(handles.txt_slider_PT_Cost,'String',num2str(Cost2All300))
    set(handles.txt_TotalCostDrivetrain,'String',num2str(Cost2All300))
    
    %pie chart
    Cost2Inverter300 = Cost2Inverter300_1+Cost2Inverter300_2+Cost2Inverter300_3+Cost2Inverter300_4;   
    Cost2Motor300 = Cost2Motor300_1+Cost2Motor300_2+Cost2Motor300_3+Cost2Motor300_4;
    Cost2Trans300 = Cost2Trans300_1+Cost2Trans300_2+Cost2Trans300_3+Cost2Trans300_4; 
    Percent_2B300 = round((Cost2B300/Cost2All300)*100*100)/100;
    Percent_2Inv300 = round((Cost2Inverter300/Cost2All300)*100*100)/100;
    Percent_2Mot300 = round((Cost2Motor300/Cost2All300)*100*100)/100;
    Percent_2Trans300 = round((Cost2Trans300/Cost2All300)*100*100)/100;
    axes(handles.ax_CE_PT_Drivetrain3)

    labels = {'','','',''};
    pie([Cost2B300 Cost2Inverter300 Cost2Motor300 Cost2Trans300],labels) 
    colormap(gca,[0 0.45 0.74;1 0 0;0.47 0.67 0.19;1 1 0])
        
    axes(handles.ax_CE_PT_Drivetrain4)
    labels = {'','','','','','','','','','','',''};
    % explode = [1 1 1 1 1 1];
    pie([Cost2Inverter300_1 Cost2Inverter300_2 Cost2Inverter300_3 Cost2Inverter300_4 Cost2Motor300_1 Cost2Motor300_2 Cost2Motor300_3 Cost2Motor300_4 Cost2Trans300_1 Cost2Trans300_2 Cost2Trans300_3 Cost2Trans300_4],labels)
    colormap(gca,[1 0 0;1 0 0;1 0 0;1 0 0;0.47 0.67 0.19;0.47 0.67 0.19;0.47 0.67 0.19;0.47 0.67 0.19;1 1 0;1 1 0;1 1 0;1 1 0])
    
    set(handles.txt_CE_Color_Battery,'BackgroundColor',[0.22 0.48 0.69])
    set(handles.txt_CE_Color_Inverter,'BackgroundColor',[1 0 0])
    set(handles.txt_CE_Color_Motor,'BackgroundColor',[0.47 0.67 0.19])
    set(handles.txt_CE_Color_Transmission,'BackgroundColor',[1 1 0])
    set(handles.txt_CE_Component_Battery,'String','Battery')
    set(handles.txt_CE_Component_Inverter,'String','Inverter')
    set(handles.txt_CE_Component_Motor,'String','Motor')
    set(handles.txt_CE_Component_Transmission,'String','Transmission')
    set(handles.txt_CE_Per_Battery,'String',num2str(Percent_2B300))
    set(handles.txt_CE_Per_Inverter,'String',num2str(Percent_2Inv300))
    set(handles.txt_CE_Per_Motor,'String',num2str(Percent_2Mot300))
    set(handles.txt_CE_Per_Transmission,'String',num2str(Percent_2Trans300))
    set(handles.txt_CE_NoC_Battery,'String','1')
    set(handles.txt_CE_NoC_Inverter,'String','4')
    set(handles.txt_CE_NoC_Motor,'String','4')
    set(handles.txt_CE_NoC_Transmission,'String','4')
    set(handles.txt_CE_Cost_Battery,'String',num2str(Cost2B300))
    set(handles.txt_CE_Cost_Inverter,'String',num2str(Cost2Inverter300))
    set(handles.txt_CE_Cost_Motor,'String',num2str(Cost2Motor300))
    set(handles.txt_CE_Cost_Transmission,'String',num2str(Cost2Trans300))
    
     % Cost Estimation Powertrain 1
    set(handles.txt_CE_Cost_Battery_1,'String',num2str(Cost2B300))
    set(handles.txt_CE_Cost_Inverter_1,'String',num2str(Cost2Inverter300))
    set(handles.txt_CE_Cost_Motor_1,'String',num2str(Cost2Motor300))
    set(handles.txt_CE_Cost_Transmission_1,'String',num2str(Cost2Trans300))
    
    % Cost Estimation Powertrain 3
    set(handles.txt_CE_Cost_Battery_2,'String',num2str(Cost2B300))
    set(handles.txt_CE_Cost_Inverter_2,'String',num2str(Cost2Inverter300))
    set(handles.txt_CE_Cost_Motor_2,'String',num2str(Cost2Motor300))
    set(handles.txt_CE_Cost_Transmission_2,'String',num2str(Cost2Trans300))
   
    c1 = Cost2Inverter300;      %Cost Inverter 
    c2 = Cost2Motor300;         %Cost Motor
    c3 = Cost2Trans300;         %Cost Transmissionpb_CostEstimation
    c4 = Cost2B300;             %Cost Battery
    
    % load Powertrain Database
    Powertrain_Data = load([path_base '13_Phi\01_EnergyConsumption\300km2Motor\' matfile_index]);
    
else if rabbit == 103

    Cost2B400 = evalin('base','Cost2B400');
    Cost2Inverter400_1 = evalin('base','Cost2Inverter400_1');
    Cost2Inverter400_2 = evalin('base','Cost2Inverter400_2');
    Cost2Inverter400_3 = evalin('base','Cost2Inverter400_3');
    Cost2Inverter400_4 = evalin('base','Cost2Inverter400_4');
    Cost2Motor400_1 = evalin('base','Cost2Motor400_1');
    Cost2Motor400_2 = evalin('base','Cost2Motor400_1');
    Cost2Motor400_3 = evalin('base','Cost2Motor400_1');
    Cost2Motor400_4 = evalin('base','Cost2Motor400_1');
    Cost2Trans400_1 = evalin('base','Cost2Trans400_1');
    Cost2Trans400_2 = evalin('base','Cost2Trans400_1');
    Cost2Trans400_3 = evalin('base','Cost2Trans400_1');
    Cost2Trans400_4 = evalin('base','Cost2Trans400_1');
    Cost2All400 = evalin('base','Cost2All400');

    %Relevant Specification
    set(handles.txt_CE_PT_MotorAxle,'String','2 Motor')
    set(handles.txt_CE_PT_Motor,'String','Horlbeck PSM, 69kW, 3096rpm, 155Nm')
    set(handles.txt_slider_PT_Cost,'String',num2str(Cost2All400))
    set(handles.txt_TotalCostDrivetrain,'String',num2str(Cost2All400))
    
    %pie chart
    Cost2Inverter400 = Cost2Inverter400_1+Cost2Inverter400_2+Cost2Inverter400_3+Cost2Inverter400_4;   
    Cost2Motor400 = Cost2Motor400_1+Cost2Motor400_2+Cost2Motor400_3+Cost2Motor400_4;
    Cost2Trans400 = Cost2Trans400_1+Cost2Trans400_2+Cost2Trans400_3+Cost2Trans400_4; 
    Percent_2B400 = round((Cost2B400/Cost2All400)*100*100)/100;
    Percent_2Inv400 = round((Cost2Inverter400/Cost2All400)*100*100)/100;
    Percent_2Mot400 = round((Cost2Motor400/Cost2All400)*100*100)/100;
    Percent_2Trans400 = round((Cost2Trans400/Cost2All400)*100*100)/100;
    axes(handles.ax_CE_PT_Drivetrain3)
    labels = {'','','',''};
    pie([Cost2B400 Cost2Inverter400 Cost2Motor400 Cost2Trans400],labels) 
    colormap(gca,[0 0.45 0.74;1 0 0;0.47 0.67 0.19;1 1 0])
        
    axes(handles.ax_CE_PT_Drivetrain4)
    labels = {'','','','','','','','','','','',''};
    % explode = [1 1 1 1 1 1];
    pie([Cost2Inverter400_1 Cost2Inverter400_2 Cost2Inverter400_3 Cost2Inverter400_4 Cost2Motor400_1 Cost2Motor400_2 Cost2Motor400_3 Cost2Motor400_4 Cost2Trans400_1 Cost2Trans400_2 Cost2Trans400_3 Cost2Trans400_4],labels)
    colormap(gca,[1 0 0;1 0 0;1 0 0;1 0 0;0.47 0.67 0.19;0.47 0.67 0.19;0.47 0.67 0.19;0.47 0.67 0.19;1 1 0;1 1 0;1 1 0;1 1 0])
    
         
    set(handles.txt_CE_Color_Battery,'BackgroundColor',[0.22 0.48 0.69])
    set(handles.txt_CE_Color_Inverter,'BackgroundColor',[1 0 0])
    set(handles.txt_CE_Color_Motor,'BackgroundColor',[0.47 0.67 0.19])
    set(handles.txt_CE_Color_Transmission,'BackgroundColor',[1 1 0])
    set(handles.txt_CE_Component_Battery,'String','Battery')
    set(handles.txt_CE_Component_Inverter,'String','Inverter')
    set(handles.txt_CE_Component_Motor,'String','Motor')
    set(handles.txt_CE_Component_Transmission,'String','Transmission')
    set(handles.txt_CE_Per_Battery,'String',num2str(Percent_2B400))
    set(handles.txt_CE_Per_Inverter,'String',num2str(Percent_2Inv400))
    set(handles.txt_CE_Per_Motor,'String',num2str(Percent_2Mot400))
    set(handles.txt_CE_Per_Transmission,'String',num2str(Percent_2Trans400))
    set(handles.txt_CE_NoC_Battery,'String','1')
    set(handles.txt_CE_NoC_Inverter,'String','4')
    set(handles.txt_CE_NoC_Motor,'String','4')
    set(handles.txt_CE_NoC_Transmission,'String','4')
    set(handles.txt_CE_Cost_Battery,'String',num2str(Cost2B400))
    set(handles.txt_CE_Cost_Inverter,'String',num2str(Cost2Inverter400))
    set(handles.txt_CE_Cost_Motor,'String',num2str(Cost2Motor400))
    set(handles.txt_CE_Cost_Transmission,'String',num2str(Cost2Trans400))
    
     % Cost Estimation Powertrain 1
    set(handles.txt_CE_Cost_Battery_1,'String',num2str(Cost2B400))
    set(handles.txt_CE_Cost_Inverter_1,'String',num2str(Cost2Inverter400))
    set(handles.txt_CE_Cost_Motor_1,'String',num2str(Cost2Motor400))
    set(handles.txt_CE_Cost_Transmission_1,'String',num2str(Cost2Trans400))
    
    % Cost Estimation Powertrain 3
    set(handles.txt_CE_Cost_Battery_2,'String',num2str(Cost2B400))
    set(handles.txt_CE_Cost_Inverter_2,'String',num2str(Cost2Inverter400))
    set(handles.txt_CE_Cost_Motor_2,'String',num2str(Cost2Motor400))
    set(handles.txt_CE_Cost_Transmission_2,'String',num2str(Cost2Trans400))
    
    
    c1 = Cost2Inverter400;      %Cost Inverter 
    c2 = Cost2Motor400;         %Cost Motor
    c3 = Cost2Trans400;         %Cost Transmission
    c4 = Cost2B400;             %Cost Battery
    
    % load Powertrain Database
    Powertrain_Data = load([path_base '13_Phi\01_EnergyConsumption\400km2Motor\' matfile_index]);
            
            end
        end
    end
end

assignin('base','Powertrain_Data',Powertrain_Data)

assignin('base','c1',c1)
assignin('base','c2',c2)
assignin('base','c3',c3)
assignin('base','c4',c4)

HVAC_Data = evalin('base','HVAC_Data');
database_option = evalin('base','database_option');

%% Cost Estimatation

  if database_option == 1   %Coach
   
        a1 = 0.005405;              %NoP
        a2 = 1;                     %NoP 
        a3 = 1.162;                 %NoP
        a4 = cell2mat(HVAC_Data(3:13,1));     %NoP
        
   
      switch true
          
            case rabbit == 100    % 1Motor per Axle 300km             
                
                a = 0.004021;
                b = 1.7;
                c = 2.688e+04;
                d = Cost1All300; 
                YLimit = [30000 70000];
                YLimit_SGD = [60000 140000];
                YTickk = [30000:5000:70000];
                YTickk_SGD = [60000:10000:140000];
                YTick_Label = {'30000','35000','40000','45000','50000','55000','60000','65000','70000'};
                YTick_Label_SGD = {'60000','70000','80000','90000','100000','110000','120000','130000','140000'};
                
            case rabbit == 101      %1 Motor per Axle 400km
            
                a = 0.0005113;
                b = 1.957;
                c = 3.836e+04;
                d = Cost1All400;
                YLimit = [45000 93000];
                YLimit_SGD = [90000 186000];
                YTickk = [45000:6000:93000];
                YTickk_SGD = [90000:12000:186000];
                YTick_Label = {'45000','51000','57000','63000','69000','75000','81000','87000','93000'};
                YTick_Label_SGD = {'90000','102000','114000','126000','138000','150000','162000','174000','186000'};
                
            case rabbit == 102      %2 Motor per Axle 300km
            
                a = 0.0004392;
                b = 1.927;
                c = 2.909e+04;
                d = Cost2All300;
                YLimit = [30000 70000];
                YLimit_SGD = [60000 140000];
                YTickk = [30000:5000:70000];
                YTickk_SGD = [60000:10000:140000];
                YTick_Label = {'30000','35000','40000','45000','50000','55000','60000','65000','70000'};
                YTick_Label_SGD = {'60000','70000','80000','90000','100000','110000','120000','130000','140000'};
                
            case rabbit == 103      %2 Motor per Axle 400km

                a = 0.0004576;
                b = 1.96;
                c = 3.834e+04;
                d = Cost2All400;
                YLimit = [45000 93000];
                YLimit_SGD = [90000 186000];
                YTickk = [45000:6000:93000];
                YTickk_SGD = [90000:12000:186000];
                YTick_Label = {'45000','51000','57000','63000','69000','75000','81000','87000','93000'};
                YTick_Label_SGD = {'90000','102000','114000','126000','138000','150000','162000','174000','186000'};
                    
      end

      
  else if database_option == 2   %City Bus 2 Zone
          
        a1 = 0.007824;              %NoP
        a2 = 0.9994;                %NoP
        a3 = -11.78;                %NoP
        a4 = cell2mat(HVAC_Data(17:27,1));    %NoP
        
        switch true
          
            case rabbit == 100    % 1Motor per Axle 300km             
                
                a = 0.06054;
                b = 1.433;
                c = 2.243e+04;
                d = Cost1All300; 
                YLimit = [30000 70000];
                YLimit_SGD = [60000 140000];
                YTickk = [30000:5000:70000];
                YTickk_SGD = [60000:10000:140000];
                YTick_Label = {'30000','35000','40000','45000','50000','55000','60000','65000','70000'};
                YTick_Label_SGD = {'60000','70000','80000','90000','100000','110000','120000','130000','140000'};
                
            case rabbit == 101      %1 Motor per Axle 400km
            
                a = 0.0945;
                b = 1.427;
                c = 2.826e+04;
                d = Cost1All400;
                YLimit = [45000 85000];
                YLimit_SGD = [90000 170000];
                YTickk = [45000:5000:85000];
                YTickk_SGD = [90000:10000:170000];
                YTick_Label = {'45000','50000','55000','60000','65000','70000','75000','80000','85000'};
                YTick_Label_SGD = {'90000','100000','110000','120000','130000','140000','150000','160000','170000'};
                
            case rabbit == 102      %2 Motor per Axle 300km
            
                a = 0.3305;
                b = 1.253;
                c = 2e+04;
                d = Cost2All300;
                YLimit = [30000 70000];
                YLimit_SGD = [60000 140000];
                YTickk = [30000:5000:70000];
                YTickk_SGD = [60000:10000:140000];
                YTick_Label = {'30000','35000','40000','45000','50000','55000','60000','65000','70000'};
                YTick_Label_SGD = {'60000','70000','80000','90000','100000','110000','120000','130000','140000'};
                
            case rabbit == 103      %2 Motor per Axle 400km

                a = 0.5142;
                b = 1.242;
                c = 2.525e+04;
                d = Cost2All400;
                YLimit = [45000 85000];
                YLimit_SGD = [90000 170000];
                YTickk = [45000:5000:85000];
                YTickk_SGD = [90000:10000:170000];
                YTick_Label = {'45000','50000','55000','60000','65000','70000','75000','80000','85000'};
                YTick_Label_SGD = {'90000','100000','110000','120000','130000','140000','150000','160000','170000'};
                
      end
         
  
  else if database_option == 3   %Shuttle Bus 2 Zone
          
        a1 = 0.007784;              %NoP
        a2 = 0.9999;                %NoP
        a3 = -9.282;                %NoP
        a4 = cell2mat(HVAC_Data(31:41,1));    %NoP
        
        
        switch true
          
            case rabbit == 100    % 1Motor per Axle 300km             
                
                a = 0.2108;
                b = 1.308;
                c = 2.018e+04;
                d = Cost1All300; 
                YLimit = [30000 70000];
                YLimit_SGD = [60000 140000];
                YTickk = [30000:5000:70000];
                YTickk_SGD = [60000:10000:140000];
                YTick_Label = {'30000','35000','40000','45000','50000','55000','60000','65000','70000'};
                YTick_Label_SGD = {'60000','70000','80000','90000','100000','110000','120000','130000','140000'};
                
            case rabbit == 101      %1 Motor per Axle 400km
            
                a = 0.218;
                b = 1.342;
                c = 2.699e+04;
                d = Cost1All400;
                YLimit = [45000 85000];
                YLimit_SGD = [90000 170000];
                YTickk = [45000:5000:85000];
                YTickk_SGD = [90000:10000:170000];
                YTick_Label = {'45000','50000','55000','60000','65000','70000','75000','80000','85000'};
                YTick_Label_SGD = {'90000','100000','110000','120000','130000','140000','150000','160000','170000'};
                
            case rabbit == 102      %2 Motor per Axle 300km
            
                a = 0.282;
                b = 1.269;
                c = 2.108e+04;
                d = Cost2All300;
                YLimit = [30000 70000];
                YLimit_SGD = [60000 140000];
                YTickk = [30000:5000:70000];
                YTickk_SGD = [60000:10000:140000];
                YTick_Label = {'30000','35000','40000','45000','50000','55000','60000','65000','70000'};
                YTick_Label_SGD = {'60000','70000','80000','90000','100000','110000','120000','130000','140000'};
                
            case rabbit == 103      %2 Motor per Axle 400km

                a = 1.119;
                b = 1.164;
                c = 2.372e+04;
                d = Cost2All400;
                YLimit = [45000 85000];
                YLimit_SGD = [90000 170000];
                YTickk = [45000:5000:85000];
                YTickk_SGD = [90000:10000:170000];
                YTick_Label = {'45000','50000','55000','60000','65000','70000','75000','80000','85000'};
                YTick_Label_SGD = {'90000','100000','110000','120000','130000','140000','150000','160000','170000'};
                
      end
  
  else if database_option == 4   %Standing
          
        a1 = 0.007778;              %NoP
        a2 = 1;                     %NoP
        a3 = -7.763;                %NoP
        a4 = cell2mat(HVAC_Data(45:55,1));    %NoP
  
        switch true
          
            case rabbit == 100    % 1Motor per Axle 300km             
                
                a = 0.2727;
                b = 1.281;
                c = 2.043e+04;
                d = Cost1All300; 
                YLimit = [30000 70000];
                YLimit_SGD = [60000 140000];
                YTickk = [30000:5000:70000];
                YTickk_SGD = [60000:10000:140000];
                YTick_Label = {'30000','35000','40000','45000','50000','55000','60000','65000','70000'};
                YTick_Label_SGD = {'60000','70000','80000','90000','100000','110000','120000','130000','140000'};
                
            case rabbit == 101      %1 Motor per Axle 400km
            
                a = 0.2461;
                b = 1.33;
                c = 2.746e+04;
                d = Cost1All400;
                YLimit = [45000 85000];
                YLimit_SGD = [90000 170000];
                YTickk = [45000:5000:85000];
                YTickk_SGD = [90000:10000:170000];
                YTick_Label = {'45000','50000','55000','60000','65000','70000','75000','80000','85000'};
                YTick_Label_SGD = {'90000','100000','110000','120000','130000','140000','150000','160000','170000'};
                
            case rabbit == 102      %2 Motor per Axle 300km
            
                a = 0.3942;
                b = 1.235;
                c = 2.093e+04;
                d = Cost2All300;
                YLimit = [30000 70000];
                YLimit_SGD = [60000 140000];
                YTickk = [30000:5000:70000];
                YTickk_SGD = [60000:10000:140000];
                YTick_Label = {'30000','35000','40000','45000','50000','55000','60000','65000','70000'};
                YTick_Label_SGD = {'60000','70000','80000','90000','100000','110000','120000','130000','140000'};
                
            case rabbit == 103      %2 Motor per Axle 400km

                a = 3.067;
                b = 1.061;
                c = 2.112e+04;
                d = Cost2All400;
                YLimit = [45000 85000];
                YLimit_SGD = [90000 170000];
                YTickk = [45000:5000:85000];
                YTickk_SGD = [90000:10000:170000];
                YTick_Label = {'45000','50000','55000','60000','65000','70000','75000','80000','85000'};
                YTick_Label_SGD = {'90000','100000','110000','120000','130000','140000','150000','160000','170000'};
                
        end
       
                 end
           end
      end
  end
  
%   global a b c d a1 a2 a3 a4

assignin('base','a',a)
assignin('base','b',b)
assignin('base','c',c)
assignin('base','d',d)
assignin('base','a1',a1)
assignin('base','a2',a2)
assignin('base','a3',a3)
assignin('base','a4',a4)
assignin('base','YLimit',YLimit)
assignin('base','YTickk',YTickk)
assignin('base','YTick_Label',YTick_Label)
assignin('base','YLimit_SGD',YLimit_SGD)
assignin('base','YTickk_SGD',YTickk_SGD)
assignin('base','YTick_Label_SGD',YTick_Label_SGD)

%% Calculation of the plots
NoP_length = a1*a4.^a2+a3;        %NoP equation

axes(handles.ax_CE_PT_Drivetrain1)
yyaxis left
plot(a4,NoP_length,'Color',[0.22 0.48 0.69],'LineWidth',1)
set(gca,'YColor',[0.22 0.48 0.69],'YLim',[30 70],'YTick',[30:5:70],'XLim',[5000 13000],'XTick',[5000:1000:13000])
ylabel('Number of Passengers','Color',[0.22 0.48 0.69])
xlabel('Vehicle Length')
grid on
hold on
plot(l_overall,NoP,'ro','MarkerEdgeColor','r','MarkerFaceColor','r')

Cost_1_300 = a*a4.^b+c;           %Total Cost equation

yyaxis right
plot(a4,Cost_1_300,'Color',[0.06 0.66 0.53],'LineWidth',1)
set(gca,'YColor',[0.06 0.66 0.53],'YLim',YLimit,'YTick',YTickk,'YTickLabel',YTick_Label)
ylabel('Total Cost of Powertrain in €','Color',[0.06 0.66 0.53])
plot(l_overall,d,'ro','MarkerEdgeColor','r','MarkerFaceColor','r')

axes(handles.ax_CE_PT_Drivetrain2)
labels = {'','','',''};
explode = [1 0 0 0];
pie([c4 c1 c2 c3],explode,labels) 
colormap(handles.ax_CE_PT_Drivetrain2,[0 0.45 0.74;1 0 0;0.47 0.67 0.19;1 1 0])
set(handles.txt_slider_PT_Battery,'String',round((c4*100/d).*100)/100)

%Powertrain 3 c1 c2 c3 c4

ControlModules = 12529;     % Color 0.93 0.69 0.13
WireHarness = 1462;         % Color 1 0 1
Contactor = 628;            % Color 0 1 1

set(handles.txt_CE_Cost_ControlModules,'String',ControlModules)
set(handles.txt_CE_Cost_WireHarness,'String',WireHarness)
set(handles.txt_CE_Cost_Contactor,'String',Contactor)

axes(handles.ax_CE_PT_total1)
labels = {'','','','','','',''};
pie([c4 c1 c2 c3 ControlModules WireHarness Contactor],labels) 
colormap(handles.ax_CE_PT_total1,[0 0.45 0.74;1 0 0;0.47 0.67 0.19;1 1 0;0.93 0.69 0.13;1 0 1;0 1 1])   

set(handles.txt_CE_Color_ControlModules,'BackgroundColor',[0.93 0.69 0.13])
set(handles.txt_CE_Color_WireHarness,'BackgroundColor',[1 0 1])  
set(handles.txt_CE_Color_ContactorBox,'BackgroundColor',[0 1 1])

axes(handles.ax_CE_PT_total2)
Cost_Drivetrain = c1+c2+c3;
Cost_Electronics = ControlModules+WireHarness+Contactor 
labels = {'','',''};
pie([c4 Cost_Drivetrain Cost_Electronics],labels) 
colormap(handles.ax_CE_PT_total2,[0 0.45 0.74;0.47 0.67 0.19;0.93 0.69 0.13])   

TotalPowertrainCost = c4+Cost_Drivetrain+Cost_Electronics;
set(handles.txt_TotalCostPowertrain,'String',TotalPowertrainCost)
assignin('base','TotalPowertrainCost',TotalPowertrainCost)

%Percentage of Components Total
Percenet_Total_Battery = round((c4/TotalPowertrainCost)*100*100)/100;
Percenet_Total_Inverter = round((c1/TotalPowertrainCost)*100*100)/100;
Percenet_Total_Motor = round((c2/TotalPowertrainCost)*100*100)/100;
Percenet_Total_Transmission = round((c3/TotalPowertrainCost)*100*100)/100;
Percenet_Total_ControlModules = round((ControlModules/TotalPowertrainCost)*100*100)/100;
Percenet_Total_WireHarness = round((WireHarness/TotalPowertrainCost)*100*100)/100;
Percenet_Total_Contactor = round((Contactor/TotalPowertrainCost)*100*100)/100;
set(handles.txt_CE_Per_Battery_total,'String',Percenet_Total_Battery)
set(handles.txt_CE_Per_Inverter__total,'String',Percenet_Total_Inverter)
set(handles.txt_CE_Per_Motor_total,'String',Percenet_Total_Motor)
set(handles.txt_CE_Per_Transmission_total,'String',Percenet_Total_Transmission)
set(handles.txt_CE_Per_ContactModules_total,'String',Percenet_Total_ControlModules)
set(handles.txt_CE_Per_WireHarness_total,'String',Percenet_Total_WireHarness)
set(handles.txt_CE_Per_Contactor_total,'String',Percenet_Total_Contactor)

%% HVAC
Cost_Compressor = 955;      %Currency = Euro
Cost_Evaporator = 442;
Cost_Condenser = 893;
Cost_Aircurtains = 732;
Cost_HVACadd = 2136;
Cost_ACducts = 1183;
Cost_Total_HVAC = Cost_Compressor+Cost_Evaporator+Cost_Condenser+Cost_Aircurtains+Cost_HVACadd+Cost_ACducts;
assignin('base','Cost_Total_HVAC',Cost_Total_HVAC)
Percenet_Total_Compressor = round((Cost_Compressor/Cost_Total_HVAC)*100*100)/100;
Percenet_Total_Evaporator = round((Cost_Evaporator/Cost_Total_HVAC)*100*100)/100;
Percenet_Total_Condenser = round((Cost_Condenser/Cost_Total_HVAC)*100*100)/100;
Percenet_Total_Aircurtains = round((Cost_Aircurtains/Cost_Total_HVAC)*100*100)/100;
Percenet_Total_HVACadd = round((Cost_HVACadd/Cost_Total_HVAC)*100*100)/100;
Percenet_Total_ACducts = round((Cost_ACducts/Cost_Total_HVAC)*100*100)/100;
set(handles.txt_CE_Per_Compressor,'String',Percenet_Total_Compressor)
set(handles.txt_CE_Per_Evaporator,'String',Percenet_Total_Evaporator)
set(handles.txt_CE_Per_Condenser,'String',Percenet_Total_Condenser)
set(handles.txt_CE_Per_Aircurtains,'String',Percenet_Total_Aircurtains)
set(handles.txt_CE_Per_HVACadd,'String',Percenet_Total_HVACadd)
set(handles.txt_CE_Per_ACducts,'String',Percenet_Total_ACducts)
set(handles.txt_CE_Cost_Compressor,'String',Cost_Compressor)
set(handles.txt_CE_Cost_Evaporator,'String',Cost_Evaporator)
set(handles.txt_CE_Cost_Condenser,'String',Cost_Condenser)
set(handles.txt_CE_Cost_Aircurtains,'String',Cost_Aircurtains)
set(handles.txt_CE_Cost_HVACadd,'String',Cost_HVACadd)
set(handles.txt_CE_Cost_ACducts,'String',Cost_ACducts)
set(handles.txt_TotalCostHVAC,'String',Cost_Total_HVAC)

axes(handles.ax_CE_HVAC)
labels = {'','','','','',''};
pie([Cost_Compressor Cost_Evaporator Cost_Condenser Cost_Aircurtains Cost_HVACadd Cost_ACducts],labels) 
colormap(handles.ax_CE_HVAC,[0 0.45 0.74;1 0 0;0.47 0.67 0.19;1 1 0;0.93 0.69 0.13;1 0 1])
set(handles.txt_CE_Color_Compressor,'BackgroundColor',[0.22 0.48 0.69]);
set(handles.txt_CE_Color_Evaporator,'BackgroundColor',[1 0 0]);
set(handles.txt_CE_Color_Condenser,'BackgroundColor',[0.47 0.67 0.19]);
set(handles.txt_CE_Color_Aircurtains,'BackgroundColor',[1 1 0]);
set(handles.txt_CE_Color_HVACadd,'BackgroundColor',[0.93 0.69 0.13]);
set(handles.txt_CE_Color_ACducts,'BackgroundColor',[1 0 1]);

%% Autonomous
Cost_Lidar = 16000;
Cost_Logi = 15186;
Cost_Autonomous = Cost_Lidar+Cost_Logi;

set(handles.txt_CE_Cost_Lidar,'String',Cost_Lidar)
set(handles.txt_CE_Cost_Logi,'String',Cost_Logi)
set(handles.txt_TotalCostAutonomous,'String',Cost_Autonomous)

%% Chassis
Cost_Axles = 5117;      %Currency = Euro
% assignin('base','Cost_Axles',Cost_Axles)
Cost_Rim = 232;
% assignin('base','Cost_Rim',Cost_Rim)
Cost_Tire = 695;
% assignin('base','Cost_Tire',Cost_Tire)
Cost_Brake = 741;
% assignin('base','Cost_Brake',Cost_Brake)
Cost_WheelHub = 1093;
% assignin('base','Cost_WheelHub',Cost_WheelHub)
Cost_Spring = 348;
% assignin('base','Cost_Spring',Cost_Spring)
Cost_Suspension = 386;
% assignin('base','Cost_Suspension',Cost_Suspension)
Cost_Calippers = 1070;
% assignin('base','Cost_Calippers',Cost_Calippers)

mass_ALL = evalin('base','mass_ALL')
vehicle_mass = evalin('base','vehicle_mass')
vehicle_mass_ALL = double(mass_ALL)
assignin('base','vehicle_mass_ALL',vehicle_mass_ALL)
Cost_Frame = round(vehicle_mass*4*1.2*1.68*0.97*1.09*1);     % SRT Body will weigh around 750Kgs. Hence using 8Euro/kg(Aluminium)(Change to 4), mass*750*Minor implicit, Components *Currency conversion * Inflation adjustment * Type of Cost figure adjustement * Scale of cost figure adjustment 
assignin('base','Cost_Frame',Cost_Frame)

Cost_Total_Chassis = sum([Cost_Axles Cost_Rim Cost_Tire Cost_Brake Cost_WheelHub Cost_Spring Cost_Suspension Cost_Calippers Cost_Frame]); ;
assignin('base','Cost_Total_Chassis',Cost_Total_Chassis)
Percenet_Total_Axles = round((Cost_Axles/Cost_Total_Chassis)*100*100)/100;
Percenet_Total_Rim = round((Cost_Rim/Cost_Total_Chassis)*100*100)/100;
Percenet_Total_Tire = round((Cost_Tire/Cost_Total_Chassis)*100*100)/100;
Percenet_Total_Brake = round((Cost_Brake/Cost_Total_Chassis)*100*100)/100;
Percenet_Total_WheelHub = round((Cost_WheelHub/Cost_Total_Chassis)*100*100)/100;
Percenet_Total_Spring = round((Cost_Spring/Cost_Total_Chassis)*100*100)/100;
Percenet_Total_Suspension = round((Cost_Suspension/Cost_Total_Chassis)*100*100)/100;
Percenet_Total_Calippers = round((Cost_Calippers/Cost_Total_Chassis)*100*100)/100;
Percenet_Total_Frame = round((Cost_Frame/Cost_Total_Chassis)*100*100)/100;
assignin('base','Percenet_Total_Frame',Percenet_Total_Frame)
set(handles.txt_CE_Per_Axles,'String',Percenet_Total_Axles)
set(handles.txt_CE_Per_Rim,'String',Percenet_Total_Rim)
set(handles.txt_CE_Per_Tire,'String',Percenet_Total_Tire)
set(handles.txt_CE_Per_Brake,'String',Percenet_Total_Brake)
set(handles.txt_CE_Per_WheelHub,'String',Percenet_Total_WheelHub)
set(handles.txt_CE_Per_Spring,'String',Percenet_Total_Spring)
set(handles.txt_CE_Per_Suspension,'String',Percenet_Total_Suspension)
set(handles.txt_CE_Per_Calippers,'String',Percenet_Total_Calippers)
set(handles.txt_CE_Cost_Axles,'String',Cost_Axles)
set(handles.txt_CE_Cost_Rim,'String',Cost_Rim)
set(handles.txt_CE_Cost_Tire,'String',Cost_Tire)
set(handles.txt_CE_Cost_Brake,'String',Cost_Brake)
set(handles.txt_CE_Cost_WheelHub,'String',Cost_WheelHub)
set(handles.txt_CE_Cost_Spring,'String',Cost_Spring)
set(handles.txt_CE_Cost_Suspension,'String',Cost_Suspension)
set(handles.txt_CE_Cost_Calippers,'String',Cost_Calippers)

set(handles.txt_CE_Per_Frame,'String',Percenet_Total_Frame)
set(handles.txt_CE_Cost_Frame,'String',Cost_Frame)              % Cost Frame

set(handles.txt_TotalCostChassis,'String',Cost_Total_Chassis)

axes(handles.ax_CE_Chassis2)
labels = {'','','','','','','','',''};
pie([Cost_Axles Cost_Rim Cost_Tire Cost_Brake Cost_WheelHub Cost_Spring Cost_Suspension Cost_Calippers Cost_Frame],labels) 
colormap(handles.ax_CE_Chassis2,[0 0.45 0.74;1 0 0;0.47 0.67 0.19;1 1 0;0.93 0.69 0.13;1 0 1;0.65 0.65 0.65;0.64 0.08 0.18;0.15 0.15 0.15])
set(handles.txt_CE_Color_Axles,'BackgroundColor',[0.22 0.48 0.69]);
set(handles.txt_CE_Color_Rim,'BackgroundColor',[1 0 0]);
set(handles.txt_CE_Color_Tire,'BackgroundColor',[0.47 0.67 0.19]);
set(handles.txt_CE_Color_Brake,'BackgroundColor',[1 1 0]);
set(handles.txt_CE_Color_WheelHub,'BackgroundColor',[0.93 0.69 0.13]);
set(handles.txt_CE_Color_Spring,'BackgroundColor',[1 0 1]);
set(handles.txt_CE_Color_Suspension,'BackgroundColor',[0.65 0.65 0.65]);
set(handles.txt_CE_Color_Calippers,'BackgroundColor',[0.64 0.08 0.18]);
set(handles.txt_CE_Color_Frame,'BackgroundColor',[0.15 0.15 0.15]);

axes(handles.ax_CE_Chassis1)
labels = {'','','','','','','','',''};
pie([Cost_Axles Cost_Rim Cost_Tire Cost_Brake Cost_WheelHub Cost_Spring Cost_Suspension Cost_Calippers Cost_Frame],labels) 
colormap(handles.ax_CE_Chassis1,[0 0.45 0.74;1 0 0;0.47 0.67 0.19;1 1 0;0.93 0.69 0.13;1 0 1;0.65 0.65 0.65;0.64 0.08 0.18;0.15 0.15 0.15])

l_overall = evalin('base','l_overall');
set(handles.Slider_Chassis,'Value',l_overall)

%% Total Cost
set(handles.txt_TotalCost,'String',sum([Cost_Total_Chassis Cost_Total_HVAC TotalPowertrainCost Cost_Autonomous])); 

if (handles.rb_PT_1.Value == true || handles.rb_PT_2.Value == true || handles.rb_PT_3.Value == true || handles.rb_PT_4.Value == true)...
        && Cooling == 1 && handles.pb_Ch_Sizing.Value == 1 && VehicleSpecification == 1
    
    set(handles.uip_Automated_Analysis,'Visible','on');
    set(handles.uip_Automated,'Visible','off');
    set(handles.uip_ConfigurationProgress_Automated,'Visible','off');
    
end

%% Energy Consumption Drive Cycle
Cycle = 'BRT_Beijing.mat';
global path_base
% Drivecycle = load(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\12_Longitudinal_Simulation_SK\00_Parameters\' Cycle]);
Drivecycle = load([path_base '\13_Phi\00_Parameters\' Cycle]);
axes(handles.ax_DriveCycle)
hold off
plot(Drivecycle.dc.time,Drivecycle.dc.speed*3.6,'Color',[0.06 0.66 0.53]);
axis([0 Drivecycle.dc.tmax 0 max(Drivecycle.dc.speed*3.6)+5]);
title('Speed Profile')
xlabel('time in s')
ylabel('speed in km/h')
% v_speed = 'speed.mat';
% Speed = load(['T:\04_Cluster_C\500_SRT\033_SRT Package\Parametric Model\Phi Tran\05 AEV Tool\03 Beginner_Mode\' v_speed]);
assignin('base','Drivecycle',Drivecycle)
% assignin('base','Speed',Speed)
%Drive Cycle textfield
set(handles.txt_DriveCycle,'String','BRT Beijing')

%Speedometer
score = 0;
axes(handles.ax_speedometer)
if (score > 1)
    disp('Error! Please input a decimal value and retry!');
else if (score < 0)
        disp('Error! The score value should be between 0 and 1');
    else
        % code below draws a half circle (0 to pi) --> 0 to 2*pi draws a full
        % circle
        cla %clear the previous axes if any
        radius = 1; %unit circle
        angle = 0:0.01:3/2*pi; % for only a half circle
        x = radius * cos(angle);
        y = radius * sin(angle);
        [grad,~] = colorGradient([0.22 0.48 0.69],[0.06 0.66 0.53],length(angle)); %c1 set to red and
        % c2 set to green since I wanted to create a colourmap with red at one end of
        % the spectrum and green at the other, can experiment with any colour
        % values you like!!
        
        colormap(handles.ax_speedometer,grad)
        z = zeros(size(x));
        col = x;  % This is the color, vary with x in this case.
        surface([x;x],[y;y],[z;z],[col;col],'FaceColor','no','EdgeColor','interp','LineWidth',45); %line width set to 45 since we need a thick line - can change this to anything
        text(x(1),y(1),'100','FontSize',12)
        text(x(length(angle)),y(length(angle)),'0','FontSize',12)
        text(x(round(length(angle)/2)),y(round(length(angle)/2)),'50','FontSize',12)
%         text(x(round(length(angle)/4)),y(round(length(angle)/4)),'75','FontSize',12)
%         text(x(round(length(angle)/1.5)),y(round(length(angle)/1.5)),'25','FontSize',12)
        axis equal
        axis off
        hold on
        
        % this part draws the line to indicate the score and a string to display
        % the value
        scoreRange = linspace(1,0,length(angle));
        [~,index] = min(abs(scoreRange - score));
        scoreString = strcat(num2str(score*100),'km/h');
%         plot([x(index),0],[y(index),0],'-k','LineWidth',2)
        text(x(index),y(index),scoreString,'FontSize',12)
    end
end

set(handles.uip_DriveCycle,'Visible','on');
set(handles.uip_cover_DriveCycle,'Visible','off');

%% Vehicle Concept
Concept = evalin('base','Concept');
tb_SA_2zones = evalin('base','tb_SA_2zones');
tb_SA_seats = evalin('base','tb_SA_seats');
tb_SA_standing = evalin('base','tb_SA_standing');
llleenn = evalin('base','llleenn');
mass_ALL = evalin('base','mass_ALL');
E1Consumption300 = evalin('base','E1Consumption300');
E1Consumption400 = evalin('base','E1Consumption400');
E2Consumption300 = evalin('base','E2Consumption300');
E2Consumption400 = evalin('base','E2Consumption400');

if Concept == 1
    
set(handles.cb_concept1,'Enable','on');
        
set(handles.ed_VC_Clasification,'String',VS);
set(handles.ed_VC_NoP,'String',NoP);

if tb_SA_seats == 1
    
        set(handles.ed_VC_SA,'String','Coach');
        
else if tb_SA_2zones == 1
        
        set(handles.ed_VC_SA,'String','Urban Layout 2');
        
else if tb_SA_standing == 1

        set(handles.ed_VC_SA,'String','Urban Layout 1');
        
        end
    end
end

X=sprintf('%s x 2700 x 3100',llleenn);
set(handles.ed_VC_Dimension,'String',X);        
set(handles.ed_VC_Weight,'String',double(mass_ALL));

if rabbit == 100
    
ECon = E1Consumption300;
set(handles.ed_VC_Consumption,'String',ECon);
Range = 300;

else if rabbit == 101
    
ECon = E1Consumption400;
set(handles.ed_VC_Consumption,'String',ECon);
Range = 300;

else if rabbit == 102
                        
ECon = E2Consumption300;
set(handles.ed_VC_Consumption,'String',ECon);
Range = 400;

else if rabbit == 103
 
ECon = E2Consumption400;
set(handles.ed_VC_Consumption,'String',ECon);
Range = 400;

        
            end
        end
    end
end
set(handles.ed_VC_Range,'String',Range);
set(handles.ed_VC_Cost,'String',sum([Cost_Total_Chassis Cost_Total_HVAC TotalPowertrainCost Cost_Autonomous]));


TCost = sum([Cost_Total_Chassis Cost_Total_HVAC TotalPowertrainCost]);
% Spider Chart

% Cheat
hold off
axes(handles.ax_spiderchart_VC1)
plot(1)
set(handles.ax_spiderchart_VC1,'YColor',[1 1 1],'YLim',[0 1],'YTick',[0:0.5:1],...
    'XColor',[1 1 1],'XLim',[0 1],'XTick',[0:0.5:1])

axes(handles.ax_spiderchart_VC1_C)
plot(1)
set(handles.ax_spiderchart_VC1_C,'YColor',[1 1 1],'YLim',[0 1],'YTick',[0:0.5:1],...
    'XColor',[1 1 1],'XLim',[0 1],'XTick',[0:0.5:1])

% Point properties 
num_of_points = 6; 
row_of_points = 3; 

% % Random data 
P = rand(row_of_points, num_of_points);
num_seats = evalin('base','num_seats');
% Random data 
% First row is the maximum value, second row is the minimum value
% Third row is the main value
%NoP, Length, Cost, Energy Consumption, Range, Seats
P = [70 15 240 180 400 60;30 5 80 0 0 0;NoP llleenn/1000 (TCost+31186)/1000 ECon Range num_seats]; 
P_1 = [NoP llleenn/1000 (TCost+31186)/1000 ECon Range num_seats];
assignin('base','P_1',P_1)

% Create generic labels 
P_labels = cell(num_of_points, 1); 

% for ii = 1:num_of_points 
% P_labels{ii} = sprintf('Label %i', ii); 
% end 
P_labels{1} = sprintf('Number of \nPassengers \n(30 - 70)');
P_labels{2} = sprintf('Length \n(5m - 15m)');
P_labels{3} = sprintf('Cost \n(80k - 240k €)');
P_labels{4} = sprintf('E. Consumption \n(0kWh/100km - \n180kWh/100km)');
P_labels{5} = sprintf('Range \n(0-400km)');
P_labels{6} = sprintf('Seats \n(0-60)');


% Figure properties 
axes(handles.ax_spiderchart_VC1)
% figure('units', 'normalized', 'outerposition', [0 0.05 1 0.95]); 

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
title('Concept 1',... 
'Fontweight', 'bold',... 
'FontSize', 12); 

hold off

% Comparison

% Point properties 
num_of_points = 6; 
row_of_points = 3; 

% % Random data 
P = rand(row_of_points, num_of_points); 
% Random data 
% First row is the maximum value, second row is the minimum value
% Third row is the main value
%NoP, Length, Cost, Energy Consumption, Range, Seats
P = [70 15 240 180 400 60;30 5 80 0 0 0;NoP llleenn/1000 (TCost+31186)/1000 ECon Range num_seats];  

% Create generic labels 
P_labels = cell(num_of_points, 1); 

% for ii = 1:num_of_points 
% P_labels{ii} = sprintf('Label %i', ii); 
% end 
P_labels{1} = sprintf('Number of \nPassengers \n(30 - 70)');
P_labels{2} = sprintf('Length \n(5m - 15m)');
P_labels{3} = sprintf('Cost \n(80k - 240k €)');
P_labels{4} = sprintf('E. Consumption \n(0kWh/100km - \n180kWh/100km)');
P_labels{5} = sprintf('Range \n(0-400km)');
P_labels{6} = sprintf('Seats \n(20-40)');

% Figure properties 
axes(handles.ax_spiderchart_VC1_C)
% figure('units', 'normalized', 'outerposition', [0 0.05 1 0.95]); 

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
title('Concept 1',... 
'Fontweight', 'bold',... 
'FontSize', 12); 

hold off

else if Concept == 2
        
set(handles.cb_concept2,'Enable','on');
               
        set(handles.ed_VC_Classification_2,'String',VS);
        set(handles.ed_VC_NoP_2,'String',NoP);

if tb_SA_seats == 1
    
        set(handles.ed_VC_SA_2,'String','Coach');
        
else if tb_SA_2zones == 1
        
        set(handles.ed_VC_SA_2,'String','Urban Layout 2');
        
else if tb_SA_standing == 1

        set(handles.ed_VC_SA_2,'String','Urban Layout 1');
        
        end
    end
end

X=sprintf('%s x 2700 x 3100',llleenn);
set(handles.ed_VC_Dimension_2,'String',X);        
set(handles.ed_VC_Weight_2,'String',double(mass_ALL));

if rabbit == 100
    
ECon = E1Consumption300;
set(handles.ed_VC_Consumption_2,'String',ECon);
Range = 300;

else if rabbit == 101
    
ECon = E1Consumption400;
set(handles.ed_VC_Consumption_2,'String',ECon);
Range = 300;


else if rabbit == 102
                        
ECon = E2Consumption300;
set(handles.ed_VC_Consumption_2,'String',ECon);
Range = 400;


else if rabbit == 103
 
ECon = E2Consumption400;
set(handles.ed_VC_Consumption_2,'String',ECon);
Range = 400;
        
            end
        end
    end
end
set(handles.ed_VC_Range_2,'String',Range);
set(handles.ed_VC_Cost_2,'String',sum([Cost_Total_Chassis Cost_Total_HVAC TotalPowertrainCost Cost_Autonomous]));


TCost = sum([Cost_Total_Chassis Cost_Total_HVAC TotalPowertrainCost]);
% Spider Chart

% Cheat
hold off
axes(handles.ax_spiderchart_VC2)
plot(1)
set(handles.ax_spiderchart_VC2,'YColor',[1 1 1],'YLim',[0 1],'YTick',[0:0.5:1],...
    'XColor',[1 1 1],'XLim',[0 1],'XTick',[0:0.5:1])

axes(handles.ax_spiderchart_VC2_C)
plot(1)
set(handles.ax_spiderchart_VC2_C,'YColor',[1 1 1],'YLim',[0 1],'YTick',[0:0.5:1],...
    'XColor',[1 1 1],'XLim',[0 1],'XTick',[0:0.5:1])

% Point properties 
num_of_points = 6; 
row_of_points = 3; 
num_seats = evalin('base','num_seats');

% % Random data 
P = rand(row_of_points, num_of_points); 
% Random data 
% First row is the maximum value, second row is the minimum value
% Third row is the main value
%NoP, Length, Cost, Energy Consumption, Range, Seats
P = [70 15 240 180 400 60;30 5 80 0 0 0;NoP llleenn/1000 (TCost+31186)/1000 ECon Range num_seats];  
P_2 = [NoP llleenn/1000 (TCost+31186)/1000 ECon Range num_seats];
assignin('base','P_2',P_2)
% Create generic labels 
P_labels = cell(num_of_points, 1); 

% for ii = 1:num_of_points 
% P_labels{ii} = sprintf('Label %i', ii); 
% end 
P_labels{1} = sprintf('Number of \nPassengers \n(30 - 70)');
P_labels{2} = sprintf('Length \n(5m - 15m)');
P_labels{3} = sprintf('Cost \n(80k - 240k €)');
P_labels{4} = sprintf('E. Consumption \n(0kWh/100km - \n180kWh/100km)');
P_labels{5} = sprintf('Range \n(0-400km)');
P_labels{6} = sprintf('Seats \n(0-60)');


% Figure properties 
axes(handles.ax_spiderchart_VC2)
% figure('units', 'normalized', 'outerposition', [0 0.05 1 0.95]); 

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
title('Concept 2',... 
'Fontweight', 'bold',... 
'FontSize', 12); 

hold off

% Comparison
% Point properties 
num_of_points = 6; 
row_of_points = 3; 

% % Random data 
P = rand(row_of_points, num_of_points); 
% Random data 
% First row is the maximum value, second row is the minimum value
% Third row is the main value
%NoP, Length, Cost, Energy Consumption, Range, Seats
P = [70 15 240 180 400 60;30 5 80 0 0 0;NoP llleenn/1000 (TCost+31186)/1000 ECon Range num_seats];  

% Create generic labels 
P_labels = cell(num_of_points, 1); 

% for ii = 1:num_of_points 
% P_labels{ii} = sprintf('Label %i', ii); 
% end 
P_labels{1} = sprintf('Number of \nPassengers \n(30 - 70)');
P_labels{2} = sprintf('Length \n(5m - 15m)');
P_labels{3} = sprintf('Cost \n(80k - 240k €)');
P_labels{4} = sprintf('E. Consumption \n(0kWh/100km - \n180kWh/100km)');
P_labels{5} = sprintf('Range \n(0-400km)');
P_labels{6} = sprintf('Seats \n(0-60)');

% Figure properties 
axes(handles.ax_spiderchart_VC2_C)
% figure('units', 'normalized', 'outerposition', [0 0.05 1 0.95]); 

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
title('Concept 2',... 
'Fontweight', 'bold',... 
'FontSize', 12); 

hold off

    end
end
        
        
% %% Statistic
% % Statistic = evalin('base','Statistic');
% % Vehicle Specification
% Statistic_VS = evalin('base','Statistic_VS');
% Stat_VS = evalin('base','Stat_VS');
%     
%     Statistic_VS.Statistic_VS.Selection(Stat_VS) = Statistic_VS.Statistic_VS.Selection(Stat_VS)+1
% %     Statistic.Statistic.Statistic.Statistic_VS.Statistic_VS(Stat_VS,2) = {Statistic.Statistic.Statistic.Statistic_VS.Statistic_VS.Selection(Stat_VS)}
% 
% assignin('base','Statistic_VS',Statistic_VS);
% 
% % Number of Passengers
% Statistic_NoP = evalin('base','Statistic_NoP');
% 
%     Statistic_NoP.Statistic_NoP.Selections(NoP) = Statistic_NoP.Statistic_NoP.Selections(NoP)+1
% %     Statistic.Statistic.Statistic.Statistic_NoP.Statistic_NoP(NoP,2) = {Statistic.Statistic.Statistic.Statistic_NoP.Statistic_NoP.Selections(NoP)}
% 
% assignin('base','Statistic_NoP',Statistic_NoP);
% 
% % Motor
% Statistic_Motor = evalin('base','Statistic_Motor');
% 
%     Statistic_Motor.Statistic_Motor.Selection(rabbit-99) = Statistic_Motor.Statistic_Motor.Selection(rabbit-99)+1   
% %     Statistic.Statistic.Statistic.Statistic_Motor.Statistic_Motor(rabbit-99,2) = {Statistic.Statistic.Statistic.Statistic_Motor.Statistic_Motor.Selection(rabbit-99)}
% 
% assignin('base','Statistic_Motor',Statistic_Motor);
% % assignin('base','Statistic',Statistic);
% 
% % Save Statistic
% Path_Statistic = ([path_base '13_Phi\03_Statistics\']);
% % save(Path_Statistic,'Statistic_VS','Statistic_NoP','Statistic_Motor')
% save('Statistic_VS');
% save('Statistic_NoP');
% save('Statistic_Motor');

% --- Executes on button press in pb_EnergyConsumption.
function pb_EnergyConsumption_Callback(hObject, eventdata, handles)
% hObject    handle to pb_EnergyConsumption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uip_EnergyConsumption,'Visible','on');
set(handles.uip_CostEstimation,'Visible','off');
set(handles.uip_VC,'Visible','off');

% --- Executes on button press in pb_CostEstimation.
function pb_CostEstimation_Callback(hObject, eventdata, handles)
% hObject    handle to pb_CostEstimation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uip_EnergyConsumption,'Visible','off');
set(handles.uip_CostEstimation,'Visible','on');
set(handles.uip_VC,'Visible','off');

% --- Executes on button press in pb_Chassis_forward2.
function pb_Chassis_forward2_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Chassis_forward2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Panel_Chassis1,'Visible','on')
set(handles.Panel_Chassis2,'Visible','off')

% --- Executes on slider movement.
function Slider_Chassis_Callback(hObject, eventdata, handles)
% hObject    handle to Slider_Chassis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%% Slider for chassis Cost Estimation -- frame
Cost_Axles = 5117;      %Currency = Euro
Cost_Rim = 232;
Cost_Tire = 695;
Cost_Brake = 741;
Cost_WheelHub = 1093;
Cost_Spring = 348;
Cost_Suspension = 386;
Cost_Calippers = 1070;

currency_rabbit = evalin('base','currency_rabbit');

slider_Chassis = round(get(hObject,'Value'));
    a = 2.831e-13;
    b = 0.002474;
    c = 2350;
    d = 8.001e-05;
vehicle_mass_SL = floor(a*exp(b*slider_Chassis) + c*exp(d*slider_Chassis));
set(handles.txt_CE_Chassis_VehicleLength,'String',round(slider_Chassis));

Cost_Frame_SL = round(vehicle_mass_SL*4*1.2*1.68*0.97*1.09*1);     % SRT Body will weigh around 750Kgs. Hence using 8Euro/kg(Aluminium)(Change to 4), mass*750*Minor implicit, Components *Currency conversion * Inflation adjustment * Type of Cost figure adjustement * Scale of cost figure adjustment 
Cost_Total_Chassis_SL = sum([Cost_Axles Cost_Rim Cost_Tire Cost_Brake Cost_WheelHub Cost_Spring Cost_Suspension Cost_Calippers Cost_Frame_SL]); ;
Percenet_Total_Frame_SL = round((Cost_Frame_SL/Cost_Total_Chassis_SL)*100*100)/100;


axes(handles.ax_CE_Chassis1)
labels = {'','','','','','','','',''};
pie([Cost_Axles Cost_Rim Cost_Tire Cost_Brake Cost_WheelHub Cost_Spring Cost_Suspension Cost_Calippers Cost_Frame_SL],labels) 
colormap(handles.ax_CE_Chassis1,[0 0.45 0.74;1 0 0;0.47 0.67 0.19;1 1 0;0.93 0.69 0.13;1 0 1;0.65 0.65 0.65;0.64 0.08 0.18;0.15 0.15 0.15])

% Currency Change
if currency_rabbit == 1

    set(handles.txt_CE_Cost_Frame,'String',round(Cost_Frame_SL))
    set(handles.txt_TotalCostChassis,'String',Cost_Total_Chassis_SL)

else if currency_rabbit == 2

    Cost_Frame_SL = Cost_Frame_SL*1.6;    
    set(handles.txt_CE_Cost_Frame,'String',round(Cost_Frame_SL))
    Cost_Total_Chassis_SL = Cost_Total_Chassis_SL*1.6;
    set(handles.txt_TotalCostChassis,'String',Cost_Total_Chassis_SL)
        
   end
end

set(handles.txt_CE_Per_Frame,'String',Percenet_Total_Frame_SL)
% set(handles.txt_TotalCostChassis,'String',Cost_Total_Chassis_SL)

Cost_Total_HVAC = evalin('base','Cost_Total_HVAC')
TotalPowertrainCost = evalin('base','TotalPowertrainCost')
set(handles.txt_TotalCost,'String',sum([Cost_Total_Chassis_SL Cost_Total_HVAC TotalPowertrainCost]));


% --- Executes during object creation, after setting all properties.
function Slider_Chassis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider_Chassis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pb_return_Chassis_SL.
function pb_return_Chassis_SL_Callback(hObject, eventdata, handles)
% hObject    handle to pb_return_Chassis_SL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% return the chassis estimation to first position
Cost_Axles = 5117;      %Currency = Euro
Cost_Rim = 232;
Cost_Tire = 695;
Cost_Brake = 741;
Cost_WheelHub = 1093;
Cost_Spring = 348;
Cost_Suspension = 386;
Cost_Calippers = 1070;

l_overall = evalin('base','l_overall')
Cost_Frame = evalin('base','Cost_Frame')
Percenet_Total_Frame = evalin('base','Percenet_Total_Frame')
set(handles.Slider_Chassis,'Value',l_overall)
set(handles.txt_CE_Chassis_VehicleLength,'String',l_overall)
set(handles.txt_CE_Per_Frame,'String',Percenet_Total_Frame)
set(handles.txt_CE_Cost_Frame,'String',Cost_Frame)

axes(handles.ax_CE_Chassis1)
labels = {'','','','','','','','',''};
pie([Cost_Axles Cost_Rim Cost_Tire Cost_Brake Cost_WheelHub Cost_Spring Cost_Suspension Cost_Calippers Cost_Frame],labels) 
colormap(handles.ax_CE_Chassis1,[0 0.45 0.74;1 0 0;0.47 0.67 0.19;1 1 0;0.93 0.69 0.13;1 0 1;0.65 0.65 0.65;0.64 0.08 0.18;0.15 0.15 0.15])

Cost_Total_Chassis = evalin('base','Cost_Total_Chassis')
set(handles.txt_TotalCostChassis,'String',Cost_Total_Chassis)
Cost_Total_HVAC = evalin('base','Cost_Total_HVAC')
TotalPowertrainCost = evalin('base','TotalPowertrainCost')
set(handles.txt_TotalCost,'String',sum([Cost_Total_Chassis Cost_Total_HVAC TotalPowertrainCost]));


% --- Executes on button press in pb_Chassis_forward1.
function pb_Chassis_forward1_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Chassis_forward1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Panel_Chassis1,'Visible','off')
set(handles.Panel_Chassis2,'Visible','on')

% --- Executes on button press in pb_PT_backward2.
function pb_PT_backward2_Callback(hObject, eventdata, handles)
% hObject    handle to pb_PT_backward2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Powertrain2,'Visible','off');
set(handles.Powertrain3,'Visible','off');
set(handles.Powertrain1,'Visible','on');

% --- Executes on button press in pb_PT_forward2.
function pb_PT_forward2_Callback(hObject, eventdata, handles)
% hObject    handle to pb_PT_forward2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Powertrain2,'Visible','off');
set(handles.Powertrain3,'Visible','on');
set(handles.Powertrain1,'Visible','off');

% --- Executes on slider movement.
function slider_PT_Callback(hObject, eventdata, handles)
% hObject    handle to slider_PT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%% Length - NoP - Powertrain Cost
HVAC_Data = evalin('base','HVAC_Data');
l_overall = evalin('base','l_overall');
a = evalin('base','a');
b = evalin('base','b');
c = evalin('base','c');
d = evalin('base','d');
a1 = evalin('base','a1');
a2 = evalin('base','a2');
a3 = evalin('base','a3');
a4 = evalin('base','a4');
c1 = evalin('base','c1');
c2 = evalin('base','c2');
c3 = evalin('base','c3');
YLimit = evalin('base','YLimit');
YTickk = evalin('base','YTickk');
YTick_Label = evalin('base','YTick_Label');
YLimit_SGD = evalin('base','YLimit_SGD');
YTickk_SGD = evalin('base','YTickk_SGD');
YTick_Label_SGD = evalin('base','YTick_Label_SGD');

currency_rabbit = evalin('base','currency_rabbit');

sliderPT = round(get(hObject,'Value'));
assignin('base','sliderPT',sliderPT);

axes(handles.ax_CE_PT_Drivetrain1)
set(handles.txt_slider_PT_Length,'String',sliderPT);

NoP_length_sl = a1*sliderPT.^a2+a3;
NoP_length = a1*a4.^a2+a3;
Cost_1_300 = a*a4.^b+c;
Cost_1_300_sl = a*sliderPT.^b+c;
set(handles.txt_slider_PT_NoP,'String',round(NoP_length_sl));
% set(handles.txt_slider_PT_Cost,'String',Cost_1_300_sl);


% Currency Change
if currency_rabbit == 1

    set(handles.txt_slider_PT_Cost,'String',round(Cost_1_300_sl));

else if currency_rabbit == 2

    Cost_1_300_sl = Cost_1_300_sl*1.6;    
    set(handles.txt_slider_PT_Cost,'String',round(Cost_1_300_sl));
        
   end
end

% Cost1B300 = evalin('base','Cost1B300')

hold off
yyaxis left
plot(sliderPT,NoP_length_sl,'ro','MarkerEdgeColor','r','MarkerFaceColor','r')
yyaxis right
plot(sliderPT,Cost_1_300_sl,'ro','MarkerEdgeColor','r','MarkerFaceColor','r')
yyaxis left
hold on
plot(a4,NoP_length,'Color',[0.22 0.48 0.69],'LineWidth',1)
set(gca,'YLim',[30 70],'YTick',[30:5:70],'XLim',[5000 13000],'XTick',[5000:1000:13000])
ylabel('Number of Passengers','Color',[0.22 0.48 0.69])
yyaxis right
% plot(a4,Cost_1_300,'Color',[0.06 0.66 0.53],'LineWidth',1)
if currency_rabbit == 1
    plot(a4,Cost_1_300,'Color',[0.06 0.66 0.53],'LineWidth',1)
    set(gca,'YColor',[0.06 0.66 0.53],'YLim',YLimit,'YTick',YTickk,'YTickLabel',YTick_Label)
    ylabel('Total Cost of Powertrain in €','Color',[0.06 0.66 0.53])

else if currency_rabbit == 2
        
    plot(a4,Cost_1_300*1.6,'Color',[0.06 0.66 0.53],'LineWidth',1)
    set(gca,'YColor',[0.06 0.66 0.53],'YLim',YLimit_SGD,'YTick',YTickk_SGD,'YTickLabel',YTick_Label_SGD)
    ylabel('Total Cost of Powertrain in SGD','Color',[0.06 0.66 0.53])
   
    end
end

axes(handles.ax_CE_PT_Drivetrain2)
cost_sl_battery = (Cost_1_300_sl-c1-c2-c3);
labels = {'','','',''};
explode = [1 0 0 0];
pie([cost_sl_battery c1 c2 c3],explode,labels) 
colormap([0 0.45 0.74;1 0 0;0.47 0.67 0.19;1 1 0])
set(handles.txt_slider_PT_Battery,'String',round((cost_sl_battery*100/Cost_1_300_sl).*100)/100)



% --- Executes during object creation, after setting all properties.
function slider_PT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_PT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pb_PT_backward3.
function pb_PT_backward3_Callback(hObject, eventdata, handles)
% hObject    handle to pb_PT_backward3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Powertrain2,'Visible','on');
set(handles.Powertrain3,'Visible','off');
set(handles.Powertrain1,'Visible','off');

% --- Executes on button press in pb_PT_forward1.
function pb_PT_forward1_Callback(hObject, eventdata, handles)
% hObject    handle to pb_PT_forward1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Powertrain2,'Visible','on');
set(handles.Powertrain3,'Visible','off');
set(handles.Powertrain1,'Visible','off');


% --- Executes on button press in pb_
function pb_Simulation_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Simulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% load the correct Powertrain Matfile

P_Battery = evalin('base','P_Battery');
Powertrain_Data = evalin('base','Powertrain_Data')

set(handles.uip_cover_EnergyLoss,'Visible','off');
set(handles.uip_cover_EnergyLoss_text,'Visible','off');
set(handles.uip_CE_EnergyLoss,'Visible','on');
set(handles.uip_EnergyLoss,'Visible','on');

E_loss_All = 0;
axes(handles.ax_DriveCycle)
hold on
for i = 1:10:length(Powertrain_Data.RES.t)
        axes(handles.ax_DriveCycle)
        area(Powertrain_Data.RES.t(i),Powertrain_Data.RES.v_actual(i)*3.6,'FaceColor',[0.06 0.66 0.53])
        grid on
        pause(0.01)
    %% Speedometer
        axes(handles.ax_speedometer)
        score = Powertrain_Data.RES.v_actual(i)*3.6/100;  
        % code below draws a half circle (0 to pi) --> 0 to 2*pi draws a full
        % circle
        cla %clear the previous axes if any
        radius = 1; %unit circle
        angle = 0:0.01:3/2*pi; % for only a half circle
        x = radius * cos(angle);
        y = radius * sin(angle);
        [grad,~] = colorGradient([0.22 0.48 0.69],[0.06 0.66 0.53],length(angle)); %c1 set to red and
        % c2 set to green since I wanted to create a colourmap with red at one end of
        % the spectrum and green at the other, can experiment with any colour
        % values you like!!
        
        colormap(handles.ax_speedometer,grad)
        z = zeros(size(x));
        col = x;  % This is the color, vary with x in this case.
        surface([x;x],[y;y],[z;z],[col;col],'FaceColor','no','EdgeColor','interp','LineWidth',45); %line width set to 45 since we need a thick line - can change this to anything
        text(x(1),y(1),'100','FontSize',12)
        text(x(length(angle)),y(length(angle)),'0','FontSize',12)
        text(x(round(length(angle)/2)),y(round(length(angle)/2)),'50','FontSize',12)
        axis equal
        axis off
        hold on
        
        % this part draws the line to indicate the score and a string to display
        % the value
        scoreRange = linspace(1,0,length(angle));
        [~,index] = min(abs(scoreRange - score));
        scoreString = strcat(num2str(round(score*100)),'km/h');
        plot([x(index),0],[y(index),0],'-k','LineWidth',2)
%       text(x(index),y(index),scoreString,'FontSize',12)
        set(handles.txt_speedometer,'String',scoreString)
        pause(0)
%         a = i
   %% Energy Loss
   
   % Calculation
   EnergyLoss_Pt(i) = Powertrain_Data.RES.E_loss_bat(i)+Powertrain_Data.RES.E_loss_inv_all(i)...
       +Powertrain_Data.RES.E_loss_mot_all(i)+Powertrain_Data.RES.E_loss_TM_all(i); 
   EnergyLoss_Res(i) = Powertrain_Data.RES.E_loss_RollResistance(i)+Powertrain_Data.RES.E_loss_AirResistance(i)...
       +Powertrain_Data.RES.E_loss_SlopeResistance(i);
   
   axes(handles.ax_EnergyLoss)
        plot(Powertrain_Data.RES.t(i),EnergyLoss_Pt(i),'.','MarkerEdgeColor',[0.22 0.48 0.69]);
%         plot(Speed.RES.t(i),Speed.RES.E_loss_bat(i),'.','MarkerEdgeColor',[0.06 1 0.53]);
        hold on;
%         plot(Speed.RES.t(i),Speed.RES.E_loss_inv_all(i),'.','MarkerEdgeColor',[0.5 0.66 0.53]);
%         plot(Speed.RES.t(i),Speed.RES.E_loss_mot_all(i),'.','MarkerEdgeColor',[0.06 0.66 0.3]);
%         plot(Speed.RES.t(i),Speed.RES.E_loss_TM_all(i),'.','MarkerEdgeColor',[0.22 0.3 0.69]);
        plot(Powertrain_Data.RES.t(i),EnergyLoss_Res(i),'.','MarkerEdgeColor',[0.9 0.9 0.9]);
%         plot(Speed.RES.t(i),Speed.RES.E_loss_RollResistance(i),'.','MarkerEdgeColor',[0.22 0.48 0.69]);
%         plot(Speed.RES.t(i),Speed.RES.E_loss_AirResistance(i),'.','MarkerEdgeColor',[0.22 0.48 1]);
%         plot(Speed.RES.t(i),Speed.RES.E_loss_SlopeResistance(i),'.','MarkerEdgeColor',[0.22 0.48 0.5]);
        plot(Powertrain_Data.RES.t(i),Powertrain_Data.RES.E_loss_ALL(i),'o','MarkerEdgeColor',[0.06 0.66 0.53],'MarkerFaceColor',[0.06 0.66 0.53]);
        
        axes(handles.ax_EnergyLoss)
        grid on
        title('Energy Losses');
        xlabel('time in s');
        ylabel('Losses in kWh');
        axis([0 max(Powertrain_Data.RES.t) 0 max(Powertrain_Data.RES.E_loss_ALL)*1.1]);
   
    %% Textfeld
%     E_loss_All = E_loss_All + Speed.RES.E_loss_ALL(i);

        set(handles.txt_EL_All_ed,'String',num2str(Powertrain_Data.RES.E_loss_ALL(i)),'BackgroundColor',[0.06 0.66 0.53]);
        set(handles.txt_EL_PT_ed,'String',num2str(EnergyLoss_Pt(i)),'BackgroundColor',[0.22 0.48 0.69]);
        set(handles.txt_EL_Res_ed,'String',num2str(EnergyLoss_Res(i)),'BackgroundColor',[0.9 0.9 0.9]);
%         set(handles.txt_EL_Bat_ed,'String',num2str(Speed.RES.E_loss_bat(i)))
%         set(handles.txt_EL_Inv_ed,'String',num2str(Speed.RES.E_loss_inv_all(i)))
%         set(handles.txt_EL_Mot_ed,'String',num2str(Speed.RES.E_loss_mot_all(i)))
%         set(handles.txt_EL_Trans_ed,'String',num2str(Speed.RES.E_loss_TM_all(i)))
%         set(handles.txt_EL_Roll_ed,'String',num2str(Speed.RES.E_loss_RollResistance(i)))
%         set(handles.txt_EL_Air_ed,'String',num2str(Speed.RES.E_loss_AirResistance(i)))
%         set(handles.txt_EL_Slope_ed,'String',num2str(Speed.RES.E_loss_SlopeResistance(i)))
        
%% Battery Power Consumption
    axes(handles.ax_P_Battery)
    hold off
    plot([i i],ylim,'r','Linewidth',2)
    hold on
    plot(P_Battery)
    set(gca,'XLim',[0 1222])
    xlabel('time in s')
    ylabel('Power Battery in W')
    title('Energy Consumption Battery')
    grid on

% Set Values for Energy Use and Recuperation
    if P_Battery(i)>0
        set(handles.txt_Bat_EUse_ed,'String',P_Battery(i)/1000)
        set(handles.txt_Bat_ERecup_ed,'String','0')
    else
        set(handles.txt_Bat_ERecup_ed,'String',P_Battery(i)/1000)
        set(handles.txt_Bat_EUse_ed,'String','0')
    end
end


% --- Executes on button press in pb_VS_m.
function pb_VS_m_Callback(hObject, eventdata, handles)
% hObject    handle to pb_VS_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Vehicle Specification - Manual Mode
%% Callback the Pages
set(handles.uip_M_VehicleSpecification,'Visible','on');
set(handles.uip_M_Powertrain,'Visible','off');
set(handles.uip_M_Suspension,'Visible','off');
set(handles.uip_M_Chassis,'Visible','off');
set(handles.uip_M_Electronics,'Visible','off');

% --- Executes on button press in pb_PT_m.
function pb_PT_m_Callback(hObject, eventdata, handles)
% hObject    handle to pb_PT_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Powertrain - Manual Mode
%% Callback the Pages
set(handles.uip_M_VehicleSpecification,'Visible','off');
set(handles.uip_M_Powertrain,'Visible','on');
set(handles.uip_M_Suspension,'Visible','off');
set(handles.uip_M_Chassis,'Visible','off');
set(handles.uip_M_Electronics,'Visible','off');

% --- Executes on button press in pb_SP_m.
function pb_SP_m_Callback(hObject, eventdata, handles)
% hObject    handle to pb_SP_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Suspension - Manual Mode
%% Callback the Pages
set(handles.uip_M_VehicleSpecification,'Visible','off');
set(handles.uip_M_Powertrain,'Visible','off');
set(handles.uip_M_Suspension,'Visible','on');
set(handles.uip_M_Chassis,'Visible','off');
set(handles.uip_M_Electronics,'Visible','off');

% --- Executes on button press in pb_CH_m.
function pb_CH_m_Callback(hObject, eventdata, handles)
% hObject    handle to pb_CH_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Chassis - Manual Mode
%% Callback the Pages
set(handles.uip_M_VehicleSpecification,'Visible','off');
set(handles.uip_M_Powertrain,'Visible','off');
set(handles.uip_M_Suspension,'Visible','off');
set(handles.uip_M_Chassis,'Visible','on');
set(handles.uip_M_Electronics,'Visible','off');

% --- Executes on button press in pb_EL_m.
function pb_EL_m_Callback(hObject, eventdata, handles)
% hObject    handle to pb_EL_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Electronics - Manual Mode
%% Callback the Pages
set(handles.uip_M_VehicleSpecification,'Visible','off');
set(handles.uip_M_Powertrain,'Visible','off');
set(handles.uip_M_Suspension,'Visible','off');
set(handles.uip_M_Chassis,'Visible','off');
set(handles.uip_M_Electronics,'Visible','on');

% --- Executes on button press in pushbutton_default_values.
function pushbutton_default_values_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_default_values (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Default button
%Vehicle Specification - Overall Vehicle
set(handles.edit_overall_length,'String',6000);
set(handles.edit_overall_width,'String',2700);
set(handles.edit_overall_height,'String',3100);

set(handles.edit_wheelbase,'String',4200);
set(handles.edit_ground_clearance,'String',150);
set(handles.edit_lifting_height,'String',0);

%Vehicle Specification - Vehicle Configuration
set(handles.checkbox_layout_urban1,'Value',0);
set(handles.checkbox_layout_urban2,'Value',0);
set(handles.checkbox_layout_coach,'Value',1);

set(handles.checkbox_central_motor_rear,'Value',1);
set(handles.checkbox_dual_motor_rear,'Value',0);
set(handles.checkbox_all_wheel_drive,'Value',0);

set(handles.checkbox_ramp_pulled_in,'Value',1);
set(handles.checkbox_ramp_deployed,'Value',0);

%Vehicle Specification - Interior
set(handles.edit_seat_length,'String',400);
set(handles.edit_seat_width,'String',400);
set(handles.edit_seat_height,'String',450);
set(handles.edit_seat_thickness,'String',40);
set(handles.edit_backrest_height,'String',500);
set(handles.edit_leg_clearance,'String',300);
set(handles.edit_seat_gap,'String',50);
set(handles.popupmenu_seat_material,'Value',3);
set(handles.edit_passenger_shoulder_width,'String',530);
set(handles.edit_passenger_body_depth,'String',450);

%Powertrain - Drivetrain
set(handles.edit_motor_length,'String',300);
set(handles.edit_motor_diameter,'String',270);
set(handles.popupmenu_motor_material,'Value',1);

%Powertrain - Cooler
set(handles.edit_cooler_length,'String',1200);
set(handles.edit_cooler_height,'String',250);
set(handles.edit_cooler_thickness,'String',50);
set(handles.popupmenu_cooler_material,'Value',1);

%Powertrain - Transmission
set(handles.edit_transmission_length,'String',235);
set(handles.edit_transmission_width,'String',370);
set(handles.popupmenu_transmission_material,'Value',1);

%Powertrain - Inverter
set(handles.edit_inverter_length,'String',343);
set(handles.edit_inverter_width,'String',150);
set(handles.edit_inverter_height,'String',70);
set(handles.popupmenu_inverter_material,'Value',1);

%Powertrain - Battery Cell
set(handles.edit_cell_volume,'String',0.354);
set(handles.edit_cell_diameter,'String',18);
set(handles.edit_cell_height,'String',65);
set(handles.popupmenu_cell_material,'Value',2);

%Powertrain - Battery Box
set(handles.edit_thickness_box,'String',4);
set(handles.edit_battery_electronics_height,'String',15);
set(handles.popupmenu_box_material,'Value',1);

%Suspension - Wheel
set(handles.edit_tire_width,'String',215);
set(handles.edit_tire_diameter,'String',767);
set(handles.edit_rim_diameter,'String',19);
set(handles.edit_rim_thickness,'String',10);
set(handles.popupmenu_tire_material,'Value',2);
set(handles.popupmenu_rim_material,'Value',1);

%Suspension - Breaking System
set(handles.edit_disc_outer_diameter,'String',430);
set(handles.edit_disc_inner_diameter,'String',160);
set(handles.edit_disc_thickness,'String',34);
set(handles.popupmenu_disc_material,'Value',4);
set(handles.popupmenu_brake_pad_material,'Value',4);
set(handles.popupmenu_brake_caliper_material,'Value',4);

%Suspension - Wheel Carrier
set(handles.edit_carrier_length,'String',140);
set(handles.edit_carrier_width,'String',90);
set(handles.popupmenu_carrier_material,'Value',1);

%Suspension - A-Arms
set(handles.edit_aarm_diameter,'String',15);
set(handles.edit_aarm_thickness,'String',10);
set(handles.popupmenu_aarm_material,'Value',5);

%Suspension - Air Suspension
set(handles.edit_air_spring_height,'String',285);
set(handles.edit_air_spring_diameter,'String',300);
set(handles.popupmenu_air_spring_material,'Value',5);
set(handles.edit_air_tank_diameter,'String',250);
set(handles.edit_air_tank_length,'String',450);
set(handles.edit_air_tank_thickness,'String',1);
set(handles.popupmenu_air_tank_material,'Value',1);
set(handles.edit_compressor_diameter,'String',200);
set(handles.edit_compressor_length,'String',450);
set(handles.edit_compressor_thickness,'String',4);
set(handles.popupmenu_compressor_material,'Value',1);

%Suspension - Steering Angle
set(handles.edit_front_angle,'String',0);
set(handles.edit_rear_angle,'String',0);

%Suspension - Axis
set(handles.edit_axis_thickness,'String',8);
set(handles.edit_axis_diameter,'String',50);
set(handles.popupmenu_axis_material,'Value',5);

%Suspension - Damper
set(handles.edit_damper_diameter,'String',50);
set(handles.popupmenu_damper_material,'Value',1);

%Chassis - Body
set(handles.edit_roof_height,'String',400);
set(handles.edit_body_thickness,'String',5);
set(handles.popupmenu_body_material,'Value',4);
set(handles.popupmenu_wheelhouse_material,'Value',4);

%Chassis - Frame
set(handles.edit_frame_thickness,'String',8);
set(handles.edit_frame_height,'String',100);
set(handles.popupmenu_frame_material,'Value',4);

%Chassis - Window
set(handles.edit_window_thickness,'String',6);
set(handles.edit_window_shoulder,'String',940);
set(handles.edit_window_height,'String',1285);
set(handles.popupmenu_window_material,'Value',2);

%Chassis - Floor
set(handles.edit_floor_thickness,'String',5);
set(handles.edit_floor_height,'String',350);
set(handles.popupmenu_floor_material,'Value',1);

%Chassis - Ramp
set(handles.edit_ramp_length,'String',1200);
set(handles.edit_ramp_width,'String',1000);
set(handles.edit_ramp_thickness,'String',50);
set(handles.popupmenu_ramp_material,'Value',1);
set(handles.edit_curb_height,'String',150);

%Chassis - Door
set(handles.edit_door_height,'String',2200);
set(handles.edit_door_width,'String',1800);
set(handles.edit_door_thickness,'String',6);
set(handles.popupmenu_door_material,'Value',2);

%Electronics - Lidar
set(handles.edit_lidar_height,'String',80);
set(handles.edit_lidar_diameter,'String',150);
set(handles.popupmenu_lidar_material,'Value',3);

%Air Condition
set(handles.edit_ac_length,'String',2000);
set(handles.edit_ac_width,'String',1500);
set(handles.edit_ac_height,'String',150);
set(handles.popupmenu_ac_material,'Value',1);

%Configuration Progress
set(handles.txt_M_Config_VS,'BackgroundColor',[0.06 0.66 0.53])
set(handles.txt_M_Config_PT,'BackgroundColor',[0.06 0.66 0.53])
set(handles.txt_M_Config_Susp,'BackgroundColor',[0.06 0.66 0.53])
set(handles.txt_M_Config_Ch,'BackgroundColor',[0.06 0.66 0.53])
set(handles.txt_M_Config_El,'BackgroundColor',[0.06 0.66 0.53])


%Workspace
assignin('base','l_overall',6000)
assignin('base','w_overall',2700)
assignin('base','h_overall',3100)
assignin('base','wheelbase',4200)
assignin('base','gc',150)
assignin('base','h_lift',0)
assignin('base','lay_urban1',0)
assignin('base','lay_urban2',0)
assignin('base','lay_coach',1)
assignin('base','central_motor_rear',1)
assignin('base','dual_motor_rear',0)
assignin('base','all_wheel_drive',0)
assignin('base','ramp_in',1)
assignin('base','ramp_out',0)
assignin('base','l_seat',400)
assignin('base','w_seat',400)
assignin('base','h_seat',450)
assignin('base','t_seat',40)
assignin('base','h_backrest',500)
assignin('base','l_leg_clearance',300)
assignin('base','w_seat_gap',50)
assignin('base','mat_seat','Plastic') 
assignin('base','p_shoulder_width',530)
assignin('base','p_body_depth',450)
assignin('base','l_motor',300)
assignin('base','d_motor',270)
assignin('base','mat_motor','Aluminium')
assignin('base','l_cooler',1200)
assignin('base','h_cooler',250)
assignin('base','t_cooler',50)
assignin('base','mat_cooler','Aluminium')
assignin('base','l_trans',235)
assignin('base','w_trans',370)
assignin('base','mat_trans','Aluminium')
assignin('base','l_inv',343)
assignin('base','w_inv',150)
assignin('base','h_inv',70)
assignin('base','mat_inv','Aluminium')
assignin('base','t_bat_box',4)
assignin('base','h_bat_el',15)
assignin('base','mat_bat_box','Aluminium')
assignin('base','V_bat',0.3540)
assignin('base','d_bat_cell',18)
assignin('base','h_bat_cell',65)
assignin('base','mat_bat_cell','Copper')
assignin('base','w_tire',215)
assignin('base','d_tire',767)
assignin('base','d_rim',19)
assignin('base','t_rim',10)
assignin('base','mat_tire','Rubber')
assignin('base','mat_rim','Aluminium')
assignin('base','da_bdisc',430)
assignin('base','di_bdisc',160)
assignin('base','t_bdisc',34)
assignin('base','mat_bdisc','Steel')
assignin('base','mat_bpad','Steel')
assignin('base','mat_bcaliper','Steel')
assignin('base','l_wcarrier',140)
assignin('base','w_wcarrier',90)
assignin('base','mat_wcarrier','Aluminium')
assignin('base','d_aarm',15)
assignin('base','t_aarm',10)
assignin('base','mat_aarm','Steel')
assignin('base','h_spring',285)
assignin('base','d_spring',300)
assignin('base','mat_spring','Rubber')
assignin('base','d_air_tank',250)
assignin('base','l_air_tank',450)
assignin('base','t_air_tank',1)
assignin('base','mat_air_tank','Aluminium')
assignin('base','d_compressor',200)
assignin('base','l_compressor',450)
assignin('base','t_compressor',4)
assignin('base','mat_compressor','Aluminium')
assignin('base','a_front',0)
assignin('base','a_rear',0)
assignin('base','t_axis',8)
assignin('base','d_axis',50)
assignin('base','mat_axis','Steel')
assignin('base','d_damper',50)
assignin('base','mat_damper','Aluminium')
assignin('base','h_r',400)
assignin('base','t_body',5)
assignin('base','mat_body','Plastic')
assignin('base','mat_wh','Plastic')
assignin('base','t_frame',8)
assignin('base','h_frame',100)
assignin('base','mat_frame','Steel')
assignin('base','t_window',6)
assignin('base','h_window_shoulder',940)
assignin('base','h_window',1285)
assignin('base','mat_window','Glass')
assignin('base','t_floor',5)
assignin('base','h_floor',350)
assignin('base','mat_floor','Aluminium')
assignin('base','l_ramp',1200)
assignin('base','w_ramp',1000)
assignin('base','t_ramp',50)
assignin('base','h_curb',150)
assignin('base','mat_ramp','Aluminium')
assignin('base','h_door',2200)
assignin('base','w_door',1800)
assignin('base','t_door',6)
assignin('base','mat_door','Glass')
assignin('base','h_lidar',80)
assignin('base','d_lidar',150)
assignin('base','mat_lidar','Glass')
assignin('base','l_ac',2000)
assignin('base','w_ac',1500)
assignin('base','h_ac',150)
assignin('base','mat_ac','Aluminium')


function edit_ac_width_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ac_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ac_width as text
%        str2double(get(hObject,'String')) returns contents of edit_ac_width as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end

h = findobj('Tag','edit_overall_width');
data = str2double(h.String);

lower_limit = 0.10*data; % min 15% of overall width 
upper_limit = 0.75*data ; % max 04% of overall width 
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end

%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_ac_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ac_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ac_height_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ac_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ac_height as text
%        str2double(get(hObject,'String')) returns contents of edit_ac_height as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 49;
upper_limit = 201;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_ac_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ac_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_ac_material.
function popupmenu_ac_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_ac_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_ac_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_ac_material


% --- Executes during object creation, after setting all properties.
function popupmenu_ac_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_ac_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ac_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ac_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ac_length as text
%        str2double(get(hObject,'String')) returns contents of edit_ac_length as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end

h = findobj('Tag','edit_overall_length');
data = str2double(h.String);

lower_limit = 0.1*data; % min 10% of overall length
upper_limit = 0.75*data; % max 75% of overall length
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_ac_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ac_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_lidar_height_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lidar_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lidar_height as text
%        str2double(get(hObject,'String')) returns contents of edit_lidar_height as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 49;
upper_limit = 101;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');       
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_lidar_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lidar_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_lidar_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lidar_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lidar_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_lidar_diameter as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 49;
upper_limit = 201;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_lidar_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lidar_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_lidar_material.
function popupmenu_lidar_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_lidar_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_lidar_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_lidar_material


% --- Executes during object creation, after setting all properties.
function popupmenu_lidar_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_lidar_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_Check_Electronics.
function pb_Check_Electronics_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Check_Electronics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Lidar
h_lidar = str2num(char(get(handles.edit_lidar_height,'String')));
assignin('base','h_lidar',h_lidar)
if (isempty(h_lidar))
    set(handles.edit_lidar_height,'BackgroundColor',[1 0 0])
else
    set(handles.edit_lidar_height,'BackgroundColor',[1 1 1])
end
d_lidar = str2num(char(get(handles.edit_lidar_diameter,'String')));
assignin('base','d_lidar',d_lidar)
if (isempty(d_lidar))
    set(handles.edit_lidar_diameter,'BackgroundColor',[1 0 0])
else
    set(handles.edit_lidar_diameter,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_lidar_material,'String');
mat_lidar = contents{get(handles.popupmenu_lidar_material,'Value')};
assignin('base','mat_lidar',mat_lidar)

%Air Condition
l_ac = str2num(char(get(handles.edit_ac_length,'String')));
assignin('base','l_ac',l_ac)
if (isempty(l_ac))
    set(handles.edit_ac_length,'BackgroundColor',[1 0 0])
else
    set(handles.edit_ac_length,'BackgroundColor',[1 1 1])
end
w_ac = str2num(char(get(handles.edit_ac_width,'String')));
assignin('base','w_ac',w_ac)
if (isempty(w_ac))
    set(handles.edit_ac_width,'BackgroundColor',[1 0 0])
else
    set(handles.edit_ac_width,'BackgroundColor',[1 1 1])
end
h_ac = str2num(char(get(handles.edit_ac_height,'String')));
assignin('base','h_ac',h_ac)
if (isempty(h_ac))
    set(handles.edit_ac_height,'BackgroundColor',[1 0 0])
else
    set(handles.edit_ac_height,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_ac_material,'String');
mat_ac = contents{get(handles.popupmenu_ac_material,'Value')};
assignin('base','mat_ac',mat_ac)

%%Check if input is correct
if (isempty(h_lidar) || isempty(d_lidar) || isempty(l_ac) || isempty(w_ac) || isempty(h_ac))
    h = warndlg('Please enter all required fields');
    set(handles.txt_M_Config_El,'BackgroundColor',[0.22 0.48 0.69])
  else
    set(handles.txt_M_Config_El,'BackgroundColor',[0.06 0.66 0.53])
  end

% --- Executes on button press in pb_Check_Chassis.
function pb_Check_Chassis_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Check_Chassis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Body
h_r = str2num(char(get(handles.edit_roof_height,'String')));
assignin('base','h_r',h_r)
if (isempty(h_r))
    set(handles.edit_roof_height,'BackgroundColor',[1 0 0])
else
    set(handles.edit_roof_height,'BackgroundColor',[1 1 1])
end
t_body = str2num(char(get(handles.edit_body_thickness,'String')));
assignin('base','t_body',t_body)
if (isempty(t_body))
    set(handles.edit_body_thickness,'BackgroundColor',[1 0 0])
else
    set(handles.edit_body_thickness,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_body_material,'String');
mat_body = contents{get(handles.popupmenu_body_material,'Value')};
contents = get(handles.popupmenu_wheelhouse_material,'String');
mat_wh = contents{get(handles.popupmenu_wheelhouse_material,'Value')};
assignin('base','mat_body',mat_body)
assignin('base','mat_wh',mat_wh)

%Frame
t_frame = str2num(char(get(handles.edit_frame_thickness,'String')));
assignin('base','t_frame',t_frame)
if (isempty(t_frame))
    set(handles.edit_frame_thickness,'BackgroundColor',[1 0 0])
else
    set(handles.edit_frame_thickness,'BackgroundColor',[1 1 1])
end
h_frame = str2num(char(get(handles.edit_frame_height,'String')));
assignin('base','h_frame',h_frame)
if (isempty(h_frame))
    set(handles.edit_frame_height,'BackgroundColor',[1 0 0])
else
    set(handles.edit_frame_height,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_frame_material,'String');
mat_frame = contents{get(handles.popupmenu_frame_material,'Value')};
assignin('base','mat_frame',mat_frame)

%Window
t_window = str2num(char(get(handles.edit_window_thickness,'String')));
assignin('base','t_window',t_window)
if (isempty(t_window))
    set(handles.edit_window_thickness,'BackgroundColor',[1 0 0])
else
    set(handles.edit_window_thickness,'BackgroundColor',[1 1 1])
end
h_window_shoulder = str2num(char(get(handles.edit_window_shoulder,'String')));
assignin('base','h_window_shoulder',h_window_shoulder)
if (isempty(h_window_shoulder))
    set(handles.edit_window_shoulder,'BackgroundColor',[1 0 0])
else
    set(handles.edit_window_shoulder,'BackgroundColor',[1 1 1])
end
h_window = str2num(char(get(handles.edit_window_height,'String')));
assignin('base','h_window',h_window)
if (isempty(h_window))
    set(handles.edit_window_height,'BackgroundColor',[1 0 0])
else
    set(handles.edit_window_height,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_window_material,'String');
mat_window = contents{get(handles.popupmenu_window_material,'Value')};
assignin('base','mat_window',mat_window)

%Floor
t_floor = str2num(char(get(handles.edit_floor_thickness,'String')));
assignin('base','t_floor',t_floor)
if (isempty(t_floor))
    set(handles.edit_floor_thickness,'BackgroundColor',[1 0 0])
else
    set(handles.edit_floor_thickness,'BackgroundColor',[1 1 1])
end
h_floor = str2num(char(get(handles.edit_floor_height,'String')));
assignin('base','h_floor',h_floor)
if (isempty(h_floor))
    set(handles.edit_floor_height,'BackgroundColor',[1 0 0])
else
    set(handles.edit_floor_height,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_floor_material,'String');
mat_floor = contents{get(handles.popupmenu_floor_material,'Value')};
assignin('base','mat_floor',mat_floor)

%Ramp
l_ramp = str2num(char(get(handles.edit_ramp_length,'String')));
assignin('base','l_ramp',l_ramp)
if (isempty(l_ramp))
    set(handles.edit_ramp_length,'BackgroundColor',[1 0 0])
else
    set(handles.edit_ramp_length,'BackgroundColor',[1 1 1])
end
w_ramp = str2num(char(get(handles.edit_ramp_width,'String')));
assignin('base','w_ramp',w_ramp)
if (isempty(w_ramp))
    set(handles.edit_ramp_width,'BackgroundColor',[1 0 0])
else
    set(handles.edit_ramp_width,'BackgroundColor',[1 1 1])
end
t_ramp = str2num(char(get(handles.edit_ramp_thickness,'String')));
assignin('base','t_ramp',t_ramp)
if (isempty(t_ramp))
    set(handles.edit_ramp_thickness,'BackgroundColor',[1 0 0])
else
    set(handles.edit_ramp_thickness,'BackgroundColor',[1 1 1])
end
h_curb = str2num(char(get(handles.edit_curb_height,'String')));
assignin('base','h_curb',h_curb)
if (isempty(h_curb))
    set(handles.edit_curb_height,'BackgroundColor',[1 0 0])
else
    set(handles.edit_curb_height,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_frame_material,'String');
mat_ramp = contents{get(handles.popupmenu_ramp_material,'Value')};
assignin('base','mat_ramp',mat_ramp)

%Door
h_door = str2num(char(get(handles.edit_door_height,'String')));
assignin('base','h_door',h_door)
if (isempty(h_door))
    set(handles.edit_door_height,'BackgroundColor',[1 0 0])
else
    set(handles.edit_door_height,'BackgroundColor',[1 1 1])
end
w_door = str2num(char(get(handles.edit_door_width,'String')));
assignin('base','w_door',w_door)
if (isempty(w_door))
    set(handles.edit_door_width,'BackgroundColor',[1 0 0])
else
    set(handles.edit_door_width,'BackgroundColor',[1 1 1])
end
t_door = str2num(char(get(handles.edit_door_thickness,'String')));
assignin('base','t_door',t_door)
if (isempty(t_door))
    set(handles.edit_door_thickness,'BackgroundColor',[1 0 0])
else
    set(handles.edit_door_thickness,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_door_material,'String');
mat_door = contents{get(handles.popupmenu_door_material,'Value')};
assignin('base','mat_door',mat_door)

%%Check if input is correct
if (isempty(h_r) || isempty(t_body) || isempty(t_frame) || isempty(h_frame) || isempty(t_window) || isempty(h_window_shoulder) || isempty(h_window) || isempty(t_floor) || isempty(h_floor) || isempty(l_ramp) || isempty(w_ramp) || isempty(t_ramp) || isempty(h_curb) || isempty(h_door) || isempty(w_door) || isempty(t_door))
    h = warndlg('Please enter all required fields');
    set(handles.txt_M_Config_Ch,'BackgroundColor',[0.22 0.48 0.69])
 else
    set(handles.txt_M_Config_Ch,'BackgroundColor',[0.06 0.66 0.53])
 end


function edit_ramp_width_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ramp_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ramp_width as text
%        str2double(get(hObject,'String')) returns contents of edit_ramp_width as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 799;
upper_limit = 1501;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_ramp_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ramp_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ramp_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ramp_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ramp_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_ramp_thickness as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 19;
upper_limit = 101;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_ramp_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ramp_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_ramp_material.
function popupmenu_ramp_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_ramp_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_ramp_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_ramp_material


% --- Executes during object creation, after setting all properties.
function popupmenu_ramp_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_ramp_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ramp_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ramp_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ramp_length as text
%        str2double(get(hObject,'String')) returns contents of edit_ramp_length as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 799;
upper_limit = 1501;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_ramp_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ramp_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_curb_height_Callback(hObject, eventdata, handles)
% hObject    handle to edit_curb_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_curb_height as text
%        str2double(get(hObject,'String')) returns contents of edit_curb_height as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 0;
upper_limit = 251;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});


% --- Executes during object creation, after setting all properties.
function edit_curb_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_curb_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_door_width_Callback(hObject, eventdata, handles)
% hObject    handle to edit_door_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_door_width as text
%        str2double(get(hObject,'String')) returns contents of edit_door_width as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 799;
upper_limit = 2501;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_door_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_door_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_door_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_door_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_door_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_door_thickness as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 1;
upper_limit = 11;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_door_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_door_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_door_material.
function popupmenu_door_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_door_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_door_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_door_material


% --- Executes during object creation, after setting all properties.
function popupmenu_door_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_door_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_door_height_Callback(hObject, eventdata, handles)
% hObject    handle to edit_door_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_door_height as text
%        str2double(get(hObject,'String')) returns contents of edit_door_height as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end

h1 = findobj('Tag','edit_overall_height');
data1 = str2double(h1.String);
h2 = findobj('Tag','edit_floor_height');
data2 = str2double(h2.String);
h3 = findobj('Tag','edit_ground_clearance');
data3 = str2double(h3.String);

lower_limit = 1799; % min 1.8m
upper_limit = data1 - (data2 + data3 + 180); % max height subtracted by floor height, roof and groundclearance
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_door_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_door_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_floor_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_floor_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_floor_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_floor_thickness as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 1;
upper_limit = 11;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_floor_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_floor_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_floor_height_Callback(hObject, eventdata, handles)
% hObject    handle to edit_floor_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_floor_height as text
%        str2double(get(hObject,'String')) returns contents of edit_floor_height as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 299;
upper_limit = 401;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_floor_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_floor_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_floor_material.
function popupmenu_floor_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_floor_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_floor_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_floor_material


% --- Executes during object creation, after setting all properties.
function popupmenu_floor_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_floor_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_frame_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_frame_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_frame_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_frame_thickness as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 1;
upper_limit = 11;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_frame_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_frame_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_frame_height_Callback(hObject, eventdata, handles)
% hObject    handle to edit_frame_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_frame_height as text
%        str2double(get(hObject,'String')) returns contents of edit_frame_height as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 19;
upper_limit = 151;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_frame_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_frame_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_frame_material.
function popupmenu_frame_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_frame_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_frame_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_frame_material


% --- Executes during object creation, after setting all properties.
function popupmenu_frame_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_frame_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_roof_height_Callback(hObject, eventdata, handles)
% hObject    handle to edit_roof_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_roof_height as text
%        str2double(get(hObject,'String')) returns contents of edit_roof_height as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 199;
upper_limit = 501;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_roof_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_roof_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_body_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_body_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_body_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_body_thickness as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 1;
upper_limit = 11;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_body_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_body_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_body_material.
function popupmenu_body_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_body_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_body_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_body_material


% --- Executes during object creation, after setting all properties.
function popupmenu_body_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_body_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_wheelhouse_material.
function popupmenu_wheelhouse_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_wheelhouse_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_wheelhouse_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_wheelhouse_material


% --- Executes during object creation, after setting all properties.
function popupmenu_wheelhouse_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_wheelhouse_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_window_shoulder_Callback(hObject, eventdata, handles)
% hObject    handle to edit_window_shoulder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_window_shoulder as text
%        str2double(get(hObject,'String')) returns contents of edit_window_shoulder as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 49;
upper_limit = 1251;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_window_shoulder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_window_shoulder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_window_height_Callback(hObject, eventdata, handles)
% hObject    handle to edit_window_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_window_height as text
%        str2double(get(hObject,'String')) returns contents of edit_window_height as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end

h1 = findobj('Tag','edit_door_height');
data1 = str2double(h1.String);
h2 = findobj('Tag','edit_window_shoulder');
data2 = str2double(h2.String);

lower_limit = 0.60*(data1 - data2); % min 20% of door height subtractet by window shoulder
upper_limit = data1 - data2; % max door height subtractet by window shoulder
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_window_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_window_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_window_material.
function popupmenu_window_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_window_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_window_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_window_material


% --- Executes during object creation, after setting all properties.
function popupmenu_window_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_window_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_window_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_window_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_window_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_window_thickness as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 1;
upper_limit = 11;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});


% --- Executes during object creation, after setting all properties.
function edit_window_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_window_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_Check_Suspension.
function pb_Check_Suspension_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Check_Suspension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Wheel
w_tire = str2num(char(get(handles.edit_tire_width,'String')));
assignin('base','w_tire',w_tire)
if (isempty(w_tire))
    set(handles.edit_tire_width,'BackgroundColor',[1 0 0])
else
    set(handles.edit_tire_width,'BackgroundColor',[1 1 1])
end
d_tire = str2num(char(get(handles.edit_tire_diameter,'String')));
assignin('base','d_tire',d_tire)
if (isempty(d_tire))
    set(handles.edit_tire_diameter,'BackgroundColor',[1 0 0])
else
    set(handles.edit_tire_diameter,'BackgroundColor',[1 1 1])
end
d_rim = str2num(char(get(handles.edit_rim_diameter,'String')));
assignin('base','d_rim',d_rim)
if (isempty(d_rim))
    set(handles.edit_rim_diameter,'BackgroundColor',[1 0 0])
else
    set(handles.edit_rim_diameter,'BackgroundColor',[1 1 1])
end
t_rim = str2num(char(get(handles.edit_rim_thickness,'String')));
assignin('base','t_rim',t_rim)
if (isempty(t_rim))
    set(handles.edit_rim_thickness,'BackgroundColor',[1 0 0])
else
    set(handles.edit_rim_thickness,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_tire_material,'String');
mat_tire = contents{get(handles.popupmenu_tire_material,'Value')};
contents = get(handles.popupmenu_rim_material,'String');
mat_rim = contents{get(handles.popupmenu_rim_material,'Value')};
assignin('base','mat_tire',mat_tire)
assignin('base','mat_rim',mat_rim)

%Breaking System
da_bdisc = str2num(char(get(handles.edit_disc_outer_diameter,'String')));
assignin('base','da_bdisc',da_bdisc)
if (isempty(da_bdisc))
    set(handles.edit_disc_outer_diameter,'BackgroundColor',[1 0 0])
else
    set(handles.edit_disc_outer_diameter,'BackgroundColor',[1 1 1])
end
di_bdisc = str2num(char(get(handles.edit_disc_inner_diameter,'String')));
assignin('base','di_bdisc',di_bdisc)
if (isempty(di_bdisc))
    set(handles.edit_disc_inner_diameter,'BackgroundColor',[1 0 0])
else
    set(handles.edit_disc_inner_diameter,'BackgroundColor',[1 1 1])
end
t_bdisc = str2num(char(get(handles.edit_disc_thickness,'String')));
assignin('base','t_bdisc',t_bdisc)
if (isempty(t_bdisc))
    set(handles.edit_disc_thickness,'BackgroundColor',[1 0 0])
else
    set(handles.edit_disc_thickness,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_disc_material,'String');
mat_bdisc = contents{get(handles.popupmenu_disc_material,'Value')};
contents = get(handles.popupmenu_brake_pad_material,'String');
mat_bpad = contents{get(handles.popupmenu_brake_pad_material,'Value')};
contents = get(handles.popupmenu_brake_caliper_material,'String');
mat_bcaliper = contents{get(handles.popupmenu_brake_caliper_material,'Value')};
assignin('base','mat_bdisc',mat_bdisc)
assignin('base','mat_bpad',mat_bpad)
assignin('base','mat_bcaliper',mat_bcaliper)

%Wheel Carrier
l_wcarrier = str2num(char(get(handles.edit_carrier_length,'String')));
assignin('base','l_wcarrier',l_wcarrier)
if (isempty(l_wcarrier))
    set(handles.edit_carrier_length,'BackgroundColor',[1 0 0])
else
    set(handles.edit_carrier_length,'BackgroundColor',[1 1 1])
end
w_wcarrier = str2num(char(get(handles.edit_carrier_width,'String')));
assignin('base','w_wcarrier',w_wcarrier)
if (isempty(w_wcarrier))
    set(handles.edit_carrier_width,'BackgroundColor',[1 0 0])
else
    set(handles.edit_carrier_width,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_carrier_material,'String');
mat_wcarrier = contents{get(handles.popupmenu_carrier_material,'Value')};
assignin('base','mat_wcarrier',mat_wcarrier)

%A-Arms
d_aarm = str2num(char(get(handles.edit_aarm_diameter,'String')));
assignin('base','d_aarm',d_aarm)
if (isempty(d_aarm))
    set(handles.edit_aarm_diameter,'BackgroundColor',[1 0 0])
else
    set(handles.edit_aarm_diameter,'BackgroundColor',[1 1 1])
end
t_aarm = str2num(char(get(handles.edit_aarm_thickness,'String')));
assignin('base','t_aarm',t_aarm)
if (isempty(t_aarm))
    set(handles.edit_aarm_thickness,'BackgroundColor',[1 0 0])
else
    set(handles.edit_aarm_thickness,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_aarm_material,'String');
mat_aarm = contents{get(handles.popupmenu_aarm_material,'Value')};
assignin('base','mat_aarm',mat_aarm)

%Air Suspension
h_spring = str2num(char(get(handles.edit_air_spring_height,'String')));
assignin('base','h_spring',h_spring)
if (isempty(h_spring))
    set(handles.edit_air_spring_height,'BackgroundColor',[1 0 0])
else
    set(handles.edit_air_spring_height,'BackgroundColor',[1 1 1])
end
d_spring = str2num(char(get(handles.edit_air_spring_diameter,'String')));
assignin('base','d_spring',d_spring)
if (isempty(d_spring))
    set(handles.edit_air_spring_diameter,'BackgroundColor',[1 0 0])
else
    set(handles.edit_air_spring_diameter,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_air_spring_material,'String');
mat_spring = contents{get(handles.popupmenu_air_spring_material,'Value')};
assignin('base','mat_spring',mat_spring)

d_air_tank = str2num(char(get(handles.edit_air_tank_diameter,'String')));
assignin('base','d_air_tank',d_air_tank)
if (isempty(d_air_tank))
    set(handles.edit_air_tank_diameter,'BackgroundColor',[1 0 0])
else
    set(handles.edit_air_tank_diameter,'BackgroundColor',[1 1 1])
end
l_air_tank = str2num(char(get(handles.edit_air_tank_length,'String')));
assignin('base','l_air_tank',l_air_tank)
if (isempty(l_air_tank))
    set(handles.edit_air_tank_length,'BackgroundColor',[1 0 0])
else
    set(handles.edit_air_tank_length,'BackgroundColor',[1 1 1])
end
t_air_tank = str2num(char(get(handles.edit_air_tank_thickness,'String')));
assignin('base','t_air_tank',t_air_tank)
if (isempty(t_air_tank))
    set(handles.edit_air_tank_thickness,'BackgroundColor',[1 0 0])
else
    set(handles.edit_air_tank_thickness,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_air_tank_material,'String');
mat_air_tank = contents{get(handles.popupmenu_air_tank_material,'Value')};
assignin('base','mat_air_tank',mat_air_tank)

d_compressor = str2num(char(get(handles.edit_compressor_diameter,'String')));
assignin('base','d_compressor',d_compressor)
if (isempty(d_compressor))
    set(handles.edit_compressor_diameter,'BackgroundColor',[1 0 0])
else
    set(handles.edit_compressor_diameter,'BackgroundColor',[1 1 1])
end
l_compressor = str2num(char(get(handles.edit_compressor_length,'String')));
assignin('base','l_compressor',l_compressor)
if (isempty(l_compressor))
    set(handles.edit_compressor_length,'BackgroundColor',[1 0 0])
else
    set(handles.edit_compressor_length,'BackgroundColor',[1 1 1])
end
t_compressor = str2num(char(get(handles.edit_compressor_thickness,'String')));
assignin('base','t_compressor',t_compressor)
if (isempty(t_compressor))
    set(handles.edit_compressor_thickness,'BackgroundColor',[1 0 0])
else
    set(handles.edit_compressor_thickness,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_compressor_material,'String');
mat_compressor = contents{get(handles.popupmenu_compressor_material,'Value')};
assignin('base','mat_compressor',mat_compressor)

%Steering Angle
a_front = str2num(char(get(handles.edit_front_angle,'String')));
assignin('base','a_front',a_front)
if (isempty(a_front))
    set(handles.edit_front_angle,'BackgroundColor',[1 0 0])
else
    set(handles.edit_front_angle,'BackgroundColor',[1 1 1])
end
a_rear = str2num(char(get(handles.edit_rear_angle,'String')));
assignin('base','a_rear',a_rear)
if (isempty(a_rear))
    set(handles.edit_rear_angle,'BackgroundColor',[1 0 0])
else
    set(handles.edit_rear_angle,'BackgroundColor',[1 1 1])
end

%Axis
t_axis = str2num(char(get(handles.edit_axis_thickness,'String')));
assignin('base','t_axis',t_axis)
if (isempty(t_axis))
    set(handles.edit_axis_thickness,'BackgroundColor',[1 0 0])
else
    set(handles.edit_axis_thickness,'BackgroundColor',[1 1 1])
end
d_axis = str2num(char(get(handles.edit_axis_diameter,'String')));
assignin('base','d_axis',d_axis)
if (isempty(d_axis))
    set(handles.edit_axis_diameter,'BackgroundColor',[1 0 0])
else
    set(handles.edit_axis_diameter,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_axis_material,'String');
mat_axis = contents{get(handles.popupmenu_axis_material,'Value')};
assignin('base','mat_axis',mat_axis)

%Damper
d_damper = str2num(char(get(handles.edit_damper_diameter,'String')));
assignin('base','d_damper',d_damper)
if (isempty(d_damper))
    set(handles.edit_damper_diameter,'BackgroundColor',[1 0 0])
else
    set(handles.edit_damper_diameter,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_damper_material,'String');
mat_damper = contents{get(handles.popupmenu_damper_material,'Value')};
assignin('base','mat_damper',mat_damper)

%%Check if input is correct
if (isempty(w_tire) || isempty(d_tire) || isempty(d_rim) || isempty(t_rim) || isempty(da_bdisc) || isempty(di_bdisc) || isempty(t_bdisc) || isempty(l_wcarrier) || isempty(w_wcarrier) || isempty(d_aarm) || isempty(t_aarm) || isempty(h_spring) || isempty(d_spring) || isempty(d_air_tank) || isempty(l_air_tank) || isempty(t_air_tank) || isempty(d_compressor) || isempty(l_compressor) || isempty(t_compressor) || isempty(a_front) || isempty(a_rear) || isempty(t_axis) || isempty(d_axis) || isempty(d_damper))
    h = warndlg('Please enter all required fields');
    set(handles.txt_M_Config_Susp,'BackgroundColor',[0.22 0.48 0.69])
else
    set(handles.txt_M_Config_Susp,'BackgroundColor',[0.06 0.66 0.53])
end


function edit_damper_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_damper_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_damper_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_damper_diameter as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 39;
upper_limit = 71;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_damper_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_damper_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_damper_material.
function popupmenu_damper_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_damper_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_damper_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_damper_material


% --- Executes during object creation, after setting all properties.
function popupmenu_damper_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_damper_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_axis_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_axis_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_axis_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_axis_thickness as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 0.5;
upper_limit = 16;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_axis_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_axis_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_axis_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_axis_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_axis_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_axis_diameter as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 14;
upper_limit = 81;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_axis_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_axis_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_axis_material.
function popupmenu_axis_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_axis_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_axis_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_axis_material


% --- Executes during object creation, after setting all properties.
function popupmenu_axis_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_axis_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_front_angle_Callback(hObject, eventdata, handles)
% hObject    handle to edit_front_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_front_angle as text
%        str2double(get(hObject,'String')) returns contents of edit_front_angle as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = -36;
upper_limit = 36;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_front_angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_front_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rear_angle_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rear_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rear_angle as text
%        str2double(get(hObject,'String')) returns contents of edit_rear_angle as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = -36;
upper_limit = 36;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_rear_angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rear_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_air_spring_height_Callback(hObject, eventdata, handles)
% hObject    handle to edit_air_spring_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_air_spring_height as text
%        str2double(get(hObject,'String')) returns contents of edit_air_spring_height as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 99;
upper_limit = 376;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_air_spring_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_air_spring_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_air_spring_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_air_spring_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_air_spring_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_air_spring_diameter as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 99;
upper_limit = 401;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_air_spring_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_air_spring_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_air_spring_material.
function popupmenu_air_spring_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_air_spring_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_air_spring_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_air_spring_material


% --- Executes during object creation, after setting all properties.
function popupmenu_air_spring_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_air_spring_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_air_tank_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_air_tank_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_air_tank_length as text
%        str2double(get(hObject,'String')) returns contents of edit_air_tank_length as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 249;
upper_limit = 601;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_air_tank_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_air_tank_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_air_tank_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_air_tank_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_air_tank_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_air_tank_thickness as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 0.5;
upper_limit = 9;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_air_tank_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_air_tank_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_air_tank_material.
function popupmenu_air_tank_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_air_tank_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_air_tank_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_air_tank_material


% --- Executes during object creation, after setting all properties.
function popupmenu_air_tank_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_air_tank_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_air_tank_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_air_tank_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_air_tank_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_air_tank_diameter as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 99;
upper_limit = 351;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});


% --- Executes during object creation, after setting all properties.
function edit_air_tank_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_air_tank_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_compressor_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_compressor_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_compressor_length as text
%        str2double(get(hObject,'String')) returns contents of edit_compressor_length as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 249;
upper_limit = 601;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_compressor_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_compressor_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_compressor_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_compressor_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_compressor_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_compressor_thickness as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 0.5;
upper_limit = 9;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_compressor_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_compressor_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_compressor_material.
function popupmenu_compressor_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_compressor_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_compressor_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_compressor_material


% --- Executes during object creation, after setting all properties.
function popupmenu_compressor_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_compressor_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_compressor_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_compressor_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_compressor_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_compressor_diameter as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 99;
upper_limit = 351;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});


% --- Executes during object creation, after setting all properties.
function edit_compressor_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_compressor_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_aarm_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aarm_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aarm_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_aarm_diameter as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 9;
upper_limit = 31;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_aarm_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aarm_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_aarm_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aarm_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aarm_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_aarm_thickness as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 4;
upper_limit = 16;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_aarm_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aarm_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_aarm_material.
function popupmenu_aarm_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_aarm_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_aarm_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_aarm_material


% --- Executes during object creation, after setting all properties.
function popupmenu_aarm_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_aarm_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_disc_inner_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_disc_inner_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_disc_inner_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_disc_inner_diameter as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end

h = findobj('Tag','edit_rim_diameter');
data = str2double(h.String);

lower_limit = 0.15*data*25.4; % min 15% of rim diameter *25.4 for inch to mm conversion
upper_limit = 0.4*data*25.4 ; % max 40% of rim diameter *25.4 for inch to mm conversion
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_disc_inner_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_disc_inner_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_disc_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_disc_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_disc_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_disc_thickness as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 19;
upper_limit = 51;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_disc_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_disc_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_disc_material.
function popupmenu_disc_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_disc_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_disc_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_disc_material


% --- Executes during object creation, after setting all properties.
function popupmenu_disc_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_disc_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_disc_outer_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_disc_outer_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_disc_outer_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_disc_outer_diameter as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end

h = findobj('Tag','edit_rim_diameter');
data = str2double(h.String);

lower_limit = 0.6*data*25.4; % min 60% of rim diameter *25.4 for inch to mm conversion
upper_limit = 0.9*data*25.4 ; % max 90% of rim diameter *25.4 for inch to mm conversion
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_disc_outer_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_disc_outer_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_brake_pad_material.
function popupmenu_brake_pad_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_brake_pad_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_brake_pad_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_brake_pad_material


% --- Executes during object creation, after setting all properties.
function popupmenu_brake_pad_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_brake_pad_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_brake_caliper_material.
function popupmenu_brake_caliper_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_brake_caliper_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_brake_caliper_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_brake_caliper_material


% --- Executes during object creation, after setting all properties.
function popupmenu_brake_caliper_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_brake_caliper_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_carrier_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_carrier_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_carrier_length as text
%        str2double(get(hObject,'String')) returns contents of edit_carrier_length as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 99;
upper_limit = 201;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_carrier_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_carrier_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_carrier_width_Callback(hObject, eventdata, handles)
% hObject    handle to edit_carrier_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_carrier_width as text
%        str2double(get(hObject,'String')) returns contents of edit_carrier_width as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 49;
upper_limit = 151;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_carrier_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_carrier_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_carrier_material.
function popupmenu_carrier_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_carrier_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_carrier_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_carrier_material


% --- Executes during object creation, after setting all properties.
function popupmenu_carrier_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_carrier_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rim_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rim_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rim_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_rim_diameter as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 14.9;
upper_limit = 22.5;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_rim_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rim_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rim_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rim_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rim_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_rim_thickness as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 4;
upper_limit = 21;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_rim_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rim_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_tire_material.
function popupmenu_tire_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_tire_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_tire_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_tire_material


% --- Executes during object creation, after setting all properties.
function popupmenu_tire_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_tire_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_rim_material.
function popupmenu_rim_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_rim_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_rim_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_rim_material


% --- Executes during object creation, after setting all properties.
function popupmenu_rim_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_rim_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_tire_width_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tire_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tire_width as text
%        str2double(get(hObject,'String')) returns contents of edit_tire_width as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 174;
upper_limit = 296;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_tire_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tire_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_tire_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tire_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tire_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_tire_diameter as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 549;
upper_limit = 1046;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_tire_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tire_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_Check_Powertrain.
function pb_Check_Powertrain_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Check_Powertrain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%Drivetrain
l_motor = str2num(char(get(handles.edit_motor_length,'String')));
assignin('base','l_motor',l_motor)
if (isempty(l_motor))
    set(handles.edit_motor_length,'BackgroundColor',[1 0 0])
else
    set(handles.edit_motor_length,'BackgroundColor',[1 1 1])
end
d_motor = str2num(char(get(handles.edit_motor_diameter,'String')));
assignin('base','d_motor',d_motor)
if (isempty(d_motor))
    set(handles.edit_motor_diameter,'BackgroundColor',[1 0 0])
else
    set(handles.edit_motor_diameter,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_motor_material,'String');
mat_motor = contents{get(handles.popupmenu_motor_material,'Value')};
assignin('base','mat_motor',mat_motor)

%Cooler
l_cooler = str2num(char(get(handles.edit_cooler_length,'String')));
assignin('base','l_cooler',l_cooler)
if (isempty(l_cooler))
    set(handles.edit_cooler_length,'BackgroundColor',[1 0 0])
else
    set(handles.edit_cooler_length,'BackgroundColor',[1 1 1])
end
h_cooler = str2num(char(get(handles.edit_cooler_height,'String')));
assignin('base','h_cooler',h_cooler)
if (isempty(h_cooler))
    set(handles.edit_cooler_height,'BackgroundColor',[1 0 0])
else
    set(handles.edit_cooler_height,'BackgroundColor',[1 1 1])
end
t_cooler = str2num(char(get(handles.edit_cooler_thickness,'String')));
assignin('base','t_cooler',t_cooler)
if (isempty(t_cooler))
    set(handles.edit_cooler_thickness,'BackgroundColor',[1 0 0])
else
    set(handles.edit_cooler_thickness,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_cooler_material,'String');
mat_cooler = contents{get(handles.popupmenu_cooler_material,'Value')};
assignin('base','mat_cooler',mat_cooler)

%Transmission
l_trans = str2num(char(get(handles.edit_transmission_length,'String')));
assignin('base','l_trans',l_trans)
if (isempty(l_trans))
    set(handles.edit_transmission_length,'BackgroundColor',[1 0 0])
else
    set(handles.edit_transmission_length,'BackgroundColor',[1 1 1])
end
w_trans = str2num(char(get(handles.edit_transmission_width,'String')));
assignin('base','w_trans',w_trans)
if (isempty(w_trans))
    set(handles.edit_transmission_width,'BackgroundColor',[1 0 0])
else
    set(handles.edit_transmission_width,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_transmission_material,'String');
mat_trans = contents{get(handles.popupmenu_transmission_material,'Value')};
assignin('base','mat_trans',mat_trans)

%Inverter
l_inv = str2num(char(get(handles.edit_inverter_length,'String')));
assignin('base','l_inv',l_inv)
if (isempty(l_inv))
    set(handles.edit_inverter_length,'BackgroundColor',[1 0 0])
else
    set(handles.edit_inverter_length,'BackgroundColor',[1 1 1])
end
w_inv = str2num(char(get(handles.edit_inverter_width,'String')));
assignin('base','w_inv',w_inv)
if (isempty(w_inv))
    set(handles.edit_inverter_width,'BackgroundColor',[1 0 0])
else
    set(handles.edit_inverter_width,'BackgroundColor',[1 1 1])
end
h_inv = str2num(char(get(handles.edit_inverter_height,'String')));
assignin('base','h_inv',h_inv)
if (isempty(h_inv))
    set(handles.edit_inverter_height,'BackgroundColor',[1 0 0])
else
    set(handles.edit_inverter_height,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_inverter_material,'String');
mat_inv = contents{get(handles.popupmenu_inverter_material,'Value')};
assignin('base','mat_inv',mat_inv)

%Battery Box
t_bat_box = str2num(char(get(handles.edit_thickness_box,'String')));
assignin('base','t_bat_box',t_bat_box)
if (isempty(t_bat_box))
    set(handles.edit_thickness_box,'BackgroundColor',[1 0 0])
else
    set(handles.edit_thickness_box,'BackgroundColor',[1 1 1])
end
h_bat_el = str2num(char(get(handles.edit_battery_electronics_height,'String')));
assignin('base','h_bat_el',h_bat_el)
if (isempty(h_bat_el))
    set(handles.edit_battery_electronics_height,'BackgroundColor',[1 0 0])
else
    set(handles.edit_battery_electronics_height,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_box_material,'String');
mat_bat_box = contents{get(handles.popupmenu_box_material,'Value')};
assignin('base','mat_bat_box',mat_bat_box)

%Battery Cell
V_bat = str2num(char(get(handles.edit_cell_volume,'String')));
assignin('base','V_bat',V_bat)
if (isempty(V_bat))
    set(handles.edit_cell_volume,'BackgroundColor',[1 0 0])
else
    set(handles.edit_cell_volume,'BackgroundColor',[1 1 1])
end
d_bat_cell = str2num(char(get(handles.edit_cell_diameter,'String')));
assignin('base','d_bat_cell',d_bat_cell)
if (isempty(d_bat_cell))
    set(handles.edit_cell_diameter,'BackgroundColor',[1 0 0])
else
    set(handles.edit_cell_diameter,'BackgroundColor',[1 1 1])
end
h_bat_cell = str2num(char(get(handles.edit_cell_height,'String')));
assignin('base','h_bat_cell',h_bat_cell)
if (isempty(h_bat_cell))
    set(handles.edit_cell_height,'BackgroundColor',[1 0 0])
else
    set(handles.edit_cell_height,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_cell_material,'String');
mat_bat_cell = contents{get(handles.popupmenu_cell_material,'Value')};
assignin('base','mat_bat_cell',mat_bat_cell)

%%Check if input is correct
if (isempty(l_motor) || isempty(d_motor) || isempty(l_cooler) || isempty(h_cooler) || isempty(t_cooler) || isempty(l_trans) || isempty(w_trans) || isempty(l_inv) || isempty(w_inv) ||  isempty(h_inv) || isempty(t_bat_box) || isempty(h_bat_el) || isempty(V_bat) || isempty(d_bat_cell) || isempty(h_bat_cell))
    h = warndlg('Please enter all required fields');
    set(handles.txt_M_Config_PT,'BackgroundColor',[0.22 0.48 0.69])
else
    set(handles.txt_M_Config_PT,'BackgroundColor',[0.06 0.66 0.53])
  end



function edit_cooler_height_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cooler_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cooler_height as text
%        str2double(get(hObject,'String')) returns contents of edit_cooler_height as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 99;
upper_limit = 501;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_cooler_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cooler_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_cooler_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cooler_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cooler_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_cooler_thickness as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 9;
upper_limit = 71;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_cooler_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cooler_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_cooler_material.
function popupmenu_cooler_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_cooler_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_cooler_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_cooler_material


% --- Executes during object creation, after setting all properties.
function popupmenu_cooler_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_cooler_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_cooler_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cooler_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cooler_length as text
%        str2double(get(hObject,'String')) returns contents of edit_cooler_length as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end

h1 = findobj('Tag','edit_overall_width');
data1 = str2double(h1.String);
h2 = findobj('Tag','edit_air_spring_diameter');
data2 = str2double(h2.String);
h3 = findobj('Tag','edit_tire_width');
data3 = str2double(h3.String);
h4 = findobj('Tag','edit_body_thickness');
data4 = str2double(h4.String);

lower_limit = 0.20*(data1 - (2*(data2 + data3 + data4 + 50))); % min 20% of overall width subtracted by width of wheelhouses
upper_limit = data1 - (2*(data2 + data3 + data4 + 50)); % max width subtracted by width of wheelhouses
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_cooler_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cooler_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_motor_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_motor_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_motor_length as text
%        str2double(get(hObject,'String')) returns contents of edit_motor_length as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 199;
upper_limit = 601;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_motor_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_motor_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_motor_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_motor_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_motor_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_motor_diameter as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 149;
upper_limit = 501;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_motor_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_motor_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_motor_material.
function popupmenu_motor_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_motor_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_motor_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_motor_material


% --- Executes during object creation, after setting all properties.
function popupmenu_motor_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_motor_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thickness_box_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thickness_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thickness_box as text
%        str2double(get(hObject,'String')) returns contents of edit_thickness_box as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 1;
upper_limit = 51;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_thickness_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_battery_electronics_height_Callback(hObject, eventdata, handles)
% hObject    handle to edit_battery_electronics_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_battery_electronics_height as text
%        str2double(get(hObject,'String')) returns contents of edit_battery_electronics_height as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 4;
upper_limit = 151;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_battery_electronics_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_battery_electronics_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_box_material.
function popupmenu_box_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_box_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_box_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_box_material


% --- Executes during object creation, after setting all properties.
function popupmenu_box_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_box_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_inverter_width_Callback(hObject, eventdata, handles)
% hObject    handle to edit_inverter_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_inverter_width as text
%        str2double(get(hObject,'String')) returns contents of edit_inverter_width as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 99;
upper_limit = 401;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_inverter_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_inverter_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_inverter_height_Callback(hObject, eventdata, handles)
% hObject    handle to edit_inverter_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_inverter_height as text
%        str2double(get(hObject,'String')) returns contents of edit_inverter_height as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 19;
upper_limit = 201;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_inverter_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_inverter_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_inverter_material.
function popupmenu_inverter_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_inverter_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_inverter_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_inverter_material


% --- Executes during object creation, after setting all properties.
function popupmenu_inverter_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_inverter_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_inverter_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_inverter_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_inverter_length as text
%        str2double(get(hObject,'String')) returns contents of edit_inverter_length as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 199;
upper_limit = 601;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_inverter_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_inverter_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_transmission_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_transmission_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_transmission_length as text
%        str2double(get(hObject,'String')) returns contents of edit_transmission_length as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 179;
upper_limit = 401;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_transmission_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_transmission_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_transmission_width_Callback(hObject, eventdata, handles)
% hObject    handle to edit_transmission_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_transmission_width as text
%        str2double(get(hObject,'String')) returns contents of edit_transmission_width as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 174;
upper_limit = 501;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_transmission_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_transmission_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_transmission_material.
function popupmenu_transmission_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_transmission_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_transmission_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_transmission_material


% --- Executes during object creation, after setting all properties.
function popupmenu_transmission_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_transmission_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_cell_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cell_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cell_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_cell_diameter as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 14;
upper_limit = 31;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_cell_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cell_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_cell_height_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cell_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cell_height as text
%        str2double(get(hObject,'String')) returns contents of edit_cell_height as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 39;
upper_limit = 121;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_cell_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cell_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_cell_material.
function popupmenu_cell_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_cell_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_cell_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_cell_material


% --- Executes during object creation, after setting all properties.
function popupmenu_cell_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_cell_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_cell_volume_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cell_volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cell_volume as text
%        str2double(get(hObject,'String')) returns contents of edit_cell_volume as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 0.099;
upper_limit = 0.701;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_cell_volume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cell_volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_Check_VehicleSpecification.
function pb_Check_VehicleSpecification_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Check_VehicleSpecification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Overall vehicle
l_overall = str2num(char(get(handles.edit_overall_length,'String')));
assignin('base','l_overall',l_overall)
if (isempty(l_overall))
    set(handles.edit_overall_length,'BackgroundColor',[1 0 0])
else
    set(handles.edit_overall_length,'BackgroundColor',[1 1 1])
end
w_overall = str2num(char(get(handles.edit_overall_width,'String')));
assignin('base','w_overall',w_overall)
if (isempty(w_overall))
    set(handles.edit_overall_width,'BackgroundColor',[1 0 0])
else
    set(handles.edit_overall_width,'BackgroundColor',[1 1 1])
end
h_overall = str2num(char(get(handles.edit_overall_height,'String')));
assignin('base','h_overall',h_overall)
if (isempty(h_overall))
    set(handles.edit_overall_height,'BackgroundColor',[1 0 0])
else
    set(handles.edit_overall_height,'BackgroundColor',[1 1 1])
end
wheelbase = str2num(char(get(handles.edit_wheelbase,'String')));
assignin('base','wheelbase',wheelbase)
if (isempty(wheelbase))
    set(handles.edit_wheelbase,'BackgroundColor',[1 0 0])
else
    set(handles.edit_wheelbase,'BackgroundColor',[1 1 1])
end
gc = str2num(char(get(handles.edit_ground_clearance,'String')));
assignin('base','gc',gc)
if (isempty(gc))
    set(handles.edit_ground_clearance,'BackgroundColor',[1 0 0])
else
    set(handles.edit_ground_clearance,'BackgroundColor',[1 1 1])
end
h_lift = str2num(char(get(handles.edit_lifting_height,'String')));
assignin('base','h_lift',h_lift)
if (isempty(h_lift))
    set(handles.edit_lifting_height,'BackgroundColor',[1 0 0])
else
    set(handles.edit_lifting_height,'BackgroundColor',[1 1 1])
end

%Vehicle Configuration
lay_urban1 = get(handles.checkbox_layout_urban1,'Value');
lay_urban2 = get(handles.checkbox_layout_urban2,'Value');
lay_coach = get(handles.checkbox_layout_coach,'Value');
assignin('base','lay_urban1',lay_urban1)
assignin('base','lay_urban2',lay_urban2)
assignin('base','lay_coach',lay_coach)

if (lay_urban1 == 0 && lay_urban2 == 0 && lay_coach == 0) 
    set(handles.uigr_SeatingLayout,'ForegroundColor',[1 0 0],'ShadowColor',[1 0 0])
else
    set(handles.uigr_SeatingLayout,'ForegroundColor',[0.22 0.48 0.69],'ShadowColor',[0.22 0.48 0.69])
end

central_motor_rear = get(handles.checkbox_central_motor_rear,'Value');
dual_motor_rear = get(handles.checkbox_dual_motor_rear,'Value');
all_wheel_drive = get(handles.checkbox_all_wheel_drive,'Value');
assignin('base','central_motor_rear',central_motor_rear)
assignin('base','dual_motor_rear',dual_motor_rear)
assignin('base','all_wheel_drive',all_wheel_drive)

if (central_motor_rear == 0 && dual_motor_rear == 0 && all_wheel_drive == 0) 
    set(handles.uigr_PowertrainLayout,'ForegroundColor',[1 0 0],'ShadowColor',[1 0 0])
else
    set(handles.uigr_PowertrainLayout,'ForegroundColor',[0.22 0.48 0.69],'ShadowColor',[0.22 0.48 0.69])
end

ramp_in = get(handles.checkbox_ramp_pulled_in,'Value');
ramp_out = get(handles.checkbox_ramp_deployed,'Value');
assignin('base','ramp_in',ramp_in)
assignin('base','ramp_out',ramp_out)

if (ramp_in == 0 && ramp_out == 0) 
    set(handles.uigr_RampLayout,'ForegroundColor',[1 0 0],'ShadowColor',[1 0 0])
else
    set(handles.uigr_RampLayout,'ForegroundColor',[0.22 0.48 0.69],'ShadowColor',[0.22 0.48 0.69])
end

%Interior
l_seat = str2num(char(get(handles.edit_seat_length,'String')));
assignin('base','l_seat',l_seat)
if (isempty(l_seat))
    set(handles.edit_seat_length,'BackgroundColor',[1 0 0])
else
    set(handles.edit_seat_length,'BackgroundColor',[1 1 1])
end
w_seat = str2num(char(get(handles.edit_seat_width,'String')));
assignin('base','w_seat',w_seat)
if (isempty(w_seat))
    set(handles.edit_seat_width,'BackgroundColor',[1 0 0])
else
    set(handles.edit_seat_width,'BackgroundColor',[1 1 1])
end
h_seat = str2num(char(get(handles.edit_seat_height,'String')));
assignin('base','h_seat',h_seat)
if (isempty(h_seat))
    set(handles.edit_seat_height,'BackgroundColor',[1 0 0])
else
    set(handles.edit_seat_height,'BackgroundColor',[1 1 1])
end
t_seat = str2num(char(get(handles.edit_seat_thickness,'String')));
assignin('base','t_seat',t_seat)
if (isempty(t_seat))
    set(handles.edit_seat_thickness,'BackgroundColor',[1 0 0])
else
    set(handles.edit_seat_thickness,'BackgroundColor',[1 1 1])
end
h_backrest = str2num(char(get(handles.edit_backrest_height,'String')));
assignin('base','h_backrest',h_backrest)
if (isempty(h_backrest))
    set(handles.edit_backrest_height,'BackgroundColor',[1 0 0])
else
    set(handles.edit_backrest_height,'BackgroundColor',[1 1 1])
end
l_leg_clearance = str2num(char(get(handles.edit_leg_clearance,'String')));
assignin('base','l_leg_clearance',l_leg_clearance)
if (isempty(l_leg_clearance))
    set(handles.edit_leg_clearance,'BackgroundColor',[1 0 0])
else
    set(handles.edit_leg_clearance,'BackgroundColor',[1 1 1])
end
w_seat_gap = str2num(char(get(handles.edit_seat_gap,'String')));
assignin('base','w_seat_gap',w_seat_gap)
if (isempty(w_seat_gap))
    set(handles.edit_seat_gap,'BackgroundColor',[1 0 0])
else
    set(handles.edit_seat_gap,'BackgroundColor',[1 1 1])
end
contents = get(handles.popupmenu_seat_material,'String'); 
mat_seat = contents{get(handles.popupmenu_seat_material,'Value')};
assignin('base','mat_seat',mat_seat)    
p_shoulder_width = str2num(char(get(handles.edit_passenger_shoulder_width,'String')));
assignin('base','p_shoulder_width',p_shoulder_width)
if (isempty(p_shoulder_width))
    set(handles.edit_passenger_shoulder_width,'BackgroundColor',[1 0 0])
else
    set(handles.edit_passenger_shoulder_width,'BackgroundColor',[1 1 1])
end
p_body_depth = str2num(char(get(handles.edit_passenger_body_depth,'String')));
assignin('base','p_body_depth',p_body_depth)
if (isempty(p_body_depth))
    set(handles.edit_passenger_body_depth,'BackgroundColor',[1 0 0])
else
    set(handles.edit_passenger_body_depth,'BackgroundColor',[1 1 1])
end

%%Check if input is correct
if (isempty(l_overall) || isempty(w_overall) || isempty(h_overall) || isempty(wheelbase) || isempty(gc) || isempty(h_lift) || isempty(l_seat) || isempty(w_seat) || isempty(h_seat) || isempty(t_seat) || isempty(h_backrest) || isempty(l_leg_clearance) || isempty(w_seat_gap) || isempty(mat_seat) || isempty(p_shoulder_width) || isempty(p_body_depth) || (lay_urban1==0 && lay_urban2==0 && lay_coach==0) || (central_motor_rear==0 && dual_motor_rear==0 && all_wheel_drive==0) || (ramp_in==0 && ramp_out==0))
    h = warndlg('Please enter all required fields');
    set(handles.txt_M_Config_VS,'BackgroundColor',[0.22 0.48 0.69])
  else
    set(handles.txt_M_Config_VS,'BackgroundColor',[0.06 0.66 0.53])
 end




function edit_overall_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_overall_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_overall_length as text
%        str2double(get(hObject,'String')) returns contents of edit_overall_length as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 3900;
upper_limit = 14001;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_overall_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_overall_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_overall_width_Callback(hObject, eventdata, handles)
% hObject    handle to edit_overall_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_overall_width as text
%        str2double(get(hObject,'String')) returns contents of edit_overall_width as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 1985;
upper_limit = 2701;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_overall_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_overall_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_overall_height_Callback(hObject, eventdata, handles)
% hObject    handle to edit_overall_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_overall_height as text
%        str2double(get(hObject,'String')) returns contents of edit_overall_height as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 2499;
upper_limit = 3501;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))}); 

% --- Executes during object creation, after setting all properties.
function edit_overall_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_overall_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_wheelbase_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wheelbase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wheelbase as text
%        str2double(get(hObject,'String')) returns contents of edit_wheelbase as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end

h = findobj('Tag','edit_overall_length');
data = str2double(h.String);

lower_limit = 0.60*data; % min 60% of overall length
upper_limit = 0.82*data; % max 82% of overall length
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_wheelbase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wheelbase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ground_clearance_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ground_clearance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ground_clearance as text
%        str2double(get(hObject,'String')) returns contents of edit_ground_clearance as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 149;
upper_limit = 301;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_ground_clearance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ground_clearance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_lifting_height_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lifting_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lifting_height as text
%        str2double(get(hObject,'String')) returns contents of edit_lifting_height as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = -101;
upper_limit = 101;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_lifting_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lifting_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_ramp_pulled_in.
function checkbox_ramp_pulled_in_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_ramp_pulled_in (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_ramp_pulled_in
set(handles.checkbox_ramp_deployed,'Value',0);

% --- Executes on button press in checkbox_ramp_deployed.
function checkbox_ramp_deployed_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_ramp_deployed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_ramp_deployed
set(handles.checkbox_ramp_pulled_in,'Value',0);

% --- Executes on button press in checkbox_central_motor_rear.
function checkbox_central_motor_rear_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_central_motor_rear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_central_motor_rear

set(handles.checkbox_all_wheel_drive,'Value',0);
set(handles.checkbox_dual_motor_rear,'Value',0);

% --- Executes on button press in checkbox_dual_motor_rear.
function checkbox_dual_motor_rear_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_dual_motor_rear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_dual_motor_rear

set(handles.checkbox_all_wheel_drive,'Value',0);
set(handles.checkbox_central_motor_rear,'Value',0);

% --- Executes on button press in checkbox_all_wheel_drive.
function checkbox_all_wheel_drive_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_all_wheel_drive (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_all_wheel_drive

set(handles.checkbox_dual_motor_rear,'Value',0);
set(handles.checkbox_central_motor_rear,'Value',0);

% --- Executes on button press in checkbox_layout_urban1.
function checkbox_layout_urban1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_layout_urban1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_layout_urban1

set(handles.checkbox_layout_urban2,'Value',0);
set(handles.checkbox_layout_coach,'Value',0);

% --- Executes on button press in checkbox_layout_urban2.
function checkbox_layout_urban2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_layout_urban2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_layout_urban2

set(handles.checkbox_layout_urban1,'Value',0);
set(handles.checkbox_layout_coach,'Value',0);

% --- Executes on button press in checkbox_layout_coach.
function checkbox_layout_coach_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_layout_coach (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_layout_coach

set(handles.checkbox_layout_urban1,'Value',0);
set(handles.checkbox_layout_urban2,'Value',0);

function edit_seat_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_seat_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_seat_length as text
%        str2double(get(hObject,'String')) returns contents of edit_seat_length as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 299;
upper_limit = 451;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_seat_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_seat_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_seat_material.
function popupmenu_seat_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_seat_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_seat_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_seat_material


% --- Executes during object creation, after setting all properties.
function popupmenu_seat_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_seat_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_seat_height_Callback(hObject, eventdata, handles)
% hObject    handle to edit_seat_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_seat_height as text
%        str2double(get(hObject,'String')) returns contents of edit_seat_height as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 399;
upper_limit = 551;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_seat_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_seat_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_seat_width_Callback(hObject, eventdata, handles)
% hObject    handle to edit_seat_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_seat_width as text
%        str2double(get(hObject,'String')) returns contents of edit_seat_width as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 349;
upper_limit = 501;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_seat_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_seat_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_seat_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_seat_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_seat_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_seat_thickness as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 9;
upper_limit = 51;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_seat_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_seat_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_backrest_height_Callback(hObject, eventdata, handles)
% hObject    handle to edit_backrest_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_backrest_height as text
%        str2double(get(hObject,'String')) returns contents of edit_backrest_height as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 449;
upper_limit = 801;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});


% --- Executes during object creation, after setting all properties.
function edit_backrest_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_backrest_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_leg_clearance_Callback(hObject, eventdata, handles)
% hObject    handle to edit_leg_clearance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_leg_clearance as text
%        str2double(get(hObject,'String')) returns contents of edit_leg_clearance as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 279;
upper_limit = 501;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_leg_clearance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_leg_clearance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_seat_gap_Callback(hObject, eventdata, handles)
% hObject    handle to edit_seat_gap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_seat_gap as text
%        str2double(get(hObject,'String')) returns contents of edit_seat_gap as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 19;
upper_limit = 101;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_seat_gap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_seat_gap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_passenger_shoulder_width_Callback(hObject, eventdata, handles)
% hObject    handle to edit_passenger_shoulder_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_passenger_shoulder_width as text
%        str2double(get(hObject,'String')) returns contents of edit_passenger_shoulder_width as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 399;
upper_limit = 851;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_passenger_shoulder_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_passenger_shoulder_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_passenger_body_depth_Callback(hObject, eventdata, handles)
% hObject    handle to edit_passenger_body_depth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_passenger_body_depth as text
%        str2double(get(hObject,'String')) returns contents of edit_passenger_body_depth as a double

x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end
lower_limit = 249;
upper_limit = 601;
%Output equals value of z if z falls between the bounds set by lower_limit
%and upper_limit. Otherwise it is 0 or an empty array
output = z*(z < upper_limit)*(z > lower_limit);
%If z does not fall within the bounds set by the limit parameters or is an
%empty array
if isempty(output) | (~output)
      %Set the output value to the limit value closest to z
      output = lower_limit*(z < lower_limit) + upper_limit*(z > upper_limit);
      %If there is no value in z, set the output value to the lower limit of
      %the desired bounds
      if isempty(output)
          output = lower_limit;
      end
      %Create a message string and initiate a message box informing the user
      %to enter a value within the limits of the defined range
      str = sprintf('Enter a number between %d and %d', lower_limit, upper_limit);
      warndlg(str,'Warning');
      status = system('nircmd win settopmost title "Warning" 1')
end
%Set the value of the text box to the new value, which lies within the
%value range
set(hObject,'String',{num2str(output(1))});

% --- Executes during object creation, after setting all properties.
function edit_passenger_body_depth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_passenger_body_depth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_M_Vizualisation.
function pb_M_Vizualisation_Callback(hObject, eventdata, handles)
% hObject    handle to pb_M_Vizualisation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Progress Button before visualization
l_overall = evalin('base','l_overall')
w_overall = evalin('base','w_overall')
h_overall = evalin('base','h_overall')
wheelbase = evalin('base','wheelbase')
gc = evalin('base','gc')
h_lift = evalin('base','h_lift');
lay_urban1 = evalin('base','lay_urban1')
lay_urban2 = evalin('base','lay_urban2')
lay_coach = evalin('base','lay_coach')
central_motor_rear = evalin('base','central_motor_rear')
dual_motor_rear = evalin('base','dual_motor_rear')
all_wheel_drive = evalin('base','all_wheel_drive')
ramp_in = evalin('base','ramp_in')
ramp_out = evalin('base','ramp_out')
l_seat = evalin('base','l_seat')
w_seat = evalin('base','w_seat')
h_seat = evalin('base','h_seat')
t_seat = evalin('base','t_seat')
h_backrest = evalin('base','h_backrest')
l_leg_clearance = evalin('base','l_leg_clearance')
w_seat_gap = evalin('base','w_seat_gap')
mat_seat = evalin('base','mat_seat') 
p_shoulder_width = evalin('base','p_shoulder_width')
p_body_depth = evalin('base','p_body_depth')
l_motor = evalin('base','l_motor')
d_motor = evalin('base','d_motor')
mat_motor = evalin('base','mat_motor')
l_cooler = evalin('base','l_cooler')
h_cooler = evalin('base','h_cooler')
t_cooler = evalin('base','t_cooler')
mat_cooler = evalin('base','mat_cooler')
l_trans = evalin('base','l_trans')
w_trans = evalin('base','w_trans')
mat_trans = evalin('base','mat_trans')
l_inv = evalin('base','l_inv')
w_inv = evalin('base','w_inv')
h_inv = evalin('base','h_inv')
mat_inv = evalin('base','mat_inv')
t_bat_box = evalin('base','t_bat_box')
h_bat_el = evalin('base','h_bat_el')
mat_bat_box = evalin('base','mat_bat_box')
V_bat = evalin('base','V_bat')
d_bat_cell = evalin('base','d_bat_cell')
h_bat_cell = evalin('base','h_bat_cell')
mat_bat_cell = evalin('base','mat_bat_cell')
w_tire = evalin('base','w_tire')
d_tire = evalin('base','d_tire')
d_rim = evalin('base','d_rim')
t_rim = evalin('base','t_rim')
mat_tire = evalin('base','mat_tire')
mat_rim = evalin('base','mat_rim')
da_bdisc = evalin('base','da_bdisc')
di_bdisc = evalin('base','di_bdisc')
t_bdisc = evalin('base','t_bdisc')
mat_bdisc = evalin('base','mat_bdisc')
mat_bpad = evalin('base','mat_bpad')
mat_bcaliper = evalin('base','mat_bcaliper')
l_wcarrier = evalin('base','l_wcarrier')
w_wcarrier = evalin('base','w_wcarrier')
mat_wcarrier = evalin('base','mat_wcarrier')
d_aarm = evalin('base','d_aarm')
t_aarm = evalin('base','t_aarm')
mat_aarm = evalin('base','mat_aarm')
h_spring = evalin('base','h_spring')
d_spring = evalin('base','d_spring')
mat_spring = evalin('base','mat_spring')
d_air_tank = evalin('base','d_air_tank')
l_air_tank = evalin('base','l_air_tank')
t_air_tank = evalin('base','t_air_tank')
mat_air_tank = evalin('base','mat_air_tank')
d_compressor = evalin('base','d_compressor')
l_compressor = evalin('base','l_compressor')
t_compressor = evalin('base','t_compressor')
mat_compressor = evalin('base','mat_compressor')
a_front = evalin('base','a_front')
a_rear = evalin('base','a_rear')
t_axis = evalin('base','t_axis')
d_axis = evalin('base','d_axis')
mat_axis = evalin('base','mat_axis')
d_damper = evalin('base','d_damper')
mat_damper = evalin('base','mat_damper')
h_r = evalin('base','h_r')
t_body = evalin('base','t_body')
mat_body = evalin('base','mat_body')
mat_wh = evalin('base','mat_wh')
t_frame = evalin('base','t_frame')
h_frame = evalin('base','h_frame')
mat_frame = evalin('base','mat_frame')
t_window = evalin('base','t_window')
h_window_shoulder = evalin('base','h_window_shoulder')
h_window = evalin('base','h_window')
mat_window = evalin('base','mat_window')
t_floor = evalin('base','t_floor')
h_floor = evalin('base','h_floor')
mat_floor = evalin('base','mat_floor')
l_ramp = evalin('base','l_ramp')
w_ramp = evalin('base','w_ramp')
t_ramp = evalin('base','t_ramp')
h_curb = evalin('base','h_curb')
mat_ramp = evalin('base','mat_ramp')
h_door = evalin('base','h_door')
w_door = evalin('base','w_door')
t_door = evalin('base','t_door')
mat_door = evalin('base','mat_door')
h_lidar = evalin('base','h_lidar')
d_lidar = evalin('base','d_lidar')
mat_lidar = evalin('base','mat_lidar')
l_ac = evalin('base','l_ac')
w_ac = evalin('base','w_ac')
h_ac = evalin('base','h_ac')
mat_ac = evalin('base','mat_ac')


%% Check if input is correct
if (isempty(l_overall) || isempty(w_overall) || isempty(h_overall) || isempty(wheelbase) || isempty(gc) || isempty(h_lift) || isempty(l_seat) || isempty(w_seat) || isempty(h_seat) || isempty(t_seat) || isempty(h_backrest) || isempty(w_seat_gap) || isempty(p_shoulder_width) || isempty(p_body_depth) || isempty(l_motor) || isempty(d_motor) || isempty(l_cooler) || isempty(h_cooler) || isempty(t_cooler) || isempty(l_trans) || isempty(w_trans) || isempty(l_inv) || isempty(w_inv) || isempty(h_inv) || isempty(V_bat) || isempty(d_bat_cell) || isempty(h_bat_cell) || isempty(t_bat_box) || isempty(h_bat_el) || isempty(h_lidar) || isempty(d_lidar) || isempty(l_ac) || isempty(w_ac) || isempty(h_ac) || isempty(w_tire) || isempty(d_tire) || isempty(d_rim) || isempty(t_rim) || isempty(da_bdisc) || isempty(di_bdisc) || isempty(t_bdisc) || isempty(l_wcarrier) || isempty(w_wcarrier) || isempty(d_aarm) || isempty(t_aarm) || isempty(h_spring) || isempty(d_spring) || isempty(d_air_tank) || isempty(l_air_tank) || isempty(t_air_tank) || isempty(d_compressor) || isempty(l_compressor) || isempty(t_compressor) || isempty(a_front) || isempty(a_rear) || isempty(t_axis) || isempty(d_axis) || isempty(d_damper) || isempty(h_r) || isempty(t_body) || isempty(h_door) || isempty(w_door) || isempty(t_door) || isempty(t_window) || isempty(h_window_shoulder) || isempty(h_window) || isempty(t_floor) || isempty(h_floor) || isempty(t_frame) || isempty(h_frame) || isempty(h_curb) || isempty(l_ramp) || isempty(w_ramp) || isempty(t_ramp) || (lay_urban1==0 && lay_urban2==0 && lay_coach==0) || (central_motor_rear==0 && dual_motor_rear==0 && all_wheel_drive==0) || (ramp_in==0 && ramp_out==0))
    warndlg('Please enter all required fields','Incomplete');
    status = system('nircmd win settopmost title "Incomplete" 1')
else
   %Close GUI
   
set(handles.uip_M_Visualization,'Visible','on');   

% All subsequent functions

% Calculation t_tire
[t_tire] = calc_tire(d_tire, d_rim);

% Calculation wheelbase
[wb] = calc_wheelbase(l_overall,wheelbase);

% Calculation floor



% Drivetrain layouts

if central_motor_rear == 1
    drivetrain_center_rear = 'true';
    drivetrain_dual_all = 'false';
    cooler_all = 'false';
    motor_all = 'false';
    trans_all = 'false';
    inv_all = 'false';
    
elseif dual_motor_rear == 1
    drivetrain_center_rear = 'false';
    drivetrain_dual_all = 'true';
    cooler_all = 'false';
    motor_all = 'false';
    trans_all = 'false';
    inv_all = 'false';
    
elseif all_wheel_drive == 1
    drivetrain_center_rear = 'false';
    drivetrain_dual_all = 'true';
    cooler_all = 'true';
    motor_all = 'true';
    trans_all = 'true';
    inv_all = 'true';
    
end

% Ramp layouts

if ramp_in == 1
    ramp_in = 'true';
    ramp_out = 'false';
    street = 'false';
    
elseif ramp_out == 1
    ramp_out = 'true';
    ramp_in = 'false';
    street = 'false';
    
end

% Writing values of GUI Manual in txt.file for CAD model
UpdateParameters_Manual(l_overall, w_overall, h_overall, gc, h_ac, h_r, h_door, d_tire, wb, w_door, w_tire, t_tire, a_front, a_rear, t_rim, d_axis, t_axis, da_bdisc, di_bdisc, t_bdisc, t_body, h_lift, V_bat, h_bat_cell,...
    t_bat_box, h_bat_el, t_floor, l_ac, w_ac, d_bat_cell, h_lidar, d_lidar, t_door, t_window, l_motor, d_motor, l_trans, w_trans, l_inv, w_inv, h_inv, t_frame, h_frame, d_spring, h_spring, w_wcarrier, t_aarm, d_aarm, d_damper,...
    l_wcarrier, l_air_tank, d_air_tank, t_air_tank, d_compressor, t_compressor, l_compressor, h_seat, w_seat, l_seat, t_seat, h_backrest, l_leg_clearance, w_seat_gap, l_cooler, h_cooler, t_cooler, h_floor, h_window_shoulder, h_curb,...
    l_ramp, w_ramp, t_ramp, h_window, mat_wh, mat_body, mat_door, mat_window, mat_floor, mat_frame, mat_ramp, mat_ac, mat_lidar, mat_seat, mat_bat_box, mat_bat_cell, mat_motor, mat_trans, mat_inv, mat_cooler, mat_tire, mat_rim, mat_bdisc,...
    mat_bpad, mat_bcaliper, mat_axis, mat_wcarrier, mat_aarm, mat_spring, mat_damper, mat_air_tank, mat_compressor, drivetrain_center_rear, drivetrain_dual_all, cooler_all, motor_all, trans_all, inv_all, ramp_in, ramp_out, street);

% Calculation seat layouts
% Calculation seat layout UL1
if lay_urban1 == 1
    lay_urban1 = 'true';
    lay_urban2 = 'false';
    lay_coach = 'false';

    [n_ul1_rear, n_ul1_window, n_ul1_door, n_ul1_passenger, n_ul1_seats, n_ul1_standing, per_ul1_sitting, per_ul1_standing, w_rest_gap_window_ul1, w_rest_gap_rear_ul1, w_rest_gap_door_ul1, seat_ul1_front, seat_ul1_rear, seat_ul1_door_rear, seat_ul1_door_front, pattern_seat_ul1_front, pattern_seat_ul1_rear, pattern_seat_ul1_door_rear, pattern_seat_ul1_door_front] = calc_seat_layout_ul1 (l_overall, w_overall, h_overall, gc, wb, wheelbase, h_lift, d_tire, w_tire, d_spring, t_body, w_door, w_seat, l_seat, t_seat, l_leg_clearance, w_seat_gap, p_shoulder_width, p_body_depth);

    % Writing values of layout UL1 in txt.file for CAD model
    UpdateParameters_Layout_ul1 (n_ul1_rear, n_ul1_window, n_ul1_door, w_rest_gap_window_ul1, w_rest_gap_rear_ul1, w_rest_gap_door_ul1, lay_urban1, lay_urban2, lay_coach, seat_ul1_front, seat_ul1_rear, seat_ul1_door_rear, seat_ul1_door_front, pattern_seat_ul1_front, pattern_seat_ul1_rear, pattern_seat_ul1_door_rear, pattern_seat_ul1_door_front);

    
% Calculation seat layout UL2
elseif lay_urban2 == 1
    lay_urban1 = 'false';
    lay_urban2 = 'true';
    lay_coach = 'false';
    
    [n_ul2_rear, n_ul2_window, n_ul2_door, n_ul2_passenger, n_ul2_seats, n_ul2_standing, per_ul2_sitting, per_ul2_standing, w_rest_gap_door_ul2, w_rest_gap_window_ul2, w_rest_gap_rear_ul2,  seat_ul2_door_front, seat_ul2_front, seat_ul2_door_rear, seat_ul2_rear, pattern_seat_ul2_door_front, pattern_seat_ul2_front, pattern_seat_ul2_door_rear, pattern_seat_ul2_rear] = calc_seat_layout_ul2 (l_overall, w_overall, h_overall, gc, wb, wheelbase, h_lift, w_tire, d_spring, t_body, w_door, w_seat, l_seat, t_seat, l_leg_clearance, w_seat_gap, p_shoulder_width, p_body_depth);
    
    % Writing values of layout UL2 in txt.file for CAD model
    UpdateParameters_Layout_ul2 (n_ul2_rear, n_ul2_window, n_ul2_door, w_rest_gap_door_ul2, w_rest_gap_window_ul2, w_rest_gap_rear_ul2, lay_urban1, lay_urban2, lay_coach, seat_ul2_door_front, seat_ul2_front, seat_ul2_door_rear, seat_ul2_rear, pattern_seat_ul2_door_front, pattern_seat_ul2_front, pattern_seat_ul2_door_rear, pattern_seat_ul2_rear);
    
% Calculation seat layout CL1
elseif lay_coach == 1
    lay_urban1 = 'false';
    lay_urban2 = 'false';
    lay_coach = 'true';
    
    [n_cl1_rear, n_cl1_window, n_cl1_door, n_cl1_passenger, n_cl1_seats, n_cl1_standing, per_cl1_sitting, per_cl1_standing, w_rest_gap_rear_cl1, w_rest_gap_window_cl1, w_rest_gap_door_cl1, seat_cl1_door] = calc_seat_layout_cl1 (l_overall, w_overall, h_overall, gc, wb, wheelbase, h_lift, d_tire, w_tire, d_spring, t_body, w_door, w_seat, l_seat, t_seat, l_leg_clearance, w_seat_gap, p_shoulder_width, p_body_depth);
    
    % Writing values of layout CL1 in txt.file for CAD model
    UpdateParameters_Layout_cl1 (n_cl1_rear, n_cl1_window, n_cl1_door, w_rest_gap_rear_cl1, w_rest_gap_window_cl1, w_rest_gap_door_cl1, lay_urban1, lay_urban2, lay_coach, seat_cl1_door);
    
end    

end   



% --- Executes on button press in pb_M_Visu_Visualization.
function pb_M_Visu_Visualization_Callback(hObject, eventdata, handles)
% hObject    handle to pb_M_Visu_startVisu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_M_Visu_Analysis.
function pb_M_Visu_Analysis_Callback(hObject, eventdata, handles)
% hObject    handle to pb_M_Visu_Analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_M_Visu_startVisu.
function pb_M_Visu_startVisu_Callback(hObject, eventdata, handles)
% hObject    handle to pb_M_Visu_startVisu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Waitbar
% status = system('nircmd win settopmost title "CATIA V5" 0')
wait = waitbar(0,'Please wait...','Name','Visualization');
status = system('nircmd win settopmost title "Visualization" 1')
pause(.3)
waitbar(.11,wait,'Loading your data','Name','Visualization');
pause(.2)
waitbar(.22,wait,'Loading your data','Name','Visualization');
% pause(1)

trigger = '';
global path_base
fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'wt');
% global path_base
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'wt');
fprintf(fid,'%s',trigger);
fclose(fid);

% Execute CATIA macro
winopen CATIA_Open_Update_Save.CATScript;

% Check if macro is finished
i=1;
while i==1
    fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'rt');
%     fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'rt');
    trigger = fgetl(fid);
    fclose(fid);
    if trigger == 'trigger'
        i = 2;
    end
end

waitbar(.33,wait,'Loading your data','Name','Visualization');

% Execute CATIA macro
winopen CATIA_Measure_Mass_COG.CATScript;

% Set trigger = '' for CATIA application in catia_trigger.txt
trigger = '';
fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'wt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'wt');
fprintf(fid,'%s',trigger);
fclose(fid);

waitbar(.44,wait,'Loading your data','Name','Visualization');

% Execute CATIA macro
winopen CATIA_Screenshots.CATScript;

% Check if macro is finished
i=1;
while i==1
    fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'rt');
%     fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'rt');
    trigger = fgetl(fid);
    fclose(fid);
    if trigger == 'trigger'
        i = 2;
    end
end

waitbar(.55,wait,'Loading your data','Name','Visualization');

% Set trigger = '' for CATIA application in catia_trigger.txt
trigger = '';
fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'wt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'wt');
fprintf(fid,'%s',trigger);
fclose(fid);

% Execute CATIA macro
winopen CATIA_Screenshot_Suspension.CATScript;

% Check if macro is finished
i=1;
while i==1
    fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'rt');
%     fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'rt');
    trigger = fgetl(fid);
    fclose(fid);
    if trigger == 'trigger'
        i = 2;
    end
end

waitbar(.66,wait,'Loading your data','Name','Visualization');

% Set trigger = '' for CATIA application in catia_trigger.txt
trigger = '';
fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'wt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'wt');
fprintf(fid,'%s',trigger);
fclose(fid);

% Execute CATIA macro
winopen CATIA_Screenshot_Interior.CATScript;

% Check if macro is finished
i=1;
while i==1
    fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'rt');
%     fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'rt');
    trigger = fgetl(fid);
    fclose(fid);
    if trigger == 'trigger'
        i = 2;
    end
end

waitbar(.77,wait,'Loading your data','Name','Visualization');

% Set trigger = '' for CATIA application in catia_trigger.txt
trigger = '';
fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'wt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'wt');
fprintf(fid,'%s',trigger);
fclose(fid);

winopen CATIA_Close.CATscript;

waitbar(.88,wait,'Processing your data','Name','Visualization');
pause(1)

%% load screenshots

% Image Bus Iso View
Screenshot_ISO = imread('Bus_ISO.png');
Screenshot_ISO = imresize(Screenshot_ISO,1/3);
set(handles.pushbutton_bus_iso,'CData',Screenshot_ISO)


% Image Bus Front View
Screenshot_Front = imread('Bus_Front.png');
Screenshot_Front = imresize(Screenshot_Front,1/3);
set(handles.pushbutton_bus_front,'CData',Screenshot_Front)


% Image Bus Side View
Screenshot_Side = imread('Bus_Side.png');
Screenshot_Side = imresize(Screenshot_Side,1/5);
set(handles.pushbutton_bus_side,'CData',Screenshot_Side)


% Load vehicle specification DB
load([path_base '\10_Results\Components\Selection.mat']);
%load(['T:\04_Cluster_C\500_SRT\033_SRT Package\Parametric Model\AEV_Tool\10_Results\Components\Selection.mat']);
% load('Selection.mat')

exist n_ul1_passenger
check_ul1 = ans;
exist n_ul2_passenger
check_ul2 = ans;
exist n_cl1_passenger
check_cl1 = ans;

if check == 'db'
    
    % Set Vehicle Specifications
    set(handles.text_output_overall_length, 'String', num2str(l_overall));
    set(handles.text_output_overall_width, 'String', num2str(w_overall));
    set(handles.text_output_overall_height, 'String', num2str(h_overall));
    set(handles.text_output_wheelbase, 'String', num2str(wheelbase));
    
    
    air_suspension_type = strcat(AirSuspension_selection.brand,{' '},AirSuspension_selection.style_number);
    set(handles.text_air_suspension, 'String', air_suspension_type);
    
    brake_type = strcat(Brake_selection.brand,{' '},Brake_selection.brake);
    set(handles.text_brake, 'String', brake_type);
    
    brake_type = strcat(Brake_selection.brand,{' '},Brake_selection.brake);
    set(handles.text_brake, 'String', brake_type);
    
    tire_type = strcat(Tyre_selection.brand,{' '},num2str(Tyre_selection.width),{'\'},num2str(Tyre_selection.aspect_ratio),{' '},Tyre_selection.construction,num2str(Tyre_selection.rim_size));
    set(handles.text_tire, 'String', tire_type);
    
    %set(handles.uibuttongroup_suspension_specification,'visible','on');
    %set(handles.uibuttongroup_interior_specification,'visible','off');
    
    
    
    load ('Link_selection','t_aarm','d_aarm');
    set(handles.text_suspension_links, 'String', num2str(d_aarm*2));
    
    
    
    % Image Bus Suspension View
    [x,map]=imread('Bus_Suspension_ISO.png');
    I4=imresize(x, [4200 11300]);
    f=figure;
    imagesc(x);set(gcf,'Visible', 'off');
    set(gca,'units','normalized','position',[0 0 1 1]);
%     set(gcf,'units','pixels','position',[150 150 550 260]);
    I4=getframe(gca);
    I4=I4.cdata;
    close(f)
    set(handles.pushbutton_details,'cdata',I4);
    
    
    
    
    % Load vehicle specification Manual
    % Layout UL1
elseif  check_ul1 == 1
    set(handles.text_output_overall_length, 'String', num2str(l_overall));
    set(handles.text_output_overall_width, 'String', num2str(w_overall));
    set(handles.text_output_overall_height, 'String', num2str(h_overall));
    set(handles.text_output_ground_clearance, 'String', num2str(gc));
    set(handles.text_output_wheelbase, 'String', num2str(wheelbase));
    set(handles.text_output_lifting_height, 'String', num2str(h_lift));
    set(handles.text_output_interior_layout, 'String', 'Urban_1');
    set(handles.text_output_number_of_passenger, 'String', num2str(n_ul1_passenger));
    set(handles.text_output_number_of_seats, 'String', num2str(n_ul1_seats));
    set(handles.text_output_number_of_standing_people, 'String', num2str(n_ul1_standing));
    set(handles.text_output_percentage_sitting, 'String', num2str(per_ul1_sitting));
    set(handles.text_output_percentage_standing, 'String', num2str(per_ul1_standing));
    
    assignin('base','number_person',n_ul1_passenger)
    
    %set(handles.uibuttongroup_suspension_specification,'visible','off');
    %set(handles.uibuttongroup_interior_specification,'visible','on');

    
    % Layout UL2
elseif check_ul2 == 1
    set(handles.text_output_overall_length, 'String', num2str(l_overall));
    set(handles.text_output_overall_width, 'String', num2str(w_overall));
    set(handles.text_output_overall_height, 'String', num2str(h_overall));
    set(handles.text_output_ground_clearance, 'String', num2str(gc));
    set(handles.text_output_wheelbase, 'String', num2str(wheelbase));
    set(handles.text_output_lifting_height, 'String', num2str(h_lift));
    set(handles.text_output_interior_layout, 'String', 'Urban_2');
    set(handles.text_output_number_of_passenger, 'String', num2str(n_ul2_passenger));
    set(handles.text_output_number_of_seats, 'String', num2str(n_ul2_seats));
    set(handles.text_output_number_of_standing_people, 'String', num2str(n_ul2_standing));
    set(handles.text_output_percentage_sitting, 'String', num2str(per_ul2_sitting));
    set(handles.text_output_percentage_standing, 'String', num2str(per_ul2_standing));
    
    assignin('base','number_person',n_ul2_passenger)
    
    %set(handles.uibuttongroup_suspension_specification,'visible','off');
    %set(handles.uibuttongroup_interior_specification,'visible','on');
  
    
    
    % Load vehicle specification Manual - Layout CL1
elseif check_cl1 == 1
    set(handles.text_output_overall_length, 'String', num2str(l_overall));
    set(handles.text_output_overall_width, 'String', num2str(w_overall));
    set(handles.text_output_overall_height, 'String', num2str(h_overall));
    set(handles.text_output_ground_clearance, 'String', num2str(gc));
    set(handles.text_output_wheelbase, 'String', num2str(wheelbase));
    set(handles.text_output_lifting_height, 'String', num2str(h_lift));
    set(handles.text_output_interior_layout, 'String', 'Coach_1');
    set(handles.text_output_number_of_passenger, 'String', num2str(n_cl1_passenger));
    set(handles.text_output_number_of_seats, 'String', num2str(n_cl1_seats));
    set(handles.text_output_number_of_standing_people, 'String', num2str(n_cl1_standing));
    set(handles.text_output_percentage_sitting, 'String', num2str(per_cl1_sitting));
    set(handles.text_output_percentage_standing, 'String', num2str(per_cl1_standing));
    
    assignin('base','number_person',n_cl1_passenger)
    
    %set(handles.uibuttongroup_suspension_specification,'visible','off');
    %set(handles.uibuttongroup_interior_specification,'visible','on');
 
%     
end

Screenshot_Layout = imread('Bus_Interior.png');
Screenshot_Layout = imresize(Screenshot_Layout,1/5);
set(handles.pushbutton_details,'CData',Screenshot_Layout)

% Load vehicle specification from CATIA - Mass & Center of Gravity
fid = fopen([path_base '06_Exchange\catia_inertia.txt'], 'rt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_inertia.txt'], 'rt');
inertia = fgetl(fid);
fclose(fid);

inertia_array = strsplit(inertia);
m_overall =  str2double(inertia_array{1,1});
inertia_coo_x =  str2double(inertia_array{1,2})*1000; %mm
inertia_coo_y =  str2double(inertia_array{1,3})*1000; %mm
inertia_coo_z =  str2double(inertia_array{1,4})*1000; %mm
assignin('base','m_overall',m_overall)
save([path_base '06_Exchange\inertia.mat','inertia_array']);
% save(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\inertia.mat','inertia_array']);


set(handles.text_output_total_weight, 'String', num2str(m_overall));
%assignin('base','m_overall',m_overall)
set(handles.text_output_cog_x, 'String', num2str(inertia_coo_x));
set(handles.text_output_cog_y, 'String', num2str(inertia_coo_y));
set(handles.text_output_cog_z, 'String', num2str(inertia_coo_z));

inertia = '';
fid = fopen([path_base '06_Exchange\catia_inertia.txt'], 'wt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_inertia.txt'], 'wt');
fprintf(fid,'%s',inertia);
fclose(fid);

waitbar(1,wait,'Finishing','Name','Visualization');
pause(3)

close(wait)
   


% --- Executes on button press in pushbutton_details.
function pushbutton_details_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_details (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_bus_front.
function pushbutton_bus_front_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_bus_front (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_bus_side.
function pushbutton_bus_side_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_bus_side (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_bus_iso.
function pushbutton_bus_iso_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_bus_iso (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_M_Visu_back.
function pb_M_Visu_back_Callback(hObject, eventdata, handles)
% hObject    handle to pb_M_Visu_back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uip_ManualMode,'Visible','on');
set(handles.uip_M_Visualization,'Visible','off');


% --- Executes on button press in pb_M_Visu_Cad.
function pb_M_Visu_Cad_Callback(hObject, eventdata, handles)
% hObject    handle to pb_M_Visu_Cad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

winopen CATIA_Open_Update_Save.CATScript;
status = system('nircmd win settopmost title "CATIA V5 - [SRT_2030.CATProduct]" 1')
status = system('nircmd win settopmost title "TUMCREATE" 0')

% --- Executes on button press in pb_StartPage.
function pb_StartPage_Callback(hObject, eventdata, handles)
% hObject    handle to pb_StartPage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uip_M_Config,'Visible','off')
set(handles.uip_ConfigurationProgress_Automated,'Visible','off')
set(handles.uip_Automated_Analysis,'Visible','off')
set(handles.uip_Automated,'Visible','off');
set(handles.uip_M_Visualization,'Visible','off');
set(handles.uip_ManualMode,'Visible','off');
set(handles.uip_DART,'Visible','off');

set(handles.uip_StartPage,'Visible','on');
set(handles.txt_Mode,'String','AEV - Tool');

% --- Executes on button press in pb_CE_PowerBattery.
function pb_CE_PowerBattery_Callback(hObject, eventdata, handles)
% hObject    handle to pb_CE_PowerBattery (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Vizualisation of Battery Performance

HVAC_Data = evalin('base','HVAC_Data');
rabbit = evalin('base','rabbit');
row_pt = evalin('base','row_pt');
Powertrain_Data = evalin('base','Powertrain_Data');

P_Battery = Powertrain_Data.simout.Battery.P_bat_actual__W_.Data;       %convert timeseries to double
% P_Battery = Result_simout.simout.Battery.P_bat_actual__W_.Data;      % convert timeseries to double 
assignin('base','P_Battery',P_Battery)
    

%% Electrical Power (Battery)
axes(handles.ax_P_Battery)
plot(P_Battery)
set(gca,'XLim',[0 1222])
ylabel('Power in W')
xlabel('Time in s')
title('Energy Consumption Battery');

set(handles.uip_cover_Battery,'Visible','off');
set(handles.uip_P_Battery,'Visible','on');

% --- Executes on button press in pb_CE_PMotor.
function pb_CE_PMotor_Callback(hObject, eventdata, handles)
% hObject    handle to pb_CE_PMotor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

HVAC_Data = evalin('base','HVAC_Data');
rabbit = evalin('base','rabbit');
row_pt = evalin('base','row_pt');
Powertrain_Data = evalin('base','Powertrain_Data');

RES.gear_actual{1} = Powertrain_Data.simout.Drivetrain.gear_TM_actual_FA____.data;
RES.gear_actual{2} = Powertrain_Data.simout.Drivetrain.gear_TM_actual_FA____.data;
RES.gear_actual{3} = Powertrain_Data.simout.Drivetrain.gear_TM_actual_RA____.data;
RES.gear_actual{4} = Powertrain_Data.simout.Drivetrain.gear_TM_actual_RA____.data;

  %% Motor 1 Front 
     
  if ~isempty(Powertrain_Data.Init.Drivetrain.MOT{1})
        axes(handles.ax_Motor_Map1) 
        set(handles.ax_Motor_Map1,'Visible','on');
        [Weighted, eff_ov,e] = VISUALIZE_load_points_FR_180226( ...
            Powertrain_Data.DU{1}.eff_n_DU, Powertrain_Data.DU{1}.eff_T_DU, Powertrain_Data.DU{1}.eff_DU,...
            Powertrain_Data.RES.n_mot{1}, Powertrain_Data.RES.T_mot{1}, Powertrain_Data.RES.gear_actual{1});
        title(gca,'Drive Unit: Motor Front (1)');
        xlabel(gca,'Motor Speed in rpm');
        ylabel(gca,'Motor Torque in Nm');
        
        set(handles.txt_ME_MaxTorque_ed,'String',num2str(round(max(Powertrain_Data.RES.T_mot{1,1}*100))/100));
        set(handles.txt_ME_AvgMotorEff_ed,'String',num2str(mean(Powertrain_Data.RES.EFF.MOT{1,1}*100),'%.2f'));
        set(handles.txt_ME_AvgTransEff_ed,'String',num2str(mean(Powertrain_Data.RES.EFF.TM{1,1}*100),'%.2f'));
        set(handles.txt_ME_AvgInvEff_ed,'String',num2str(mean(Powertrain_Data.RES.EFF.INV{1,1}*100),'%.2f'));
  end
     
     %% Motor 1 Rear
    
  if ~isempty(Powertrain_Data.Init.Drivetrain.MOT{3})
        axes(handles.ax_Motor_Map3) 
        set(handles.ax_Motor_Map3,'Visible','on');
        [Weighted, eff_ov,e] = VISUALIZE_load_points_FR_180226( ...
            Powertrain_Data.DU{3}.eff_n_DU, Powertrain_Data.DU{3}.eff_T_DU, Powertrain_Data.DU{3}.eff_DU,...
            Powertrain_Data.RES.n_mot{3}, Powertrain_Data.RES.T_mot{3}, Powertrain_Data.RES.gear_actual{3});
        title(gca,'Drive Unit: Motor Rear (1)');
        xlabel(gca,'Motor Speed in rpm');
        ylabel(gca,'Motor Torque in Nm');
        
        set(handles.txt_ME_MaxTorque_Back_ed,'String',num2str(round(max(Powertrain_Data.RES.T_mot{1,3}*100))/100));
        set(handles.txt_ME_AvgMotorEff_Back_ed,'String',num2str(mean(Powertrain_Data.RES.EFF.MOT{1,3}*100),'%.2f'));
        set(handles.txt_ME_AvgTransEff_Back_ed,'String',num2str(mean(Powertrain_Data.RES.EFF.TM{1,3}*100),'%.2f'));
        set(handles.txt_ME_AvgInvEff_Back_ed,'String',num2str(mean(Powertrain_Data.RES.EFF.INV{1,3}*100),'%.2f'));
  end
     
    %% Motor 2 Front

  if ~isempty(Powertrain_Data.Init.Drivetrain.MOT{2})
        axes(handles.ax_Motor_Map2) 
        set(handles.ax_Motor_Map2,'Visible','on');
        [Weighted, eff_ov,e] = VISUALIZE_load_points_FR_180226( ...
            Powertrain_Data.DU{2}.eff_n_DU, Powertrain_Data.DU{2}.eff_T_DU, Powertrain_Data.DU{2}.eff_DU,...
            Powertrain_Data.RES.n_mot{2}, Powertrain_Data.RES.T_mot{2}, Powertrain_Data.RES.gear_actual{2});
        title(gca,'Drive Unit: Motor Front (2)');
        xlabel(gca,'Motor Speed in rpm');
        ylabel(gca,'Motor Torque in Nm');
        
        set(handles.txt_ME_MaxTorque_ed_2,'String',num2str(round(max(Powertrain_Data.RES.T_mot{1,2}*100))/100));
        set(handles.txt_ME_AvgMotorEff_ed_2,'String',num2str(mean(Powertrain_Data.RES.EFF.MOT{1,2}*100),'%.2f'));
        set(handles.txt_ME_AvgTransEff_ed_2,'String',num2str(mean(Powertrain_Data.RES.EFF.TM{1,2}*100),'%.2f'));
        set(handles.txt_ME_AvgInvEff_ed_2,'String',num2str(mean(Powertrain_Data.RES.EFF.INV{1,2}*100),'%.2f'));
  end
  
  %% Motor 2 Rear
  
  if ~isempty(Powertrain_Data.Init.Drivetrain.MOT{4})
        axes(handles.ax_Motor_Map4) 
        set(handles.ax_Motor_Map4,'Visible','on');
        [Weighted, eff_ov,e] = VISUALIZE_load_points_FR_180226( ...
            Powertrain_Data.DU{4}.eff_n_DU, Powertrain_Data.DU{4}.eff_T_DU, Powertrain_Data.DU{4}.eff_DU,...
            Powertrain_Data.RES.n_mot{4}, Powertrain_Data.RES.T_mot{4}, Powertrain_Data.RES.gear_actual{4});
        title(gca,'Drive Unit: Motor Rear (2)');
        xlabel(gca,'Motor Speed in rpm');
        ylabel(gca,'Motor Torque in Nm');
        
        set(handles.txt_ME_MaxTorque_Back_ed_2,'String',num2str(round(max(Powertrain_Data.RES.T_mot{1,4}*100))/100));
        set(handles.txt_ME_AvgMotorEff_Back_ed_2,'String',num2str(mean(Powertrain_Data.RES.EFF.MOT{1,4}*100),'%.2f'));
        set(handles.txt_ME_AvgTransEff_Back_ed_2,'String',num2str(mean(Powertrain_Data.RES.EFF.TM{1,4}*100),'%.2f'));
        set(handles.txt_ME_AvgInvEff_Back_ed_2,'String',num2str(mean(Powertrain_Data.RES.EFF.INV{1,4}*100),'%.2f'));
  end

set(handles.uip_cover_Motor,'Visible','off');
set(handles.uip_MotorEff_Front1,'Visible','on');
set(handles.uip_Motor_Text_Front,'Visible','on');
set(handles.uip_cover_Motor_Text,'Visible','off');
% set(handles.uip_MotorEff_Front2,'Visible','on')
% set(handles.uip_MotorEff_Back1,'Visible','on')
% set(handles.uip_MotorEff_Back2,'Visible','on')
% set(handles.uip_MotorEff_Front1,'Visible','on')
% set(handles.uip_Motor_Text_Front,'Visible','on');
% set(handles.uip_Motor_Text_Back,'Visible','on');
% set(handles.uip_Motor_Text_Front_2,'Visible','on');
% set(handles.uip_Motor_Text_Back_2,'Visible','on');
 
% --- Executes on button press in pb_Motor_forward_Front1.
function pb_Motor_forward_Front1_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Motor_forward_Front1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% decide between 1 Motor per Axle and 2 Motors per Axle
rabbit = evalin('base','rabbit');

set(handles.uip_MotorEff_Front1,'Visible','off');
set(handles.uip_MotorEff_Back2,'Visible','off');
set(handles.uip_Motor_Text_Front,'Visible','off');
set(handles.uip_Motor_Text_Back_2,'Visible','off');

if (rabbit == 100 || rabbit == 101)     % 1 Motor per Axle

% Efficency Map
set(handles.uip_MotorEff_Back1,'Visible','on');

% Textfield
set(handles.uip_Motor_Text_Back,'Visible','on');
      
else if (rabbit == 102 || rabbit == 103)    % 2 Motors per Axle
        
% Efficency Map
set(handles.uip_MotorEff_Front2,'Visible','on');

% Textfield
set(handles.uip_Motor_Text_Front_2,'Visible','on');

    end
end

% --- Executes on button press in pb_Motor_forward_Back1.
function pb_Motor_forward_Back1_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Motor_forward_Back1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% decide between 1 Motor per Axle and 2 Motors per Axle
rabbit = evalin('base','rabbit');

set(handles.uip_MotorEff_Front2,'Visible','off')
set(handles.uip_MotorEff_Back1,'Visible','off')
set(handles.uip_Motor_Text_Back,'Visible','off');
set(handles.uip_Motor_Text_Front_2,'Visible','off');

if (rabbit == 100 || rabbit == 101)     % 1 Motor per Axle
    
% Efficency Map
set(handles.uip_MotorEff_Front1,'Visible','on');

% Textfield
set(handles.uip_Motor_Text_Front,'Visible','on');


else if (rabbit == 102 || rabbit == 103)    % 2 Motors per Axle

% Efficency Map
set(handles.uip_MotorEff_Back2,'Visible','on');

% Textfield
set(handles.uip_Motor_Text_Back_2,'Visible','on');

    end
end

% --- Executes on button press in pb_Motor_forward_Back2.
function pb_Motor_forward_Back2_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Motor_forward_Back2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uip_MotorEff_Front2,'Visible','off')
set(handles.uip_MotorEff_Back1,'Visible','off')
set(handles.uip_MotorEff_Back2,'Visible','off')
set(handles.uip_MotorEff_Front1,'Visible','on')

set(handles.uip_Motor_Text_Back_2,'Visible','off');
set(handles.uip_Motor_Text_Front,'Visible','on');

% --- Executes on button press in pb_Motor_forward_Front2.
function pb_Motor_forward_Front2_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Motor_forward_Front2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uip_MotorEff_Front2,'Visible','off')
set(handles.uip_MotorEff_Back1,'Visible','on')
set(handles.uip_MotorEff_Back2,'Visible','off')
set(handles.uip_MotorEff_Front1,'Visible','off')

set(handles.uip_Motor_Text_Front_2,'Visible','off');
set(handles.uip_Motor_Text_Back,'Visible','on');

% --- Executes on button press in pb_DART_Seats.
function pb_DART_Seats_Callback(hObject, eventdata, handles)
% hObject    handle to pb_DART_Seats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_DART_Front.
function pb_DART_Front_Callback(hObject, eventdata, handles)
% hObject    handle to pb_DART_Front (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_DART_Side.
function pb_DART_Side_Callback(hObject, eventdata, handles)
% hObject    handle to pb_DART_Side (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_DART_ISO.
function pb_DART_ISO_Callback(hObject, eventdata, handles)
% hObject    handle to pb_DART_ISO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_Dart_Arrow_1.
function pb_Dart_Arrow_1_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Dart_Arrow_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uip_DART_Spec1,'Visible','off');
set(handles.uip_DART_Spec2,'Visible','on');

% --- Executes on button press in pb_Dart_Arrow_2.
function pb_Dart_Arrow_2_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Dart_Arrow_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uip_DART_Spec1,'Visible','on');
set(handles.uip_DART_Spec2,'Visible','off');


% --- Executes on button press in pb_Presentation.
function pb_Presentation_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Presentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% winopen cmd.exe
status = system('nircmd win settopmost title "TUMCREATE" 0')
status = system('nircmd win settopmost title "AEV Tool" 1')


% --- Executes on button press in pb_Close.
function pb_Close_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uip_Automated_Info_Seating,'Visible','off');
set(handles.uip_Automated_Info_Standing,'Visible','off');
set(handles.uip_Automated_Info_2Zone,'Visible','off');

% --- Executes on button press in pb_info_standing.
function pb_info_standing_Callback(hObject, eventdata, handles)
% hObject    handle to pb_info_standing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pb_info_standing

set(handles.uip_Automated_Info_Seating,'Visible','off');
set(handles.uip_Automated_Info_Standing,'Visible','on');
set(handles.uip_Automated_Info_2Zone,'Visible','off');

% --- Executes on button press in pb_info_2zones.
function pb_info_2zones_Callback(hObject, eventdata, handles)
% hObject    handle to pb_info_2zones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pb_info_2zones

set(handles.uip_Automated_Info_Seating,'Visible','off');
set(handles.uip_Automated_Info_Standing,'Visible','off');
set(handles.uip_Automated_Info_2Zone,'Visible','on');


% --- Executes on button press in pb_delete.
function pb_delete_Callback(hObject, eventdata, handles)
% hObject    handle to pb_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hold off

% arrayfun(@cla,findall(0,'type','axes'))
% close(gcbf) TUMCREATE
set(findobj(0,'style','edit'),'string','')          % delete all the edit boxes
set(findobj(0,'style','checkbox'),'Value',0)        % return checkbox to 0
set(findobj(0,'style','pushbutton'),'Value',0)      % return push button to 0
set(findobj(0,'style','togglebutton'),'Value',0)    % return toggle button to 0
set(findobj(0,'style','radiobutton'),'Value',0)     % return radio button to 0
% evalin('base','clear all');


evalin('base','clearvars -except HVAC_Data');   % delete workspace except database

%% Configuration Progess Manual Mode

set(handles.txt_M_Config_VS,'BackgroundColor',[0.22 0.48 0.69])
set(handles.txt_M_Config_PT,'BackgroundColor',[0.22 0.48 0.69])
set(handles.txt_M_Config_Susp,'BackgroundColor',[0.22 0.48 0.69])
set(handles.txt_M_Config_Ch,'BackgroundColor',[0.22 0.48 0.69])
set(handles.txt_M_Config_El,'BackgroundColor',[0.22 0.48 0.69])

%% Configuration Progress Automated Mode

set(handles.txt_Config_VS,'BackgroundColor',[0.22 0.48 0.69])
set(handles.txt_Config_PT,'BackgroundColor',[0.22 0.48 0.69])
set(handles.txt_Config_CH,'BackgroundColor',[0.22 0.48 0.69])
set(handles.txt_Config_HVAC,'BackgroundColor',[0.22 0.48 0.69])

%% Vehicle Specification

set(handles.tb_30,'Enable','on');
set(handles.tb_40,'Enable','on');
set(handles.tb_50,'Enable','on');
set(handles.tb_60,'Enable','on');
set(handles.tb_70,'Enable','on');
set(handles.slider1,'Enable','off');
set(handles.pb_NoP_ind,'Enable','off');

%% change graphics
axes(handles.ax_Powertrain1)
imshow('Powertrain_base.jpg')

axes(handles.ax_Powertrain2)
labels = {'','','',''};
pie([25 25 25 25],labels)
colormap(handles.ax_Powertrain2,[1 1 1;1 1 1;1 1 1;1 1 1]);

% Benchmark
axes(handles.ax_Benchmark)
plot(1)
set(handles.ax_Benchmark,'YColor',[1 1 1],'YLim',[0 1],'YTick',[0:0.5:1],...
    'XColor',[1 1 1],'XLim',[0 1],'XTick',[0:0.5:1])

% Drive Cycle
set(handles.uip_cover_DriveCycle,'Visible','on');
set(handles.uip_DriveCycle,'Visible','off');

% Energy Loss
set(handles.uip_cover_EnergyLoss,'Visible','on');
set(handles.uip_cover_EnergyLoss_text,'Visible','on');
set(handles.uip_EnergyLoss,'Visible','off');
set(handles.uip_CE_EnergyLoss,'Visible','off');

axes(handles.ax_EnergyLoss)
hold off
plot(1)
set(handles.ax_EnergyLoss,'YColor',[1 1 1],'YLim',[0 1],'YTick',[0:0.5:1],...
    'XColor',[1 1 1],'XLim',[0 1],'XTick',[0:0.5:1])
 
% Power Battery
set(handles.uip_cover_Battery,'Visible','on');
set(handles.uip_P_Battery,'Visible','off');

% Motor Efficiency
set(handles.uip_cover_Motor,'Visible','on');
set(handles.uip_cover_Motor_Text,'Visible','on');
set(handles.uip_MotorEff_Front2,'Visible','off')
set(handles.uip_MotorEff_Back1,'Visible','off')
set(handles.uip_MotorEff_Back2,'Visible','off')
set(handles.uip_MotorEff_Front1,'Visible','off')
set(handles.uip_Motor_Text_Front,'Visible','off');
set(handles.uip_Motor_Text_Back,'Visible','off');
set(handles.uip_Motor_Text_Front_2,'Visible','off');
set(handles.uip_Motor_Text_Back_2,'Visible','off');


%% Currency Change
set(handles.tb_CE_SGD,'Value',0.0);
set(handles.tb_CE_Euro,'Value',1.0);

set(handles.tb_CE_Euro,'BackgroundColor',[0.06 0.66 0.53]);
set(handles.tb_CE_SGD,'BackgroundColor',[0.65 0.65 0.65]);

% Change Currency to Euro
set(handles.txt_CE_Currency,'String','€')

% Vehicle Concept
hold off
axes(handles.ax_spiderchart_VC1)
plot(1)
set(handles.ax_spiderchart_VC1,'YColor',[1 1 1],'YLim',[0 1],'YTick',[0:0.5:1],...
    'XColor',[1 1 1],'XLim',[0 1],'XTick',[0:0.5:1])

axes(handles.ax_spiderchart_VC1_C)
plot(1)
set(handles.ax_spiderchart_VC1_C,'YColor',[1 1 1],'YLim',[0 1],'YTick',[0:0.5:1],...
    'XColor',[1 1 1],'XLim',[0 1],'XTick',[0:0.5:1])

axes(handles.ax_spiderchart_VC2)
plot(1)
set(handles.ax_spiderchart_VC2,'YColor',[1 1 1],'YLim',[0 1],'YTick',[0:0.5:1],...
    'XColor',[1 1 1],'XLim',[0 1],'XTick',[0:0.5:1])

axes(handles.ax_spiderchart_VC2_C)
plot(1)
set(handles.ax_spiderchart_VC2_C,'YColor',[1 1 1],'YLim',[0 1],'YTick',[0:0.5:1],...
    'XColor',[1 1 1],'XLim',[0 1],'XTick',[0:0.5:1])

axes(handles.ax_spiderchart_total)
plot(1)
set(handles.ax_spiderchart_total,'YColor',[1 1 1],'YLim',[0 1],'YTick',[0:0.5:1],...
    'XColor',[1 1 1],'XLim',[0 1],'XTick',[0:0.5:1])



% --- Executes on button press in pb_Automated_Visualization.
function pb_Automated_Visualization_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Automated_Visualization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Page Calback
set(handles.uip_VehicleSpecification,'Visible','off');
set(handles.uip_Powertrain,'Visible','off');
set(handles.uip_Chassis,'Visible','off');
set(handles.uip_Cooling,'Visible','off');
set(handles.uip_Automated_Visualization,'Visible','on');
set(handles.uip_Powertrain_Simulation,'Visible','off');


% --- Executes on button press in pb_Play.
function pb_Play_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

wait = waitbar(0,'Please wait...','Name','Visualization');

%% Values for Visualization
llen = evalin('base','llen');
wb = evalin('base','wb');
tb_SA_standing = evalin('base','tb_SA_standing');
tb_SA_2zones = evalin('base','tb_SA_2zones');
tb_SA_seats = evalin('base','tb_SA_seats');

%Workspace
l_overall = double(llen)+500;
w_overall = 2700;
h_overall = 3100;
wheelbase = double(wb);
gc = 150;
h_lift = 0;
lay_urban1 = tb_SA_standing;
lay_urban2 = tb_SA_2zones;
lay_coach = tb_SA_seats;
% lay_urban1 = 0;
% lay_urban2 = 0;
% lay_coach = 1;
central_motor_rear = 1;
dual_motor_rear = 0;
all_wheel_drive = 0;
ramp_in = 1;
ramp_out = 0;
l_seat = 400;
w_seat = 400;
h_seat = 450;
t_seat = 40;
h_backrest = 500;
l_leg_clearance = 300;
w_seat_gap = 50;
mat_seat = 'Plastic'; 
p_shoulder_width = 530;
p_body_depth = 450;
l_motor = 300;
d_motor = 270;
mat_motor = 'Aluminium';
l_cooler = 1200;
h_cooler = 250;
t_cooler = 50;
mat_cooler = 'Aluminium';
l_trans = 235;
w_trans = 370;
mat_trans = 'Aluminium';
l_inv = 343;
w_inv = 150;
h_inv = 70;
mat_inv = 'Aluminium';
t_bat_box = 4;
h_bat_el = 15;
mat_bat_box = 'Aluminium';
V_bat = 0.3540;
d_bat_cell = 18;
h_bat_cell = 65;
mat_bat_cell = 'Copper';
w_tire = 215;
d_tire = 767;
d_rim = 19;
t_rim = 10;
mat_tire = 'Rubber';
mat_rim = 'Aluminium';
da_bdisc = 430;
di_bdisc = 160;
t_bdisc = 34;
mat_bdisc = 'Steel';
mat_bpad = 'Steel';
mat_bcaliper = 'Steel';
l_wcarrier = 140;
w_wcarrier = 90;
mat_wcarrier = 'Aluminium';
d_aarm = 15;
t_aarm = 10;
mat_aarm = 'Steel';
h_spring = 285;
d_spring = 300;
mat_spring = 'Rubber';
d_air_tank = 250;
l_air_tank = 450;
t_air_tank = 1;
mat_air_tank = 'Aluminium';
d_compressor = 200;
l_compressor = 450;
t_compressor = 4;
mat_compressor = 'Aluminium';
a_front = 0;
a_rear = 0;
t_axis = 8;
d_axis = 50;
mat_axis = 'Steel';
d_damper = 50;
mat_damper = 'Aluminium';
h_r = 400;
t_body = 5;
mat_body = 'Plastic';
mat_wh = 'Plastic';
t_frame = 8;
h_frame = 100;
mat_frame = 'Steel';
t_window = 6;
h_window_shoulder = 940;
h_window = 1285;
mat_window = 'Glass';
t_floor = 5;
h_floor = 350;
mat_floor = 'Aluminium';
l_ramp = 1200;
w_ramp = 1000;
t_ramp = 50;
h_curb = 150;
mat_ramp = 'Aluminium';
h_door = 2200;
w_door = 1800;
t_door = 6;
mat_door = 'Glass';
h_lidar = 80;
d_lidar = 150;
mat_lidar = 'Glass';
l_ac = 2000;
w_ac = 1500;
h_ac = 150;
mat_ac = 'Aluminium';

%% Suspension Model

%% Check if input is correct

waitbar(.11,wait,'Loading your data','Name','Visualization');
% Calculation t_tire
[t_tire] = calc_tire(d_tire, d_rim);

% Calculation wheelbase
[wb] = calc_wheelbase(l_overall,wheelbase);

% Calculation floor

% Drivetrain layouts

if central_motor_rear == 1
    drivetrain_center_rear = 'true';
    drivetrain_dual_all = 'false';
    cooler_all = 'false';
    motor_all = 'false';
    trans_all = 'false';
    inv_all = 'false';
    
elseif dual_motor_rear == 1
    drivetrain_center_rear = 'false';
    drivetrain_dual_all = 'true';
    cooler_all = 'false';
    motor_all = 'false';
    trans_all = 'false';
    inv_all = 'false';
    
elseif all_wheel_drive == 1
    drivetrain_center_rear = 'false';
    drivetrain_dual_all = 'true';
    cooler_all = 'true';
    motor_all = 'true';
    trans_all = 'true';
    inv_all = 'true';
    
end

% Ramp layouts

if ramp_in == 1
    ramp_in = 'true';
    ramp_out = 'false';
    street = 'false';
    
elseif ramp_out == 1
    ramp_out = 'true';
    ramp_in = 'false';
    street = 'false';
    
end

% Writing values of GUI Manual in txt.file for CAD model
UpdateParameters_Manual(l_overall, w_overall, h_overall, gc, h_ac, h_r, h_door, d_tire, wb, w_door, w_tire, t_tire, a_front, a_rear, t_rim, d_axis, t_axis, da_bdisc, di_bdisc, t_bdisc, t_body, h_lift, V_bat, h_bat_cell,...
    t_bat_box, h_bat_el, t_floor, l_ac, w_ac, d_bat_cell, h_lidar, d_lidar, t_door, t_window, l_motor, d_motor, l_trans, w_trans, l_inv, w_inv, h_inv, t_frame, h_frame, d_spring, h_spring, w_wcarrier, t_aarm, d_aarm, d_damper,...
    l_wcarrier, l_air_tank, d_air_tank, t_air_tank, d_compressor, t_compressor, l_compressor, h_seat, w_seat, l_seat, t_seat, h_backrest, l_leg_clearance, w_seat_gap, l_cooler, h_cooler, t_cooler, h_floor, h_window_shoulder, h_curb,...
    l_ramp, w_ramp, t_ramp, h_window, mat_wh, mat_body, mat_door, mat_window, mat_floor, mat_frame, mat_ramp, mat_ac, mat_lidar, mat_seat, mat_bat_box, mat_bat_cell, mat_motor, mat_trans, mat_inv, mat_cooler, mat_tire, mat_rim, mat_bdisc,...
    mat_bpad, mat_bcaliper, mat_axis, mat_wcarrier, mat_aarm, mat_spring, mat_damper, mat_air_tank, mat_compressor, drivetrain_center_rear, drivetrain_dual_all, cooler_all, motor_all, trans_all, inv_all, ramp_in, ramp_out, street);

% Calculation seat layouts
% Calculation seat layout UL1
if lay_urban1 == 1
    lay_urban1 = 'true';
    lay_urban2 = 'false';
    lay_coach = 'false';

    [n_ul1_rear, n_ul1_window, n_ul1_door, n_ul1_passenger, n_ul1_seats, n_ul1_standing, per_ul1_sitting, per_ul1_standing, w_rest_gap_window_ul1, w_rest_gap_rear_ul1, w_rest_gap_door_ul1, seat_ul1_front, seat_ul1_rear, seat_ul1_door_rear, seat_ul1_door_front, pattern_seat_ul1_front, pattern_seat_ul1_rear, pattern_seat_ul1_door_rear, pattern_seat_ul1_door_front] = calc_seat_layout_ul1 (l_overall, w_overall, h_overall, gc, wb, wheelbase, h_lift, d_tire, w_tire, d_spring, t_body, w_door, w_seat, l_seat, t_seat, l_leg_clearance, w_seat_gap, p_shoulder_width, p_body_depth);

    % Writing values of layout UL1 in txt.file for CAD model
    UpdateParameters_Layout_ul1 (n_ul1_rear, n_ul1_window, n_ul1_door, w_rest_gap_window_ul1, w_rest_gap_rear_ul1, w_rest_gap_door_ul1, lay_urban1, lay_urban2, lay_coach, seat_ul1_front, seat_ul1_rear, seat_ul1_door_rear, seat_ul1_door_front, pattern_seat_ul1_front, pattern_seat_ul1_rear, pattern_seat_ul1_door_rear, pattern_seat_ul1_door_front);

    
% Calculation seat layout UL2
elseif lay_urban2 == 1
    lay_urban1 = 'false';
    lay_urban2 = 'true';
    lay_coach = 'false';
    
    [n_ul2_rear, n_ul2_window, n_ul2_door, n_ul2_passenger, n_ul2_seats, n_ul2_standing, per_ul2_sitting, per_ul2_standing, w_rest_gap_door_ul2, w_rest_gap_window_ul2, w_rest_gap_rear_ul2,  seat_ul2_door_front, seat_ul2_front, seat_ul2_door_rear, seat_ul2_rear, pattern_seat_ul2_door_front, pattern_seat_ul2_front, pattern_seat_ul2_door_rear, pattern_seat_ul2_rear] = calc_seat_layout_ul2 (l_overall, w_overall, h_overall, gc, wb, wheelbase, h_lift, w_tire, d_spring, t_body, w_door, w_seat, l_seat, t_seat, l_leg_clearance, w_seat_gap, p_shoulder_width, p_body_depth);
    
    % Writing values of layout UL2 in txt.file for CAD model
    UpdateParameters_Layout_ul2 (n_ul2_rear, n_ul2_window, n_ul2_door, w_rest_gap_door_ul2, w_rest_gap_window_ul2, w_rest_gap_rear_ul2, lay_urban1, lay_urban2, lay_coach, seat_ul2_door_front, seat_ul2_front, seat_ul2_door_rear, seat_ul2_rear, pattern_seat_ul2_door_front, pattern_seat_ul2_front, pattern_seat_ul2_door_rear, pattern_seat_ul2_rear);
    
% Calculation seat layout CL1
elseif lay_coach == 1
    lay_urban1 = 'false';
    lay_urban2 = 'false';
    lay_coach = 'true';
    
    [n_cl1_rear, n_cl1_window, n_cl1_door, n_cl1_passenger, n_cl1_seats, n_cl1_standing, per_cl1_sitting, per_cl1_standing, w_rest_gap_rear_cl1, w_rest_gap_window_cl1, w_rest_gap_door_cl1, seat_cl1_door] = calc_seat_layout_cl1 (l_overall, w_overall, h_overall, gc, wb, wheelbase, h_lift, d_tire, w_tire, d_spring, t_body, w_door, w_seat, l_seat, t_seat, l_leg_clearance, w_seat_gap, p_shoulder_width, p_body_depth);
    
    % Writing values of layout CL1 in txt.file for CAD model
    UpdateParameters_Layout_cl1 (n_cl1_rear, n_cl1_window, n_cl1_door, w_rest_gap_rear_cl1, w_rest_gap_window_cl1, w_rest_gap_door_cl1, lay_urban1, lay_urban2, lay_coach, seat_cl1_door);
    
end    

  


% lay_urban1 = get(handles.checkbox_layout_urban1,'Value');
% lay_urban2 = get(handles.checkbox_layout_urban2,'Value');
% lay_coach = get(handles.checkbox_layout_coach,'Value');

%Waitbar
% status = system('nircmd win settopmost title "CATIA V5" 0')
% wait = waitbar(0,'Please wait...','Name','Visualization');
status = system('nircmd win settopmost title "Visualization" 1')
% pause(.3)
% waitbar(.11,wait,'Loading your data','Name','Visualization');
% pause(.2)
waitbar(.22,wait,'Loading your data','Name','Visualization');
% pause(1)

trigger = '';
global path_base
fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'wt');
% global path_base
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'wt');
fprintf(fid,'%s',trigger);
fclose(fid);

% Execute CATIA macro
winopen CATIA_Open_Update_Save.CATScript;

% Check if macro is finished
i=1;
while i==1
    fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'rt');
%     fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'rt');
    trigger = fgetl(fid);
    fclose(fid);
    if trigger == 'trigger'
        i = 2;
    end
end

waitbar(.33,wait,'Loading your data','Name','Visualization');

% Execute CATIA macro
winopen CATIA_Measure_Mass_COG.CATScript;

% Set trigger = '' for CATIA application in catia_trigger.txt
trigger = '';
fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'wt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'wt');
fprintf(fid,'%s',trigger);
fclose(fid);

waitbar(.44,wait,'Loading your data','Name','Visualization');

% Execute CATIA macro
winopen CATIA_Screenshots.CATScript;

% Check if macro is finished
i=1;
while i==1
    fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'rt');
%     fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'rt');
    trigger = fgetl(fid);
    fclose(fid);
    if trigger == 'trigger'
        i = 2;
    end
end

waitbar(.55,wait,'Loading your data','Name','Visualization');

% Set trigger = '' for CATIA application in catia_trigger.txt
trigger = '';
fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'wt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'wt');
fprintf(fid,'%s',trigger);
fclose(fid);

% Execute CATIA macro
winopen CATIA_Screenshot_Suspension.CATScript;

% Check if macro is finished
i=1;
while i==1
    fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'rt');
%     fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'rt');
    trigger = fgetl(fid);
    fclose(fid);
    if trigger == 'trigger'
        i = 2;
    end
end

waitbar(.66,wait,'Loading your data','Name','Visualization');

% Set trigger = '' for CATIA application in catia_trigger.txt
trigger = '';
fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'wt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'wt');
fprintf(fid,'%s',trigger);
fclose(fid);

% Execute CATIA macro
winopen CATIA_Screenshot_Interior.CATScript;

% Check if macro is finished
i=1;
while i==1
    fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'rt');
%     fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'rt');
    trigger = fgetl(fid);
    fclose(fid);
    if trigger == 'trigger'
        i = 2;
    end
end

waitbar(.77,wait,'Loading your data','Name','Visualization');

% Set trigger = '' for CATIA application in catia_trigger.txt
trigger = '';
fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'wt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'wt');
fprintf(fid,'%s',trigger);
fclose(fid);

winopen CATIA_Close.CATscript;

waitbar(.88,wait,'Processing your data','Name','Visualization');
% pause(1)

%% load screenshots


% Image Bus Iso View
Screenshot_ISO = imread('Bus_ISO.png');
Screenshot_ISO = imresize(Screenshot_ISO,1/4);
set(handles.pb_Automated_Visu_ISO,'CData',Screenshot_ISO)



% Image Bus Front View
Screenshot_Front = imread('Bus_Front.png');
Screenshot_Front = imresize(Screenshot_Front,1/4);
set(handles.pb_Automated_Visu_Front,'CData',Screenshot_Front)


% Image Bus Side View
Screenshot_Side = imread('Bus_Side.png');
Screenshot_Side = imresize(Screenshot_Side,1/6);
set(handles.pb_Automated_Visu_Side,'CData',Screenshot_Side)


% Load vehicle specification DB
load([path_base '\10_Results\Components\Selection.mat']);
%load(['T:\04_Cluster_C\500_SRT\033_SRT Package\Parametric Model\AEV_Tool\10_Results\Components\Selection.mat']);
% load('Selection.mat')

exist n_ul1_passenger
check_ul1 = ans;
exist n_ul2_passenger
check_ul2 = ans;
exist n_cl1_passenger
check_cl1 = ans;

if check == 'db'
    
%     % Set Vehicle Specifications
%     set(handles.text_output_overall_length, 'String', num2str(l_overall));
%     set(handles.text_output_overall_width, 'String', num2str(w_overall));
%     set(handles.text_output_overall_height, 'String', num2str(h_overall));
%     set(handles.text_output_wheelbase, 'String', num2str(wheelbase));
    
    
    air_suspension_type = strcat(AirSuspension_selection.brand,{' '},AirSuspension_selection.style_number);
    set(handles.text_air_suspension, 'String', air_suspension_type);
    
    brake_type = strcat(Brake_selection.brand,{' '},Brake_selection.brake);
    set(handles.text_brake, 'String', brake_type);
    
    brake_type = strcat(Brake_selection.brand,{' '},Brake_selection.brake);
    set(handles.text_brake, 'String', brake_type);
    
    tire_type = strcat(Tyre_selection.brand,{' '},num2str(Tyre_selection.width),{'\'},num2str(Tyre_selection.aspect_ratio),{' '},Tyre_selection.construction,num2str(Tyre_selection.rim_size));
    set(handles.text_tire, 'String', tire_type);
    

end

Screenshot_Layout = imread('Bus_Interior.png');
Screenshot_Layout = imresize(Screenshot_Layout,1/5);
set(handles.pb_Automated_Visu_Seating,'CData',Screenshot_Layout)

% Load vehicle specification from CATIA - Mass & Center of Gravity
fid = fopen([path_base '06_Exchange\catia_inertia.txt'], 'rt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_inertia.txt'], 'rt');
inertia = fgetl(fid);
fclose(fid);

inertia_array = strsplit(inertia);
m_overall =  str2double(inertia_array{1,1});
inertia_coo_x =  str2double(inertia_array{1,2})*1000; %mm
inertia_coo_y =  str2double(inertia_array{1,3})*1000; %mm
inertia_coo_z =  str2double(inertia_array{1,4})*1000; %mm
assignin('base','m_overall',m_overall)
save([path_base '06_Exchange\inertia.mat','inertia_array']);
% save(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\inertia.mat','inertia_array']);


set(handles.text_output_total_weight, 'String', num2str(m_overall));
%assignin('base','m_overall',m_overall)
set(handles.text_output_cog_x, 'String', num2str(inertia_coo_x));
set(handles.text_output_cog_y, 'String', num2str(inertia_coo_y));
set(handles.text_output_cog_z, 'String', num2str(inertia_coo_z));

inertia = '';
fid = fopen([path_base '06_Exchange\catia_inertia.txt'], 'wt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_inertia.txt'], 'wt');
fprintf(fid,'%s',inertia);
fclose(fid);

% Image Suspension
Suspension_image = imread('Bus_Suspension_ISO.png');
Suspension_image_resize = imresize(Suspension_image,1/5);
set(handles.pb_Automated_Visu_Suspension,'CData',Suspension_image_resize)    


waitbar(1,wait,'Finishing','Name','Visualization');
pause(3)

close(wait)


% --- Executes on button press in pb_Automated_Visualization_CAD.
function pb_Automated_Visualization_CAD_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Automated_Visualization_CAD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

winopen CATIA_Open_Update_Save.CATScript;
status = system('nircmd win settopmost title "CATIA V5 - [SRT_2030.CATProduct]" 1')
status = system('nircmd win settopmost title "TUMCREATE" 0')


% --- Executes on button press in tb_CE_Euro.
function tb_CE_Euro_Callback(hObject, eventdata, handles)
% hObject    handle to tb_CE_Euro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tb_CE_Euro

% currency Variable
currency_rabbit = 1;                        % Euro = 1
assignin('base','currency_rabbit',currency_rabbit);

% Change Button Color 
set(handles.tb_CE_Euro,'BackgroundColor',[0.06 0.66 0.53]);
set(handles.tb_CE_SGD,'BackgroundColor',[0.65 0.65 0.65]);

% Change Currency to Euro
set(handles.txt_CE_Currency,'String','€')

%% Chassis
set(handles.txt_CE_Cost_Axles,'String',round(str2num(char(get(handles.txt_CE_Cost_Axles,'String')))/1.6));      % Euro in SGD 1.6
set(handles.txt_CE_Cost_Rim,'String',round(str2num(char(get(handles.txt_CE_Cost_Rim,'String')))/1.6));
set(handles.txt_CE_Cost_Tire,'String',round(str2num(char(get(handles.txt_CE_Cost_Tire,'String')))/1.6));
set(handles.txt_CE_Cost_Brake,'String',round(str2num(char(get(handles.txt_CE_Cost_Brake,'String')))/1.6));
set(handles.txt_CE_Cost_WheelHub,'String',round(str2num(char(get(handles.txt_CE_Cost_WheelHub,'String')))/1.6));
set(handles.txt_CE_Cost_Spring,'String',round(str2num(char(get(handles.txt_CE_Cost_Spring,'String')))/1.6));
set(handles.txt_CE_Cost_Suspension,'String',round(str2num(char(get(handles.txt_CE_Cost_Suspension,'String')))/1.6));
set(handles.txt_CE_Cost_Calippers,'String',round(str2num(char(get(handles.txt_CE_Cost_Calippers,'String')))/1.6));
set(handles.txt_CE_Cost_Frame,'String',round(str2num(char(get(handles.txt_CE_Cost_Frame,'String')))/1.6));
set(handles.txt_TotalCostChassis,'String',round(str2num(char(get(handles.txt_TotalCostChassis,'String')))/1.6));

%% HVAC
set(handles.txt_CE_Cost_Compressor,'String',round(str2num(char(get(handles.txt_CE_Cost_Compressor,'String')))/1.6));      % Euro in SGD 1.6
set(handles.txt_CE_Cost_Evaporator,'String',round(str2num(char(get(handles.txt_CE_Cost_Evaporator,'String')))/1.6));
set(handles.txt_CE_Cost_Condenser,'String',round(str2num(char(get(handles.txt_CE_Cost_Condenser,'String')))/1.6));
set(handles.txt_CE_Cost_Aircurtains,'String',round(str2num(char(get(handles.txt_CE_Cost_Aircurtains,'String')))/1.6));
set(handles.txt_CE_Cost_HVACadd,'String',round(str2num(char(get(handles.txt_CE_Cost_HVACadd,'String')))/1.6));
set(handles.txt_CE_Cost_ACducts,'String',round(str2num(char(get(handles.txt_CE_Cost_ACducts,'String')))/1.6));
set(handles.txt_TotalCostHVAC,'String',round(str2num(char(get(handles.txt_TotalCostHVAC,'String')))/1.6));

%% Powertrain
% Powertrain Page 1
set(handles.txt_CE_Cost_Battery_1,'String',round(str2num(char(get(handles.txt_CE_Cost_Battery_1,'String')))/1.6));      % Euro in SGD 1.6
set(handles.txt_CE_Cost_Inverter_1,'String',round(str2num(char(get(handles.txt_CE_Cost_Inverter_1,'String')))/1.6));
set(handles.txt_CE_Cost_Motor_1,'String',round(str2num(char(get(handles.txt_CE_Cost_Motor_1,'String')))/1.6));
set(handles.txt_CE_Cost_Transmission_1,'String',round(str2num(char(get(handles.txt_CE_Cost_Transmission_1,'String')))/1.6));
set(handles.txt_CE_PT_title,'String','Cost in €');
% Powertrain Page 2
set(handles.txt_CE_PT_Drivetrain,'String','Total Cost of Drivetrain in €');
set(handles.txt_slider_PT_Cost,'String',round(str2num(char(get(handles.txt_slider_PT_Cost,'String')))/1.6));      % Euro in SGD 1.6
% Powertrain Page 3
set(handles.txt_CE_Cost_Battery_2,'String',round(str2num(char(get(handles.txt_CE_Cost_Battery_2,'String')))/1.6));      % Euro in SGD 1.6
set(handles.txt_CE_Cost_Inverter_2,'String',round(str2num(char(get(handles.txt_CE_Cost_Inverter_2,'String')))/1.6));
set(handles.txt_CE_Cost_Motor_2,'String',round(str2num(char(get(handles.txt_CE_Cost_Motor_2,'String')))/1.6));
set(handles.txt_CE_Cost_Transmission_2,'String',round(str2num(char(get(handles.txt_CE_Cost_Transmission_2,'String')))/1.6));
set(handles.txt_CE_Cost_ControlModules,'String',round(str2num(char(get(handles.txt_CE_Cost_ControlModules,'String')))/1.6));      % Euro in SGD 1.6
set(handles.txt_CE_Cost_WireHarness,'String',round(str2num(char(get(handles.txt_CE_Cost_WireHarness,'String')))/1.6));
set(handles.txt_CE_Cost_Contactor,'String',round(str2num(char(get(handles.txt_CE_Cost_Contactor,'String')))/1.6));
set(handles.txt_TotalCostPowertrain,'String',round(str2num(char(get(handles.txt_TotalCostPowertrain,'String')))/1.6));

%% Autonomous
set(handles.txt_CE_Cost_Lidar,'String',round(str2num(char(get(handles.txt_CE_Cost_Lidar,'String')))/1.6));      % Euro in SGD 1.6
set(handles.txt_CE_Cost_Logi,'String',round(str2num(char(get(handles.txt_CE_Cost_Logi,'String')))/1.6));
set(handles.txt_TotalCostAutonomous,'String',round(str2num(char(get(handles.txt_TotalCostAutonomous,'String')))/1.6));


%% Total Cost
set(handles.txt_TotalCost,'String',round(str2num(char(get(handles.txt_TotalCost,'String')))/1.6));      % Euro in SGD 1.6


% --- Executes on button press in tb_CE_SGD.
function tb_CE_SGD_Callback(hObject, eventdata, handles)
% hObject    handle to tb_CE_SGD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tb_CE_SGD

% currency Variable
currency_rabbit = 2;                    % SGD = 2
assignin('base','currency_rabbit',currency_rabbit);

% Change Color of Currency Button
set(handles.tb_CE_SGD,'BackgroundColor',[0.06 0.66 0.53]);
set(handles.tb_CE_Euro,'BackgroundColor',[0.65 0.65 0.65]);
% Change Currency to SGD
set(handles.txt_CE_Currency,'String','SGD')

%% Chassis
set(handles.txt_CE_Cost_Axles,'String',round(str2num(char(get(handles.txt_CE_Cost_Axles,'String')))*1.6));      % Euro in SGD 1.6
set(handles.txt_CE_Cost_Rim,'String',round(str2num(char(get(handles.txt_CE_Cost_Rim,'String')))*1.6));
set(handles.txt_CE_Cost_Tire,'String',round(str2num(char(get(handles.txt_CE_Cost_Tire,'String')))*1.6));
set(handles.txt_CE_Cost_Brake,'String',round(str2num(char(get(handles.txt_CE_Cost_Brake,'String')))*1.6));
set(handles.txt_CE_Cost_WheelHub,'String',round(str2num(char(get(handles.txt_CE_Cost_WheelHub,'String')))*1.6));
set(handles.txt_CE_Cost_Spring,'String',round(str2num(char(get(handles.txt_CE_Cost_Spring,'String')))*1.6));
set(handles.txt_CE_Cost_Suspension,'String',round(str2num(char(get(handles.txt_CE_Cost_Suspension,'String')))*1.6));
set(handles.txt_CE_Cost_Calippers,'String',round(str2num(char(get(handles.txt_CE_Cost_Calippers,'String')))*1.6));
set(handles.txt_CE_Cost_Frame,'String',round(str2num(char(get(handles.txt_CE_Cost_Frame,'String')))*1.6));
set(handles.txt_TotalCostChassis,'String',round(str2num(char(get(handles.txt_TotalCostChassis,'String')))*1.6));

%% HVAC
set(handles.txt_CE_Cost_Compressor,'String',round(str2num(char(get(handles.txt_CE_Cost_Compressor,'String')))*1.6));      % Euro in SGD 1.6
set(handles.txt_CE_Cost_Evaporator,'String',round(str2num(char(get(handles.txt_CE_Cost_Evaporator,'String')))*1.6));
set(handles.txt_CE_Cost_Condenser,'String',round(str2num(char(get(handles.txt_CE_Cost_Condenser,'String')))*1.6));
set(handles.txt_CE_Cost_Aircurtains,'String',round(str2num(char(get(handles.txt_CE_Cost_Aircurtains,'String')))*1.6));
set(handles.txt_CE_Cost_HVACadd,'String',round(str2num(char(get(handles.txt_CE_Cost_HVACadd,'String')))*1.6));
set(handles.txt_CE_Cost_ACducts,'String',round(str2num(char(get(handles.txt_CE_Cost_ACducts,'String')))*1.6));
set(handles.txt_TotalCostHVAC,'String',round(str2num(char(get(handles.txt_TotalCostHVAC,'String')))*1.6));

%% Powertrain
% Powertrain Page 1
set(handles.txt_CE_Cost_Battery_1,'String',round(str2num(char(get(handles.txt_CE_Cost_Battery_1,'String')))*1.6));      % Euro in SGD 1.6
set(handles.txt_CE_Cost_Inverter_1,'String',round(str2num(char(get(handles.txt_CE_Cost_Inverter_1,'String')))*1.6));
set(handles.txt_CE_Cost_Motor_1,'String',round(str2num(char(get(handles.txt_CE_Cost_Motor_1,'String')))*1.6));
set(handles.txt_CE_Cost_Transmission_1,'String',round(str2num(char(get(handles.txt_CE_Cost_Transmission_1,'String')))*1.6));
set(handles.txt_CE_PT_title,'String','Cost in SGD');
% Powertrain Page 2
set(handles.txt_CE_PT_Drivetrain,'String','Total Cost of Drivetrain in SGD');
set(handles.txt_slider_PT_Cost,'String',round(str2num(char(get(handles.txt_slider_PT_Cost,'String')))*1.6));      % Euro in SGD 1.6
% Powertrain Page 3
set(handles.txt_CE_Cost_Battery_2,'String',round(str2num(char(get(handles.txt_CE_Cost_Battery_2,'String')))*1.6));      % Euro in SGD 1.6
set(handles.txt_CE_Cost_Inverter_2,'String',round(str2num(char(get(handles.txt_CE_Cost_Inverter_2,'String')))*1.6));
set(handles.txt_CE_Cost_Motor_2,'String',round(str2num(char(get(handles.txt_CE_Cost_Motor_2,'String')))*1.6));
set(handles.txt_CE_Cost_Transmission_2,'String',round(str2num(char(get(handles.txt_CE_Cost_Transmission_2,'String')))*1.6));
set(handles.txt_CE_Cost_ControlModules,'String',round(str2num(char(get(handles.txt_CE_Cost_ControlModules,'String')))*1.6));      % Euro in SGD 1.6
set(handles.txt_CE_Cost_WireHarness,'String',round(str2num(char(get(handles.txt_CE_Cost_WireHarness,'String')))*1.6));
set(handles.txt_CE_Cost_Contactor,'String',round(str2num(char(get(handles.txt_CE_Cost_Contactor,'String')))*1.6));
set(handles.txt_TotalCostPowertrain,'String',round(str2num(char(get(handles.txt_TotalCostPowertrain,'String')))*1.6));

%% Autonomous
set(handles.txt_CE_Cost_Lidar,'String',round(str2num(char(get(handles.txt_CE_Cost_Lidar,'String')))*1.6));      % Euro in SGD 1.6
set(handles.txt_CE_Cost_Logi,'String',round(str2num(char(get(handles.txt_CE_Cost_Logi,'String')))*1.6));
set(handles.txt_TotalCostAutonomous,'String',round(str2num(char(get(handles.txt_TotalCostAutonomous,'String')))*1.6));

%% Total Cost
set(handles.txt_TotalCost,'String',round(str2num(char(get(handles.txt_TotalCost,'String')))*1.6));      % Euro in SGD 1.6


% --- Executes on button press in pb_VehicleConcept.
function pb_VehicleConcept_Callback(hObject, eventdata, handles)
% hObject    handle to pb_VehicleConcept (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uip_EnergyConsumption,'Visible','off');
set(handles.uip_CostEstimation,'Visible','off');
set(handles.uip_VC,'Visible','on');

% --- Executes on button press in pushbutton221.
function pushbutton221_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton221 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton220.
function pushbutton220_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton220 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_visualize_property.
function pb_visualize_property_Callback(hObject, eventdata, handles)
% hObject    handle to pb_visualize_property (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Visualization Vehicle Concept 1
Concept = evalin('base','Concept');
if Concept ==1

wait = waitbar(0,'Please wait...','Name','Visualization');

%% Values for Visualization
llen = evalin('base','llen');
wb = evalin('base','wb');
tb_SA_standing = evalin('base','tb_SA_standing');
tb_SA_2zones = evalin('base','tb_SA_2zones');
tb_SA_seats = evalin('base','tb_SA_seats');

%Workspace
l_overall = double(llen)+500;
w_overall = 2700;
h_overall = 3100;
wheelbase = double(wb);
gc = 150;
h_lift = 0;
lay_urban1 = tb_SA_standing;
lay_urban2 = tb_SA_2zones;
lay_coach = tb_SA_seats;
% lay_urban1 = 0;
% lay_urban2 = 0;
% lay_coach = 1;
central_motor_rear = 1;
dual_motor_rear = 0;
all_wheel_drive = 0;
ramp_in = 1;
ramp_out = 0;
l_seat = 400;
w_seat = 400;
h_seat = 450;
t_seat = 40;
h_backrest = 500;
l_leg_clearance = 300;
w_seat_gap = 50;
mat_seat = 'Plastic'; 
p_shoulder_width = 530;
p_body_depth = 450;
l_motor = 300;
d_motor = 270;
mat_motor = 'Aluminium';
l_cooler = 1200;
h_cooler = 250;
t_cooler = 50;
mat_cooler = 'Aluminium';
l_trans = 235;
w_trans = 370;
mat_trans = 'Aluminium';
l_inv = 343;
w_inv = 150;
h_inv = 70;
mat_inv = 'Aluminium';
t_bat_box = 4;
h_bat_el = 15;
mat_bat_box = 'Aluminium';
V_bat = 0.3540;
d_bat_cell = 18;
h_bat_cell = 65;
mat_bat_cell = 'Copper';
w_tire = 215;
d_tire = 767;
d_rim = 19;
t_rim = 10;
mat_tire = 'Rubber';
mat_rim = 'Aluminium';
da_bdisc = 430;
di_bdisc = 160;
t_bdisc = 34;
mat_bdisc = 'Steel';
mat_bpad = 'Steel';
mat_bcaliper = 'Steel';
l_wcarrier = 140;
w_wcarrier = 90;
mat_wcarrier = 'Aluminium';
d_aarm = 15;
t_aarm = 10;
mat_aarm = 'Steel';
h_spring = 285;
d_spring = 300;
mat_spring = 'Rubber';
d_air_tank = 250;
l_air_tank = 450;
t_air_tank = 1;
mat_air_tank = 'Aluminium';
d_compressor = 200;
l_compressor = 450;
t_compressor = 4;
mat_compressor = 'Aluminium';
a_front = 0;
a_rear = 0;
t_axis = 8;
d_axis = 50;
mat_axis = 'Steel';
d_damper = 50;
mat_damper = 'Aluminium';
h_r = 400;
t_body = 5;
mat_body = 'Plastic';
mat_wh = 'Plastic';
t_frame = 8;
h_frame = 100;
mat_frame = 'Steel';
t_window = 6;
h_window_shoulder = 940;
h_window = 1285;
mat_window = 'Glass';
t_floor = 5;
h_floor = 350;
mat_floor = 'Aluminium';
l_ramp = 1200;
w_ramp = 1000;
t_ramp = 50;
h_curb = 150;
mat_ramp = 'Aluminium';
h_door = 2200;
w_door = 1800;
t_door = 6;
mat_door = 'Glass';
h_lidar = 80;
d_lidar = 150;
mat_lidar = 'Glass';
l_ac = 2000;
w_ac = 1500;
h_ac = 150;
mat_ac = 'Aluminium';

%% Suspension Model

%% Check if input is correct

waitbar(.11,wait,'Loading your data 11%','Name','Visualization');
% Calculation t_tire
[t_tire] = calc_tire(d_tire, d_rim);

% Calculation wheelbase
[wb] = calc_wheelbase(l_overall,wheelbase);

% Calculation floor

% Drivetrain layouts

if central_motor_rear == 1
    drivetrain_center_rear = 'true';
    drivetrain_dual_all = 'false';
    cooler_all = 'false';
    motor_all = 'false';
    trans_all = 'false';
    inv_all = 'false';
    
elseif dual_motor_rear == 1
    drivetrain_center_rear = 'false';
    drivetrain_dual_all = 'true';
    cooler_all = 'false';
    motor_all = 'false';
    trans_all = 'false';
    inv_all = 'false';
    
elseif all_wheel_drive == 1
    drivetrain_center_rear = 'false';
    drivetrain_dual_all = 'true';
    cooler_all = 'true';
    motor_all = 'true';
    trans_all = 'true';
    inv_all = 'true';
    
end

% Ramp layouts

if ramp_in == 1
    ramp_in = 'true';
    ramp_out = 'false';
    street = 'false';
    
elseif ramp_out == 1
    ramp_out = 'true';
    ramp_in = 'false';
    street = 'false';
    
end

% Writing values of GUI Manual in txt.file for CAD model
UpdateParameters_Manual(l_overall, w_overall, h_overall, gc, h_ac, h_r, h_door, d_tire, wb, w_door, w_tire, t_tire, a_front, a_rear, t_rim, d_axis, t_axis, da_bdisc, di_bdisc, t_bdisc, t_body, h_lift, V_bat, h_bat_cell,...
    t_bat_box, h_bat_el, t_floor, l_ac, w_ac, d_bat_cell, h_lidar, d_lidar, t_door, t_window, l_motor, d_motor, l_trans, w_trans, l_inv, w_inv, h_inv, t_frame, h_frame, d_spring, h_spring, w_wcarrier, t_aarm, d_aarm, d_damper,...
    l_wcarrier, l_air_tank, d_air_tank, t_air_tank, d_compressor, t_compressor, l_compressor, h_seat, w_seat, l_seat, t_seat, h_backrest, l_leg_clearance, w_seat_gap, l_cooler, h_cooler, t_cooler, h_floor, h_window_shoulder, h_curb,...
    l_ramp, w_ramp, t_ramp, h_window, mat_wh, mat_body, mat_door, mat_window, mat_floor, mat_frame, mat_ramp, mat_ac, mat_lidar, mat_seat, mat_bat_box, mat_bat_cell, mat_motor, mat_trans, mat_inv, mat_cooler, mat_tire, mat_rim, mat_bdisc,...
    mat_bpad, mat_bcaliper, mat_axis, mat_wcarrier, mat_aarm, mat_spring, mat_damper, mat_air_tank, mat_compressor, drivetrain_center_rear, drivetrain_dual_all, cooler_all, motor_all, trans_all, inv_all, ramp_in, ramp_out, street);

% Calculation seat layouts
% Calculation seat layout UL1
if lay_urban1 == 1
    lay_urban1 = 'true';
    lay_urban2 = 'false';
    lay_coach = 'false';

    [n_ul1_rear, n_ul1_window, n_ul1_door, n_ul1_passenger, n_ul1_seats, n_ul1_standing, per_ul1_sitting, per_ul1_standing, w_rest_gap_window_ul1, w_rest_gap_rear_ul1, w_rest_gap_door_ul1, seat_ul1_front, seat_ul1_rear, seat_ul1_door_rear, seat_ul1_door_front, pattern_seat_ul1_front, pattern_seat_ul1_rear, pattern_seat_ul1_door_rear, pattern_seat_ul1_door_front] = calc_seat_layout_ul1 (l_overall, w_overall, h_overall, gc, wb, wheelbase, h_lift, d_tire, w_tire, d_spring, t_body, w_door, w_seat, l_seat, t_seat, l_leg_clearance, w_seat_gap, p_shoulder_width, p_body_depth);

    % Writing values of layout UL1 in txt.file for CAD model
    UpdateParameters_Layout_ul1 (n_ul1_rear, n_ul1_window, n_ul1_door, w_rest_gap_window_ul1, w_rest_gap_rear_ul1, w_rest_gap_door_ul1, lay_urban1, lay_urban2, lay_coach, seat_ul1_front, seat_ul1_rear, seat_ul1_door_rear, seat_ul1_door_front, pattern_seat_ul1_front, pattern_seat_ul1_rear, pattern_seat_ul1_door_rear, pattern_seat_ul1_door_front);

    
% Calculation seat layout UL2
elseif lay_urban2 == 1
    lay_urban1 = 'false';
    lay_urban2 = 'true';
    lay_coach = 'false';
    
    [n_ul2_rear, n_ul2_window, n_ul2_door, n_ul2_passenger, n_ul2_seats, n_ul2_standing, per_ul2_sitting, per_ul2_standing, w_rest_gap_door_ul2, w_rest_gap_window_ul2, w_rest_gap_rear_ul2,  seat_ul2_door_front, seat_ul2_front, seat_ul2_door_rear, seat_ul2_rear, pattern_seat_ul2_door_front, pattern_seat_ul2_front, pattern_seat_ul2_door_rear, pattern_seat_ul2_rear] = calc_seat_layout_ul2 (l_overall, w_overall, h_overall, gc, wb, wheelbase, h_lift, w_tire, d_spring, t_body, w_door, w_seat, l_seat, t_seat, l_leg_clearance, w_seat_gap, p_shoulder_width, p_body_depth);
    
    % Writing values of layout UL2 in txt.file for CAD model
    UpdateParameters_Layout_ul2 (n_ul2_rear, n_ul2_window, n_ul2_door, w_rest_gap_door_ul2, w_rest_gap_window_ul2, w_rest_gap_rear_ul2, lay_urban1, lay_urban2, lay_coach, seat_ul2_door_front, seat_ul2_front, seat_ul2_door_rear, seat_ul2_rear, pattern_seat_ul2_door_front, pattern_seat_ul2_front, pattern_seat_ul2_door_rear, pattern_seat_ul2_rear);
    
% Calculation seat layout CL1
elseif lay_coach == 1
    lay_urban1 = 'false';
    lay_urban2 = 'false';
    lay_coach = 'true';
    
    [n_cl1_rear, n_cl1_window, n_cl1_door, n_cl1_passenger, n_cl1_seats, n_cl1_standing, per_cl1_sitting, per_cl1_standing, w_rest_gap_rear_cl1, w_rest_gap_window_cl1, w_rest_gap_door_cl1, seat_cl1_door] = calc_seat_layout_cl1 (l_overall, w_overall, h_overall, gc, wb, wheelbase, h_lift, d_tire, w_tire, d_spring, t_body, w_door, w_seat, l_seat, t_seat, l_leg_clearance, w_seat_gap, p_shoulder_width, p_body_depth);
    
    % Writing values of layout CL1 in txt.file for CAD model
    UpdateParameters_Layout_cl1 (n_cl1_rear, n_cl1_window, n_cl1_door, w_rest_gap_rear_cl1, w_rest_gap_window_cl1, w_rest_gap_door_cl1, lay_urban1, lay_urban2, lay_coach, seat_cl1_door);
    
end    

  


% lay_urban1 = get(handles.checkbox_layout_urban1,'Value');
% lay_urban2 = get(handles.checkbox_layout_urban2,'Value');
% lay_coach = get(handles.checkbox_layout_coach,'Value');

%Waitbar
% status = system('nircmd win settopmost title "CATIA V5" 0')
% wait = waitbar(0,'Please wait...','Name','Visualization');
status = system('nircmd win settopmost title "Visualization" 1')
% pause(.3)
% waitbar(.11,wait,'Loading your data','Name','Visualization');
% pause(.2)
waitbar(.22,wait,'Loading your data 22%','Name','Visualization');
% pause(1)

trigger = '';
global path_base
fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'wt');
% global path_base
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'wt');
fprintf(fid,'%s',trigger);
fclose(fid);

% Execute CATIA macro
winopen CATIA_Open_Update_Save.CATScript;

% Check if macro is finished
i=1;
while i==1
    fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'rt');
%     fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'rt');
    trigger = fgetl(fid);
    fclose(fid);
    if trigger == 'trigger'
        i = 2;
    end
end

waitbar(.33,wait,'Loading your data 33%','Name','Visualization');

% Execute CATIA macro
winopen CATIA_Measure_Mass_COG.CATScript;

% Set trigger = '' for CATIA application in catia_trigger.txt
trigger = '';
fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'wt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'wt');
fprintf(fid,'%s',trigger);
fclose(fid);

waitbar(.44,wait,'Loading your data 44%','Name','Visualization');

% Execute CATIA macro
winopen CATIA_Screenshots.CATScript;

% Check if macro is finished
i=1;
while i==1
    fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'rt');
%     fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'rt');
    trigger = fgetl(fid);
    fclose(fid);
    if trigger == 'trigger'
        i = 2;
    end
end

waitbar(.55,wait,'Loading your data 55%','Name','Visualization');

% Set trigger = '' for CATIA application in catia_trigger.txt
trigger = '';
fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'wt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'wt');
fprintf(fid,'%s',trigger);
fclose(fid);

% Execute CATIA macro
winopen CATIA_Screenshot_Suspension.CATScript;

% Check if macro is finished
i=1;
while i==1
    fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'rt');
%     fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'rt');
    trigger = fgetl(fid);
    fclose(fid);
    if trigger == 'trigger'
        i = 2;
    end
end

waitbar(.66,wait,'Loading your data 66%','Name','Visualization');

% Set trigger = '' for CATIA application in catia_trigger.txt
trigger = '';
fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'wt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'wt');
fprintf(fid,'%s',trigger);
fclose(fid);

% Execute CATIA macro
winopen CATIA_Screenshot_Interior.CATScript;

% Check if macro is finished
i=1;
while i==1
    fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'rt');
%     fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'rt');
    trigger = fgetl(fid);
    fclose(fid);
    if trigger == 'trigger'
        i = 2;
    end
end

waitbar(.77,wait,'Loading your data 77%','Name','Visualization');

% Set trigger = '' for CATIA application in catia_trigger.txt
trigger = '';
fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'wt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'wt');
fprintf(fid,'%s',trigger);
fclose(fid);

winopen CATIA_Close.CATscript;

waitbar(.88,wait,'Processing your data','Name','Visualization');
% pause(1)

%% load screenshots


% Image Bus Iso View
Screenshot_ISO = imread('Bus_ISO.png');
Screenshot_ISO = imresize(Screenshot_ISO,1/4);
set(handles.image_VC1_ISO,'CData',Screenshot_ISO)



% Image Bus Front View
Screenshot_Front = imread('Bus_Front.png');
Screenshot_Front = imresize(Screenshot_Front,1/4);
set(handles.image_VC1_FRONT,'CData',Screenshot_Front)


% Image Bus Side View
Screenshot_Side = imread('Bus_Side.png');
Screenshot_Side = imresize(Screenshot_Side,1/6);
set(handles.image_VC1_SIDE,'CData',Screenshot_Side)


% Load vehicle specification DB
load([path_base '\10_Results\Components\Selection.mat']);
%load(['T:\04_Cluster_C\500_SRT\033_SRT Package\Parametric Model\AEV_Tool\10_Results\Components\Selection.mat']);
% load('Selection.mat')

exist n_ul1_passenger
check_ul1 = ans;
exist n_ul2_passenger
check_ul2 = ans;
exist n_cl1_passenger
check_cl1 = ans;

if check == 'db'
    
%     % Set Vehicle Specifications
%     set(handles.text_output_overall_length, 'String', num2str(l_overall));
%     set(handles.text_output_overall_width, 'String', num2str(w_overall));
%     set(handles.text_output_overall_height, 'String', num2str(h_overall));
%     set(handles.text_output_wheelbase, 'String', num2str(wheelbase));
    
    
    air_suspension_type = strcat(AirSuspension_selection.brand,{' '},AirSuspension_selection.style_number);
    set(handles.text_air_suspension, 'String', air_suspension_type);
    
    brake_type = strcat(Brake_selection.brand,{' '},Brake_selection.brake);
    set(handles.text_brake, 'String', brake_type);
    
    brake_type = strcat(Brake_selection.brand,{' '},Brake_selection.brake);
    set(handles.text_brake, 'String', brake_type);
    
    tire_type = strcat(Tyre_selection.brand,{' '},num2str(Tyre_selection.width),{'\'},num2str(Tyre_selection.aspect_ratio),{' '},Tyre_selection.construction,num2str(Tyre_selection.rim_size));
    set(handles.text_tire, 'String', tire_type);
    

end

Screenshot_Layout = imread('Bus_Interior.png');
Screenshot_Layout = imresize(Screenshot_Layout,1/5);
set(handles.image_VC1_TOP,'CData',Screenshot_Layout)

% Load vehicle specification from CATIA - Mass & Center of Gravity
fid = fopen([path_base '06_Exchange\catia_inertia.txt'], 'rt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_inertia.txt'], 'rt');
inertia = fgetl(fid);
fclose(fid);

inertia_array = strsplit(inertia);
m_overall =  str2double(inertia_array{1,1});
inertia_coo_x =  str2double(inertia_array{1,2})*1000; %mm
inertia_coo_y =  str2double(inertia_array{1,3})*1000; %mm
inertia_coo_z =  str2double(inertia_array{1,4})*1000; %mm
assignin('base','m_overall',m_overall)
save([path_base '06_Exchange\inertia.mat','inertia_array']);
% save(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\inertia.mat','inertia_array']);


set(handles.text_output_total_weight, 'String', num2str(m_overall));
% assignin('base','m_overall',m_overall)
set(handles.text_output_cog_x, 'String', num2str(inertia_coo_x));
set(handles.text_output_cog_y, 'String', num2str(inertia_coo_y));
set(handles.text_output_cog_z, 'String', num2str(inertia_coo_z));

inertia = '';
fid = fopen([path_base '06_Exchange\catia_inertia.txt'], 'wt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_inertia.txt'], 'wt');
fprintf(fid,'%s',inertia);
fclose(fid);

% % Image Suspension
% Suspension_image = imread('Bus_Suspension_ISO.png');
% Suspension_image_resize = imresize(Suspension_image,1/5);
% set(handles.pb_Automated_Visu_Suspension,'CData',Suspension_image_resize)    


waitbar(1,wait,'Finishing','Name','Visualization');
pause(3)

close(wait)

end

% --- Executes on button press in pb_ISO_property.
function pb_ISO_property_Callback(hObject, eventdata, handles)
% hObject    handle to pb_ISO_property (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton225.
function pushbutton225_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton225 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pushbutton225


% --- Executes on button press in pushbutton229.
function pushbutton229_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton229 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pushbutton229


% --- Executes on button press in pushbutton230.
function pushbutton230_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton230 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pushbutton230


% --- Executes on button press in pushbutton231.
function pushbutton231_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton231 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pushbutton231



function edit267_Callback(hObject, eventdata, handles)
% hObject    handle to edit267 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit267 as text
%        str2double(get(hObject,'String')) returns contents of edit267 as a double


% --- Executes during object creation, after setting all properties.
function edit267_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit267 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit268_Callback(hObject, eventdata, handles)
% hObject    handle to edit268 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit268 as text
%        str2double(get(hObject,'String')) returns contents of edit268 as a double


% --- Executes during object creation, after setting all properties.
function edit268_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit268 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit269_Callback(hObject, eventdata, handles)
% hObject    handle to edit269 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit269 as text
%        str2double(get(hObject,'String')) returns contents of edit269 as a double


% --- Executes during object creation, after setting all properties.
function edit269_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit269 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in image_DART_TOP.
function image_DART_TOP_Callback(hObject, eventdata, handles)
% hObject    handle to image_DART_TOP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in image_DART_FRONT.
function image_DART_FRONT_Callback(hObject, eventdata, handles)
% hObject    handle to image_DART_FRONT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in image_DART_SIDE.
function image_DART_SIDE_Callback(hObject, eventdata, handles)
% hObject    handle to image_DART_SIDE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in image_DART_ISO.
function image_DART_ISO_Callback(hObject, eventdata, handles)
% hObject    handle to image_DART_ISO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit270_Callback(hObject, eventdata, handles)
% hObject    handle to edit270 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit270 as text
%        str2double(get(hObject,'String')) returns contents of edit270 as a double


% --- Executes during object creation, after setting all properties.
function edit270_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit270 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit271_Callback(hObject, eventdata, handles)
% hObject    handle to edit271 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit271 as text
%        str2double(get(hObject,'String')) returns contents of edit271 as a double


% --- Executes during object creation, after setting all properties.
function edit271_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit271 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit274_Callback(hObject, eventdata, handles)
% hObject    handle to edit274 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit274 as text
%        str2double(get(hObject,'String')) returns contents of edit274 as a double


% --- Executes during object creation, after setting all properties.
function edit274_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit274 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit275_Callback(hObject, eventdata, handles)
% hObject    handle to edit275 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit275 as text
%        str2double(get(hObject,'String')) returns contents of edit275 as a double


% --- Executes during object creation, after setting all properties.
function edit275_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit275 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit276_Callback(hObject, eventdata, handles)
% hObject    handle to edit276 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit276 as text
%        str2double(get(hObject,'String')) returns contents of edit276 as a double


% --- Executes during object creation, after setting all properties.
function edit276_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit276 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit277_Callback(hObject, eventdata, handles)
% hObject    handle to edit277 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit277 as text
%        str2double(get(hObject,'String')) returns contents of edit277 as a double


% --- Executes during object creation, after setting all properties.
function edit277_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit277 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit278_Callback(hObject, eventdata, handles)
% hObject    handle to edit278 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit278 as text
%        str2double(get(hObject,'String')) returns contents of edit278 as a double


% --- Executes during object creation, after setting all properties.
function edit278_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit278 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_VC_Clasification_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Clasification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Clasification as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Clasification as a double


% --- Executes during object creation, after setting all properties.
function ed_VC_Clasification_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Clasification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_VC_NoP_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_NoP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_NoP as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_NoP as a double


% --- Executes during object creation, after setting all properties.
function ed_VC_NoP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_NoP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_VC_SA_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_SA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_SA as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_SA as a double


% --- Executes during object creation, after setting all properties.
function ed_VC_SA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_SA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_VC_Consumption_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Consumption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Consumption as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Consumption as a double


% --- Executes during object creation, after setting all properties.
function ed_VC_Consumption_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Consumption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_VC_Range_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Range as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Range as a double


% --- Executes during object creation, after setting all properties.
function ed_VC_Range_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_VC_Cost_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Cost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Cost as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Cost as a double


% --- Executes during object creation, after setting all properties.
function ed_VC_Cost_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Cost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_VC_Weight_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Weight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Weight as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Weight as a double


% --- Executes during object creation, after setting all properties.
function ed_VC_Weight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Weight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_VC_Dimension_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Dimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Dimension as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Dimension as a double


% --- Executes during object creation, after setting all properties.
function ed_VC_Dimension_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Dimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in image_VC1_TOP.
function image_VC1_TOP_Callback(hObject, eventdata, handles)
% hObject    handle to image_VC1_TOP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in image_VC1_FRONT.
function image_VC1_FRONT_Callback(hObject, eventdata, handles)
% hObject    handle to image_VC1_FRONT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in image_VC1_SIDE.
function image_VC1_SIDE_Callback(hObject, eventdata, handles)
% hObject    handle to image_VC1_SIDE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in image_VC1_ISO.
function image_VC1_ISO_Callback(hObject, eventdata, handles)
% hObject    handle to image_VC1_ISO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in tb_VC1.
function tb_VC1_Callback(hObject, eventdata, handles)
% hObject    handle to tb_VC1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tb_VC1

set(handles.tb_VC1,'BackgroundColor',[0.06 0.66 0.53]);
set(handles.tb_VC_DART,'BackgroundColor',[0.9 0.9 0.9]);
set(handles.tb_VC2,'BackgroundColor',[0.9 0.9 0.9]);
set(handles.tb_VC_Comparison,'BackgroundColor',[0.9 0.9 0.9]);
set(handles.uip_VC_1,'Visible','on');
set(handles.uip_VC_DART,'Visible','off');
set(handles.uip_VC_2,'Visible','off');
set(handles.uip_VC_Comparison,'Visible','off');
set(handles.uip_VC_Comparison_1,'Visible','off');

% --- Executes on button press in tb_VC_DART.
function tb_VC_DART_Callback(hObject, eventdata, handles)
% hObject    handle to tb_VC_DART (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tb_VC_DART

set(handles.tb_VC1,'BackgroundColor',[0.9 0.9 0.9]);
set(handles.tb_VC_DART,'BackgroundColor',[0.06 0.66 0.53]);
set(handles.tb_VC2,'BackgroundColor',[0.9 0.9 0.9]);
set(handles.tb_VC_Comparison,'BackgroundColor',[0.9 0.9 0.9]);
set(handles.uip_VC_1,'Visible','off');
set(handles.uip_VC_DART,'Visible','on');
set(handles.uip_VC_2,'Visible','off');
set(handles.uip_VC_Comparison,'Visible','off');
set(handles.uip_VC_Comparison_1,'Visible','off');

% --- Executes on button press in tb_VC2.
function tb_VC2_Callback(hObject, eventdata, handles)
% hObject    handle to tb_VC2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tb_VC2

set(handles.tb_VC1,'BackgroundColor',[0.9 0.9 0.9]);
set(handles.tb_VC_DART,'BackgroundColor',[0.9 0.9 0.9]);
set(handles.tb_VC2,'BackgroundColor',[0.06 0.66 0.53]);
set(handles.tb_VC_Comparison,'BackgroundColor',[0.9 0.9 0.9]);
set(handles.uip_VC_1,'Visible','off');
set(handles.uip_VC_DART,'Visible','off');
set(handles.uip_VC_2,'Visible','on');
set(handles.uip_VC_Comparison,'Visible','off');
set(handles.uip_VC_Comparison_1,'Visible','off');

% --- Executes on button press in tb_VC_Comparison.
function tb_VC_Comparison_Callback(hObject, eventdata, handles)
% hObject    handle to tb_VC_Comparison (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tb_VC_Comparison

set(handles.tb_VC1,'BackgroundColor',[0.9 0.9 0.9]);
set(handles.tb_VC_DART,'BackgroundColor',[0.9 0.9 0.9]);
set(handles.tb_VC2,'BackgroundColor',[0.9 0.9 0.9]);
set(handles.tb_VC_Comparison,'BackgroundColor',[0.06 0.66 0.53]);
set(handles.uip_VC_1,'Visible','off');
set(handles.uip_VC_DART,'Visible','off');
set(handles.uip_VC_2,'Visible','off');
set(handles.uip_VC_Comparison,'Visible','on');
set(handles.uip_VC_Comparison_1,'Visible','off');

% --- Executes on button press in pb_visualize_property2.
function pb_visualize_property2_Callback(hObject, eventdata, handles)
% hObject    handle to pb_visualize_property2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Visualization Concept 2
Concept = evalin('base','Concept');
if Concept == 2

wait = waitbar(0,'Please wait...','Name','Visualization');

%% Values for Visualization
llen = evalin('base','llen');
wb = evalin('base','wb');
tb_SA_standing = evalin('base','tb_SA_standing');
tb_SA_2zones = evalin('base','tb_SA_2zones');
tb_SA_seats = evalin('base','tb_SA_seats');

%Workspace
l_overall = double(llen)+500;
w_overall = 2700;
h_overall = 3100;
wheelbase = double(wb);
gc = 150;
h_lift = 0;
lay_urban1 = tb_SA_standing;
lay_urban2 = tb_SA_2zones;
lay_coach = tb_SA_seats;
% lay_urban1 = 0;
% lay_urban2 = 0;
% lay_coach = 1;
central_motor_rear = 1;
dual_motor_rear = 0;
all_wheel_drive = 0;
ramp_in = 1;
ramp_out = 0;
l_seat = 400;
w_seat = 400;
h_seat = 450;
t_seat = 40;
h_backrest = 500;
l_leg_clearance = 300;
w_seat_gap = 50;
mat_seat = 'Plastic'; 
p_shoulder_width = 530;
p_body_depth = 450;
l_motor = 300;
d_motor = 270;
mat_motor = 'Aluminium';
l_cooler = 1200;
h_cooler = 250;
t_cooler = 50;
mat_cooler = 'Aluminium';
l_trans = 235;
w_trans = 370;
mat_trans = 'Aluminium';
l_inv = 343;
w_inv = 150;
h_inv = 70;
mat_inv = 'Aluminium';
t_bat_box = 4;
h_bat_el = 15;
mat_bat_box = 'Aluminium';
V_bat = 0.3540;
d_bat_cell = 18;
h_bat_cell = 65;
mat_bat_cell = 'Copper';
w_tire = 215;
d_tire = 767;
d_rim = 19;
t_rim = 10;
mat_tire = 'Rubber';
mat_rim = 'Aluminium';
da_bdisc = 430;
di_bdisc = 160;
t_bdisc = 34;
mat_bdisc = 'Steel';
mat_bpad = 'Steel';
mat_bcaliper = 'Steel';
l_wcarrier = 140;
w_wcarrier = 90;
mat_wcarrier = 'Aluminium';
d_aarm = 15;
t_aarm = 10;
mat_aarm = 'Steel';
h_spring = 285;
d_spring = 300;
mat_spring = 'Rubber';
d_air_tank = 250;
l_air_tank = 450;
t_air_tank = 1;
mat_air_tank = 'Aluminium';
d_compressor = 200;
l_compressor = 450;
t_compressor = 4;
mat_compressor = 'Aluminium';
a_front = 0;
a_rear = 0;
t_axis = 8;
d_axis = 50;
mat_axis = 'Steel';
d_damper = 50;
mat_damper = 'Aluminium';
h_r = 400;
t_body = 5;
mat_body = 'Plastic';
mat_wh = 'Plastic';
t_frame = 8;
h_frame = 100;
mat_frame = 'Steel';
t_window = 6;
h_window_shoulder = 940;
h_window = 1285;
mat_window = 'Glass';
t_floor = 5;
h_floor = 350;
mat_floor = 'Aluminium';
l_ramp = 1200;
w_ramp = 1000;
t_ramp = 50;
h_curb = 150;
mat_ramp = 'Aluminium';
h_door = 2200;
w_door = 1800;
t_door = 6;
mat_door = 'Glass';
h_lidar = 80;
d_lidar = 150;
mat_lidar = 'Glass';
l_ac = 2000;
w_ac = 1500;
h_ac = 150;
mat_ac = 'Aluminium';

%% Suspension Model

%% Check if input is correct

waitbar(.11,wait,'Loading your data 11%','Name','Visualization');
% Calculation t_tire
[t_tire] = calc_tire(d_tire, d_rim);

% Calculation wheelbase
[wb] = calc_wheelbase(l_overall,wheelbase);

% Calculation floor

% Drivetrain layouts

if central_motor_rear == 1
    drivetrain_center_rear = 'true';
    drivetrain_dual_all = 'false';
    cooler_all = 'false';
    motor_all = 'false';
    trans_all = 'false';
    inv_all = 'false';
    
elseif dual_motor_rear == 1
    drivetrain_center_rear = 'false';
    drivetrain_dual_all = 'true';
    cooler_all = 'false';
    motor_all = 'false';
    trans_all = 'false';
    inv_all = 'false';
    
elseif all_wheel_drive == 1
    drivetrain_center_rear = 'false';
    drivetrain_dual_all = 'true';
    cooler_all = 'true';
    motor_all = 'true';
    trans_all = 'true';
    inv_all = 'true';
    
end

% Ramp layouts

if ramp_in == 1
    ramp_in = 'true';
    ramp_out = 'false';
    street = 'false';
    
elseif ramp_out == 1
    ramp_out = 'true';
    ramp_in = 'false';
    street = 'false';
    
end

% Writing values of GUI Manual in txt.file for CAD model
UpdateParameters_Manual(l_overall, w_overall, h_overall, gc, h_ac, h_r, h_door, d_tire, wb, w_door, w_tire, t_tire, a_front, a_rear, t_rim, d_axis, t_axis, da_bdisc, di_bdisc, t_bdisc, t_body, h_lift, V_bat, h_bat_cell,...
    t_bat_box, h_bat_el, t_floor, l_ac, w_ac, d_bat_cell, h_lidar, d_lidar, t_door, t_window, l_motor, d_motor, l_trans, w_trans, l_inv, w_inv, h_inv, t_frame, h_frame, d_spring, h_spring, w_wcarrier, t_aarm, d_aarm, d_damper,...
    l_wcarrier, l_air_tank, d_air_tank, t_air_tank, d_compressor, t_compressor, l_compressor, h_seat, w_seat, l_seat, t_seat, h_backrest, l_leg_clearance, w_seat_gap, l_cooler, h_cooler, t_cooler, h_floor, h_window_shoulder, h_curb,...
    l_ramp, w_ramp, t_ramp, h_window, mat_wh, mat_body, mat_door, mat_window, mat_floor, mat_frame, mat_ramp, mat_ac, mat_lidar, mat_seat, mat_bat_box, mat_bat_cell, mat_motor, mat_trans, mat_inv, mat_cooler, mat_tire, mat_rim, mat_bdisc,...
    mat_bpad, mat_bcaliper, mat_axis, mat_wcarrier, mat_aarm, mat_spring, mat_damper, mat_air_tank, mat_compressor, drivetrain_center_rear, drivetrain_dual_all, cooler_all, motor_all, trans_all, inv_all, ramp_in, ramp_out, street);

% Calculation seat layouts
% Calculation seat layout UL1
if lay_urban1 == 1
    lay_urban1 = 'true';
    lay_urban2 = 'false';
    lay_coach = 'false';

    [n_ul1_rear, n_ul1_window, n_ul1_door, n_ul1_passenger, n_ul1_seats, n_ul1_standing, per_ul1_sitting, per_ul1_standing, w_rest_gap_window_ul1, w_rest_gap_rear_ul1, w_rest_gap_door_ul1, seat_ul1_front, seat_ul1_rear, seat_ul1_door_rear, seat_ul1_door_front, pattern_seat_ul1_front, pattern_seat_ul1_rear, pattern_seat_ul1_door_rear, pattern_seat_ul1_door_front] = calc_seat_layout_ul1 (l_overall, w_overall, h_overall, gc, wb, wheelbase, h_lift, d_tire, w_tire, d_spring, t_body, w_door, w_seat, l_seat, t_seat, l_leg_clearance, w_seat_gap, p_shoulder_width, p_body_depth);

    % Writing values of layout UL1 in txt.file for CAD model
    UpdateParameters_Layout_ul1 (n_ul1_rear, n_ul1_window, n_ul1_door, w_rest_gap_window_ul1, w_rest_gap_rear_ul1, w_rest_gap_door_ul1, lay_urban1, lay_urban2, lay_coach, seat_ul1_front, seat_ul1_rear, seat_ul1_door_rear, seat_ul1_door_front, pattern_seat_ul1_front, pattern_seat_ul1_rear, pattern_seat_ul1_door_rear, pattern_seat_ul1_door_front);

    
% Calculation seat layout UL2
elseif lay_urban2 == 1
    lay_urban1 = 'false';
    lay_urban2 = 'true';
    lay_coach = 'false';
    
    [n_ul2_rear, n_ul2_window, n_ul2_door, n_ul2_passenger, n_ul2_seats, n_ul2_standing, per_ul2_sitting, per_ul2_standing, w_rest_gap_door_ul2, w_rest_gap_window_ul2, w_rest_gap_rear_ul2,  seat_ul2_door_front, seat_ul2_front, seat_ul2_door_rear, seat_ul2_rear, pattern_seat_ul2_door_front, pattern_seat_ul2_front, pattern_seat_ul2_door_rear, pattern_seat_ul2_rear] = calc_seat_layout_ul2 (l_overall, w_overall, h_overall, gc, wb, wheelbase, h_lift, w_tire, d_spring, t_body, w_door, w_seat, l_seat, t_seat, l_leg_clearance, w_seat_gap, p_shoulder_width, p_body_depth);
    
    % Writing values of layout UL2 in txt.file for CAD model
    UpdateParameters_Layout_ul2 (n_ul2_rear, n_ul2_window, n_ul2_door, w_rest_gap_door_ul2, w_rest_gap_window_ul2, w_rest_gap_rear_ul2, lay_urban1, lay_urban2, lay_coach, seat_ul2_door_front, seat_ul2_front, seat_ul2_door_rear, seat_ul2_rear, pattern_seat_ul2_door_front, pattern_seat_ul2_front, pattern_seat_ul2_door_rear, pattern_seat_ul2_rear);
    
% Calculation seat layout CL1
elseif lay_coach == 1
    lay_urban1 = 'false';
    lay_urban2 = 'false';
    lay_coach = 'true';
    
    [n_cl1_rear, n_cl1_window, n_cl1_door, n_cl1_passenger, n_cl1_seats, n_cl1_standing, per_cl1_sitting, per_cl1_standing, w_rest_gap_rear_cl1, w_rest_gap_window_cl1, w_rest_gap_door_cl1, seat_cl1_door] = calc_seat_layout_cl1 (l_overall, w_overall, h_overall, gc, wb, wheelbase, h_lift, d_tire, w_tire, d_spring, t_body, w_door, w_seat, l_seat, t_seat, l_leg_clearance, w_seat_gap, p_shoulder_width, p_body_depth);
    
    % Writing values of layout CL1 in txt.file for CAD model
    UpdateParameters_Layout_cl1 (n_cl1_rear, n_cl1_window, n_cl1_door, w_rest_gap_rear_cl1, w_rest_gap_window_cl1, w_rest_gap_door_cl1, lay_urban1, lay_urban2, lay_coach, seat_cl1_door);
    
end    

  


% lay_urban1 = get(handles.checkbox_layout_urban1,'Value');
% lay_urban2 = get(handles.checkbox_layout_urban2,'Value');
% lay_coach = get(handles.checkbox_layout_coach,'Value');

%Waitbar
% status = system('nircmd win settopmost title "CATIA V5" 0')
% wait = waitbar(0,'Please wait...','Name','Visualization');
status = system('nircmd win settopmost title "Visualization" 1')
% pause(.3)
% waitbar(.11,wait,'Loading your data','Name','Visualization');
% pause(.2)
waitbar(.22,wait,'Loading your data 22%','Name','Visualization');
% pause(1)

trigger = '';
global path_base
fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'wt');
% global path_base
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'wt');
fprintf(fid,'%s',trigger);
fclose(fid);

% Execute CATIA macro
winopen CATIA_Open_Update_Save.CATScript;

% Check if macro is finished
i=1;
while i==1
    fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'rt');
%     fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'rt');
    trigger = fgetl(fid);
    fclose(fid);
    if trigger == 'trigger'
        i = 2;
    end
end

waitbar(.33,wait,'Loading your data 33%','Name','Visualization');

% Execute CATIA macro
winopen CATIA_Measure_Mass_COG.CATScript;

% Set trigger = '' for CATIA application in catia_trigger.txt
trigger = '';
fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'wt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'wt');
fprintf(fid,'%s',trigger);
fclose(fid);

waitbar(.44,wait,'Loading your data 44%','Name','Visualization');

% Execute CATIA macro
winopen CATIA_Screenshots.CATScript;

% Check if macro is finished
i=1;
while i==1
    fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'rt');
%     fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'rt');
    trigger = fgetl(fid);
    fclose(fid);
    if trigger == 'trigger'
        i = 2;
    end
end

waitbar(.55,wait,'Loading your data 55%','Name','Visualization');

% Set trigger = '' for CATIA application in catia_trigger.txt
trigger = '';
fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'wt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'wt');
fprintf(fid,'%s',trigger);
fclose(fid);

% Execute CATIA macro
winopen CATIA_Screenshot_Suspension.CATScript;

% Check if macro is finished
i=1;
while i==1
    fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'rt');
%     fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'rt');
    trigger = fgetl(fid);
    fclose(fid);
    if trigger == 'trigger'
        i = 2;
    end
end

waitbar(.66,wait,'Loading your data 66%','Name','Visualization');

% Set trigger = '' for CATIA application in catia_trigger.txt
trigger = '';
fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'wt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'wt');
fprintf(fid,'%s',trigger);
fclose(fid);

% Execute CATIA macro
winopen CATIA_Screenshot_Interior.CATScript;

% Check if macro is finished
i=1;
while i==1
    fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'rt');
%     fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'rt');
    trigger = fgetl(fid);
    fclose(fid);
    if trigger == 'trigger'
        i = 2;
    end
end

waitbar(.77,wait,'Loading your data 77%','Name','Visualization');

% Set trigger = '' for CATIA application in catia_trigger.txt
trigger = '';
fid = fopen([path_base '06_Exchange\catia_trigger.txt'], 'wt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_trigger.txt'], 'wt');
fprintf(fid,'%s',trigger);
fclose(fid);

winopen CATIA_Close.CATscript;

waitbar(.88,wait,'Processing your data','Name','Visualization');
% pause(1)

%% load screenshots


% Image Bus Iso View
Screenshot_ISO = imread('Bus_ISO.png');
Screenshot_ISO = imresize(Screenshot_ISO,1/4);
set(handles.image_VC2_ISO,'CData',Screenshot_ISO)



% Image Bus Front View
Screenshot_Front = imread('Bus_Front.png');
Screenshot_Front = imresize(Screenshot_Front,1/4);
set(handles.image_VC2_FRONT,'CData',Screenshot_Front)


% Image Bus Side View
Screenshot_Side = imread('Bus_Side.png');
Screenshot_Side = imresize(Screenshot_Side,1/6);
set(handles.image_VC2_SIDE,'CData',Screenshot_Side)


% Load vehicle specification DB
load([path_base '\10_Results\Components\Selection.mat']);
%load(['T:\04_Cluster_C\500_SRT\033_SRT Package\Parametric Model\AEV_Tool\10_Results\Components\Selection.mat']);
% load('Selection.mat')

exist n_ul1_passenger
check_ul1 = ans;
exist n_ul2_passenger
check_ul2 = ans;
exist n_cl1_passenger
check_cl1 = ans;

if check == 'db'
    
%     % Set Vehicle Specifications
%     set(handles.text_output_overall_length, 'String', num2str(l_overall));
%     set(handles.text_output_overall_width, 'String', num2str(w_overall));
%     set(handles.text_output_overall_height, 'String', num2str(h_overall));
%     set(handles.text_output_wheelbase, 'String', num2str(wheelbase));
    
    
    air_suspension_type = strcat(AirSuspension_selection.brand,{' '},AirSuspension_selection.style_number);
    set(handles.text_air_suspension, 'String', air_suspension_type);
    
    brake_type = strcat(Brake_selection.brand,{' '},Brake_selection.brake);
    set(handles.text_brake, 'String', brake_type);
    
    brake_type = strcat(Brake_selection.brand,{' '},Brake_selection.brake);
    set(handles.text_brake, 'String', brake_type);
    
    tire_type = strcat(Tyre_selection.brand,{' '},num2str(Tyre_selection.width),{'\'},num2str(Tyre_selection.aspect_ratio),{' '},Tyre_selection.construction,num2str(Tyre_selection.rim_size));
    set(handles.text_tire, 'String', tire_type);
    

end

Screenshot_Layout = imread('Bus_Interior.png');
Screenshot_Layout = imresize(Screenshot_Layout,1/5);
set(handles.image_VC2_TOP,'CData',Screenshot_Layout)

% Load vehicle specification from CATIA - Mass & Center of Gravity
fid = fopen([path_base '06_Exchange\catia_inertia.txt'], 'rt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_inertia.txt'], 'rt');
inertia = fgetl(fid);
fclose(fid);

inertia_array = strsplit(inertia);
m_overall =  str2double(inertia_array{1,1});
inertia_coo_x =  str2double(inertia_array{1,2})*1000; %mm
inertia_coo_y =  str2double(inertia_array{1,3})*1000; %mm
inertia_coo_z =  str2double(inertia_array{1,4})*1000; %mm
assignin('base','m_overall',m_overall)
save([path_base '06_Exchange\inertia.mat','inertia_array']);
% save(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\inertia.mat','inertia_array']);


set(handles.text_output_total_weight, 'String', num2str(m_overall));
% assignin('base','m_overall',m_overall)
set(handles.text_output_cog_x, 'String', num2str(inertia_coo_x));
set(handles.text_output_cog_y, 'String', num2str(inertia_coo_y));
set(handles.text_output_cog_z, 'String', num2str(inertia_coo_z));

inertia = '';
fid = fopen([path_base '06_Exchange\catia_inertia.txt'], 'wt');
% fid = fopen(['T:\04_Cluster_C\700_Transfer Temp\Phi_Tran\AEV_Tool\06_Exchange\catia_inertia.txt'], 'wt');
fprintf(fid,'%s',inertia);
fclose(fid);

% % Image Suspension
% Suspension_image = imread('Bus_Suspension_ISO.png');
% Suspension_image_resize = imresize(Suspension_image,1/5);
% set(handles.pb_Automated_Visu_Suspension,'CData',Suspension_image_resize)    


waitbar(1,wait,'Finishing','Name','Visualization');
pause(3)

close(wait)

end

function ed_VC_Classification_2_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Classification_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Classification_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Classification_2 as a double


% --- Executes during object creation, after setting all properties.
function ed_VC_Classification_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Classification_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_VC_NoP_2_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_NoP_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_NoP_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_NoP_2 as a double


% --- Executes during object creation, after setting all properties.
function ed_VC_NoP_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_NoP_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_VC_SA_2_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_SA_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_SA_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_SA_2 as a double


% --- Executes during object creation, after setting all properties.
function ed_VC_SA_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_SA_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_VC_Consumption_2_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Consumption_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Consumption_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Consumption_2 as a double


% --- Executes during object creation, after setting all properties.
function ed_VC_Consumption_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Consumption_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_VC_Range_2_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Range_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Range_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Range_2 as a double


% --- Executes during object creation, after setting all properties.
function ed_VC_Range_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Range_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_VC_Cost_2_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Cost_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Cost_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Cost_2 as a double


% --- Executes during object creation, after setting all properties.
function ed_VC_Cost_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Cost_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_VC_Weight_2_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Weight_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Weight_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Weight_2 as a double


% --- Executes during object creation, after setting all properties.
function ed_VC_Weight_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Weight_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_VC_Dimension_2_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Dimension_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Dimension_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Dimension_2 as a double


% --- Executes during object creation, after setting all properties.
function ed_VC_Dimension_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Dimension_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in image_VC2_TOP.
function image_VC2_TOP_Callback(hObject, eventdata, handles)
% hObject    handle to image_VC2_TOP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in image_VC2_FRONT.
function image_VC2_FRONT_Callback(hObject, eventdata, handles)
% hObject    handle to image_VC2_FRONT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in image_VC2_SIDE.
function image_VC2_SIDE_Callback(hObject, eventdata, handles)
% hObject    handle to image_VC2_SIDE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in image_VC2_ISO.
function image_VC2_ISO_Callback(hObject, eventdata, handles)
% hObject    handle to image_VC2_ISO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_Concept_Back.
function pb_Concept_Back_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Concept_Back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uip_StartPage,'Visible','off');
set(handles.uip_Automated,'Visible','on');
set(handles.uip_ConfigurationProgress_Automated,'Visible','on');

set(handles.uip_ManualMode,'Visible','off');
set(handles.uip_M_Config,'Visible','off')
set(handles.uip_M_Visualization,'Visible','off');
set(handles.uip_Automated_Analysis,'Visible','off');


% --- Executes on button press in pushbutton254.
function pushbutton254_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton254 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit311_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Clasification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Clasification as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Clasification as a double


% --- Executes during object creation, after setting all properties.
function edit311_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Clasification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit312_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_NoP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_NoP as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_NoP as a double


% --- Executes during object creation, after setting all properties.
function edit312_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_NoP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit313_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_SA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_SA as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_SA as a double


% --- Executes during object creation, after setting all properties.
function edit313_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_SA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit314_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Consumption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Consumption as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Consumption as a double


% --- Executes during object creation, after setting all properties.
function edit314_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Consumption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit315_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Range as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Range as a double


% --- Executes during object creation, after setting all properties.
function edit315_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit316_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Cost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Cost as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Cost as a double


% --- Executes during object creation, after setting all properties.
function edit316_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Cost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit317_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Weight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Weight as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Weight as a double


% --- Executes during object creation, after setting all properties.
function edit317_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Weight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit318_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Dimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Dimension as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Dimension as a double


% --- Executes during object creation, after setting all properties.
function edit318_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Dimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton255.
function pushbutton255_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton255 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton256.
function pushbutton256_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton256 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton257.
function pushbutton257_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton257 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton258.
function pushbutton258_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton258 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit327_Callback(hObject, eventdata, handles)
% hObject    handle to edit327 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit327 as text
%        str2double(get(hObject,'String')) returns contents of edit327 as a double


% --- Executes during object creation, after setting all properties.
function edit327_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit327 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit328_Callback(hObject, eventdata, handles)
% hObject    handle to edit328 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit328 as text
%        str2double(get(hObject,'String')) returns contents of edit328 as a double


% --- Executes during object creation, after setting all properties.
function edit328_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit328 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit329_Callback(hObject, eventdata, handles)
% hObject    handle to edit329 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit329 as text
%        str2double(get(hObject,'String')) returns contents of edit329 as a double


% --- Executes during object creation, after setting all properties.
function edit329_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit329 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit330_Callback(hObject, eventdata, handles)
% hObject    handle to edit330 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit330 as text
%        str2double(get(hObject,'String')) returns contents of edit330 as a double


% --- Executes during object creation, after setting all properties.
function edit330_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit330 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit331_Callback(hObject, eventdata, handles)
% hObject    handle to edit331 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit331 as text
%        str2double(get(hObject,'String')) returns contents of edit331 as a double


% --- Executes during object creation, after setting all properties.
function edit331_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit331 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit332_Callback(hObject, eventdata, handles)
% hObject    handle to edit332 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit332 as text
%        str2double(get(hObject,'String')) returns contents of edit332 as a double


% --- Executes during object creation, after setting all properties.
function edit332_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit332 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit333_Callback(hObject, eventdata, handles)
% hObject    handle to edit333 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit333 as text
%        str2double(get(hObject,'String')) returns contents of edit333 as a double


% --- Executes during object creation, after setting all properties.
function edit333_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit333 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit334_Callback(hObject, eventdata, handles)
% hObject    handle to edit334 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit334 as text
%        str2double(get(hObject,'String')) returns contents of edit334 as a double


% --- Executes during object creation, after setting all properties.
function edit334_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit334 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit319_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Classification_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Classification_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Classification_2 as a double


% --- Executes during object creation, after setting all properties.
function edit319_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Classification_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit320_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_NoP_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_NoP_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_NoP_2 as a double


% --- Executes during object creation, after setting all properties.
function edit320_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_NoP_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit321_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_SA_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_SA_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_SA_2 as a double


% --- Executes during object creation, after setting all properties.
function edit321_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_SA_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit322_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Consumption_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Consumption_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Consumption_2 as a double


% --- Executes during object creation, after setting all properties.
function edit322_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Consumption_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit323_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Range_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Range_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Range_2 as a double


% --- Executes during object creation, after setting all properties.
function edit323_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Range_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit324_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Cost_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Cost_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Cost_2 as a double


% --- Executes during object creation, after setting all properties.
function edit324_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Cost_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit325_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Weight_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Weight_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Weight_2 as a double


% --- Executes during object creation, after setting all properties.
function edit325_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Weight_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit326_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Dimension_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Dimension_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Dimension_2 as a double


% --- Executes during object creation, after setting all properties.
function edit326_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Dimension_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_VC_next1.
function pb_VC_next1_Callback(hObject, eventdata, handles)
% hObject    handle to pb_VC_next1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uip_VC_1,'Visible','off');
set(handles.uip_VC_DART,'Visible','off');
set(handles.uip_VC_2,'Visible','off');
set(handles.uip_VC_Comparison,'Visible','off');
set(handles.uip_VC_Comparison_1,'Visible','on');


% --- Executes on button press in pb_VC_next2.
function pb_VC_next2_Callback(hObject, eventdata, handles)
% hObject    handle to pb_VC_next2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uip_VC_1,'Visible','off');
set(handles.uip_VC_DART,'Visible','off');
set(handles.uip_VC_2,'Visible','off');
set(handles.uip_VC_Comparison,'Visible','on');
set(handles.uip_VC_Comparison_1,'Visible','off');


function ed_VC_Clasification_2_Callback(hObject, eventdata, handles)
% hObject    handle to ed_VC_Classification_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_VC_Classification_2 as text
%        str2double(get(hObject,'String')) returns contents of ed_VC_Classification_2 as a double


% --- Executes during object creation, after setting all properties.
function ed_VC_Clasification_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_VC_Classification_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit367_Callback(hObject, eventdata, handles)
% hObject    handle to edit367 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit367 as text
%        str2double(get(hObject,'String')) returns contents of edit367 as a double


% --- Executes during object creation, after setting all properties.
function edit367_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit367 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit368_Callback(hObject, eventdata, handles)
% hObject    handle to edit368 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit368 as text
%        str2double(get(hObject,'String')) returns contents of edit368 as a double


% --- Executes during object creation, after setting all properties.
function edit368_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit368 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit369_Callback(hObject, eventdata, handles)
% hObject    handle to edit369 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit369 as text
%        str2double(get(hObject,'String')) returns contents of edit369 as a double


% --- Executes during object creation, after setting all properties.
function edit369_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit369 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit370_Callback(hObject, eventdata, handles)
% hObject    handle to edit370 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit370 as text
%        str2double(get(hObject,'String')) returns contents of edit370 as a double


% --- Executes during object creation, after setting all properties.
function edit370_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit370 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit371_Callback(hObject, eventdata, handles)
% hObject    handle to edit371 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit371 as text
%        str2double(get(hObject,'String')) returns contents of edit371 as a double


% --- Executes during object creation, after setting all properties.
function edit371_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit371 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit372_Callback(hObject, eventdata, handles)
% hObject    handle to edit372 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit372 as text
%        str2double(get(hObject,'String')) returns contents of edit372 as a double


% --- Executes during object creation, after setting all properties.
function edit372_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit372 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit373_Callback(hObject, eventdata, handles)
% hObject    handle to edit373 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit373 as text
%        str2double(get(hObject,'String')) returns contents of edit373 as a double


% --- Executes during object creation, after setting all properties.
function edit373_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit373 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit374_Callback(hObject, eventdata, handles)
% hObject    handle to edit374 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit374 as text
%        str2double(get(hObject,'String')) returns contents of edit374 as a double


% --- Executes during object creation, after setting all properties.
function edit374_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit374 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cb_concept1.
function cb_concept1_Callback(hObject, eventdata, handles)
% hObject    handle to cb_concept1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_concept1

cb_concept1 = (get(hObject,'Value'));
assignin('base','cb_concept1',cb_concept1)

% --- Executes on button press in cb_concept2.
function cb_concept2_Callback(hObject, eventdata, handles)
% hObject    handle to cb_concept2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_concept2

cb_concept2 = (get(hObject,'Value'));
assignin('base','cb_concept2',cb_concept2)

% --- Executes on button press in cb_dart.
function cb_dart_Callback(hObject, eventdata, handles)
% hObject    handle to cb_dart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_dart

cb_dart = (get(hObject,'Value'));
assignin('base','cb_dart',cb_dart)


% --- Executes on button press in pb_SpiderChart_Total.
function pb_SpiderChart_Total_Callback(hObject, eventdata, handles)
% hObject    handle to pb_SpiderChart_Total (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hold off
axes(handles.ax_spiderchart_total)
plot(1)
set(handles.ax_spiderchart_total,'YColor',[1 1 1],'YLim',[0 1],'YTick',[0:0.5:1],...
    'XColor',[1 1 1],'XLim',[0 1],'XTick',[0:0.5:1])

cb_concept1 = evalin('base','cb_concept1');
cb_concept2 = evalin('base','cb_concept2');
cb_dart = evalin('base','cb_dart');

if cb_concept1 == true && cb_concept2 == false && cb_dart == false

P_1 = evalin('base','P_1');
% Point properties 
num_of_points = 6; 
row_of_points = 3; 

% % Random data 
P = rand(row_of_points, num_of_points); 
% Random data 
% First row is the maximum value, second row is the minimum value
% Third row is the main value
%NoP, Length, Cost, Energy Consumption, Range, Seats
P = [70 15 240 180 400 60;30 5 80 0 0 0;P_1];  
% Create generic labels 
P_labels = cell(num_of_points, 1); 

% for ii = 1:num_of_points 
% P_labels{ii} = sprintf('Label %i', ii); 
% end 

P_labels{1} = sprintf('Number of \nPassengers \n(30 - 70)');
P_labels{2} = sprintf('Length \n(5m - 15m)');
P_labels{3} = sprintf('Cost \n(80k - 240k €)');
P_labels{4} = sprintf('E. Consumption \n(0kWh/100km - \n180kWh/100km)');
P_labels{5} = sprintf('Range \n(0-400km)');
P_labels{6} = sprintf('Seats \n(0-60)');

% Figure properties 
axes(handles.ax_spiderchart_total)
% figure('units', 'normalized', 'outerposition', [0 0.05 1 0.95]); 

% Axes properties 
axes_interval = 2; 
axes_precision = 1;

% Spider plot 
spider_plot_CV1(P, P_labels, axes_interval, axes_precision,... 
'Marker', 'o',... 
'LineStyle', '-',... 
'LineWidth', 2,... 
'MarkerSize', 5); 

% Title properties 
title('Concept 1',... 
'Fontweight', 'bold',... 
'FontSize', 12); 


else if cb_concept1 == true && cb_concept2 == true && cb_dart == false

P_1 = evalin('base','P_1');
P_2 = evalin('base','P_2');

% Point properties 
num_of_points = 6; 
row_of_points = 4; 

% % Random data 
P = rand(row_of_points, num_of_points); 
% Random data 
% First row is the maximum value, second row is the minimum value
% Third row is the main value
%NoP, Length, Cost, Energy Consumption, Range, Seats
P = [70 15 240 180 400 60;30 5 80 0 0 0;P_1;P_2];  
% Create generic labels 
P_labels = cell(num_of_points, 1); 

% for ii = 1:num_of_points 
% P_labels{ii} = sprintf('Label %i', ii); 
% end 

P_labels{1} = sprintf('Number of \nPassengers \n(30 - 70)');
P_labels{2} = sprintf('Length \n(5m - 15m)');
P_labels{3} = sprintf('Cost \n(80k - 240k €)');
P_labels{4} = sprintf('E. Consumption \n(0kWh/100km - \n180kWh/100km)');
P_labels{5} = sprintf('Range \n(0-400km)');
P_labels{6} = sprintf('Seats \n(0-60)');

% Figure properties 
axes(handles.ax_spiderchart_total)
% figure('units', 'normalized', 'outerposition', [0 0.05 1 0.95]); 

% Axes properties 
axes_interval = 2; 
axes_precision = 1;

% Spider plot 
spider_plot_CV1(P, P_labels, axes_interval, axes_precision,... 
'Marker', 'o',... 
'LineStyle', '-',... 
'LineWidth', 2,... 
'MarkerSize', 5); 

% Title properties 
title('Concept 1 & 2',... 
'Fontweight', 'bold',... 
'FontSize', 12); 

else if cb_concept1 == true && cb_concept2 == true && cb_dart == true

P_1 = evalin('base','P_1');
P_2 = evalin('base','P_2');

% Point properties 
num_of_points = 6; 
row_of_points = 5; 

% % Random data 
P = rand(row_of_points, num_of_points); 
% Random data 
% First row is the maximum value, second row is the minimum value
% Third row is the main value
%NoP, Length, Cost, Energy Consumption, Range, Seats
P = [70 15 240 180 400 60;30 5 80 0 0 0;P_1;P_2;30 6 170/1.6 66 192 20];  
% Create generic labels 
P_labels = cell(num_of_points, 1); 

% for ii = 1:num_of_points 
% P_labels{ii} = sprintf('Label %i', ii); 
% end 

P_labels{1} = sprintf('Number of \nPassengers \n(30 - 70)');
P_labels{2} = sprintf('Length \n(5m - 15m)');
P_labels{3} = sprintf('Cost \n(80k - 240k €)');
P_labels{4} = sprintf('E. Consumption \n(0kWh/100km - \n180kWh/100km)');
P_labels{5} = sprintf('Range \n(0-400km)');
P_labels{6} = sprintf('Seats \n(0-60)');

% Figure properties 
axes(handles.ax_spiderchart_total)
% figure('units', 'normalized', 'outerposition', [0 0.05 1 0.95]); 

% Axes properties 
axes_interval = 2; 
axes_precision = 1;

% Spider plot 
spider_plot_CV1(P, P_labels, axes_interval, axes_precision,... 
'Marker', 'o',... 
'LineStyle', '-',... 
'LineWidth', 2,... 
'MarkerSize', 5); 

% Title properties 
title('Concept 1 & 2 & DART',... 
'Fontweight', 'bold',... 
'FontSize', 12); 

else if cb_concept1 == true && cb_concept2 == false && cb_dart == true

P_1 = evalin('base','P_1');

% Point properties 
num_of_points = 6; 
row_of_points = 4; 

% % Random data 
P = rand(row_of_points, num_of_points); 
% Random data 
% First row is the maximum value, second row is the minimum value
% Third row is the main value
%NoP, Length, Cost, Energy Consumption, Range, Seats
P = [70 15 240 180 400 60;30 5 80 0 0 0;P_1;30 6 170/1.6 66 192 20];  
% Create generic labels 
P_labels = cell(num_of_points, 1); 

% for ii = 1:num_of_points 
% P_labels{ii} = sprintf('Label %i', ii); 
% end 

P_labels{1} = sprintf('Number of \nPassengers \n(30 - 70)');
P_labels{2} = sprintf('Length \n(5m - 15m)');
P_labels{3} = sprintf('Cost \n(80k - 240k €)');
P_labels{4} = sprintf('E. Consumption \n(0kWh/100km - \n180kWh/100km)');
P_labels{5} = sprintf('Range \n(0-400km)');
P_labels{6} = sprintf('Seats \n(0-60)');

% Figure properties 
axes(handles.ax_spiderchart_total)
% figure('units', 'normalized', 'outerposition', [0 0.05 1 0.95]); 

% Axes properties 
axes_interval = 2; 
axes_precision = 1;

% Spider plot 
spider_plot_CV1_DART(P, P_labels, axes_interval, axes_precision,... 
'Marker', 'o',... 
'LineStyle', '-',... 
'LineWidth', 2,... 
'MarkerSize', 5); 

% Title properties 
title('Concept 1 & DART',... 
'Fontweight', 'bold',... 
'FontSize', 12); 

else if cb_concept1 == false && cb_concept2 == true && cb_dart == false
    
P_2 = evalin('base','P_2');    
% Point properties 
num_of_points = 6; 
row_of_points = 3; 

% % Random data 
P = rand(row_of_points, num_of_points); 
% Random data 
% First row is the maximum value, second row is the minimum value
% Third row is the main value
%NoP, Length, Cost, Energy Consumption, Range, Seats
P = [70 15 240 180 400 60;30 5 80 0 0 0;P_2];  
% Create generic labels 
P_labels = cell(num_of_points, 1); 

% for ii = 1:num_of_points 
% P_labels{ii} = sprintf('Label %i', ii); 
% end 

P_labels{1} = sprintf('Number of \nPassengers \n(30 - 70)');
P_labels{2} = sprintf('Length \n(5m - 15m)');
P_labels{3} = sprintf('Cost \n(80k - 240k €)');
P_labels{4} = sprintf('E. Consumption \n(0kWh/100km - \n180kWh/100km)');
P_labels{5} = sprintf('Range \n(0-400km)');
P_labels{6} = sprintf('Seats \n(0-60)');

% Figure properties 
axes(handles.ax_spiderchart_total)
% figure('units', 'normalized', 'outerposition', [0 0.05 1 0.95]); 

% Axes properties 
axes_interval = 2; 
axes_precision = 1;

% Spider plot 
spider_plot_CV2(P, P_labels, axes_interval, axes_precision,... 
'Marker', 'o',... 
'LineStyle', '-',... 
'LineWidth', 2,... 
'MarkerSize', 5); 

% Title properties 
title('Concept 2',... 
'Fontweight', 'bold',... 
'FontSize', 12); 

else if cb_concept1 == false && cb_concept2 == true && cb_dart == true

P_2 = evalin('base','P_2');
% Point properties 
num_of_points = 6; 
row_of_points = 4; 

% % Random data 
P = rand(row_of_points, num_of_points); 
% Random data 
% First row is the maximum value, second row is the minimum value
% Third row is the main value
%NoP, Length, Cost, Energy Consumption, Range, Seats
P = [70 15 240 180 400 60;30 5 80 0 0 0;P_2;30 6 170/1.6 66 192 20];  
% Create generic labels 
P_labels = cell(num_of_points, 1); 

% for ii = 1:num_of_points 
% P_labels{ii} = sprintf('Label %i', ii); 
% end 

P_labels{1} = sprintf('Number of \nPassengers \n(30 - 70)');
P_labels{2} = sprintf('Length \n(5m - 15m)');
P_labels{3} = sprintf('Cost \n(80k - 240k €)');
P_labels{4} = sprintf('E. Consumption \n(0kWh/100km - \n180kWh/100km)');
P_labels{5} = sprintf('Range \n(0-400km)');
P_labels{6} = sprintf('Seats \n(0-60)');

% Figure properties 
axes(handles.ax_spiderchart_total)
% figure('units', 'normalized', 'outerposition', [0 0.05 1 0.95]); 

% Axes properties 
axes_interval = 2; 
axes_precision = 1;

% Spider plot 
spider_plot_CV2(P, P_labels, axes_interval, axes_precision,... 
'Marker', 'o',... 
'LineStyle', '-',... 
'LineWidth', 2,... 
'MarkerSize', 5); 

% Title properties 
title('Concept 2 & DART',... 
'Fontweight', 'bold',... 
'FontSize', 12); 

else if cb_concept1 == false && cb_concept2 == false && cb_dart == true

% Point properties 
num_of_points = 6; 
row_of_points = 3; 

% % Random data 
P = rand(row_of_points, num_of_points); 
% Random data 
% First row is the maximum value, second row is the minimum value
% Third row is the main value
P = [70 15 240 180 400 60;30 5 80 0 0 0;30 6 170/1.6 66 192 20]; 
 
% Create generic labels 
P_labels = cell(num_of_points, 1); 

% for ii = 1:num_of_points 
% P_labels{ii} = sprintf('Label %i', ii); 
% end 
P_labels{1} = sprintf('Number of \nPassengers \n(30 - 70)');
P_labels{2} = sprintf('Length \n(5m - 15m)');
P_labels{3} = sprintf('Cost \n(80k - 240k €)');
P_labels{4} = sprintf('E. Consumption \n(0kWh/100km - \n180kWh/100km)');
P_labels{5} = sprintf('Range \n(0-400km)');
P_labels{6} = sprintf('Seats \n(0-60)');

% Figure properties 
axes(handles.ax_spiderchart_total)
% figure('units', 'normalized', 'outerposition', [0 0.05 1 0.95]); 

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

else if cb_concept1 == false && cb_concept2 == false && cb_dart == false
        
% Point properties 
num_of_points = 6; 
row_of_points = 2; 

% % Random data 
P = rand(row_of_points, num_of_points); 
% Random data 
% First row is the maximum value, second row is the minimum value
% Third row is the main value
P = [70 15 240 180 400 60;30 5 80 0 0 0]; 
 
% Create generic labels 
P_labels = cell(num_of_points, 1); 

% for ii = 1:num_of_points 
% P_labels{ii} = sprintf('Label %i', ii); 
% end 
P_labels{1} = sprintf('Number of \nPassengers \n(30 - 70)');
P_labels{2} = sprintf('Length \n(5m - 15m)');
P_labels{3} = sprintf('Cost \n(80k - 240k €)');
P_labels{4} = sprintf('E. Consumption \n(0kWh/100km - \n180kWh/100km)');
P_labels{5} = sprintf('Range \n(0-400km)');
P_labels{6} = sprintf('Seats \n(0-60)');

% Figure properties 
axes(handles.ax_spiderchart_total)
% figure('units', 'normalized', 'outerposition', [0 0.05 1 0.95]); 

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

                            end
                        end
                    end
                end
            end
        end
    end
end



function ed_MaxVelocity_Callback(hObject, eventdata, handles)
% hObject    handle to ed_MaxVelocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_MaxVelocity as text
%        str2double(get(hObject,'String')) returns contents of ed_MaxVelocity as a double


% --- Executes during object creation, after setting all properties.
function ed_MaxVelocity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_MaxVelocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_BatteryVoltage_Callback(hObject, eventdata, handles)
% hObject    handle to ed_BatteryVoltage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_BatteryVoltage as text
%        str2double(get(hObject,'String')) returns contents of ed_BatteryVoltage as a double


% --- Executes during object creation, after setting all properties.
function ed_BatteryVoltage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_BatteryVoltage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_BatteryPower_Callback(hObject, eventdata, handles)
% hObject    handle to ed_BatteryPower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_BatteryPower as text
%        str2double(get(hObject,'String')) returns contents of ed_BatteryPower as a double


% --- Executes during object creation, after setting all properties.
function ed_BatteryPower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_BatteryPower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_MaxAcceleration_Callback(hObject, eventdata, handles)
% hObject    handle to ed_MaxAcceleration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_MaxAcceleration as text
%        str2double(get(hObject,'String')) returns contents of ed_MaxAcceleration as a double


% --- Executes during object creation, after setting all properties.
function ed_MaxAcceleration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_MaxAcceleration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_FR_selec.
function pb_FR_selec_Callback(hObject, eventdata, handles)
% hObject    handle to pb_FR_selec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Motor_FR = evalin('base','Motor_FR')
Motor_Power_FR = evalin('base','Motor_Power_FR')

%ASM
if Motor_FR == 1 && Motor_Power_FR == 1
    
    FA1 =  'Horlbeck_ASM_69kW_7661rpm_86Nm';

else if Motor_FR == 1 && Motor_Power_FR == 2

    FA1 =  'Horlbeck_ASM_99kW_7459rpm_123Nm';
    
else if Motor_FR == 1 && Motor_Power_FR == 3
        
    FA1 =  'Horlbeck_ASM_129kW_8064rpm_152Nm';
    
else if Motor_FR == 1 && Motor_Power_FR == 4
        
    FA1 =  'Horlbeck_ASM_161kW_5149rpm_292Nm';

           end
        end
    end
end

%PSM
if Motor_FR == 2 && Motor_Power_FR == 1
    
    FA1 =  'Horlbeck_PSM_69kW_3096rpm_155Nm';

else if Motor_FR == 2 && Motor_Power_FR == 2

    FA1 =  'Horlbeck_PSM_102kW_1489rpm_477Nm';
    
else if Motor_FR == 2 && Motor_Power_FR == 3
        
    FA1 =  'Horlbeck_PSM_128kW_6805rpm_137Nm';
    
else if Motor_FR == 2 && Motor_Power_FR == 4
        
    FA1 =  'Horlbeck_PSM_163kW_3369rpm_346Nm';

           end
        end
    end
end

assignin('base','FA1',FA1)

% --- Executes on selection change in pop_FR_Type.
function pop_FR_Type_Callback(hObject, eventdata, handles)
% hObject    handle to pop_FR_Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_FR_Type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_FR_Type

contents = cellstr(get(hObject,'String'));
pop_choice = contents{get(hObject,'Value')};
pop_choice

if (strcmp(pop_choice,'ASM'))

    Motor_FR = 1;

else if (strcmp(pop_choice,'PSM'))
        
    Motor_FR = 2;
    
    end
end
assignin('base','Motor_FR',Motor_FR);

% --- Executes during object creation, after setting all properties.
function pop_FR_Type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_FR_Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_FR_Power.
function pop_FR_Power_Callback(hObject, eventdata, handles)
% hObject    handle to pop_FR_Power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_FR_Power contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_FR_Power

contents = cellstr(get(hObject,'String'));
pop_choice = contents{get(hObject,'Value')};
pop_choice

if (strcmp(pop_choice,'70 kW'))

    Motor_Power_FR = 1;

else if (strcmp(pop_choice,'100 kW'))
        
    Motor_Power_FR = 2;
    
    
else if (strcmp(pop_choice,'130 kW'))
        
    Motor_Power_FR = 3;
 
else if (strcmp(pop_choice,'160 kW'))
        
    Motor_Power_FR = 4;

            end
         end
    end
end
assignin('base','Motor_Power_FR',Motor_Power_FR);


% --- Executes during object creation, after setting all properties.
function pop_FR_Power_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_FR_Power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DC_Beijing.
function DC_Beijing_Callback(hObject, eventdata, handles)
% hObject    handle to DC_Beijing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DC_Beijing


% --- Executes on button press in DC_Manhattan.
function DC_Manhattan_Callback(hObject, eventdata, handles)
% hObject    handle to DC_Manhattan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DC_Manhattan


% --- Executes on button press in DC_NEDC.
function DC_NEDC_Callback(hObject, eventdata, handles)
% hObject    handle to DC_NEDC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DC_NEDC


% --- Executes on button press in DC_Nuremberg.
function DC_Nuremberg_Callback(hObject, eventdata, handles)
% hObject    handle to DC_Nuremberg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DC_Nuremberg


% --- Executes on button press in pb_RR_selec.
function pb_RR_selec_Callback(hObject, eventdata, handles)
% hObject    handle to pb_RR_selec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Motor_RR = evalin('base','Motor_FR')
Motor_Power_RR = evalin('base','Motor_Power_FR')

%ASM
if Motor_RR == 1 && Motor_Power_RR == 1
    
    RA1 =  'Horlbeck_ASM_69kW_7661rpm_86Nm';

else if Motor_RR == 1 && Motor_Power_RR == 2

    RA1 =  'Horlbeck_ASM_99kW_7459rpm_123Nm';
    
else if Motor_RR == 1 && Motor_Power_RR == 3
        
    RA1 =  'Horlbeck_ASM_129kW_8064rpm_152Nm';
    
else if Motor_RR == 1 && Motor_Power_RR == 4
        
    RA1 =  'Horlbeck_ASM_161kW_5149rpm_292Nm';

           end
        end
    end
end

%PSM
if Motor_RR == 2 && Motor_Power_RR == 1
    
    RA1 =  'Horlbeck_PSM_69kW_3096rpm_155Nm';

else if Motor_RR == 2 && Motor_Power_RR == 2

    RA1 =  'Horlbeck_PSM_102kW_1489rpm_477Nm';
    
else if Motor_RR == 2 && Motor_Power_RR == 3
        
    RA1 =  'Horlbeck_PSM_128kW_6805rpm_137Nm';
    
else if Motor_RR == 2 && Motor_Power_RR == 4
        
    RA1 =  'Horlbeck_PSM_163kW_3369rpm_346Nm';

           end
        end
    end
end

assignin('base','RA1',RA1)


% --- Executes on selection change in pop_RR_Type.
function pop_RR_Type_Callback(hObject, eventdata, handles)
% hObject    handle to pop_RR_Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_RR_Type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_RR_Type

contents = cellstr(get(hObject,'String'));
pop_choice = contents{get(hObject,'Value')};
pop_choice

if (strcmp(pop_choice,'ASM'))

    Motor_RR = 1;

else if (strcmp(pop_choice,'PSM'))
        
    Motor_RR = 2;
    
    end
end
assignin('base','Motor_RR',Motor_RR);


% --- Executes during object creation, after setting all properties.
function pop_RR_Type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_RR_Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_RR_Power.
function pop_RR_Power_Callback(hObject, eventdata, handles)
% hObject    handle to pop_RR_Power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_RR_Power contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_RR_Power

contents = cellstr(get(hObject,'String'));
pop_choice = contents{get(hObject,'Value')};
pop_choice

if (strcmp(pop_choice,'70 kW'))

    Motor_Power_RR = 1;

else if (strcmp(pop_choice,'100 kW'))
        
    Motor_Power_RR = 2;
    
    
else if (strcmp(pop_choice,'130 kW'))
        
    Motor_Power_RR = 3;
 
else if (strcmp(pop_choice,'160 kW'))
        
    Motor_Power_RR = 4;

          end
       end
    end
end
assignin('base','Motor_Power_RR',Motor_Power_RR);


% --- Executes during object creation, after setting all properties.
function pop_RR_Power_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_RR_Power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_FL_selec.
function pb_FL_selec_Callback(hObject, eventdata, handles)
% hObject    handle to pb_FL_selec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Motor_FL = evalin('base','Motor_FR')
Motor_Power_FL = evalin('base','Motor_Power_FR')

%ASM
if Motor_FL == 1 && Motor_Power_FL == 1
    
    FA2 =  'Horlbeck_ASM_69kW_7661rpm_86Nm';

else if Motor_FL == 1 && Motor_Power_FL == 2

    FA2 =  'Horlbeck_ASM_99kW_7459rpm_123Nm';
    
else if Motor_FL == 1 && Motor_Power_FL == 3
        
    FA2 =  'Horlbeck_ASM_129kW_8064rpm_152Nm';
    
else if Motor_FL == 1 && Motor_Power_FL == 4
        
    FA2 =  'Horlbeck_ASM_161kW_5149rpm_292Nm';

           end
        end
    end
end

%PSM
if Motor_FL == 2 && Motor_Power_FL == 1
    
    FA2 =  'Horlbeck_PSM_69kW_3096rpm_155Nm';

else if Motor_FL == 2 && Motor_Power_FL == 2

    FA2 =  'Horlbeck_PSM_102kW_1489rpm_477Nm';
    
else if Motor_FL == 2 && Motor_Power_FL == 3
        
    FA2 =  'Horlbeck_PSM_128kW_6805rpm_137Nm';
    
else if Motor_FL == 2 && Motor_Power_FL == 4
        
    FA2 =  'Horlbeck_PSM_163kW_3369rpm_346Nm';

           end
        end
    end
end

assignin('base','FA2',FA2)


% --- Executes on selection change in pop_FL_Type.
function pop_FL_Type_Callback(hObject, eventdata, handles)
% hObject    handle to pop_FL_Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_FL_Type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_FL_Type

contents = cellstr(get(hObject,'String'));
pop_choice = contents{get(hObject,'Value')};
pop_choice

if (strcmp(pop_choice,'ASM'))

    Motor_FL = 1;

else if (strcmp(pop_choice,'PSM'))
        
    Motor_FL = 2;
    
    end
end
assignin('base','Motor_FL',Motor_FL);


% --- Executes during object creation, after setting all properties.
function pop_FL_Type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_FL_Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_FL_Power.
function pop_FL_Power_Callback(hObject, eventdata, handles)
% hObject    handle to pop_FL_Power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_FL_Power contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_FL_Power

contents = cellstr(get(hObject,'String'));
pop_choice = contents{get(hObject,'Value')};
pop_choice

if (strcmp(pop_choice,'70 kW'))

    Motor_Power_FL = 1;

else if (strcmp(pop_choice,'100 kW'))
        
    Motor_Power_FL = 2;
    
    
else if (strcmp(pop_choice,'130 kW'))
        
    Motor_Power_FL = 3;
 
else if (strcmp(pop_choice,'160 kW'))
        
    Motor_Power_FL = 4;

           end
        end
    end
end
assignin('base','Motor_Power_FL',Motor_Power_FL);


% --- Executes during object creation, after setting all properties.
function pop_FL_Power_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_FL_Power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_RL_selec.
function pb_RL_selec_Callback(hObject, eventdata, handles)
% hObject    handle to pb_RL_selec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Motor_RL = evalin('base','Motor_FR')
Motor_Power_RL = evalin('base','Motor_Power_FR')

%ASM
if Motor_RL == 1 && Motor_Power_RL == 1
    
    RA2 =  'Horlbeck_ASM_69kW_7661rpm_86Nm';

else if Motor_RL == 1 && Motor_Power_RL == 2

    RA2 =  'Horlbeck_ASM_99kW_7459rpm_123Nm';
    
else if Motor_RL == 1 && Motor_Power_RL == 3
        
    RA2 =  'Horlbeck_ASM_129kW_8064rpm_152Nm';
    
else if Motor_RL == 1 && Motor_Power_RL == 4
        
    RA2 =  'Horlbeck_ASM_161kW_5149rpm_292Nm';

           end
        end
    end
end

%PSM
if Motor_RL == 2 && Motor_Power_RL == 1
    
    RA2 =  'Horlbeck_PSM_69kW_3096rpm_155Nm';

else if Motor_RL == 2 && Motor_Power_RL == 2

    RA2 =  'Horlbeck_PSM_102kW_1489rpm_477Nm';
    
else if Motor_RL == 2 && Motor_Power_RL == 3
        
    RA2 =  'Horlbeck_PSM_128kW_6805rpm_137Nm';
    
else if Motor_RL == 2 && Motor_Power_RL == 4
        
    RA2 =  'Horlbeck_PSM_163kW_3369rpm_346Nm';

           end
        end
    end
end

assignin('base','RA2',RA2)


% --- Executes on selection change in pop_RL_Type.
function pop_RL_Type_Callback(hObject, eventdata, handles)
% hObject    handle to pop_RL_Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_RL_Type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_RL_Type

contents = cellstr(get(hObject,'String'));
pop_choice = contents{get(hObject,'Value')};
pop_choice

if (strcmp(pop_choice,'ASM'))

    Motor_RL = 1;

else if (strcmp(pop_choice,'PSM'))
        
    Motor_RL = 2;
    
    end
end
assignin('base','Motor_RL',Motor_RL);


% --- Executes during object creation, after setting all properties.
function pop_RL_Type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_RL_Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pop_RL_Power.
function pop_RL_Power_Callback(hObject, eventdata, handles)
% hObject    handle to pop_RL_Power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_RL_Power contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_RL_Power

contents = cellstr(get(hObject,'String'));
pop_choice = contents{get(hObject,'Value')};
pop_choice

if (strcmp(pop_choice,'70 kW'))

    Motor_Power_RL = 1;

else if (strcmp(pop_choice,'100 kW'))
        
    Motor_Power_RL = 2;
    
    
else if (strcmp(pop_choice,'130 kW'))
        
    Motor_Power_RL = 3;
 
else if (strcmp(pop_choice,'160 kW'))
        
    Motor_Power_RL = 4;

            end
        end
    end
end
assignin('base','Motor_Power_RL',Motor_Power_RL);


% --- Executes during object creation, after setting all properties.
function pop_RL_Power_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_RL_Power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ch_FR_ac.
function ch_FR_ac_Callback(hObject, eventdata, handles)
% hObject    handle to ch_FR_ac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ch_FR_ac

if handles.ch_FR_ac.Value == true
    
    set(handles.pop_FR_Type,'Enable','on')
    set(handles.pop_FR_Power,'Enable','on')
    FR = 1
    
else
    
    set(handles.pop_FR_Type,'Enable','off')
    set(handles.pop_FR_Power,'Enable','off')
    FR = 0
    
end

assignin('base','FR',FR)


% --- Executes on button press in ch_RR_ac.
function ch_RR_ac_Callback(hObject, eventdata, handles)
% hObject    handle to ch_RR_ac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ch_RR_ac

if handles.ch_RR_ac.Value == true
    
    set(handles.pop_RR_Type,'Enable','on')
    set(handles.pop_RR_Power,'Enable','on')
    RR = 1
    
else
    
    set(handles.pop_RR_Type,'Enable','off')
    set(handles.pop_RR_Power,'Enable','off')
    RR =0
    
end

assignin('base','RR',RR)

% --- Executes on button press in ch_RL_ac.
function ch_RL_ac_Callback(hObject, eventdata, handles)
% hObject    handle to ch_RL_ac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ch_RL_ac

if handles.ch_RL_ac.Value == true
    
    set(handles.pop_RL_Type,'Enable','on')
    set(handles.pop_RL_Power,'Enable','on')
    RL = 1
    
else
    
    set(handles.pop_RL_Type,'Enable','off')
    set(handles.pop_RL_Power,'Enable','off')
    RL = 0
    
end

assignin('base','RL',RL)

% --- Executes on button press in ch_FL_ac.
function ch_FL_ac_Callback(hObject, eventdata, handles)
% hObject    handle to ch_FL_ac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ch_FL_ac

if handles.ch_FL_ac.Value == true
    
    set(handles.pop_FL_Type,'Enable','on')
    set(handles.pop_FL_Power,'Enable','on')
    FL = 1
    
else
    
    set(handles.pop_FL_Type,'Enable','off')
    set(handles.pop_FL_Power,'Enable','off')
    FL = 0
    
end

assignin('base','FL',FL)


% --- Executes on button press in pb_Powertrain_Simulation.
function pb_Powertrain_Simulation_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Powertrain_Simulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% % Vehicle Requirements
REQU.v_max_requ = get(handles.ed_MaxVelocity,'String') 
REQU.v_max_requ = REQU.v_max_requ/3.6               % change to m/s
REQU.a_max_requ = get(handles.ed_MaxAcceleration,'String')  % in m/s^2
U_bat = get(handles.ed_BatteryVoltage,'String')     % in V
assignin('base','U_bat',U_bat)
E_bat = get(handles.ed_BatteryPower,'String')       % Battery size in kWh

% CYCLE = 'BRT_Beijing.mat';
% assignin('base','CYCLE',CYCLE)

Z_gears_RA = evalin('base','Z_gears_RA');
Z_gears_FA = evalin('base','Z_gears_FA');
CYCLE = evalin('base','CYCLE');

% FA1 = '';
% FA2 = '';
% RA1 = '';
% RA2 = '';
% % % assignin('base','FA1',FA1)
% % % assignin('base','FA2',FA2)
% % % assignin('base','RA1',RA1)
% % % assignin('base','RA2',RA2)

% Z_gears_FA = 1;
% Z_gears_RA = 1;
% assignin('base','Z_gears_RA',Z_gears_RA)
% assignin('base','Z_gears_FA',Z_gears_FA)
% 
% % Drive Cycle
if handles.DC_Beijing.Value == 1
    
    CYCLE = 'BRT_Beijing.mat';
    
else if handles.DC_Manhattan.Value == 1
        
    CYCLE = 'MANHATTEN.mat';
    
else if handles.DC_NEDC.Value == 1
     
    CYCLE = 'NEDC.mat';
    
else if handles.DC_Nuremberg.Value == 1
    
    CYCLE = 'NUREMBERG_R36.mat';
    
            end
        end
    end
end
% 
% % Transmission Front
if handles.rb_F1.Value == 1
    
    Z_gears_FA = 1;
    
else if handles.rb_F2.Value == 1
        
    Z_gears_FA = 2;
    
else if handles.rb_F4.Value == 1
     
    Z_gears_FA = 4;
    
else if handles.rb_F6.Value == 1
    
    Z_gears_FA = 6;
    
            end
        end
    end
end
% 
% % transmission Rear
if handles.rb_R1.Value == 1
    
    Z_gears_RA = 1;
    
else if handles.rb_R2.Value == 1
        
    Z_gears_RA = 2;
    
else if handles.rb_R4.Value == 1
     
    Z_gears_RA = 4;
    
else if handles.rb_R6.Value == 1
    
    Z_gears_RA = 6;
    
            end
        end
    end
end
% 
% %% Aerodynamics
% Init.Aerodynamics.c_w = 0.4; 
% 
% % % Motor
FA1 = evalin('base','FA1');                                                %Front Axle Motor 1
FA2 = evalin('base','FA2');                                                %Front Axle Motor 2
RA1 = evalin('base','RA1');                                                %Rear Axle Motor 1
RA2 = evalin('base','FA2');                                                %Rear Axle Motor 2
fileMOT = {FA1 FA2 RA1 RA2 [] []};                                         %String with Motor Names
% 
llleenn = evalin('base','llleenn')
NoP = evalin('base','NoP')
Energy_HVAC = evalin('base','Energy_HVAC')
% 
llleenn = double(llleenn);
Init.Vehicle_Dynamics.length = llleenn/1000;     %Vehicle length in m
Init.Vehicle_Dynamics.n_passengers = NoP;      %Number of Passengers
AC_power = Energy_HVAC;                         % Cooling Demand

% cd 'T:\04_Cluster_C\500_SRT\033_SRT Package\Parametric Model'               % Change Path

% rmpath('T:\04_Cluster_C\500_SRT\033_SRT Package\Parametric Model\AEV_Tool') % Remove Path

% cd 'T:\04_Cluster_C\500_SRT\033_SRT Package\Parametric Model\Phi Tran\99 Longitudinal'  % Change Path

% addpath(genpath('T:\04_Cluster_C\500_SRT\033_SRT Package\Parametric Model\Phi Tran\99 Longitudinal\12_Longitudinal_Simulation_SK')) % Add Powertrain Simulation Path 

% cd 'T:\04_Cluster_C\500_SRT\033_SRT Package\Parametric Model\Phi Tran\99 Longitudinal\12_Longitudinal_Simulation_SK'    % Change Path

% run('lalala.m')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Script Version for the AEV Tool%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% This script initializes the Longitudinal Simulation Model
%The model is built up to investigate different drivetrain topologies for
%electric buses. It parametrical to enable the simulation of a wide range 
%of concepts

%The model uses existing component blocks from the Automotive Chair of the
%Technical University Munich (ftm). In particular these are:

%Battery model: Stefan Rohr: ECM
%Motor model: Lorenz Horlbeck: Efficiency map generation
%Inverter model: Fengqi Chang: Efficiency map generation
%Transmission model:
%Driver model:
%Tire model:

%TUMCREATE
%27/10/2017
%Author: Sebastian Krapf
%Last modified: 22/02/2018


%% FROM RUN MANUAL VERSION
% These parameters come from the RUN script in the optimization version. 
% Adjust them manueally in this script
% 
% File path


cd 'T:\04_Cluster_C\500_SRT\033_SRT Package\Parametric Model\AEV_Tool\08 Powertrain'

FN_Init = 'TUMCREATE'; %file name init script
FN_Sim_Model = 'LDS_Krapf_FINAL_180316'; %file name simulation model
path_base = mfilename('fullpath');
path_base = erase(path_base,FN_Init);
addpath(genpath(path_base));
path_base = [path_base '08 Powertrain\'];
path_mot = [path_base '20_Results\03_Design_Exploration\01_Motors_'];
%path_mot = ['T:\04_Cluster_C\500_SRT\033_SRT Package\Parametric Model\AEV_Tool\12_Longitudinal_Simulation_SK\20_Results\03_Design_Exploration\01_Motors_'];

%load('Longitudinal_data.mat','E_bat','Init','motor_string_f','motor_string_f_2','motor_string_r','motor_string_r_2','REQU','U_bat','Z_gears_FA','Z_gears_RA');

%Vehicle requirements
% % %  REQU.v_max_requ = 80/3.6; %required vehicle maximum speed in m/s
 REQU.elev_tow = 0.20; %required slope for gradability in %
 REQU.v_tow = 30/3.6; %required speed at towing requirement in m/s
 REQU.a_tow = 1; %required acceleration capability at towing requirement in m/s^2

% % % %  REQU.a_max_requ = 1.5; %required vehicle maximum acceleration in m/s^2
 REQU.v_a_max_requ = 30/3.6; %required speed at towing requirement in m/s
 
 assignin('base','REQU',REQU)

% Number of gears
% % %  Z_gears_FA = 1;..................................here...........
% % %  Z_gears_RA = 1;

% Motor power and topology
% {'FA1' 'FA2' 'RA1' 'RA2' 'TA1' 'TA2'}
%fileMOT = {motor_string_f motor_string_f_2 motor_string_r motor_string_r_2 [] []};
% % % fileMOT = {'Horlbeck_PSM_102kW_1489rpm_477Nm' [] 'Horlbeck_PSM_72kW_1493rpm_334Nm' [] [] []};%String mit Motorennamen
P_all = zeros(1,6);
for i = 1:length(fileMOT)
    if ~isempty(fileMOT{i})
        load([path_mot 'ALL\' fileMOT{i}]);
        P_all(i) = Horlbeck.settings.P_max;
    end
end
config = ~(cellfun(@isempty,fileMOT));

%Driving cycle
% % % CYCLE = 'BRT_Beijing.mat'; %initialize driving cycles..................here...............
m_fluctuation = 0;

% %Other components design parameters
% % % E_bat = 240; % Battery size  ind kWh
% % % U_bat = 400; % in V
% % %  AC_power = 6600;  % AC demand in W
 CHARGING_eff = 0.9; % Charger efficiency in -
    
%load distribution: to design the transmission
REQU.load_distribution = [P_all(1)/sum(P_all) ... %FA1
    P_all(2)/sum(P_all) ... %FA2
    P_all(3)/sum(P_all) ... %RA1
    P_all(4)/sum(P_all) ... %RA2
    [] [] ]; %TA1 and TA2

%% For re-calculation
% DIR = dir(['C:\Users\sebastian.krapf\Documents\08_LDS\50_Experiments\00_MANUAL_180316']); %PSM motors
% DIR = dir(['C:\Users\sebastian.krapf\Documents\08_LDS\50_Experiments\MF']); %PSM motors
% 
% for COUNT_SIM=3:length(DIR)
%     load(DIR(COUNT_SIM).name)
% FN_Sim_Model = 'LDS_Krapf_FINAL_180316'; %file name simulation model
% m_fluctuation = 1;

%% END of MANUAL VERSION difference   
 
%% Organizational initialization
% clear Init; close all; clc;
visualize = 0; %visualize design results? [0 1]

%% Vehicle design parameters
Init.Requirements = REQU; % Vehicle design parameters

%% Motor design parameters
% %Cells with the filenames of the motor and inverter that should be used
% Is initalized in RUN_... script. to initialize MANUALLY:
% fileMOT = {[] [] 'Horlbeck_PSM_163kW_3369rpm_346Nm.mat' [] [] []};

%% Gearbox design parameter
Init.Requirements.z_gears = [Z_gears_FA Z_gears_FA Z_gears_RA Z_gears_RA 0 0]; %numbers of gears in -

%% Simulink Model Initilization
% FN_Sim_Model = 'LDS_Krapf_180222'; 
%Logic: Name the parameters according to the block they are used in the
%simulation. E.g. tire radius: chassis.tire.radius = 0.3
%exception: eff. maps. they are initialized under the component

%% Environment
Init.Environment = load([path_base '\00_Parameters\' CYCLE]);        %Beijing BRT Driving cyle
Init.Environment.gravity = 9.81;                                           %in kg/(ms^2)

%% Auxilliaries
Init.Auxilliaries.HV_LV_Converter.efficiency = 0.98;                    	%in -
Init.Auxilliaries.P_AC = AC_power;                                         	%in W, constant power demand 
Init.Auxilliaries.P_other_LV = 1500;                                       	%in W, constant power demand 
Init.Charger.eff = CHARGING_eff; %Define charging efficiency to adapt 

%% Chassis
%% Chassis.Tire
Init.Chassis.Tire.r_dyn = 0.372;                                         	%in m
Init.Chassis.Tire.roll_res_sta = 0.011;                                    	%in -
%at 100km/h, the roll resistance should be around 5% higher than at 0 (Naunheimer)
Init.Chassis.Tire.roll_res_dyn = 0;                                         %in 1/(m/s)
Init.Chassis.Tire.n_wheels = 4;                                             %in -

%% Aerodynamics
Init.Aerodynamics.front_area = 7.11;                                        %in m^2
Init.Aerodynamics.c_w = 0.4;                                               %in -
Init.Aerodynamics.rho_air = 1.19;                                           %in kg/m^3, constant at 293K. Wikipedia

%% Vehicle Dynamics
% % % Init.Vehicle_Dynamics.length = 6.8;                                        %in m
% % % Init.Vehicle_Dynamics.n_passengers = 38;                                     %in -
Init.Vehicle_Dynamics.est_fac_intertia = 1.1;                                 %in -; factor for rotational mass

%% Drivetrain
Init.Drivetrain.Config = ~(cellfun(@isempty,fileMOT));

%% Drivetrain.Battery
load([path_base '\01_Battery\Battery_cell_parameters.mat']);                 	%don't change the name, because the model would need to be updated then
[Init] = INIT_Battery(Init, E_bat, U_bat, path_base);

%% Initial mass estimation
[Init] = Mass_Cost_calculation(Init,1); % functions to calculate mass and costs

for i = 1:length(fileMOT)
    if ~isempty(fileMOT{i})
%% Drivetrain.Motor
        
        load([path_mot 'ALL\' fileMOT{i}]);
        Init.Drivetrain.MOT{i} = Horlbeck;
        
%% Drivetrain.Inverter
        [Inverter] = GENERATE_Inverter_eff_with_mot(Init, 'IGBT', visualize);
        Init.Drivetrain.INV{i} = Inverter;
        
%% Drivetrain.Transmission
        Init.Drivetrain.TM{i} = GENERATE_Simple_Transmission_design( Init, i);
%         Init.Drivetrain.TM{i} = GENERATE_Transmission_design(Init, Init.Requirements.v_max_requ, ... 
%             Init.Requirements.elev_tow, Init.Requirements.v_tow, ... 
%             Init.Requirements.a_tow, Init.Requirements.z_gears(i), ...
%             0, 'geom', visualize);
         
        Init.Drivetrain.TM{i} = GENERATE_Transmission_efficiency(Init, visualize);
    else 
        Init.Drivetrain.INV{i} = [];
        Init.Drivetrain.MOT{i} = [];
        Init.Drivetrain.TM{i} = [];
    end
end
%Phi
[CHECK_requ_T_tow, CHECK_requ_T_acc, CHECK_requ_n] = CHECK_Requirements(Init);

%% Drivetrain.Controller_Drivetrain
for i = 1:length(fileMOT)
    if ~isempty(fileMOT{i})
%         if Init.Requirements.z_gears(i) ~= 2
        try
        Init.Drivetrain.ShiftManagement{i} = ...
            GENERATE_Shift_points(Init, i, visualize); %Shift Management
        catch %try the simple shift management if the first calculation fails
            Init.Drivetrain.ShiftManagement{i}  = ... 
            GENERATE_Shift_points_alternative(Init, i, visualize); %Shift Management
        end
%         elseif Init.Requirements.z_gears(i) == 2 %create an easier shift map for 2-speed TM, because the other way does not work
%             Init.Drivetrain.ShiftManagement{i}  = ... 
%                 GENERATE_Shift_points_two_speed_TM(Init, visualize); %Shift Management
%         end
    else
        Init.Drivetrain.ShiftManagement{i} = [];
    end
end
Init.Drivetrain.PowerManagement = GENERATE_power_management(Init, visualize);

%% Driver
Init.Driver = GENERATE_inverse_vehicle(Init, Init.Requirements.v_max_requ, ...
    Init.Requirements.a_max_requ, 0, visualize);
Init.Driver.PID_factors = 10*[0.2,0.01,0.001];                             	%in -, factors for driver controller accelerating [P, I, D]

%% Initial conditions
% Signals that are fed back in the closed loop need an initial value
Init.Start_cond.v_long_actual = 0;
Init.Start_cond.gear = 1;
Init.Start_cond.V_bat_actual = Init.Drivetrain.BAT.U_bat_max;
Init.Start_cond.n_wheels_actual = 0;
Init.Start_cond.n_mot_actual = 0.1;
Init.Start_cond.T_mot_actual = 0;

%% Mass and cost calculation
[Init] = Mass_Cost_calculation(Init,0); % functions to calculate mass and costs

if m_fluctuation==1
    DC_m = load('DC_mass');
    DC_m.dc_mass = DC_m.dc_mass*Init.Mass.m_passengers*30/18; %passenger load in kg. Scale to max. passenger load
    Init.Mass.m_VEH_gross = Init.Mass.m_VEH_gross-Init.Mass.m_passengers; %reduce the gross weight by passenger load, because of the dc mass
    Init.Environment.dc.mass = DC_m.dc_mass;
else
    Init.Environment.dc.mass = 0*Init.Environment.dc.time;
end

%% Repair motor and inverter maps to avoid NaN interpolation in Simulink
[Init] = Repair_Init_eff_maps(Init);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               SIMULATION                                %
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load_system(FN_Sim_Model); %load model

%% Transfer init data to the blocks (necessary, because of library function)
Table_placeholder = zeros(3,3,3); %needed for unused lookup tables in simulink
BP_placeholder = [1 2 3]; %needed for unused lookup tables in simulink
for i = 1:length(fileMOT)
    % Define drivetrain topo (power of drive unit in kW):
%     addpath(genpath(ftm_Lib_dir));
    drive_code = {'FA1' 'FA2' 'RA1' 'RA2' 'TA1' 'TA2'};
    set_param_Motor_controller(drive_code{i}, fileMOT, i, FN_Sim_Model);
end

assignin('base','Init',Init)
assignin('base','Battery_specs',Battery_specs)
assignin('base','BP_placeholder',BP_placeholder)
assignin('base','Table_placeholder',Table_placeholder)
 %% Simulation 
warning ('off','all');
simStep = 0.01; %simulation step size.
assignin('base','simStep',simStep)
E_bat = str2double(E_bat);
U_bat = str2double(U_bat);
% Convert - Phi
Init.Vehicle_Dynamics.length = double(Init.Vehicle_Dynamics.length);
Init.Requirements.v_max_requ = Init.Requirements.v_max_requ(1,1);
Init.Requirements.a_max_requ = str2double(Init.Requirements.a_max_requ);
Init.Drivetrain.BAT.E_bat = str2double(Init.Drivetrain.BAT.E_bat);
Init.Drivetrain.BAT.U_bat_max = str2double(Init.Drivetrain.BAT.U_bat_max);
Init.Mass.m_VEH_gross = double(Init.Mass.m_VEH_gross);
Init.Mass.m_VEH_gross = Init.Mass.m_VEH_gross(1,1);
Init.Mass.m_BAT = Init.Mass.m_BAT(1,1);
Init.Mass.m_BODY = double(Init.Mass.m_BODY);
Init.Mass.m_PWT = Init.Mass.m_PWT(1,1);
Init.Mass.m_VEH_curb = double(Init.Mass.m_VEH_curb);
Init.Mass.m_VEH_curb = Init.Mass.m_VEH_curb(1,1);
Init.Start_cond.V_bat_actual = str2double(Init.Start_cond.V_bat_actual);
Init.Cost.C_BAT = Init.Cost.C_BAT(1,1);
REQU.v_max_requ = REQU.v_max_requ(1,1);
REQU.a_max_requ = str2double(REQU.a_max_requ);
CHECK_requ_n = CHECK_requ_n(1,1);
CHECK_requ_T_acc = CHECK_requ_T_acc(1,1);
Init.Drivetrain.BAT.n_serial = Init.Drivetrain.BAT.n_serial(1,1);
Init.Drivetrain.BAT.n_cells_total = Init.Drivetrain.BAT.n_cells_total(1,1);
%% Identify simulink in- and outputs
% parfor i = 1:N 
% try 
% simOut = sim(FN_Sim_Model, 'SimulationMode', 'accelerator');
% catch exception 
% error_var{i} = lasterror 
% stack_var{i} = dbstack 
% exception_var{i} = getReport(exception,'extended') 
% end 
% % end

simOut = sim(FN_Sim_Model, 'SimulationMode', 'accelerator');
assignin('base','simOut',simOut)
simout = simOut.simout;
warning ('on','all');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             DATA TREATMENT                              %
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Calculate and check results
[RES] = ALLOCATE_results_180310(simout,Init);
% Check results
[RES.CHECK] = CHECK_Results_180219(simout,Init);

%Energy consumption of configuration in kWh/km WITH charging losses
E_actual = RES.E_actual(end);
E_actual_ChargingLosses = RES.E_actual(end)/Init.Charger.eff; 

%Cost of all PWT components
Cost_actual = Init.Cost.C_BAT + sum(Init.Cost.C_INV) + ...
    sum(Init.Cost.C_MOT) + sum(Init.Cost.C_TM);

%all results in one vector
ALL_E_actual = E_actual;
ALL_Cost_actual = Cost_actual;

assignin('base','ALL_E_actual',ALL_E_actual)
assignin('base','RES',RES)

run Visualize_results_180316

%% for re-calculation
% save(['C:\Users\sebastian.krapf\Documents\08_LDS\50_Experiments\01_MANUAL_180316\' DIR(COUNT_SIM).name])

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 Help functions to make the code clearer:                %
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Init] = Repair_Init_eff_maps(Init)
%% Reduce NaNs in Motor and Inverter Map 
%to avoid errornous interpolation in Simulink
for i = 1:length(Init.Drivetrain.MOT)
    MOT = Init.Drivetrain.MOT{i}; %assign
    INV = Init.Drivetrain.INV{i}; %assign
    SHIFT = Init.Drivetrain.ShiftManagement{i}; %assign
    if ~isempty(MOT)
        for j = 1:2 %make sure there are no NaNs near the T_max line!
            %% Repair Motor Map
            [MOT.eff_n_mot,MOT.eff_T_mot,MOT.eff_mot] = ...
                Repair_map(MOT.eff_n_mot,MOT.eff_T_mot, ...
                MOT.eff_mot,MOT.T_max_mot,MOT.T_max_n_mot);
            %% Repair Inverter Map
            [INV.eff_n_inv,INV.eff_T_inv,INV.eff_inv_acc] = ...
                Repair_map(INV.eff_n_inv,INV.eff_T_inv, ...
                INV.eff_inv_acc, MOT.T_max_mot,MOT.T_max_n_mot);

            [INV.eff_n_inv,INV.eff_T_inv,INV.eff_inv_recu] = ...
                Repair_map(INV.eff_n_inv,INV.eff_T_inv, ...
                INV.eff_inv_recu,MOT.T_max_mot,MOT.T_max_n_mot);
            
            %% Repair shift map
            [SHIFT.shift_n,SHIFT.shift_T,SHIFT.shift] = ...
                Repair_map(SHIFT.shift_n,SHIFT.shift_T,SHIFT.shift, ... 
                MOT.T_max_mot,MOT.T_max_n_mot);
        end
        %% Minimum efficiency is 50%
        MOT.eff_mot(MOT.eff_mot<0.5) = 0.5;
        INV.eff_inv_acc(INV.eff_inv_acc<0.5) = 0.5;
        INV.eff_inv_recu(INV.eff_inv_recu<0.5) = 0.5;
    end
    Init.Drivetrain.MOT{i} = MOT; %assign back
    Init.Drivetrain.INV{i} = INV; %assign back
    Init.Drivetrain.ShiftManagement{i} = SHIFT; %assign
end

% end

function set_param_Motor_controller(drive_unit_short_name, fileMOT, id_config, FN_Sim_Model)
%Help function to make code clearer. Sets the parameters of all motor controllers

%% %% If component is used in this configuration %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~isempty(fileMOT{id_config})
%% Turn off warning, that library block parameters have been changed:
warning('off','Simulink:Commands:SetParamLinkChangeWarn');

%% Init
du = drive_unit_short_name;

%% Controll_Unit.Motor_Controller.Power_Management
file_block = [FN_Sim_Model '/Controll Unit/Motor controller/Power Management - Krapf - ', du, '/'] ;
file_init = ['Init.Drivetrain.TM{' num2str(id_config) '}.'];

% Gear TM actual
set_param([file_block, 'i_TM_actual'],'Table',[file_init, 'i_transmission']);
set_param([file_block, 'i_TM_gear1'], 'Value', [file_init, 'i_transmission(1)']);

% P_mot_target - Target power motor depending on target vehicle load point
file_init = ['Init.Drivetrain.PowerManagement{' num2str(id_config) '}.'];

set_param([file_block, 'P_mot_target'],'Table',[file_init, 'P_target_mot']);
set_param([file_block, 'P_mot_target'],'BreakpointsForDimension1',[file_init, 'P_target_T']);
set_param([file_block, 'P_mot_target'],'BreakpointsForDimension2',[file_init, 'P_target_n']);
set_param([file_block, 'P_mot_target'],'BreakpointsForDimension3',[file_init, 'P_target_i']);

% T_max_acc and T_max_recu - Maximum torque in acceleration and regenerating mode
file_init = ['Init.Drivetrain.MOT{' num2str(id_config) '}.'];

set_param([file_block, 'T_mot_max_acc'],'Table',[file_init, 'T_max_mot']);
set_param([file_block, 'T_mot_max_acc'],'BreakpointsForDimension1',[file_init, 'T_max_n_mot']);
set_param([file_block, 'T_mot_max_recu'],'Table',[file_init, 'T_max_mot']);
set_param([file_block, 'T_mot_max_recu'],'BreakpointsForDimension1',[file_init, 'T_max_n_mot']);

% eta MOT efficiencies in acceleration and regenerating mode
set_param([file_block, 'eta_mot_acc'],'Table',[file_init, 'eff_mot' char(39)]);
set_param([file_block, 'eta_mot_acc'],'BreakpointsForDimension1',[file_init, 'eff_n_mot']);
set_param([file_block, 'eta_mot_acc'],'BreakpointsForDimension2',[file_init, 'eff_T_mot']);

set_param([file_block, 'eta_mot_recu'],'Table',[file_init, 'eff_mot' char(39)]);
set_param([file_block, 'eta_mot_recu'],'BreakpointsForDimension1',[file_init, 'eff_n_mot']);
set_param([file_block, 'eta_mot_recu'],'BreakpointsForDimension2',[file_init, 'eff_T_mot']);

% eta INV efficiencies in acceleration and regenerating mode
file_init = ['Init.Drivetrain.INV{' num2str(id_config) '}.'];

set_param([file_block, 'eta_inv_acc'],'Table',[file_init, 'eff_inv_acc' char(39)]);
set_param([file_block, 'eta_inv_acc'],'BreakpointsForDimension1',[file_init, 'eff_n_inv']);
set_param([file_block, 'eta_inv_acc'],'BreakpointsForDimension2',[file_init, 'eff_T_inv']);

set_param([file_block, 'eta_inv_recu'],'Table',[file_init, 'eff_inv_recu' char(39)]);
set_param([file_block, 'eta_inv_recu'],'BreakpointsForDimension1',[file_init, 'eff_n_inv']);
set_param([file_block, 'eta_inv_recu'],'BreakpointsForDimension2',[file_init, 'eff_T_inv']);

% eta TM efficiencies in acceleration and regenerating mode
file_init = ['Init.Drivetrain.TM{' num2str(id_config) '}.'];

set_param([file_block, 'eta_TM_acc'],'Table',[file_init, 'eff_TM']);
set_param([file_block, 'eta_TM_acc'],'BreakpointsForDimension1',[file_init, 'eff_T_TM']);
set_param([file_block, 'eta_TM_acc'],'BreakpointsForDimension2',[file_init, 'eff_n_TM']);
set_param([file_block, 'eta_TM_acc'],'BreakpointsForDimension3',[file_init, 'eff_i_TM']);

set_param([file_block, 'eta_TM_recu'],'Table',[file_init, 'eff_TM']);
set_param([file_block, 'eta_TM_recu'],'BreakpointsForDimension1',[file_init, 'eff_T_TM']);
set_param([file_block, 'eta_TM_recu'],'BreakpointsForDimension2',[file_init, 'eff_n_TM']);
set_param([file_block, 'eta_TM_recu'],'BreakpointsForDimension3',[file_init, 'eff_i_TM']);

%% Controll_Unit.Motor_Controller.Shift_Management
file_block = [FN_Sim_Model '/Controll Unit/Motor controller/Shift Management - Krapf - ', du, '/'] ;
file_init = ['Init.Drivetrain.ShiftManagement{' num2str(id_config) '}.'];

set_param([file_block, 'shift map'],'Table',[file_init, 'shift' char(39)]);
set_param([file_block, 'shift map'],'BreakpointsForDimension1',[file_init, 'shift_n']);
set_param([file_block, 'shift map'],'BreakpointsForDimension2',[file_init, 'shift_T']);

%% Drivetrain
% T_max_acc and T_max_recu - Maximum torque in acceleration and regenerating mode
file_block = [FN_Sim_Model '/Drivetrain/Drive Unit - ', du, '/'] ;
file_init = ['Init.Drivetrain.MOT{' num2str(id_config) '}.'];

set_param([file_block, 'T_mot_max_acc'],'Table',[file_init, 'T_max_mot']);
set_param([file_block, 'T_mot_max_acc'],'BreakpointsForDimension1',[file_init, 'T_max_n_mot']);
set_param([file_block, 'T_mot_max_recu'],'Table',[file_init, 'T_max_mot']);
set_param([file_block, 'T_mot_max_recu'],'BreakpointsForDimension1',[file_init, 'T_max_n_mot'])

%% Drivetrain.Inverter
% eta INV efficiencies in acceleration and regenerating mode
file_block = [FN_Sim_Model '/Drivetrain/Drive Unit - ', du, '/Inverter/'] ;
file_init = ['Init.Drivetrain.INV{' num2str(id_config) '}.'];

set_param([file_block, 'eta_inv_acc'],'Table',[file_init, 'eff_inv_acc' char(39)]);
set_param([file_block, 'eta_inv_acc'],'BreakpointsForDimension1',[file_init, 'eff_n_inv']);
set_param([file_block, 'eta_inv_acc'],'BreakpointsForDimension2',[file_init, 'eff_T_inv']);

set_param([file_block, 'eta_inv_recu'],'Table',[file_init, 'eff_inv_recu' char(39)]);
set_param([file_block, 'eta_inv_recu'],'BreakpointsForDimension1',[file_init, 'eff_n_inv']);
set_param([file_block, 'eta_inv_recu'],'BreakpointsForDimension2',[file_init, 'eff_T_inv']);

%% Drivetrain.Motor
% eta MOT efficiencies in acceleration and regenerating mode
file_block = [FN_Sim_Model '/Drivetrain/Drive Unit - ', du, '/Electric Motor/'] ;
file_init = ['Init.Drivetrain.MOT{' num2str(id_config) '}.'];

set_param([file_block, 'eta_mot_acc'],'Table',[file_init, 'eff_mot' char(39)]);
set_param([file_block, 'eta_mot_acc'],'BreakpointsForDimension1',[file_init, 'eff_n_mot']);
set_param([file_block, 'eta_mot_acc'],'BreakpointsForDimension2',[file_init, 'eff_T_mot']);

set_param([file_block, 'eta_mot_recu'],'Table',[file_init, 'eff_mot' char(39)]);
set_param([file_block, 'eta_mot_recu'],'BreakpointsForDimension1',[file_init, 'eff_n_mot']);
set_param([file_block, 'eta_mot_recu'],'BreakpointsForDimension2',[file_init, 'eff_T_mot']);

%interiat motor
file_init = ['Init.Mass.J_MOT(' num2str(id_config) ')'];
set_param([file_block, 'J_mot_red_actual'], 'Value', file_init);

%% Drivetrain.Transmission
% eta TM efficiencies in acceleration and regenerating mode
file_block = [FN_Sim_Model '/Drivetrain/Drive Unit - ', du, '/Transmission/'] ;
file_init = ['Init.Drivetrain.TM{' num2str(id_config) '}.'];

set_param([file_block, 'eta_TM_acc'],'Table',[file_init, 'eff_TM' ]);
set_param([file_block, 'eta_TM_acc'],'BreakpointsForDimension1',[file_init, 'eff_T_TM']);
set_param([file_block, 'eta_TM_acc'],'BreakpointsForDimension2',[file_init, 'eff_n_TM']);
set_param([file_block, 'eta_TM_acc'],'BreakpointsForDimension3',[file_init, 'eff_i_TM']);

set_param([file_block, 'eta_TM_recu'],'Table',[file_init, 'eff_TM' ]);
set_param([file_block, 'eta_TM_recu'],'BreakpointsForDimension1',[file_init, 'eff_T_TM']);
set_param([file_block, 'eta_TM_recu'],'BreakpointsForDimension2',[file_init, 'eff_n_TM']);
set_param([file_block, 'eta_TM_recu'],'BreakpointsForDimension3',[file_init, 'eff_i_TM']);

%gears TM 
set_param([file_block, 'i_TM_actual'],'Table',[file_init, 'i_transmission']);
set_param([file_block, 'gear_limit'],'UpperLimit',['length(' file_init, 'i_transmission)']);

%intertia TM 
file_init = ['Init.Mass.J_TM{' num2str(id_config) '}'];
set_param([file_block, 'J_TM_actual'],'Table',file_init);

%% %% If component is NOT used in this configuration: Everything is empty %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Every lookup table is empty, but still needs to ne specified as such to avoid erros
else

%% Turn off warning, that library block parameters have been changed:
warning('off','Simulink:Commands:SetParamLinkChangeWarn');

%% Init
du = drive_unit_short_name;

%% Controll_Unit.Motor_Controller.Power_Management
file_block = [FN_Sim_Model '/Controll Unit/Motor controller/Power Management - Krapf - ', du, '/'] ;

% Gear TM actual
set_param([file_block, 'i_TM_actual'],'Table', 'Table_placeholder(1,1,1)');
set_param([file_block, 'i_TM_gear1'], 'Value', 'Table_placeholder(1,1,1)');

% P_mot_target - Target power motor depending on target vehicle load point
set_param([file_block, 'P_mot_target'],'Table','Table_placeholder');
set_param([file_block, 'P_mot_target'],'BreakpointsForDimension1','BP_placeholder');
set_param([file_block, 'P_mot_target'],'BreakpointsForDimension2','BP_placeholder');
set_param([file_block, 'P_mot_target'],'BreakpointsForDimension3','BP_placeholder');

% T_max_acc and T_max_recu - Maximum torque in acceleration and regenerating mode
file_init = ['Init.Drivetrain.MOT{' num2str(id_config) '}.'];

set_param([file_block, 'T_mot_max_acc'],'Table','Table_placeholder(:,1,1)');
set_param([file_block, 'T_mot_max_acc'],'BreakpointsForDimension1','BP_placeholder');
set_param([file_block, 'T_mot_max_recu'],'Table','Table_placeholder(:,1,1)');
set_param([file_block, 'T_mot_max_recu'],'BreakpointsForDimension1','BP_placeholder');

% eta MOT efficiencies in acceleration and regenerating mode
set_param([file_block, 'eta_mot_acc'],'Table','Table_placeholder(:,:,1)');
set_param([file_block, 'eta_mot_acc'],'BreakpointsForDimension1','BP_placeholder');
set_param([file_block, 'eta_mot_acc'],'BreakpointsForDimension2','BP_placeholder');

set_param([file_block, 'eta_mot_recu'],'Table','Table_placeholder(:,:,1)');
set_param([file_block, 'eta_mot_recu'],'BreakpointsForDimension1','BP_placeholder');
set_param([file_block, 'eta_mot_recu'],'BreakpointsForDimension2','BP_placeholder');

% eta INV efficiencies in acceleration and regenerating mode
file_init = ['Init.Drivetrain.INV{' num2str(id_config) '}.'];

set_param([file_block, 'eta_inv_acc'],'Table','Table_placeholder(:,:,1)');
set_param([file_block, 'eta_inv_acc'],'BreakpointsForDimension1','BP_placeholder');
set_param([file_block, 'eta_inv_acc'],'BreakpointsForDimension2','BP_placeholder');

set_param([file_block, 'eta_inv_recu'],'Table','Table_placeholder(:,:,1)');
set_param([file_block, 'eta_inv_recu'],'BreakpointsForDimension1','BP_placeholder');
set_param([file_block, 'eta_inv_recu'],'BreakpointsForDimension2','BP_placeholder');

% eta TM efficiencies in acceleration and regenerating mode
file_init = ['Init.Drivetrain.TM{' num2str(id_config) '}.'];

set_param([file_block, 'eta_TM_acc'],'Table','Table_placeholder(:,:,:)');
set_param([file_block, 'eta_TM_acc'],'BreakpointsForDimension1','BP_placeholder');
set_param([file_block, 'eta_TM_acc'],'BreakpointsForDimension2','BP_placeholder');
set_param([file_block, 'eta_TM_acc'],'BreakpointsForDimension3','BP_placeholder');

set_param([file_block, 'eta_TM_recu'],'Table','Table_placeholder(:,:,:)');
set_param([file_block, 'eta_TM_recu'],'BreakpointsForDimension1','BP_placeholder');
set_param([file_block, 'eta_TM_recu'],'BreakpointsForDimension2','BP_placeholder');
set_param([file_block, 'eta_TM_recu'],'BreakpointsForDimension3','BP_placeholder');

%% Controll_Unit.Motor_Controller.Shift_Management
file_block = [FN_Sim_Model '/Controll Unit/Motor controller/Shift Management - Krapf - ', du, '/'] ;
file_init = ['Init.Drivetrain.ShiftManagement{' num2str(id_config) '}.'];

set_param([file_block, 'shift map'],'Table','Table_placeholder(:,:,1)');
set_param([file_block, 'shift map'],'BreakpointsForDimension1','BP_placeholder');
set_param([file_block, 'shift map'],'BreakpointsForDimension2','BP_placeholder');

%% Drivetrain
% T_max_acc and T_max_recu - Maximum torque in acceleration and regenerating mode
file_block = [FN_Sim_Model '/Drivetrain/Drive Unit - ', du, '/'] ;
file_init = ['Init.Drivetrain.MOT{' num2str(id_config) '}.'];

set_param([file_block, 'T_mot_max_acc'],'Table','Table_placeholder(:,1,1)');
set_param([file_block, 'T_mot_max_acc'],'BreakpointsForDimension1','BP_placeholder');
set_param([file_block, 'T_mot_max_recu'],'Table','Table_placeholder(:,1,1)');
set_param([file_block, 'T_mot_max_recu'],'BreakpointsForDimension1','BP_placeholder')

%% Drivetrain.Inverter
% eta INV efficiencies in acceleration and regenerating mode
file_block = [FN_Sim_Model '/Drivetrain/Drive Unit - ', du, '/Inverter/'] ;
file_init = ['Init.Drivetrain.INV{' num2str(id_config) '}.'];

set_param([file_block, 'eta_inv_acc'],'Table','Table_placeholder(:,:,1)');
set_param([file_block, 'eta_inv_acc'],'BreakpointsForDimension1','BP_placeholder');
set_param([file_block, 'eta_inv_acc'],'BreakpointsForDimension2','BP_placeholder');

set_param([file_block, 'eta_inv_recu'],'Table','Table_placeholder(:,:,1)');
set_param([file_block, 'eta_inv_recu'],'BreakpointsForDimension1','BP_placeholder');
set_param([file_block, 'eta_inv_recu'],'BreakpointsForDimension2','BP_placeholder');

%% Drivetrain.Motor
% eta MOT efficiencies in acceleration and regenerating mode
file_block = [FN_Sim_Model '/Drivetrain/Drive Unit - ', du, '/Electric Motor/'] ;
file_init = ['Init.Drivetrain.MOT{' num2str(id_config) '}.'];

set_param([file_block, 'eta_mot_acc'],'Table','Table_placeholder(:,:,1)');
set_param([file_block, 'eta_mot_acc'],'BreakpointsForDimension1','BP_placeholder');
set_param([file_block, 'eta_mot_acc'],'BreakpointsForDimension2','BP_placeholder');

set_param([file_block, 'eta_mot_recu'],'Table','Table_placeholder(:,:,1)');
set_param([file_block, 'eta_mot_recu'],'BreakpointsForDimension1','BP_placeholder');
set_param([file_block, 'eta_mot_recu'],'BreakpointsForDimension2','BP_placeholder');

%interiat motor
file_init = ['Init.Mass.J_MOT(' num2str(id_config) ')'];
set_param([file_block, 'J_mot_red_actual'], 'Value', file_init);


%% Drivetrain.Transmission
% eta TM efficiencies in acceleration and regenerating mode
file_block = [FN_Sim_Model '/Drivetrain/Drive Unit - ', du, '/Transmission/'] ;
file_init = ['Init.Drivetrain.TM{' num2str(id_config) '}.'];

set_param([file_block, 'eta_TM_acc'],'Table','Table_placeholder(:,:,:)');
set_param([file_block, 'eta_TM_acc'],'BreakpointsForDimension1','BP_placeholder');
set_param([file_block, 'eta_TM_acc'],'BreakpointsForDimension2','BP_placeholder');
set_param([file_block, 'eta_TM_acc'],'BreakpointsForDimension3','BP_placeholder');

set_param([file_block, 'eta_TM_recu'],'Table','Table_placeholder(:,:,:)');
set_param([file_block, 'eta_TM_recu'],'BreakpointsForDimension1','BP_placeholder');
set_param([file_block, 'eta_TM_recu'],'BreakpointsForDimension2','BP_placeholder');
set_param([file_block, 'eta_TM_recu'],'BreakpointsForDimension3','BP_placeholder');

%gears TM 
set_param([file_block, 'i_TM_actual'],'Table','Table_placeholder(1,1,1)');
set_param([file_block, 'gear_limit'],'UpperLimit','1');

%intertia TM 
file_init = ['Init.Mass.J_TM{' num2str(id_config) '}'];
set_param([file_block, 'J_TM_actual'],'Table','Table_placeholder(1,1,1)');

end
%% Turn warning on again
warning('on','Simulink:Commands:SetParamLinkChangeWarn');
% end


% assignin('base','ALL_E_actual',ALL_E_actual)
% assignin('base','RES',RES)
% assignin('base','simout',simout)         
        
        
    
%% Trash

% --- Executes on button press in pb_AddPowertrain.
function pb_AddPowertrain_Callback(hObject, eventdata, handles)
% hObject    handle to pb_AddPowertrain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uip_Powertrain_Simulation,'Visible','on')
set(handles.uip_VehicleSpecification,'Visible','off');
set(handles.uip_Powertrain,'Visible','off');
set(handles.uip_Chassis,'Visible','off');
set(handles.uip_Cooling,'Visible','off');
set(handles.uip_Automated_Visualization,'Visible','off');

% --- Executes on button press in pb_Ch_Database.
function pb_Ch_Database_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Ch_Database (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_Ch_UpdateDatabase.
function pb_Ch_UpdateDatabase_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Ch_UpdateDatabase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in pm_DatabaseComponents.
function pm_DatabaseComponents_Callback(hObject, eventdata, handles)
% hObject    handle to pm_DatabaseComponents (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_DatabaseComponents contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_DatabaseComponents


% --- Executes during object creation, after setting all properties.
function pm_DatabaseComponents_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_DatabaseComponents (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ed_Ch_EnterDatabase_Callback(hObject, eventdata, handles)
% hObject    handle to ed_Ch_EnterDatabase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ed_Ch_EnterDatabase as text
%        str2double(get(hObject,'String')) returns contents of ed_Ch_EnterDatabase as a double


% --- Executes during object creation, after setting all properties.
function ed_Ch_EnterDatabase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ed_Ch_EnterDatabase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_Ch_Continue.
function pb_Ch_Continue_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Ch_Continue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pb_return_PT_SL.
function pb_return_PT_SL_Callback(hObject, eventdata, handles)
% hObject    handle to pb_return_PT_SL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pb_Automated_Visu_Side.
function pb_Automated_Visu_Side_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Automated_Visu_Side (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_Automated_Visu_Front.
function pb_Automated_Visu_Front_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Automated_Visu_Front (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function txt_OV_VC_ed_Callback(hObject, eventdata, handles)
% hObject    handle to txt_OV_VC_ed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_OV_VC_ed as text
%        str2double(get(hObject,'String')) returns contents of txt_OV_VC_ed as a double


% --- Executes during object creation, after setting all properties.
function txt_OV_VC_ed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_OV_VC_ed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_OV_NoP_ed_Callback(hObject, eventdata, handles)
% hObject    handle to txt_OV_NoP_ed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_OV_NoP_ed as text
%        str2double(get(hObject,'String')) returns contents of txt_OV_NoP_ed as a double


% --- Executes during object creation, after setting all properties.
function txt_OV_NoP_ed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_OV_NoP_ed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_OV_SA_ed_Callback(hObject, eventdata, handles)
% hObject    handle to txt_OV_SA_ed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_OV_SA_ed as text
%        str2double(get(hObject,'String')) returns contents of txt_OV_SA_ed as a double


% --- Executes during object creation, after setting all properties.
function txt_OV_SA_ed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_OV_SA_ed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_Automated_Visu_ISO.
function pb_Automated_Visu_ISO_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Automated_Visu_ISO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function txt_OV_VehicleMassALL_ed_Callback(hObject, eventdata, handles)
% hObject    handle to txt_OV_VehicleMassALL_ed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_OV_VehicleMassALL_ed as text
%        str2double(get(hObject,'String')) returns contents of txt_OV_VehicleMassALL_ed as a double


% --- Executes during object creation, after setting all properties.
function txt_OV_VehicleMassALL_ed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_OV_VehicleMassALL_ed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_OV_VehicleDimension_ed_Callback(hObject, eventdata, handles)
% hObject    handle to txt_OV_VehicleDimension_ed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_OV_VehicleDimension_ed as text
%        str2double(get(hObject,'String')) returns contents of txt_OV_VehicleDimension_ed as a double


% --- Executes during object creation, after setting all properties.
function txt_OV_VehicleDimension_ed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_OV_VehicleDimension_ed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_Automated_Visu_Suspension.
function pb_Automated_Visu_Suspension_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Automated_Visu_Suspension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_Automated_Visu_Seating.
function pb_Automated_Visu_Seating_Callback(hObject, eventdata, handles)
% hObject    handle to pb_Automated_Visu_Seating (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function txt_CE_Cost_Inverter_2_Callback(hObject, eventdata, handles)
% hObject    handle to txt_CE_Cost_Inverter_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_CE_Cost_Inverter_2 as text
%        str2double(get(hObject,'String')) returns contents of txt_CE_Cost_Inverter_2 as a double


% --- Executes during object creation, after setting all properties.
function txt_CE_Cost_Inverter_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_CE_Cost_Inverter_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_CE_Cost_Motor_2_Callback(hObject, eventdata, handles)
% hObject    handle to txt_CE_Cost_Motor_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_CE_Cost_Motor_2 as text
%        str2double(get(hObject,'String')) returns contents of txt_CE_Cost_Motor_2 as a double


% --- Executes during object creation, after setting all properties.
function txt_CE_Cost_Motor_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_CE_Cost_Motor_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_CE_Cost_Transmission_2_Callback(hObject, eventdata, handles)
% hObject    handle to txt_CE_Cost_Transmission_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_CE_Cost_Transmission_2 as text
%        str2double(get(hObject,'String')) returns contents of txt_CE_Cost_Transmission_2 as a double


% --- Executes during object creation, after setting all properties.
function txt_CE_Cost_Transmission_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_CE_Cost_Transmission_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_CE_Cost_Battery_2_Callback(hObject, eventdata, handles)
% hObject    handle to txt_CE_Cost_Battery_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_CE_Cost_Battery_2 as text
%        str2double(get(hObject,'String')) returns contents of txt_CE_Cost_Battery_2 as a double


% --- Executes during object creation, after setting all properties.
function txt_CE_Cost_Battery_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_CE_Cost_Battery_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_CE_Cost_Battery_1_Callback(hObject, eventdata, handles)
% hObject    handle to txt_CE_Cost_Battery_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_CE_Cost_Battery_1 as text
%        str2double(get(hObject,'String')) returns contents of txt_CE_Cost_Battery_1 as a double


% --- Executes during object creation, after setting all properties.
function txt_CE_Cost_Battery_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_CE_Cost_Battery_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_CE_Cost_Inverter_1_Callback(hObject, eventdata, handles)
% hObject    handle to txt_CE_Cost_Inverter_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_CE_Cost_Inverter_1 as text
%        str2double(get(hObject,'String')) returns contents of txt_CE_Cost_Inverter_1 as a double


% --- Executes during object creation, after setting all properties.
function txt_CE_Cost_Inverter_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_CE_Cost_Inverter_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_CE_Cost_Motor_1_Callback(hObject, eventdata, handles)
% hObject    handle to txt_CE_Cost_Motor_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_CE_Cost_Motor_1 as text
%        str2double(get(hObject,'String')) returns contents of txt_CE_Cost_Motor_1 as a double


% --- Executes during object creation, after setting all properties.
function txt_CE_Cost_Motor_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_CE_Cost_Motor_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txt_CE_Cost_Transmission_1_Callback(hObject, eventdata, handles)
% hObject    handle to txt_CE_Cost_Transmission_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_CE_Cost_Transmission_1 as text
%        str2double(get(hObject,'String')) returns contents of txt_CE_Cost_Transmission_1 as a double


% --- Executes during object creation, after setting all properties.
function txt_CE_Cost_Transmission_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_CE_Cost_Transmission_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
