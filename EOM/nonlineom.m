function varargout = nonlineom(varargin)
% NONLINEOM MATLAB code for nonlineom.fig
%      NONLINEOM, by itself, creates a new NONLINEOM or raises the existing
%      singleton*.
%
%      H = NONLINEOM returns the handle to a new NONLINEOM or the handle to
%      the existing singleton*.
%
%      NONLINEOM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NONLINEOM.M with the given input arguments.
%
%      NONLINEOM('Property','Value',...) creates a new NONLINEOM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nonlineom_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nonlineom_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nonlineom

% Last Modified by GUIDE v2.5 17-Dec-2018 16:40:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nonlineom_OpeningFcn, ...
                   'gui_OutputFcn',  @nonlineom_OutputFcn, ...
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

% --- Executes just before nonlineom is made visible.
function nonlineom_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nonlineom (see VARARGIN)

% Choose default command line output for nonlineom
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = nonlineom_OutputFcn(hObject, eventdata, handles) 
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
sim('euler.slx')
setappdata(0,'phi_out',phi_out); setappdata(0,'theta_out',theta_out); setappdata(0,'psi_out',psi_out);
setappdata(0,'w1_out',w1_out); setappdata(0,'w2_out',w2_out); setappdata(0,'w3_out',w3_out);

function hwz_Callback(hObject, eventdata, handles)
% hObject    handle to hwz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hwz = str2double(get(hObject,'String'));
assignin('base','hwz',hwz)

% --- Executes during object creation, after setting all properties.
function hwz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hwz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function hwy_Callback(hObject, eventdata, handles)
% hObject    handle to hwy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hwy = str2double(get(hObject,'String'));
assignin('base','hwy',hwy)

% --- Executes during object creation, after setting all properties.
function hwy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hwy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function hwx_Callback(hObject, eventdata, handles)
% hObject    handle to hwx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hwx = str2double(get(hObject,'String'));
assignin('base','hwx',hwx)

% --- Executes during object creation, after setting all properties.
function hwx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hwx (see GCBO)
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

function w1_Callback(hObject, eventdata, handles)
% hObject    handle to w1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
w1 = str2double(get(hObject,'String'));
assignin('base','w1',w1)

% --- Executes during object creation, after setting all properties.
function w1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to w1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function w2_Callback(hObject, eventdata, handles)
% hObject    handle to w2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
w2 = str2double(get(hObject,'String'));
assignin('base','w2',w2)

% --- Executes during object creation, after setting all properties.
function w2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to w2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function w3_Callback(hObject, eventdata, handles)
% hObject    handle to w3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
w3 = str2double(get(hObject,'String'));
assignin('base','w3',w3)

% --- Executes during object creation, after setting all properties.
function w3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to w3 (see GCBO)
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

% --- Executes on button press in w1_graph.
function w1_graph_Callback(hObject, eventdata, handles)
% hObject    handle to w1_graph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
w1_out = getappdata(0,'w1_out');
figure
plot(w1_out); hold on; title('w1 VS Time'); xlabel('Time(sec)'); ylabel('w1');

% --- Executes on button press in w2_graph.
function w2_graph_Callback(hObject, eventdata, handles)
% hObject    handle to w2_graph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
w2_out = getappdata(0,'w2_out');
figure
plot(w2_out); hold on; title('w2 VS Time'); xlabel('Time(sec)'); ylabel('w2');

% --- Executes on button press in w3_graph.
function w3_graph_Callback(hObject, eventdata, handles)
% hObject    handle to w3_graph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
w3_out = getappdata(0,'w3_out');
figure
plot(w3_out); hold on; title('w3 VS Time'); xlabel('Time(sec)'); ylabel('w3');

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
