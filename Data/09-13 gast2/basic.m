clc; clear; clf; tic;
rng(1); % define seed
load('data/t1'); % Initial conditions. Column 1-3: Position. Column 4-6: AB polarity. Column 7-9: PCP polarity. Column 10-11: Irrelevant (statistics: potential and #NBs)
t = 2; % next time step
dt = 0.1; % dt
inc = 100; % #ofCells to screen in neighbor function
eta = 1e-5; % width of gaussian noise
IDs = find(p(:, 7));
lambdas = repmat([1 0 0], size(p, 1), 1);
lambdas(IDs, :) = repmat([0.5 0.4 0.1], size(IDs, 1), 1);
[~, ID] = mink(sqrt((p(:, 1)' - p(:, 1)).^2 + (p(:, 2)' - p(:, 2)).^2 + (p(:, 3)' - p(:, 3)).^2), inc+1, 2);
while t <= 5e4 % limit the number of time steps
    disp(t); % print current time step
    disp(p(1, :)); % print properties of cell 1 (test)
	NB = neighbor(ID, inc, p); % find current neighbors
    dr = moved(lambdas, NB, p); % euler update
	p(IDs, 4:5) = p(IDs, 4:5) - 0.02*p(IDs, 1:2)./repmat(sqrt(sum(p(IDs, 1:2).^2, 2)), 1, 2).*repmat(exp((-p(IDs, 1).^2-p(IDs, 2).^2)/10^2), 1, 2);
    p(:, 1:6) = p(:, 1:6) + dt*dr(:, 1:6) + normrnd(0, eta, size(p, 1), 6); % Update all and add noise
    p(:, 4:6) = p(:, 4:6)./repmat(sqrt(sum(p(:, 4:6).^2, 2)), 1, 3); % Normalize AB polarity
    if mod(t, 50) == 0 % update statistics and save current status
        p(:, 10) = dr(:, 10); % update potential (for statistics only)
        p(:, 11) = sum(NB>0, 2); % update #ofNeighbors (for statistics only)
        save(['data/t' num2str(t) '.mat'], 'p'); % save all data in data folder
        [~, ID] = mink(sqrt((p(:, 1)' - p(:, 1)).^2 + (p(:, 2)' - p(:, 2)).^2 + (p(:, 3)' - p(:, 3)).^2), inc+1, 2); % Update neighboorhood
    end
    t = t + 1;
end
toc;