.PHONY: help moments

include ${CONFIG}

PROJECT_DIR=/g/data/xv83/dbi599/east-coast-rain
VAR=pr
DASK_CONFIG=dask_local.yml
SHAPEFILE=/g/data/xv83/dbi599/east-coast-rain/shapefiles/east-coast-flood.shp
REGION_NAME=east-coast-flood-region

RX15DAY_OPTIONS_FCST=--lat_bnds -40 -20 --lon_bnds 140 160 --shp_overlap 0.1 --output_chunks lead_time=50
RX15DAY_OPTIONS=--variables ${VAR} --spatial_agg weighted_mean --rolling_sum_window 15 --shapefile ${SHAPEFILE} --time_freq A-AUG --time_agg max --input_freq D --units_timing middle --reset_times --complete_time_agg_periods --dask_config ${DASK_CONFIG} --verbose --time_agg_dates --units pr='mm day-1'
OBS_CONFIG=/home/599/dbi599/unseen/config/dataset_agcd_daily.yml
RX15DAY_OBS=${PROJECT_DIR}/data/Rx15day_AGCD-CSIRO_r005_1900-2022_annual-aug-to-sep_${REGION_NAME}.zarr.zip
SST_OBS=/g/data/ia39/aus-ref-clim-data-nci/hadisst/data/HadISST_sst.nc
NINO_FCST=${PROJECT_DIR}/data/nino34-anomaly_${MODEL}-${EXPERIMENT}_${TIME_PERIOD_TEXT}_base-${BASE_PERIOD_TEXT}.nc
NINO_OBS=${PROJECT_DIR}/data/nino34-anomaly_HadISST_1870-2022_base-1981-2010.nc
FCST_DATA=/home/599/dbi599/east-coast-rain/file_lists/${MODEL}_${EXPERIMENT}_pr_files.txt
FCST_TOS_DATA=/home/599/dbi599/east-coast-rain/file_lists/${MODEL}_${EXPERIMENT}_tos_files.txt
OBS_DATA := $(sort $(wildcard /g/data/xv83/agcd-csiro/precip/daily/precip-total_AGCD-CSIRO_r005_*_daily.nc))
RX15DAY_FCST=${PROJECT_DIR}/data/Rx15day_${MODEL}-${EXPERIMENT}_${TIME_PERIOD_TEXT}_annual-aug-to-sep_${REGION_NAME}.zarr.zip
INDEPENDENCE_PLOT=${PROJECT_DIR}/figures/independence-test_Rx15day_${MODEL}-${EXPERIMENT}_${TIME_PERIOD_TEXT}_annual-aug-to-sep_${REGION_NAME}.png
STABILITY_PLOT_EMPIRICAL=${PROJECT_DIR}/figures/stability-test-empirical_Rx15day_${MODEL}-${EXPERIMENT}_${TIME_PERIOD_TEXT}_annual-aug-to-sep_${REGION_NAME}.png
STABILITY_PLOT_GEV=${PROJECT_DIR}/figures/stability-test-gev_Rx15day_${MODEL}-${EXPERIMENT}_${TIME_PERIOD_TEXT}_annual-aug-to-sep_${REGION_NAME}.png
RX15DAY_FCST_ADDITIVE_BIAS_CORRECTED=${PROJECT_DIR}/data/Rx15day_${MODEL}-${EXPERIMENT}_${TIME_PERIOD_TEXT}_annual-aug-to-sep_${REGION_NAME}_bias-corrected-AGCD-CSIRO-additive.zarr.zip
RX15DAY_FCST_MULTIPLICATIVE_BIAS_CORRECTED=${PROJECT_DIR}/data/Rx15day_${MODEL}-${EXPERIMENT}_${TIME_PERIOD_TEXT}_annual-aug-to-sep_${REGION_NAME}_bias-corrected-AGCD-CSIRO-multiplicative.zarr.zip
SIMILARITY_ADDITIVE_BIAS=${PROJECT_DIR}/data/similarity-test_Rx15day_${MODEL}-${EXPERIMENT}_${BASE_PERIOD_TEXT}_annual-aug-to-sep_${REGION_NAME}_bias-corrected-AGCD-CSIRO-additive.zarr.zip
SIMILARITY_MULTIPLICATIVE_BIAS=${PROJECT_DIR}/data/similarity-test_Rx15day_${MODEL}-${EXPERIMENT}_${BASE_PERIOD_TEXT}_annual-aug-to-sep_${REGION_NAME}_bias-corrected-AGCD-CSIRO-multiplicative.zarr.zip
SIMILARITY_RAW=${PROJECT_DIR}/data/similarity-test_Rx15day_${MODEL}-${EXPERIMENT}_${BASE_PERIOD_TEXT}_annual-aug-to-sep_${REGION_NAME}_AGCD-CSIRO.zarr.zip
MOMENTS_ADDITIVE_BIAS_PLOT=${PROJECT_DIR}/figures/moments-test_Rx15day_${MODEL}-${EXPERIMENT}_${BASE_PERIOD_TEXT}_annual-aug-to-sep_${REGION_NAME}_bias-corrected-AGCD-CSIRO-additive.png
MOMENTS_MULTIPLICATIVE_BIAS_PLOT=${PROJECT_DIR}/figures/moments-test_Rx15day_${MODEL}-${EXPERIMENT}_${BASE_PERIOD_TEXT}_annual-aug-to-sep_${REGION_NAME}_bias-corrected-AGCD-CSIRO-multiplicative.png
MOMENTS_RAW_PLOT=${PROJECT_DIR}/figures/moments-test_Rx15day_${MODEL}-${EXPERIMENT}_${BASE_PERIOD_TEXT}_annual-aug-to-sep_${REGION_NAME}_AGCD-CSIRO.png

