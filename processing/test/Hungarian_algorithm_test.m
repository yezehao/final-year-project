clear;clc;
load('centroid_v2\2.5_1_1.mat');
i = 1200;
a = structure(i).centroid;
b = structure(i+1).centroid;
matrix = pdist2(a,b);
[x,y] = HungarianAlgorithm(matrix);