RunEnrichment <- function(fits.long.filt, genes.bg, jonto = "BP", GOterms = FALSE, tstarts = seq(0, 23), tstep = 6, ncores = 1, day = 24){
  # fits.long.filt: object with phase.avg in column name for tstart and tend to check

  # jonto: ontology can be "BP" for biological process or "CC" for cellular component or "MF" for molecular function.
  # GOterms: FALSE does all GO terms. Otherwise input a list c("GO:008152") as example https://www.ebi.ac.uk/QuickGO/annotations
  # tstarts: list of tstarts
  # ncores: number of cores for parallelization

  # mclapply doesnt quite work: with DBI package??
  # https://www.mail-archive.com/bioc-devel@r-project.org/msg08780.html
  # requires sourcing files INSIDE THE LOOP
  # enrichment <- parallel::mclapply(tstarts, function(tstart){
  enrichment <- lapply(tstarts, function(tstart){
    # source("/home/yeung/projects/CyclicGO/R/AnalyzeGeneEnrichment.R")
    library(DBI)  # dbGetQuery() not found when loading topGO
    library(topGO)
    library(org.Mm.eg.db)
    tend <- tstart + tstep
    if (tend > day){
      tend <- tend - day
    }
    print(paste("TimeWindow:", tstart, tend))
    genes <- as.character(subset(fits.long.filt, IsBtwnTimes(phase.avg, tstart, tend))$gene)
    print(paste("Ngenes", length(genes)))
    enrichment <- GetGOEnrichment(genes.bg, genes, fdr.cutoff = 1, ontology = jonto, show.top.n = Inf, filter.GO.terms = GOterms)
    enrichment <- subset(enrichment, !is.na(GO.ID))
    enrichment$tstart <- tstart
  return(as.data.frame(subset(enrichment, !is.na(GO.ID))))
  # }, mc.cores = ncores)
  })
  print(enrichment)
}

RunEnrichmentOneTime <- function(genes, genes.bg, jonto = "BP", GOterms = FALSE, timelabel = ""){
  # genes: genes for enrichment
  # jonto: ontology can be "BP" for biological process or "CC" for cellular component or "MF" for molecular function.
  # GOterms: FALSE does all GO terms. Otherwise input a list c("GO:008152") as example https://www.ebi.ac.uk/QuickGO/annotations
  # timelabel: labels output dataframe in case you want to use this in an lapply
  enrichment <- GetGOEnrichment(genes.bg, genes, fdr.cutoff = 1, ontology = jonto, show.top.n = Inf, filter.GO.terms = GOterms)
  enrichment <- subset(enrichment, !is.na(GO.ID))
  # for labelling purposes only 
  enrichment$tstart <- timelabel
  return(enrichment)
}
