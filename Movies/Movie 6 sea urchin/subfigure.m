function subfigure(ax, fig, p)
a = 20;
siz = 1000;
axes(fig(ax));
N = size(p, 1);
col = 1-exp(log(1 - 0.85)/(a/2)*abs(p(:, 2)));
if ax == 2
    scatter3(p(:, 1) + p(:, 7), p(:, 2) + p(:, 8), p(:, 3) + p(:, 9), siz, [zeros(N, 1) ones(N, 1) 1-col], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3)), hold on;
end
scatter3(p(:, 1) + p(:, 4), p(:, 2) + p(:, 5), p(:, 3) + p(:, 6), siz, [ones(N, 1) col zeros(N, 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3)), hold on;
scatter3(p(:, 1), p(:, 2), p(:, 3), siz, [col col ones(N, 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3));
axis([-a a -a a -a a], 'square');
view(0, 0);
axis('off');