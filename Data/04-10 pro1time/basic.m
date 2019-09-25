clc; clear; clf; tic;
rng(1);
t = 0;
load('t1');
N = size(p, 1) + 1;
vec = rand(1, 3)*2 - 1;
p(N, :) = p(1, :) + [0.5*vec/norm(vec) 0 0 0 0 0 0];
[NB, NBc] = neighbor(p);
dr = moved(ones(N, 1), NB, NBc, p, 0);
p(:, 7) = dr(:, 7);
p(:, 8) = dr(:, 8);
p(:, 9) = sum(NB>0, 2);
save(['data/t' num2str(t) '.mat'], 'p');
while t <= 1000
    disp(t);
    if t < 1
        dt = 0.01;
    else
        dt = 0.1;
    end
    t = t + dt;
    p(:, 1:6) = p(:, 1:6) + dt*(dr(:, 1:6) + normrnd(0, 1e-4, N, 6));
    p(:, 4:6) = p(:, 4:6)./repmat(sqrt(sum(p(:, 4:6).^2, 2)), 1, 3);
    dr = moved(ones(N, 1), NB, NBc, p, 0);
	p(:, 7) = dr(:, 7);
	p(:, 8) = dr(:, 8);
	p(:, 9) = sum(NB>0, 2);
	[NB, NBc] = neighbor(p);
	save(['data/t' num2str(round(t*1000)) '.mat'], 'p');
end
toc;