region_line <- function(df) {
  
  psrcplot:::make_interactive(static_line_chart(t=df %>% filter(geography=="County" & name=="Region"),
                                                x='data_year', y='injuries', fill='name', est="number",
                                                lwidth = 2, color = "pgnobgy_5") +
                                ggplot2::geom_point(colour = psrc_colors$pgnobgy_5[[2]], size = 3) +
                                ggplot2::theme(legend.position = "none") +
                                ggplot2::scale_y_continuous(limits=c(0,max(df$injuries)*1.25), labels=scales::label_comma()))
}

county_line <- function(df) {
  
  psrcplot:::make_interactive(static_line_chart(t=df %>% filter(geography=="County" & name !="Region"),
                                                x='data_year', y=input$county_toggle, fill='name', est="number",
                                                lwidth = 2, color = "pgnobgy_5",
                                                dec=if(input$county_toggle=="injury_rate_per_100k") {dec=1} else {dec=0}) +
                                ggplot2::scale_y_continuous(limits=c(0,
                                                                     round(df %>% filter(geography=="County" & name!="Region") %>% select(all_of(input$county_toggle)) %>% pull() %>% max()*1.25,0)),
                                                            labels=scales::label_comma()))

}

create_pictogram <- function(df, x, vbl, icon_svg, title, hover, color) {
  
  # First Modify data to make plot in echarts4r
  df <- df %>%
    select(name=all_of(x), value=all_of(vbl))
  
  picto_chart <- df %>% 
    e_charts(x=name) %>%
    e_color(color) %>%
    e_tooltip() %>%
    e_pictorial(serie = value, 
                symbol = icon_svg,
                symbolRepeat = TRUE, z = -1,
                symbolSize = 40,
                legend = FALSE, 
                name = hover) %>%
    e_title(title) %>%
    e_flip_coords() %>%
    e_legend(show = FALSE) %>%
    e_x_axis(splitLine=list(show = FALSE)) %>% 
    e_y_axis(splitLine=list(show = FALSE),
             axisPointer = list(show = FALSE))
  
  return(picto_chart)
  
}


