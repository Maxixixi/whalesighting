% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/whaletype_freq.R
\name{whaletype_freq}
\alias{whaletype_freq}
\title{Get whale types and frequency}
\usage{
whaletype_freq(x)
}
\arguments{
\item{x}{An integer between 1 and 1000 that indicates the number of recent sightings you want to get}
}
\value{
A R dataframe that contains the whales types and the respective frequency of sightings
}
\description{
The Whale Hotline API allows users to get a maximum of 1000 recent whale sighting records.
By pass an integer x between 1 and 1000 to the function, it will return a R dataframe that contains
all whale types that have been documented in the most recent x whale sightings and the frequency of sightings
for each whale type. A bar chart will be drawn to visualize the distribution of different whale types.
}
\examples{
whaletype_freq(500)
whaletype_freq(1000)
}
