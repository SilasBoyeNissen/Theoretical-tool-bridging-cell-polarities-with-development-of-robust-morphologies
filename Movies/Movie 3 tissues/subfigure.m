function subfigure(ax, dic, fig, txt, t)
load(['/Users/Silas/Desktop/top/07-27 ' dic 'Fix/data/t' num2str(t)]);
p((p(:, 2) < 0) == 1, :) = [];
panel = 'ABCD';
a = 70;
siz = 70;
axes(fig(ax));
N = size(p, 1);
col = 1-exp(log(1-0.85)/(a/2)*abs(p(:, 2)));
scatter3(p(:, 1) + p(:, 4), p(:, 2) + p(:, 5), p(:, 3) + p(:, 6), siz, [ones(N, 1) col zeros(N, 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3)), hold on;
scatter3(p(:, 1), p(:, 2), p(:, 3), siz, [col col ones(N, 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3));
text(-12, -12, 96, panel(ax), 'FontSize', 20, 'FontWeight', 'bold');
text(-6, -6, 96, [txt ' symmetry'], 'FontSize', 20);
axis([-a a -a a -a a], 'square');
view(45, 30);
axis('off');