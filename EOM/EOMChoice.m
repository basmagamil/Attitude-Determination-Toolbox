function varargout = EOMChoice(varargin)
% EOMCHOICE MATLAB code for EOMChoice.fig
%      EOMCHOICE, by itself, creates a new EOMCHOICE or raises the existing
%      singleton*.
%
%      H = EOMCHOICE returns the handle to a new EOMCHOICE or the handle to
%      the existing singleton*.
%
%      EOMCHOICE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EOMCHOICE.M with the given input arguments.
%
%      EOMCHOICE('Property','Value',...) creates a new EOMCHOICE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EOMChoice_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EOMChoice_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EOMChoice

% Last Modified by GUIDE v2.5 17-Dec-2018 18:19:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EOMChoice_OpeningFcn, ...
                   'gui_OutputFcn',  @EOMChoice_OutputFcn, ...
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

% --- Executes just before EOMChoice is made visible.
function EOMChoice_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EOMChoice (see VARARGIN)

% Choose default command line output for EOMChoice
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EOMChoice wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = EOMChoice_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in linear_button.
function linear_button_Callback(hObject, eventdata, handles)
% hObject    handle to linear_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(EOMChoice)
lineom

% --- Executes on button press in non_linear_button.
function non_linear_button_Callback(hObject, eventdata, handles)
% hObject    handle to non_linear_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(EOMChoice)
nonlineom
