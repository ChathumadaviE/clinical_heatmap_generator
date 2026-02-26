# clinical_heatmap_generator.R
# Generate a series of heatmaps for all contiguous row ranges of a
# clinical/omics matrix (e.g., gene set by sample), saving each as a PDF.

# Assumes:
#   - 'geneset' is a numeric matrix or data frame (rows = features, cols = samples)
#   - 'pairs.breaks', 'mycol', and 'classcol' are defined in the environment
#   - 'heatmap.3' function is available (from gplots or custom)

generate_clinical_heatmaps <- function(geneset,
                                       pairs.breaks,
                                       mycol,
                                       classcol,
                                       output_dir = "heatmaps",
                                       width = 10,
                                       height = 3,
                                       pointsize = 8) {
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }

  n_rows <- nrow(geneset)

  for (row_start in seq_len(n_rows)) {
    if (row_start >= n_rows) {
      next
    }

    for (row_end in seq(row_start + 1, n_rows)) {
      data_subset <- geneset[row_start:row_end, , drop = FALSE]

      outfile <- file.path(
        output_dir,
        paste0("heatmap_", row_start, "_", row_end, ".pdf")
      )

      pdf(file = outfile, pointsize = pointsize, width = width, height = height)

      heatmap.3(
        data_subset,
        distfun   = function(x) dist(x),
        hclustfun = function(x) hclust(x, method = "complete"),
        breaks    = pairs.breaks,
        col       = mycol,
        key       = TRUE,
        trace     = "none",
        margins   = c(10, 10),
        ColSideColors = classcol
      )

      dev.off()
    }
  }
}
