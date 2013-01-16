function varargout = xsection_cut(varargin)
% XSECTION_CUT M-file for xsection_cut.fig
%      XSECTION_CUT, by itself, creates a new XSECTION_CUT or raises the existing
%      singleton*.
%
%      H = XSECTION_CUT returns the handle to a new XSECTION_CUT or the handle to
%      the existing singleton*.
%
%      XSECTION_CUT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in XSECTION_CUT.M with the given input arguments.
%
%      XSECTION_CUT('Property','Value',...) creates a new XSECTION_CUT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before xsection_cut_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to xsection_cut_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help xsection_cut

% Last Modified by GUIDE v2.5 07-Aug-2008 18:05:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @xsection_cut_OpeningFcn, ...
                   'gui_OutputFcn',  @xsection_cut_OutputFcn, ...
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



% --- Executes just before xsection_cut is made visible.
function xsection_cut_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to xsection_cut (see VARARGIN)

% Choose default command line output for xsection_cut
handles.original = varargin{1};
handles.img = varargin{1};
handles.output = handles.img;




% Update handles structure
guidata(hObject, handles);
redraw(handles);

% UIWAIT makes xsection_cut wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = xsection_cut_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
close xsection_cut

% --- Executes on button press in grab.
function grab_Callback(hObject, eventdata, handles)

% hObject    handle to grab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)





% --- Executes on button press in cutx.
function cutx_Callback(hObject, eventdata, handles)

axes(handles.axes2);
valid = 0;
[sr,sc] = size(handles.img);


while(~valid)
    in = ginput(1);
    if  in(1) < 1 || in(1) > sc || in(2) < min(handles.img(:)) || in(2) > max(handles.img(:))
        set(handles.display, 'string', 'X-CUT OUT OF RANGE');
    else
        set(handles.display, 'string', sprintf('Threshold set at %0.4f', in(2)));
        valid = 1;
    end
end

threshold = in(2);
handles.img(handles.img < threshold) = 0;
redraw(handles);

handles.output = handles.img;
guidata(hObject, handles);


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
guidata(hObject, handles);
uiresume(handles.figure1);


function [] = redraw(handles)
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


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
handles.img = handles.original;
guidata(hObject, handles);
redraw(handles)


