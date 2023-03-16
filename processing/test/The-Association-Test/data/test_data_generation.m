%% test data generation
clear;clc;

%% Test data for simple association
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

figure, grid on % Plot figure
for i = 1:nframes-1
    centroid1 = structure(i).centroid;
    centroid2 = structure(i+1).centroid;

    line([centroid1(1,1),centroid2(1,1)],[centroid1(1,2),centroid2(1,2)],"color","r");
    line([centroid1(2,1),centroid2(2,1)],[centroid1(2,2),centroid2(2,2)],"color","g");
    line([centroid1(3,1),centroid2(3,1)],[centroid1(3,2),centroid2(3,2)],"color","b");
end

save('test_data_non_empty.mat','structure') % save the data 


%% Test data for complex association
clear;clc;
for i = 4:16
    structure(i).centroid = [10*i+ 7*(-0.5 + rand(1,1)) 10*i+ 7*(-0.5 + rand(1,1))];
end
for i = 17:29
    structure(i).centroid = [10*i+ 7*(-0.5 + rand(1,1)) 10*i+ 7*(-0.5 + rand(1,1));
                             10*i+ 7*(-0.5 + rand(1,1)) 100+10*i+ 7*(-0.5 + rand(1,1))];
end
for i = 30:42
    structure(i).centroid = [10*i+ 7*(-0.5 + rand(1,1)) 100+10*i+ 7*(-0.5 + rand(1,1))];
end
for i = 48:50
    structure(i).centroid = [10*i+ 7*(-0.5 + rand(1,1)) 10*i+ 7*(-0.5 + rand(1,1))];
end

figure, grid on % Plot figure
for i = 4:28
    L11 = structure(i).centroid(1,:);
    L12 = structure(i+1).centroid(1,:);
    line([L11(1),L12(1)],[L11(2),L12(2)],"color","c")
end
for i = 17:28
    L11 = structure(i).centroid(2,:);
    L12 = structure(i+1).centroid(2,:);
    line([L11(1),L12(1)],[L11(2),L12(2)],"color","b")
end
for i = 30:41
    L11 = structure(i).centroid(1,:);
    L12 = structure(i+1).centroid(1,:);
    line([L11(1),L12(1)],[L11(2),L12(2)],"color","b")
end
for i = 48:49
    L11 = structure(i).centroid(1,:);
    L12 = structure(i+1).centroid(1,:);
    line([L11(1),L12(1)],[L11(2),L12(2)],"color","c")
end

hold on % Hold on to generate the  result of testing
save('test_data_empty.mat','structure')