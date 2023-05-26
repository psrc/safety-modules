# Tabset Panel Visualization by Severity Type Module ----

tabset_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    
    tabsetPanel(id = ns('tabset'),
                type = 'pills',
                selected = 'Overview',
                tabPanel('Overview',
                         h2("Safety in the Regional Transportation Plan"),
                         textOutput("safety_text_1"),
                         br(),
                         strong(textOutput("safety_text_2")),
                         br(),
                         textOutput("safety_text_5"),
                         h2("Racial Dispartieis in Traffic Deaths"),
                         textOutput("safety_text_4"),
                         br(), 
                         div(img(src="fatal-rate-by-race-wa.png", width = "75%", alt = "Fatality Rate by Race")),
                         tags$div(class="chart_source","Source: Washington State Strategic Highway Safety Plan"),
                         br(),
                         textOutput("safety_text_6"),
                         h2("Principles of a Safe System Approach"), 
                         textOutput("safety_text_3"),
                         br(), 
                         HTML("&emsp;* Death and Serious Injuries are <b>Unacceptable</b><br/>
                         &emsp;* Humans Make <b>Mistakes</b><br/>
                         &emsp;* Humans Are <b>Vulnerable</b><br/>
                         &emsp;* Responsibility is <b>Shared</b><br/>
                         &emsp;* Safety is <b>Proactive</b><br/>
                         &emsp;* Redundancy is <b>Crucial</b>"),
                         br(), br(),
                         textOutput("safety_text_7"),
                         br()
                         ),
                tabPanel('by Place', 
                         br(),
                         h2("Region"),
                         radioButtons("region_toggle", label = "Rate or Total",
                                      choices = list("Total" = "injuries", "Rate per 100k people" = "injury_rate_per_100k"),
                                      selected = "injuries",
                                      inline = TRUE),
                         chart_text_ui(ns('region_text')),
                         plot_ui(ns("region_chart")),
                         tags$div(class="chart_source", chart_source_ui(ns("region_source"))),
                         h2("County"),
                         radioButtons("county_toggle", label = "Rate or Total",
                                      choices = list("Total" = "injuries", "Rate per 100k people" = "injury_rate_per_100k"),
                                      selected = "injuries",
                                      inline = TRUE),
                         ),
                tabPanel('by Demographics',
                         br(),
                         h2("Race and Ethnicity"),
                         fluidRow(column(12,echarts4rOutput("fatal_demographics", height = "500px"))),
                         tags$div(class="chart_source", chart_source_ui(ns("demographic_source"))),
                         )

                ) # end of tabset panel
                        
  
    ) # end of tag list

}

tabset_server <- function(id, df, vbl) {
  
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    chart_text_server('region_text', df, vbl)
    plot_server("region_chart", df)
    
    # Dynamic Sources for various charts
    chart_source_server('region_source', vbl)
    chart_source_server('demographic_source', vbl)
  })
  
}
