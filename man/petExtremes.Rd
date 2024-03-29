% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/petExtremes.R
\name{petExtremes}
\alias{petExtremes}
\title{PET Extremes}
\usage{
petExtremes(PETstack, precipStack, meantempStack)
}
\arguments{
\item{PETstack}{SpatRaster of monthly PET,
layer names assumed to end in month numbers}

\item{precipStack}{SpatRaster of monthly precipitation}

\item{meantempStack}{SpatRaster of monthly mean temperature}
}
\value{
SpatRaster of PETColdestQuarter, PETWarmestQuarter, PETWettestQuarter, PETDriestQuarter
in mm / month.
}
\description{
Calculates summed PET of the coldest, warmest, wettest and driest quarters.
}
\details{
Generates summed monthly PET for the warmest, coldest, wettest and driest 
3 consecutive months. Previous versions of the envirem package incorrectly 
calculated mean quarterly PET.
}
\examples{
\donttest{
# Find example rasters
rasterFiles <- list.files(system.file('extdata', package='envirem'), full.names=TRUE)
env <- rast(rasterFiles)

# identify the appropriate layers
meantemp <- grep('mean', names(env), value=TRUE)
solar <- grep('solrad', names(env), value=TRUE)
maxtemp <- grep('tmax', names(env), value=TRUE)
mintemp <- grep('tmin', names(env), value=TRUE)
precip <- grep('prec', names(env), value=TRUE)

# read them in as SpatRasters
meantemp <- env[[meantemp]]
solar <- env[[solar]]
maxtemp <- env[[maxtemp]]
mintemp <- env[[mintemp]]
tempRange <- abs(maxtemp - mintemp)
precip <- env[[precip]]

# set up naming scheme - only precip is different from default
assignNames(precip = 'prec_##')

# get monthly PET
pet <- monthlyPET(meantemp, solar, tempRange)

petExtremes(pet, precip, meantemp)

# set back to defaults
assignNames(reset = TRUE)
}
}
\references{
Metzger, M.J., Bunce, R.G.H., Jongman, R.H.G., Sayre, R., Trabucco, A. & Zomer, R. (2013). 
A high-resolution bioclimate map of the world: a unifying framework for global 
biodiversity research and monitoring. \emph{Global Ecology and Biogeography}, 
\strong{22}, 630-638.
}
\seealso{
\code{\link{monthlyPET}}
}
\author{
Pascal Title
}
