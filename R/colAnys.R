### ============================================================================
### colAnys
###

### ----------------------------------------------------------------------------
### Non-exported methods
###

#' `colAnys()` block-processing internal helper
#' @inherit matrixStats::colAnys
#' @importFrom methods is
.DelayedMatrix_block_colAnys <- function(x, rows = NULL, cols = NULL,
                                         value = TRUE, na.rm = FALSE,
                                         dim. = dim(x), ...) {
  # Check input
  stopifnot(is(x, "DelayedMatrix"))
  stopifnot(!x@is_transposed)
  # TODO: Answer is always logical, so this might not be appropriate
  DelayedArray:::.get_ans_type(x)

  # Subset
  x <- ..subset(x, rows = rows, cols = cols)

  # Compute result
  val <- DelayedArray:::colblock_APPLY(x,
                                       matrixStats::colAnys,
                                       value = value,
                                       na.rm = na.rm,
                                       ...)
  if (length(val) == 0L) {
    return(logical(ncol(x)))
  }
  # NOTE: Return value of matrixStats::colAnys() has no names
  unlist(val, recursive = FALSE, use.names = FALSE)
}

### ----------------------------------------------------------------------------
### Exported methods
###

# ------------------------------------------------------------------------------
# General method
#

#' @importFrom DelayedArray seed
#' @importFrom methods hasMethod is
#' @rdname colAnys
#' @template common_params
#' @export
setMethod("colAnys", "DelayedMatrix",
          function(x, rows = NULL, cols = NULL, value = TRUE, na.rm = FALSE,
                   dim. = dim(x), force_block_processing = FALSE, ...) {
            if (!hasMethod("colAnys", class(seed(x))) ||
                force_block_processing) {
              message2("Block processing", get_verbose())
              return(.DelayedMatrix_block_colAnys(x, rows, cols, value, na.rm,
                                                  dim., ...))
            }

            message2("Has seed-aware method", get_verbose())
            if (DelayedArray:::is_pristine(x)) {
              message2("Pristine", get_verbose())
              simple_seed_x <- seed(x)
            } else {
              message2("Coercing to seed class", get_verbose())
              # TODO: do_transpose trick
              simple_seed_x <- try(from_DelayedArray_to_simple_seed_class(x),
                                   silent = TRUE)
              if (is(simple_seed_x, "try-error")) {
                message2("Unable to coerce to seed class", get_verbose())
                return(colAnys(x, rows, cols, value, na.rm, dim.,
                               force_block_processing = TRUE, ...))
              }
            }

            colAnys(simple_seed_x, rows, cols, value, na.rm, dim., ...)
          }
)

# ------------------------------------------------------------------------------
# Seed-aware methods
#

#' @importFrom methods setMethod
#' @export
setMethod("colAnys", "matrix", matrixStats::colAnys)