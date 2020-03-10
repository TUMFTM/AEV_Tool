function varargout = GUI_Concept(varargin)


% GUI_CONCEPT MATLAB code for GUI_Concept.fig
%      GUI_CONCEPT, by itself, creates a new GUI_CONCEPT or raises the existing
%      singleton*.
%
%      H = GUI_CONCEPT returns the handle to a new GUI_CONCEPT or the handle to
%      the existing singleton*.
%
%      GUI_CONCEPT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_CONCEPT.M with the given input arguments.
%
%      GUI_CONCEPT('Property','Value',...) creates a new GUI_CONCEPT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Concept_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Concept_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Concept

% Last Modified by GUIDE v2.5 07-Feb-2018 09:34:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @GUI_Concept_OpeningFcn, ...
    'gui_OutputFcn',  @GUI_Concept_OutputFcn, ...
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


% --- Executes just before GUI_Concept is made visible.
function GUI_Concept_OpeningFcn(hObject, eventdata, handles, varargin)
global path_base
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Concept (see VARARGIN)

% Choose default command line output for GUI_Concept
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Concept wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Image Bus Iso View
[x,map]=imread('Bus_ISO.png');
I1=imresize(x, [4200 11300]);
f=figure;
imagesc(x);set(gcf,'Visible', 'off');
set(gca,'units','normalized','position',[0 0 1 1]);
set(gcf,'units','pixels','position',[100 100 550 380]);
I1=getframe(gca);
I1=I1.cdata;
close(f)
set(handles.pushbutton_bus_iso,'cdata',I1);

% Image Bus Front View
[x,map]=imread('Bus_Front.png');
I2=imresize(x, [4200 11300]);
f=figure;
imagesc(x);set(gcf,'Visible', 'off');
set(gca,'units','normalized','position',[0 0 1 1]);
set(gcf,'units','pixels','position',[100 100 550 380]);
I2=getframe(gca);
I2=I2.cdata;
close(f)
set(handles.pushbutton_bus_front,'cdata',I2);

% Image Bus Side View
[x,map]=imread('Bus_Side.png');
I3=imresize(x, [4200 11300]);
f=figure;
imagesc(x);set(gcf,'Visible', 'off');
set(gca,'units','normalized','position',[0 0 1 1]);
set(gcf,'units','pixels','position',[150 150 420 380]);
I3=getframe(gca);
I3=I3.cdata;
close(f)
set(handles.pushbutton_bus_side,'cdata',I3);


% Load vehicle specification DB
load([path_base '\10_Results\Components\Selection.mat']);

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
    
    set(handles.uibuttongroup_suspension_specification,'visible','on');
    set(handles.uibuttongroup_interior_specification,'visible','off');
    
    
    
    load ('Link_selection','t_aarm','d_aarm');
    set(handles.text_suspension_links, 'String', num2str(d_aarm*2));
    
    
    
    % Image Bus Suspension View
    [x,map]=imread('Bus_Suspension_ISO.png');
    I4=imresize(x, [4200 11300]);
    f=figure;
    imagesc(x);set(gcf,'Visible', 'off');
    set(gca,'units','normalized','position',[0 0 1 1]);
    set(gcf,'units','pixels','position',[150 150 550 260]);
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
    
    set(handles.uibuttongroup_suspension_specification,'visible','off');
    set(handles.uibuttongroup_interior_specification,'visible','on');
    
    % Image Bus Seat Layout UL1 View
    [x,map]=imread('Bus_Interior.png');
    I4=imresize(x, [4200 11300]);
    f=figure;
    imagesc(x);set(gcf,'Visible', 'off');
    set(gca,'units','normalized','position',[0 0 1 1]);
    set(gcf,'units','pixels','position',[150 150 420 380]);
    I4=getframe(gca);
    I4=I4.cdata;
    close(f)
    set(handles.pushbutton_details,'cdata',I4);
    
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
    
    set(handles.uibuttongroup_suspension_specification,'visible','off');
    set(handles.uibuttongroup_interior_specification,'visible','on');
    
    % Image Bus Seat Layout UL2 View
    [x,map]=imread('Bus_Interior.png');
    I4=imresize(x, [4200 11300]);
    f=figure;
    imagesc(x);set(gcf,'Visible', 'off');
    set(gca,'units','normalized','position',[0 0 1 1]);
    set(gcf,'units','pixels','position',[150 150 420 380]);
    I4=getframe(gca);
    I4=I4.cdata;
    close(f)
    set(handles.pushbutton_details,'cdata',I4);
    
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
    
    set(handles.uibuttongroup_suspension_specification,'visible','off');
    set(handles.uibuttongroup_interior_specification,'visible','on');
    
    % Image Bus Seat Layout CL1 View
    [x,map]=imread('Bus_Interior.png');
    I4=imresize(x, [4200 11300]);
    f=figure;
    imagesc(x);set(gcf,'Visible', 'off');
    set(gca,'units','normalized','position',[0 0 1 1]);
    set(gcf,'units','pixels','position',[150 150 420 380]);
    I4=getframe(gca);
    I4=I4.cdata;
    close(f)
    set(handles.pushbutton_details,'cdata',I4);
    
