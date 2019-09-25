function subfigure(al, ax, fig, file, panX, panZ, siz, txt, txtX, txtZ)
load(['../../Data/' file]);
axes(fig(ax));
panel = 'ABCDEF';
p(:, 3) = p(:, 3) + 7;
col = 1-exp(log(1-0.85)/(al/1.6)*abs(p(:, 2)));
scatter3(p(:, 1) + p(:, 4), p(:, 2) + p(:, 5), p(:, 3) + p(:, 6), siz, [ones(size(p, 1), 1) col zeros(size(p, 1), 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3)); hold on;
scatter3(p(:, 1), p(:, 2), p(:, 3), siz, [col col ones(size(p, 1), 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3));
text(panX, 0, panZ, panel(ax), 'FontSize', 30, 'FontWeight', 'bold');
text(txtX, 0, txtZ, txt, 'FontSize', 30);
axis([-al al -al al -al al], 'square');
axis('off');
view(0, 0);