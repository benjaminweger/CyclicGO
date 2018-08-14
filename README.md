* CyclicGO

Install with `devtools::install_github("naef-lab/CyclicGO")`

See the `run_enrichment.R` file to get example of getting enrichment

Example

```
enrichment <- RunEnrichmentOneTime(genes.fg.all, genes.bg, GOterms = myGOterms)
# Run around the clock. Expects phase.avg column in fits.sub 
enrichment.multi <- RunEnrichment(fits.sub, genes.bg, tstarts = seq(0, 23), GOterms = myGOterms, ncores = 1)
```

