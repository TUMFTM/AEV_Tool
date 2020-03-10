function varargout = GUI_Component_Selection_Manual(varargin)
% GUI_COMPONENT_SELECTION_MANUAL MATLAB code for GUI_Component_Selection_Manual.fig
%      GUI_COMPONENT_SELECTION_MANUAL, by itself, creates a new GUI_COMPONENT_SELECTION_MANUAL or raises the existing
%      singleton*.
%
%      H = GUI_COMPONENT_SELECTION_MANUAL returns the handle to a new GUI_COMPONENT_SELECTION_MANUAL or the handle to
%      the existing singleton*.
%
%      GUI_COMPONENT_SELECTION_MANUAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_COMPONENT_SELECTION_MANUAL.M with the given input arguments.
%
%      GUI_COMPONENT_SELECTION_MANUAL('Property','Value',...) creates a new GUI_COMPONENT_SELECTION_MANUAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Component_Selection_Manual_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Component_Selection_Manual_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Component_Selection_Manual

% Last Modified by GUIDE v2.5 21-Mar-2018 14:19:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Component_Selection_Manual_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Component_Selection_Manual_OutputFcn, ...
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


% --- Executes just before GUI_Component_Selection_Manual is made visible.
function GUI_Component_Selection_Manual_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Component_Selection_Manual (see VARARGIN)

% Choose default command line output for GUI_Component_Selection_Manual
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Component_Selection_Manual wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%Disabling all edits for structured user input

%Powertrain
set(handles.edit_motor_length,'Enable','off');
set(handles.edit_motor_diameter,'Enable','off');
set(handles.popupmenu_motor_material,'Enable','off');
set(handles.edit_cooler_length,'Enable','off');
set(handles.edit_cooler_height,'Enable','off');
set(handles.edit_cooler_thickness,'Enable','off');
set(handles.popupmenu_cooler_material,'Enable','off');
set(handles.edit_transmission_length,'Enable','off');
set(handles.edit_transmission_width,'Enable','off');
set(handles.popupmenu_transmission_material,'Enable','off');
set(handles.edit_inverter_length,'Enable','off');
set(handles.edit_inverter_width,'Enable','off');
set(handles.edit_inverter_height,'Enable','off');
set(handles.popupmenu_inverter_material,'Enable','off');
set(handles.edit_cell_volume,'Enable','off');
set(handles.edit_cell_diameter,'Enable','off');
set(handles.edit_cell_height,'Enable','off');
set(handles.popupmenu_cell_material,'Enable','off');
set(handles.edit_thickness_box,'Enable','off');
set(handles.edit_battery_electronics_height,'Enable','off');
set(handles.popupmenu_box_material,'Enable','off');

%Interior
set(handles.edit_seat_length,'Enable','off');
set(handles.edit_seat_width,'Enable','off');
set(handles.edit_seat_height,'Enable','off');
set(handles.edit_seat_thickness,'Enable','off');
set(handles.popupmenu_seat_material,'Enable','off');
set(handles.edit_backrest_height,'Enable','off');
set(handles.edit_leg_clearance,'Enable','off');
set(handles.edit_seat_gap,'Enable','off');
set(handles.edit_passenger_shoulder_width,'Enable','off');
set(handles.edit_passenger_body_depth,'Enable','off');

%Suspension
set(handles.edit_tire_width,'Enable','off');
set(handles.edit_tire_diameter,'Enable','off');
set(handles.edit_rim_diameter,'Enable','off');
set(handles.edit_rim_thickness,'Enable','off');
set(handles.popupmenu_tire_material,'Enable','off');
set(handles.popupmenu_rim_material,'Enable','off');
set(handles.edit_disc_outer_diameter,'Enable','off');
set(handles.edit_disc_inner_diameter,'Enable','off');
set(handles.edit_disc_thickness,'Enable','off');
set(handles.popupmenu_disc_material,'Enable','off');
set(handles.popupmenu_brake_pad_material,'Enable','off');
set(handles.popupmenu_brake_caliper_material,'Enable','off');
set(handles.edit_carrier_length,'Enable','off');
set(handles.edit_carrier_width,'Enable','off');
set(handles.popupmenu_carrier_material,'Enable','off');
set(handles.edit_aarm_diameter,'Enable','off');
set(handles.edit_aarm_thickness,'Enable','off');
set(handles.popupmenu_aarm_material,'Enable','off');
set(handles.edit_air_spring_height,'Enable','off');
set(handles.edit_air_spring_diameter,'Enable','off');
set(handles.popupmenu_air_spring_material,'Enable','off');
set(handles.edit_air_tank_diameter,'Enable','off');
set(handles.edit_air_tank_length,'Enable','off');
set(handles.edit_air_tank_thickness,'Enable','off');
set(handles.popupmenu_air_tank_material,'Enable','off');
set(handles.edit_compressor_diameter,'Enable','off');
set(handles.edit_compressor_length,'Enable','off');
set(handles.edit_compressor_thickness,'Enable','off');
set(handles.popupmenu_compressor_material,'Enable','off');
set(handles.edit_front_angle,'Enable','off');
set(handles.edit_rear_angle,'Enable','off');
set(handles.edit_axis_thickness,'Enable','off');
set(handles.edit_axis_diameter,'Enable','off');
set(handles.popupmenu_axis_material,'Enable','off');
set(handles.edit_damper_diameter,'Enable','off');
set(handles.popupmenu_damper_material,'Enable','off');

