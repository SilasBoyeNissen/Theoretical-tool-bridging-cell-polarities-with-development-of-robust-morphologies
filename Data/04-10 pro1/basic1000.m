clc; clear; clf; tic;
for K = 1000
    lt = 0;
    num = cd;
    load('t1');
    N = size(p, 1);
    rng(str2double(num(end)));
    while N <= 20000
        t = 0;
        [NB, NBc] = neighbor(p);
        dr = moved(ones(N, 1), NB, NBc, p, 0);
        disp(['Proliferation ' num2str(K) ': ' num2str(N)]);
        while t < K/N
            dt = min(min(0.2, K/N/5), K/N-t);
            p(:, 1:6) = p(:, 1:6) + dt*(dr(:, 1:6) + normrnd(0, 1e-4, N, 6));
            p(:, 4:6) = p(:, 4:6)./repmat(sqrt(sum(p(:, 4:6).^2, 2)), 1, 3);
            dr = moved(ones(N, 1), NB, NBc, p, 0);
            t = t + dt;
        end
        if floor(log10(N)*100)/100 > lt || mod(N, 2000) == 0
            lt = floor(log10(N)*100)/100;
            p(:, 7) = dr(:, 7);
            p(:, 8) = dr(:, 8);
            p(:, 9) = sum(NB>0, 2);
            save(['data' num2str(K) '/t' num2str(N) '.mat'], 'p');
        end
        N = N + 1;
        vec = rand(1, 3)*2-1;
        p(N, :) = p(datasample(1:N-1, 1), :) + [0.5*vec/norm(vec) 0 0 0 0 0 0];
    end
end
toc;