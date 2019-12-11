#' Get whale types and frequency
#'
#' The Whale Hotline API allows users to get a maximum of 1000 recent whale sighting records.
#' By pass an integer x between 1 and 1000 to the function, it will search all whale types that have been
#' documented in the most recent x whale sightings and the frequency of sightings for each whale type.
#' A bar chart will be drawn to visualize the distribution of different whale types.
#'
#' @param x An integer between 1 and 1000 that indicates the number of recent sightings you want to get
#' @return A R dataframe that contains the whales types and the respective frequency of sightings
#' @examples
#' whaletype_freq(500)
#' whaletype_freq(1000)
#' @import httr
#' @import dplyr
#' @import ggplot2
#' @export


whaletype_freq <- function(x) {

  requireNamespace("httr")
  requireNamespace("dplyr")
  requireNamespace("ggplot2")

  whales_species <- c()

  endpoint <- paste("http://hotline.whalemuseum.org/api.json?&limit=", x, sep="")
  get_result <- GET(endpoint)
  content <- content(get_result)

  for (i in 1:length(content)) {
    whales_species[i] <- content[[i]]$species
  }

  output_dataframe <- whales_species %>% table() %>% as.data.frame()
  names(output_dataframe) <- c("Whale Type", "Count")
  arrange(output_dataframe, desc(output_dataframe$Count))
  output_dataframe

  ggplot(data=output_dataframe, aes(x=output_dataframe$`Whale Type`, y=output_dataframe$Count)) +
    geom_bar(stat = "identity")
}
