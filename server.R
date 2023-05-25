shinyServer(function(input, output, session) {
  
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
  
  tabset_server("severity_type", 
                df = reactive(df_filter()), 
                vbl = reactive(input$severity))
  
  output$safety_text_1 <- renderText({safety_overview_1})
  
  output$safety_text_2 <- renderText({safety_overview_2})
  
  output$safety_text_3 <- renderText({safety_overview_3})
  
  output$safety_text_4 <- renderText({safety_overview_4})
  
  output$safety_text_5 <- renderText({safety_overview_5})
  
  output$safety_text_6 <- renderText({safety_overview_6})
  
  output$safety_text_7 <- renderText({safety_overview_7})
  
})