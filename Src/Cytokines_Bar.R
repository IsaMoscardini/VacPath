#####
rm(list = ls()) 
options(stringsAsFactors = FALSE)
sapply(c('ggplot2','reshape2','dplyr',"mixOmics", "pheatmap"), require,character.only=T)

#####
cytok <- read.csv("Data/Cyto_my_filt.csv")
View(cytok)

pheno <- cytok[,c(1,19)] # 22
View(pheno)

rownames(cytok) <- cytok$Sample.
cytok$Sample. <- NULL
cytok$Group <- NULL

rnames <- rownames(cytok)
cytok <- as.data.frame(cytok)
cytok <- apply(cytok, 2, function(x) gsub(",", ".", x))
cytok <- as.data.frame(cytok)
cytok <- apply(cytok, 2, as.character)
cytok <- apply(cytok, 2, as.numeric)
rownames(cytok) <- rnames
cytok <- as.data.frame(cytok)
View(cytok)

#cytok$ALL <- NULL
#cytok$ANY <- NULL

rownames(pheno) <- pheno$Sample.
pheno$Sample. <- NULL

pc <- pca(cytok, ncomp = 3, scale = TRUE)
plotIndiv(pc, group = pheno$Group)

pheatmap(t(cytok), annotation = pheno)

pheno$Group <- as.factor(pheno$Group)
