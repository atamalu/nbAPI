#' @title Retrieves team season performance data
#'
#' @description `team_performance` gets performance data for a full season
#'
#' @importFrom jsonlite read_json
#' @param TeamID NBA id of team
#' @param Year start year of season schedule in YYYY format
#' @return a data frame with performance data for a given team for a given year
#' @examples
#' team_performance(TeamID = 1610612745, Year = 2018)
#' @export

team_performance <- function(TeamID, Year = 2018){

  ### Format text for url
  end.year <- as.character(as.numeric(substr(Year, 3, 4)) + 1)
  Year <- paste(Year, end.year, sep = '-')

  ### Get team data
  url <- paste0('https://stats.nba.com/stats/teamdashboardbyteamperformance/?measureType=Base&perMode=PerGame&plusMinus=N&paceAdjust=N&rank=N&leagueId=00&season=', Year, '&seasonType=Regular+Season&poRound=0&teamId=', TeamID, '&outcome=&location=&month=0&seasonSegment=&dateFrom=&dateTo=&opponentTeamId=0&vsConference=&vsDivision=&gameSegment=&period=0&shotClockRange=&lastNGames=0')

  json.parsed <- read_json(url, simplifyVector = TRUE)
  json.parsed <- json.parsed$resultSets

  ### Extract data frames
  row.set <- json.parsed$rowSet
  row.set <- lapply(row.set, data.frame, stringsAsFactors = FALSE)

  set.names <- json.parsed$name
  set.names <- gsub('TeamDashboard', '', set.names)

  ### Get column names and rename
  name.list <- json.parsed$headers

  ### Rename list items then data frame columns
  for(i in 1:length(row.set)){
    colnames(row.set[[i]]) <- c(unlist(name.list[[i]]))
  }

  names(row.set) <- set.names

  return(row.set)

}
