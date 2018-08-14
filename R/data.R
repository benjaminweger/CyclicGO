#' Foreground gene example
#'
#' @format List of 1395 genes (system-driven liver-rhythmic genes)
#' \itemize{
#'   \item For RunEnrichmentOneTime()
#' }
"genes.fg.all"

#' Background gene example
#'
#' @format List of 13503 genes (expressed genes)
#' \itemize{
#'   \item Gene list in alphabetical order
#' }
"genes.bg"

#' Dataframe with phase.avg for filtering by tstart and tend
#'
#' @format Dataframe 1395 by 12. With gene names and phase.avg 
#' \itemize{
#'   \item For RunEnrichment()
#' }
"fits.sub.rda"

#' Dataframe with phase.avg for filtering by tstart and tend
#'
#' @format Dataframe 216 by 11. Example output of enrichment
#' \itemize{
#'   \item Can be used for plotting downstream
#' }
"enrichment.rda"
