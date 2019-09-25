function subfigure(a, ax, fig, p, siz)
axes(fig(ax));
col = 1-exp(log(1 - 0.85)/(a/2)*abs(p(:, 2)));
scatter3(p(:, 1) + p(:, 4), p(:, 2) + p(:, 5), p(:, 3) + p(:, 6), siz, [ones(size(p, 1), 1) col zeros(size(p, 1), 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3)), hold on;
scatter3(p(:, 1), p(:, 2), p(:, 3), siz, [col col ones(size(p, 1), 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3));
axis([-a a -a a -a a], 'square');
view(0, 0);
axis('off');