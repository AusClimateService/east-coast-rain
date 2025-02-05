"""Script to generate supplementary information document"""

import glob
from fpdf import FPDF
import xarray as xr


models = [
    'CAFE',
    'CMCC-CM2-SR5',
    'CanESM5',
    'EC-Earth3',
    'HadGEM3-GC31-MM',
    'IPSL-CM6A-LR',
    'MIROC6',
    'MPI-ESM1-2-HR',
    'MRI-ESM2-0',
    'NorCPM1',
]

pdf = FPDF()

# Title page
pdf.add_page()
pdf.set_font("Times", size=14, style='B')
pdf.multi_cell(
    txt="Supplementary Information",
    w=pdf.epw,
    align='L',
    new_x='LEFT'
)
#pdf.ln()
#pdf.set_font("Times", size=12, style='I')
#pdf.multi_cell(
#    txt="Irving et al (submitted). A multi-model likelihood analysis of unprecedented extreme rainfall along the east coast of Australia.",
#    w=pdf.epw,
#    align='L',
#    new_x='LEFT'
#)
#pdf.ln()
#pdf.ln()
pdf.ln()
pdf.set_font("Times", size=11)
pdf.multi_cell(
    txt="This document presents supplementary figures for each of the 10 models used in the study.",
    w=pdf.epw,
    align='L',
    new_x='LEFT'
)

fignum = 0

# Stability and stationarity
pdf.add_page()
pdf.set_font("Times", size=12, style='B')
pdf.multi_cell(
    txt="Stability and stationarity",
    w=pdf.epw,
    align='L',
    new_x='LEFT'
)
pdf.ln()
pdf.set_font("Times", size=11)
for model in models:
    pdf.image(
        glob.glob(f"stability-test-gev_Rx15day_{model}*_annual-aug-to-sep_east-coast-flood-region.png")[0],
        w=0.65 * pdf.epw,
    )
    pdf.ln()
    fignum += 1
    if model == 'CAFE':
        caption = f"Figure S{fignum}: Stability and stationarity evaluation for the {model} model. Return period curves (panels b and d) were derived from a GEV fit to the data. Grey shading illustrates the 95% confidence intervals of the distribution of the pooled lead times, bootstrapped to timeseries of similar length to the individual lead times with n=1,000."
        reference_fig = fignum
    else:
        caption = f"Figure S{fignum}: As per Figure S{reference_fig} but for the {model} model" 
    pdf.multi_cell(txt=caption, w=pdf.epw, new_x='LEFT')
    pdf.ln()
    pdf.ln()
    pdf.ln()

# Independence (do a grid)
pdf.add_page()
pdf.set_font("Times", size=12, style='B')
pdf.multi_cell(
    txt="Independence",
    w=pdf.epw,
    align='L',
    new_x='LEFT'
)
pdf.ln()
pdf.set_font("Times", size=11)
pdf.image("Rx15day_ensemble_independence.png", w=0.65 * pdf.epw)
pdf.ln()
fignum += 1
pdf.multi_cell(
    txt=f"Figure S{fignum}: Independence evaluation for each model. Dots represent the mean Spearman correlation between all combinations of ensemble members at each lead time. Purple shading shows the 95% confidence interval from the estimated distribution for uncorrelated data.",
    w=pdf.epw,
)

# KS and AD tests 
pdf.add_page()
pdf.set_font("Times", size=12, style='B')
pdf.multi_cell(
    txt="Fidelity - test scores",
    w=pdf.epw,
    align='L',
    new_x='LEFT'
)
pdf.ln()
pdf.set_font("Times", size=11)
pdf.multi_cell(
    txt="Table S1: Fidelity test scores for uncorrected model data. A test p-value of greater than 0.05 is taken to indicate that the null hypothesis (that the two samples are from the same population) cannot be rejected, meaning the model data is sufficiently similar to observations to be used in likelihood analysis.",
    w=pdf.epw,
    new_x='LEFT',
)
#col_widths=(20, 20, 20),
with pdf.table(width=0.65 * pdf.epw, text_align=("LEFT", "CENTER", "CENTER"), align='L') as table:
    data_row = ('model', 'Kolmogorov-Smirnov', 'Anderson-Darling')
    row = table.row()
    for datum in data_row:
        row.cell(datum)

    for model in models:
        uncorrected_scores = xr.open_dataset(glob.glob(f"similarity-test_Rx15day_{model}*_annual-aug-to-sep_east-coast-flood-region_AGCD-CSIRO.zarr.zip")[0], engine='zarr')
        uncorrected_ks = float(uncorrected_scores['ks_statistic'].values)
        uncorrected_ks_pval = float(uncorrected_scores['ks_pval'].values)
        uncorrected_ad = float(uncorrected_scores['ad_statistic'].values)
        uncorrected_ad_pval = float(uncorrected_scores['ad_pval'].values)
        data_row = (
            model,
            f"{uncorrected_ks:.2f} (p = {uncorrected_ks_pval:.4f})",
            f"{uncorrected_ad:.2f} (p = {uncorrected_ad_pval:.4f})"
        )
        row = table.row()
        for datum in data_row:
            row.cell(datum)
pdf.ln()
pdf.ln()

