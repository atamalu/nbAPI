#' @title Retrieves list of teams
#'
#' @description `teams_list` gets basic information on all NBA teams
#'
#' @importFrom jsonlite read_json
#' @param Year start year of season schedule in YYYY format
#' @param Type type of data to keep (standard, vegas)
#' @return a data frame with basic franchise information for all NBA teams
#' @examples
#' teams_list(Year = 2018, Type = 'vegas')
#' @export

teams_list <- function(Year, Type = 'standard'){

  ### Get data ---------------
  url <- paste0('http://data.nba.net/prod/v1/', Year, '/teams.json')

  json.parsed <- read_json(url)
  json.parsed <- json.parsed[['league']][[Type]]

  ### Format data ----------------
  json.parsed <- lapply(json.parsed, data.frame, stringsAsFactors = FALSE)
  json.parsed <- do.call(rbind, json.parsed)

  return(json.parsed)

}