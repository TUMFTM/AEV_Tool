function varargout = MachineLearning(varargin)
% MACHINELEARNING MATLAB code for MachineLearning.fig
%      MACHINELEARNING, by itself, creates a new MACHINELEARNING or raises the existing
%      singleton*.
%
%      H = MACHINELEARNING returns the handle to a new MACHINELEARNING or the handle to
%      the existing singleton*.
%
%      MACHINELEARNING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MACHINELEARNING.M with the given input arguments.
%
%      MACHINELEARNING('Property','Value',...) creates a new MACHINELEARNING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MachineLearning_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MachineLearning_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MachineLearning

% Last Modified by GUIDE v2.5 07-Oct-2018 14:15:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MachineLearning_OpeningFcn, ...
                   'gui_OutputFcn',  @MachineLearning_OutputFcn, ...
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


% --- Executes just before MachineLearning is made visible.
function MachineLearning_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MachineLearning (see VARARGIN)

% Choose default command line output for MachineLearning
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MachineLearning wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MachineLearning_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_1.
function pb_1_Callback(hObject, eventdata, handles)
% hObject    handle to pb_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
T = evalin('base','T')
T.Choise(1) = T.Choise(1)+1
T(1,2) = {T.Choise(1)}
set(handles.textfeld,'String',num2str(T.Choise(1)))
assignin('base','T',T)

% --- Executes on button press in pb_2.
function pb_2_Callback(hObject, eventdata, handles)
% hObject    handle to pb_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

T = evalin('base','T')
T.Choise(2) = T.Choise(2)+1
T(2,2) = {T.Choise(2)}
set(handles.textfeld,'String',num2str(T.Choise(2)))
assignin('base','T',T)

% --- Executes on button press in pb_3.
function pb_3_Callback(hObject, eventdata, handles)
% hObject    handle to pb_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

T = evalin('base','T')
T.Choise(3) = T.Choise(3)+1
T(3,2) = {T.Choise(3)}
set(handles.textfeld,'String',num2str(T.Choise(3)))
assignin('base','T',T)