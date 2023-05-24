# metric module ----
metric_ui <- function(id) {
  ns <- NS(id)
  
  textOutput(ns('chart_text'))
}

metric_server <- function(id, df, vbl) {
  
  moduleServer(id, function(input, output, session) {
    # ns <- session$ns
    # stopifnot(is.reactive(vbl))
    
    num <- reactive({
      # if(vbl() == 'Serious Injury') browser()
      
      df() %>% 
        filter(year == 2022 & injury_type == vbl() & name == "Region") %>% 
        select(injuries) %>% 
        pull()
    })
    
    output$chart_text <- renderText({
      paste("In 2022, the total", vbl(), "totaled", num())
    })
    

  })
  
}

# chart_text_ui(ns("metric"))
# chart_text_server("metric", df, vbl())