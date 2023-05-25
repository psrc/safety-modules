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

first_yr <- min(collision_data$year)
latest_yr <- max(collision_data$year)

# full application ----
ui <- fluidPage(
  
  tags$style("@import url(https://use.fontawesome.com/releases/v6.3.0/css/all.css);"),
  theme = "styles.css",

  titlePanel(tags$a(div(tags$img(src='psrc-logo.png',
                                 style="margin-top: -80px; padding-left: 40px;",
                                 height = "80")
  ), href="https://www.psrc.org", target="_blank"), windowTitle = "PSRC Geospatial Collision Analysis"),
  
  banner_ui('overviewBanner'),
  
  sidebarLayout(sidebarPanel = leftpanel_ui('overviewleftpanel'),
                
                mainPanel = mainPanel(metric_ui("severity_type"))
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
  
  leftpanel_server('overviewleftpanel',
                   contact_name = "Craig Helmann",
                   contact_phone = "206-389-2889",
                   contact_email = "chelmann@psrc.org",
                   contact_title = "Director of Data",
                   photo_filename = "04_PR-Winter2022_Feature_SSA-Overview2.jpg",
                   df=collision_data)
  
  output$bn_title <- renderText({
    paste(input$severity)
  })
  
  df_filter <- reactive({
    collision_data %>% 
      filter(injury_type == input$severity & geography=="County" & name=="Region")
  })
  
  metric_server("severity_type", 
                df = reactive(df_filter()), 
                vbl = reactive(input$severity),
                yr = latest_yr)
  
  output$safety_text_1 <- renderText({safety_overview_1})
  
  output$safety_text_2 <- renderText({safety_overview_2})
  
  output$safety_text_3 <- renderText({safety_overview_3})
  
  output$safety_text_4 <- renderText({safety_overview_4})
  
  output$safety_text_5 <- renderText({safety_overview_5})
  
  output$safety_text_6 <- renderText({safety_overview_6})
  
  output$safety_text_7 <- renderText({safety_overview_7})
  
}

shinyApp(ui, server)
