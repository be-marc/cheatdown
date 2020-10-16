#' @export
print_pdf = function(input, chrome = TRUE) {
  url = rmarkdown::render(input)

  svr = servr::httd(
    dirname(url), daemon = TRUE, browser = FALSE, verbose = 1,
    port = servr::random_port(), initpath = httpuv::encodeURIComponent(basename(url))
  )

  dir.create("pdf", showWarnings = FALSE)
  command = paste0(ifelse(chrome, "google-chrome", "chromium-browser"), " --headless --run-all-compositor-stages-before-draw --print-to-pdf='pdf/mlr3.pdf' --virtual-time-budget=60000  --disable-gpu ", svr$url)
  print(command)
  system(command)
}
