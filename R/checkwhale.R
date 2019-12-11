#' Check if a particular whale type has been sighted
#'
#' By passing a particular whale type to the function, it will tell you if
#' this type of whale has occurred in the recent 1000 sightings
#' (maximum of sightings to access). If yes, it will return the
#' specfic number of sightings.If not, it will tell you
#' there are no such records.
#'
#' @param x A whale type (A character string in quotation mark)
#' @return A character string telling whether or not the input whale
#' type has occurred in recent sightings.
#' If yes, it will return the specfic number of sightings.
#' @examples
#' checkWhale("orca")
#' checkWhale("humpback")
#' @import httr
#' @import dplyr
#' @export

checkWhale <- function(x) {

  requireNamespace("dplyr")
  requireNamespace("httr")

  if (is.character(x) == FALSE) {
    print("Please input a valid whale name")
  }

  else {
    endpoint <- "http://hotline.whalemuseum.org/api.json?&limit=1000"
    get_result <- GET(endpoint)
    content <- content(get_result)

    whalelist <- c()

    for (i in 1:length(content)) {
      whalelist[i] <- content[[i]]$species
    }

    whalenamelist <- whalelist %>% unique() %>% as.character()
    x <- str_to_lower(x, locale = "en")

    if ((TRUE %in% str_detect(whalenamelist, x)) == FALSE) {
      printout <- paste("There are no records of", x, "in the recent 1000 sightings (1000 is the maximum)", sep=" ")
      printout
    }
    else {
      url <- paste("http://hotline.whalemuseum.org/api/count.json?species=", x, sep = "")
      get_result <- GET(url)
      sighting <- content(get_result)

      if (sighting == 1) {
        printout <- paste("There is 1 sighting of", x, sep = " ")
        printout
      }
      else {
        printout <- paste("There are", sighting, "records of", x, "in the recent 1000 sightings (1000 is the maximum)", sep = " ")
        printout
      }
   }
  }
}
