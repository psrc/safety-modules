# Display footer

leftpanel_ui <- function(id) {
  ns <- NS(id)
  
  tagList( 
    uiOutput(ns('aleftpanel'))
  )
  
}

leftpanel_server <- function(id, contact_name, contact_title, contact_phone, contact_email, photo_filename, df) {
  
  moduleServer(id, function(input, output, session) { 
    ns <- session$ns
    
    output$aleftpanel <- renderUI({

      sidebarPanel(
        br(),
        selectInput("severity", 
                    "Select Severity Type", 
                    choices = unique(df$injury_type),
                    selected = "Traffic Related Deaths"
        ),
        
        br(),
        strong(tags$div(class="source_url", "Resources")),
        hr(style = "border-top: 1px solid #000000;"),
        a(class = "source_url", href="https://www.transportation.gov/NRSS/SafeSystem", "USDOT Safe System Approach", target="_blank"),
        hr(style = "border-top: 1px solid #000000;"),
        a(class = "source_url", href="https://targetzero.com/", "Washington State Strategic Highway Safety Plan: Target Zero", target="_blank"),
        hr(style = "border-top: 1px solid #000000;"),
        a(class = "source_url", href="https://www.togetherwegetthere.com/", "Washington Traffic Safety Commission: Together We Get There", target="_blank"),
        hr(style = "border-top: 1px solid #000000;"),
        a(class = "source_url", href="https://www.transportation.gov/grants/SS4A", "USDOT Safe Streets and Roads for All (SS4A)", target="_blank"),
        hr(style = "border-top: 1px solid #000000;"),
        div(img(src=photo_filename, width = "100%", height = "100%", style = "padding-top: 0px; border-radius:30px 0 30px 0;", alt = "Image of Region")),
        hr(style = "border-top: 1px solid #000000;"),
        strong(tags$div(class="sidebar_heading","Connect With Us")),
        hr(style = "border-top: 1px solid #000000;"),
        tags$div(class="sidebar_notes",contact_name),
        tags$div(class="sidebar_notes",contact_title),
        br(),
        icon("envelope"), 
        tags$a(class = "source_url", href=paste0("mailto:",contact_email,"?"), "Email"),
        br(), br(),
        icon("phone-volume"), contact_phone,
        hr(style = "border-top: 1px solid #000000;"),
      )
    
    })
    
  }) # end moduleServer
  
}
