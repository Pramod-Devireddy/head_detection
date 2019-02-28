function varargout = HeadCount(varargin)
% HEADCOUNT MATLAB code for HeadCount.fig
%      HEADCOUNT, by itself, creates a new HEADCOUNT or raises the existing
%      singleton*.
%
%      H = HEADCOUNT returns the handle to a new HEADCOUNT or the handle to
%      the existing singleton*.
%
%      HEADCOUNT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HEADCOUNT.M with the given input arguments.
%
%      HEADCOUNT('Property','Value',...) creates a new HEADCOUNT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HeadCount_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HeadCount_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HeadCount

% Last Modified by GUIDE v2.5 22-Feb-2016 00:13:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HeadCount_OpeningFcn, ...
                   'gui_OutputFcn',  @HeadCount_OutputFcn, ...
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


% --- Executes just before HeadCount is made visible.
function HeadCount_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HeadCount (see VARARGIN)

% Choose default command line output for HeadCount
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HeadCount wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = HeadCount_OutputFcn(hObject, eventdata, handles) 
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
global stop
stop = false;
vidObj = webcam;
faceDetector = vision.CascadeObjectDetector('Head6.xml','MergeThreshold',6); % Finds Heads
tracker = MultiObjectTrackerKLT;

%% Iterate until we have successfully detected a face
bboxes = [];
while isempty(bboxes)
    pause(3);
    framergb = snapshot(vidObj);
    frame = flip(rgb2gray(framergb),2);
    bboxes = 1*faceDetector.step(imresize(frame, 1));
    axes(handles.axes1);
    imshow(framergb);
end
tracker.addDetections(frame, bboxes);

%% And loop until the player is closed
frameNumber = 0;
keepRunning = true;
while keepRunning
    if stop == false
    framergb = flip(snapshot(vidObj),2);
    frame = rgb2gray(framergb);
    
    if mod(frameNumber, 5) == 0
        bboxes = 1*faceDetector.step(imresize(frame, 1));
        if ~isempty(bboxes)
            tracker.addDetections(frame, bboxes);
        end
    else
        % Track faces
        tracker.track(frame);
    end
    
    % Display bounding boxes and tracked points.
    set(handles.text2,'String',num2str(tracker.NextId-1));
    displayFrame = insertObjectAnnotation(framergb, 'rectangle',...
        tracker.Bboxes, tracker.BoxIds);
%     displayFrame = insertMarker(displayFrame, tracker.Points);
%     videoPlayer.step(displayFrame);
    imshow(displayFrame);
    
    frameNumber = frameNumber + 1;
    else
        clear vidObj;
        return;
    end
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stop
stop = true;
