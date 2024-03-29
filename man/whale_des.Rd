% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/whale_des.R
\name{whale_des}
\alias{whale_des}
\title{Get whale types and provide detailed descriptions for each type}
\usage{
whale_des(x)
}
\arguments{
\item{x}{An integer between 1 and 1000 that indicates the number of recent sightings you want to get}
}
\value{
A R dataframe that contains the whales species and the respective descriptions
}
\description{
The Whale Hotline API allows users to get a maximum of 1000 recent whale sighting records.
By pass an integer x between 1 and 1000 to the function, it will return a R dataframe that contains
all whale types that have been documented in the most recent x whale sightings and detailed descriptions
for each whale type.
}
\examples{
whale_des(500)
whale_des(1000)
}
