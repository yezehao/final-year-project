function [centroid] = F_ImageProcessing(videoobj,i)
    % Read in the frames
    frame_1 = rgb2gray(read(videoobj,i));
    frame_2 = rgb2gray(read(videoobj,i+1));
    % Frame Temperal Difference
    I = frame_2-frame_1;% get the substration of frames

%    % Image Processing 
%    % Read in the frames
%    frame_1 = rgb2gray(read(videoobj,i));
%    frame_2 = rgb2gray(read(videoobj,i+1));
%    I = frame_2-frame_1;% get the substration of frames
%     
%    % image Processing Version_1 
%    SE1 = strel('diamond',4); % construct SE1 for dilation
%    I_dilation = imdilate(I,SE1); % use dilation to expand the object
%    I_pre = imbinarize(I_dilation,0.05); % convert grayscale image into binary image
%    SE2 = strel('diamond',2); % construct SE2 for erosion
%    I_binary = imerode(I_pre,SE2);
%    I_pro = bwareaopen(I_binary,30); % delete the obj smaller than 30 pixels

    % Image Processing Version_2
    I_blur = medfilt2(I);               % apply medium filter to the image
    I_binary = imbinarize(I_blur,0.03); % convert grayscale image into binary image
    SE1 = strel('diamond',1);           % construct SE1 for opening operation
    I_open = imopen(I_binary,SE1);      % use opening operation to remove burrs
    SE2 = strel('diamond',1);           % construct SE2 for erosion
    I_erode = imerode(I_open,SE2);      % use erosion to shrink objects in an appropriate amount
    I_pro = bwareaopen(I_binary,5);     % delete the obj smaller than 5 pixels
    [labelpic,num] = bwlabel (I_pro,4); % label the objects

    % Region Centroid
    prop = regionprops(labelpic,"Centroid"); % get the centroid coordinates
    m = size(prop);
    centroid = zeros(m(1),2);
    for n = 1:m(1)
        centroid(n,1) = prop(n).Centroid(1);
        centroid(n,2) = prop(n).Centroid(2);
    end

end