clear;clc;close all;
% cam = webcam;
vidObj = vision.VideoFileReader('TownCentreXVID.avi','VideoOutputDataType','uint8');
HeadDetector = vision.CascadeObjectDetector('Town1.xml');
vid = VideoWriter('samp.avi');
vid.FrameRate = 24;
open(vid);
for i=1:250
    framergb = step(vidObj);
    frame = rgb2gray(framergb);
    bboxes = 2*HeadDetector.step(imresize(frame,0.5));
    displayframe = insertObjectAnnotation(framergb,'rectangle',bboxes,'Head');
%     frame = snapshot(cam);
    writeVideo(vid,displayframe);
end
close(vid);
clear cam;