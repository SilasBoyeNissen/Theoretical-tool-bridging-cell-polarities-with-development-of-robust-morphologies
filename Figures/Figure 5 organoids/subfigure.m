tic;
t = 16000;
rep = {'04-10 pro3'};
val = {[500]};

for r = 1:size(rep, 2)
    for v = 1:size(val{r}, 2)
        siz = 110;
        figure(1); clf;
        set(figure(1), 'color', 'w', 'Position', [0, 0, 440, 440]);
        load(['../../Data/' rep{r} '/data' num2str(val{r}(v)) '/t' num2str(t) '.mat']);
        a = 2*ceil(max(max(abs(p(:, 1:3))))/2)+3;
        col = 1-exp(log(1-0.85)/(a/2)*abs (p(:, 2)));
        axes(tightsubplot(1, 1, [0 0], [0 0], [0 0]));
        scatter3(p(:, 1) + p(:, 4), p(:, 2) + p(:, 5), p(:, 3) + p(:, 6), siz, [ones(size(p, 1), 1) col zeros(size(p, 1), 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3)), hold on;
        scatter3(p(:, 1), p(:, 2), p(:, 3), siz, [col col ones(size(p, 1), 1)], 'filled', 'LineWidth', 0.1, 'MarkerEdgeColor', 0.1*ones(1, 3));
        axis([-a a -a a -a a], 'square');
        axis('off');
        view(0, 0);
        print([rep{r} '-' num2str(val{r}(v)) '-' num2str(t) '.png'], '-dpng');
    end
end
toc;