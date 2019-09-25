clc; clear; clf; tic;
files = dir('../../Data/June 1 noiseE-4/data/t*.mat');
ts = sort(cellfun(@(s) str2double(strrep(strrep(s, '.mat', ''), 't', '')), {files.name}));
video = VideoWriter('movie', 'MPEG-4');
video.FrameRate = 10;
open(video);
a = 50;
FS = 24;
for t = ts(1:end)
    figure(1); clf;
    set(figure(1), 'color', 'w', 'Position', [10, 10, 1240, 440]);
    fig = tightsubplot(1, 3, [0 0.025], [0.11 0.015], [0.05 0.02]);
    load(['../../Data/June 1 noiseE-4/data/t' num2str(t)]);
    subfigure(a, 1, 0, 0, fig, FS, p);
    text(-a+a/10, 0, a-a/10, 'A', 'FontSize', FS, 'HorizontalAlignment', 'center');
    p((p(:, 2) < 0) == 1, :) = [];
    subfigure(a, 2, 0, 0, fig, FS, p);
    text(-a+a/10, 0, a-a/10, 'B', 'FontSize', FS, 'HorizontalAlignment', 'center');
    subfigure(a, 3, 45, 30, fig, FS, p);
    text(-a-6, -a-6, a+a/1.6, ['log(t) = ' num2str(round(log10((t+1)/10), 1))], 'FontSize', FS, 'FontWeight', 'bold');
    text(-a+a/14, a-a/4, a-a/8, 'C', 'FontSize', FS, 'HorizontalAlignment', 'center');
    writeVideo(video, getframe(gcf));
end
close(video);
toc;