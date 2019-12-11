#' Get whale types and provide detailed descriptions for each type
#'
#' The Whale Hotline API allows users to get a maximum of 1000 recent whale sighting records.
#' By pass an integer x between 1 and 1000 to the function, it will return a R dataframe that contains
#' all whale types that have been documented in the most recent x whale sightings and detailed descriptions
#' for each whale type.
#'
#' @param x An integer between 1 and 1000 that indicates the number of recent sightings you want to get
#' @return A R dataframe that contains the whales species and the respective descriptions
#' @examples
#' whale_des(500)
#' whale_des(1000)
#' @import httr
#' @import dplyr
#' @import rvest
#' @import stringr

#' @export

whale_des <- function(x) {

  requireNamespace("dplyr")
  requireNamespace("httr")
  requireNamespace("stringr")
  requireNamespace("rvest")

  whalelist <- c()
  descriptionlist <- c()

  url_wiki <- "https://www.thoughtco.com/types-of-whales-2292021"
  wiki <- read_html(url_wiki)
  whaledescriptions <- html_text(html_nodes(wiki, css = ".comp.mntl-sc-block.mntl-sc-block-html"))

  endpoint <- paste("http://hotline.whalemuseum.org/api.json?&limit=", x, sep="")
  get_result <- GET(endpoint)
  content <- content(get_result)

  for (i in 1:length(content)) {
    whalelist[i] <- content[[i]]$species
  }

  whalenamelist <- whalelist %>% unique() %>% as.character()

  for (i in 1:length(whalenamelist)) {
    whalename <- whalenamelist[i]

    for (j in 1:length(whaledescriptions)) {
      if (str_detect(whaledescriptions[j], whalename) == TRUE) {
        descriptionlist[i] <- whaledescriptions[j]
        descriptionlist[i] <- str_remove(descriptionlist[i], "\n")
      }
    }
  }

  name_description <- as.data.frame(cbind(whalenamelist, descriptionlist))
  names(name_description) <- c("Whale Type", "Description")
  name_description
}
