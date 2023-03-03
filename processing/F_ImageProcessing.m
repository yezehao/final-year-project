function [centroid] = F_ImageProcessing(videoobj,i)
    % Read in the frames
    frame_1 = rgb2gray(read(videoobj,i));
    frame_2 = rgb2gray(read(videoobj,i+1));
    I = frame_2-frame_1; % Frame Temperal Difference

    % image Processing Version 2
    I_blur = medfilt2(I);                   % Medium Filter
    I_binary = imbinarize(I_blur,0.095);    % Binarization (threshold: 25/256) 
    I_pro = bwareaopen(I_binary,5);         % Remove small components (<5)
    SE1 = strel('diamond',5);               % SE for dilation
    SE2 = strel('square',5);                % SE for opening operation
    I_dilate = imdilate(I_pro,SE1);         % Dilation    
    I_open = imopen(I_dilate,SE2);          % Opening Operation
    [labelpic,num] = bwlabel (I_open,8);    % label 8-NN objects

    % Measure properties of image region
    prop = regionprops(labelpic,"Centroid");
    centroid = zeros(length(prop),2);
    for n = 1:length(prop)
        centroid(n,1) = prop(n).Centroid(1);
        centroid(n,2) = prop(n).Centroid(2);
    end
end