function varargout = lineom(varargin)
% LINEOM MATLAB code for lineom.fig
%      LINEOM, by itself, creates a new LINEOM or raises the existing
%      singleton*.
%
%      H = LINEOM returns the handle to a new LINEOM or the handle to
%      the existing singleton*.
%
%      LINEOM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LINEOM.M with the given input arguments.
%
%      LINEOM('Property','Value',...) creates a new LINEOM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lineom_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lineom_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lineom

% Last Modified by GUIDE v2.5 17-Dec-2018 13:21:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lineom_OpeningFcn, ...
                   'gui_OutputFcn',  @lineom_OutputFcn, ...
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

% --- Executes just before lineom is made visible.
function lineom_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lineom (see VARARGIN)

% Choose default command line output for lineom
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = lineom_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sim('euler2GG.slx')
setappdata(0,'phi_out',phi_out);
setappdata(0,'theta_out',theta_out);
setappdata(0,'psi_out',psi_out);

function tof_Callback(hObject, eventdata, handles)
% hObject    handle to tof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tof = str2double(get(hObject,'String'));
w = 2 * pi / (tof * 60);
assignin('base','w',w)

% --- Executes during object creation, after setting all properties.
function tof_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function phi_Callback(hObject, eventdata, handles)
% hObject    handle to phi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
phi = str2num(get(hObject,'String'));
assignin('base','phi',phi)

% --- Executes during object creation, after setting all properties.
function phi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to phi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function theta_Callback(hObject, eventdata, handles)
% hObject    handle to theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta = str2num(get(hObject,'String'));
assignin('base','theta',theta)

% --- Executes during object creation, after setting all properties.
function theta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function psi_Callback(hObject, eventdata, handles)
% hObject    handle to psi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
psi = str2num(get(hObject,'String'));
assignin('base','psi',psi)

% --- Executes during object creation, after setting all properties.
function psi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to psi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Tz_Callback(hObject, eventdata, handles)
% hObject    handle to Tz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Tz = str2double(get(hObject,'String'));
assignin('base','Tz',Tz)

% --- Executes during object creation, after setting all properties.
function Tz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Ty_Callback(hObject, eventdata, handles)
% hObject    handle to Ty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Ty = str2double(get(hObject,'String'));
assignin('base','Ty',Ty)

% --- Executes during object creation, after setting all properties.
function Ty_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Tx_Callback(hObject, eventdata, handles)
% hObject    handle to Tx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Tx = str2double(get(hObject,'String'));
assignin('base','Tx',Tx)

% --- Executes during object creation, after setting all properties.
function Tx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Iz_Callback(hObject, eventdata, handles)
% hObject    handle to Iz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Iz = str2double(get(hObject,'String'));
assignin('base','Iz',Iz)

% --- Executes during object creation, after setting all properties.
function Iz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Iz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Iy_Callback(hObject, eventdata, handles)
% hObject    handle to Iy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Iy = str2double(get(hObject,'String'));
assignin('base','Iy',Iy)

% --- Executes during object creation, after setting all properties.
function Iy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Iy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Ix_Callback(hObject, eventdata, handles)
% hObject    handle to Ix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Ix = str2double(get(hObject,'String'));
assignin('base','Ix',Ix)

% --- Executes during object creation, after setting all properties.
function Ix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in phi_graph.
function phi_graph_Callback(hObject, eventdata, handles)
% hObject    handle to phi_graph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
phi_out = getappdata(0,'phi_out');
figure
plot(phi_out); hold on; title('Phi VS Time'); xlabel('Time(sec)'); ylabel('phi(rad)');

% --- Executes on button press in theta_graph.
function theta_graph_Callback(hObject, eventdata, handles)
% hObject    handle to theta_graph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta_out = getappdata(0,'theta_out');
figure
plot(theta_out); hold on; title('Theta VS Time'); xlabel('Time(sec)'); ylabel('theta(rad)');

% --- Executes on button press in psi_graph.
function psi_graph_Callback(hObject, eventdata, handles)
% hObject    handle to psi_graph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
psi_out = getappdata(0,'psi_out');
figure
plot(psi_out); hold on; title('Psi VS Time'); xlabel('Time(sec)'); ylabel('psi(rad)');