pdf.multi_cell(
    txt="Table S2: As per Table S1 but for multiplicative bias corrected model data.",
    w=pdf.epw,
    new_x='LEFT',
)
with pdf.table(width=0.65 * pdf.epw, text_align=("LEFT", "CENTER", "CENTER"), align='L') as table:
    data_row = ('model', 'Kolmogorov-Smirnov', 'Anderson-Darling')
    row = table.row()
    for datum in data_row:
        row.cell(datum)
    for model in models:
        corrected_scores = xr.open_dataset(glob.glob(f"similarity-test_Rx15day_{model}*CSIRO-multiplicative.zarr.zip")[0], engine='zarr')
        corrected_ks = float(corrected_scores['ks_statistic'].values)
        corrected_ks_pval = float(corrected_scores['ks_pval'].values)
        corrected_ad = float(corrected_scores['ad_statistic'].values)
        corrected_ad_pval = float(corrected_scores['ad_pval'].values)
        data_row = (
            model,
            f"{corrected_ks:.2f} (p = {corrected_ks_pval:.4f})",
            f"{corrected_ad:.2f} (p = {corrected_ad_pval:.4f})"
        )
        row = table.row()
        for datum in data_row:
            row.cell(datum)

# Moments test
pdf.add_page()
pdf.set_font("Times", size=12, style='B')
pdf.multi_cell(
    txt="Fidelity - moments test",
    w=pdf.epw,
    align='L',
    new_x='LEFT'
)
pdf.ln()
pdf.set_font("Times", size=11)

for model in models:
    pdf.image(
        glob.glob(f"moments-test_Rx15day_{model}*_annual-aug-to-sep_east-coast-flood-region_bias-corrected-AGCD-CSIRO-multiplicative.png")[0],
        w=0.8 * pdf.epw,
    )
    pdf.ln()
    fignum += 1
    if model == 'CAFE':
        caption = f"Figure S{fignum}: Moments test for the {model} model. Each panel shows the histogram (bars) and 95% confidence interval (dashed lines) derived from 1,000 bootstrap samples of 122 years (the length of the observational Rx15day record) from the model data. The sign convention for the GEV shape parameter is such that negative and positive values correspond to a Frechet and reversed Weibull distribution respectively."
        reference_fig = fignum
    else:
        caption = f"Figure S{fignum}: As per Figure S{reference_fig} but for the {model} model" 
    pdf.multi_cell(txt=caption, w=pdf.epw, new_x='LEFT')
    pdf.ln()
    pdf.ln()
    pdf.ln()

# Fidelity - timing (do a grid)
pdf.add_page()
pdf.set_font("Times", size=12, style='B')
pdf.multi_cell(
    txt="Fidelity - timing",
    w=pdf.epw,
    align='L',
    new_x='LEFT'
)
pdf.ln()
pdf.set_font("Times", size=11)
pdf.image("Rx15day_ensemble_timing.png", w=pdf.epw * 0.65)
pdf.ln()
fignum += 1
pdf.multi_cell(
    txt=f"Figure S{fignum}: Rx15day seasonality for each model.",
    w=pdf.epw,
)

# Fidelity - ENSO (do a grid)
pdf.add_page()
pdf.set_font("Times", size=12, style='B')
pdf.multi_cell(
    txt="Fidelity - ENSO",
    w=pdf.epw,
    align='L',
    new_x='LEFT'
)
pdf.ln()
pdf.set_font("Times", size=11)

pdf.image("Rx15day_ensemble_ENSO.png", w=pdf.epw * 0.7)
pdf.ln()
fignum += 1
pdf.multi_cell(
    txt=f"Figure S{fignum}: Rx15day versus ENSO for each model. Nino 3.4 values above 0.65C and below -0.65C are commonly used as thresholds to designate a El Nino and La Nina events respectively.",
    w=pdf.epw,
)

# Fidelity - MSLP
#pdf.add_page()
#pdf.set_font("Times", size=11)
#pdf.image(
#    f"Rx15day_top3_mslp-pr_{model}.png",
#    w=pdf.epw * 0.7,
#)
#pdf.ln()
#fignum += 1
#pdf.multi_cell(
#    txt=f"Figure S{fignum}: 15-day mean sea level pressure for the top three most extreme Rx15day events from the {model} model.",
#    w=pdf.epw * 0.7,
#)


# Results (do a grid)
pdf.add_page()
pdf.set_font("Times", size=12, style='B')
pdf.multi_cell(
    txt="Likelihood analysis",
    w=pdf.epw,
    align='L',
    new_x='LEFT'
)
pdf.ln()
pdf.set_font("Times", size=11)
pdf.image("Rx15day_ensemble_return-curves.png", w=pdf.epw * 0.65)
pdf.ln()
fignum += 1
pdf.multi_cell(
    txt=f"Figure S{fignum}: Rx15day return periods for each model. The 95% confidence interval (CI) on the GEV fit was derived from 1,000 bootstraps of the model data (of the same sample size as the original model data). The number quoted in the bottom right of each panel is the return period (and 95% CI) for a 410mm event.",
    w=pdf.epw,
)

pdf.output("supplementary_information.pdf")
