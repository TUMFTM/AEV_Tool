function varargout = GUI_Component_Selection_Database(varargin)
% GUI_COMPONENT_SELECTION_DATABASE MATLAB code for GUI_Component_Selection_Database.fig
%      GUI_COMPONENT_SELECTION_DATABASE, by itself, creates a new GUI_COMPONENT_SELECTION_DATABASE or raises the existing
%      singleton*.
%
%      H = GUI_COMPONENT_SELECTION_DATABASE returns the handle to a new GUI_COMPONENT_SELECTION_DATABASE or the handle to
%      the existing singleton*.
%
%      GUI_COMPONENT_SELECTION_DATABASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_COMPONENT_SELECTION_DATABASE.M with the given input arguments.
%
%      GUI_COMPONENT_SELECTION_DATABASE('Property','Value',...) creates a new GUI_COMPONENT_SELECTION_DATABASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Component_Selection_Database_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Component_Selection_Database_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Component_Selection_Database

% Last Modified by GUIDE v2.5 23-Jan-2018 14:56:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @GUI_Component_Selection_Database_OpeningFcn, ...
    'gui_OutputFcn',  @GUI_Component_Selection_Database_OutputFcn, ...
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


% --- Executes just before GUI_Component_Selection_Database is made visible.
function GUI_Component_Selection_Database_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Component_Selection_Database (see VARARGIN)

% Choose default command line output for GUI_Component_Selection_Database
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Component_Selection_Database wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% Grey out buttons
set(handles.edit_overall_length,'Enable','off');
set(handles.edit_overall_width,'Enable','off');
set(handles.edit_overall_height,'Enable','off');
set(handles.edit_wheelbase,'Enable','off');
set(handles.edit_vehicle_mass,'Enable','off');
set(handles.edit_number_people,'Enable','off');
set(handles.pushbutton_save_VS,'Enable','off');
set(handles.checkbox_VS_mbs,'Enable','off');
set(handles.pushbutton_save_BV,'Enable','off');
set(handles.checkbox_BV_mbs,'Enable','off');
set(handles.pushbutton_urbino,'Enable','off');
set(handles.pushbutton_olli,'Enable','off');
set(handles.pushbutton_default_values,'Enable','off');
set(handles.pushbutton_clear_values,'Enable','off');
set(handles.checkbox_urbino,'Enable','off');
set(handles.checkbox_olli,'Enable','off');
set(handles.checkbox_VS_mbs,'Value',0);




% Pictures for Benchmark Vehicles Buttons
[x,map]=imread('urbino_test.jpg');
I2=imresize(x, [42 113]);
f=figure;
imagesc(x);set(gcf,'Visible', 'off');
set(gca,'units','normalized','position',[0 0 1 1]);
set(gcf,'units','pixels','position',[600 600 300 186]);
I2=getframe(gca);
I2=I2.cdata;
close(f)
set(handles.pushbutton_urbino,'cdata',I2);

[x,map]=imread('Olli_button.png');
I3=imresize(x, [42 113]);
f=figure;
imagesc(x);set(gcf,'Visible', 'off');
set(gca,'units','normalized','position',[0 0 1 1]);
set(gcf,'units','pixels','position',[600 600 300 186]);
I3=getframe(gca);
I3=I3.cdata;
close(f)
set(handles.pushbutton_olli,'cdata',I3);

% --- Outputs from this function are returned to the command line.
function varargout = GUI_Component_Selection_Database_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in checkbox_BV.
function checkbox_BV_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_BV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_BV
set(handles.checkbox_VS,'Value',0);
set(handles.checkbox_VS_mbs,'Value',0);
set(handles.edit_overall_length,'Enable','off');
set(handles.edit_overall_width,'Enable','off');
set(handles.edit_overall_height,'Enable','off');
set(handles.edit_wheelbase,'Enable','off');
set(handles.edit_vehicle_mass,'Enable','off');
set(handles.edit_number_people,'Enable','off');
set(handles.pushbutton_save_VS,'Enable','off');
set(handles.checkbox_VS_mbs,'Enable','off');
set(handles.pushbutton_default_values,'Enable','off');
set(handles.pushbutton_clear_values,'Enable','off');
set(handles.checkbox_urbino,'Enable','on');
set(handles.checkbox_olli,'Enable','on');
set(handles.pushbutton_save_BV,'Enable','on');
set(handles.checkbox_BV_mbs,'Enable','on');



