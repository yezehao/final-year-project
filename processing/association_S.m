%% Distance-based Association
clear; clc;
load('centroid\2.5_1_1.mat');
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
            if min(min(matrix)) <= 10
                z = x; z(:,1) = loopnum;
                path(3*j-2) = x;
                path(3*j-1) = y;
                path(3*j-0) = z;
                % replace the colomn of minimum distance with large number
                for m = 1:size_x
                    matrix(m,y) = 10000;end
                % replace the row of minimum distance with large number
                for n = 1:size_y    
                    matrix(x,n) = 10000;end
            else
                loopnum = loopnum+1;
            end
        end
    end
end

% clear the useless variables
clearvars loopnum a b size_x size_y m 
clearvars x y z i j k

% %% The loop to get the matrix of series of centroid
% for i = 1:(numframes-3)
%     % start with the first point for further processing
%     % need to be modified if multiple vichels need to be attrack
%     limit = size(associa(i).path);
%     for j = 1:limit(2) 
%         if isempty(associa(i).path) == 0 && isempty(associa(i+1).path) == 0
%             number = j;
%             A = associa(i).path(number).centroid;
%             coordinate(3*j-2,i) = structure(i).centroid(A(1),1);
%             coordinate(3*j-1,i) = structure(i).centroid(A(1),2);
%             coordinate(3*j,i) = A(3);
%             m = size(associa(i+1).path);
%             for n = 1:m(2)
%                 B = associa(i+1).path(n).centroid;
%                 if  A(2) == B(1) && A(3) == B(3)
%                     coordinate(1,i+1) = structure(i+1).centroid(B(1),1);
%                     coordinate(2,i+1) = structure(i+1).centroid(B(1),2);
%                     coordinate(3,i+1) = B(3);
%                     number = n;
%                 end
%             end
%         end
%     end
% end
% 
% % clear the useless variables
% clearvars A B i j m n number limit 
% 
% 
% %% Save the matrix into authorization file
% save('association\2.5_1_1.mat','coordinate')