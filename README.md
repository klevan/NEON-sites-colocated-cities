# NEON-sites-colocated-cities
A repo to share code that determines the proximity of NEON sites to US cities

## Background
I've been asked more than once what cities are closest to NEON sampling site locations. The `sp` library has a nice implementation of a distance calculator (using Great Circle distance) and the `maps` library has a simple database of city populations from 2006. 

## Code chunks

- 00 - city_distances.R

Code chunk to generate NEON_sites_and_colocated_cities.csv from NEON field site metadata that includes the following columns: `domainID`,`siteID`,`colocatedSiteID`,`closestCity`,`minDistToCityInKM`,`pop`

## References

  Becker, R.A. and A. R. Wilks. R version by Ray Brownrigg. Enhancements by Thomas P Minka and Alex Deckmyn. (2018). maps: Draw Geographical Maps. R package version 3.3.0. https://CRAN.R-project.org/package=maps

  Pebesma, E.J. and R.S. Bivand, 2005. Classes and methods for spatial data in R. R News 5 (2), https://cran.r-project.org/doc/Rnews/.

  Bivand, R.S., E. Pebesma, Virgilio Gomez-Rubio, 2013. Applied spatial data analysis with R, Second edition. Springer, NY. https://asdar-book.org/

  Wickham et al., (2019). Welcome to the tidyverse. Journal of Open Source Software, 4(43), 1686, https://doi.org/10.21105/joss.01686
