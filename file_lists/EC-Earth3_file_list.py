"""Create EC-Earth3 DCPP file list."""

import glob
import numpy as np

# From 2005-2010 there are no r1i4p1f1 files
# 2018 is left out because it does not have i2 files

file_dir = '/g/data/oi10/replicas/CMIP6/DCPP/EC-Earth-Consortium/EC-Earth3/dcppA-hindcast'
for year in np.arange(1960, 2017 + 1):
    print(year)
    infiles1 = glob.glob(f'{file_dir}/s{year}-r?i1p1f1/day/pr/gr/v202012??/*.nc')
    infiles1.sort()
    print('# r?i1p1f1 files:', len(infiles1))
    infiles2 = glob.glob(f'{file_dir}/s{year}-r10i1p1f1/day/pr/gr/v202012??/*.nc')
    infiles2.sort()
    print('# r10i1p1f1 files:', len(infiles2))
    infiles3 = glob.glob(f'{file_dir}/s{year}-r?i2p1f1/day/pr/gr/*/*.nc')
    infiles3.sort()
    print('# r?i2p1f1 files:', len(infiles3))
    infiles4 = glob.glob(f'{file_dir}/s{year}-r10i2p1f1/day/pr/gr/*/*.nc')
    infiles4.sort()
    print('# r10i2p1f1 files:', len(infiles4))
    #infiles5 = glob.glob(f'{file_dir}/s{year}-r?i4p1f1/day/pr/gr/*/*.nc')
    #infiles5.sort()
    #print('# r?i4p1f1 files:', len(infiles5))
    infiles = infiles1 + infiles2 + infiles3 + infiles4
    #assert len(infiles) == 15 * 11, f'Wrong number of files for year {year}'    
    with open('EC-Earth3_dcppA-hindcast_files.txt', 'a') as outfile:
        for item in infiles:
            outfile.write(f"{item}\n")
