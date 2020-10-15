#' @export
print_pdf = function(input, chrome = TRUE) {
  url = rmarkdown::render(input)

  svr = servr::httd(
    dirname(url), daemon = TRUE, browser = FALSE, verbose = 1,
    port = servr::random_port(), initpath = httpuv::encodeURIComponent(basename(url))
  )

  dir.create("pdf", showWarnings = FALSE)
  command = paste0(ifelse(chrome, "chrome", "chromium"), " --headless --print-to-pdf='pdf/mlr3.pdf' --virtual-time-budget=20000  --disable-gpu --run-all-compositor-stages-before-draw ", svr$url)
  print(command)
  system(command, wait = FALSE)
}
