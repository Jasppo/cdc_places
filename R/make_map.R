# State Map

create_map <- function(myState, myMeasure, myDataValueType) {
  
  t_dat <- places_county %>% 
    filter(Data_Value_Type == myDataValueType, Measure == myMeasure) %>% 
    select(Year, StateAbbr, StateDesc, LocationName, Measure, Data_Value_Type, Data_Value, TotalPopulation, TotalPop18plus)
  
  if (myState == "United States") {
    t_dat <- t_dat %>% 
      filter(LocationName == StateDesc)
    
    data_sf <- bound_states %>%
      left_join(t_dat, by = c("NAME" = "StateDesc")) # Match by state name
    
  } else {
    t_dat <- t_dat %>% 
      filter(grepl(" County", LocationName), StateDesc == myState)
    
    # Join your data with spatial polygons
    data_sf <- bound_counties %>%
      filter(state_name == myState) %>% 
      left_join(t_dat, by = c("NAME" = "LocationName")) # Match by state name
    
  }
  
  # Create color palette based on values
  pal <- colorNumeric(
    palette = "YlOrRd", # Color scheme (Yellow-Orange-Red)
    domain = data_sf$Data_Value, # Values from your data
    na.color = "gray" # Color for missing values
  )
  
  # Create leaflet map
  t_title <- paste0(myState, " Map")
  
  leaflet(data_sf) %>%
    # Basemap without labels (removes place names)
    addProviderTiles("CartoDB.PositronNoLabels") %>% 
    # Add state polygons with colors
    # Title using addControl
    addControl(
      html = h5(t_title),
      position = "topright" # Title position
    ) %>%
    addPolygons(
      fillColor = ~pal(Data_Value), # Fill color based on value
      color = "white", # Border color
      weight = 1, # Border thickness
      opacity = 1, # Border opacity
      fillOpacity = 0.7, # Fill opacity
      label = ~paste(NAME, ": ", round(Data_Value, 2), "%"), # Hover label
      highlightOptions = highlightOptions(
        weight = 2,
        color = "#666",
        fillOpacity = 0.9,
        bringToFront = TRUE
      )
    ) %>%
    # Add legend
    addLegend(
      pal = pal,
      values = data_sf$Data_Value,
      title = "Values",
      position = "bottomright"
    )
  
}

if (F) {
  create_map("California", "Current asthma among adults", "Crude prevalence")
}

