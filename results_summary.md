## Overview

## Individual models

### CAFE
- Resolution: coarse (11 grid boxes)
- Ensemble: 96 members, 52 initial dates (1995-2020), 9 lead times 
- Independence: Eliminate first 2 lead times
- Sample size: 34,944
- Fidelity:
  - Raw KS/AD: Fail
  - Add KS/AD: Pass (besides a single AD lead time)
  - Mulc KS/AD: Pass
  - mslp: can get high over NZ :white_check_mark:
  - z500: trough weak and not along coast :question:
  - u300: split jet not in correct location :x: 
- Return period:
  - Raw empirical: N/A
  - Raw GEV: N/A
  - Add empirical: 0 / 34,944 = inf
  - Add GEV: 49,834 years
  - Mulc empirical: 0 / 34,944 = inf
  - Mulc GEV: 1,114 years
- Stationary over decades
- Seasonality: :white_check_mark:
- ENSO: Weak relationship with La Nina :question:

### CanESM5
- Resolution: coarse (6 grid boxes)
- Ensemble: 20 members, 57 initial dates (1961-2017), 9 lead times 
- Independence: All lead times
- Sample size: 10,260
- Fidelity:
  - Raw KS/AD: Fail
  - Add KS/AD: Pass
  - Mulc KS/AD: Pass (by more)
  - mslp: gets high over NZ :white_check_mark:
  - z500: trough not quite along the coast an not deep enough :question:
  - u300: hint of a split jet :question:
- Return period:
  - Raw empirical: N/A
  - Raw GEV: N/A
  - Add empirical: 0/10260 = inf
  - Add GEV: 14,700 years
  - Mulc empirical: 6/10260 = 1710 years
  - Mulc GEV: 1377 years
- Non-stationary over decades
- Seasonality: Jan-Mar peak :white_check_mark:
- ENSO: Trivial relationship with La Nina :x:

### CMCC-CM2-SR5
- Resolution: high (24 grid boxes)
- Ensemble: 10 members, 60 initial dates (1960-2019), 9 lead times 
- Independence: Eliminate first 3 lead times
- Sample size: 3,600
- Fidelity:
  - Raw KS/AD: Pass
  - Add KS/AD: Pass
  - Mulc KS/AD: Pass
  - mslp: high over NZ :white_check_mark:
  - z500: N/A
  - u300: N/A
- Return period:
  - Raw empirical: 0 in 3600 = inf
  - Raw GEV: 6,949 years
  - Add empirical: 0 in 3600 = inf
  - Add GEV: 5,147 years
  - Mulc empirical: 0 in 3600 = inf
  - Mulc GEV: 2,813 years
- Stationary over decades
- Seasonality: :white_check_mark:
- ENSO: Strong relationship with La Nina :white_check_mark:

### EC-Earth3

TODO

### HadGEM3-GC31-MM
- Resolution: very high (53 grid boxes)
- Ensemble: 10 members, 59 initial dates (1960-2018), 9 lead times 
- Independence: All lead times
- Sample size: 5,310
- Fidelity:
  - Raw KS/AD: Fail
  - Add KS/AD: Pass
  - Mulc KS/AD: Pass
  - mslp: gets high over NZ but low near QLD :question:
  - z500: N/A
  - u300: N/A
- Return period:
  - Raw empirical: 0 in 3600 = inf
  - Raw GEV: 6,949 years
  - Add empirical: 1 in 5,310 = 5310 years
  - Add GEV: 2,995 years
  - Mulc empirical: 1 in 5,310 = 5310 years
  - Mulc GEV: 441 years
- Stationary over decades
- Seasonality: :white_check_mark:
- ENSO: Negligible relationship with La Nina :x:

### IPSL-CM6A-LR
- Resolution: TODO re-plot with better color contrast
- Ensemble: 10 members, 57 initial dates (1961-2017), 9 lead times 
- Independence: All lead times
- Sample size: 5,130
- Fidelity:
  - Raw KS/AD: Fail
  - Add KS/AD: Pass
  - Mulc KS/AD: Pass
  - mslp: gets high over NZ :white_check_mark:
  - z500: N/A
  - u300: can get a split jet :white_check_mark: or :question:
