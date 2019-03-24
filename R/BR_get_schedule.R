#' @title Retrieves season schedule
#'
#' @description `BR_get_schedule` gets the full season schedule from basketball-reference
#'
#' @importFrom xml2 read_html
#' @importFrom rvest html_nodes html_table
#' @import dplyr
#' @param Year year in YYYY format
#' @param Month full name of month, all in lowercase
#' @return a data frame with box scores for specified month
#' @examples
#' BR_get_schedule(Year = 2019, Month = 'october')
#' @export

BR_get_schedule <- function(Year, Month){

  ### Load page
  url <- paste0("https://www.basketball-reference.com/leagues/NBA_", Year,
                "_games-", Month, ".html")
  webpage <- read_html(url)

  ### Get column names
  web.table <- webpage %>%
    html_nodes('table#schedule') %>%
    html_table()

  web.table <- web.table[[1]]

  return(web.table)

}
