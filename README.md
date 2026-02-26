# Clinical heatmap generator in R

This repository contains an R function to generate a series of heatmaps
from a clinical or omics data matrix (e.g., genes × patients), saving
each heatmap as a PDF file. It was designed for visualizing clinical
annotations and expression patterns across subsets of features.

The script iterates over contiguous row ranges of the input matrix
(`geneset`) and calls a custom `heatmap.3` function to produce
hierarchically clustered heatmaps with column side colors indicating
clinical classes.

## Files

- `clinical_heatmap_generator.R`  
  Defines `generate_clinical_heatmaps()`, which loops over row ranges
  and writes one PDF per heatmap.

- (optional) Example scripts or data files showing how to build
  `geneset`, `classcol`, `mycol`, and `pairs.breaks`.

## Requirements

- R (version 3.0+)
- A `heatmap.3` implementation (e.g., from the `gplots` package or a
  custom script).
- Predefined objects:
  - `geneset`: numeric matrix or data frame (rows = features, columns = samples)
  - `pairs.breaks`: numeric vector of breakpoints for the heatmap color scale
  - `mycol`: vector of colors for the heatmap
  - `classcol`: vector of colors for samples (one color per column of `geneset`)

Example packages you might use:

```r
install.packages("gplots")
library(gplots)

