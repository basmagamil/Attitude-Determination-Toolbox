function varargout = angles(varargin)
% ANGLES MATLAB code for angles.fig
%      ANGLES, by itself, creates a new ANGLES or raises the existing
%      singleton*.
%
%      H = ANGLES returns the handle to a new ANGLES or the handle to
%      the existing singleton*.
%
%      ANGLES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANGLES.M with the given input arguments.
%
%      ANGLES('Property','Value',...) creates a new ANGLES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before angles_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to angles_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help angles

% Last Modified by GUIDE v2.5 19-Dec-2018 21:56:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @angles_OpeningFcn, ...
                   'gui_OutputFcn',  @angles_OutputFcn, ...
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


% --- Executes just before angles is made visible.
function angles_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to angles (see VARARGIN)

% Choose default command line output for angles
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes angles wait for user response (see UIRESUME)
% uiwait(handles.angles);


% --- Outputs from this function are returned to the command line.
function varargout = angles_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in convert_pushbutton.
function convert_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to convert_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%user-chosen methods
input_method = getappdata(0,'input_method');
output_method = getappdata(0,'output_method');

switch input_method
    case 'q_in'
        qs = getappdata(0,'qs'); qx = getappdata(0,'qx'); qy = getappdata(0,'qy'); qz = getappdata(0,'qz');
        q = [qx qy qz];
        switch output_method
            case 'euler_out'
                seq_out = getappdata(0,'seq_out');
                [theta1,theta2,theta3] = quaternion2euler(qs,q,seq_out);
                set(handles.theta1_out_text,'string',sprintf('%.4f',theta1));
                set(handles.theta2_out_text,'string',sprintf('%.4f',theta2));
                set(handles.theta3_out_text,'string',sprintf('%.4f',theta3));
            case 'dcm_out'
                [T] = quaternion2dcm_nonhomog(qs,q);
                set(handles.dcm11_out_text,'string',sprintf('%.4f',T(1,1))); set(handles.dcm12_out_text,'string',sprintf('%.4f',T(1,2))); set(handles.dcm13_out_text,'string',sprintf('%.4f',T(1,3)));
                set(handles.dcm21_out_text,'string',sprintf('%.4f',T(2,1))); set(handles.dcm22_out_text,'string',sprintf('%.4f',T(2,2))); set(handles.dcm23_out_text,'string',sprintf('%.4f',T(2,3)));
                set(handles.dcm31_out_text,'string',sprintf('%.4f',T(3,1))); set(handles.dcm32_out_text,'string',sprintf('%.4f',T(3,2))); set(handles.dcm33_out_text,'string',sprintf('%.4f',T(3,3)));
        end
    case 'euler_in'
        theta1 = getappdata(0,'theta1'); theta2 = getappdata(0,'theta2'); theta3 = getappdata(0,'theta3');
        seq_in = getappdata(0,'seq_in');
        switch output_method
            case 'q_out'
                [qs,q] = euler2quaternion(theta1,theta2,theta3,seq_in);
                set(handles.qs_out_text,'string',sprintf('%.4f',qs));
                set(handles.qx_out_text,'string',sprintf('%.4f',q(1)));
                set(handles.qy_out_text,'string',sprintf('%.4f',q(2)));
                set(handles.qz_out_text,'string',sprintf('%.4f',q(3)));
            case 'dcm_out'
                [T] = euler2dcm(theta1,theta2,theta3,seq_in);
                set(handles.dcm11_out_text,'string',sprintf('%.4f',T(1,1))); set(handles.dcm12_out_text,'string',sprintf('%.4f',T(1,2))); set(handles.dcm13_out_text,'string',sprintf('%.4f',T(1,3)));
                set(handles.dcm21_out_text,'string',sprintf('%.4f',T(2,1))); set(handles.dcm22_out_text,'string',sprintf('%.4f',T(2,2))); set(handles.dcm23_out_text,'string',sprintf('%.4f',T(2,3)));
                set(handles.dcm31_out_text,'string',sprintf('%.4f',T(3,1))); set(handles.dcm32_out_text,'string',sprintf('%.4f',T(3,2))); set(handles.dcm33_out_text,'string',sprintf('%.4f',T(3,3)));
        end
    case 'dcm_in'
        T11 = getappdata(0,'dcm11'); T12 = getappdata(0,'dcm12'); T13 = getappdata(0,'dcm13');
        T21 = getappdata(0,'dcm21'); T22 = getappdata(0,'dcm22'); T23 = getappdata(0,'dcm23');
        T31 = getappdata(0,'dcm31'); T32 = getappdata(0,'dcm32'); T33 = getappdata(0,'dcm33');
        T = [T11 T12 T13; T21 T22 T23; T31 T32 T33];
        switch output_method
            case 'q_out'
                [qs, q] = dcm2quaternion(T);
                set(handles.qs_out_text,'string',sprintf('%.4f',qs));
                set(handles.qx_out_text,'string',sprintf('%.4f',q(1)));
                set(handles.qy_out_text,'string',sprintf('%.4f',q(2)));
                set(handles.qz_out_text,'string',sprintf('%.4f',q(3)));
            case 'euler_out'
                [theta1,theta2,theta3] = dcm2euler(T,seq);
                set(handles.theta1_out_text,'string',sprintf('%.4f',theta1));
                set(handles.theta2_out_text,'string',sprintf('%.4f',theta2));
                set(handles.theta3_out_text,'string',sprintf('%.4f',theta3));
        end
