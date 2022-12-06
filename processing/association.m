%% Distance-based Association %%
clear; clc;

load('C:\Users\30348\Documents\final-year-project\data\centroid\2.5_1_1.mat');
numframes = 1495; % the number of frames is 1495

% The loop using distance-base association to associate centroid together
for i = 1:(numframes-1)
    a = structure(i).centroid;
    b = structure(i+1).centroid;
    if isempty(a) == 0 && isempty(b) ==0
        matrix = pdist2(a,b);
        [size_x,size_y] = size(matrix);
        for m = 1:min(size_x, size_y)
            [x,y] = find(min(min(matrix)) == matrix); % find the minimum distance
            associa(i).path(m).centroid = [x,y];
            % replace the colomn of minimum distance with large number
            for j = 1:size_x
                matrix(j,y) = 1000;end
            % replace the row of minimum distance with large number
            for k = 1:size_y    
                matrix(x,k) = 1000;end
        end
    end
    clearvars i j k x y % clear the useless variables
end


% The loop to get the matrix of series of centroid
for i = 1:(numframes-2)
    % start with the first point for further processing
    % need to be modified if multiple vichels need to be attrack
    number = 1; 
    if isempty(associa(i).path) ==0 && isempty(associa(i+1).path) ==0
        A = associa(i).path(number).centroid;
        coordinate(1,i) = structure(i).centroid(A(1),1);
        coordinate(2,i) = structure(i).centroid(A(1),2);

        m = size(associa(i+1).path);
        for n = 1:m(2)
            B = associa(i+1).path(n).centroid;
            if  A(2) == B(1)
                coordinate(1,i+1) = structure(i+1).centroid(B(1),1);
                coordinate(2,i+1) = structure(i+1).centroid(B(1),2);
                number = n;
            end
        end
    end
    clearvars a A b B i m n number % clear the useless variables
end

%% Save the matrix into authorization file
save('C:\Users\30348\Documents\final-year-project\data\authorization\2.5_1_1.mat','coordinate')