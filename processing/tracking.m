% Initializatoin
clear;clc;
tic; % record the start time
cd ('..'); currentfolder = pwd; cd ('processing\');
path = [currentfolder,'\data\'];
% Data Input
load([path,'centroid\2.5_2.mat']);
numframes = 1495;

%% structure: Track
% The fields of structure array "Track" is shown as follow:
% centroid; kalmanS; kalmanX; label
Track = struct([]);

%% Tracking
% The timestep is represented by i
for i  = 1:numframes
    detection = structure(i).centroid;
    % The number of detection
    if isempty(detection) == 0
        Nd = length(detection(:,1));
    else
        Nd = 0;
    end
    % The number of Tracker
    if isempty(Track) == 0
        Nt = length(Track);
    else
        Nt = 0;
    end

    if Nd == 0 % There is no detection
        if Nt == 0 % Do nothing
            % Nothing should be done if Nt = 0 & Nd = 0
        else % Upate tracking without measurements(prediction)
            for j = 1:Nt
                m = []; % The detection is empty
                S = Track(j).kalmanS;
                X = Track(j).kalmanX;
                [S, X] = F_Kalmanfilter(m, S, X);
                Track(j).centroid(i,1) = X(1,1);
                Track(j).centroid(i,2) = X(2,1);
                Track(j).kalmanS = S;
                Track(j).kalmanX = X;
                if Track(j).delete == 0
                    Track(j).centroid(i,:) = [0,0];
                    Track(j).kalmanX = [X(1,1),X(2,1),0,0]';
                else
                    Track(j).delete = Track(j).delete-1;
                end
            end
        end
    else % There is detection
        if Nt == 0 % Use detection to start tracks
            for j = 1:Nd
                m = detection(j,:); 
                Track(j).centroid(i,:) = m;
                Track(j).kalmanS = 10^6 * eye(4);
                Track(j).kalmanX = [m(1),m(2),0,0]';
                Track(j).delete = 10;
            end
        else % Data associatoin and Kalman filter
            for j = 1:Nt 
                a(j,:) = Track(j).centroid(i-1,:);
            end % The variable "a" contains the centroid of frame (i-1)
            b = detection;% The variable "b" contains the centroid of frame (i)
            % Calculate the distance among the points
            matrix = pdist2(a,b);
            % Find the points corresponding to the minimum value
            A = []; 
            for k = 1:Nd
                [x,y] = find(min(min(matrix)) == matrix); % find the minimum distance
                if min(min(matrix)) <= 60 % The speed of vehicle should within limitation
                    A(k,1) = x(1); A(k,2) = y(1); A(k,3) = 1;
                end
                % replace the colomn of minimum distance with large number
                for m = 1:Nt
                    matrix(m,y(1)) = 10000;end
                % replace the row of minimum distance with large number
                for n = 1:Nd  
                    matrix(x(1),n) = 10000;end
            end

            Nt_s = 1:1:Nt; Nd_s = 1:1:Nd;
            if isempty(A) == 0
                match = length(A(:,1));
                for o = 1:match
                    Nt_s(find(Nt_s==A(o,1)))=[];
                    Nd_s(find(Nd_s==A(o,2)))=[];
                end
            else
                match = 0;
            end
            for t = (match+1):Nt
                A(t,1) = Nt_s(1,t-match);
                A(t,2) = 0;
                A(t,3) = -1;
            end
            for s = (Nt+1):(Nd+Nt-match)
                A(s,1) = s;
                A(s,2) = Nd_s(1,s-Nt);
                A(s,3) = 0;
            end

            % The tracking that need to associate
            for j = 1:length(A(:,1))
                if A(j,3) == 0
                    p = A(j,1);
                    q = A(j,2);
                    m = detection(q,:); 
                    Track(p).centroid(i,:) = m;
                    Track(p).kalmanS = 10^6 * eye(4);
                    Track(p).kalmanX = [m(1),m(2),0,0]';
                    Track(p).delete = 10;
                elseif A(j,3) == -1
                    p = A(j,1);
                    q = A(j,2);
                    m = []; % The detection is empty
                    S = Track(p).kalmanS;
                    X = Track(p).kalmanX;
                    [S, X] = F_Kalmanfilter(m, S, X);
                    Track(p).centroid(i,1) = X(1,1);
                    Track(p).centroid(i,2) = X(2,1);
                    Track(p).kalmanS = S;
                    Track(p).kalmanX = X;
                    if Track(p).delete == 0
                        Track(p).centroid(i,:) = [0,0];
                        Track(p).kalmanX = [X(1,1),X(2,1),0,0]';
                    else
                        Track(p).delete = Track(p).delete-1;
                    end
                else % A(j,3) = 1
                    p = A(j,1);
                    q = A(j,2);
                    m = detection(q,:);
                    S = Track(p).kalmanS;
                    X = Track(p).kalmanX;
                    [S, X] = F_Kalmanfilter(m, S, X);
                    Track(p).kalmanS = S;
                    Track(p).kalmanX = X;
                    Track(p).centroid(i,1) = X(1,1);
                    Track(p).centroid(i,2) = X(2,1);
                    Track(p).delete = 10;
                end
            end
        end
    end
end

%% Save the structure into data file
save([path,'\track\2.5_2.mat'],'Track')

toc % The time for runnning the tracking programme