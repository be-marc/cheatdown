#' @title Preview cheat sheet in chrome browser
#'
#' @description
#' Preview cheat sheets in chrome or chromium browser.
#'
#' @param input (`character(1)`)\cr
#' The path to the input R Markdown document (.Rmd) to be previewed.
#' @param chrome (`logical(1)`)\cr
#' Use chrome or chromium?
#'
#' @export
preview_chrome = function(input, chrome = TRUE) {
  url = rmarkdown::render(input)

  svr = servr::httd(dirname(url), daemon = TRUE, browser = FALSE, verbose = 1,
    port = servr::random_port(), 
    initpath = httpuv::encodeURIComponent(basename(url))
  )

  command = paste0(ifelse(chrome, "google-chrome ", "chromium-browser "), 
    svr$url)
    
  system(command, wait = FALSE)
}
