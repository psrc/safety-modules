region_line <- function(df) {
  
  psrcplot:::make_interactive(static_line_chart(t=df %>%
                                                  select("year", Injuries="injuries", `Collisions`="collisions") %>%
                                                  pivot_longer(!year),
                                                x='year', y='value', fill='name', est="number",
                                                lwidth = 2, color = "pgnobgy_5") +
                                ggplot2::scale_y_continuous(limits=c(0,max(df$injuries)*1.25), labels=scales::label_comma()))
}
