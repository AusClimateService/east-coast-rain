## Overview

### Context

In the observational (AGCD) record,
the unprecedented 2022 RX15day value of 410mm has a return period of 297 years
(calculated from a GEV fit to 122 annual values with a shape,).
There is a strong tendency for RX15day events to occur in February and March
(with the least likely months being Jul-Sep),
and large RX15day values have exclusively occurred in La Nina or ENSO neutral months
(i.e. never during El Nino).

### Model summary

| Model           | Res* | Sample size | shape | loc | scale | mslp | z500 | u300 | Seasonality | ENSO | RP raw | RP add | RP mulc |
| ---             | ---         | ---         | ---   | --- | ---   | ---  | ---  | ---  | ---         | ---  | ---    | ---    | ---     |
| [AGCD](https://github.com/AusClimateService/east-coast-rain/blob/master/AGCD_east-coast-flood-region.ipynb) | | 122 | -0.06 | 143 | 39.3 | | | | | | 297 | | | 
| [CAFE](https://github.com/AusClimateService/east-coast-rain/blob/master/analysis_CAFE.ipynb) | 11 | 34,944 | 0.029 | 98 | 27.5 | :white_check_mark: | :question: | :x: | :white_check_mark: | :question: | Fail | 49,834 | 1,114 |
| [CanESM5](https://github.com/AusClimateService/east-coast-rain/blob/master/analysis_CanESM5.ipynb) | 6 | 10,260 | 0.07 | 117 | 36.9 | :white_check_mark: | :question: | :question: | :white_check_mark: | :x: | Fail | 14,700 | 1,377 |
| [CMCC-CM2-SR5](https://github.com/AusClimateService/east-coast-rain/blob/master/analysis_CMCC-CM2-SR5.ipynb) | 24 | 3,600 | 0.024 | 140 | 34.0 | :white_check_mark: | N/A | N/A | :white_check_mark: | :white_check_mark: | 6,949 | 5,147 | 2,813 |
| [EC-Earth3](https://github.com/AusClimateService/east-coast-rain/blob/master/analysis_EC-Earth3.ipynb) | 51 | 7,830 | 0.043 | 122 | 37.7 | :white_check_mark: | N/A | N/A | :white_check_mark: | :white_check_mark: | Fail | 5,798 | 816 |
| [HadGEM3-GC31-MM](https://github.com/AusClimateService/east-coast-rain/blob/master/analysis_HadGEM3-GC31-MM.ipynb) | 53 | 5,310 | 0.005 | 108 | 33.5 | :question: | N/A | N/A | :white_check_mark: | :x: | Fail | 2,995 | 441 |
| [IPSL-CM6A-LR](https://github.com/AusClimateService/east-coast-rain/blob/master/analysis_IPSL-CM6A-LR.ipynb) | 12 | 5,130 | 0.032 | 131 | 31.9 | :white_check_mark: | N/A | :white_check_mark: :question: | :white_check_mark: | :x: | Fail | 12,666 | 3,324 |
| [MIROC6](https://github.com/AusClimateService/east-coast-rain/blob/master/analysis_MIROC6.ipynb) | 18 | 5,310 | 0.087 | 139 | 32.9 | :question: | :x: | :question: | :white_check_mark: :question: | :x: | PFail | PFail | 2,663 |
| [MPI-ESM1-2-HR](https://github.com/AusClimateService/east-coast-rain/blob/master/analysis_MPI-ESM1-2-HR.ipynb) | 31 | 5,310 | 0.019 | 76.5 | 26.5 | :white_check_mark: | N/A | N/A | :white_check_mark: | N/A | Fail | Fail | 241 |
| [MRI-ESM2-0](https://github.com/AusClimateService/east-coast-rain/blob/master/analysis_MRI-ESM2-0.ipynb) | 25 | 2,400 | 0.044 | 93 | 25.8 | :white_check_mark: | N/A | N/A | :white_check_mark: | :question: | Fail | Fail | 1,814 |
| [NorCPM1](https://github.com/AusClimateService/east-coast-rain/blob/master/analysis_NorCPM1.ipynb) | 9 | 9,440 | 0.034 | 120 | 23.9 | :question: | N/A | N/A | :white_check_mark: | TODO | Fail | Fail | Fail |

*Resolution is the number of grid boxes in the target east coast region  
RP = return period (in years) determined from a GEV fit;
fail means the KS and Anderson Darling tests failed
(pfail means some but not all lead times failed)

### Results

Comments on the UNSEEN methodology in general:
- Different models can produce vastly different return period estimates
- Different bias correction methods can produce vastly different return period estimates
- Commonly used similarity tests tend to produce the same result in the sense that they tend to accept or reject the same models (pending implementation of the moments method)
-  

Comments on the east coast rainfall event:
- Higher resolution models tended to have lower return period estimates
- 


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

- Resolution: very high (51 grid boxes)
- Ensemble: 15 members, 58 initial dates (1960-2017), 9 lead times 
- Independence: All lead times
- Sample size: 7,830
- Fidelity:
  - Raw KS/AD: Fail
  - Add KS/AD: Pass
  - Mulc KS/AD: Pass
  - mslp: gets high over NZ :white_check_mark:
  - z500: N/A
  - u300: N/A
- Return period:
  - Raw empirical: N/A
  - Raw GEV: N/A
  - Add empirical: 2 in 7,830 = 3,915 years
  - Add GEV: 5,798 years
  - Mulc empirical: 2 in 7,830 = 3,915 years
  - Mulc GEV: 816 years
- Stationary over decades
- Seasonality: :white_check_mark:
- ENSO: Strong relationship with La Nina :white_check_mark:

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
  - Raw empirical: N/A
  - Raw GEV: N/A
  - Add empirical: 1 in 5,310 = 5310 years
  - Add GEV: 2,995 years
  - Mulc empirical: 1 in 5,310 = 5310 years
  - Mulc GEV: 441 years
- Stationary over decades
- Seasonality: :white_check_mark:
- ENSO: Negligible relationship with La Nina :x:

### IPSL-CM6A-LR
- Resolution: 12 grid points
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
  - Raw empirical: N/A
  - Raw GEV: N/A
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