% --- Executes on button press in checkbox_VS.
function checkbox_VS_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_VS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_VS
set(handles.checkbox_BV,'Value',0);
set(handles.checkbox_BV_mbs,'Value',0);
set(handles.edit_overall_length,'Enable','on');
set(handles.edit_overall_width,'Enable','on');
set(handles.edit_overall_height,'Enable','on');
set(handles.edit_wheelbase,'Enable','on');
set(handles.edit_vehicle_mass,'Enable','on');
set(handles.edit_number_people,'Enable','on');
set(handles.pushbutton_save_VS,'Enable','on');
set(handles.checkbox_VS_mbs,'Enable','on');
set(handles.pushbutton_default_values,'Enable','on');
set(handles.pushbutton_clear_values,'Enable','on');
set(handles.pushbutton_urbino,'Enable','off');
set(handles.pushbutton_olli,'Enable','off');
set(handles.checkbox_urbino,'Enable','off');
set(handles.checkbox_olli,'Enable','off');
set(handles.pushbutton_save_BV,'Enable','off');
set(handles.checkbox_BV_mbs,'Enable','off');
set(handles.checkbox_urbino,'Value',0);
set(handles.checkbox_olli,'Value',0);


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
lower_limit = 4000;
upper_limit = 14000;
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
lower_limit = 2000;
upper_limit = 2700;
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
lower_limit = 2500;
upper_limit = 3200;
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

lower_limit = 0.58*data; % min 58% of overall length
upper_limit = 0.85*data; % max 85% of overall length
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



function edit_vehicle_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vehicle_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vehicle_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_vehicle_mass as a double
x = get(hObject,'String');  % get text from handles structure
try
      y = x{1};               % cell to string
      z = str2num(strtok(y));         % string to number
catch
      z = str2num(strtok(x));          % string to number
end

h = findobj('Tag','edit_overall_length');
data = str2double(h.String);

