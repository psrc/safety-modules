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
