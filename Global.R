# Load packages ---------------------------------------------------------------

library(bslib) # Shiny framework
library(dplyr) # Data wrangling
library(ggplot2) # Static plots
library(highcharter) # Interactive Plots
library(leaflet) # Make maps
library(readr)
library(shiny)
library(shinyWidgets)
library(sf)
library(tigris)


# Load Data -------------------------------------------------------------------
places_county <- read_csv("data/places_county_2024.csv") %>% 
  filter(!StateDesc %in% c("Alaska", "Hawaii"))

list_of_states <- unique(places_county$StateDesc)

bound_states <- tigris::states(year = 2020) %>% 
  filter(NAME %in% list_of_states) %>% 
  select(STATEFP, NAME) %>% 
  st_transform(crs = 4326) # Transform CRS to WGS84 (EPSG:4326)


bound_states_df <- bound_states %>% 
  st_drop_geometry() %>% 
  rename(state_name = NAME)

bound_counties <- tigris::counties(year = 2020) %>% 
  filter(!STATEFP %in% c("02", "15")) %>% 
  select(STATEFP, COUNTYFP, NAME) %>% 
  st_transform(crs = 4326) %>% 
  mutate(NAME = paste0(NAME, " County")) %>% 
  left_join(bound_states_df) %>% 
  filter(!is.na(state_name))

# Icons -----------------------------------------------------------------------

link_shiny <- tags$a(
  shiny::icon("github"), "Shiny",
  href = "https://github.com/rstudio/shiny",
  target = "_blank"
)
link_posit <- tags$a(
  shiny::icon("r-project"), "Posit",
  href = "https://posit.co",
  target = "_blank"
)

