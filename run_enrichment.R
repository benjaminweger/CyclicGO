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
data(enrichment)



# Example: RUN ENRICHMENT -------------------------------------------------


GOterms <- c("GO:0006260", "GO:0042254", "GO:0032868", "GO:0043434", "GO:0046326", "GO:0090526", "GO:0006111",
             "GO:0005977", "GO:0006096", "GO:0006111", "GO:0006110")
# multicore not working without sourcing scripts inside
enrichment.test <- RunEnrichmentOneTime(genes.fg.all, genes.bg, GOterms = GOterms)

# Run at tstart = 0 and 1 with window size 6
enrichment.multi <- RunEnrichment(fits.sub, genes.bg, tstarts = c(0, 1), tstep = 6,  GOterms = GOterms, ncores = 1)



# Example: RUN & PLOT DOWNSTREAM -------------------------------------------------


# Downstream analysis
enrichment <- CopyZT0ToZT24(enrichment, convert.cname=FALSE)  # complete the circle, and add time midpoint

# show just 3 GO terms
enrichment <- subset(enrichment, Term %in% c("ribosome biogenesis", "DNA replication", "response to insulin"))
jmod <- "LiverWT,LiverBmal1KO"
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#F")
amp.max <- ceiling(max(enrichment$minuslogpval))

# Plot
ggplot(enrichment %>% arrange(Term, tmid),
       aes(x = tmid, y = minuslogpval, fill = Term)) +
  geom_polygon(alpha = 0.3) +
  coord_polar(theta = "x") + scale_x_continuous(limits = c(0, 24), breaks = seq(6, 24, 6)) +
  scale_fill_manual(values = cbPalette) +
  theme_bw() +
  ggtitle(jmod) +
  geom_hline(yintercept = seq(0, amp.max, length.out = 2), colour = "grey50", size = 0.2, linetype = "dashed") +
  geom_vline(xintercept = seq(6, 24, by = 6), colour = "grey50", size = 0.2, linetype = "solid") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        axis.line = element_line(colour = "black"),
        legend.position="bottom",
        panel.border = element_blank(),
        legend.key = element_blank(),
        axis.ticks = element_blank(),
        panel.grid  = element_blank()) +
  xlab("ZT [h]") +
  ylab("Minus log10(pval)")
