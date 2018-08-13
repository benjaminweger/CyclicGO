# Jake Yeung
# Date of Creation: 2018-08-02
# File: ~/projects/CyclicGO/run_enrichment.R
# Test package

rm(list=ls())

library(CyclicGO)
library(dplyr)
library(ggplot2)
library(parallel)
library(DBI)
library(topGO)
library(org.Mm.eg.db)
# library(GenomicRanges)

# TEST ENRICHMENT ---------------------------------------------------------

# infobj <- "/home/yeung/projects/tissue-specificity/Robjs/liver_kidney_atger_nestle/fits.long.multimethod.filtbest.staggeredtimepts.bugfixed.annotated.Robj"
# load(infobj)
# fits.long.filt <- subset(fits.long.filt, method == jmeth)
# jmod.long <- "Liver_SV129,Liver_BmalKO"
# jmeth <- "g=1001"
# genes.fg.all <- as.character(subset(fits.long.filt, model %in% jmod.long)$gene)
# genes.bg <- as.character(fits.long.filt$gene)
# write(genes.fg.all, file = "/home/yeung/projects/CyclicGO/data/genes.fg.all.txt")
# write(genes.bg, file = "/home/yeung/projects/CyclicGO/data/genes.bg.txt")

# source("/home/yeung/projects/CyclicGO/R/AnalyzeGeneEnrichment.R")
# source("/home/yeung/projects/CyclicGO/R/RunEnrichment.R")
# source("/home/yeung/projects/CyclicGO/R/DataHandlingFunctions.R")

genes.fg.all <- read.csv2(file = "/home/yeung/projects/CyclicGO/data/genes.fg.all.txt", header = FALSE, stringsAsFactors = FALSE)$V1
genes.bg <- read.csv2(file = "/home/yeung/projects/CyclicGO/data/genes.bg.txt", header = FALSE, stringsAsFactors = FALSE)$V1

GOterms <- c("GO:0006260", "GO:0042254", "GO:0032868", "GO:0043434", "GO:0046326", "GO:0090526", "GO:0006111",
             "GO:0005977", "GO:0006096", "GO:0006111", "GO:0006110")

enrichment <- RunEnrichment(genes.fg.all, genes.bg, tstarts = c(15), GOterms = GOterms, ncores = 1)
