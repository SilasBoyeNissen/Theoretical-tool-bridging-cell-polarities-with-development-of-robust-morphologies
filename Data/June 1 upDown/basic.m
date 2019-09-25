clc; clear; clf;
load('data/t290000');
t = 290001;
l = ones(size(p, 1), 1);
while t
    disp(t);
    disp(p(1, :));
    tt = num2str(t);
	NB = neighbor(p);
    dr = moved(l, NB, p);
    if t < 100 || all(tt(3:end) == '0')
        p(:, 7) = dr(:, 7);
        p(:, 8) = sum(NB>0, 2);
        trials = 1;
        while trials
            try
                save(['data/t' tt '.mat'], 'p');
                trials = 0;
            catch
                disp([num2str(trials) ' trials']);
                trials = trials+1;
                pause(60);
            end
        end
    end
    p(:, 1:6) = p(:, 1:6) + 0.1*dr(:, 1:6) + normrnd(0, 0.1, size(p, 1), 6);
    p(:, 4:6) = p(:, 4:6)./repmat(sqrt(sum(p(:, 4:6).^2, 2)), 1, 3);
    t = t + 1;
end