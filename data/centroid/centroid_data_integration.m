%% Centroid Data Integration
clear;clc;
for i = 1:12
    load(['2.5_1_',num2str(i),'.mat']);
    coordinate(i).centroid = structure;
end
clearvars structure

numframes = 1496;
frame_width = 1496;
frame_length = 2000;

for j = 1:numframes-1
    m = [];
    for i = 1:6
        a = coordinate(i).centroid(j).centroid;
        if isempty(a) == 0
            b = frame_width*(i-1)*ones(length(a),1);
            c = zeros(length(a),1);
            d = [b c];
            e = a + d;
            m = [m;e];
        end
    end
    for i = 7:12
        a = coordinate(i).centroid(j).centroid;
        if isempty(a) == 0
            b = frame_width*(i-7)*ones(length(a),1);
            c = frame_length*ones(length(a),1);
            d = [b c];
            e = a + d;
            m = [m;e];
        end
    end
    structure(j).centroid = m;
end

save('2.5_1.mat','structure')