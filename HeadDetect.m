function varargout = HeadDetect(varargin)
% HEADDETECT MATLAB code for HeadDetect.fig
%      HEADDETECT, by itself, creates a new HEADDETECT or raises the existing
%      singleton*.
%
%      H = HEADDETECT returns the handle to a new HEADDETECT or the handle to
%      the existing singleton*.
%
%      HEADDETECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HEADDETECT.M with the given input arguments.
%
%      HEADDETECT('Property','Value',...) creates a new HEADDETECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HeadDetect_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HeadDetect_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HeadDetect

% Last Modified by GUIDE v2.5 29-Feb-2016 07:42:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HeadDetect_OpeningFcn, ...
                   'gui_OutputFcn',  @HeadDetect_OutputFcn, ...
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


% --- Executes just before HeadDetect is made visible.
function HeadDetect_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HeadDetect (see VARARGIN)

% Choose default command line output for HeadDetect
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HeadDetect wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HeadDetect_OutputFcn(hObject, eventdata, handles) 
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
global HeadDetector HeadDetector1
HeadDetector1 = vision.CascadeObjectDetector('Haar.xml','MergeThreshold',6);
HeadDetector = vision.CascadeObjectDetector('Head6.xml');
[path,cancel] = imgetfile();
if cancel
    message=sprintf('Image not selected');
    uiwait(msgbox(message));
    return;
end
I_org = imread(path);
if size(I_org,3)==3
    I = rgb2gray(I_org);
else
    I = I_org;
end
bbox1 = HeadDetector1.step(I);
for i=1:size(bbox1,1)
    y1 = bbox1(i,1);
    x1 = bbox1(i,2);
    y2 = bbox1(i,3);
    x2 = bbox1(i,4);
    I(x1:x1+x2,y1:y1+y2) = zeros(x2+1,y2+1);
end
bbox2 = HeadDetector.step(I);
bbox = vertcat(bbox1,bbox2);
I1 = insertObjectAnnotation(I_org,'rectangle',bbox,'Head');
axes(handles.axes1);
imshow(I1);
set(handles.text2,'String',num2str(size(bbox,1)));

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global HeadDetector HeadDetector1
HeadDetector1 = vision.CascadeObjectDetector('Haar.xml','MergeThreshold',6);
HeadDetector = vision.CascadeObjectDetector('Head6.xml');
cam = webcam;
pause(3);
I_org = snapshot(cam);
I = rgb2gray(I_org);
bbox1 = HeadDetector1.step(I);
for i=1:size(bbox1,1)
    y1 = bbox1(i,1);
    x1 = bbox1(i,2);
    y2 = bbox1(i,3);
    x2 = bbox1(i,4);
    I(x1:x1+x2-10,y1:y1+y2-10) = zeros(x2+1-10,y2+1-10);
end
bbox2 = HeadDetector.step(I);
bbox = vertcat(bbox1,bbox2);
I1 = insertObjectAnnotation(I_org,'rectangle',bbox,'Head');
axes(handles.axes1);
imshow(I1);
set(handles.text2,'String',num2str(size(bbox,1)));
clear cam;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1);