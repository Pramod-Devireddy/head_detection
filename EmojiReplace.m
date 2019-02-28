clear;clc;close all;
% path = imgetfile();
% I = imread(path);
% create a detector object
FaceDetector = vision.CascadeObjectDetector('Haar.xml');
HeadDetector = vision.CascadeObjectDetector('Head6.xml');
[Im, map, alpha] = imread('emoji.png');
% Read input image from cam
cam = webcam();
% frame = snapshot(cam);
% imshow(frame);
% set(gcf,'Units','normalized')
% k = waitforbuttonpress;
% rect_pos = rbbox;
% count = 0;
% while(true)
pause(3);
    I = snapshot(cam);
%     web('http://localhost/image.php');
%     I = imread('VRlab.jpg');
    I1 = rgb2gray(I);
    bbox1 = FaceDetector.step(I1);
    for i=1:size(bbox1,1)
        y1 = bbox1(i,1)-20;
        x1 = bbox1(i,2)-20;
        y2 = bbox1(i,3)+50;
        x2 = bbox1(i,4)+50;
        
%         x(i) = floor((2*y1+y2)/2);
%         y(i) = floor((2*x1+x2)/2);
        I1(x1:x1+x2,y1:y1+y2) = zeros(x2+1,y2+1);
    end
    bbox2 = HeadDetector.step(I1);    %to detect faces
    bbox = vertcat(bbox1,bbox2);
%     A = insertObjectAnnotation(I,'rectangle',bbox,'Pramod');
    figure;imshow(I);
    hold on;
    Im1 = imresize(Im,5*size(Im,1)/y2);
    alpha = imresize(alpha,5*size(Im,1)/y2);
    x = linspace(y1,y1+y2,size(Im1,2));
    y = linspace(x1-50,x1+x2+20,size(Im1,1));
    f = imagesc(x,y,Im1);
    set(f,'AlphaData',alpha);
%     count = count+1;
    % annotation('rectangle',rect_pos,'Color','red');
% end