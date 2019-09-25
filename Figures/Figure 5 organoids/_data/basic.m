clc; clear; close all; tic;
proV = [10000 5000 2000 1000 500 200 100];
preV = 0:6;
numV = 1:3;
for t = 8000:4000:16000
    sta1 = zeros(size(preV, 2), 4);
    res1 = cell(1, 1, size(preV, 2));
    for r = 1:size(preV, 2)
        disp(preV(r));
        mergeR = zeros(0, 6);
        mergeS = zeros(max(numV), 3);
        for n = numV
            load(['../../../Data/04-10 pres' num2str(n) '/data' num2str(preV(r)) '/t' num2str(t)]);
            [groups, NB, NBc, waterLevel] = group(p);
            [groups, res, stat] = measure(groups, NB, NBc, p, waterLevel);
            mergeR(end+1:end+size(res, 1), :) = res;
            mergeS(n, :) = stat;
        end
        sta1(r, :) = [mean(mergeS, 1) std(mergeS(:, 3), 1)];
        res1{:, :, r} = mergeR;
    end
    sta2 = zeros(size(proV, 2), 4);
    res2 = cell(1, 1, size(proV, 2));
    for r = 1:size(proV, 2)
        disp(proV(r));
        mergeR = zeros(0, 6);
        mergeS = zeros(max(numV), 3);
        for n = numV
            load(['../../../Data/04-10 pro' num2str(n) '/data' num2str(proV(r)) '/t' num2str(t)]);
            [groups, NB, NBc, waterLevel] = group(p);
            [groups, res, stat] = measure(groups, NB, NBc, p, waterLevel);
            mergeR(end+1:end+size(res, 1), :) = res;
            mergeS(n, :) = stat;
        end
        sta2(r, :) = [mean(mergeS, 1) std(mergeS(:, 3), 1)];
        res2{:, :, r} = mergeR;
    end
    save(num2str(t), 'res1', 'res2', 'sta1', 'sta2');
end
toc;