function subfigure(pol, pos)
yLi = 0.25;
pan = 'AB';
xLi = [20 pi];
xSt = [5 pi/4];
figure(1); clf;
mat = {pos pol};
xTe = {'Distance', 'Angle'};
his = {[0:19 100] 0:pi/20:pi};
set(figure(1), 'Position', [0, 0, 650, 650]);
fig = tightsubplot(2, 1, [0.1 0.1], [0.085 0.01], [0.1 0.02]);
xTi = {{'0', '5', '10', '15', '20'} {'0', '\pi/4', '\pi/2', '3\pi/4', '\pi'}};
for i = 1:2
    set(gcf, 'CurrentAxes', fig(i));
    histogram([], his{i}, 'EdgeColor', 'k', 'FaceAlpha', 0.5, 'FaceColor', hex2rgb('#4292c6'), 'LineWidth', 0.5); hold on;
    histogram([], his{i}, 'EdgeColor', 'k', 'FaceAlpha', 0.5, 'FaceColor', hex2rgb('#f16913'), 'LineWidth', 0.5);
    histogram(mat{i}(:, 1:3), his{i}, 'EdgeColor', 'none', 'FaceAlpha', 0.5, 'FaceColor', hex2rgb('#4292c6'), 'Normalization', 'probability');
    histogram(mat{i}(:, 7:9), his{i}, 'EdgeColor', 'none', 'FaceAlpha', 0.5, 'FaceColor', hex2rgb('#f16913'), 'Normalization', 'probability');
    histogram(mat{i}(:, 1:3), his{i}, 'DisplayStyle', 'stairs', 'EdgeColor', 'k', 'LineWidth', 1, 'Normalization', 'probability');
    histogram(mat{i}(:, 7:9), his{i}, 'DisplayStyle', 'stairs', 'EdgeColor', 'k', 'LineWidth', 1, 'Normalization', 'probability');
    text(xLi(i)/30, 0.93*yLi, pan(i), 'FontSize', 18, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
    [h, p] = kstest2(reshape(mat{i}(:, 1:3), 24000, 1), reshape(mat{i}(:, 7:9), 24000, 1));
    set(gca, 'FontSize', 18, 'XTick', 0:xSt(i):xLi(i), 'YTick', 0:0.05:yLi);
    legend('Vary initial polarity', 'Vary noise seed');
    ylabel('Probability', 'FontWeight', 'bold');
    xlabel(xTe{i}, 'FontWeight', 'bold');
    axis([0 xLi(i) 0 yLi]);
    xticklabels(xTi{i});
end
distance = [reshape(mat{1}(:, 1:3), 24000, 1) reshape(mat{1}(:, 7:9), 24000, 1)];
angle = [reshape(mat{2}(:, 1:3), 24000, 1) reshape(mat{2}(:, 7:9), 24000, 1)];
save('Panel B angle', 'angle');
save('Panel A distance', 'distance');
f = gcf; f.PaperSize = [f.PaperPosition(3) f.PaperPosition(4)];
print('figure.pdf', '-dpdf');