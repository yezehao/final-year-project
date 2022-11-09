% write blank video
provideo=VideoWriter('D:\research\final-year-project\data\preprossess\');
endFrame = 1495; % The end frames
provideo.FrameRate = 5; % fps = 5
open(provideo); % Open file for writing video data
% imread image from result
for i= 1:endFrame
    frames=imread(['D:\research\final-year-project\data\preprossess\',num2str(i),'.jpg']);
    writeVideo(provideo,frames);
end
close(provideo);

