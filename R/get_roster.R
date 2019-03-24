#' @title retrieves team roster
#'
#' @description `synergy_team` gets roster data for a given team
#'
#' @importFrom jsonlite read_json
#' @param TeamID NBA id of team to get data for
#' @return a data frame with roster data for a given team
#' @examples
#' get_roster(TeamID = 1610612745)
#' @export

get_roster <- function(TeamID){

  url <- paste0('https://stats.nba.com/stats/commonteamroster/?season=2018-19&teamId=', TeamID, '&leagueId=00')

  ### Get page content
  json.parsed <- read_json(url)
  json.parsed <- json.parsed$resultSets[[1]]

  row.set <- lapply(json.parsed$rowSet, rbind)
  row.set <- lapply(row.set, data.frame)
  return.df <- do.call(rbind, row.set)

  colnames(return.df) <- json.parsed$headers

  return(return.df)

}
