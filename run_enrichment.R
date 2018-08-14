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
library(GenomicRanges)

data(genes.fg.all)
data(genes.bg)
data(fits.sub)

GOterms <- c("GO:0006260", "GO:0042254", "GO:0032868", "GO:0043434", "GO:0046326", "GO:0090526", "GO:0006111",
             "GO:0005977", "GO:0006096", "GO:0006111", "GO:0006110")
# multicore not working without sourcing scripts inside
enrichment <- RunEnrichmentOneTime(genes.fg.all, genes.bg, GOterms = GOterms)

enrichment.multi <- RunEnrichment(fits.sub, genes.bg, tstarts = c(15, 5), GOterms = GOterms, ncores = 1)

print(enrichment)
