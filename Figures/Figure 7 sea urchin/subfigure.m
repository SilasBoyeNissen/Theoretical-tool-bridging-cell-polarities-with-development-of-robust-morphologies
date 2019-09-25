function subfigure(fig, no, t)
a = 24;
siz = 280;
axes(fig(no));
panel = 'ABCDEF';
load(['../../Data/09-13 gast2/data/t' t]);
p(:, 3) = p(:, 3) + 6;
p((p(:, 2) < 0) == 1, :) = [];
col = 1-exp(log(1-0.85)/(a/1.7)*abs(p(:, 2)));
scatter3(p(p(:, 7) ~= 0, 1) + p(p(:, 7) ~= 0, 7), p(p(:, 7) ~= 0, 2) + p(p(:, 7) ~= 0, 8), p(p(:, 7) ~= 0, 3) + p(p(:, 7) ~= 0, 9), siz, [zeros(sum(p(:, 7) ~= 0), 1) ones(sum(p(:, 7) ~= 0), 1) 1-col(p(:, 7) ~= 0, :)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3)); hold on;
scatter3(p(:, 1) + p(:, 4), p(:, 2) + p(:, 5), p(:, 3) + p(:, 6), siz, [ones(size(p, 1), 1) col zeros(size(p, 1), 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3));
scatter3(p(:, 1), p(:, 2), p(:, 3), siz, [col col ones(size(p, 1), 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3));
text(-a+a/4, 0, a-a/40, panel(no), 'FontSize', 24, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
view(0, 0);
axis('off');
axis([-a a -a a -a a], 'equal');