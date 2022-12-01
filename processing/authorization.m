%% Distance-based Authorization %%
clear; clc;

load('D:\research\final-year-project\data\process_result\2.5_1_1.mat');
numframes = 1495; % the number of frames is 1495

% The loop to rearrange the structure of data
for i = 1:numframes

    m = size(structure(i).centroid); % get the number of centroid
    centroid = zeros(m(1), 2); % create the zero matrix for centroid

    for n = 1:m(1)

        x_coordinate = structure(i).centroid(n).Centroid(1);
        y_coordinate = structure(i).centroid(n).Centroid(2);
        centroid(n,1) = x_coordinate;
        centroid(n,2) = y_coordinate;

    end
    clearvars n m % clear the useless variables
    s(i).centroid = centroid;
end

% The loop using distance-base authorization to associate centroid together
for i = 1:(numframes-1)
    a = s(i).centroid;
    b = s(i+1).centroid;
    if isempty(a) == 0 && isempty(b) ==0
        matrix = pdist2(a,b);
        [size_x,size_y] = size(matrix);
        for m = 1:min(size_x, size_y)
            [x,y] = find(min(min(matrix)) == matrix); % find the minimum distance
            authori(i).path(m).centroid = [x,y];
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
    if isempty(authori(i).path) ==0 && isempty(authori(i+1).path) ==0
        A = authori(i).path(number).centroid;
        coordinate(i,1) = structure(i).centroid(A(1)).Centroid(1);
        coordinate(i,2) = structure(i).centroid(A(1)).Centroid(2);

        m = size(authori(i+1).path);
        for n = 1:m(2)
            B = authori(i+1).path(n).centroid;
            if  A(2) == B(1)
                coordinate(i+1,1) = structure(i+1).centroid(B(1)).Centroid(1);
                coordinate(i+1,2) = structure(i+1).centroid(B(1)).Centroid(2);
                number = n;
            end
        end
    end
    clearvars a A b B i m n number % clear the useless variables
end

%% Save the structure into preprocessing file
save('D:\research\final-year-project\data\authorization\2.5_1_1.mat','coordinate')