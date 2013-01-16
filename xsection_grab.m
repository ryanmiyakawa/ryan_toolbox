function varargout = xsection_grab(varargin)
% XSECTION_GRAB M-file for xsection_grab.fig
%      XSECTION_GRAB, by itself, creates a new XSECTION_GRAB or raises the existing
%      singleton*.
%
%      H = XSECTION_GRAB returns the handle to a new XSECTION_GRAB or the handle to
%      the existing singleton*.
%
%      XSECTION_GRAB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in XSECTION_GRAB.M with the given input arguments.
%
%      XSECTION_GRAB('Property','Value',...) creates a new XSECTION_GRAB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before xsection_grab_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to xsection_grab_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help xsection_grab

% Last Modified by GUIDE v2.5 07-Aug-2008 16:22:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @xsection_grab_OpeningFcn, ...
                   'gui_OutputFcn',  @xsection_grab_OutputFcn, ...
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



% --- Executes just before xsection_grab is made visible.
function xsection_grab_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to xsection_grab (see VARARGIN)

% Choose default command line output for xsection_grab
handles.output = hObject;
handles.img = varargin{1};
[sr,sc] = size(handles.img);
axes(handles.axes1);
try
    imagesca(handles.img);
end
set(handles.axes1, 'YTickLabel', []);
set(handles.axes1, 'XTickLabel', []);
axes(handles.axes2);
whitebg('black');
plot(1:sc,max(abs(handles.img)));
set(handles.axes2, 'YTickLabel', []);
axes(handles.axes3);
whitebg('black');
plot(max(abs(handles.img),[],2),1:sr);
set(handles.axes3, 'XTickLabel', []);

try
    vals = ginput(varargin{2});
catch 
    vals = ginput(2);
end

handles.output = vals;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes xsection_grab wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = xsection_grab_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in grab.
function grab_Callback(hObject, eventdata, handles)

% hObject    handle to grab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)



