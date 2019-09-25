function [groups, NB, NBc, waterLevel] = group(p)
g = 1;
[NB, NBc] = neighbor(p);
NBm = NBc;
groups = zeros(size(p, 1), 4);
queue = false(size(p, 1), 1);
groups(:, 1) = sqrt(sum((p(:, 1:3) - mean(p(:, 1:3))).^2, 2));
waterLevel = (max(groups(:, 1)) + min(groups(:, 1)))/2;
NB(:, max(p(:, end))+1:end) = [];
NBc(:, max(p(:, end))+1:end) = [];
NBm(:, max(p(:, end))+1:end) = [];
groups(:, 2) = (groups(:, 1) < waterLevel);
NBm(ismember(NBm, find(groups(:, 2) == 0)) == 1) = 0;
while find(groups(:, 2), 1)
    i = find(groups(:, 2) == 1, 1);
    groups(i, 2) = 0;
    groups(i, 3) = g;
    NBm(NBm == i) = 0;
    queue(NBm(i, NBm(i, :) > 0)) = 1;
    while find(queue, 1)
        j = find(queue == 1, 1);
        queue(j) = 0;
        groups(j, 2) = 0;
        groups(j, 3) = g;
        NBm(NBm == j) = 0;
        queue(NBm(j, NBm(j, :) > 0)) = 1;
    end
    g = g + 1;
end