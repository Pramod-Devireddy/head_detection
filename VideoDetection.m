clear;clc;close all;

vidObj = vision.VideoFileReader('TownCentreXVID.avi','VideoOutputDataType','uint8');

HeadDetector = vision.CascadeObjectDetector('Town2.xml'); % Finds faces by default
tracker = MultiObjectTrackerKLT;

frame = step(vidObj);
frameSize = size(frame);

bboxes = [];
while isempty(bboxes)
    framergb = step(vidObj);
    frame = rgb2gray(framergb);
    bboxes = HeadDetector.step(frame);
end
tracker.addDetections(frame, bboxes);

%% And loop until the player is closed
frameNumber = 0;
keepRunning = true;
disp('Press Ctrl-C to exit...');
vid = VideoWriter('samp.avi');
vid.FrameRate = 25;
open(vid);
while ~isDone(vidObj)
    
    framergb = step(vidObj);
    frame = rgb2gray(framergb);
    
    if mod(frameNumber, 5) == 0
        bboxes = 1*HeadDetector.step(imresize(frame, 1));
        if ~isempty(bboxes)
            tracker.addDetections(frame, bboxes);
        end
    else
        % Track faces
        tracker.track(frame);
    end
%     fprintf('Count = %d \n',tracker.BoxIds);
    % Display bounding boxes and tracked points.
    displayFrame = insertObjectAnnotation(framergb, 'rectangle',...
        tracker.Bboxes, tracker.BoxIds);
%     displayFrame = insertMarker(displayFrame, tracker.Points);
%     videoPlayer.step(displayFrame);
    writeVideo(vid,displayFrame);
%     imshow(displayFrame);
    frameNumber = frameNumber + 1;
end
close(vid);