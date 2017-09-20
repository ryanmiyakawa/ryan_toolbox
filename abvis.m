% Aberration visualizer, call with arguments:
% abvis(wave, basis, rec, mask)

function varargout = abvis(varargin)
% ABVIS M-file for abvis.fig
%      ABVIS, by itself, creates a new ABVIS or raises the existing
%      singleton*.
%
%      H = ABVIS returns the handle to a new ABVIS or the handle to
%      the existing singleton*.
%
%      ABVIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ABVIS.M with the given input arguments.
%
%      ABVIS('Property','Value',...) creates a new ABVIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before abvis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to abvis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help abvis

% Last Modified by GUIDE v2.5 02-Feb-2013 09:03:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @abvis_OpeningFcn, ...
                   'gui_OutputFcn',  @abvis_OutputFcn, ...
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


% --- Executes just before abvis is made visible.
function abvis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to abvis (see VARARGIN)

% Choose default command line output for abvis
handles.output  = hObject;
handles.fig     = hObject;

handles.wave    = varargin{1};
handles.basis   = varargin{2};
handles.rec     = varargin{3};
handles.mask    = varargin{4};
if length(varargin) == 5
    handles.labels  = varargin{5};
else
    handles.labels = '';
end


% Update handles structure
guidata(hObject, handles);

init(handles);

% UIWAIT makes abvis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function init(handles)
handles = guidata(handles.fig);

handles.currentIdx = 1;

set(handles.fig, 'currentaxes', handles.axes1);
imagesc(handles.wave);
axis off
axis image

set(handles.fig, 'currentaxes', handles.axes2);
stem(handles.rec);
handles.removeVec = zeros(1, length(handles.basis));

set(handles.removeCB, 'visible', 'off');
set(handles.listbox, 'value', 1);
guidata(handles.fig, handles);
updateListbox(handles)
listbox_Callback(handles.listbox, [], handles)

function updateListbox(handles)
handles = guidata(handles.fig);
% set up listbox
handles.listTxt = 'Total Wave|';
removeShowVec = cell(1, length(handles.rec));
for k = 1:length(handles.rec)
    if handles.removeVec(k) == 1
        removeShowVec{k} = '(-)';
    else
        removeShowVec{k} = '';
    end
end

if isempty(handles.labels)
    handles = rmfield(handles, 'labels');
    for k = 1:length(handles.rec)
       
        handles.labels{k} = num2str(k);
        
    end
end
for k = 1:length(handles.rec)
    thisStr = sprintf('V_%s: %0.3f  %s|', handles.labels{k}, handles.rec(k), removeShowVec{k});
    if k == length(handles.rec)
        thisStr = sprintf('V_%s: %0.3f  %s', handles.labels{k}, handles.rec(k), removeShowVec{k});
    end
    handles.listTxt = [handles.listTxt thisStr];
    
end

set(handles.listbox, 'string', handles.listTxt);

% restem:
set(handles.fig, 'currentaxes', handles.axes2);
colormap hot
msk = 1 - handles.removeVec;
if size(handles.rec, 1) > size(handles.rec, 2)
    msk = msk'
end
stem(handles.rec.*msk);

guidata(handles.fig, handles);



% --- Outputs from this function are returned to the command line.
function varargout = abvis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox.
function listbox_Callback(hObject, eventdata, handles)
handles = guidata(handles.fig);



val = get(hObject, 'value');
if val > 1
    set(handles.removeCB, 'visible', 'on');
else
    set(handles.removeCB, 'visible', 'off');
end




set(handles.fig, 'currentaxes', handles.axes1)
if val == 1
    % remove abs from wave:
    sb = zeros(size(handles.wave));
    ad = zeros(size(handles.wave));
    for k = 1:length(handles.rec)
        if handles.removeVec(k) == 0
            ad = ad + handles.rec(k)*handles.basis{k}.*handles.mask;
            continue;
        end
        sb = sb + handles.rec(k)*handles.basis{k}.*handles.mask;
    end
    imagesc(handles.wave.*handles.mask - sb);
    colorbar
    
    numPts = length(find(handles.wave.*handles.mask));
    
    rmsEr = 1000*sqrt(sum(sum(abs(ad).^2))/numPts);
    conEr = 1000*sqrt(sum(sum(abs(handles.wave.*handles.mask - ad - sb).^2))/numPts);
    set(handles.conEr, 'string', sprintf('%0.1f', conEr));
    set(handles.rmsEr, 'string', sprintf('%0.1f', rmsEr));
    
    
else
    imagesc(handles.basis{val - 1})
    ckVal = handles.removeVec(val - 1);
    set(handles.removeCB, 'value', ckVal);
    colorbar
end
axis off
axis image





% --- Executes during object creation, after setting all properties.
function listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in prev.
function prev_Callback(hObject, eventdata, handles)
% hObject    handle to prev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in next.
function next_Callback(hObject, eventdata, handles)
% hObject    handle to next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in removeCB.
function removeCB_Callback(hObject, eventdata, handles)
handles = guidata(handles.fig);
lbVal = get(handles.listbox, 'value');
ckVal = get(hObject, 'value');
handles.removeVec(lbVal - 1) = ckVal;

guidata(handles.fig, handles);
updateListbox(handles)


% --- Executes on key press with focus on listbox and none of its controls.
function listbox_KeyPressFcn(hObject, eventdata, handles)



function rmsEr_Callback(hObject, eventdata, handles)
% hObject    handle to rmsEr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rmsEr as text
%        str2double(get(hObject,'String')) returns contents of rmsEr as a double


% --- Executes during object creation, after setting all properties.
function rmsEr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rmsEr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function conEr_Callback(hObject, eventdata, handles)
% hObject    handle to conEr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of conEr as text
%        str2double(get(hObject,'String')) returns contents of conEr as a double


% --- Executes during object creation, after setting all properties.
function conEr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to conEr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
