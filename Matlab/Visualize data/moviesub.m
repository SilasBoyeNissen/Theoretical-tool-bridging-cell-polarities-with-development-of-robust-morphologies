function moviesub(AL, ax, az, el, fig, FS, p)
N = size(p, 1);
set(gcf, 'CurrentAxes', fig(ax));
col = 1-exp(log(1 - 0.85)/(AL/2)*abs(p(:, 2)));
scatter3(p(:, 1)+p(:, 7), p(:, 2)+p(:, 8), p(:, 3)+p(:, 9), 200, [zeros(N, 1) ones(N, 1) 1-col], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3)), hold on;
scatter3(p(:, 1)+p(:, 4), p(:, 2)+p(:, 5), p(:, 3)+p(:, 6), 200, [ones(N, 1) col zeros(N, 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3));
scatter3(p(:, 1), p(:, 2), p(:, 3), 200, [col col ones(N, 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3));
set(gca, 'XTick', -AL:AL/2:AL, 'YTick', -AL:AL/2:AL, 'ZTick', -AL:AL/2:AL, 'FontSize', FS-4);
axis([-AL AL -AL AL -AL AL], 'square');
view(az, el);
grid('off');
box('on');
if ax == 1
    xlabel('x', 'FontSize', FS, 'FontWeight', 'bold');
    zlabel('z', 'FontSize', FS, 'FontWeight', 'bold');
elseif ax == 2
    xlabel('x', 'FontSize', FS, 'FontWeight', 'bold');
    set(fig(ax), 'ZTickLabel', '');
elseif ax == 3
    set(fig(ax), 'ZTickLabel', '');
    text(0, -AL-AL/2, -AL-5, 'x', 'FontSize', FS, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
    text(AL+AL/2, 0, -AL-5, 'y', 'FontSize', FS, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
end