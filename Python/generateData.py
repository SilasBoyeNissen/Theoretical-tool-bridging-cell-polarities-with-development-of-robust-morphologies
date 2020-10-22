from scipy.spatial.ckdtree import cKDTree
import numpy as np
import torch as tc
import scipy.io
import time

t = 0  # time step
dt = 0.1  # dt in euler update
inc = 100  # numberOfCells to screen
eta = 0.01  # width of gaussian noise
t_save = 100  # how often to save data
np.random.seed(0)  # define seed
tic = time.time()  # record time
dev = "cuda" if tc.cuda.is_available() else "cpu"  # cuda or cpu
flt = tc.cuda.FloatTensor if dev == "cuda" else tc.FloatTensor  # set float tensor
xpq = tc.tensor(scipy.io.loadmat('input/bulk-N8000.mat')['xpq'], requires_grad=True, dtype=tc.float, device=dev)
# initial conditions. Column 1-3: Position (x,y,z). Column 4-6: AB polarity (px,py,pz). Column 7-9: PCP (qx,qy,qz).
ld = tc.tensor(np.array([1, 0, 0]), dtype=tc.float, device=dev)  # set lambda1, lambda2, and lambda3 column-wise
while t <= 500:  # limit the number of time steps
    t += 1  # next time step
    xyz = xpq[:, 0:3].detach().to("cpu").numpy()  # get xyz coordinates
    d, j = cKDTree(xyz).query(xyz, inc+1, distance_upper_bound=np.inf, n_jobs=-1)  # find nearest neighbor distances
    d = tc.tensor(d[:, 1:], dtype=tc.float, device=dev)  # distances to everyone except yourself
    j = tc.tensor(j[:, 1:], dtype=tc.long, device=dev)  # indices to everyone except yourself
    rij = xpq[:, None, 0:3] - xpq[j, 0:3]  # calculate rij vector
    with tc.no_grad():
        xpq[:, 3:6] /= tc.sqrt(tc.sum(xpq[:, 3:6]**2, dim=1))[:, None]  # normalize AB polarity
        xpq[:, 6:9] /= tc.sqrt(tc.sum(xpq[:, 6:9]**2, dim=1))[:, None]  # normalize PCP polarity
        nd = tc.sum((rij[:, :, None, :]/2 - rij[:, None, :, :])**2, dim=3) + 1000*tc.eye(inc, device=dev)[None, :, :]
    nb = tc.cat([(tc.sum(nd < (d[:, :, None]**2/4), dim=2) <= 0)])  # neighborhood
    sj = tc.argsort(nb.float(), dim=1, descending=True)  # sort j
    nb = tc.gather(nb, 1, sj)  # update neighborhood
    m = tc.max(tc.sum(nb, dim=1)) + 1
    rij = tc.gather(rij, 1, sj[:, :, None].expand(-1, -1, 3))[:, :m]  # calculate rij vector
    j = tc.gather(j, 1, sj)[:, :m]  # indices to j neighbors
    d = tc.sqrt(tc.sum(rij**2, dim=2))  # distances to j neighbors
    rij = rij/d[:, :, None]  # rij vector
    pi = xpq[:, None, 3:6].expand(xpq.shape[0], j.shape[1], 3)  # calculate pi vector
    qi = xpq[:, None, 6:9].expand(xpq.shape[0], j.shape[1], 3)  # calculate qi vector
    S1 = tc.sum(tc.cross(xpq[j, 3:6], rij, dim=2)*tc.cross(pi, rij, dim=2), dim=2)  # calculate S1 factor
    S2 = tc.sum(tc.cross(pi, qi, dim=2)*tc.cross(xpq[j, 3:6], xpq[j, 6:9], dim=2), dim=2)  # calculate S2 factor
    S3 = tc.sum(tc.cross(qi, rij, dim=2)*tc.cross(xpq[j, 6:9], rij, dim=2), dim=2)  # calculate S3 factor
    tc.sum(nb[:, :m].float()*(tc.exp(-d) - (ld[0]*S1 + ld[1]*S2 + ld[2]*S3)*tc.exp(-d/5))).backward()  # potential V
    with tc.no_grad():
        xpq += -xpq.grad*dt + eta*flt(*xpq.shape).normal_()*np.sqrt(dt)  # update all and add noise
    xpq.grad.zero_()
    if t % t_save == 0:  # save at these time steps
        scipy.io.savemat(f'output/t{t}.mat', dict(xpq=xpq.detach().to("cpu").numpy()))  # save current state
        print(f'Running {t}', end='\r')  # print time step
print(time.time() - tic)  # print time passed
