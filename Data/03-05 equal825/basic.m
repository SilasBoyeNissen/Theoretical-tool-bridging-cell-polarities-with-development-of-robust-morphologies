clc; clear; clf; tic;
load('data/t3311312');
t = 3311313;
lt = 6.52;
inc = 100;
[~, ID] = mink(sqrt((p(:, 1)' - p(:, 1)).^2 + (p(:, 2)' - p(:, 2)).^2 + (p(:, 3)' - p(:, 3)).^2), inc+1, 2);
while t <= 1e7
    disp(t);
    disp(p(1, :));
	NB = neighbor(ID, inc, p);
    dr = moved(repmat([0.825*1/2 1/2 0.175*1/2 0], size(p, 1), 1), NB, p);
    p(:, 1:9) = p(:, 1:9) + 0.2*dr(:, 1:9) + normrnd(0, 1e-5, size(p, 1), 9);
    p(:, 4:6) = p(:, 4:6)./repmat(sqrt(sum(p(:, 4:6).^2, 2)), 1, 3);
    p(:, 7:9) = p(:, 7:9)./repmat(sqrt(sum(p(:, 7:9).^2, 2)), 1, 3);
    if floor(log10(t)*100)/100 > lt
        lt = floor(log10(t)*100)/100;
        p(:, 10) = dr(:, 10);
        p(:, 11) = sum(NB>0, 2);
        save(['data/t' num2str(t) '.mat'], 'p');
        [~, ID] = mink(sqrt((p(:, 1)' - p(:, 1)).^2 + (p(:, 2)' - p(:, 2)).^2 + (p(:, 3)' - p(:, 3)).^2), inc+1, 2);
    end
    t = t + 1;
end
toc;