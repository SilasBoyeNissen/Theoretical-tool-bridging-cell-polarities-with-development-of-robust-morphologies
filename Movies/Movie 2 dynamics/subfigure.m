function subfigure(a, ax, az, el, fig, FS, p)
axes(fig(ax));
col = 1-exp(log(1 - 0.85)/(a/2)*abs(p(:, 2)));
scatter3(p(:, 1) + p(:, 4), p(:, 2) + p(:, 5), p(:, 3) + p(:, 6), 100, [ones(size(p, 1), 1) col zeros(size(p, 1), 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3)), hold on;
scatter3(p(:, 1), p(:, 2), p(:, 3), 100, [col col ones(size(p, 1), 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3));
set(gca, 'XTick', -a:a:a, 'YTick', -a:a:a, 'ZTick', -a:a:a, 'FontSize', FS-4);
axis([-a a -a a -a a], 'square');
view(az, el);
grid('off');
box('on');
if ax == 1
    xlabel('x', 'FontSize', FS, 'FontWeight', 'bold');
    zlabel('z', 'FontSize', FS, 'FontWeight', 'bold');
elseif ax == 2
    xlabel('x', 'FontSize', FS, 'FontWeight', 'bold');
    set(fig(ax), 'ZTickLabel', '');
else
    set(fig(ax), 'ZTickLabel', '');
    text(0, -a-a/2, -a-5, 'x', 'FontSize', FS, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
    text(a+a/2, 0, -a-5, 'y', 'FontSize', FS, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
end