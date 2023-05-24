# load libraries ----

library(shiny)
library(shinydashboard)
library(bs4Dash)

library(psrcplot)
library(ggplot2)
library(tidyverse)
library(plotly)

# load resources ----
module_files <- list.files('modules', full.names = TRUE)
sapply(module_files, source)

# data prep ----
collision_data <- read_csv("data/collision_data.csv", show_col_types = FALSE) %>% 
  mutate(data_year = as.character(year)) %>%
  mutate(injury_type = str_replace_all(injury_type, "Fatality", "Traffic Related Deaths"))

# full application ----
ui <- fluidPage(
  
  tags$style("@import url(https://use.fontawesome.com/releases/v6.3.0/css/all.css);"),
  
  theme = "styles.css",

  titlePanel(tags$a(div(tags$img(src='psrc-logo.png',
                                 style="margin-top: -30px; padding-left: 40px;",
                                 height = "80")
  ), href="https://www.psrc.org", target="_blank"), windowTitle = "PSRC Geospatial Collision Analysis"),
  
  banner_ui('overviewBanner'),
  
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      br(),
      selectInput("severity", 
                  "Select Severity Type", 
                  choices = unique(collision_data$injury_type),
                  selected = "Traffic Related Deaths"
      ),
      br(),
      strong(tags$div(class="source_url", "Resources")),
      hr(style = "border-top: 1px solid #000000;"),
      a(class = "source_url", href="https://www.psrc.org/planning-2050/regional-transportation-plan/projects-and-approval", "Projects and Approval", target="_blank"),
      hr(style = "border-top: 1px solid #000000;"),
      a(class = "source_url", href="https://www.psrc.org/coordinated-mobility-plan", "Coordinated Mobility Plan", target="_blank"),
      hr(style = "border-top: 1px solid #000000;"),
      a(class = "source_url", href="https://www.psrc.org/planning-2050/regional-transportation-plan/data-research-and-policy-briefs", "Data, Research and Policy Briefs", target="_blank"),
      hr(style = "border-top: 1px solid #000000;"),
      a(class = "source_url", href="https://www.psrc.org/planning-2050/regional-transportation-plan/transportation-system-visualization-tool", "Transportation System Visualization Tool", target="_blank"),
      hr(style = "border-top: 1px solid #000000;"),
      div(img(src="climate-image.png", width = "100%", height = "100%", style = "padding-top: 0px; border-radius:30px 0 30px 0;", alt = "Glass and steel building in the background")),
      hr(style = "border-top: 1px solid #000000;"),
      strong(tags$div(class="sidebar_heading","Connect With Us")),
      hr(style = "border-top: 1px solid #000000;"),
      tags$div(class="sidebar_notes","Craig Helmann"),
      tags$div(class="sidebar_notes","Director of Data"),
      br(),
      icon("envelope"), 
      tags$a(class = "source_url", href=paste0("mailto:","chelmann@psrc.org","?"), "Email"),
      br(), br(),
      icon("phone-volume"), "206-389-2889",
      hr(style = "border-top: 1px solid #000000;"),
    ),
    mainPanel = mainPanel(
      h2("Region"),
      metric_ui("region"),
      h2("County"),
      h2("Historically Disadvantaged Communities (HDC)")
    )
    
  ),
  
  tags$footer(footer_ui('psrcfooter'))
)

server <- function(input, output, session) {
  
  banner_server('overviewBanner', 
                photo_filename = "street-intersection.jpeg", 
                banner_title = textOutput("bn_title"), 
                banner_subtitle = "Regional Transportation Plan",
                banner_url = "https://www.psrc.org/planning-2050/regional-transportation-plan")
  
  footer_server('psrcfooter')
  
  output$bn_title <- renderText({
    paste(input$severity, "Collisions")
  })
  
  df_filter <- reactive({
    collision_data %>% 
      filter(injury_type == input$severity & geography=="County" & name=="Region")
  })
  
  metric_server("region", 
                df = reactive(df_filter()), 
                vbl = reactive(input$severity))
  
  
  
}

shinyApp(ui, server)
