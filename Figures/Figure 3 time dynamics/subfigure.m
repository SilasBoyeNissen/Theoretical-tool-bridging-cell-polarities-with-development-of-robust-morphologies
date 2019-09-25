function subfigure(fig, logt, n, p)
a = 50;
axes(fig(n));
panel = 'ABCDE';
col = 1-exp(log(1-0.85)/(a/2)*abs(p(:,2)));
scatter3(p(:, 1) + p(:, 4), p(:, 2) + p(:, 5), p(:, 3) + p(:, 6), 70, [ones(size(p, 1), 1) col zeros(size(p, 1), 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3)); hold on;
scatter3(p(:, 1), p(:, 2), p(:, 3), 70, [col col ones(size(p, 1), 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3));
text(-a+a/10, 0, a-a/10, panel(n), 'FontSize', 24, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
set(gca, 'XTick', -a:a/2:a, 'ZTick', -a:a/2:a/2, 'FontSize', 24);
xticklabels({'-50', '', '0', '', '50'});
axis([-a a -a a -a a], 'square');
view(0, 0);
grid('off');
box('on');

if n == 1 || n == 3 || n == 5
    zlabel('z', 'FontWeight', 'bold');
    zticklabels({'-50', '', '0', ''});
else
    set(gca, 'ZTickLabel', '');
end

if n == 5
    xlabel('x', 'FontWeight', 'bold');
else
    set(gca, 'XTickLabel', '');
end

if n == 1
    text(a-a/40, 0, a-a/10, 't = 0', 'FontSize', 24, 'HorizontalAlignment', 'right');
	set(gca, 'ZTick', -a:a/2:a, 'FontSize', 24);
    zticklabels({'-50', '', '0', '', '50'});
else
    text(a-a/40, 0, a-a/10, ['log(t) = ' num2str(logt)], 'FontSize', 24, 'HorizontalAlignment', 'right');
end