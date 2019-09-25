clc; clear; clf; tic;
folder = '../../Data/03-05 equal825/data/';
files = dir([folder 't*.mat']);
ts = sort(cellfun(@(s) str2double(strrep(strrep(s, '.mat', ''), 't', '')), {files.name}));
video = VideoWriter('movie', 'MPEG-4');
open(video);
for t = ts(1:end)
    figure(1); clf;
    set(gcf, 'color', 'w');
    load([folder 't' num2str(t)]);
    set(figure(1), 'Position', [10, 10, 500, 500]);
    fig = tightsubplot(1, 2, [0 -0.5], [0 0], [-0.2 -0.2]);
    subfigure(1, fig, p);
    p((p(:, 2) < 0) == 1, :) = [];
    subfigure(2, fig, p);
    text(-60, 0, 87, ['log(t) = ' num2str(round(log10(t/5), 1))], 'FontSize', 20, 'FontWeight', 'bold');
    writeVideo(video, getframe(gcf));
end
close(video);
toc;