# load libraries ----
library(tidyverse)

library(shiny)
library(shinydashboard)
library(bs4Dash)

library(psrcplot)
library(ggplot2)
library(plotly)
library(echarts4r)

# load resources ----
module_files <- list.files('modules', full.names = TRUE)
sapply(module_files, source)
fa_person <- "path://M112 48a48 48 0 1 1 96 0 48 48 0 1 1 -96 0zm40 304V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V256.9L59.4 304.5c-9.1 15.1-28.8 20-43.9 10.9s-20-28.8-10.9-43.9l58.3-97c17.4-28.9 48.6-46.6 82.3-46.6h29.7c33.7 0 64.9 17.7 82.3 46.6l58.3 97c9.1 15.1 4.2 34.8-10.9 43.9s-34.8 4.2-43.9-10.9L232 256.9V480c0 17.7-14.3 32-32 32s-32-14.3-32-32V352H152z"
echarts4r::e_common(font_family = "Poppins")

# data prep ----
collision_data <- read_csv("data/collision_data.csv", show_col_types = FALSE) %>% 
  mutate(data_year = as.character(year)) %>%
  mutate(injury_type = str_replace_all(injury_type, "Fatality", "Traffic Related Deaths"))

fatal_by_race <- read_csv("data/fatal_collision_data.csv", show_col_types = FALSE) %>% 
  filter(variable == "Race & Ethnicity" & metric == "1-year average for fatal collisions" & geography=="Region" & year==2021) %>%
  mutate(fatality_rate = round(fatality_rate,1)) %>%
  dplyr::arrange(fatality_rate) %>%
  dplyr::mutate(race= str_wrap(grouping, 10))

first_yr <- min(collision_data$year)
latest_yr <- max(collision_data$year)
