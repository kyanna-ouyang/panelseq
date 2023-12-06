# install biomart ----
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("biomaRt")

# load libraries ----
library(tidyverse)
library(dplyr)
library(biomaRt)

# connect to Ensembl live gene mart human dataset (GRCh38) ----
ensembl <- useEnsembl(biomart="ensembl", dataset="hsapiens_gene_ensembl")

# set attributes to be outputted ----
attributes <- c("ensembl_gene_id_version", "ensembl_gene_id", "hgnc_symbol", "description")

# set filters for retrieving genes ----
filters <- c("ensembl_gene_id_version")

# set input values for retrieving genes ----
values <- df$geneID

# retrieve genes ----
genes <- getBM(attributes = attributes,
               filters = filters,
               values = values,
               mart = ensembl)

# write out gene table ----
write.csv(genes, "genes.csv")

# rename genes column names ----
names(genes)[1] <- "geneID"

# join df and genes table by geneID ----
annotated <- full_join(genes, df, by = "geneID")

# replace empty hgnc symbols with ensembl id ----
annotated["hgnc_symbol"][annotated["hgnc_symbol"] == ''] <- NA

n <- nrow(annotated)
for (i in 1:n) {
  if (is.na(annotated[i, 3]==TRUE)) {
    annotated[i ,3] <- annotated[i, 1]
  }
}

# write out annotated count table ----
write.csv(annotated, "annotated.csv")
