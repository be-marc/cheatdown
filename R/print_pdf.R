#' @import crrri
NULL

#' @title  Print cheat sheet to pdf
#' 
#' @description 
#' The `print_pdf()` function renders the input R Markdown file and prints the page in a chrome headless session.
#' 
#' @param input (`character(1)`)\cr
#' The path to the input R Markdown document (.Rmd) to be rendered.
#' 
#' @param output (`character(1)`)\cr
#' The path of the output file (.pdf).
#' 
#' @export
print_pdf = function(input, output) {
  url = rmarkdown::render(input)

  svr = servr::httd(
    dirname(url), daemon = TRUE, browser = FALSE, verbose = 1,
    port = servr::random_port(), initpath = httpuv::encodeURIComponent(basename(url))
  )

  dir.create(dirname(output), showWarnings = FALSE)

  save_url_as_pdf <- function(url, output) {
  function(client) {
    Page <- client$Page

    Page$enable() %...>% {
      Page$navigate(url = url)
      Page$loadEventFired()
    } %...>% 
    wait(10) %...>% {
      Page$printToPDF(printBackground = TRUE, preferCSSPageSize = TRUE)
    } %...>% {
      .$data %>%
        jsonlite::base64_dec() %>%
        writeBin(output)
    }
  }
}

perform_with_chrome(save_url_as_pdf(svr$url, output))
}
