clc; clear; clf; tic;
rep = [824 850 875 900 925 950 975 1000];
pic = [1 3 5 7];
stat = zeros(numel(rep), 3);
pos = [.092 .135 .89 .85];
axs = [0 0.1 0 80];
wid = .88;
subfigure(rep(pic), [65 60 60 60]);

for r = rep
    files = dir(['../../Data/09-29 equal' sprintf('%02d', r) '/data/t*.mat']);
    ts = sort(cellfun(@(s) str2double(strrep(strrep(s, '.mat', ''), 't', '')), {files.name}));
    load(['../../Data/09-29 equal' sprintf('%02d', r) '/data/t' num2str(ts(end))]);
    [~, ID] = max(real(acos(p(:, 4:6)*p(:, 4:6)')));
    d = sqrt((p(:, 1) - p(ID, 1)).^2 + (p(:, 2) - p(ID, 2)).^2 + (p(:, 3) - p(ID, 3)).^2)/2;
    stat(find(stat(:, 2) == 0, 1), :) = [(1000-r)/1000*0.5 min(d) max(d)];
end

figure(1); clf;
set(figure(1), 'color', 'w', 'Position', [0, 0, 650, 440]);
axes('Position', pos, 'XTick', [], 'YTick', []);
axis(axs);
for i = pic
    axes('Position', [(stat(i, 1)-axs(1))/(axs(2)-axs(1))*pos(3)-wid/2+pos(1) (mean(stat(i, 2:3))-axs(3))/(axs(4)-axs(3))*pos(4)-wid/2+pos(2) wid wid]);
    imshow([num2str(rep(i)) '.png']);
end
axes('Position', pos);
scatter(stat(:, 1), stat(:, 3), 400, 'o', 'filled', 'MarkerFaceColor', hex2rgb('#3182bd')), hold on;
scatter(stat(:, 1), stat(:, 2), 400, 'o', 'filled', 'MarkerFaceColor', hex2rgb('#9ecae1'));
set(gca, 'Color', 'none', 'FontSize', 18, 'XTick', 0:0.02:0.1, 'YTick', 0:20:100);
legend('Semi-major axis', 'Semi-minor axis', 'Location', 'northwest');
xlabel('Strength of PCP (\lambda_3)', 'FontWeight', 'bold');
ylabel('Length', 'FontWeight', 'bold');
axis(axs);
box('on');

f = gcf; f.PaperSize = [f.PaperPosition(3) f.PaperPosition(4)];
print('figure.pdf', '-dpdf');
toc;