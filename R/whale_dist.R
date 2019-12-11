#' Get whale sightings that occured near a center point within a radius
#'
#' Users can specify the location of sightings they want to get. There are three parameters they can modify:
#' latitude, longitude, and radius. A pair of latitude and longitude fixes a center point and the radius refers
#' to the distance around that center point. Togther, they forms a region. By passing latitude, longitude,
#' and radius sequentially to the function, it will return a R dataframe that contains sightings falling in
#' specified region, as well as a variety of information about the sightings including whale species,
#' sighting latitude & longitude, location, and sighting date & time.
#'
#' @param x Latitude (Must be within the range [-90, 90])
#' @param y Longitude (Must be within the range [-180, 180])
#' @param z Radius (Must be a non-negative number)
#' @return A dataframe that contains the sightings falling in the specified region
#' @examples
#' whale_dist(48.5159, -123.1524, 0.5)
#' whale_dist(37.765, 120.98, 120)
#' @import httr
#' @import dplyr
#' @export

whale_dist <- function(x, y, z) {

  if (x < -90 | x > 90) {
    warning('Please input a valid latitude! Note that latitude must be within the range [-90, 90].')
  }
  else if (y < -180 | y > 180) {
    warning('Please input a valid longitude! Note that longitude must be within the range [-180, 180].')
  }
  else  if (z < 0) {
    warning('Please input a valid radius! Note that the radius must be a non-negative number.')
  }
  else {

    requireNamespace("dplyr")
    requireNamespace("httr")
    species <- c()
    quantity <- c()
    latitude <- c()
    longitude <- c()
    location <- c()
    sighted_at <- c()

    endpoint <- paste("http://hotline.whalemuseum.org/api.json?&limit=1000&near=", x, ",", y, "&radius=", z, sep = "")
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
