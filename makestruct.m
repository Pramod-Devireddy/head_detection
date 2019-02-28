clear;clc;
data = struct('imageFilename','objectBoundingBoxes');
allfiles = dir('E:\Control systems\Control Systems-Practice\Image Processing\Heads\SideHeads');
allnames = {allfiles.name};
for i=1:size(allnames,2)-2
    I = imread(char(allnames(i+2)));
    if size(size(I),2)==3
        I = rgb2gray(I);
    end
    data(i).imageFilename = strcat('SideHeads/',char(allnames(i+2)));
    data(i).objectBoundingBoxes = [1,1,size(I,2),size(I,1)];
end

negativeFolder = fullfile('E:\background');

% trainCascadeObjectDetector('Head.xml',data,negativeFolder);