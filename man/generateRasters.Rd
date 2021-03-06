% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generateRasters.R
\name{generateRasters}
\alias{generateRasters}
\title{Execute Layer Creation}
\usage{
generateRasters(
  var,
  maindir,
  prefix = "",
  outputDir = "./",
  rasterExt = ".tif",
  nTiles = 1,
  tempScale = 1,
  precipScale = 1,
  overwriteResults = TRUE,
  outputFormat = "GTiff",
  tempDir = "~/temp",
  gdalinfoPath = NULL,
  gdal_translatePath = NULL,
  useCompression = TRUE
)
}
\arguments{
\item{var}{a vector of variable names to generate, see Details.}

\item{maindir}{path to directory of input rasters}

\item{prefix}{prefix to append to output filename}

\item{outputDir}{output directory.}

\item{rasterExt}{the file extension of the input rasters}

\item{nTiles}{the number of tiles to split the rasters when 
tiling is requested, must be a perfect square}

\item{tempScale}{integer; scaling factor for the temperature data, see \link{envirem} for 
additional details.}

\item{precipScale}{integer; scaling factor for the precipitation data, see \link{envirem}
for additional details.}

\item{overwriteResults}{logical, should existing rasters be overwritten}

\item{outputFormat}{output format for rasters, see \code{\link{writeRaster}} for options}

\item{tempDir}{temporary directory for raster tiles that will be created and then removed}

\item{gdalinfoPath}{path to gdalinfo binary, leave as \code{NULL} if it is in the default search path.}

\item{gdal_translatePath}{path to gdal_translate binary, leave as \code{NULL} if it is in the default search path.}

\item{useCompression}{logical; should compression options be used to achieve smaller file sizes.
Only pertains to format GTiff.}
}
\value{
The requested set of rasterLayers will be written to \code{outputDir}.
}
\description{
Main function to generate specified ENVIREM layers.
If requested, this function will split input rasters into tiles, generate desired variables,
and reassemble the results. 
For the distinction between this function and \code{\link{layerCreation}}, 
see \code{Details}.
}
\details{
The function \code{\link{layerCreation}} will generate envirem rasters from input R 
objects (rasterStacks) and will return the result as an R object. In contrast, 
the function \code{generateRasters} reads in input rasters from a specified directory, 
splits input rasters into tiles if necessary, internally calls 
\code{\link{layerCreation}} and writes the result to file. 

Possible variables to generate include:\cr
\cr
annualPET \cr
aridityIndexThornthwaite \cr
climaticMoistureIndex \cr
continentality \cr
embergerQ \cr
growingDegDays0 \cr
growingDegDays5 \cr
maxTempColdest \cr
minTempWarmest \cr
meanTempColdest \cr
meanTempWarmest \cr
monthCountByTemp10 \cr
PETColdestQuarter \cr
PETDriestQuarter \cr
PETseasonality \cr
PETWarmestQuarter \cr
PETWettestQuarter \cr
thermicityIndex \cr

If \code{var = 'all'}, then all of the variables will be generated.


Rasters in \code{mainDir} should be named appropriately (see \code{\link{verifyFileStructure}})
and with identical resolution, origin and extent. 

Output rasters are written with the most appropriate \code{\link{dataType}}, as 
inferred with \code{\link{dataTypeCheck}}. This will reduce the file size of these rasters. 

If the goal is to use these rasters with the standalone Maxent program, we recommend 
\code{outputFormat = 'EHdr'}.

\strong{IMPORTANT}: Temporary files can quickly fill up your hard drive when working with
	large rasters. There are two temporary directories to consider for this function: The
	\code{tempDir} directory defined as an argument in this function is used for storing
	intermediate files when splitting rasters into tiles (and is ignored if \code{nTiles = 1}).
	The raster package will use another directory for storing temporary rasters. This can be 
	can be viewed with \code{rasterOptions()}, and can be set with 
	\code{rasterOptions(tmpdir = 'path-to-dir')}. Be sure that this is pointing to a directory
	with plenty of available space. Both temporary directories are automatically cleared.
}
\seealso{
Naming of rasters in inputDir will be checked with \code{\link{verifyFileStructure}}.
}
\author{
Pascal Title
}
