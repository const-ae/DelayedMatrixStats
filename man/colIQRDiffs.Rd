% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/colIQRDiffs.R,
%   R/colMadDiffs.R, R/colSdDiffs.R, R/colVarDiffs.R, R/rowIQRDiffs.R,
%   R/rowMadDiffs.R, R/rowSdDiffs.R, R/rowVarDiffs.R
\docType{methods}
\name{colIQRDiffs}
\alias{colIQRDiffs}
\alias{colMadDiffs}
\alias{colSdDiffs}
\alias{colVarDiffs}
\alias{rowIQRDiffs}
\alias{rowMadDiffs}
\alias{rowSdDiffs}
\alias{rowVarDiffs}
\alias{colIQRDiffs,DelayedMatrix-method}
\alias{colMadDiffs,DelayedMatrix-method}
\alias{colSdDiffs,DelayedMatrix-method}
\alias{colVarDiffs,DelayedMatrix-method}
\alias{rowIQRDiffs,DelayedMatrix-method}
\alias{rowMadDiffs,DelayedMatrix-method}
\alias{rowSdDiffs,DelayedMatrix-method}
\alias{rowVarDiffs,DelayedMatrix-method}
\title{Estimation of scale based on sequential-order differences}
\usage{
colIQRDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE, diff = 1L,
  trim = 0, ...)

colMadDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE, diff = 1L,
  trim = 0, ...)

colSdDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE, diff = 1L,
  trim = 0, ...)

colVarDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE, diff = 1L,
  trim = 0, ...)

rowIQRDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE, diff = 1L,
  trim = 0, ...)

rowMadDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE, diff = 1L,
  trim = 0, ...)

rowSdDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE, diff = 1L,
  trim = 0, ...)

rowVarDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE, diff = 1L,
  trim = 0, ...)

\S4method{colIQRDiffs}{DelayedMatrix}(x, rows = NULL, cols = NULL,
  na.rm = FALSE, diff = 1L, trim = 0,
  force_block_processing = FALSE, ...)

\S4method{colMadDiffs}{DelayedMatrix}(x, rows = NULL, cols = NULL,
  na.rm = FALSE, diff = 1L, trim = 0,
  force_block_processing = FALSE, ...)

\S4method{colSdDiffs}{DelayedMatrix}(x, rows = NULL, cols = NULL,
  na.rm = FALSE, diff = 1L, trim = 0,
  force_block_processing = FALSE, ...)

\S4method{colVarDiffs}{DelayedMatrix}(x, rows = NULL, cols = NULL,
  na.rm = FALSE, diff = 1L, trim = 0,
  force_block_processing = FALSE, ...)

\S4method{rowIQRDiffs}{DelayedMatrix}(x, rows = NULL, cols = NULL,
  na.rm = FALSE, diff = 1L, trim = 0,
  force_block_processing = FALSE, ...)

\S4method{rowMadDiffs}{DelayedMatrix}(x, rows = NULL, cols = NULL,
  na.rm = FALSE, diff = 1L, trim = 0,
  force_block_processing = FALSE, ...)

\S4method{rowSdDiffs}{DelayedMatrix}(x, rows = NULL, cols = NULL,
  na.rm = FALSE, diff = 1L, trim = 0,
  force_block_processing = FALSE, ...)

\S4method{rowVarDiffs}{DelayedMatrix}(x, rows = NULL, cols = NULL,
  na.rm = FALSE, diff = 1L, trim = 0,
  force_block_processing = FALSE, ...)
}
\arguments{
\item{x}{A NxK \linkS4class{DelayedMatrix}.}

\item{rows}{A \code{\link[base]{vector}} indicating subset of
elements (or rows and/or columns) to operate over. If
\code{\link[base]{NULL}}, no subsetting is done.}

\item{cols}{A \code{\link[base]{vector}} indicating subset of
elements (or rows and/or columns) to operate over. If
\code{\link[base]{NULL}}, no subsetting is done.}

\item{na.rm}{If \code{\link[base:logical]{TRUE}}, \code{\link[base]{NA}}s
are excluded, otherwise not.}

\item{diff}{The positional distance of elements for which the difference
should be calculated.}

\item{trim}{A \code{\link[base]{double}} in [0,1/2] specifying the fraction
of observations to be trimmed from each end of (sorted) \code{x} before
estimation.}

\item{...}{Additional arguments passed to specific methods.}

\item{force_block_processing}{\code{FALSE} (the default) means that a
seed-aware, optimised method is used (if available). This can be overridden
to use the general block-processing strategy by setting this to \code{TRUE}
(typically not advised). The block-processing strategy loads one or more
(depending on \code{\link[DelayedArray]{getAutoBlockSize}()}) columns (\code{colFoo()})
or rows (\code{rowFoo()}) into memory as an ordinary \link[base:array]{base::array}.}
}
\value{
Returns a \code{\link[base]{numeric}} \code{\link[base]{vector}} of
length 1, length N, or length K.
}
\description{
Estimation of scale based on sequential-order differences, corresponding to
the scale estimates provided by \code{\link[stats]{var}},
\code{\link[stats]{sd}}, \code{\link[stats]{mad}} and
\code{\link[stats]{IQR}}.
}
\details{
Note that n-order difference MAD estimates, just like the ordinary MAD
estimate by \code{\link[stats]{mad}}, apply a correction factor such that
the estimates are consistent with the standard deviation under Gaussian
distributions.

The interquartile range (IQR) estimates does \emph{not} apply such a
correction factor.  If asymptotically normal consistency is wanted, the
correction factor for IQR estimate is \code{1 / (2 * qnorm(3/4))}, which is
half of that used for MAD estimates, which is \code{1 / qnorm(3/4)}.  This
correction factor needs to be applied manually, i.e. there is no
\code{constant} argument for the IQR functions.
}
\examples{
# A DelayedMatrix with a 'Matrix' seed
dm_Matrix <- DelayedArray(Matrix::Matrix(c(rep(1L, 5),
                                           as.integer((0:4) ^ 2),
                                           seq(-5L, -1L, 1L)),
                                         ncol = 3))
# A DelayedMatrix with a 'SolidRleArraySeed' seed
dm_Rle <- RleArray(Rle(c(rep(1L, 5),
                         as.integer((0:4) ^ 2),
                         seq(-5L, -1L, 1L))),
                   dim = c(5, 3))

colIQRDiffs(dm_Matrix)

colMadDiffs(dm_Matrix)

colSdDiffs(dm_Matrix)

colVarDiffs(dm_Matrix)

# Only using rows 2-4
rowIQRDiffs(dm_Rle, rows = 2:4)

# Only using rows 2-4
rowMadDiffs(dm_Rle, rows = 2:4)

# Only using rows 2-4
rowSdDiffs(dm_Rle, rows = 2:4)

# Only using rows 2-4
rowVarDiffs(dm_Rle, rows = 2:4)
}
\references{
[1] J. von Neumann et al., \emph{The mean square successive
difference}.  Annals of Mathematical Statistics, 1941, 12, 153-162.\cr
}
\seealso{
For the corresponding non-differentiated estimates, see
\code{\link[stats]{var}}, \code{\link[stats]{sd}}, \code{\link[stats]{mad}}
and \code{\link[stats]{IQR}}.  Internally, \code{\link{diff2}}() is used
which is a faster version of \code{\link[base]{diff}}().
}
