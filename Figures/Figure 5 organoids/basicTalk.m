clc; clear; close all; tic;
figure(1); clf;
set(figure(1), 'Position', [0 0 1000 500]);
proV = [10000 5000 2000 1000 500];
ts = [8000 12000 16000];
ax1 = [-0.5 6.5 0 30];
ax2 = [0.0001 0.0035 0 30];
ax2l = [log10(ax2(1)) log10(ax2(2)) 0 30];
FS = 22;
Yti = 0:10:30;
wid = 0.35;
preV = 0:6;
xLen = 0.455;
yPos = 0.155;
yLen = 0.83;
genT = 1./(proV*log(2))';
genL = log10(genT);

pos = [.038 yPos xLen yLen];
axes('Color', 'none', 'FontSize', FS, 'Position', pos, 'XTick', [], 'YTick', Yti);
load('_data/16000');
yticklabels({'', '', '', ''});
axis(ax2l);
for i = [5 3 1]
    axes('Position', [(genL(i)-ax2l(1))/(ax2l(2)-ax2l(1))*pos(3)-wid/2+pos(1) (sta2(i, 3)-ax2l(3))/(ax2l(4)-ax2l(3))*pos(4)-wid/2+pos(2) wid wid]);
    imshow(['04-10 pro3-' num2str(proV(i)) '.png']);
end

axes('Position', pos);
col = {'#c6dbef', '#6baed6', '#2171b5'};
for ti = 3%1:size(ts, 2)
    load(['_data/' num2str(ts(ti))]);
    scatter(genT, sta2(1:size(proV, 2), 3), 100, 'o', 'filled', 'MarkerFaceColor', hex2rgb(col{ti})); hold on;
    fill([genT', fliplr(genT')], [(sta2(1:size(proV, 2), 3)-sta2(1:size(proV, 2), 4))', fliplr((sta2(1:size(proV, 2), 3)+sta2(1:size(proV, 2), 4))')], hex2rgb(col{ti}), 'EdgeColor', 'none', 'FaceAlpha', .3);
end
%legend(findobj(gca, 'Type', 'scatter'), '16000 cells', '12000 cells', '8000 cells', 'Location', 'northwest');
%text(7e-4, 28.5, 'A', 'FontSize', FS, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
set(gca, 'Box', 'on', 'Color', 'none', 'FontSize', FS, 'LineWidth', 3, 'XScale', 'log', 'YTick', Yti);
%xlabel('1/(generation time) (1/t_G)', 'FontWeight', 'bold');
%ylabel('# Local minima', 'FontWeight', 'bold');
xticklabels({'', ''});
yticklabels({'', '', '', ''});
axis(ax2);

pos = [.493 yPos xLen yLen];
axes('Color', 'none', 'FontSize', FS, 'Position', pos, 'XTick', [], 'YTick', []);
load('_data/16000');
axis(ax1);
for i = 1:3:7
    axes('Position', [(i-1-ax1(1))/(ax1(2)-ax1(1))*pos(3)-wid/2+pos(1) (sta1(i, 3)-ax1(3))/(ax1(4)-ax1(3))*pos(4)-wid/2+pos(2) wid wid]);
    imshow(['04-10 pres1-' num2str(preV(i)) '.png']);
end

axes('Color', 'none', 'Position', pos);
for ti = 3%1:size(ts, 2)
    load(['_data/' num2str(ts(ti))]);
    scatter(preV', sta1(:, 3), 100, 'o', 'filled', 'MarkerFaceColor', hex2rgb(col{ti})); hold on;
    fill([preV, fliplr(preV)], [(sta1(:, 3)-sta1(:, 4))', fliplr((sta1(:, 3)+sta1(:, 4))')], hex2rgb(col{ti}), 'EdgeColor', 'none', 'FaceAlpha', .3);
end
%legend(findobj(gca, 'Type', 'scatter'), '16000 cells', '12000 cells', '8000 cells', 'Color', 'none', 'Location', 'northeast');
%text(3, 28.5, 'B', 'FontSize', FS, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
set(gca, 'Box', 'on', 'Color', 'none', 'FontSize', FS, 'LineWidth', 3, 'XTick', 0:2:6, 'YTick', Yti);
%xlabel('Pressure (P)', 'FontWeight', 'bold');
xticklabels({'', '', '', ''});
yticklabels({'', '', '', ''});
axis(ax1);

pos = [.038 yPos xLen yLen];
axes('Color', 'none', 'FontSize', FS, 'LineWidth', 3, 'Position', pos, 'XScale', 'log', 'YTick', Yti);
xticklabels({'', ''});
yticklabels({'', '', '', ''});
axis(ax2);

f = gcf; f.PaperSize = [f.PaperPosition(3) f.PaperPosition(4)];
print('figureTalk.pdf', '-dpdf');
toc;