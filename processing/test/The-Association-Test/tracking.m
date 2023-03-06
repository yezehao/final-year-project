%% Distance-based Association
clear; clc;
% % load data in data folder

load('C:\Users\30348\Desktop\final-year-project\data\centroid\2.5_1_1.mat');

numframes = 1496; % the number of frames is 100

% Initialize Tracking
ff = structure(1).centroid;
if isempty(ff) == 0
    firstrun(:,1) = zeros(length(ff),1);
else
    firstrun(:,1) = -1;
end

% Tracking Procedue
for i = 1:(numframes-1)
    a = structure(i).centroid;
    b = structure(i+1).centroid;

    if isempty(a) == 0 && isempty(b) == 0 % The two series of centroid cannot be empty
        for j = 1:length(a(:,1))
            if firstrun(j,i) == 0
                [A,firstrun] = F_Association(a,b,i,j,firstrun);
                kalman(j).S = 10^6 * eye(4);
                kalman(j).X = [0,0,0,0]';
                association(:,i) = A(:,1);
                track(i).centroid = a;
            elseif firstrun(j,i) == 1
                for k = 1:length(a(:,1))
                    S = kalman(k).S;
                    X = kalman(k).X;
                    m = a(k,:);
                    [mk, S, X] = F_Kalmanfilter(m, S, X);
                    ak(k,:) = mk;
                    kalman(k).S = S;
                    kalman(k).X = X;            
                end
                [A,firstrun] = F_Association(ak,b,i,j,firstrun);
                association(:,i) = A(:,1);
                track(i).centroid = ak;
            end

        end
    elseif isempty(a) == 1 && isempty(b) == 0
        firstrun(:,i+1) = zeros(length(b(:,1)),1);
    else
        firstrun(:,i+1) = -1;
    
    end
end

% clear the useless variables
clearvars a ak m mk b i j k A S X

figure,
for i = 1:numframes-2
    a = track(i).centroid; b = track(i+1).centroid;
    c = structure(i).centroid; d = structure(i+1).centroid;
    line([a(1,1),b(1,1)],[a(1,2),b(1,2)],"color","b")
    line([a(2,1),b(2,1)],[a(2,2),b(2,2)],"color","b")
    line([a(3,1),b(3,1)],[a(3,2),b(3,2)],"color","b")
    line([c(1,1),d(1,1)],[c(1,2),d(1,2)],"color","r")
    line([c(2,1),d(2,1)],[c(2,2),d(2,2)],"color","r")
    line([c(3,1),d(3,1)],[c(3,2),d(3,2)],"color","r")
end