end

% --- Executes on button press in q_out.
function q_out_Callback(hObject, eventdata, handles)
% hObject    handle to q_out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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

% --- Executes on button press in euler_out.
function euler_out_Callback(hObject, eventdata, handles)
% hObject    handle to euler_out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function theta1_out_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta1_out_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function theta2_out_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta2_out_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function theta3_out_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta3_out_text (see GCBO)
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
function dcm31_out_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dcm31_out_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
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

% --- Executes on button press in dcm_out.
function dcm_out_Callback(hObject, eventdata, handles)
% hObject    handle to dcm_out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in euler_in.
function euler_in_Callback(hObject, eventdata, handles)
% hObject    handle to euler_in (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function theta1_in_edit_Callback(hObject, eventdata, handles)
% hObject    handle to theta1_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta1 = str2double(get(hObject,'String'));
setappdata(0,'theta1',theta1)

% --- Executes during object creation, after setting all properties.
function theta1_in_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta1_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function theta2_in_edit_Callback(hObject, eventdata, handles)
% hObject    handle to theta2_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta2 = str2double(get(hObject,'String'));
setappdata(0,'theta2',theta2)

% --- Executes during object creation, after setting all properties.
function theta2_in_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta2_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function theta3_in_edit_Callback(hObject, eventdata, handles)
% hObject    handle to theta3_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta3 = str2double(get(hObject,'String'));
setappdata(0,'theta3',theta3)

% --- Executes during object creation, after setting all properties.
function theta3_in_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta3_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dcm11_in_edit_Callback(hObject, eventdata, handles)
% hObject    handle to dcm11_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dcm11 = str2double(get(hObject,'String'));
setappdata(0,'dcm11',dcm11)

% --- Executes during object creation, after setting all properties.
function dcm11_in_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dcm11_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dcm12_in_edit_Callback(hObject, eventdata, handles)
% hObject    handle to dcm12_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dcm12 = str2double(get(hObject,'String'));
setappdata(0,'dcm12',dcm12)

% --- Executes during object creation, after setting all properties.
function dcm12_in_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dcm12_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dcm13_in_edit_Callback(hObject, eventdata, handles)
% hObject    handle to dcm13_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dcm13 = str2double(get(hObject,'String'));
setappdata(0,'dcm13',dcm13)

% --- Executes during object creation, after setting all properties.
function dcm13_in_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dcm13_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dcm21_in_edit_Callback(hObject, eventdata, handles)
% hObject    handle to dcm21_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dcm21 = str2double(get(hObject,'String'));
setappdata(0,'dcm21',dcm21)

% --- Executes during object creation, after setting all properties.
function dcm21_in_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dcm21_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dcm22_in_edit_Callback(hObject, eventdata, handles)
% hObject    handle to dcm22_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dcm22 = str2double(get(hObject,'String'));
setappdata(0,'dcm22',dcm22)

% --- Executes during object creation, after setting all properties.
function dcm22_in_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dcm22_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dcm31_in_edit_Callback(hObject, eventdata, handles)
% hObject    handle to dcm31_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dcm31 = str2double(get(hObject,'String'));
setappdata(0,'dcm31',dcm31)

% --- Executes during object creation, after setting all properties.
function dcm31_in_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dcm31_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dcm32_in_edit_Callback(hObject, eventdata, handles)
% hObject    handle to dcm32_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dcm32 = str2double(get(hObject,'String'));
setappdata(0,'dcm32',dcm32)

% --- Executes during object creation, after setting all properties.
function dcm32_in_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dcm32_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dcm33_in_edit_Callback(hObject, eventdata, handles)
% hObject    handle to dcm33_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dcm33 = str2double(get(hObject,'String'));
setappdata(0,'dcm33',dcm33)

% --- Executes during object creation, after setting all properties.
function dcm33_in_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dcm33_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dcm23_in_edit_Callback(hObject, eventdata, handles)
% hObject    handle to dcm23_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dcm23 = str2double(get(hObject,'String'));
setappdata(0,'dcm23',dcm23)

% --- Executes during object creation, after setting all properties.
function dcm23_in_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dcm23_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in dcm_in.
function dcm_in_Callback(hObject, eventdata, handles)
% hObject    handle to dcm_in (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of dcm_in

% --- Executes on button press in q_in.
function q_in_Callback(hObject, eventdata, handles)
% hObject    handle to q_in (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of q_in

function qs_in_edit_Callback(hObject, eventdata, handles)
% hObject    handle to qs_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
qs = str2double(get(hObject,'String'));
setappdata(0,'qs',qs)

% --- Executes during object creation, after setting all properties.
function qs_in_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qs_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function qx_in_edit_Callback(hObject, eventdata, handles)
% hObject    handle to qx_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
qx = str2double(get(hObject,'String'));
setappdata(0,'qx',qx)

% --- Executes during object creation, after setting all properties.
function qx_in_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qx_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function qy_in_edit_Callback(hObject, eventdata, handles)
% hObject    handle to qy_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
qy = str2double(get(hObject,'String'));
setappdata(0,'qy',qy)

% --- Executes during object creation, after setting all properties.
function qy_in_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qy_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function qz_in_edit_Callback(hObject, eventdata, handles)
% hObject    handle to qz_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
qz = str2double(get(hObject,'String'));
setappdata(0,'qz',qz)

% --- Executes during object creation, after setting all properties.
function qz_in_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qz_in_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function InputGroup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function OutputGroup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OutputGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes when selected object is changed in InputGroup.
function InputGroup_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in InputGroup 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input_method = get(eventdata.NewValue,'tag');
setappdata(0,'input_method',input_method);

% --- Executes when selected object is changed in OutputGroup.
function OutputGroup_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in OutputGroup 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
output_method = get(eventdata.NewValue,'tag');
setappdata(0,'output_method',output_method);

function seq_out_Callback(hObject, eventdata, handles)
% hObject    handle to seq_out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
seq_out = get(hObject,'String');
setappdata(0,'seq_out',seq_out)

% --- Executes during object creation, after setting all properties.
function seq_out_CreateFcn(hObject, eventdata, handles)
% hObject    handle to seq_out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function seq_in_Callback(hObject, eventdata, handles)
% hObject    handle to seq_in (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
seq_in = get(hObject,'String');
setappdata(0,'seq_in',seq_in)

% --- Executes during object creation, after setting all properties.
function seq_in_CreateFcn(hObject, eventdata, handles)
% hObject    handle to seq_in (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
