RunEnrichment <- function(genes, genes.bg, jonto = "BP", GOterms = FALSE, tstarts = seq(0, 23), tstep = 6, ncores = 1, day = 24){
  # jonto: ontology can be "BP" for biological process or "CC" for cellular component or "MF" for molecular function.
  # GOterms: FALSE does all GO terms. Otherwise input a list c("GO:008152") as example https://www.ebi.ac.uk/QuickGO/annotations
  # tstarts: list of tstarts
  # ncores: number of cores for parallelization
  enrichment <- parallel::mclapply(tstarts, function(tstart){
    source("/home/yeung/projects/CyclicGO/R/AnalyzeGeneEnrichment.R")
    tend <- tstart + tstep
    if (tend > day){
      tend <- tend - day
    }
    print(paste("TimeWindow:", tstart, tend))
    # genes <- as.character(subset(fits.long.filt, model %in% jmod.long & IsBtwnTimes(phase.avg, tstart, tend))$gene)
    print(paste("Ngenes", length(genes)))
    enrichment <- GetGOEnrichment(genes.bg, genes, fdr.cutoff = 1, ontology = jonto, show.top.n = Inf, filter.GO.terms = GOterms)
    enrichment <- subset(enrichment, !is.na(GO.ID))
    enrichment$tstart <- tstart
    return(as.data.frame(subset(enrichment, !is.na(GO.ID))))
  }, mc.cores = ncores)
  print(enrichment)
}
