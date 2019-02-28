clear;clc;close all;
I = imread('ppt.jpg');
I = rgb2gray(I);
I1 = imresize(I,[256,256]);
I1 = imadjust(I1);
figure;imshow(I1);

[Gx, Gy] = imgradientxy(I1);
[Gmag, Gdir] = imgradient(I1);
% figure;imshow(Gx, []);
% figure;imshow(Gy,[]);
% figure;imshow(Gmag,[]);
% figure;imshow(Gdir,[]);

[rows, columns, numberOfColorChannels] = size(I1);
spacing = 32;
for row = 1 : spacing : rows
line([1, columns], [row, row],'Color','r');
end
for column = 1 : spacing  : columns
line([column, column], [1, rows],'Color','r');
end

[F, V] = extractHOGFeatures(I1,'CellSize',[32 32]);
hold on
plot(V,'Color','b');