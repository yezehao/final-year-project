filename = 'movie.avi';
vidObj = VideoWriter(filename);
vidObj.FrameRate = 5;
open(vidObj);

scrsz = get(groot,'ScreenSize');
hFig1 = figure('units','normalized','outerposition',[0 0 1 1]);
hAx = axes('parent', hFig1);

N_frames = 100;

for index = 1:N_frames
% Generate figure here and loop



% Output to Video (if required)
if (videoFlag == 1)
    currFrame = getframe(hAx);
    writeVideo(vidObj,currFrame);
end

end

% Close the video, if generated.
if (videoFlag == 1)
    close(vidObj);
end