%Chassis
set(handles.edit_roof_height,'Enable','off');
set(handles.edit_body_thickness,'Enable','off');
set(handles.popupmenu_body_material,'Enable','off');
set(handles.popupmenu_wheelhouse_material,'Enable','off');
set(handles.edit_door_height,'Enable','off');
set(handles.edit_door_width,'Enable','off');
set(handles.edit_door_thickness,'Enable','off');
set(handles.popupmenu_door_material,'Enable','off');
set(handles.edit_window_thickness,'Enable','off');
set(handles.edit_window_shoulder,'Enable','off');
set(handles.edit_window_height,'Enable','off');
set(handles.popupmenu_window_material,'Enable','off');
set(handles.edit_floor_thickness,'Enable','off');
set(handles.edit_floor_height,'Enable','off');
set(handles.popupmenu_floor_material,'Enable','off');
set(handles.edit_frame_thickness,'Enable','off');
set(handles.edit_frame_height,'Enable','off');
set(handles.popupmenu_frame_material,'Enable','off');
set(handles.edit_ramp_length,'Enable','off');
set(handles.edit_ramp_width,'Enable','off');
set(handles.edit_ramp_thickness,'Enable','off');
set(handles.popupmenu_ramp_material,'Enable','off');
set(handles.edit_curb_height,'Enable','off');

%Electronics
set(handles.edit_lidar_height,'Enable','off');
set(handles.edit_lidar_diameter,'Enable','off');
set(handles.popupmenu_lidar_material,'Enable','off');
set(handles.edit_ac_length,'Enable','off');
set(handles.edit_ac_width,'Enable','off');
set(handles.edit_ac_height,'Enable','off');
set(handles.popupmenu_ac_material,'Enable','off');



