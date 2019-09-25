clc; clear; close all; tic;
rng(1); % define seed
PAR = 1; % Turn on/off parallel computing
load('input/bulk/N1000'); % initial conditions. Column 1-3: Position. Column 4-6: AB polarity. Column 7-9: PCP. Column 10-11: Irrelevant (statistics: V_i and #NBs)
p(:, 4:6) = rand(size(p, 1), 3)*2-1; % modify initial directions of AB polarities
p(:, 7:9) = 0; % modify initiatial directions of PCP polarities
save('output/t1.mat', 'p'); % save initial conditions
t = 2; % next time step
dt = 0.1; % dt in euler update
inc = 100; % numberOfCells to screen
eta = 1e-5; % width of gaussian noise
ID = knnsearch(p(:, 1:3), p(:, 1:3), 'K', inc+1); % calculate neighborhood
lambdas = repmat([1 0 0], size(p, 1), 1); % column 1: Strength of S1 (lambda1). Column 2: Strength of S2 (lambda2). Column 3: Strength of S3 (lambda3).
while t % limit the number of time steps
    disp(t); % print current time step
    disp(p(1, :)); % print properties of cell 1 (test)
    if PAR
        NB = neighborPar(ID, inc, p(:, 1:3)); % find current neighbors
        dr = movedPar(lambdas, NB, p); % euler update
    else
        NB = neighbor(ID, inc, p(:, 1:3)); % find current neighbors
        dr = moved(lambdas, NB, p); % euler update
    end
    p(:, 1:9) = p(:, 1:9) + dt*dr(:, 1:9) + normrnd(0, eta, size(p, 1), 9); % update all and add noise
    p(:, 4:6) = p(:, 4:6)./repmat(sqrt(sum(p(:, 4:6).^2, 2)), 1, 3); % normalize AB polarity
  	p(:, 7:9) = p(:, 7:9)./repmat(sqrt(sum(p(:, 7:9).^2, 2)), 1, 3); % normalize PCP polarity
	p(:, 10) = dr(:, 10); % update potential (for statistics only)
	p(:, 11) = sum(NB>0, 2); % update NumberOfNeighbors (for statistics only)
	save(['output/t' num2str(t) '.mat'], 'p'); % save current state in output folder
	ID = knnsearch(p(:, 1:3), p(:, 1:3), 'K', inc+1); % update neighborhood
    t = t + 1; % next time step
end
toc;