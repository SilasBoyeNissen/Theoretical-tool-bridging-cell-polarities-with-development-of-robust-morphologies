clc; clear; clf; tic;
folder = '../../Data/09-13 gast2/data/';
files = dir([folder 't*.mat']);
ts = sort(cellfun(@(s) str2double(strrep(strrep(s, '.mat', ''), 't', '')), {files.name}));
video = VideoWriter('movie', 'MPEG-4');
open(video);
for t = ts(1:end)
    figure(1); clf;
    set(gcf, 'color', 'w');
    load([folder 't' num2str(t)]);
    set(figure(1), 'Position', [10, 10, 1000, 500]);
    fig = tightsubplot(1, 2, [0 0], [0 0], [0 0]);
    subfigure(1, fig, p);
    p((p(:, 2) < 0) == 1, :) = [];
    subfigure(2, fig, p);
    text(-19.5, 0, 18, ['t = ' num2str(round(t/10, 1))], 'FontSize', 30, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
    writeVideo(video, getframe(gcf));
end
close(video);
toc;