clc; clear; clf; tic;
load('t1');
t = 2;
lt = 0;
inc = 100;
lambda3 = 0.09;
[~, I] = sort(abs(p(:, 3)));
[~, ID] = mink(sqrt((p(:, 1)' - p(:, 1)).^2 + (p(:, 2)' - p(:, 2)).^2 + (p(:, 3)' - p(:, 3)).^2), inc+1, 2);
lambdas = repmat([0.5-lambda3 0.5 lambda3 0], size(p, 1), 1);
lambdas(I(1:333), :) = repmat([1 0 0 0], 333, 1);
p(I(1:333), 7:9) = 0;
save('dataCyst2/t1.mat', 'p');
while t <= 1e7
    disp(t);
	NB = neighbor(ID, inc, p);
    dr = moved(lambdas, NB, p);
    p(:, 1:6) = p(:, 1:6) + 0.1*dr(:, 1:6) + normrnd(0, 1e-4, size(p, 1), 6);
    p(:, 4:6) = p(:, 4:6)./repmat(sqrt(sum(p(:, 4:6).^2, 2)), 1, 3);
    p(I(334:end), 7:9) = p(I(334:end), 7:9) + 0.1*dr(I(334:end), 7:9) + normrnd(0, 1e-4, 667, 3);
    p(I(334:end), 7:9) = p(I(334:end), 7:9)./repmat(sqrt(sum(p(I(334:end), 7:9).^2, 2)), 1, 3);
    if floor(log10(t)*100)/100 > lt
        lt = floor(log10(t)*100)/100;
        p(:, 10) = dr(:, 10);
        p(:, 11) = sum(NB>0, 2);
        save(['dataCyst2/t' num2str(t) '.mat'], 'p');
        [~, ID] = mink(sqrt((p(:, 1)' - p(:, 1)).^2 + (p(:, 2)' - p(:, 2)).^2 + (p(:, 3)' - p(:, 3)).^2), inc+1, 2);
    end
    t = t + 1;
end
toc;