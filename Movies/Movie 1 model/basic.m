clc; clear; clf; tic;
video = VideoWriter('movie', 'MPEG-4');
open(video);
files = dir('../../Data/Model data/data1/t*.mat');
ts = sort(cellfun(@(s) str2double(strrep(strrep(s, '.mat', ''), 't', '')), {files.name}));
for t = ts(1:end)
    figure(1); clf; 
    set(gcf, 'color', 'w');
    set(figure(1), 'Position', [10, 10, 600, 900]);
    fig = tightsubplot(3, 2, [0 0], [0 0], [0 0]);
    subfigure(1, fig, 'Up - up', t);
    subfigure(2, fig, '45^{\circ} - 45^{\circ}', t);
    subfigure(3, fig, 'Up - right', t);
    subfigure(4, fig, 'Up - left', t);
    subfigure(5, fig, 'Six 45^{\circ}', t);
    subfigure(6, fig, '3 up - 3 right', t);
    writeVideo(video, getframe(gcf));
end
close(video);
toc;