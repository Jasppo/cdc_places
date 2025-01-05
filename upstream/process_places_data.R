# Documentation ---------------------------------------------------------------

# Process CDC Places Data - County and Tract Level - 2024 Data

# covers the entire United States—50 states and the District of Columbia

# The dataset includes estimates for 40 measures: 
# - 12 for health outcomes
# - 7 for preventive services use
# - 4 for chronic disease-related health risk behaviors
# - 7 for disabilities
# - 3 for health status
# - 7 for health-related social needs

# Data Sources:
# - BRFSS 2022 or 2021 data
#   - All measures from 2022 except 4 which are from 2021:
#     - 1. high BP
#     - 2. high cholesterol
#     - 3. cholesterol screening
#     - 4. taking medicine for high blood pressure control among those with high blood pressure
# - Census 2020 population data
# - American Community Survey 2018-2022

# Note:
# Two county values: Crude prevalence (%) and Age-adjusted prevalence (%)
# All tract values are % (crude prevalence)

# Download Links:
# Tract level: https://data.cdc.gov/500-Cities-Places/PLACES-Local-Data-for-Better-Health-Census-Tract-D/cwsq-ngmh/about_data
# County level: https://data.cdc.gov/500-Cities-Places/PLACES-Local-Data-for-Better-Health-County-Data-20/swc5-untb/about_data

# Author: Genie Tang
# Created: Decemeber 2, 2024
# Last Modified: December 10, 2024

# Load packages ---------------------------------------------------------------
library(dplyr)
library(readr)

# Load data -------------------------------------------------------------------
raw_data_county <- read_csv("upstream/data/PLACES_county_2024.csv")
raw_data_tract <- read_csv("upstream/data/PLACES_tract_2024.csv")


# Process Data ----------------------------------------------------------------

# Remove columns
data_county <- raw_data_county %>% 
  select(-DataSource, -Data_Value_Unit,
         -Data_Value_Footnote, -Data_Value_Footnote_Symbol, -Geolocation, 
         -CategoryID, -MeasureId)


data_tract <- raw_data_tract %>% 
  select(-DataSource, -Data_Value_Unit, -Data_Value_Type, -DataValueTypeID, 
         -Data_Value_Footnote, -Data_Value_Footnote_Symbol, -Geolocation, 
         -CategoryID, -MeasureId, -LocationID)

# Compute State prevalence
states <- data_county %>% 
  filter(StateDesc != "United States") %>% 
  distinct(StateDesc) %>% 
  pull(StateDesc)

measures <- data_county %>% 
  distinct(Measure) %>% 
  pull(Measure)

measure_types <- unique(data_county$Data_Value_Type)

t_dat <- data_county %>% 
  filter(StateDesc == "California")

t_dat2 <- t_dat %>% 
  filter(Measure == "Cancer (non-skin) or melanoma among adults")

t_dat2 %>% 
  filter(Data_Value_Type == "Crude prevalence") %>% 
  mutate(value = (Data_Value / 100) * TotalPop18plus)
  View()

# Loop through each to calculate state prevalence
data_state <- lapply(states, function(x) {
  
  t_dat <- data_county %>% 
    filter(StateDesc == x)
  
  lapply(measures, function(y) {
    
    t_dat2 <- t_dat %>% 
      filter(Measure == y)
    
    lapply(measure_types, function(z) {
      
      t_dat2 %>% 
        filter(Data_Value_Type == z) %>% 
        
      
    })
    
  })
  
})

# Save Data -------------------------------------------------------------------

write_csv(data_county, "data/places_county_2024.csv")
write_csv(data_tract, "data/places_tract_2024.csv")