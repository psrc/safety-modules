chart_text_ui <- function(id) {
  
  fluidRow(
    textOutput(NS(id, "chart_text"))
  )
  
}

chart_text_server <- function(id, df, vbl) {
  
  moduleServer(id, function(input, output, session) {
    
    n <- reactive({df() %>% filter(year==2022 & injury_type==vbl & name=="Region") %>% select("injuries") %>% pull()})
    
    output$chart_text <- renderText({
      paste("In 2022, the total", 
            vbl, 
            "totaled",
            n())
    })
    
  })
  
}