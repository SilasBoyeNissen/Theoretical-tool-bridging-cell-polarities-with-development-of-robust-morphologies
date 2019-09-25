function subfigure(rep, siz)
a = 1;
for r = 1:size(rep, 2)
    files = dir(['../../Data/09-29 equal' num2str(rep(r)) '/data/t*.mat']);
    ts = sort(cellfun(@(s) str2double(strrep(strrep(s, '.mat', ''), 't', '')), {files.name}));
    load(['../../Data/09-29 equal' num2str(rep(r)) '/data/t' num2str(ts(end))]);
    figure(2); clf;
    set(figure(2), 'color', 'w', 'Position', [650, 0, 220, 440]);
    a = max(a, max(10, max(max(abs(p(:, 1:3))))+3));
    col = 1-exp(log(1 - 0.85)/(a/5)*abs(p(:, 2)));
    axes(tightsubplot(1, 1, [0 0], [0 0], [-60 -60]));
    scatter3(p(:, 1) + p(:, 4), p(:, 2) + p(:, 5), p(:, 3) + p(:, 6), siz(r), [ones(size(p, 1), 1) col zeros(size(p, 1), 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3)), hold on;
    scatter3(p(:, 1), p(:, 2), p(:, 3), siz(r), [col col ones(size(p, 1), 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3));
    axis([-a a -a a -a a], 'square');
    axis('off');
    view(0, 0);
	print([num2str(rep(r)) '.png'], '-dpng');
end