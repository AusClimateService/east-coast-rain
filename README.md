# East Coast flooding

Code associated with the following paper:

> Damien B Irving, James S. Risbey, Dougal T. Squire, Richard Matear, Carly Tozer, Didier P. Monselesan, Nandini Ramesh, P. Jyoteeshkumar Reddy, Mandy Freund, Annette Stellema (submitted).
> *A multi-model likelihood analysis of unprecedented extreme rainfall along the east coast of Australia.*
> Meteorological Applications.

## Notebooks

#### `prepare_shapefile.ipynb`  
Used to generate the shapefile corresponding to the study region (used by `Makefile`)
and also Figure 1 of the paper.

#### `AGCD_east-coast-flood-region.ipynb`  
Presents the analysis of the observational data.
Created by running the `Makefile` as follows:
```
make rx15day-obs-analysis
```
#### `analysis_{model-name}.ipynb`
Presents the analysis of each model.
Created by creating a file list using the relevant script in the `file_lists/` directory
and then the `Makefile` as follows:
```
make rx15day-forecast-analysis CONFIG=config/config_CanESM5.mk
```
#### `ensemble_figures.ipynb`
Used to generate the figures that appear in the paper summarising the results from all the models.

## Software environment

The command line programs used by the Makefile come from our [UNSEEN package](https://github.com/AusClimateService/unseen).

The two conda environments referred to in the Makefile correspond to
`environment-unseen2.yml` and `environment-unseen-processing.yml`.

