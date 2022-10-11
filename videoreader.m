%%  Read the video information
clear; clc;
obj1 =  ... % input the video to make further process
VideoReader('D:\research\final-year-project\data\2.5deg_fov\movie_1_1_AA.mp4');
frame1 = read(obj1,1);
