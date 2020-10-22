import numpy as np
from mayavi import mlab
import scipy.io
import glob
import os

mlab.figure(size=(900, 900))
print(max(glob.glob(f'./output/*.mat'), key=os.path.getctime))
xpq = scipy.io.loadmat(max(glob.glob(f'./output/*.mat'), key=os.path.getctime))['xpq']
mlab.points3d(xpq[:, 0], xpq[:, 1], xpq[:, 2], scale_factor=2, scale_mode='none')
plotAB = mlab.points3d(xpq[:, 0]+xpq[:, 3], xpq[:, 1]+xpq[:, 4], xpq[:, 2]+xpq[:, 5], scale_factor=2, scale_mode='none')
plotAB.mlab_source.dataset.point_data.scalars = (xpq[:, 0]-min(xpq[:, 0]))/(max(xpq[:, 0])-min(xpq[:, 0]))/5
mlab.show()
