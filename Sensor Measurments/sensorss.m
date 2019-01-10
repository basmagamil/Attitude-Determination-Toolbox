function varargout = sensorss(varargin)
% SENSORSS MATLAB code for sensorss.fig
%      SENSORSS, by itself, creates a new SENSORSS or raises the existing
%      singleton*.
%
%      H = SENSORSS returns the handle to a new SENSORSS or the handle to
%      the existing singleton*.
%
%      SENSORSS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SENSORSS.M with the given input arguments.
%
%      SENSORSS('Property','Value',...) creates a new SENSORSS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sensorss_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sensorss_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sensorss

% Last Modified by GUIDE v2.5 15-Dec-2018 19:52:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sensorss_OpeningFcn, ...
                   'gui_OutputFcn',  @sensorss_OutputFcn, ...
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

% --- Executes just before sensorss is made visible.
function sensorss_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sensorss (see VARARGIN)

% Choose default command line output for sensorss
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = sensorss_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in calculate.
function calculate_Callback(hObject, eventdata, handles)
% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
alpha1 = getappdata(0,'alpha1'); alpha2 = getappdata(0,'alpha2');
qs = getappdata(0,'qs'); qx = getappdata(0,'qx'); qy = getappdata(0,'qy'); qz = getappdata(0,'qz');
q = [qx; qy; qz];
[Rbs,sbody] = sun_sensor(alpha1,alpha2,qs,q);
set(handles.Rbs11,'string',sprintf('%.4f',Rbs(1,1))); set(handles.Rbs12,'string',sprintf('%.4f',Rbs(1,2))); set(handles.Rbs13,'string',sprintf('%.4f',Rbs(1,3)));
set(handles.Rbs21,'string',sprintf('%.4f',Rbs(2,1))); set(handles.Rbs22,'string',sprintf('%.4f',Rbs(2,2))); set(handles.Rbs23,'string',sprintf('%.4f',Rbs(2,3)));
set(handles.Rbs31,'string',sprintf('%.4f',Rbs(3,1))); set(handles.Rbs32,'string',sprintf('%.4f',Rbs(3,2))); set(handles.Rbs33,'string',sprintf('%.4f',Rbs(3,3)));
set(handles.sbody1,'string',sprintf('%.4f',sbody(1))); set(handles.sbody2,'string',sprintf('%.4f',sbody(2))); set(handles.sbody3,'string',sprintf('%.4f',sbody(3)));

function alpha1_Callback(hObject, eventdata, handles)
% hObject    handle to alpha1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
alpha1 = str2double(get(hObject,'String'));
setappdata(0,'alpha1',alpha1);

% --- Executes during object creation, after setting all properties.
function alpha1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function alpha2_Callback(hObject, eventdata, handles)
% hObject    handle to alpha2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
alpha2 = str2double(get(hObject,'String'));
setappdata(0,'alpha2',alpha2);

% --- Executes during object creation, after setting all properties.
function alpha2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function qs_Callback(hObject, eventdata, handles)
% hObject    handle to qs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
qs = str2double(get(hObject,'String'));
setappdata(0,'qs',qs);

% --- Executes during object creation, after setting all properties.
function qs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function qx_Callback(hObject, eventdata, handles)
% hObject    handle to qx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
qx = str2double(get(hObject,'String'));
setappdata(0,'qx',qx);

% --- Executes during object creation, after setting all properties.
function qx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function qy_Callback(hObject, eventdata, handles)
% hObject    handle to qy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
qy = str2double(get(hObject,'String'));
setappdata(0,'qy',qy);

% --- Executes during object creation, after setting all properties.
function qy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function qz_Callback(hObject, eventdata, handles)
% hObject    handle to qz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
qz = str2double(get(hObject,'String'));
setappdata(0,'qz',qz);

% --- Executes during object creation, after setting all properties.
function qz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
