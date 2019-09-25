function subfigure(ax, t)
a = 52;
ang = 0.205;
panel = 'ABCD';
figure(1); clf;
set(figure(1), 'color', 'w', 'Position', [10, 10, 450, 700]);
load(['../../Data/08-01 tube/dataCyst2/t' num2str(t) '.mat']);
p(:, 1:3) = ([1 0 0; 0 cos(ang) -sin(ang); 0 sin(ang) cos(ang)]*p(:, 1:3)')';
p(:, 4:6) = ([1 0 0; 0 cos(ang) -sin(ang); 0 sin(ang) cos(ang)]*p(:, 4:6)')';
p(:, 7:9) = ([1 0 0; 0 cos(ang) -sin(ang); 0 sin(ang) cos(ang)]*p(:, 7:9)')';
if mod(ax, 2) == 0
    p((p(:, 2) < 0) == 1, :) = [];
end
col = 1-exp(log(1-0.85)/(a/4)*abs(p(:, 2)));
axes(tightsubplot(1, 1, [0 0], [0 0], [-0.25 -0.25]));
scatter3(p(:, 1) + p(:, 4), p(:, 2) + p(:, 5), p(:, 3) + p(:, 6), 250, [ones(size(p, 1), 1) col zeros(size(p, 1), 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3)); hold on;
scatter3(p(:, 1), p(:, 2), p(:, 3), 250, [col col ones(size(p, 1), 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3));
view(0, 0);
axis('off');
axis([-a a -a a -a a], 'equal');
f = gcf; f.PaperSize = [f.PaperPosition(3) f.PaperPosition(4)];
print(['figure' panel(ax) '.pdf'], '-dpdf');