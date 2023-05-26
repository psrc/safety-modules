# plot module ----
plot_ui <- function(id) {
  
  tagList(
  fluidRow(column(12, plotlyOutput(NS(id, "plot")))),
  tags$div(class="chart_source",paste0("Source: "))
  ) # end of tag list
}

plot_server <- function(id, df) {
  
  moduleServer(id, function(input, output, session) {
    
    plot <- reactive({region_line(df())})
    output$plot <- renderPlotly({plot()})

  })
}
