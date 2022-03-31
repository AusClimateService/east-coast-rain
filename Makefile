.PHONY: help

include ${MODEL_CONFIG}
#Model config file needs to define MODEL, MODEL_IO_OPTIONS (optional) MIN_LEAD,
#BIAS_METHOD, BASE_PERIOD, BASE_PERIOD_TEXT and TIME_PERIOD_TEXT
include ${REGION_CONFIG}
#Region config file nees to define SHAPEFILE and REGION_NAME

PROJECT_DIR=/g/data/xv83/dbi599/east-coast-rain
VAR=pr
BIAS_METHOD=multiplicative
DASK_CONFIG=dask_local.yml
IO_OPTIONS=--variables ${VAR} --shapefile ${SHAPEFILE} --spatial_agg mean  --rolling_sum_window 15 --time_freq A-AUG --time_agg max --input_freq D
OBS_FILES=/g/data/xv83/agcd-csiro/precip/precip-total_AGCD-CSIRO_r005_*_daily.nc
OBS_CONFIG=/home/599/dbi599/forks/unseen/config/dataset_agcd_daily.yml
RX15DAY_OBS=${PROJECT_DIR}/data/Rx15day_AGCD-CSIRO_r005_1900-2022_annual-aug-to-sep_${REGION_NAME}.zarr.zip
FCST_DATA=file_lists/${MODEL}_${EXPERIMENT}_files.txt
RX15DAY_FCST=${PROJECT_DIR}/data/Rx15day_${MODEL}-${EXPERIMENT}_${TIME_PERIOD_TEXT}_annual-aug-to-sep_${REGION_NAME}.zarr.zip
INDEPENDENCE_PLOT=${PROJECT_DIR}/figures/independence-test_Rx15day_${MODEL}-${EXPERIMENT}_${TIME_PERIOD_TEXT}_annual-aug-to-sep_${REGION_NAME}.png
RX15DAY_FCST_BIAS_CORRECTED=${PROJECT_DIR}/data/Rx15day_${MODEL}-${EXPERIMENT}_${TIME_PERIOD_TEXT}_annual-aug-to-sep_${REGION_NAME}_bias-corrected-AGCD-CSIRO-${BIAS_METHOD}.zarr.zip
SIMILARITY_BIAS=${PROJECT_DIR}/data/ks-test_Rx15day_${MODEL}-${EXPERIMENT}_${BASE_PERIOD_TEXT}_annual-aug-to-sep_${REGION_NAME}_bias-corrected-AGCD-CSIRO-${BIAS_METHOD}.zarr.zip
SIMILARITY_RAW=${PROJECT_DIR}/data/ks-test_Rx15day_${MODEL}-${EXPERIMENT}_${BASE_PERIOD_TEXT}_annual-aug-to-sep_${REGION_NAME}_AGCD-CSIRO.zarr.zip


## rx15day-obs : calculate Rx15day in observations
rx15day-obs : ${RX15DAY_OBS}
${RX15DAY_OBS} : 
	fileio ${OBS_FILES} $@ ${IO_OPTIONS} --metadata_file ${OBS_CONFIG} --verbose

## rx15day-forecast : calculate Rx15day in forecast ensemble
rx15day-forecast : ${RX15DAY_FCST}
${RX15DAY_FCST} : ${FCST_DATA}
	fileio $< $@ --forecast ${IO_OPTIONS} ${MODEL_IO_OPTIONS} --reset_times --complete_time_agg_periods --output_chunks lead_time=50 --dask_config ${DASK_CONFIG} --verbose

## independence-test : independence test for different lead times
independence-test : ${INDEPENDENCE_PLOT}
${INDEPENDENCE_PLOT} : ${RX3DAY_FCST}
	independence $< ${VAR} $@

## bias-correction : bias corrected forecast data using observations
bias-correction : ${RX15DAY_FCST_BIAS_CORRECTED}
${RX15DAY_FCST_BIAS_CORRECTED} : ${RX15DAY_FCST} ${RX15DAY_OBS}
	bias_correction $< $(word 2,$^) ${VAR} ${BIAS_METHOD} $@ --base_period ${BASE_PERIOD} --rounding_freq A --min_lead ${MIN_LEAD}

## similarity-test-bias : similarity test between observations and bias corrected forecast
similarity-test-bias : ${SIMILARITY_BIAS}
${SIMILARITY_BIAS} : ${RX3DAY_FCST_BIAS_CORRECTED} ${RX15DAY_OBS}
	similarity $< $(word 2,$^) ${VAR} $@ --reference_time_period ${BASE_PERIOD}

## similarity-test-raw : similarity test between observations and raw forecast
similarity-test-raw : ${SIMILARITY_RAW}
${SIMILARITY_RAW} : ${RX15DAY_FCST} ${RX15DAY_OBS}
	similarity $< $(word 2,$^) ${VAR} $@ --reference_time_period ${BASE_PERIOD}

## analysis : do the final analysis
analysis : analysis/analysis_${MODEL}.ipynb
analysis/analysis_${MODEL}.ipynb : analysis/analysis.ipynb ${OBS_NC_DATA} ${FCST_ENSEMBLE_FILE} ${FCST_BIAS_FILE} ${SIMILARITY_BIAS_FILE} ${SIMILARITY_RAW_FILE} ${INDEPENDENCE_PLOT}
	papermill -p bom_file $(word 2,$^) -p model_file $(word 3,$^) -p model_bc_file $(word 4,$^) -p similarity_bc_file $(word 5,$^) -p similarity_raw_file $(word 6,$^) -p independence_plot $(word 7,$^) -p model_name ${MODEL} -p min_lead ${MIN_LEAD} $< $@

## help : show this message
help :
	@echo 'make [target] [-Bnf] MODEL_CONFIG=config_file.mk REGION_CONFIG=config_file.mk'
	@echo ''
	@echo 'valid targets:'
	@grep -h -E '^##' ${MAKEFILE_LIST} | sed -e 's/## //g' | column -t -s ':'
