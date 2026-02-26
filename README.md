# Clinical heatmap generation with heatmap.3 in R

This repository contains an extended `heatmap.3` function and a helper
wrapper to generate clinical or omics heatmaps from a feature × sample
matrix. It is useful for visualizing expression or clinical feature
patterns with sample-level annotations (e.g., disease status, treatment).

## Files

- `heatmap3.R`  
  Custom `heatmap.3` implementation supporting row/column dendrograms,
  side color bars, and a flexible color key.

- `clinical_heatmap_generator.R`  
  Defines `generate_clinical_heatmaps()`, which loops over contiguous
  row ranges in a data matrix and writes one PDF heatmap per range.

- (optional) `example_data.R` or `example_geneset.rds`  
  Example code/data showing how to construct `geneset`, `pairs.breaks`,
  `mycol`, and `classcol`.

## Requirements

- R (version 3.0+)
- Base functions: `dist`, `hclust`, `image`, etc.  
  (No additional packages are strictly required; you can integrate with
  `gplots` or others if desired.)

You will need to prepare:

- `geneset`: numeric matrix or data frame (rows = features/genes,
  columns = samples).
- `pairs.breaks`: numeric vector of breakpoints for the color scale
  (e.g., for z-scores from -3 to 3).
- `mycol`: vector of colors (e.g., from `colorRampPalette`).
- `classcol`: vector of colors, one per sample (column of `geneset`),
  encoding clinical groups or other annotations.

## Usage

1. Load your data and color settings in R:

```r
# geneset: rows = features, cols = samples
geneset <- as.matrix(my_expression_or_clinical_matrix)

# Example: z-score by row before plotting
geneset <- t(scale(t(geneset)))

# classcol: color per sample (e.g., by group)
group <- factor(sample_groups)  # e.g., c("Control", "Case", ...)
classcol <- c("Control" = "blue", "Case" = "red")[group]

# Heatmap colors and breaks
mycol <- colorRampPalette(c("blue", "white", "red"))(50)
pairs.breaks <- seq(-3, 3, length.out = 51)
