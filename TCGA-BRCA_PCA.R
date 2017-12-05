# jingqian
# 20171204
# use in rstudio: get active document context !
install.packages("rstudioapi")
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# setwd('/.')
install.packages("ggfortify")
library(ggfortify)

final <- read.table('finaldata.txt', header = TRUE, sep = '\t', check.names = FALSE)
asian <- read.table('asians.txt', header = FALSE)
black <- read.table('blacks.txt', header = FALSE)
american <- read.table('american indian.txt', header = FALSE)
white <- read.table('whites.txt', header = FALSE)

row.names(final) <- final$gene

final <- final[-c(1)]
final <- t(final)

final <- as.data.frame(final)
final$Samples <- rownames(final)

final$Group <- NA

final$Group <- ifelse(final$Samples %in% asian$V1, 'ASIAN',
                      ifelse(final$Samples %in% black$V1, 'BLACK',
                             ifelse(final$Samples %in% american$V1, 'AMERICAN INDIAN',
                                    ifelse(final$Samples %in% white$V1, 'WHITE','UnKnown'))))


final.data <- final[c(1:60483)]

autoplot(prcomp(final.data), data = final, colour = 'Group')

PCA = prcomp(final.data)
summary <- summary(PCA)
write.table(summary$importance, file = 'TCGA-BRCA-PCA.txt', sep = '\t', col.names = NA)

