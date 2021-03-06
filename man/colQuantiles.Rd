% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/colQuantiles.R,
%   R/rowQuantiles.R
\docType{methods}
\name{colQuantiles}
\alias{colQuantiles}
\alias{rowQuantiles}
\alias{colQuantiles,DelayedMatrix-method}
\alias{rowQuantiles,DelayedMatrix-method}
\title{Estimates quantiles for each row (column) in a matrix}
\usage{
colQuantiles(x, rows = NULL, cols = NULL, probs = seq(from = 0, to =
  1, by = 0.25), na.rm = FALSE, type = 7L, ..., drop = TRUE)

rowQuantiles(x, rows = NULL, cols = NULL, probs = seq(from = 0, to =
  1, by = 0.25), na.rm = FALSE, type = 7L, ..., drop = TRUE)

\S4method{colQuantiles}{DelayedMatrix}(x, rows = NULL, cols = NULL,
  probs = seq(from = 0, to = 1, by = 0.25), na.rm = FALSE, type = 7L,
  force_block_processing = FALSE, ..., drop = TRUE)

\S4method{rowQuantiles}{DelayedMatrix}(x, rows = NULL, cols = NULL,
  probs = seq(from = 0, to = 1, by = 0.25), na.rm = FALSE, type = 7L,
  force_block_processing = FALSE, ..., drop = TRUE)
}
\arguments{
\item{x}{A NxK \linkS4class{DelayedMatrix}.}

\item{rows}{A \code{\link[base]{vector}} indicating subset of rows
(and/or columns) to operate over. If \code{\link[base]{NULL}}, no subsetting
is done.}

\item{cols}{A \code{\link[base]{vector}} indicating subset of rows
(and/or columns) to operate over. If \code{\link[base]{NULL}}, no subsetting
is done.}

\item{probs}{A \code{\link[base]{numeric}} \code{\link[base]{vector}} of J
probabilities in [0, 1].}

\item{na.rm}{If \code{\link[base:logical]{TRUE}}, \code{\link[base]{NA}}s
are excluded first, otherwise not.}

\item{type}{An \code{\link[base]{integer}} specify the type of estimator.
See \code{\link[stats]{quantile}} for more details.}

\item{...}{Additional arguments passed to specific methods.}

\item{drop}{If TRUE, singleton dimensions in the result are dropped,
otherwise not.}

\item{force_block_processing}{\code{FALSE} (the default) means that a
seed-aware, optimised method is used (if available). This can be overridden
to use the general block-processing strategy by setting this to \code{TRUE}
(typically not advised). The block-processing strategy loads one or more
(depending on \code{\link[DelayedArray]{getAutoBlockSize}()}) columns (\code{colFoo()})
or rows (\code{rowFoo()}) into memory as an ordinary \link[base:array]{base::array}.}
}
\value{
Returns a \code{\link[base]{numeric}} NxJ (KxJ)
\code{\link[base]{matrix}}, where N (K) is the number of rows (columns) for
which the J quantiles are calculated.
}
\description{
Estimates quantiles for each row (column) in a matrix.
}
\examples{
# A DelayedMatrix with a 'data.frame' seed
dm_df <- DelayedArray(data.frame(C1 = rep(1L, 5),
                                 C2 = as.integer((0:4) ^ 2),
                                 C3 = seq(-5L, -1L, 1L)))

# colnames, if present, are preserved as rownames on output
colQuantiles(dm_df)

# Input has no rownames so output has no rownames
rowQuantiles(dm_df)
}
\seealso{
\code{\link[stats]{quantile}}.
}
