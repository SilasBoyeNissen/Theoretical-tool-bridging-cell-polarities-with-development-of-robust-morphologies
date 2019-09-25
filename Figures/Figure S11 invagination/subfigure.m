function subfigure(al, ax, dz, fig, file, siz, t)
load(['../../Data/' file 't' t '.mat']);
p(:, 3) = p(:, 3) + dz;
p((p(:, 2) < 0) == 1, :) = [];
if ax > 4
    p(:, 7:9) = [];
    p((abs(p(:, 1)) > 11) == 1, :) = [];
end
axes(fig(ax));
col = 1-exp(log(1-0.85)/(al/1.5)*abs(p(:, 2)));
if size(p, 2) > 9
    scatter3(p(p(:, 7) ~= 0, 1) + p(p(:, 7) ~= 0, 7), p(p(:, 7) ~= 0, 2) + p(p(:, 7) ~= 0, 8), p(p(:, 7) ~= 0, 3) + p(p(:, 7) ~= 0, 9), siz, ...
        [zeros(sum(p(:, 7) ~= 0), 1) ones(sum(p(:, 7) ~= 0), 1) 1-col(p(:, 7) ~= 0, :)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3)); hold on;
end
scatter3(p(:, 1) + p(:, 4), p(:, 2) + p(:, 5), p(:, 3) + p(:, 6), siz, [ones(size(p, 1), 1) col zeros(size(p, 1), 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3)); hold on;
scatter3(p(:, 1), p(:, 2), p(:, 3), siz, [col col ones(size(p, 1), 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3));
view(0, 0);
axis([-al al -al al -al al], 'equal');
axis('off');