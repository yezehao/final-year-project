function [path] = Association(structure,numframes)
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
                path(3*j-2,i) = x(1);
                path(3*j-1,i) = y(1);
                path(3*j-0,i) = z(1);
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
