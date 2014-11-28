function varargout = detectionGUI(varargin)
% DETECTIONGUI MATLAB code for detectionGUI.fig
%      DETECTIONGUI, by itself, creates a new DETECTIONGUI or raises the existing
%      singleton*.
%
%      H = DETECTIONGUI returns the handle to a new DETECTIONGUI or the handle to
%      the existing singleton*.
%
%      DETECTIONGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DETECTIONGUI.M with the given input arguments.
%
%      DETECTIONGUI('Property','Value',...) creates a new DETECTIONGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before detectionGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to detectionGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help detectionGUI

% Last Modified by GUIDE v2.5 26-Nov-2014 18:59:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @detectionGUI_OpeningFcn, ...
    'gui_OutputFcn',  @detectionGUI_OutputFcn, ...
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


% --- Executes just before detectionGUI is made visible.
function detectionGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to detectionGUI (see VARARGIN)

% Choose default command line output for detectionGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes detectionGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = detectionGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

for idx = handles.start : handles.start+100
    Img = handles.vidFrames(:,:,:,idx);
    [licenseNum, color, date, time, licensePlate, corrMap, folderName] = MainFunc(Img);
    
    axes(handles.axes1);
    imshow(Img);
    
    axes(handles.axes4);
    imshow(licensePlate);
    
    axes(handles.axes3);
    imagesc(corrMap);
    ax = gca;
    set(ax, 'YTickLabel',folderName);
    set(ax, 'YTick',1:numel(folderName));
    
    text2GUI={'License Number:' ; num2str(licenseNum); ' ' ; 'Car Color:'; color; ' ' ; 'Date:'; date; ' ' ;  'Time:'; time};
    set(handles.text4,'String',text2GUI);
    
    handles.corrMap = corrMap;
    handles.folderName = folderName;
end

handles.start =  handles.start+100;

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.start = handles.start + 100*6;
idx = handles.start;
Img = handles.vidFrames(:,:,:,idx);
[licenseNum, color, date, time, licensePlate, corrMap, folderName] = MainFunc(Img);

axes(handles.axes1);
imshow(Img);

axes(handles.axes4);
imshow(licensePlate);

axes(handles.axes3);
imagesc(corrMap);
ax = gca;
set(ax, 'YTickLabel',folderName);
set(ax, 'YTick',1:numel(folderName));

text2GUI={'License Number:' ; num2str(licenseNum); ' ' ; 'Car Color:'; color; ' ' ; 'Date:'; date; ' ' ;  'Time:'; time};
set(handles.text4,'String',text2GUI);

handles.corrMap = corrMap;
handles.folderName = folderName;

% Update handles structure
guidata(hObject, handles);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function singleTab_Callback(hObject, eventdata, handles)
% hObject    handle to singleTab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile( {'*.png','PNG file (*.png)';'*.bmp','BMP file (*.bmp)'; '*.jpg','JPEG file (*.jpg)' });
loadedPath = fullfile(pathname,filename);
handles.bigImagesPath = pathname;
Img = imread(loadedPath);

[licenseNum, color, date, time, licensePlate, corrMap, folderName] = MainFunc(Img);

axes(handles.axes1);
imshow(Img);

axes(handles.axes4);
imshow(licensePlate);

axes(handles.axes3);
imagesc(corrMap);
ax = gca;
set(ax, 'YTickLabel',folderName);
set(ax, 'YTick',1:numel(folderName));

text2GUI={'License Number:' ; num2str(licenseNum); ' ' ; 'Car Color:'; color; ' ' ; 'Date:'; date; ' ' ;  'Time:'; time};
set(handles.text4,'String',text2GUI);

handles.corrMap = corrMap;
handles.folderName = folderName;
handles.single = 1;
handles.start = 1;
% Update handles structure
guidata(hObject, handles);

% --------------------------------------------------------------------
function movieTab_Callback(hObject, eventdata, handles)
% hObject    handle to movieTab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile( {'*.avi','AVI file (*.avi)'});
loadedPath = fullfile(pathname,filename);

% D:\10\שער יפו כניסה _1
% Construct a multimedia reader object associated with file 'xylophone.mpg' with
% user tag set to 'myreader1'.
readerobj = VideoReader(loadedPath, 'tag', 'myreader1');

% Read in all video frames.
handles.vidFrames = read(readerobj, [1 100]);

% Get the number of frames.
handles.numFrames = get(readerobj, 'NumberOfFrames');

Img = handles.vidFrames(:,:,:,1);
[licenseNum, color, date, time, licensePlate, corrMap, folderName] = MainFunc(Img);

axes(handles.axes1);
imshow(Img);

axes(handles.axes4);
imshow(licensePlate);

axes(handles.axes3);
imagesc(corrMap);
ax = gca;
set(ax, 'YTickLabel',folderName);
set(ax, 'YTick',1:numel(folderName));

text2GUI={'License Number:' ; num2str(licenseNum); ' ' ; 'Car Color:'; color; ' ' ; 'Date:'; date; ' ' ;  'Time:'; time};
set(handles.text4,'String',text2GUI);

handles.corrMap = corrMap;
handles.folderName = folderName;
handles.start = 1;
handles.single = 0;
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
if  get(hObject,'Value')==1
    figure();
    imagesc(handles.corrMap);
    ax = gca;
    set(ax, 'YTickLabel',handles.folderName);
    set(ax, 'YTick',1:numel(handles.folderName));
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
idx = handles.start;
if handles.single == 0
    Img = handles.vidFrames(:,:,:,idx);
else
    bigImagesPath = handles.bigImagesPath;
    bigImagesPNG  = dir([bigImagesPath '\*.png']);
    bigImagesBMP  = dir([bigImagesPath '\*.bmp']);
    bigImages = [bigImagesPNG ; bigImagesBMP];
    Img = imread([bigImagesPath '\' bigImages(mod(idx,length(bigImages))+1).name]);
end

[licenseNum, color, date, time, licensePlate, corrMap, folderName] = MainFunc(Img);

axes(handles.axes1);
imshow(Img);

axes(handles.axes4);
imshow(licensePlate);

axes(handles.axes3);
imagesc(corrMap);
ax = gca;
set(ax, 'YTickLabel',folderName);
set(ax, 'YTick',1:numel(folderName));

text2GUI={'License Number:' ; num2str(licenseNum); ' ' ; 'Car Color:'; color; ' ' ; 'Date:'; date; ' ' ;  'Time:'; time};
set(handles.text4,'String',text2GUI);

handles.corrMap = corrMap;
handles.folderName = folderName;

handles.start =  handles.start+1;

% Update handles structure
guidata(hObject, handles);


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile( {'*.png','PNG file (*.png)';'*.bmp','BMP file (*.bmp)'; '*.jpg','JPEG file (*.jpg)' });
loadedPath = fullfile(pathname,filename);
handles.bigImagesPath = pathname;
Img = imread(loadedPath);

axes(handles.axes1);
imshow(Img);

[licenseNum, color, bwImage] = MainFuncBig(Img);


axes(handles.axes4);
imshow(bwImage);

axes(handles.axes3);
imshow(bwImage);

f = dir(loadedPath);  % struct f contains file information
dateTime = f.date;     % is string containing modification time

time = dateTime(end-8:end);
date = dateTime(1:11);

text2GUI={'License Number:' ; num2str(licenseNum); ' ' ; 'Car Color:'; color; ' ' ; 'Date:'; date; ' ' ;  'Time:'; time};
set(handles.text4,'String',text2GUI);

handles.corrMap = corrMap;
handles.folderName = folderName;
handles.single = 1;
handles.start = 1;
% Update handles structure
guidata(hObject, handles);