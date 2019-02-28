clc;clear;close all;
HeadDetector1 = vision.CascadeObjectDetector('Haar.xml');
HeadDetector = vision.CascadeObjectDetector('Head6.xml');
% path = imgetfile();
% I_org = imread(path);
% cam = webcam;
% pause(3);
% I_org = snapshot(cam);
allfiles = dir('D:\Photos\Ponmudi & Kallar');
allnames = {allfiles.name};
for x = 1:size(allnames,2)-2
    filename = strcat('D:\Photos\Ponmudi & Kallar\',char(allnames(x+2)));
    I_org = imread(filename);
    I = rgb2gray(I_org);
    bbox1 = [];bbox2 = []; bbox = [];
    bbox1 = HeadDetector.step(I);
    for i=1:size(bbox1,1)
        y1 = bbox1(i,1);
        x1 = bbox1(i,2);
        y2 = bbox1(i,3);
        x2 = bbox1(i,4);
        I(x1:x1+x2,y1:y1+y2) = zeros(x2+1,y2+1);
    end
    bbox2 = HeadDetector1.step(I);
    bbox = vertcat(bbox1,bbox2);
    for i=1:size(bbox,1)
        I1 = imcrop(I_org,bbox(i,:));
        imshow(I1);
        imagefilename = strcat('E:\background\False Images\FalseImage',num2str(randi(1000000)),'.jpg');
        imwrite(I1,imagefilename);
    end
end
% clear cam;
% A = insertObjectAnnotation(I_org,'rectangle',bbox,'Head');
% figure;imshow(A);