% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/shots_stats.R
\name{shots_stats}
\alias{shots_stats}
\title{retrieves shot stats}
\usage{
shots_stats(TeamID, Year = 2018, Type = "player")
}
\arguments{
\item{TeamID}{NBA id of team}

\item{Year}{start year of season schedule in YYYY format}

\item{Type}{type of data to get, team or player}
}
\value{
a data frame with team or player shot data for a given team
}
\description{
`shots_stats` gets shots stats for a given team or players on a team
}
\examples{
shots_stats(TeamID = 1610612745, Year = 2018, type = 'team')
}