FILEIO=/g/data/xv83/dbi599/miniconda3/envs/unseen-processing/bin/fileio
PAPERMILL=/g/data/xv83/dbi599/miniconda3/envs/unseen2/bin/papermill
INDEPENDENCE=/g/data/xv83/dbi599/miniconda3/envs/unseen-processing/bin/independence
STABILITY=/g/data/xv83/dbi599/miniconda3/envs/unseen2/bin/stability
BIAS_CORRECTION=/g/data/xv83/dbi599/miniconda3/envs/unseen-processing/bin/bias_correction
SIMILARITY=/g/data/xv83/dbi599/miniconda3/envs/unseen-processing/bin/similarity
MOMENTS=/g/data/xv83/dbi599/miniconda3/envs/unseen-processing/bin/moments


## rx15day-obs : calculate Rx15day in observations
rx15day-obs : ${RX15DAY_OBS}
${RX15DAY_OBS} :
	${FILEIO} ${OBS_DATA} $@ ${RX15DAY_OPTIONS} --metadata_file /home/599/dbi599/unseen/config/dataset_agcd_daily.yml

## nino34-obs : calculate Nino 3.4 in observations
nino34-obs : ${NINO_OBS}
${NINO_OBS} :
	${FILEIO} ${SST_OBS} $@ --variables sst --spatial_agg mean --lat_bnds -5 5 --lon_bnds -170 -120 --lat_dim latitude --lon_dim longitude --anomaly 1980-01-01 2009-12-31 --anomaly_freq month --verbose

## rx15day-obs-analysis : analyse Rx15day in observations
rx15day-obs-analysis : AGCD_${REGION_NAME}.ipynb
AGCD_${REGION_NAME}.ipynb : AGCD.ipynb ${RX15DAY_OBS} ${NINO_OBS}
	${PAPERMILL} -p rx15day_file $(word 2,$^) -p region_name ${REGION_NAME} -p nino_file $(word 3,$^) $< $@	

## rx15day-forecast : calculate Rx15day in forecast ensemble
rx15day-forecast : ${RX15DAY_FCST}
${RX15DAY_FCST} : ${FCST_DATA}
	${FILEIO} $< $@ --forecast ${RX15DAY_OPTIONS} ${RX15DAY_OPTIONS_FCST} ${MODEL_IO_OPTIONS}

## independence-test : independence test for different lead times
independence-test : ${INDEPENDENCE_PLOT}
${INDEPENDENCE_PLOT} : ${RX15DAY_FCST}
	${INDEPENDENCE} $< ${VAR} $@

## stability-test-empirical : stability tests (empirical)
stability-test-empirical : ${STABILITY_PLOT_EMPIRICAL}
${STABILITY_PLOT_EMPIRICAL} : ${RX15DAY_FCST}
	${STABILITY} $< ${VAR} Rx15day --start_years ${STABILITY_START_YEARS} --outfile $@ --return_method empirical --uncertainty --units "Rx15day (mm)" --ymax 550

## stability-test-gev : stability tests (GEV fit)
stability-test-gev : ${STABILITY_PLOT_GEV}
${STABILITY_PLOT_GEV} : ${RX15DAY_FCST}
	${STABILITY} $< ${VAR} Rx15day --start_years ${STABILITY_START_YEARS} --outfile $@ --return_method gev --uncertainty --units "Rx15day (mm)" --ymax 550

## bias-correction-additive : additive bias corrected forecast data using observations
bias-correction : ${RX15DAY_FCST_ADDITIVE_BIAS_CORRECTED}
${RX15DAY_FCST_ADDITIVE_BIAS_CORRECTED} : ${RX15DAY_FCST} ${RX15DAY_OBS}
	${BIAS_CORRECTION} $< $(word 2,$^) ${VAR} additive $@ --base_period ${BASE_PERIOD} --rounding_freq A --min_lead ${MIN_LEAD}

## bias-correction-multiplicative : multiplicative bias corrected forecast data using observations
bias-correction : ${RX15DAY_FCST_MULTIPLICATIVE_BIAS_CORRECTED}
${RX15DAY_FCST_MULTIPLICATIVE_BIAS_CORRECTED} : ${RX15DAY_FCST} ${RX15DAY_OBS}
	${BIAS_CORRECTION} $< $(word 2,$^) ${VAR} multiplicative $@ --base_period ${BASE_PERIOD} --rounding_freq A --min_lead ${MIN_LEAD}

