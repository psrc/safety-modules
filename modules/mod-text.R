chart_text_ui <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("chart_text_ui"))
}

chart_text_server <- function(id, df, vbl) {
 
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    output$chart_text_ui <- renderUI({
      textOutput(ns("chart_text"))
    })
    
    num <- reactive({
      df() %>% 
        filter(year == latest_yr & geography=="County" & injury_type == vbl() & name == "Region") %>% 
        select(injuries) %>% 
        pull()
    })
    
    output$chart_text <- renderText({
      paste0("In ",latest_yr,", the total ", vbl(), " totaled ", num(),".")
    })
    
  })
}