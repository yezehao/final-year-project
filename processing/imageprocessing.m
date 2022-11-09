clear;
clc;

%% Video tranfrom
obj = imread("D:\research\final-year-project\data\preprossess\1220.jpg");
grayscale = rgb2gray(obj); % convert the image into grayscale image
BW = imbinarize(grayscale,0.05); % convert grayscale image into binary image
pro = bwareaopen(BW,5); % delete the obj smaller than 5 pixels
[labelpic,num] = bwlabel (pro,8); % label the obj

figure
subplot(1,3,1);imshow(obj);
subplot(1,3,2);imshow(BW);
subplot(1,3,3);imshow(pro);

%% Plot
figure,imshow(obj);
for v=1:num
    [r, c]=find(labelpic==v);
    [rectx,recty,area,perimeter]=minboundrect(c,r,'p');
    [length, width] = minboxing(rectx(1:end-1),recty(1:end-1));
    % draw the rectangle
    line(rectx,recty,'color','y','linewidth',2); 
end
path = 'D:\research\final-year-project\result\result1.jpg';
saveas(gcf,path)