## East Coast flooding

There was significant rainfall and flooding on the east coast of Australia
over an approximate 15 day period (23 Feb - 9 Mar) in 2022.

Weatherzone describes some of the records
[here](https://www.weatherzone.com.au/news/how-rare-was-this-rain-and-flooding-event/536508) and
[here](https://www.weatherzone.com.au/news/sydney-gradually-clearing-after-16-day-deluge/536560).

A quick look at the AGCD data (see `AGCD.ipynb`) shows that basically everywhere
east of the Great Dividing Range from the Sunshine Coast to the Vic/NSW border
received significant rain (>200mm) over that 15 day period.

The most appropriate analysis region for Rx15day might therefore be
the South East Coast Topographic Drainage Division
and some of the River Regions within the North East Coast Division.
The BoM provides a [summary](http://www.bom.gov.au/water/about/riverBasinAuxNav.shtml),
of those Divisions and Regions.
The data links that the BoM provides are for geodatabase files,
which I found difficult to work with using geopandas.
Instead,
shapefiles for the Drainage Divisions can be downloaded from the ABS
([here](https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files)) and for the River Regions from Koordinates
([here](https://koordinates.com/layer/741-australias-river-basins-1997/)).

### Subsequent rainfall

There was [more record rainfall later in March](https://www.weatherzone.com.au/news/floodwater-rising-after-250-to-350mm-hits-qld-and-nsw-in-last-24-hours/536798)
so a longer timescale for the analysis might also be appropriate.
