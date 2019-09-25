clc; clear; clf; tic;
pol = zeros(8000, 9);
pos = zeros(8000, 9);
da = zeros(3, 12);
seed = '123';
ics = 'abc';
j = [2 3 1];
t = 100000;
for i = 1:size(ics, 2) % Vary initial polarity
    p1 = load(['../../Data/01-17 noiseE-5' ics(i) '1/data/t' num2str(t)]);
    p2 = load(['../../Data/01-17 noiseE-5' ics(j(i)) '1/data/t' num2str(t)]);
    qq = real(acos(p2.p(:, 4).*p1.p(:, 4) + p2.p(:, 5).*p1.p(:, 5) + p2.p(:, 6).*p1.p(:, 6)));
    pp = sqrt(sum((p2.p(:, 1:3) - p1.p(:, 1:3)).^2, 2));
    da(i, 1:4) = [mean(pp) std(pp) mean(qq) std(qq)];
    pol(:, i) = qq;
    pos(:, i) = pp;
end
for i = 1:size(seed, 2) % Vary noise level
    p1 = load(['../../Data/01-17 noiseE-2a' seed(i) '/data/t' num2str(t)]);
    p2 = load(['../../Data/01-17 noiseE-5a' seed(i) '/data/t' num2str(t)]);
    qq = real(acos(p2.p(:, 4).*p1.p(:, 4) + p2.p(:, 5).*p1.p(:, 5) + p2.p(:, 6).*p1.p(:, 6)));
    pp = sqrt(sum((p2.p(:, 1:3) - p1.p(:, 1:3)).^2, 2));
    da(i, 5:8) = [mean(pp) std(pp) mean(qq) std(qq)];
    pol(:, i+3) = qq;
    pos(:, i+3) = pp;
end
for i = 1:size(seed, 2) % Vary seed
    p1 = load(['../../Data/01-17 noiseE-5a' seed(i) '/data/t' num2str(t)]);
    p2 = load(['../../Data/01-17 noiseE-5a' seed(j(i)) '/data/t' num2str(t)]);
    qq = real(acos(p2.p(:, 4).*p1.p(:, 4) + p2.p(:, 5).*p1.p(:, 5) + p2.p(:, 6).*p1.p(:, 6)));
    pp = sqrt(sum((p2.p(:, 1:3) - p1.p(:, 1:3)).^2, 2));
    da(i, 9:12) = [mean(pp) std(pp) mean(qq) std(qq)];
    pol(:, i+6) = qq;
    pos(:, i+6) = pp;
end
subfigure(pol, pos);
toc;