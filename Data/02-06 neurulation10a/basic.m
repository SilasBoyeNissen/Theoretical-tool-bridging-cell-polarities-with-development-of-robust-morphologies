clc; clear; clf; tic;
load('data/t1'); % Initial conditions. Column 1-3: Position. Column 4-6: AB polarity. Column 7-9: PCP polarity. Column 10-11: Irrelevant (statistics: potential and #NBs)
t = 2; % next time step
lt = 0; % log(t)
dt = 0.3; % dt
inc = 100; % #ofCells to screen in neighbor function
noise = 1e-2; % width of gaussian noise
[~, ID] = mink(sqrt((p(:, 1)' - p(:, 1)).^2 + (p(:, 2)' - p(:, 2)).^2 + (p(:, 3)' - p(:, 3)).^2), inc+1, 2); % Calculate neighboorhood
lambda = repmat([0.5 0.5 0], 1000, 1); % Column 1: Strength of AB polarity. Column 2: Strength of PCP polarity. Column 3: Strength of spherical attraction.

[~, laas] = sort(abs(p(:, 1)));

while t <= 1e5 % limit the number of time steps
    disp(t); % print current time step
    disp(p(1, :)); % print properties of cell 1 (test)
	NB = neighbor(ID, inc, p); % find current neighbors
    dr = moved(lambda, NB, p); % euler update
    p(:, 1:9) = p(:, 1:9) + dt*dr(:, 1:9) + normrnd(0, noise, size(p, 1), 9); % Update all and add noise
    p(:, 4:6) = p(:, 4:6)./repmat(sqrt(sum(p(:, 4:6).^2, 2)), 1, 3); % Normalize AB polarity

    p(laas(100:200), 7:9) = repmat([-1 0 1], 101, 1);
	p((p(:, 9) == 1) + (p(:, 1) < 0) == 2, 9) = -p((p(:, 9) == 1) + (p(:, 1) < 0) == 2, 9);

  	p(:, 7:9) = p(:, 7:9)./repmat(sqrt(sum(p(:, 7:9).^2, 2)), 1, 3); % Normalize PCP polarity
    if floor(log10(t)*100)/100 > lt % update statistics and save current status
        lt = floor(log10(t)*100)/100; % update log(t) (save frequency)
        p(:, 10) = dr(:, 10); % update potential (for statistics only)
        p(:, 11) = sum(NB>0, 2); % update #ofNeighbors (for statistics only)
        save(['data/t' num2str(t) '.mat'], 'p'); % save all data in data folder
        [~, ID] = mink(sqrt((p(:, 1)' - p(:, 1)).^2 + (p(:, 2)' - p(:, 2)).^2 + (p(:, 3)' - p(:, 3)).^2), inc+1, 2); % Update neighboorhood
    end
    t = t + 1;
end
toc;