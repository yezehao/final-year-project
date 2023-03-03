function [A,firstrun] = F_Association(a,b,i,firstrun)
    if isempty(a) == 0 && isempty(b) ==0 % The two series of centroid cannot be empty
        % Calculate the distance among the points
        matrix = pdist2(a,b);
        [size_x,size_y] = size(matrix);
        % Find the points corresponding to the minimum value
        for j = 1:size_x
            [x,y] = find(min(min(matrix)) == matrix); % find the minimum distance
            if min(min(matrix)) <= 50 % The speed of vehicle should within limitation
                A(2*j-1,1) = x(1);
                A(2*j,1) = y(1);
                firstrun(y(1),i+1) = 1; % The 
            else
                firstrun(y(1),i+1) = 0;
            end
            % replace the colomn of minimum distance with large number
            for m = 1:size_x
                matrix(m,y(1)) = 10000;end
            % replace the row of minimum distance with large number
            for n = 1:size_y    
                matrix(x(1),n) = 10000;end
        end
    end
