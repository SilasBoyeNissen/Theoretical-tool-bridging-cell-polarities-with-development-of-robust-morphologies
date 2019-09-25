clc; clear; clf; tic;
AL = 20; % Axis length
FS = 24; % Font size
direc = '../Generate data/output/'; % Where to find the output folder?
video = VideoWriter('video', 'MPEG-4'); % Where to save the movie?
files = dir([direc 't*.mat']);
ts = sort(cellfun(@(s) str2double(strrep(strrep(s, '.mat', ''), 't', '')), {files.name}));
open(video);
for t = ts(1:1:end)
    figure(1); clf;
    set(gcf, 'color', 'w');
    load([direc 't' num2str(t)]);
    set(figure(1), 'Position', [10, 10, 1240, 440]);
    fig = tightsubplot(1, 3, [0 0.025], [0.11 0.015], [0.05 0.02]);
    moviesub(AL, 1, 0, 0, fig, FS, p);
    p((p(:, 2) < 0) == 1, :) = [];
    moviesub(AL, 2, 0, 0, fig, FS, p);
    moviesub(AL, 3, 45, 30, fig, FS, p);
    text(-AL-AL/10, -AL-AL/10, AL+AL/1.6, ['log(t) = ' num2str(round(log10(t), 1))], 'FontSize', FS, 'FontWeight', 'bold');
    writeVideo(video, getframe(gcf));
end
close(video);
toc;