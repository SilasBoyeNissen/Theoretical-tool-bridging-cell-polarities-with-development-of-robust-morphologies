function [groups, res, stat] = measure(groups, NB, NBc, p, waterLevel)
dr = moved(ones(size(p, 1), 1), NB, NBc, p);
test = 1000*ones(size(p, 1), 100);
d = sqrt(sum((p(:, 1:3) - mean(p(:, 1:3))).^2, 2));
test(NBc>0) = d(NBc(NBc>0));
groups(:, 4) = ((dr(:, 7) < pi/2) + all(d < test, 2) == 2);
stat = [mean(real(p(:, 7))) std(real(p(:, 7))) sum(groups(:, 4))];
for i = 1:max(groups(:, 3))
    if sum(groups(groups(:, 3) == 1, 4)) == 0
        groups(groups(:, 3) == i, 3) = 0;
    end
end
h = histogram(groups(:, 3));
res = zeros(h.NumBins-1, 6);
res(:, 1) = 1:h.NumBins-1;
res(:, 2) = h.Values(2:end)/size(p, 1)*100;
num = p(:, 1:3) - mean(p(:, 1:3));
num = num./sqrt(sum(num.^2, 2));
for i = 1:h.NumBins-1
    res(i, 3) = max(waterLevel - groups(groups(:, 3) == i, 1))/waterLevel*100;
    c = find((groups(:, 3) == i) + (groups(:, 1) > waterLevel-1) == 2);
    [~, ID] = max(real(acos(p(c, 4:6)*p(c, 4:6)')));
    ang = real(diag(acos(num(c, 1:3)*num(c(ID), 1:3)')));
    res(i, 4) = max(ang);
    res(i, 5) = min(ang);
end
res(:, 6) = res(:, 4)./res(:, 5);