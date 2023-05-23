# Display footer

leftpanel_ui <- function(id) {
  ns <- NS(id)
  
  tagList( 
    uiOutput(ns('aleftpanel'))
  )
  
}

leftpanel_server <- function(id, contact_name, contact_title, contact_phone, contact_email, photo_filename) {
  
  moduleServer(id, function(input, output, session) { 
    ns <- session$ns
    
    output$aleftpanel <- renderUI({

      bs4Jumbotron(
        title = strong(tags$div(class="source_url", "Resources")),
        hr(style = "border-top: 1px solid #000000;"),
        a(class = "source_url", href="https://www.psrc.org/planning-2050/regional-transportation-plan/projects-and-approval", "Projects and Approval", target="_blank"),
        hr(style = "border-top: 1px solid #000000;"),
        a(class = "source_url", href="https://www.psrc.org/coordinated-mobility-plan", "Coordinated Mobility Plan", target="_blank"),
        hr(style = "border-top: 1px solid #000000;"),
        a(class = "source_url", href="https://www.psrc.org/planning-2050/regional-transportation-plan/data-research-and-policy-briefs", "Data, Research and Policy Briefs", target="_blank"),
        hr(style = "border-top: 1px solid #000000;"),
        a(class = "source_url", href="https://www.psrc.org/planning-2050/regional-transportation-plan/transportation-system-visualization-tool", "Transportation System Visualization Tool", target="_blank"),
        hr(style = "border-top: 1px solid #000000;"),
        div(img(src=photo_filename, width = "100%", height = "100%", style = "padding-top: 0px; border-radius:30px 0 30px 0;", alt = "Glass and steel building in the background")),
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
        
        status = "primary",
        btnName = NULL
      )                
    
      
    })
    
  }) # end moduleServer
  
}