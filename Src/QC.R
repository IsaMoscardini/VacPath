rm(list = ls())
options(stringsAsFactors = F)

pkgs <- c('data.table','mixOmics','reshape2','DESeq2','DEGreport', "tidyverse", "edgeR")
sum(unlist(lapply(pkgs, require,character.only = T))) == length(pkgs)

data(humanGender)


idx <- c(1:10, 75:85)
dds <- DESeqDataSetFromMatrix(assays(humanGender)[[1]][1:1000, idx],
                              colData(humanGender)[idx,], design=~group)
dds <- DESeq(dds)
res <- results(dds)

counts <- counts(dds, normalized = TRUE)
design <- as.data.frame(colData(dds))


#### PCA and IPCA
pcas <- pca(t(counts), ncomp = 2)
plotIndiv(pcas, group = dds$group)

ipcas <- ipca(t(counts), ncomp = 2)
plotIndiv(ipcas, group = dds$group)

#### Density plot 
degCheckFactors(counts)

 
##### Mean-Variance
# Variation (dispersion) and average expression relationship shouldn’t be a factor among DEGs
# When plotting average mean and standard deviation, significant genes should be randomly distributed
degQC(counts, design[["group"]], pvalue = res[["pvalue"]])



