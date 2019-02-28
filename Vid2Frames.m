clear;clc;
vid = vision.VideoFileReader('TownCentreXVID.avi','ImageColorSpace','Intensity','VideoOutputDataType','uint8');
count = 1;
next = 0;
while ~isDone(vid)
     frame  = step(vid);
     if mod(next,100)==0
         frame = imadjust(frame);
         imagefilename = strcat('E:\Control systems\Control Systems-Practice\Image Processing\MyDataSet\ ',num2str(count),'.jpg');
         imwrite(frame,imagefilename);
         count = count+1;
     end
     next = next+1;
end