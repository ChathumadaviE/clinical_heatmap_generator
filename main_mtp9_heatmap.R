# main_mtp9_heatmap.R
# Example script: clustered heatmap of clinical / expression matrix (mtp9)
# using heatmap.3 and sample class colors.

#-----------------------------
# Load data
#-----------------------------

mtp9 <- as.matrix(
  read.table(
    "mtp9.csv",
    header   = TRUE,
    row.names = 1,
    sep      = ","
  )
)

# Optionally restrict to the first 47 samples (as in original code)
mtp9 <- mtp9[, 1:47, drop = FALSE]

cat("Dimensions of mtp9:", dim(mtp9), "\n")

#-----------------------------
# Heatmap parameters
#-----------------------------

library(gplots)  # for colorpanel()

# Breaks for z-scored data (example: -2 to 2)
pairs.breaks <- seq(-2, 2, length.out = 100)

# Color palette (blue-white-red)
mycol <- colorpanel(
  n   = 99,
  low = "cornflowerblue",
  mid = "white",
  high = "red"
)

# Sample class colors
# Adjust the counts to match ncol(mtp9)
# Example: 2 orange, 10 cyan, 35 green = 47 columns total
classcol <- c(
  rep("orange", 2),
  rep("cyan",   10),
  rep("green",  35)
)

if (length(classcol) != ncol(mtp9)) {
  stop("Length of classcol (", length(classcol),
       ") does not match number of samples (", ncol(mtp9), ").")
}

classcol <- as.matrix(classcol)

#-----------------------------
# Heatmap generation
#-----------------------------

source("heatmap3.R")  # loads heatmap.3

pdf("mtp9_heatmap.pdf", pointsize = 8, width = 6, height = 6)

heatmap.3(
  mtp9,
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
cat("Heatmap written to mtp9_heatmap.pdf\n")
