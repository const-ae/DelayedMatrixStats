### ============================================================================
### rowQuantiles
###

### ----------------------------------------------------------------------------
### Non-exported methods
###

#' `rowQuantiles()` block-processing internal helper
#' @inherit matrixStats::rowQuantiles
#' @importFrom methods is
.DelayedMatrix_block_rowQuantiles <-
  function(x, rows = NULL, cols = NULL,
           probs = seq(from = 0, to = 1, by = 0.25), na.rm = FALSE, type = 7L,
           ..., drop = TRUE) {
    # Check input type
    stopifnot(is(x, "DelayedMatrix"))
    stopifnot(!x@is_transposed)
    DelayedArray:::.get_ans_type(x, must.be.numeric = TRUE)

    # Subset
    x <- ..subset(x, rows, cols)

    # Compute result
    val <- rowblock_APPLY(x = x,
                          APPLY = matrixStats::rowQuantiles,
                          probs = probs,
                          na.rm = na.rm,
                          type = type,
                          ...,
                          drop = drop)
    if (length(val) == 0L) {
      return(numeric(ncol(x)))
    }
    # NOTE: Return value of matrixStats::rowQuantiles() is a vector if input is
    #       a row vector (matrix with 1 row)
    if (nrow(x) == 1L) {
      return(unlist(val))
    }
    val <- do.call(rbind, val)
    # NOTE: Return value of matrixStats::rowQuantiles() has rownames if
    #       return value is a matrix and does not have NA/NaN row
    if (!any(rowAlls(val, value = NA))) {
      rownames(val) <- rownames(x)
    }
    val
  }

### ----------------------------------------------------------------------------
### Exported methods
###

# ------------------------------------------------------------------------------
# General method
#

#' @importFrom DelayedArray seed
#' @importFrom methods hasMethod is
#' @rdname colQuantiles
#' @export
setMethod("rowQuantiles", "DelayedMatrix",
          function(x, rows = NULL, cols = NULL,
                   probs = seq(from = 0, to = 1, by = 0.25), na.rm = FALSE,
                   type = 7L, force_block_processing = FALSE, ...,
                   drop = TRUE) {
            if (!hasMethod("rowQuantiles", class(seed(x))) ||
                force_block_processing) {
              message2("Block processing", get_verbose())
              return(.DelayedMatrix_block_rowQuantiles(x = x,
                                                       rows = rows,
                                                       cols = cols,
                                                       probs = probs,
                                                       na.rm = na.rm,
                                                       type = type,
                                                       ...,
                                                       drop = drop))
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
                return(rowQuantiles(x = x,
                                    rows = rows,
                                    cols = cols,
                                    probs = probs,
                                    na.rm = na.rm,
                                    type = type,
                                    force_block_processing = TRUE,
                                    ...,
                                    drop = drop))
              }
            }

            rowQuantiles(x = simple_seed_x,
                         rows = rows,
                         cols = cols,
                         probs = probs,
                         na.rm = na.rm,
                         type = type,
                         ...,
                         drop = drop)
          }
)

# ------------------------------------------------------------------------------
# Seed-aware methods
#

#' @importFrom methods setMethod
#' @export
setMethod("rowQuantiles", "matrix", matrixStats::rowQuantiles)