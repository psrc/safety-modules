# plot module ----
plot_ui <- function(id) {
  
  tagList(
  fluidRow(column(12, plotlyOutput(NS(id, "plot"))))
  ) # end of tag list
}

plot_server <- function(id, df) {
  
  moduleServer(id, function(input, output, session) {
    
    plot <- reactive({region_line(df())})
    output$plot <- renderPlotly({plot()})

  })
}
