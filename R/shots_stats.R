#' @title retrieves shot stats
#'
#' @description `shots_stats` gets shots stats for a given team or players on a team
#'
#' @importFrom jsonlite read_json
#' @import dplyr
#' @param TeamID NBA id of team
#' @param Year start year of season schedule in YYYY format
#' @param Type type of data to get, team or player
#' @return a data frame with team or player shot data for a given team
#' @examples
#' shots_stats(TeamID = 1610612745, Year = 2018, type = 'team')
#' @export

shots_stats <- function(TeamID, Year = 2018, Type = 'player'){

  ### Format text for url
  end.year <- as.character(as.numeric(substr(Year, 3, 4)) + 1)
  Year <- paste(Year, end.year, sep = '-')

  ### Get team data
  url <- paste0('https://stats.nba.com/stats/', 'leaguedash', Type, 'ptshot', '/?measureType=Base&perMode=PerGame&leagueId=00&season=', Year, '&seasonType=Regular+Season&poRound=0&closeDefDistRange=&shotClockRange=&shotDistRange=&touchTimeRange=&dribbleRange=&generalRange=Overall&teamId=', TeamID, '&outcome=&location=&month=0&seasonSegment=&dateFrom=&dateTo=&opponentTeamId=0&vsConference=&vsDivision=&conference=&division=&gameSegment=&period=0&lastNGames=0')

  json.parsed <- read_json(url, simplifyVector = TRUE)
  json.parsed <- json.parsed$resultSets

  ### Extract data frames
  row.set <- data.frame(json.parsed$rowSet, stringsAsFactors = FALSE)
  colnames(row.set) <- unlist(json.parsed$headers)

  ### Format numeric
  row.set <- row.set %>%
    mutate_at(vars(GP:FG3_PCT), as.numeric)

  return(row.set)

}

