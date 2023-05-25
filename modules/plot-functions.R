region_line <- function(df) {
  
  psrcplot:::make_interactive(static_line_chart(t=df %>%
                                                  filter(geography=="County" & name=="Region") %>%
                                                  select("data_year", Injuries="injuries", `Collisions`="collisions") %>%
                                                  pivot_longer(!data_year),
                                                x='data_year', y='value', fill='name', est="number",
                                                lwidth = 2, color = "pgnobgy_5") +
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
