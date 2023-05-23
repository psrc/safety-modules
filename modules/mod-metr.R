# metric module ----
metric_ui <- function(id) {
  
  fluidRow(
    chart_text_ui(NS(id, "metric")),
    plot_ui(NS(id, "metric"))
  )
  
}

metric_server <- function(id, df, vbl) {
  
  moduleServer(id, function(input, output, session) {
    
    chart_text_server("metric", df, vbl)
    plot_server("metric", df)
    
  })
  
}
