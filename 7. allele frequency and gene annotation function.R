# SNV allele frequency calculation and gene annotation with annotation file
allelefreq_geneannot <- function(sample, output){
  # load in snvs file
  snvs <- fread(paste0(sample, ".snvs.ann.tsv"))
  
  # delete blank columns
  snvs <- snvs %>% select(-c(V8, V11, V14, V17, V20, V23))
  
  # name columns
  names(snvs)[1] <- "chr"
  names(snvs)[2] <- "pos"
  names(snvs)[3] <- "ref"
  names(snvs)[4] <- "alt"
  names(snvs)[5] <- "qual"
  names(snvs)[6] <- "filter"
  names(snvs)[7] <- "snpeff"
  names(snvs)[8] <- "DP_n"
  names(snvs)[9] <- "DP_t"
  names(snvs)[10] <- "FDP_n"
  names(snvs)[11] <- "FDP_t"
  names(snvs)[12] <- "AU_n"
  names(snvs)[13] <- "AU_t"
  names(snvs)[14] <- "CU_n"
  names(snvs)[15] <- "CU_t"
  names(snvs)[16] <- "GU_n"
  names(snvs)[17] <- "GU_t"
  names(snvs)[18] <- "TU_n"
  names(snvs)[19] <- "TU_t"
  
  # extract variants that passed all filters
  snvs <- snvs %>% filter(filter == "PASS")
  
  # split tier1 and tier2 reads for each allele
  snvs <- snvs %>% separate(AU_n, into = c("AU_n_tier1", "AU_n_tier2"), sep = ",")
  snvs <- snvs %>% separate(AU_t, into = c("A", "AU_t_tier2"), sep = ",")
  snvs <- snvs %>% separate(CU_n, into = c("CU_n_tier1", "CU_n_tier2"), sep = ",")
  snvs <- snvs %>% separate(CU_t, into = c("C", "CU_t_tier2"), sep = ",")
  snvs <- snvs %>% separate(GU_n, into = c("GU_n_tier1", "GU_n_tier2"), sep = ",")
  snvs <- snvs %>% separate(GU_t, into = c("G", "GU_t_tier2"), sep = ",")
  snvs <- snvs %>% separate(TU_n, into = c("TU_n_tier1", "TU_n_tier2"), sep = ",")
  snvs <- snvs %>% separate(TU_t, into = c("T", "TU_t_tier2"), sep = ",")
  
  # calculate allele frequency
  snvs$DP_t <- as.numeric(snvs$DP_t)
  snvs$A <- as.numeric(snvs$A)
  snvs$C <- as.numeric(snvs$C)
  snvs$G <- as.numeric(snvs$G)
  snvs$T <- as.numeric(snvs$T)
  
  snvs <- snvs %>%
    rowwise() %>%
    mutate(allele.frequency = get(alt) / DP_t)
  
  # convert snvs to data table
  snvs <- data.table(snvs)
  
  # join with annot file to annotate for gene in which variant is found
  snvs_annot <- annot[snvs, on = .(Chromosome == chr, Start <= pos, Stop >= pos),
                      .(chr, pos, ref, alt, allele.frequency, FeatureName, GeneName, FeatureType, Description, snpeff, PrimaryCGDID)]
  
  # add sample column
  snvs_annot$sample <- sample
  
  # save result to global environment
  assign(output, snvs_annot, envir = .GlobalEnv)
  
  # export output as csv
  fwrite(snvs_annot, paste0(sample, "_allelefreq_geneannot.csv"))
}
