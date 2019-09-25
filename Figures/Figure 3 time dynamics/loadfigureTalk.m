function loadfigureTalk(folder)
fig = tightsubplot(1, 1, [0 0], [0.01 0.01], [0.01 0.01]);
ts = {'t0', 't10000', 't100000', 't1000000'};
%for i = 1:size(ts, 2)
%    load([folder ts{i}]);
%    p((p(:, 2) < 0) == 1, :) = [];
%    subfigure(fig, i+1, i, p);
%end
load([folder 't1000000']);
axes(fig(1));
load('neighbor', 'NB');
fill([NB(:, 1)', fliplr(NB(:, 1)')], [smooth(NB(:, 2)-NB(:, 3), 10)', fliplr(smooth(NB(:, 2)+NB(:, 3), 10)')], hex2rgb('#fc9272'), 'EdgeColor', 'none', 'FaceAlpha', 0.5); hold on;
scatter(NB(:, 1), NB(:, 2), 1000, 'r.', 'MarkerEdgeColor', hex2rgb('#de2d26'));
yticklabels({'', '', '', '', '', '', '', '', '', '', ''});
%ylabel('Neighbor');
yyaxis right;
load('energy', 'E');
fill([E(:, 1)', fliplr(E(:, 1)')], [smooth(E(:, 2)-E(:, 3), 10)', fliplr(smooth(E(:, 2)+E(:, 3), 10)')], hex2rgb('#6baed6'), 'EdgeColor', 'none', 'FaceAlpha', 0.5);
scatter(E(:, 1), E(:, 2), 1000, 'b.', 'MarkerEdgeColor', hex2rgb('#08519c'));
xticklabels({'', '', '', '', '', '', ''});
yticklabels({'', '', '', '', '', '', '', '', ''});
set(gca, 'XTick', -1:5, 'FontSize', 24, 'LineWidth', 3);
%xlabel('log(t)', 'FontWeight', 'bold');
%ylabel('Energy');
axis([-1 5.2 -4 4], 'square');
%scatter(4.9, -3.35, 200, hex2rgb('#fec44f'), 'filled', 'LineWidth', 0.01, 'MarkerEdgeColor', 'k');
%text(5.75, -2, '-2', 'Color', hex2rgb('#08519c'), 'FontSize', 24, 'HorizontalAlignment', 'right');
%text(5.75, 0, '0', 'Color', hex2rgb('#08519c'), 'FontSize', 24, 'HorizontalAlignment', 'right');
%text(5.75, 2, '2', 'Color', hex2rgb('#08519c'), 'FontSize', 24, 'HorizontalAlignment', 'right');
%text(5.9, -2.95, '-3.1', 'Color', hex2rgb('#08519c'), 'FontSize', 17, 'HorizontalAlignment', 'right');
%text(5.9, -3.35, '-3.2', 'Color', hex2rgb('#08519c'), 'FontSize', 17, 'HorizontalAlignment', 'right');
ax = gca; ax.YColor = 'k';
yyaxis left;
%set(fig(1), 'YTickLabel', '');
%for i = 6:2:12
%    text(-0.9-0.65, i, num2str(i), 'Color', hex2rgb('#de2d26'), 'FontSize', 24);
%end
ax = gca; ax.YColor = 'k';
%subfigure(fig, 5, 5, p);