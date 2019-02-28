clear;clc;close all;
HeadDetector1 = vision.CascadeObjectDetector('Haar.xml','MergeThreshold',6);
HeadDetector = vision.CascadeObjectDetector('Head6.xml');
cam = webcam;
% count = 1;
while(true)
    I = snapshot(cam);
%     web('http://localhost:1234/image.php');
%     I = imread('VRlab.jpg');
    I1 = rgb2gray(I);
%     imagefilename = strcat('E:\Control systems\Control Systems-Practice\Image Processing\MyDataSet\inlabpramod',num2str(count),'.jpg');
%     imwrite(I1,imagefilename);
%     count = count+1;
    bbox1 = HeadDetector1.step(I1);
    for i=1:size(bbox1,1)
        y1 = bbox1(i,1);
        x1 = bbox1(i,2);
        y2 = bbox1(i,3);
        x2 = bbox1(i,4);
        I1(x1:x1+x2,y1:y1+y2) = zeros(x2+1,y2+1);
    end
    bbox2 = HeadDetector.step(I1);
    bbox = vertcat(bbox1,bbox2);
    A = insertObjectAnnotation(I,'rectangle',bbox,'Head');
    imshow(A);
%     fprintf('%d\n',size(bbox,1));
%     count = count+1;
end