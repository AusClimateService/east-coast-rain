"""Create MPI-ESM1-2-HR DCPP file list."""

import glob
import numpy as np

# 2019 left out because it only has 5 of the 10 runs

file_dir = '/g/data/oi10/replicas/CMIP6/DCPP/MPI-M/MPI-ESM1-2-HR/dcppA-hindcast'
for year in np.arange(1960, 2018 + 1):
    infiles1 = glob.glob(f'{file_dir}/s{year}-r?i1p1f1/day/pr/gn/v*/*.nc')
    infiles1.sort()
    infiles2 = glob.glob(f'{file_dir}/s{year}-r??i1p1f1/day/pr/gn/v*/*.nc')
    infiles2.sort()
    with open('MPI-ESM1-2-HR_dcppA-hindcast_files.txt', 'a') as outfile:
        for item in infiles1 + infiles2:
            outfile.write(f"{item}\n")