end

% Load vehicle specification from CATIA - Mass & Center of Gravity
fid = fopen([path_base '06_Exchange\catia_inertia.txt'], 'rt');
inertia = fgetl(fid);
fclose(fid);

inertia_array = strsplit(inertia);
m_overall =  str2double(inertia_array{1,1});
inertia_coo_x =  str2double(inertia_array{1,2})*1000; %mm
inertia_coo_y =  str2double(inertia_array{1,3})*1000; %mm
inertia_coo_z =  str2double(inertia_array{1,4})*1000; %mm

save([path_base '06_Exchange\inertia.mat','inertia_array']);


set(handles.text_output_total_weight, 'String', num2str(m_overall));
set(handles.text_output_cog_x, 'String', num2str(inertia_coo_x));
set(handles.text_output_cog_y, 'String', num2str(inertia_coo_y));
set(handles.text_output_cog_z, 'String', num2str(inertia_coo_z));

inertia = '';
fid = fopen([path_base '06_Exchange\catia_inertia.txt'], 'wt');
fprintf(fid,'%s',inertia);
fclose(fid);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Concept_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function text_bus_concept_visualization_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_bus_concept_visualization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in pushbutton_change_concept.
function pushbutton_change_concept_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_change_concept (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all force
clc;
clear all
Menu


% --- Executes on button press in pushbutton_view_mbs_model.
function pushbutton_view_mbs_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view_mbs_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open_system('VehicleDynamics3D')


% --- Executes on button press in pushbutton_view_cad_model.
function pushbutton_view_cad_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view_cad_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Execute CATIA macro
winopen CATIA_Open_Update_Save.CATScript;


% --- Executes on button press in pushbutton_save_concept.
function pushbutton_save_concept_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_concept (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
report;


% --- Executes during object creation, after setting all properties.
function text_output_overall_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_output_overall_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_output_overall_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_output_overall_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_output_overall_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_output_overall_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_output_wheelbase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_output_wheelbase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_output_ground_clearance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_output_ground_clearance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_output_lifting_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_output_lifting_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_output_total_weight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_output_total_weight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_output_number_of_passenger_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_output_number_of_passenger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_output_cog_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_output_cog_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_output_cog_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_output_cog_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_output_cog_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_output_cog_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_output_interior_layout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_output_interior_layout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_output_number_of_seats_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_output_number_of_seats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_output_number_of_standing_people_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_output_number_of_standing_people (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_output_percentage_sitting_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_output_percentage_sitting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


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


% --- Executes on button press in pushbutton_bus_iso.
function pushbutton_bus_front_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_bus_iso (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_details.
function pushbutton_details_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_details (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   
