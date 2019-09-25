clc; clear; close all; tic; k = 0;
panel = 'AB';
for t = [12590 12883]
    load(['../../Data/03-05 equal825/data/t' num2str(t)]);
    TRI = neighbor(12, p, 1.7);
    TRI = unique(sort(TRI, 2), 'rows');
    E = edges(triangulation(TRI, p(:, 1), p(:, 2), p(:, 3)));
    for i = 1:size(E, 1)
        dif = mysetdiff(unique(TRI(sum((TRI == E(i, 1)) + (TRI == E(i, 2)), 2) == 2, :)), E(i, :));
        if size(dif, 1) == 2
            mem = (sum((TRI == dif(1)) + (TRI == dif(2)), 2) == 2);
            TRI(mem, :) = [];
        end
    end
    TRI = calculate(p, TRI);
    FN = faceNormal(triangulation(TRI, p(:, 1), p(:, 2), p(:, 3)));
    for i = 1:size(TRI, 1)
        if acos(mean(p(TRI(i, :), 4:6))/norm(mean(p(TRI(i, :), 4:6)))*FN(i, :)') < pi/2
            TRI(i, :) = TRI(i, 3:-1:1);
        end
    end
    FV = triangulation(TRI, p(:, 1), p(:, 2), p(:, 3));
    k = k + 1;
    y = -20;
    a = 13.5;
    b = [-4 7 -5 5 -12 4];
    Points = FV.Points;
    CL = FV.ConnectivityList;
    E = edges(triangulation(TRI, p(:, 1), p(:, 2), p(:, 3)));
    figure(1); clf;
    set(figure(1), 'Position', [1, 1, 400, 950]);
    axes(tightsubplot(1, 1, [0 0], [0 0], [0 0]));
    plot3([b(1) b(1) b(2) b(2) b(1)], [y y y y y], [b(5) b(6) b(6) b(5) b(5)], 'k', 'LineWidth', 5); hold on;
    for i = 1:size(E, 1)
        CLF = find(sum((CL == E(i, 1)) + (CL == E(i, 2)), 2) == 2);
        xyz1 = mean(Points(CL(CLF(1), :), :));
        xyz2 = mean(Points(CL(CLF(2), :), :));
        if xyz1(2) < 0
            plot3([xyz1(1) xyz2(1)], [y+2 y+2], [xyz1(3) xyz2(3)], 'Color', hex2rgb('#de2d26'), 'LineWidth', 1);
        end
    end
    trisurf(FV, 'EdgeColor', 0.2*ones(1, 3), 'LineWidth', 0.1);
    view(0, 0);
    axis('off');
    axis([-a a -a a -2.375*a 2.375*a], 'equal');
    f = gcf; f.PaperSize = [f.PaperPosition(3) f.PaperPosition(4)];
    print(['figure' panel(k) '.pdf'], '-dpdf');
end
toc;