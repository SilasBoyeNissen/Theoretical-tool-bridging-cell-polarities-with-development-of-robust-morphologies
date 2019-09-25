clc; clear; clf; tic;
folder = '../../Data/June 1 noiseE-4/data/';
files = dir([folder 't*.mat']);
ts = sort(cellfun(@(s) str2double(strrep(strrep(s, '.mat', ''), 't', '')), {files.name}));
load([folder 't' num2str(ts(end))]);
NB = zeros(460, 3);
E = zeros(460, 3);
n = 1;
for t = ts(2:461)
    load([folder 't' num2str(t)]);
    E(n, :) = [log10((t+1)/10) mean(p(:, end-1)) std(p(:, end-1))];
    NB(n, :) = [log10((t+1)/10) mean(p(:, end)) std(p(:, end))];
    n = n + 1;
end
save('energy', 'E');
save('neighbor', 'NB');
figure(1); clf;
set(figure(1), 'Position', [0, 0, 700, 700]);
loadfigureTalk(folder);
text(149, 0, 45, 'Energy', 'Color', hex2rgb('#08519c'), 'FontSize', 24, 'HorizontalAlignment', 'right');
text(55, 0, 45, 'F', 'FontSize', 24, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
text(61, 0, 45, 'Neighbor', 'Color', hex2rgb('#de2d26'), 'FontSize', 24);
f = gcf; f.PaperSize = [f.PaperPosition(3) f.PaperPosition(4)];
print('figureTalk.pdf', '-dpdf');
toc;