function subfigure(a, az, el, ex, file, panel, siz, t)
figure(1); clf;
set(figure(1), 'Position', [10, 10, 500, 500]);
load(['../../Data/' file '/data/t' t]);
p((p(:, 2) < 0) == 1, :) = [];
col = 1-exp(log(1-0.85)/(a/2)*abs(p(:, 2)));
axes(tightsubplot(1, 1, [0 0], [ex ex], [ex -0.1]));
scatter3(p(:, 1) + p(:, 4), p(:, 2) + p(:, 5), p(:, 3) + p(:, 6), siz, [ones(size(p, 1), 1) col zeros(size(p, 1), 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3)), hold on;
scatter3(p(:, 1), p(:, 2), p(:, 3), siz, [col col ones(size(p, 1), 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3));
axis([-a a -a a -a a], 'square');
view(az, el);
axis('off');
f = gcf; f.PaperSize = [f.PaperPosition(3) f.PaperPosition(4)];
print(['figure' panel '.pdf'], '-dpdf');