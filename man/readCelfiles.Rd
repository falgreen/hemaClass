% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/readCelfiles.R
\name{readCelfiles}
\alias{readCelfiles}
\title{Read \code{.CEL} files into a matrix}
\usage{
readCelfiles(filenames, cdfname = NULL, rm.mask = FALSE,
  rm.outliers = FALSE, rm.extra = FALSE, verbose = FALSE,
  which = c("pm", "mm", "both"))
}
\arguments{
\item{filenames}{File names in a character vector.}

\item{cdfname}{Used to specify the name of an alternative cdf package. If set
to \code{NULL}, then the usual cdf package based on Affymetrix' mappings 
will be used.}

\item{rm.mask}{Should the spots marked as \code{'MASKS'} set to \code{NA}?}

\item{rm.outliers}{Should the spots marked as \code{'OUTLIERS'} set to 
\code{NA}?}

\item{rm.extra}{If \code{TRUE}, then overrides what is in \code{rm.mask} and 
\code{rm.oultiers}.}

\item{verbose}{logical. Should file names be written as they are read into R.}

\item{which}{A \code{character} determining if \code{pm}, \code{mm}, or 
\code{both} probes be stored in matrices.}
}
\value{
Expression matrix consisting of all \code{pm} probes.
}
\description{
Affymetrix \code{.CEL} files given in the argument filenames are read 
into a \code{matrix} in R.
}
\details{
Load \code{.CEL} files into a matrix.
}
\examples{

# Read hgu133plus2 .CEL files into R 
\donttest{
files <- dir(system.file("extdata/celfiles", package = "hemaClass"), 
             full.names = TRUE)
CEL.data <- readCelfiles(files) 
}

}
\references{
Reference to the hemaClass.com paper
}
\seealso{
For preprocessing of the cel files see 
  \code{\link{rmaPreprocessing}}.
}
\author{
Steffen Falgreen <sfl (at) rn.dk> \cr 
  Anders Ellern Bilgrau <abilgrau (at) math.aau.dk>
}
