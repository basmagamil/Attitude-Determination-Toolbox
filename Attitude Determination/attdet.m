function varargout = attdet(varargin)
% ATTDET MATLAB code for attdet.fig
%      ATTDET, by itself, creates a new ATTDET or raises the existing
%      singleton*.
%
%      H = ATTDET returns the handle to a new ATTDET or the handle to
%      the existing singleton*.
%
%      ATTDET('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ATTDET.M with the given input arguments.
%
%      ATTDET('Property','Value',...) creates a new ATTDET or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before attdet_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to attdet_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help attdet

% Last Modified by GUIDE v2.5 12-Dec-2018 19:26:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @attdet_OpeningFcn, ...
                   'gui_OutputFcn',  @attdet_OutputFcn, ...
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


% --- Executes just before attdet is made visible.
function attdet_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to attdet (see VARARGIN)

% Choose default command line output for attdet
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = attdet_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in calculate_pushbutton.
function calculate_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to calculate_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Collecting inertial frame data
v1i1 = getappdata(0,'v1i1'); v1i2 = getappdata(0,'v1i2'); v1i3 = getappdata(0,'v1i3');
v2i1 = getappdata(0,'v2i1'); v2i2 = getappdata(0,'v2i2'); v2i3 = getappdata(0,'v2i3');
v1i = [v1i1 v1i2 v1i3]'; v2i = [v2i1 v2i2 v2i3]';
%Collecting body frame data
v1b1 = getappdata(0,'v1b1'); v1b2 = getappdata(0,'v1b2'); v1b3 = getappdata(0,'v1b3');
v2b1 = getappdata(0,'v2b1'); v2b2 = getappdata(0,'v2b2'); v2b3 = getappdata(0,'v2b3');
v1b = [v1b1 v1b2 v1b3]'; v2b = [v2b1 v2b2 v2b3]';

method = getappdata(0,'method');
    switch method
        case 'Biased Triad'
            [Rbi] = biased_triad(v1b,v1i,v2b,v2i);
        case 'Balanced Triad'
            [Rbi] = balanced_triad(v1b,v1i,v2b,v2i);
        case 'Quest Method'
            [Rbi] = questmethod(v1b,v1i,v2b,v2i);
        case 'Q-method'
            [Rbi] = qmethod(v1b,v1i,v2b,v2i);
    end
    
set(handles.Rbi11_text,'string',sprintf('%.4f',Rbi(1,1)));set(handles.Rbi12_text,'string',sprintf('%.4f',Rbi(1,2)));set(handles.Rbi13_text,'string',sprintf('%.4f',Rbi(1,3)))
set(handles.Rbi21_text,'string',sprintf('%.4f',Rbi(2,1)));set(handles.Rbi22_text,'string',sprintf('%.4f',Rbi(2,2)));set(handles.Rbi23_text,'string',sprintf('%.4f',Rbi(2,3)))
set(handles.Rbi31_text,'string',sprintf('%.4f',Rbi(3,1)));set(handles.Rbi32_text,'string',sprintf('%.4f',Rbi(3,2)));set(handles.Rbi33_text,'string',sprintf('%.4f',Rbi(3,3)))

% --- Executes during object creation, after setting all properties.
function qs_out_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qs_out_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function qx_out_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qx_out_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function qy_out_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qy_out_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function qz_out_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qz_out_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function thetax_out_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thetax_out_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function thetay_out_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thetay_out_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function thetaz_out_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thetaz_out_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function dcm11_out_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dcm11_out_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function dcm12_out_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dcm12_out_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function dcm13_out_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dcm13_out_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function dcm21_out_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dcm21_out_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function dcm22_out_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dcm22_out_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function dcm23_out_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dcm23_out_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function dcm31_out_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dcm31_out_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function dcm32_out_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dcm32_out_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function dcm33_out_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dcm33_out_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function v1b1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to v1b1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v1b1 = str2double(get(hObject,'string'));
setappdata(0,'v1b1',v1b1)

% --- Executes during object creation, after setting all properties.
function v1b1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v1b1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function v2b1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to v2b1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v2b1 = str2double(get(hObject,'string'));
setappdata(0,'v2b1',v2b1)

% --- Executes during object creation, after setting all properties.
function v2b1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v2b1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function v1b2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to v1b2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v1b2 = str2double(get(hObject,'string'));
setappdata(0,'v1b2',v1b2)

% --- Executes during object creation, after setting all properties.
function v1b2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v1b2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function v2b2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to v2b2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v2b2 = str2double(get(hObject,'string'));
setappdata(0,'v2b2',v2b2)

% --- Executes during object creation, after setting all properties.
function v2b2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v2b2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function v1b3_edit_Callback(hObject, eventdata, handles)
% hObject    handle to v1b3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v1b3 = str2double(get(hObject,'string'));
setappdata(0,'v1b3',v1b3)

% --- Executes during object creation, after setting all properties.
function v1b3_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v1b3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function v2b3_edit_Callback(hObject, eventdata, handles)
% hObject    handle to v2b3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v2b3 = str2double(get(hObject,'string'));
setappdata(0,'v2b3',v2b3)

% --- Executes during object creation, after setting all properties.
function v2b3_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v2b3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function v2i3_edit_Callback(hObject, eventdata, handles)
% hObject    handle to v2i3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v2i3 = str2double(get(hObject,'string'));
setappdata(0,'v2i3',v2i3)

% --- Executes during object creation, after setting all properties.
function v2i3_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v2i3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function v2i2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to v2i2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v2i2 = str2double(get(hObject,'string'));
setappdata(0,'v2i2',v2i2)

% --- Executes during object creation, after setting all properties.
function v2i2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v2i2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function v2i1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to v2i1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v2i1 = str2double(get(hObject,'string'));
setappdata(0,'v2i1',v2i1)

% --- Executes during object creation, after setting all properties.
function v2i1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v2i1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function v1i3_edit_Callback(hObject, eventdata, handles)
% hObject    handle to v1i3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v1i3 = str2double(get(hObject,'string'));
setappdata(0,'v1i3',v1i3)

% --- Executes during object creation, after setting all properties.
function v1i3_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v1i3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function v1i2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to v1i2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v1i2 = str2double(get(hObject,'string'));
setappdata(0,'v1i2',v1i2)

% --- Executes during object creation, after setting all properties.
function v1i2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v1i2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function v1i1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to v1i1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v1i1 = str2double(get(hObject,'string'));
setappdata(0,'v1i1',v1i1)

% --- Executes during object creation, after setting all properties.
function v1i1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v1i1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in attdet_listbox.
function attdet_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to attdet_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
listbox = cellstr(get(hObject,'String'));
method = listbox{get(hObject,'Value')};
setappdata(0,'method',method)

% --- Executes during object creation, after setting all properties.
function attdet_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to attdet_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function Rbi11_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Rbi11_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
