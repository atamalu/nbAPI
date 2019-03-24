synergy_team <- function(Category, Year = 2018, Season.seg = 'Reg', Off.def = 'offensive', Team.limit = 30){

  url <- paste0('https://stats-prod.nba.com/wp-json/statscms/v1/synergy/team/?category=', Category, '&season=', Year,
                '&seasonType=', Season.seg, '&names=', Off.def, '&limit=', Team.limit)

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
