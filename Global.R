# Load packages ---------------------------------------------------------------

library(bslib) # Shiny framework
library(dplyr) # Data wrangling
library(ggplot2) # Static plots
library(highcharter) # Interactive Plots
library(leaflet) # Make maps
library(shiny)
library(shinyWidgets)


# Load Data -------------------------------------------------------------------
places_county <- read_csv("data/places_county_2024.csv")

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

