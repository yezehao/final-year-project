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
run = 0; % represent the program run for the first time
for i = 1:(numframes-3)
    if loop(i) ~= 0 && loop(i) == loop(i+1)
        if run == 0
            p = path(1,i);
            run = 1;            
        else
            p = path(next,i);
        end
        series(i,:) = structure(i).centroid(p,:);
        p = path(2,i);
        next = find(path(:,i+1) == p);
        if isempty(next) == 0
            if nnz(next) == 1
                next = next;
            elseif mod(next(1),2) == 1
                next = next(1);
            else
                next = next(2);
            end
        end
    else
        run = 0;
    end
end




% limit = loop(numframes-2);
% for j = 1:limit
%     % start with the first point for further processing
%     % need to be modified if multiple vichels need to be attrack
%     A = find(loop == j);
%     if isempty(A) ==0
%         for k = 1:(size(path,1)/2)
%             m = path(2*k-1,A(1));
%             for n = 1:length(A)
%                 if m ~= 0
%                     series(1,1) = A(n);
%                     series(1,2) = structure(A(n)).centroid(m,1);
%                     series(1,3) = structure(A(n)).centroid(m,2);
%                     association(j).centroid(n,:) = series;
%                     m = path(2*k,A(n));
%                     path(2*k-1,A(n)) = 0;
%                     path(2*k,A(n)) = 0;
%                 end
%             end
%         end
%     end
% end




% %% Save the matrix into authorization file
% save('association\2.5_1_1.mat','coordinate')