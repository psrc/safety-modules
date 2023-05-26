chart_text_ui <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("chart_text_ui"))
}

chart_source_ui <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("chart_source_ui"))
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

chart_source_server <- function(id, vbl) {
  
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    output$chart_source_ui <- renderUI({
      textOutput(ns("chart_source"))
    })
    
    chr_src <- reactive({
      if (vbl() == "Serious Injury") {
        chr_src <-"Washington State Department of Transportation, Crash Data Division, Multi-Row data files (MRFF)"
      } else {
        chr_src <-"Washington Traffic Safety Commision, Washington State Coded Fatal Crash (CFC) analytical data files"
      }
    })
    
    output$chart_source <- renderText({
      paste0("Source: ", chr_src())
    })
    
  })
}