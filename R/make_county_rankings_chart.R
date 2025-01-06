create_bar <- function(myState, myMeasure, myDataValueType) {
  
  # Testing Purposes
  if (F) {
    myState <- "California"
    myMeasure <- "Diagnosed diabetes among adults"
    myDataValueType <- "Age-adjusted prevalence"
    incNational <- T
  }

  # Prepare Data
  t_data <- places_county %>%  
    filter(Measure == myMeasure, 
           Data_Value_Type == myDataValueType) %>% 
    mutate(LocationName = ifelse(StateAbbr == "US", "United States", LocationName))
  
  if (myState == "United States") {
    
    t_data <- t_data %>% 
      filter(LocationName %in% c(list_of_states, "United States")) %>% 
      mutate(color = case_when(LocationName == "United States" ~ "#FF5733",
                               TRUE ~ "#3498DB"
      )) %>% 
      arrange(desc(Data_Value))
    
    t_title <- paste0("U.S. State Rankings: ", myDataValueType, " of ", myMeasure)
    x_title <- "U.S. State"
    
  } else {
    
    t_data <- t_data %>% 
      filter(StateDesc %in% c(myState, "United States")) %>% 
      mutate(color = case_when(StateDesc == LocationName ~ "#FF5733", 
                               LocationName == "United States" ~ "#FF5733",
                               TRUE ~ "#3498DB"
      )) %>% 
      arrange(desc(Data_Value))
    
    t_title <- paste0(myState, " County Rankings: ", myDataValueType, " of ", myMeasure)
    x_title <- "County"
  }
           
  
  t_data <- t_data %>% 
    mutate(StateDesc = factor(LocationName, levels = t_data$LocationName))
  
  
  # Prepare Plot
  
  t_subtitle <- paste0("Year: ", unique(t_data$Year))
  y_title <- paste0(myDataValueType, " (%)")
  
  # Get number of counties
  n_counties <- length(unique(t_data$LocationName))
  
  # Create Plot
  hchart(t_data, 
         "bar",
         hcaes(x = LocationName, y = Data_Value, color = color)
         ) %>% 
    hc_title(text = t_title) %>% 
    hc_subtitle(text = t_subtitle) %>% 
    hc_xAxis(title = list(text = x_title), 
             gridLineWidth = 0, 
             categories = t_data$LocationName,
             scrollbar = list(enabled = T),
             min = 0,
             max = min(20, n_counties) # Show 20 counties at a time
             ) %>% 
    hc_yAxis(title = list(text = y_title)
             ) %>% 
    hc_add_theme(hc_theme_538()) %>% 
    hc_tooltip(
      headerFormat = "", # Remove default header
      pointFormat = "<b>{point.LocationName}</b><br>Prevalence: {point.y:.2f}%"
    )
  
    
}


# Test
if (F) {
  create_bar("Alabama", 
             "Diagnosed diabetes among adults", 
             "Crude prevalence")
}