## similarity-test-additive-bias : similarity test between observations and additive bias corrected forecast
similarity-test-additive-bias : ${SIMILARITY_ADDITIVE_BIAS}
${SIMILARITY_ADDITIVE_BIAS} : ${RX15DAY_FCST_ADDITIVE_BIAS_CORRECTED} ${RX15DAY_OBS}
	${SIMILARITY} $< $(word 2,$^) ${VAR} $@ --reference_time_period ${BASE_PERIOD} --min_lead ${MIN_LEAD}

## similarity-test-multiplicative-bias : similarity test between observations and multiplicative bias corrected forecast
similarity-test-multiplicative-bias : ${SIMILARITY_MULTIPLICATIVE_BIAS}
${SIMILARITY_MULTIPLICATIVE_BIAS} : ${RX15DAY_FCST_MULTIPLICATIVE_BIAS_CORRECTED} ${RX15DAY_OBS}
	${SIMILARITY} $< $(word 2,$^) ${VAR} $@ --reference_time_period ${BASE_PERIOD} --min_lead ${MIN_LEAD}

## similarity-test-raw : similarity test between observations and raw forecast
similarity-test-raw : ${SIMILARITY_RAW}
${SIMILARITY_RAW} : ${RX15DAY_FCST} ${RX15DAY_OBS}
	${SIMILARITY} $< $(word 2,$^) ${VAR} $@ --reference_time_period ${BASE_PERIOD} --min_lead ${MIN_LEAD}

## moments-test-additive-bias : moments test between observations and additive bias corrected forecast
moments-test-additive-bias : ${MOMENTS_ADDITIVE_BIAS_PLOT}
${MOMENTS_ADDITIVE_BIAS_PLOT} : ${RX15DAY_FCST_ADDITIVE_BIAS_CORRECTED} ${RX15DAY_OBS}
	${MOMENTS} $< $(word 2,$^) ${VAR} --outfile $@ --min_lead ${MIN_LEAD} --units mm

## moments-test-multiplicative-bias : moments test between observations and multiplicative bias corrected forecast
moments-test-multiplicative-bias : ${MOMENTS_MULTIPLICATIVE_BIAS_PLOT}
${MOMENTS_MULTIPLICATIVE_BIAS_PLOT} : ${RX15DAY_FCST} ${RX15DAY_OBS} ${RX15DAY_FCST_MULTIPLICATIVE_BIAS_CORRECTED} 
	${MOMENTS} $< $(word 2,$^) ${VAR} --outfile $@ --bias_file $(word 3,$^) --min_lead ${MIN_LEAD} --units mm

## moments-test-raw : moments test between observations and raw forecast
moments-test-raw : ${MOMENTS_RAW_PLOT}
${MOMENTS_RAW_PLOT} : ${RX15DAY_FCST} ${RX15DAY_OBS}
	${MOMENTS} $< $(word 2,$^) ${VAR} --outfile $@ --min_lead ${MIN_LEAD} --units mm

## nino34-forecast : calculate Nino 3.4 in forecast ensemble
nino34-forecast : ${NINO_FCST}
${NINO_FCST} : ${FCST_TOS_DATA}
	${FILEIO} $< $@ --forecast --variables tos --spatial_agg mean --lat_bnds -5 5 --verbose ${MODEL_NINO_OPTIONS} 

## rx15day-forecast-analysis : analysis of rx15day from forecast data
rx15day-forecast-analysis : analysis_${MODEL}.ipynb
analysis_${MODEL}.ipynb : analysis.ipynb ${RX15DAY_OBS} ${RX15DAY_FCST} ${RX15DAY_FCST_ADDITIVE_BIAS_CORRECTED} ${RX15DAY_FCST_MULTIPLICATIVE_BIAS_CORRECTED} ${SIMILARITY_ADDITIVE_BIAS} ${SIMILARITY_MULTIPLICATIVE_BIAS} ${SIMILARITY_RAW} ${INDEPENDENCE_PLOT} ${STABILITY_PLOT} ${FCST_DATA} ${NINO_FCST}
	${PAPERMILL} -p agcd_file $(word 2,$^) -p model_file $(word 3,$^) -p model_add_bc_file $(word 4,$^) -p model_mulc_bc_file $(word 5,$^) -p similarity_add_bc_file $(word 6,$^) -p similarity_mulc_bc_file $(word 7,$^) -p similarity_raw_file $(word 8,$^) -p independence_plot $(word 9,$^) -p stability_plot $(word 10,$^) -p model_name ${MODEL} -p min_lead ${MIN_LEAD} -p region_name ${REGION_NAME} -p shape_file ${SHAPEFILE} -p file_list $(word 11,$^) -p nino_file $(word 12,$^) $< $@

moments : ${MOMENTS_ADDITIVE_BIAS_PLOT} ${MOMENTS_MULTIPLICATIVE_BIAS_PLOT} ${MOMENTS_RAW_PLOT}

## help : show this message
help :
	@echo 'make [target] [-Bnf] CONFIG=config_file.mk'
	@echo ''
	@echo 'valid targets:'
	@grep -h -E '^##' ${MAKEFILE_LIST} | sed -e 's/## //g' | column -t -s ':'
