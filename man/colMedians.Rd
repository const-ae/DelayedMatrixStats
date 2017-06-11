% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/colMedians.R
\docType{methods}
\name{colMedians}
\alias{colMedians}
\alias{colMedians,matrix-method}
\alias{colMedians,Matrix-method}
\alias{colMedians,data.frame-method}
\alias{colMedians,DataFrame-method}
\alias{colMedians,DelayedMatrix-method}
\alias{colMedians,ANY-method}
\title{Calculates the median for each row (column) in a matrix}
\usage{
colMedians(x, rows = NULL, cols = NULL, na.rm = FALSE, dim. = dim(x),
  ...)

\S4method{colMedians}{matrix}(x, rows = NULL, cols = NULL, na.rm = FALSE,
  dim. = dim(x), ...)

\S4method{colMedians}{Matrix}(x, rows = NULL, cols = NULL, na.rm = FALSE,
  dim. = dim(x), ...)

\S4method{colMedians}{data.frame}(x, rows = NULL, cols = NULL,
  na.rm = FALSE, dim. = dim(x), ...)

\S4method{colMedians}{DataFrame}(x, rows = NULL, cols = NULL,
  na.rm = FALSE, dim. = dim(x), ...)

\S4method{colMedians}{DelayedMatrix}(x, rows = NULL, cols = NULL,
  na.rm = FALSE, dim. = dim(x), ...)

\S4method{colMedians}{ANY}(x, rows = NULL, cols = NULL, na.rm = FALSE,
  dim. = dim(x), ...)
}
\arguments{
\item{x}{A \code{\link[base]{numeric}} NxK \code{\link[base]{matrix}}.}

\item{rows}{A \code{\link[base]{vector}} indicating subset of rows
(and/or columns) to operate over. If \code{\link[base]{NULL}}, no subsetting
is done.}

\item{cols}{A \code{\link[base]{vector}} indicating subset of rows
(and/or columns) to operate over. If \code{\link[base]{NULL}}, no subsetting
is done.}

\item{na.rm}{If \code{\link[base:logical]{TRUE}}, \code{\link[base]{NA}}s
are excluded first, otherwise not.}

\item{dim.}{An \code{\link[base]{integer}} \code{\link[base]{vector}} of
length two specifying the dimension of \code{x}, also when not a
\code{\link[base]{matrix}}.}

\item{...}{Not used.}
}
\value{
Returns a \code{\link[base]{numeric}} \code{\link[base]{vector}} of
length N (K).
}
\description{
Calculates the median for each row (column) in a matrix.
}
\details{
The implementation of \code{rowMedians()} and \code{colMedians()} is
optimized for both speed and memory.  To avoid coercing to
\code{\link[base]{double}}s (and hence memory allocation), there is a
special implementation for \code{\link[base]{integer}} matrices.  That is,
if \code{x} is an \code{\link[base]{integer}} \code{\link[base]{matrix}},
then \code{rowMedians(as.double(x))} (\code{rowMedians(as.double(x))}) would
require three times the memory of \code{rowMedians(x)}
(\code{colMedians(x)}), but all this is avoided.
}
\seealso{
See \code{\link{rowMedians}}() and \code{colMedians()} for weighted
medians.  For mean estimates, see \code{rowMeans()} in
\code{\link[base]{colSums}}().
}