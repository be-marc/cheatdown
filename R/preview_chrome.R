#' @export 
preview_chrome = function(input, chrome = TRUE) {
  url = rmarkdown::render(input)

  svr = servr::httd(
    dirname(url), daemon = TRUE, browser = FALSE, verbose = 1,
    port = servr::random_port(), initpath = httpuv::encodeURIComponent(basename(url))
  )

  command = paste0(ifelse(chrome, "google-chrome ", "chromium-browser "), svr$url)

  print(command)
  system(command, wait = FALSE)
}