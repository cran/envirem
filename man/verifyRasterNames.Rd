% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/verifyRasterNames.R
\name{verifyRasterNames}
\alias{verifyRasterNames}
\title{Verify Raster Names}
\usage{
verifyRasterNames(
  masterstack = NULL,
  solradstack = NULL,
  returnRasters = FALSE
)
}
\arguments{
\item{masterstack}{rasterStack containing all precipitation, 
min temperature, max temperature, and (optionally) mean temperature variables.}

\item{solradstack}{rasterStack of monthly solar radiation}

\item{returnRasters}{if \code{FALSE}, the function checks names
and reports back. If \code{TRUE}, a RasterStack is returned with
standardized names.}
}
\value{
Prints messages to the console if \code{returnRasters = FALSE}, 
If \code{returnRasters = TRUE}, then a RasterStack is returned. This RasterStack
will not include rasters that were deemed unnecessary.
}
\description{
Given a RasterStack, this function will verify the
naming scheme and check that all required rasters are present.
}
\details{
This function checks that the following are present:

12 precipitation rasters

12 min temperature rasters

12 max temperature rasters

12 mean temperature rasters [optional]

12 solar radiation rasters

The naming scheme will be checked against the one 
defined via the custom naming environment. See \code{link{?assignNames}}
for additional details.

The function can test the temp/precip rasterstack
and/or the solar radiation rasterstack separately, or simultaneously.
}
\examples{
# Find example rasters
rasterFiles <- list.files(system.file('extdata', package='envirem'), full.names=TRUE)

# create stack of temperature and precipitation rasters
# and stack of solar radiation rasters
solradFiles <- grep('solrad', rasterFiles, value=TRUE)
worldclim <- stack(setdiff(rasterFiles, solradFiles))
solar <- stack(solradFiles)

# modify naming
names(worldclim) <- gsub('tmin_', 'minTemp', names(worldclim))
names(worldclim) <- paste0(names(worldclim), '_v1.0')
names(solar) <- gsub('et_solrad_', 'solar_', names(solar))

# but don't specify this change
varnames()

# Run check
verifyRasterNames(masterstack = worldclim, solradstack = solar, returnRasters = FALSE)

# But if we specify our naming scheme
assignNames(tmin = 'minTemp##_v1.0', tmax = 'tmax_##_v1.0', tmean = 'tmean_##_v1.0', 
	solrad = 'solar_##', precip = 'prec_##_v1.0')
varnames()

verifyRasterNames(masterstack = worldclim, solradstack = solar, returnRasters = FALSE)

# set back to defaults
assignNames(reset = TRUE)

}
\author{
Pascal Title
}
