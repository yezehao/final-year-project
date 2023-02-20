%% Distance-based Association
clear; clc;
% % load data in data folder
% cd ..
% currentfolder = pwd;
% cd processing\
% load([currentfolder,'\data\centroid_v2\2.5_1_1.mat']);
load("test\test.mat")
numframes = 1496; % the number of frames is 1495
[path] = Association(structure,numframes);

% %% Save the matrix into authorization file
% save('association\2.5_1_1.mat','coordinate')


%% Distance-based Association With Kalman Filter
clear; clc;
load('centroid_v2\2.5_1_1.mat');
numframes = 1496; % the number of frames is 1495

%% The loop using distance-base association to associate centroid together
loopnum = 1;
for i = 1:(numframes-2)
    a = structure(i).centroid;
    b = structure(i+1).centroid;
    if isempty(a) == 0 && isempty(b) ==0 % The two series of centroid cannot be empty
        % Calculate the distance among the points
        matrix = pdist2(a,b);
        [size_x,size_y] = size(matrix);
        % Find the points corresponding to the minimum value
        for j = 1:(min(size_x, size_y))
            [x,y] = find(min(min(matrix)) == matrix); % find the minimum distance
            if min(min(matrix)) <= 15 % The speed of vehicle should within limitation
                z = x; z(:,1) = loopnum;
                path(2*j-1,i) = x(1);
                path(2*j-0,i) = y(1);
                loop(1,i) = z(1);
                % replace the colomn of minimum distance with large number
                for m = 1:size_x
                    matrix(m,y(1)) = 10000;end
                % replace the row of minimum distance with large number
                for n = 1:size_y    
                    matrix(x(1),n) = 10000;end
            else
                loopnum = loopnum+1;
            end
        end
    end
end

% clear the useless variables
clearvars loopnum a b size_x size_y m n
clearvars x y z i j k

%% The association of the single vehicle
firstrun = 0; % represent the program run for the first time
trackID = 0; % use to label the vehicles that tracking
% The initial state matrix
S = 10^6 * eye(4);
X = [746,1000,0,0]';
for i = 1:(numframes-3)
    if loop(i) ~= 0 && loop(i) == loop(i+1)
        if firstrun == 0 % The beginning of tracking
            % The tracking transfromed to another object and the trackID changed
            trackID = trackID + 1;
            n = path(1,i);
            series(trackID).centroid(:,i) = [structure(i).centroid(n,:)]';
            firstrun = 1;
            n = path(2,i);
        elseif firstrun == 1 % The procedue of tracking
            M = [structure(i).centroid(n,:)]';
            [xk, S, X, firstrun] = kalmanfilter(M, S, X, firstrun);
            series(trackID).centroid(:,i) = xk;
            next = find(path(:,i) == n);
            if mod(next(1),2) == 1
                next = next(1);
            elseif numel(next) == 1
                firstrun = 0;
            else
                next = next(2);
            end
            n = path(next+1,i);
        end
    elseif loop(i) ~= 0 && loop(i) ~= loop(i+1) % The end of tracking
        if firstrun == 0
            % The tracking transfromed to another object and the trackID changed
            trackID = trackID + 1;
            n = path(1,i);
            series(trackID).centroid(:,i) = [structure(i).centroid(n,:)]';
            firstrun = 0;
        elseif firstrun == 1
            M = [structure(i).centroid(n,:)]';
            [xk, S, X, firstrun] = kalmanfilter(M, S, X, firstrun);
            series(trackID).centroid(:,i) = xk;
            firstrun = 0;
        end
    end 
end

% clear the useless variables
clearvars firstrun i n next trackID
clearvars M S X xk


%% Save the matrix into authorization file
save('association\single\2.5_1_1.mat','series')