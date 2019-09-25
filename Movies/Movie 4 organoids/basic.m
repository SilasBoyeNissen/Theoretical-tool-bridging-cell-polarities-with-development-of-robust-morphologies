clc; clear; clf; tic;
folder = '../../Data/04-10 pro2/data200/';
files = dir([folder 't*.mat']);
ts = sort(cellfun(@(s) str2double(strrep(strrep(s, '.mat', ''), 't', '')), {files.name}));
video = VideoWriter('movie', 'MPEG-4');
video.FrameRate = 1.5;
open(video);
for t = ts([1:5:133 134:end-12])
    figure(1); clf;
    set(gcf, 'color', 'w');
    set(figure(1), 'Position', [10, 10, 900, 900]);
    fig = tightsubplot(2, 2, [0 -0.4], [0 0.09], [-0.25 -0.25]);
    
    a = 33;
    siz = 140;
    load(['../../Data/04-10 pro2/data200/t' num2str(t)]);
    subfigure(a, 1, fig, p, siz);
    text(0, 0, 1.1*a, '(A) Proliferation', 'FontSize', 24, 'HorizontalAlignment', 'center');
    p((p(:, 2) < 0) == 1, :) = [];
    subfigure(a, 3, fig, p, siz);
    
    a = 47;
    siz = 110;
    load(['../../Data/04-10 pres1/data6/t' num2str(t)]);
    subfigure(a, 2, fig, p, siz);
    text(0, 0, 1.1*a, '(B) Pressure', 'FontSize', 24, 'HorizontalAlignment', 'center');
    p((p(:, 2) < 0) == 1, :) = [];
    subfigure(a, 4, fig, p, siz);

    text(-1.52*a, 0, 3.3*a, ['N = ' num2str(t)], 'FontSize', 24, 'FontWeight', 'bold');
    writeVideo(video, getframe(gcf));
end
close(video);
toc;