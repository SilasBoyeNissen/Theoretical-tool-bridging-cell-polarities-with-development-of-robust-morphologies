load('../Figure 5 organoids/_data/16000');
figure(1); clf;
set(figure(1), 'Position', [1, 1, 700, 900]);
fig = tightsubplot(3, 2, [0 0], [0.08 0.01], [0.1 0.02]);
legs = {{'P = 0.004', 't_G^{-1} = 0.001'}, {'P = 0.005', 't_G^{-1} = 0.003'}, {'P = 0.006', 't_G^{-1} = 0.007'}};
xlab = {'Depth (%)', 'Circumference (%)'};
col1 = {'#9ecae1', '#4292c6', '#08519c'};
col2 = {'#fdae6b', '#f16913', '#a63603'};
xmin = [  0   0  ];
xmax = [100  pi  ];
xste = [ 20  pi/5];
panL = 'ADBECF';
ymin = 0;
ymax = 0.8;
yste = 0.2;
FS = 24;

for g = 0:5
    f = mod(g, 2)+1;
    axes(fig(g+1));
    histogram([], [xmin(f):xste(f)/2:xmax(f)-xste(f)/2 1e4], 'EdgeColor', 'k', 'FaceAlpha', 0.5, 'FaceColor', hex2rgb(col1{floor(g/2)+1}), 'LineWidth', 0.5); hold on;
    histogram([], [xmin(f):xste(f)/2:xmax(f)-xste(f)/2 1e4], 'EdgeColor', 'k', 'FaceAlpha', 0.5, 'FaceColor', hex2rgb(col2{floor(g/2)+1}), 'LineWidth', 0.5);
    histogram(res1{:, :, floor(g/2)+4}(:, f+2), [xmin(f):xste(f)/2:xmax(f)-xste(f)/2 1e4], 'EdgeColor', 'none', 'FaceAlpha', 0.5, 'FaceColor', hex2rgb(col1{floor(g/2)+1}), 'Normalization', 'probability');
    histogram(res2{:, :, floor(g/2)+4}(:, f+2), [xmin(f):xste(f)/2:xmax(f)-xste(f)/2 1e4], 'EdgeColor', 'none', 'FaceAlpha', 0.5, 'FaceColor', hex2rgb(col2{floor(g/2)+1}), 'Normalization', 'probability');
    histogram(res1{:, :, floor(g/2)+4}(:, f+2), [xmin(f):xste(f)/2:xmax(f)-xste(f)/2 1e4], 'DisplayStyle', 'stairs', 'EdgeColor', 'k', 'LineWidth', 1, 'Normalization', 'probability');
    histogram(res2{:, :, floor(g/2)+4}(:, f+2), [xmin(f):xste(f)/2:xmax(f)-xste(f)/2 1e4], 'DisplayStyle', 'stairs', 'EdgeColor', 'k', 'LineWidth', 1, 'Normalization', 'probability');
    text(xmax(f)/20, 0.94*ymax, panL(g+1), 'FontSize', FS, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
    [h, p] = kstest2(res1{:, :, floor(g/2)+4}(:, f+2),res2{:, :, floor(g/2)+4}(:, f+2));
    data = {res1{:, :, floor(g/2)+4}(:, f+2), res2{:, :, floor(g/2)+4}(:, f+2)};
    legend(legs{floor(g/2)+1}, 'color', 'none');
    save(['Panel ' panL(g+1)], 'data');
    axis([xmin(f) xmax(f) ymin ymax]);
    if g == 0
        set(gca, 'color', 'none', 'FontSize', FS, 'XTick', [], 'YTick', ymin:yste:ymax);
    elseif g == 4
        xlabel(xlab{f}, 'FontWeight', 'bold');
        set(gca, 'color', 'none', 'FontSize', FS, 'XTick', xmin(f):xste(f):xmax(f)-xste(f), 'YTick', ymin:yste:ymax-yste);
    elseif g == 5
        xlabel(xlab{f}, 'FontWeight', 'bold');
        set(gca, 'color', 'none', 'FontSize', FS, 'XTick', xmin(f):xste(f):xmax(f), 'YTick', ymin:yste:ymax-yste);
    else
        set(gca, 'color', 'none', 'FontSize', FS, 'XTick', [], 'YTick', ymin:yste:ymax-yste);
    end
    if f == 1
        ylabel('Probability', 'FontWeight', 'bold');
    else
        xticklabels({'0', '10', '20', '30', '40', '50'});
        yticklabels({'', '', '', '', ''});
    end
    box('on');
end
f = gcf; f.PaperSize = [f.PaperPosition(3) f.PaperPosition(4)];
print('figure.pdf', '-dpdf');