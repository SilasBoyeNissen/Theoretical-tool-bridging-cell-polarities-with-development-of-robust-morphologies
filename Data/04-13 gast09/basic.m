clc; clear; clf; tic;
load('data/t1'); % Initial conditions. Column 1-3: Position. Column 4-6: AB polarity. Column 7-9: PCP polarity. Column 10-11: Irrelevant (statistics: potential and #NBs)
t = 2; % next time step
dt = 0.3; % dt
inc = 100; % #ofCells to screen in neighbor function
noise = 1e-5; % width of gaussian noise
[~, ID] = mink(sqrt((p(:, 1)' - p(:, 1)).^2 + (p(:, 2)' - p(:, 2)).^2 + (p(:, 3)' - p(:, 3)).^2), inc+1, 2); % Calculate neighboorhood
lambda = repmat([1 0 0 0], size(p, 1), 1); % Column 1: Strength of AB polarity. Column 2: Strength of PCP polarity. Column 3: Strength of spherical attraction.

[~, lis] = sort(p(:, 3));
IDs = lis(1:333);
lambda(IDs, :) = repmat([0.9 0.1 0 0], size(IDs, 1), 1);
p(IDs, 7:9) = -p(IDs, 1:3)./sqrt(sum(p(IDs, 1:3).^2, 2));

while t <= 14e3 % limit the number of time steps
    disp(t); % print current time step
    disp(p(1, :)); % print properties of cell 1 (test)
	NB = neighbor(ID, inc, p); % find current neighbors
    dr = moved(lambda, NB, p); % euler update
    p(:, 1:6) = p(:, 1:6) + dt*dr(:, 1:6) + normrnd(0, noise, size(p, 1), 6); % Update all and add noise
    p(:, 4:6) = p(:, 4:6)./repmat(sqrt(sum(p(:, 4:6).^2, 2)), 1, 3); % Normalize AB polarity

    if t == 7e3
        p(:, 7:9) = 0;
        p(IDs, 7:8) = -p(IDs, 1:2)./sqrt(sum(p(IDs, 1:2).^2, 2));
        p(IDs, 7:9) = cross(p(IDs, 7:9), repmat([0 0 1], size(IDs, 1), 1));
        lambda(IDs, :) = repmat([0.61 0.3 0.09 0], size(IDs, 1), 1);
    end
    
    if mod(t, 50) == 0 % update statistics and save current status
        p(:, 10) = dr(:, 10); % update potential (for statistics only)
        p(:, 11) = sum(NB>0, 2); % update #ofNeighbors (for statistics only)
        save(['data/t' num2str(t) '.mat'], 'p'); % save all data in data folder
        [~, ID] = mink(sqrt((p(:, 1)' - p(:, 1)).^2 + (p(:, 2)' - p(:, 2)).^2 + (p(:, 3)' - p(:, 3)).^2), inc+1, 2); % Update neighboorhood
    end
    t = t + 1;
end
toc;