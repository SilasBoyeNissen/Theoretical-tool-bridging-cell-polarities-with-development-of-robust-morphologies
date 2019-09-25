function subfigure(ax, fig, txt, t)
load(['../../Data/Model data/data' num2str(ax) '/t' num2str(t)]);
p((p(:, 2) < 0) == 1, :) = [];
panel = 'ABCDEF';
a = 6;
axes(fig(ax));
N = size(p, 1);
scatter(p(:, 1) + p(:, 4), p(:, 3) + p(:, 6), 150, [ones(N, 1) zeros(N, 2)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3)), hold on;
scatter(p(:, 1), p(:, 3), 10*150, [zeros(N, 2) ones(N, 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3));
text(-5.2, 5.2, panel(ax), 'FontSize', 20, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
text(0, 5.2, txt, 'FontSize', 20, 'HorizontalAlignment', 'center');
axis([-a a -a a], 'square');
set(gca, 'YTickLabel', '');
axis('on');
grid('off');
box('on');