lower_limit = round(0.9*(1.0557*data + 149.25)); %linear mass assumption from Weight_over_Length.xlsx
upper_limit = round(1.3*(1.0557*data + 149.25)); %linear mass assumption from Weight_over_Length.xlsx

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
function edit_vehicle_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vehicle_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_number_people_Callback(hObject, eventdata, handles)
% hObject    handle to edit_number_people (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_number_people as text
%        str2double(get(hObject,'String')) returns contents of edit_number_people as a double


% --- Executes during object creation, after setting all properties.
function edit_number_people_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_number_people (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in pushbutton_save_VS.
function pushbutton_save_VS_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_VS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
l_overall = str2num(char(get(handles.edit_overall_length,'String')));
w_overall = str2num(char(get(handles.edit_overall_width,'String')));
h_overall = str2num(char(get(handles.edit_overall_height,'String')));
wb = str2num(char(get(handles.edit_wheelbase,'String')));
vehicle_mass = str2num(char(get(handles.edit_vehicle_mass,'String')));
number_person = str2num(char(get(handles.edit_number_people,'String')));
mbs_exe = get(handles.checkbox_VS_mbs,'Value'); % check if MBS is required

% Check if input is valid
if isempty(l_overall) || isempty(w_overall) || isempty(h_overall) || isempty(wb) || isempty(vehicle_mass) || isempty(number_person)
    h = msgbox('Please enter all required fields');
else
    close(GUI_Component_Selection_Database);
    [AirSuspension_selection,Tyre_selection,Brake_selection,l_overall,w_overall,h_overall,wb,vehicle_mass,number_person] = Chassis(l_overall,w_overall,h_overall,wb,vehicle_mass,number_person)
    
    % Link Design
    if mbs_exe == 1 % check if MBS is required
        h = waitbar(0,'Please wait...');
        close_system('VehicleDynamics3D');
        load_system('VehicleDynamics3D');
        % Display that Simulink model is running
        waitbar(10 / 30);
        Subframe; % Call script for link design
        waitbar(30 / 30);
        close_system('VehicleDynamics3D');
        close(h);
        
    end
    
    % Write parameter values in txt file
    UpdateParameters_DB(AirSuspension_selection,Tyre_selection,Brake_selection,l_overall,w_overall,h_overall,wb,mbs_exe);
    
    
end

% Enable Concept_Visualization AFTER saving
butt_concept = findobj('Tag','pushbutton_concept');
butt_cad_model = findobj('Tag','pushbutton_cad_model');
tex_concept_visualization = findobj ('Tag','text_concept_visualization');

butt_concept.Enable = 'on';
butt_cad_model.Enable = 'on';
tex_concept_visualization.Enable = 'on';






%%Picture only%%
% --- Executes on button press in pushbutton_urbino.
function pushbutton_urbino_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_urbino (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%Picture only%%
% --- Executes on button press in pushbutton_olli.
function pushbutton_olli_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_olli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_default_values.
function pushbutton_default_values_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_default_values (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_overall_length,'String',6000);
set(handles.edit_overall_width,'String', 2700);
set(handles.edit_overall_height,'String',3100);
set(handles.edit_wheelbase,'String',4200);
set(handles.edit_vehicle_mass,'String',7000);
set(handles.edit_number_people,'String',25);


% --- Executes on button press in pushbutton_clear_values.
function pushbutton_clear_values_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_clear_values (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_overall_length,'String','');
set(handles.edit_overall_width,'String','');
set(handles.edit_overall_height,'String','');
set(handles.edit_wheelbase,'String','');
set(handles.edit_vehicle_mass,'String','');
set(handles.edit_number_people,'String','');


% --- Executes on button press in checkbox_urbino.
function checkbox_urbino_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_urbino (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_urbino
set(handles.checkbox_olli,'Value',0);
set(handles.pushbutton_urbino,'Enable','on');
set(handles.pushbutton_olli,'Enable','off');

% --- Executes on button press in checkbox_olli.
function checkbox_olli_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_olli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_olli
set(handles.checkbox_urbino,'Value',0);
set(handles.pushbutton_olli,'Enable','on');
set(handles.pushbutton_urbino,'Enable','off');


% --- Executes on button press in pushbutton_save_BV.
function pushbutton_save_BV_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_BV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
u = get(handles.checkbox_olli,'Value');
w = get(handles.checkbox_urbino,'Value');
mbs_exe = get(handles.checkbox_BV_mbs,'Value');
g = get(handles.checkbox_olli,'Value');
h = get(handles.checkbox_urbino,'Value');

if u == 0 && w == 0
    h = msgbox('Please enter all required fields');
else
    
    close(GUI_Component_Selection_Database);
    if g == 1 % Olli
        
        l_overall = 3920;
        w_overall = 2050;
        h_overall = 2500;
        wb = 2526;
        vehicle_mass = 1500;
        number_person = 12;
     
        
    else % Urbino 8.9 LE electric
        
        l_overall = 8950;
        w_overall = 2400;
        h_overall = 3400;
        wb = 4380;
        vehicle_mass = 9800;
        number_person = 24;
        
    end
    
    % Call Suspension Calculation
    [AirSuspension_selection,Tyre_selection,Brake_selection,l_overall,w_overall,h_overall,wb,vehicle_mass,number_person] = Chassis(l_overall,w_overall,h_overall,wb,vehicle_mass,number_person)
    
    if mbs_exe == 1
        
        h = waitbar(0,'Please wait...');
        close_system('VehicleDynamics3D');
        load_system('VehicleDynamics3D');
        % Display that Simulink model is running
        waitbar(10 / 30);
        Subframe; % Call script for link design
        waitbar(30 / 30);
        close_system('VehicleDynamics3D');
        close(h);
    end
    
    % Update Parameters
    UpdateParameters_DB(AirSuspension_selection,Tyre_selection,Brake_selection,l_overall,w_overall,h_overall,wb,mbs_exe);
    
end
% Enable Concept_Visualization AFTER saving
butt_concept = findobj('Tag','pushbutton_concept');
butt_cad_model = findobj('Tag','pushbutton_cad_model');
tex_concept_visualization = findobj ('Tag','text_concept_visualization');

butt_concept.Enable = 'on';
butt_cad_model.Enable = 'on';
tex_concept_visualization.Enable = 'on';


% --- Executes on button press in checkbox_BV_mbs.
function checkbox_BV_mbs_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_BV_mbs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_BV_mbs
if get(handles.checkbox_BV_mbs,'Value') == 1
    h = msgbox('Multibody simulation might take several minutes');
end


% --- Executes on button press in checkbox_VS_mbs.
function checkbox_VS_mbs_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_VS_mbs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_VS_mbs
if get(handles.checkbox_VS_mbs,'Value') == 1
    h = msgbox('Multibody simulation might take several minutes');
end
