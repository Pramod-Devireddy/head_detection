clear;clc;close all;
allfiles = dir('E:\Control systems\Control Systems-Practice\Image Processing\Forppt');
allnames = {allfiles.name}';
montage(allnames(3:26), 'Size', [4 6]);
% for i=1:size(allnames,1)-2
%     I = imread(char(allnames(i+2)));
% %     imageFilename = char(allnames(i+2));
% I = imresize(I,[256,256]);
%     imwrite(I,strcat(num2str(i),'.jpg'))
% end