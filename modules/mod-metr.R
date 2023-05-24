# metric module ----

metric_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    chart_text_ui(ns('text')),
    plot_ui(ns("metric"))
  )
 
}

metric_server <- function(id, df, vbl) {
  
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    chart_text_server('text', df, vbl)
    plot_server("metric", df)
  })
  
}
