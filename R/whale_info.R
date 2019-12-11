#' Get comprehensive information about the most recent whale sightings
#'
#' The Whale Hotline API allows users to get a maximum of 1000 recent whale sighting records.
#' By pass an integer x between 1 and 1000 to the function, it will return a R dataframe that contains
#' x recent whale sightings with detailed information including whale species, sighting latitude & longitude,
#' location, and sighting date & time.
#'
#' @param x An integer between 1 and 1000 that indicates the number of recent sightings you want to get
#' @return A R dataframe that contains a variety of information about the whale sightings, including
#' whale species, sighting latitude & longitude, location, and sighting date & time.
#' @examples
#' whale_info(500)
#' whale_info(1000)
#' @import httr
#' @export

whale_info <- function(x) {

  requireNamespace("httr")

  if (x < 1 | x > 1000) {
    warning("The input number is beyond limit. Note that you must input an integer within the range [1, 1000].")
  }
  else {
    species <- c()
    quantity <- c()
    latitude <- c()
    longitude <- c()
    location <- c()
    sighted_at <- c()

    endpoint <- paste("http://hotline.whalemuseum.org/api.json?&limit=", x, sep="")
    get_result <- GET(endpoint)
    content <- content(get_result)

    for (i in 1:length(content)) {
      species[i] <- content[[i]]$species
      latitude[i] <- content[[i]]$latitude
      longitude[i] <- content[[i]]$longitude
      location[i] <- content[[i]]$location
      sighted_at[i] <- content[[i]]$sighted_at
    }

    complete_table <- as.data.frame(cbind(species, quantity, latitude, longitude, location, sighted_at))
    complete_table
  }
}