- Return period:
  - Raw empirical: 0 in 5130 = inf
  - Raw GEV: 29,397 years
  - Add empirical: 0 in 5130 = inf
  - Add GEV: 12,666 years
  - Mulc empirical: 0 in 5130 = inf
  - Mulc GEV: 3,324 years
- Stationary over decades
- Seasonality: :white_check_mark:
- ENSO: Negligible relationship with La Nina :x:

### MIROC6
- Resolution: medium (18 grid boxes)
- Ensemble: 10 members, 59 initial dates (1960-2018), 9 lead times 
- Independence: All lead times
- Sample size: 5,310
- Fidelity:
  - Raw KS/AD: Passes some but not all lead times
  - Add KS/AD: Passes some but not all lead times
  - Mulc KS/AD: Pass
  - mslp: gets high over NZ but low over QLD :question:
  - z500: weird :x:
  - u300: split jet some but not others :question:
- Return period:
  - Raw empirical: 1/5310 = 5,310 years
  - Raw GEV: 2,099,749 years
  - Add empirical: 1/5310 = 5,310 years
  - Add GEV: 6,178 years
  - Mulc empirical: 1/5310 = 5,310 years
  - Mulc GEV: 2,663 years
- Stationary
- Seasonality: Jan-Mar peak but not such a big trough in winter :white_check_mark: :question:
- ENSO: Strong relationship with La Nina :white_check_mark:

### MPI-ESM1-2-HR
- Resolution: high (31 grid boxes)
- Ensemble: 10 members, 59 initial dates (1960-2018), 9 lead times 
- Independence: All lead times
- Sample size: 5,310
- Fidelity:
  - Raw KS/AD: Fail
  - Add KS/AD: Fails all AD and most KS
  - Mulc KS/AD: Pass
  - mslp: gets high over NZ :white_check_mark:
  - z500: N/A
  - u300: N/A 
- Return period:
  - Raw empirical: N/A
  - Raw GEV: N/A
  - Add empirical: N/A
  - Add GEV: N/A
  - Mulc empirical: 1/5310 = 5,310 years
  - Mulc GEV: 281 years
- Stationary
- Seasonality: :white_check_mark:
- ENSO: N/A

### MRI-ESM2-0
- Resolution: high (25 grid boxes)
- Ensemble: 10 members, 60 initial dates (1960-2019), 4 lead times 
- Sample size: 2,400
- Independence: All lead times
- Fidelity:
  - Raw KS/AD: Fail
  - Add KS/AD: Fail
  - Mulc KS/AD: Pass
  - mslp: gets high over NZ :white_check_mark:
  - z500: N/A
  - u300: N/A 
- Return period:
  - Raw empirical: N/A
  - Raw GEV: N/A
  - Add empirical: N/A
  - Add GEV: N/A
  - Mulc empirical: 0/2400 = inf
  - Mulc GEV: 1,814 years
- Stationary
- Seasonality: :white_check_mark:
- ENSO: Weak relationship with La Nina :question:

### NorCPM1
- Resolution: low (9 grid boxes)
- Ensemble: 20 members, 59 initial dates (1960-2018), 9 lead times 
- Independence: Eliminate first lead time
- Sample size: 9440
- Fidelity:
  - Raw KS/AD: Fail
  - Add KS/AD: Fail
  - Mulc KS/AD: Fails 7/8 AD and 4/8 KS
  - mslp: gets high over NZ but low over QLD :question:
  - z500: N/A
  - u300: N/A 
- Return period:
  - Raw empirical: N/A
  - Raw GEV: N/A
  - Add empirical: N/A
  - Add GEV: N/A
  - Mulc empirical: N/A
  - Mulc GEV: N/A
- Stationary
- Seasonality: :white_check_mark:
- ENSO: FIXME
