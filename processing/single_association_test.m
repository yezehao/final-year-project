%% This programme is used for testing %%
clear; clc;

load('C:\Users\30348\OneDrive\桌面\final-year-project\data\centroid\2.5_1_1.mat');
video = VideoReader('C:\Users\30348\OneDrive\桌面\final-year-project\data\video\2.5_1_1.mp4');
y = 1;xk = [0;0];

%% The loop using distance-base association to associate centroid together
for i = 55:85
     a = structure(i).centroid;
     b = structure(i+1).centroid;
     if isempty(a) == 0 && isempty(b) ==0 % The two series of centroid cannot be empty
        matrix1 = pdist2(a,b);
        [x,y] = find(min(matrix1(y,:)) == matrix1); % find the minimum distance
        m = a(x,:);
        xk = kalmanfilter(m);
        single(1,i) = m(1);
        single(2,i) = m(2);
        single(3,i) = xk(1);
        single(4,i) = xk(2);
     end
end

for i = 86:90
    single(3,i) = xk(1);
    single(4,i) = xk(2);
end

% clear useless variables
clearvars a b i m matrix1 matrix2 x xk y

% Save the state matrix into state file
save('C:\Users\30348\OneDrive\桌面\final-year-project\data\single-association\2.5_1_1.mat','single')


%% Video Maker
for i = 50:90
    frame = rgb2gray(read(video,i));
    figure;
    imshow(frame)
    hold on;
    x = single(:,i);
    plot(x(1), x(2), 'mx');
    plot(x(3), x(4), 'bx')
    path = ['C:\Users\30348\OneDrive\桌面\final-year-project\result\single-vehicle(no-github)\' num2str(i) '.jpg'];
    saveas(gcf,path)
    close;
end

% write blank video
provideo=VideoWriter('C:\Users\30348\OneDrive\桌面\final-year-project\result\single-vehicle(no-github)');
endFrame = 36; % The end frames
provideo.FrameRate = 3; % fps = 3
open(provideo); % Open file for writing video data
% imread image from result
for i= 55:90
    frames = imread(['C:\Users\30348\OneDrive\桌面\final-year-project\result\single-vehicle(no-github)\',num2str(i),'.jpg']);
    writeVideo(provideo,frames);
end
close(provideo);



% %% This is test whether the function work
% for i = 1:10
% xm = i*10;ym = i*10+1;
% [xl,yl] = kalmanfilter(xm,ym);
% coordinate(1,i) = xm;
% coordinate(2,i) = ym;
% coordinate(3,i) = xl;
% coordinate(4,i) = yl;
% end