clc; clear; clf;
load('data/t150000');
div = datasample(1:size(p, 1), size(p, 1), 'Replace', false);
l = ones(size(p, 1), 1);
in = 1;
t = 150001;
while t
    disp(t);
    disp(size(p, 1));
    tt = num2str(t);
	NB = neighbor(p);
    dr = moved(l, NB, p);
    if t < 100 || all(tt(3:end) == '0')
        p(:, 7) = dr(:, 7);
        p(:, 8) = sum(NB>0, 2);
        save(['data/t' tt '.mat'], 'p');
    end
    p(:, 1:6) = p(:, 1:6) + 0.1*dr(:, 1:6) + normrnd(0, 0.0001, size(p, 1), 6);
    p(:, 4:6) = p(:, 4:6)./repmat(sqrt(sum(p(:, 4:6).^2, 2)), 1, 3);
    if mod(t, 10) == 1
        vec = rand(1, 3)*2-1;
        p(end+1, :) = p(div(in), :) + [vec/norm(vec) 0 0 0 0 0];
        l(end+1, 1) = 1;
        in = in + 1;
        if in > size(div, 2)
            in = 1;
            div = datasample(1:size(p, 1), size(p, 1), 'Replace', false);
        end
    end
    t = t + 1;
end