#' @title cheatdown_html
#'
#' @description
#' Converts markdown to html cheatsheet
#'
#' @param ... (ignored)
#'
#' @export
cheatdown_html <- function(...) {
  extra_dependencies= list(
    htmltools::htmlDependency(name = "paged", version = "0.1.43",
      src = pkg_resource("js", "paged-0.1.43"), script = "paged.polyfill.js",
      stylesheet = "interface.css"),
    htmltools::htmlDependency(name = "cheatdown_css", version = "0.0.1",
      src = pkg_resource("css", "cheatdown"), stylesheet = "cheatdown.css")
  )

  rmarkdown::html_document(
    self_contained = FALSE,
    theme = NULL,
    highlight = "pygments",
    mathjax = NULL,
    template = pkg_resource("html", "cheatdown.html"),
    extra_dependencies = extra_dependencies
    )
}
