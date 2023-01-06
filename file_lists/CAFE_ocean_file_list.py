"""Create CAFE-f6 ocean file list."""

import glob

infiles_1990s = glob.glob('/g/data/xv83/dcfp/CAFE-f6/c5-d60-pX-f6-199[5,6,7,8,9]*/ocean_month.zarr.zip')
infiles_1990s.sort()
infiles_2000s = glob.glob('/g/data/xv83/dcfp/CAFE-f6/c5-d60-pX-f6-2*/ocean_month.zarr.zip')
infiles_2000s.sort()

with open('CAFE_c5-d60-pX-f6_ocean_files.txt', 'a') as outfile:
    for item in infiles_1990s + infiles_2000s:
        outfile.write(f"{item}\n")

