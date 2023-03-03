%% test data generation
clear;clc;
nframes = 100;
for i = 1:nframes
    centroid(1,1) = 100  + 10*i + 7.5*(-0.5 + rand(1,1));
    centroid(1,2) = 100  + 10*i + 7.5*(-0.5 + rand(1,1));
    centroid(2,1) = 100  + 10*i + 7.5*(-0.5 + rand(1,1));
    centroid(2,2) = 1100 - 10*i + 7.5*(-0.5 + rand(1,1));
    centroid(3,1) = 600 +  0*i  + 7.5*(-0.5 + rand(1,1));
    centroid(3,2) = 100 +  10*i + 7.5*(-0.5 + rand(1,1));
    structure(i).centroid = centroid;
end

figure,
for i = 1:nframes-1
    centroid1 = structure(i).centroid;
    centroid2 = structure(i+1).centroid;

    line([centroid1(1,1),centroid2(1,1)],[centroid1(1,2),centroid2(1,2)],"color","r");
    line([centroid1(2,1),centroid2(2,1)],[centroid1(2,2),centroid2(2,2)],"color","g");
    line([centroid1(3,1),centroid2(3,1)],[centroid1(3,2),centroid2(3,2)],"color","b");
end



save('test.mat','structure')
