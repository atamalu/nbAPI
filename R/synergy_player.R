#' @title retrieves synergy player stats
#'
#' @description `synergy_player` gets player synergy data for a given category
#'
#' @importFrom httr GET content
#' @param Category category of stat to get
#' @param Year start year of season schedule in YYYY format
#' @param Season.seg part of season
#' @param Off.def choose to retrieve offensive or defensive data
#' @param Player.limit limit of players to get data for
#' @return a data frame with team synergy data of a given category
#' @examples
#' synergy_player(Category = 'transition', Off.def = 'defensive')
#' @export
synergy_player <- function(Category, Year = 2018, Season.seg = 'Reg', Off.def = 'offensive', Player.limit = 500){

  url <- paste0('https://stats-prod.nba.com/wp-json/statscms/v1/synergy/player/?category=', Category, '&season=', Year,
                '&seasonType=', Season.seg, '&names=', Off.def, '&limit=', Player.limit)

  ### Get page content
  resp <- GET(url)
  json.parsed <- content(resp,as="parsed")
  json.parsed <- json.parsed[[2]]

  ### Convert to data frame

  ## list objects
  df.list <- lapply(json.parsed, as.data.frame)
  ## list
  return.frame <- do.call(rbind, df.list)
  ### Add category
  return.frame$Category <- Category

  ### Convert to list for sapply
  return.frame <- list(return.frame)

  return(return.frame)

}
