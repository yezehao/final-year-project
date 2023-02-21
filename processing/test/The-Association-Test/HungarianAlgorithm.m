function [assignment, cost] = HungarianAlgorithm(costMatrix)
    [rowCount, colCount] = size(costMatrix);
    maxCost = max(max(costMatrix));
    
    % Initialize the matrix to keep track of row and column assignments
    assignment = zeros(1, rowCount);
    rowCover = zeros(1, rowCount);
    colCover = zeros(1, colCount);
    zerosFound = zeros(1, rowCount);
    path = zeros(rowCount + colCount, 2);
    starMatrix = zeros(rowCount, colCount);
    
    % Step 1: Subtract the row minimum from each row
    for row = 1 : rowCount
        rowMin = min(costMatrix(row, :));
        costMatrix(row, :) = costMatrix(row, :) - rowMin;
    end
    
    % Step 2: Cover each column that contains a starred zero
    for row = 1 : rowCount
        for col = 1 : colCount
            if (costMatrix(row, col) == 0 && rowCover(row) == 0 && colCover(col) == 0)
                starMatrix(row, col) = 1;
                rowCover(row) = 1;
                colCover(col) = 1;
                break;
            end
        end
    end
    
    % Step 3: Cover each column that does not contain a starred zero and uncover all the rows
    for col = 1 : colCount
        if colCover(col) == 0
            for row = 1 : rowCount
                rowCover(row) = 0;
            end
            break;
        end
    end
    
    % Step 4: Find a starred zero in the uncovered matrix and add it to the path
    pathStart = 0;
    for row = 1 : rowCount
        for col = 1 : colCount
            if (costMatrix(row, col) == 0 && rowCover(row) == 0 && colCover(col) == 0)
                pathStart = row;
                path(1, 1) = row;
                path(1, 2) = col;
                break;
            end
        end
    end
    
    % Step 5: Find the smallest uncovered value and subtract it from each
    % uncovered row and add it to each covered column
    while (pathStart)
        % Find the smallest uncovered value
        minValue = maxCost;
        for row = 1 : rowCount
            for col = 1 : colCount
                if (rowCover(row) == 0 && colCover(col) == 0 && minValue > costMatrix(row, col))
                    minValue = costMatrix(row, col);
                end
            end
        end
    end
        
    % Subtract the minimum uncovered value from each uncovered row and add it to each covered column
    for row = 1 : rowCount
        for col = 1 : colCount
            if (rowCover(row) == 1)
                costMatrix(row, col) = costMatrix(row, col) + minValue;
            end
            if (colCover(col) == 0)
                costMatrix(row, col) = costMatrix(row, col) - minValue;
            end
        end
    end
end