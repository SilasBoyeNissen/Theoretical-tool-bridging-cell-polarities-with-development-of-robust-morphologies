clc; clear; clf; tic;
video = VideoWriter('movie', 'MPEG-4');
video.FrameRate = 5;
open(video);
files = dir('../../Data/07-27 radOutFix/data/t*.mat');
ts = sort(cellfun(@(s) str2double(strrep(strrep(s, '.mat', ''), 't', '')), {files.name}));
for t = ts(1:end)
    figure(1); clf;
    set(gcf, 'color', 'w');
    set(figure(1), 'Position', [10, 10, 1000, 500]);
    fig = tightsubplot(1, 3, [0 -0.3], [-0.3 -0.15], [-0.15 -0.1]);
    subfigure(1, 'radOut', fig, 'Point', t);
    subfigure(2, 'cylinder', fig, 'Axis', t);
    subfigure(3, 'upDown', fig, 'Plane', t);
    writeVideo(video, getframe(gcf));
end
close(video);
toc;