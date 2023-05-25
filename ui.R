shinyUI(
  
  fluidPage(
  
  tags$style("@import url(https://use.fontawesome.com/releases/v6.3.0/css/all.css);"),
  theme = "styles.css",
  
  titlePanel(tags$a(div(tags$img(src='psrc-logo.png',
                                 style="margin-top: -80px; padding-left: 40px;",
                                 height = "80")
  ), href="https://www.psrc.org", target="_blank"), windowTitle = "PSRC Geospatial Collision Analysis"),
  
  banner_ui('overviewBanner'),
  
  sidebarLayout(sidebarPanel = leftpanel_ui('overviewleftpanel'),
                
                mainPanel = mainPanel(tabset_ui("severity_type"))
  ), # end of sidebar
  
  tags$footer(footer_ui('psrcfooter'))
  
  ) # end of fluid page

) # end of app