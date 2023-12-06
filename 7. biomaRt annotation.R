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

# write out annotated variant table ----
write.csv(annotated, "annotated.csv")

# extract variants in panel genes
panelgenes <- c("ABL1","AKT1","ALK","APC","ATM","BRAF","CDH1","CDKN2A","CSF1R",
                "CTNNB1","EGFR","ERBB2","ERBB4","EZH2","FBXW7","FGFR1","FGFR2",
                "FGFR3","FLT3","GNA11","GNAQ","GNAS","HNF1A","HRAS","IDH1",
                "IDH2","JAK2","JAK3","KDR","KIT","KRAS","MET","MLH1","MPL",
                "NOTCH1","NPM1","NRAS","PDGFRA","PIK3CA","PTEN","PTPN11","RB1",
                "RET","SMAD4","SMARCB1","SMO","SRC","STK11","TP53","VHL")
panelvars <- subset(annotated, hgnc_symbol %in% panelgenes)
