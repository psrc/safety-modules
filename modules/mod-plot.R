# plot module ----
plot_ui <- function(id) {
  
  fluidRow(column(10, plotlyOutput(NS(id, "plot"))),
           column(2, downloadButton(NS(id, "dnld"), label = "")))
  
}

plot_server <- function(id, df) {
  
  moduleServer(id, function(input, output, session) {
    
    plot <- reactive({region_line(df())})
    output$plot <- renderPlotly({plot()})
    output$dnld <- downloadHandler(
      filename = function() {paste0('test.png')},
      content = function(file) {ggsave(file, plot())}
    )
    
  })
}