% --- Outputs from this function are returned to the command line.
function varargout = GUI_Component_Selection_Manual_OutputFcn(~, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function text_manual_component_selection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_manual_component_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_Label_Selection_Manual_Callback(hObject, eventdata, handles)
% hObject    handle to text_manual_component_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: get(hObject,'String') returns contents of text_manual_component_selection as text
%        str2double(get(hObject,'String')) returns contents of text_manual_component_selection as a double



%% Overall Vehicle Group



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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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



%% Vehicle Configuration Group



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



%% Powertrain Group



% --- Executes on button press in checkbox_enable_powertrain.
function checkbox_enable_powertrain_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_enable_powertrain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_enable_powertrain
if handles.checkbox_enable_powertrain.Value == 1
    
    set(handles.edit_motor_length,'Enable','on');
    set(handles.edit_motor_diameter,'Enable','on');
    set(handles.popupmenu_motor_material,'Enable','on');
    set(handles.edit_cooler_length,'Enable','on');
    set(handles.edit_cooler_height,'Enable','on');
    set(handles.edit_cooler_thickness,'Enable','on');
    set(handles.popupmenu_cooler_material,'Enable','on');
    set(handles.edit_transmission_length,'Enable','on');
    set(handles.edit_transmission_width,'Enable','on');
    set(handles.popupmenu_transmission_material,'Enable','on');
    set(handles.edit_inverter_length,'Enable','on');
    set(handles.edit_inverter_width,'Enable','on');
    set(handles.edit_inverter_height,'Enable','on');
    set(handles.popupmenu_inverter_material,'Enable','on');
    set(handles.edit_cell_volume,'Enable','on');
    set(handles.edit_cell_diameter,'Enable','on');
    set(handles.edit_cell_height,'Enable','on');
    set(handles.popupmenu_cell_material,'Enable','on');
    set(handles.edit_thickness_box,'Enable','on');
    set(handles.edit_battery_electronics_height,'Enable','on');
    set(handles.popupmenu_box_material,'Enable','on');
    
else
    set(handles.edit_motor_length,'Enable','off');
    set(handles.edit_motor_diameter,'Enable','off');
    set(handles.popupmenu_motor_material,'Enable','off');
    set(handles.edit_cooler_length,'Enable','off');
    set(handles.edit_cooler_height,'Enable','off');
    set(handles.edit_cooler_thickness,'Enable','off');
    set(handles.popupmenu_cooler_material,'Enable','off');
    set(handles.edit_transmission_length,'Enable','off');
    set(handles.edit_transmission_width,'Enable','off');
    set(handles.popupmenu_transmission_material,'Enable','off');
    set(handles.edit_inverter_length,'Enable','off');
    set(handles.edit_inverter_width,'Enable','off');
    set(handles.edit_inverter_height,'Enable','off');
    set(handles.popupmenu_inverter_material,'Enable','off');
    set(handles.edit_cell_volume,'Enable','off');
    set(handles.edit_cell_diameter,'Enable','off');
    set(handles.edit_cell_height,'Enable','off');
    set(handles.popupmenu_cell_material,'Enable','off');
    set(handles.edit_thickness_box,'Enable','off');
    set(handles.edit_battery_electronics_height,'Enable','off');
    set(handles.popupmenu_box_material,'Enable','off');
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
      msgbox(str);
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
      msgbox(str);
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


function popupmenu_motor_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_motor_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_motor_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_motor_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_motor_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_motor_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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


function popupmenu_cooler_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_cooler_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_cooler_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_cooler_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_cooler_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_cooler_material (see GCBO)
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
      msgbox(str);
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
      msgbox(str);
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


function popupmenu_transmission_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_transmission_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_transmission_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_transmission_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_transmission_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_transmission_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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


function popupmenu_inverter_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_inverter_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_inverter_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_inverter_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_inverter_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_inverter_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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


function popupmenu_cell_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_cell_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_cell_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_cell_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_cell_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_cell_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
      msgbox(str);
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
      msgbox(str);
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


function popupmenu_box_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_box_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_box_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_box_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_box_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_box_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%% Interior Group


% --- Executes on button press in checkbox_enable_interior.
function checkbox_enable_interior_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_enable_interior (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_enable_interior
if handles.checkbox_enable_interior.Value == 1
    set(handles.edit_seat_length,'Enable','on');
    set(handles.edit_seat_width,'Enable','on');
    set(handles.edit_seat_height,'Enable','on');
    set(handles.edit_seat_thickness,'Enable','on');
    set(handles.popupmenu_seat_material,'Enable','on');
    set(handles.edit_backrest_height,'Enable','on');
    set(handles.edit_leg_clearance,'Enable','on');
    set(handles.edit_seat_gap,'Enable','on');
    set(handles.edit_passenger_shoulder_width,'Enable','on');
    set(handles.edit_passenger_body_depth,'Enable','on');
    
else
    set(handles.edit_seat_length,'Enable','off');
    set(handles.edit_seat_width,'Enable','off');
    set(handles.edit_seat_height,'Enable','off');
    set(handles.edit_seat_thickness,'Enable','off');
    set(handles.popupmenu_seat_material,'Enable','off');
    set(handles.edit_backrest_height,'Enable','off');
    set(handles.edit_leg_clearance,'Enable','off');
    set(handles.edit_seat_gap,'Enable','off');
    set(handles.edit_passenger_shoulder_width,'Enable','off');
    set(handles.edit_passenger_body_depth,'Enable','off');
end

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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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

function popupmenu_seat_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_seat_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_seat_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_seat_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_seat_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_seat_material (see GCBO)
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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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



%% Suspension Group



% --- Executes on button press in checkbox_enable_suspension.
function checkbox_enable_suspension_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_enable_suspension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_enable_suspension
if handles.checkbox_enable_suspension.Value == 1
    set(handles.edit_tire_width,'Enable','on');
    set(handles.edit_tire_diameter,'Enable','on');
    set(handles.edit_rim_diameter,'Enable','on');
    set(handles.edit_rim_thickness,'Enable','on');
    set(handles.popupmenu_tire_material,'Enable','on');
    set(handles.popupmenu_rim_material,'Enable','on');
    set(handles.edit_disc_outer_diameter,'Enable','on');
    set(handles.edit_disc_inner_diameter,'Enable','on');
    set(handles.edit_disc_thickness,'Enable','on');
    set(handles.popupmenu_disc_material,'Enable','on');
    set(handles.popupmenu_brake_pad_material,'Enable','on');
    set(handles.popupmenu_brake_caliper_material,'Enable','on');
    set(handles.edit_carrier_length,'Enable','on');
    set(handles.edit_carrier_width,'Enable','on');
    set(handles.popupmenu_carrier_material,'Enable','on');
    set(handles.edit_aarm_diameter,'Enable','on');
    set(handles.edit_aarm_thickness,'Enable','on');
    set(handles.popupmenu_aarm_material,'Enable','on');
    set(handles.edit_air_spring_height,'Enable','on');
    set(handles.edit_air_spring_diameter,'Enable','on');
    set(handles.popupmenu_air_spring_material,'Enable','on');
    set(handles.edit_air_tank_diameter,'Enable','on');
    set(handles.edit_air_tank_length,'Enable','on');
    set(handles.edit_air_tank_thickness,'Enable','on');
    set(handles.popupmenu_air_tank_material,'Enable','on');
    set(handles.edit_compressor_diameter,'Enable','on');
    set(handles.edit_compressor_length,'Enable','on');
    set(handles.edit_compressor_thickness,'Enable','on');
    set(handles.popupmenu_compressor_material,'Enable','on');
    set(handles.edit_front_angle,'Enable','on');
    set(handles.edit_rear_angle,'Enable','on');
    set(handles.edit_axis_thickness,'Enable','on');
    set(handles.edit_axis_diameter,'Enable','on');
    set(handles.popupmenu_axis_material,'Enable','on');
    set(handles.edit_damper_diameter,'Enable','on');
    set(handles.popupmenu_damper_material,'Enable','on');
else
    set(handles.edit_tire_width,'Enable','off');
    set(handles.edit_tire_diameter,'Enable','off');
    set(handles.edit_rim_diameter,'Enable','off');
    set(handles.edit_rim_thickness,'Enable','off');
    set(handles.popupmenu_tire_material,'Enable','off');
    set(handles.popupmenu_rim_material,'Enable','off');
    set(handles.edit_disc_outer_diameter,'Enable','off');
    set(handles.edit_disc_inner_diameter,'Enable','off');
    set(handles.edit_disc_thickness,'Enable','off');
    set(handles.popupmenu_disc_material,'Enable','off');
    set(handles.popupmenu_brake_pad_material,'Enable','off');
    set(handles.popupmenu_brake_caliper_material,'Enable','off');
    set(handles.edit_carrier_length,'Enable','off');
    set(handles.edit_carrier_width,'Enable','off');
    set(handles.popupmenu_carrier_material,'Enable','off');
    set(handles.edit_aarm_diameter,'Enable','off');
    set(handles.edit_aarm_thickness,'Enable','off');
    set(handles.popupmenu_aarm_material,'Enable','off');
    set(handles.edit_air_spring_height,'Enable','off');
    set(handles.edit_air_spring_diameter,'Enable','off');
    set(handles.popupmenu_air_spring_material,'Enable','off');
    set(handles.edit_air_tank_diameter,'Enable','off');
    set(handles.edit_air_tank_length,'Enable','off');
    set(handles.edit_air_tank_thickness,'Enable','off');
    set(handles.popupmenu_air_tank_material,'Enable','off');
    set(handles.edit_compressor_diameter,'Enable','off');
    set(handles.edit_compressor_length,'Enable','off');
    set(handles.edit_compressor_thickness,'Enable','off');
    set(handles.popupmenu_compressor_material,'Enable','off');
    set(handles.edit_front_angle,'Enable','off');
    set(handles.edit_rear_angle,'Enable','off');
    set(handles.edit_axis_thickness,'Enable','off');
    set(handles.edit_axis_diameter,'Enable','off');
    set(handles.popupmenu_axis_material,'Enable','off');
    set(handles.edit_damper_diameter,'Enable','off');
    set(handles.popupmenu_damper_material,'Enable','off');
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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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


function popupmenu_tire_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_tire_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_tire_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_tire_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_tire_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_tire_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function popupmenu_rim_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_rim_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_rim_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_rim_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_rim_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_rim_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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

function popupmenu_disc_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_disc_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_disc_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_disc_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_disc_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_disc_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function popupmenu_brake_pad_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_brake_pad_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_brake_pad_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_brake_pad_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_brake_pad_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_brake_pad_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
      msgbox(str);
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
      msgbox(str);
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


function popupmenu_carrier_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_carrier_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_carrier_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_carrier_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_carrier_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_carrier_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_aarm_diameter_Callback(hObject, eventdata, ~)
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
      msgbox(str);
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
      msgbox(str);
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


function popupmenu_aarm_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_aarm_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_aarm_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_aarm_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_aarm_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_aarm_material (see GCBO)
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
      msgbox(str);
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
      msgbox(str);
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


function popupmenu_air_spring_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_air_spring_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_air_spring_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_air_spring_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_air_spring_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_air_spring_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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


function popupmenu_air_tank_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_air_tank_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_air_tank_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_air_tank_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_air_tank_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_air_tank_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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


function popupmenu_compressor_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_compressor_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_compressor_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_compressor_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_compressor_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_compressor_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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


function popupmenu_axis_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_axis_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_axis_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_axis_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_axis_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_axis_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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
      msgbox(str);
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


function popupmenu_damper_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_damper_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_damper_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_damper_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_damper_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_damper_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




%% Chassis Group



% --- Executes on button press in checkbox_enable_chassis.
function checkbox_enable_chassis_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_enable_chassis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_enable_chassis
if handles.checkbox_enable_chassis.Value == 1
    set(handles.edit_roof_height,'Enable','on');
    set(handles.edit_body_thickness,'Enable','on');
    set(handles.popupmenu_body_material,'Enable','on');
    set(handles.popupmenu_wheelhouse_material,'Enable','on');
    set(handles.edit_door_height,'Enable','on');
    set(handles.edit_door_width,'Enable','on');
    set(handles.edit_door_thickness,'Enable','on');
    set(handles.popupmenu_door_material,'Enable','on');
    set(handles.edit_window_thickness,'Enable','on');
    set(handles.edit_window_shoulder,'Enable','on');
    set(handles.edit_window_height,'Enable','on');
    set(handles.popupmenu_window_material,'Enable','on');
    set(handles.edit_floor_thickness,'Enable','on');
    set(handles.edit_floor_height,'Enable','on');
    set(handles.popupmenu_floor_material,'Enable','on');
    set(handles.edit_frame_thickness,'Enable','on');
    set(handles.edit_frame_height,'Enable','on');
    set(handles.popupmenu_frame_material,'Enable','on');
    set(handles.edit_ramp_length,'Enable','on');
    set(handles.edit_ramp_width,'Enable','on');
    set(handles.edit_ramp_thickness,'Enable','on');
    set(handles.popupmenu_ramp_material,'Enable','on');
    set(handles.edit_curb_height,'Enable','on');
else
    set(handles.edit_roof_height,'Enable','off');
    set(handles.edit_body_thickness,'Enable','off');
    set(handles.popupmenu_body_material,'Enable','off');
    set(handles.popupmenu_wheelhouse_material,'Enable','off');
    set(handles.edit_door_height,'Enable','off');
    set(handles.edit_door_width,'Enable','off');
    set(handles.edit_door_thickness,'Enable','off');
    set(handles.popupmenu_door_material,'Enable','off');
    set(handles.edit_window_thickness,'Enable','off');
    set(handles.edit_window_shoulder,'Enable','off');
    set(handles.edit_window_height,'Enable','off');
    set(handles.popupmenu_window_material,'Enable','off');
    set(handles.edit_floor_thickness,'Enable','off');
    set(handles.edit_floor_height,'Enable','off');
    set(handles.popupmenu_floor_material,'Enable','off');
    set(handles.edit_frame_thickness,'Enable','off');
    set(handles.edit_frame_height,'Enable','off');
    set(handles.popupmenu_frame_material,'Enable','off');
    set(handles.edit_ramp_length,'Enable','off');
    set(handles.edit_ramp_width,'Enable','off');
    set(handles.edit_ramp_thickness,'Enable','off');
    set(handles.popupmenu_ramp_material,'Enable','off');
    set(handles.edit_curb_height,'Enable','off');
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
      msgbox(str);
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
      msgbox(str);
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


function popupmenu_body_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_body_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_body_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_body_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_body_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_body_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
      msgbox(str);
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
      msgbox(str);
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


function popupmenu_frame_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_frame_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_frame_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_frame_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_frame_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_frame_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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


function popupmenu_window_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_window_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_window_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_window_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_window_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_window_material (see GCBO)
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
      msgbox(str);
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
      msgbox(str);
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

function popupmenu_floor_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_floor_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_floor_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_floor_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_floor_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_floor_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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


function popupmenu_door_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_door_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_door_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_door_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_door_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_door_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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




%% Electronics Group



% --- Executes on button press in checkbox_enable_electronics.
function checkbox_enable_electronics_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_enable_electronics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_enable_electronics
if handles.checkbox_enable_electronics.Value == 1
    set(handles.edit_lidar_height,'Enable','on');
    set(handles.edit_lidar_diameter,'Enable','on');
    set(handles.popupmenu_lidar_material,'Enable','on');
    set(handles.edit_ac_length,'Enable','on');
    set(handles.edit_ac_width,'Enable','on');
    set(handles.edit_ac_height,'Enable','on');
    set(handles.popupmenu_ac_material,'Enable','on');
else
    set(handles.edit_lidar_height,'Enable','off');
    set(handles.edit_lidar_diameter,'Enable','off');
    set(handles.popupmenu_lidar_material,'Enable','off');
    set(handles.edit_ac_length,'Enable','off');
    set(handles.edit_ac_width,'Enable','off');
    set(handles.edit_ac_height,'Enable','off');
    set(handles.popupmenu_ac_material,'Enable','off');
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
      msgbox(str);
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
      msgbox(str);
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


function popupmenu_lidar_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_lidar_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_lidar_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_lidar_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_lidar_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_lidar_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
      msgbox(str);
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
      msgbox(str);
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
      msgbox(str);
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


function popupmenu_ac_material_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_ac_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popupmenu_ac_material as text
%        str2double(get(hObject,'String')) returns contents of popupmenu_ac_material as a double


% --- Executes during object creation, after setting all properties.
function popupmenu_ac_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_ac_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%% --- Executes on button press in pushbutton_default_values.



function pushbutton_default_values_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_default_values (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pushbutton_default_values

%Set default values

%Overall vehicle
set(handles.edit_overall_length,'String',6000);
set(handles.edit_overall_width,'String',2700);
set(handles.edit_overall_height,'String',3100);

set(handles.edit_wheelbase,'String',4200);
set(handles.edit_ground_clearance,'String',150);
set(handles.edit_lifting_height,'String',0);

%Vehicle Configuration
set(handles.checkbox_layout_urban1,'Value',0);
set(handles.checkbox_layout_urban2,'Value',0);
set(handles.checkbox_layout_coach,'Value',1);

set(handles.checkbox_central_motor_rear,'Value',1);
set(handles.checkbox_dual_motor_rear,'Value',0);
set(handles.checkbox_all_wheel_drive,'Value',0);

set(handles.checkbox_ramp_pulled_in,'Value',1);
set(handles.checkbox_ramp_deployed,'Value',0);

%Powertrain
set(handles.edit_motor_length,'String',300);
set(handles.edit_motor_diameter,'String',270);
set(handles.popupmenu_motor_material,'Value',1);

set(handles.edit_cooler_length,'String',1200);
set(handles.edit_cooler_height,'String',250);
set(handles.edit_cooler_thickness,'String',50);
set(handles.popupmenu_cooler_material,'Value',1);

set(handles.edit_transmission_length,'String',235);
set(handles.edit_transmission_width,'String',370);
set(handles.popupmenu_transmission_material,'Value',1);

set(handles.edit_inverter_length,'String',343);
set(handles.edit_inverter_width,'String',150);
set(handles.edit_inverter_height,'String',70);
set(handles.popupmenu_inverter_material,'Value',1);

set(handles.edit_cell_volume,'String',0.354);
set(handles.edit_cell_diameter,'String',18);
set(handles.edit_cell_height,'String',65);
set(handles.popupmenu_cell_material,'Value',2);

set(handles.edit_thickness_box,'String',4);
set(handles.edit_battery_electronics_height,'String',15);
set(handles.popupmenu_box_material,'Value',1);

%Interior
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

%Electronics
set(handles.edit_lidar_height,'String',80);
set(handles.edit_lidar_diameter,'String',150);
set(handles.popupmenu_lidar_material,'Value',3);

set(handles.edit_ac_length,'String',2000);
set(handles.edit_ac_width,'String',1500);
set(handles.edit_ac_height,'String',150);
set(handles.popupmenu_ac_material,'Value',1);

%Suspension
set(handles.edit_tire_width,'String',215);
set(handles.edit_tire_diameter,'String',767);
set(handles.edit_rim_diameter,'String',19);
set(handles.edit_rim_thickness,'String',10);
set(handles.popupmenu_tire_material,'Value',2);
set(handles.popupmenu_rim_material,'Value',1);

set(handles.edit_disc_outer_diameter,'String',430);
set(handles.edit_disc_inner_diameter,'String',160);
set(handles.edit_disc_thickness,'String',34);
set(handles.popupmenu_disc_material,'Value',4);
set(handles.popupmenu_brake_pad_material,'Value',4);
set(handles.popupmenu_brake_caliper_material,'Value',4);

set(handles.edit_carrier_length,'String',140);
set(handles.edit_carrier_width,'String',90);
set(handles.popupmenu_carrier_material,'Value',1);

set(handles.edit_aarm_diameter,'String',15);
set(handles.edit_aarm_thickness,'String',10);
set(handles.popupmenu_aarm_material,'Value',5);

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

set(handles.edit_front_angle,'String',0);
set(handles.edit_rear_angle,'String',0);
set(handles.edit_axis_thickness,'String',8);
set(handles.edit_axis_diameter,'String',50);
set(handles.popupmenu_axis_material,'Value',5);

set(handles.edit_damper_diameter,'String',50);
set(handles.popupmenu_damper_material,'Value',1);

%Chassis
set(handles.edit_roof_height,'String',400);
set(handles.edit_body_thickness,'String',5);
set(handles.popupmenu_body_material,'Value',4);
set(handles.popupmenu_wheelhouse_material,'Value',4);

set(handles.edit_door_height,'String',2200);
set(handles.edit_door_width,'String',1800);
set(handles.edit_door_thickness,'String',6);
set(handles.popupmenu_door_material,'Value',2);

set(handles.edit_window_thickness,'String',6);
set(handles.edit_window_shoulder,'String',940);
set(handles.edit_window_height,'String',1285);
set(handles.popupmenu_window_material,'Value',2);

set(handles.edit_floor_thickness,'String',5);
set(handles.edit_floor_height,'String',350);
set(handles.popupmenu_floor_material,'Value',1);

set(handles.edit_frame_thickness,'String',8);
set(handles.edit_frame_height,'String',100);
set(handles.popupmenu_frame_material,'Value',4);

set(handles.edit_ramp_length,'String',1200);
set(handles.edit_ramp_width,'String',1000);
set(handles.edit_ramp_thickness,'String',50);
set(handles.popupmenu_ramp_material,'Value',1);
set(handles.edit_curb_height,'String',150);



%% --- Executes on button press in pushbutton_save_concept.



function pushbutton_save_concept_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_concept (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Asign variables
%Overall vehicle
l_overall = str2num(char(get(handles.edit_overall_length,'String')));
w_overall = str2num(char(get(handles.edit_overall_width,'String')));
h_overall = str2num(char(get(handles.edit_overall_height,'String')));

wheelbase = str2num(char(get(handles.edit_wheelbase,'String')));
gc = str2num(char(get(handles.edit_ground_clearance,'String')));
h_lift = str2num(char(get(handles.edit_lifting_height,'String')));

%Configurations
lay_urban1 = get(handles.checkbox_layout_urban1,'Value');
lay_urban2 = get(handles.checkbox_layout_urban2,'Value');
lay_coach = get(handles.checkbox_layout_coach,'Value');

central_motor_rear = get(handles.checkbox_central_motor_rear,'Value');
dual_motor_rear = get(handles.checkbox_dual_motor_rear,'Value');
all_wheel_drive = get(handles.checkbox_all_wheel_drive,'Value');

ramp_in = get(handles.checkbox_ramp_pulled_in,'Value');
ramp_out = get(handles.checkbox_ramp_deployed,'Value');


%Interior
l_seat = str2num(char(get(handles.edit_seat_length,'String')));
w_seat = str2num(char(get(handles.edit_seat_width,'String')));
h_seat = str2num(char(get(handles.edit_seat_height,'String')));
t_seat = str2num(char(get(handles.edit_seat_thickness,'String')));
h_backrest = str2num(char(get(handles.edit_backrest_height,'String')));
l_leg_clearance = str2num(char(get(handles.edit_leg_clearance,'String')));
w_seat_gap = str2num(char(get(handles.edit_seat_gap,'String')));
contents = get(handles.popupmenu_seat_material,'String'); 
mat_seat = contents{get(handles.popupmenu_seat_material,'Value')};
p_shoulder_width = str2num(char(get(handles.edit_passenger_shoulder_width,'String')));
p_body_depth = str2num(char(get(handles.edit_passenger_body_depth,'String')));

%Powertrain
l_motor = str2num(char(get(handles.edit_motor_length,'String')));
d_motor = str2num(char(get(handles.edit_motor_diameter,'String')));
contents = get(handles.popupmenu_motor_material,'String');
mat_motor = contents{get(handles.popupmenu_motor_material,'Value')};

l_cooler = str2num(char(get(handles.edit_cooler_length,'String')));
h_cooler = str2num(char(get(handles.edit_cooler_height,'String')));
t_cooler = str2num(char(get(handles.edit_cooler_thickness,'String')));
contents = get(handles.popupmenu_cooler_material,'String');
mat_cooler = contents{get(handles.popupmenu_cooler_material,'Value')};

l_trans = str2num(char(get(handles.edit_transmission_length,'String')));
w_trans = str2num(char(get(handles.edit_transmission_width,'String')));
contents = get(handles.popupmenu_transmission_material,'String');
mat_trans = contents{get(handles.popupmenu_transmission_material,'Value')};

l_inv = str2num(char(get(handles.edit_inverter_length,'String')));
w_inv = str2num(char(get(handles.edit_inverter_width,'String')));
h_inv = str2num(char(get(handles.edit_inverter_height,'String')));
contents = get(handles.popupmenu_inverter_material,'String');
mat_inv = contents{get(handles.popupmenu_inverter_material,'Value')};

V_bat = str2num(char(get(handles.edit_cell_volume,'String')));
d_bat_cell = str2num(char(get(handles.edit_cell_diameter,'String')));
h_bat_cell = str2num(char(get(handles.edit_cell_height,'String')));
contents = get(handles.popupmenu_cell_material,'String');
mat_bat_cell = contents{get(handles.popupmenu_cell_material,'Value')};

t_bat_box = str2num(char(get(handles.edit_thickness_box,'String')));
h_bat_el = str2num(char(get(handles.edit_battery_electronics_height,'String')));
contents = get(handles.popupmenu_box_material,'String');
mat_bat_box = contents{get(handles.popupmenu_box_material,'Value')};

%Electronics
h_lidar = str2num(char(get(handles.edit_lidar_height,'String')));
d_lidar = str2num(char(get(handles.edit_lidar_diameter,'String')));
contents = get(handles.popupmenu_lidar_material,'String');
mat_lidar = contents{get(handles.popupmenu_lidar_material,'Value')};

l_ac = str2num(char(get(handles.edit_ac_length,'String')));
w_ac = str2num(char(get(handles.edit_ac_width,'String')));
h_ac = str2num(char(get(handles.edit_ac_height,'String')));
contents = get(handles.popupmenu_ac_material,'String');
mat_ac = contents{get(handles.popupmenu_ac_material,'Value')};

%Suspension
w_tire = str2num(char(get(handles.edit_tire_width,'String')));
d_tire = str2num(char(get(handles.edit_tire_diameter,'String')));
d_rim = str2num(char(get(handles.edit_rim_diameter,'String')));
t_rim = str2num(char(get(handles.edit_rim_thickness,'String')));
contents = get(handles.popupmenu_tire_material,'String');
mat_tire = contents{get(handles.popupmenu_tire_material,'Value')};
contents = get(handles.popupmenu_rim_material,'String');
mat_rim = contents{get(handles.popupmenu_rim_material,'Value')};

da_bdisc = str2num(char(get(handles.edit_disc_outer_diameter,'String')));
di_bdisc = str2num(char(get(handles.edit_disc_inner_diameter,'String')));
t_bdisc = str2num(char(get(handles.edit_disc_thickness,'String')));
contents = get(handles.popupmenu_disc_material,'String');
mat_bdisc = contents{get(handles.popupmenu_disc_material,'Value')};
contents = get(handles.popupmenu_brake_pad_material,'String');
mat_bpad = contents{get(handles.popupmenu_brake_pad_material,'Value')};
contents = get(handles.popupmenu_brake_caliper_material,'String');
mat_bcaliper = contents{get(handles.popupmenu_brake_caliper_material,'Value')};

l_wcarrier = str2num(char(get(handles.edit_carrier_length,'String')));
w_wcarrier = str2num(char(get(handles.edit_carrier_width,'String')));
contents = get(handles.popupmenu_carrier_material,'String');
mat_wcarrier = contents{get(handles.popupmenu_carrier_material,'Value')};

d_aarm = str2num(char(get(handles.edit_aarm_diameter,'String')));
t_aarm = str2num(char(get(handles.edit_aarm_thickness,'String')));
contents = get(handles.popupmenu_aarm_material,'String');
mat_aarm = contents{get(handles.popupmenu_aarm_material,'Value')};

h_spring = str2num(char(get(handles.edit_air_spring_height,'String')));
d_spring = str2num(char(get(handles.edit_air_spring_diameter,'String')));
contents = get(handles.popupmenu_air_spring_material,'String');
mat_spring = contents{get(handles.popupmenu_air_spring_material,'Value')};

d_air_tank = str2num(char(get(handles.edit_air_tank_diameter,'String')));
l_air_tank = str2num(char(get(handles.edit_air_tank_length,'String')));
t_air_tank = str2num(char(get(handles.edit_air_tank_thickness,'String')));
contents = get(handles.popupmenu_air_tank_material,'String');
mat_air_tank = contents{get(handles.popupmenu_air_tank_material,'Value')};

d_compressor = str2num(char(get(handles.edit_compressor_diameter,'String')));
l_compressor = str2num(char(get(handles.edit_compressor_length,'String')));
t_compressor = str2num(char(get(handles.edit_compressor_thickness,'String')));
contents = get(handles.popupmenu_compressor_material,'String');
mat_compressor = contents{get(handles.popupmenu_compressor_material,'Value')};

a_front = str2num(char(get(handles.edit_front_angle,'String')));
a_rear = str2num(char(get(handles.edit_rear_angle,'String')));
t_axis = str2num(char(get(handles.edit_axis_thickness,'String')));
d_axis = str2num(char(get(handles.edit_axis_diameter,'String')));
contents = get(handles.popupmenu_axis_material,'String');
mat_axis = contents{get(handles.popupmenu_axis_material,'Value')};

d_damper = str2num(char(get(handles.edit_damper_diameter,'String')));
contents = get(handles.popupmenu_damper_material,'String');
mat_damper = contents{get(handles.popupmenu_damper_material,'Value')};

%Chassis
h_r = str2num(char(get(handles.edit_roof_height,'String')));
t_body = str2num(char(get(handles.edit_body_thickness,'String')));
contents = get(handles.popupmenu_body_material,'String');
mat_body = contents{get(handles.popupmenu_body_material,'Value')};
contents = get(handles.popupmenu_wheelhouse_material,'String');
mat_wh = contents{get(handles.popupmenu_wheelhouse_material,'Value')};

h_door = str2num(char(get(handles.edit_door_height,'String')));
w_door = str2num(char(get(handles.edit_door_width,'String')));
t_door = str2num(char(get(handles.edit_door_thickness,'String')));
contents = get(handles.popupmenu_door_material,'String');
mat_door = contents{get(handles.popupmenu_door_material,'Value')};

t_window = str2num(char(get(handles.edit_window_thickness,'String')));
h_window_shoulder = str2num(char(get(handles.edit_window_shoulder,'String')));
h_window = str2num(char(get(handles.edit_window_height,'String')));
contents = get(handles.popupmenu_window_material,'String');
mat_window = contents{get(handles.popupmenu_window_material,'Value')};

t_floor = str2num(char(get(handles.edit_floor_thickness,'String')));
h_floor = str2num(char(get(handles.edit_floor_height,'String')));
contents = get(handles.popupmenu_floor_material,'String');
mat_floor = contents{get(handles.popupmenu_floor_material,'Value')};

t_frame = str2num(char(get(handles.edit_frame_thickness,'String')));
h_frame = str2num(char(get(handles.edit_frame_height,'String')));
contents = get(handles.popupmenu_frame_material,'String');
mat_frame = contents{get(handles.popupmenu_frame_material,'Value')};

l_ramp = str2num(char(get(handles.edit_ramp_length,'String')));
w_ramp = str2num(char(get(handles.edit_ramp_width,'String')));
t_ramp = str2num(char(get(handles.edit_ramp_thickness,'String')));
h_curb = str2num(char(get(handles.edit_curb_height,'String')));
contents = get(handles.popupmenu_frame_material,'String');
mat_ramp = contents{get(handles.popupmenu_ramp_material,'Value')};



%% Check if input is correct
if (isempty(l_overall) || isempty(w_overall) || isempty(h_overall) || isempty(wheelbase) || isempty(gc) || isempty(h_lift) || isempty(l_seat) || isempty(w_seat) || isempty(h_seat) || isempty(t_seat) || isempty(h_backrest) || isempty(w_seat_gap) || isempty(mat_seat) || isempty(p_shoulder_width) || isempty(p_body_depth) || isempty(l_motor) || isempty(d_motor) || isempty(mat_motor) || isempty(l_cooler) || isempty(h_cooler) || isempty(t_cooler) || isempty(mat_cooler) || isempty(l_trans) || isempty(w_trans) || isempty(mat_trans) || isempty(l_inv) || isempty(w_inv) || isempty(h_inv) || isempty(mat_inv) || isempty(V_bat) || isempty(d_bat_cell) || isempty(h_bat_cell) || isempty(mat_bat_cell) || isempty(t_bat_box) || isempty(h_bat_el) || isempty(mat_bat_box) || isempty(h_lidar) || isempty(d_lidar) || isempty(mat_lidar) || isempty(l_ac) || isempty(w_ac) || isempty(h_ac) || isempty(mat_ac) || isempty(w_tire) || isempty(d_tire) || isempty(d_rim) || isempty(t_rim) || isempty(mat_tire) || isempty(mat_rim) || isempty(da_bdisc) || isempty(di_bdisc) || isempty(t_bdisc) || isempty(mat_bdisc) || isempty(mat_bpad) || isempty(l_wcarrier) || isempty(w_wcarrier) || isempty(d_aarm) || isempty(t_aarm) || isempty(mat_aarm) || isempty(h_spring) || isempty(d_spring) || isempty(mat_spring) || isempty(d_air_tank) || isempty(l_air_tank) || isempty(t_air_tank) || isempty(mat_air_tank) || isempty(d_compressor) || isempty(l_compressor) || isempty(t_compressor) || isempty(mat_compressor) || isempty(a_front) || isempty(a_rear) || isempty(t_axis) || isempty(d_axis) || isempty(mat_axis) || isempty(d_damper) || isempty(mat_damper) || isempty(h_r) || isempty(t_body) || isempty(mat_body) || isempty(mat_wh) || isempty(h_door) || isempty(w_door) || isempty(t_door) || isempty(mat_door) || isempty(t_window) || isempty(h_window_shoulder) || isempty(h_window) || isempty(mat_window) || isempty(t_floor) || isempty(h_floor) || isempty(mat_floor) || isempty(t_frame) || isempty(h_frame) || isempty(mat_frame) || isempty(h_curb) || isempty(l_ramp) || isempty(w_ramp) || isempty(t_ramp) || isempty(mat_ramp)) || (lay_urban1==0 && lay_urban2==0 && lay_coach==0) || (central_motor_rear==0 && dual_motor_rear==0 && all_wheel_drive==0) || (ramp_in==0 && ramp_out==0)
h = msgbox('Please enter all required fields');
else
        %Close GUI
        close(GUI_Component_Selection_Manual);
    
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
UpdateParameters_Manual(l_overall, w_overall, h_overall, gc, h_ac, h_r, h_door, d_tire, wb, w_door, w_tire, t_tire, a_front, a_rear, t_rim, d_axis, t_axis, da_bdisc, di_bdisc, t_bdisc, t_body, h_lift, V_bat, h_bat_cell, t_bat_box, h_bat_el, t_floor, l_ac, w_ac, d_bat_cell, h_lidar, d_lidar, t_door, t_window, l_motor, d_motor, l_trans, w_trans, l_inv, w_inv, h_inv, t_frame, h_frame, d_spring, h_spring, w_wcarrier, t_aarm, d_aarm, d_damper, l_wcarrier, l_air_tank, d_air_tank, t_air_tank, d_compressor, t_compressor, l_compressor, h_seat, w_seat, l_seat, t_seat, h_backrest, l_leg_clearance, w_seat_gap, l_cooler, h_cooler, t_cooler, h_floor, h_window_shoulder, h_curb, l_ramp, w_ramp, t_ramp, h_window, mat_wh, mat_body, mat_door, mat_window, mat_floor, mat_frame, mat_ramp, mat_ac, mat_lidar, mat_seat, mat_bat_box, mat_bat_cell, mat_motor, mat_trans, mat_inv, mat_cooler, mat_tire, mat_rim, mat_bdisc, mat_bpad, mat_bcaliper, mat_axis, mat_wcarrier, mat_aarm, mat_spring, mat_damper, mat_air_tank, mat_compressor, drivetrain_center_rear, drivetrain_dual_all, cooler_all, motor_all, trans_all, inv_all, ramp_in, ramp_out, street);

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
