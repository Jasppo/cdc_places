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
    filter(StateDesc %in% c(myState, "United States"),
           Measure == myMeasure, 
           Data_Value_Type == myDataValueType) %>% 
    mutate(LocationName = ifelse(StateAbbr == "US", "United States", LocationName), 
           color = ifelse(LocationName == "United States", "#FF5733", "#3498DB")) %>% 
    arrange(desc(Data_Value))
  
  t_data <- t_data %>% 
    mutate(StateDesc = factor(LocationName, levels = t_data$LocationName))
  
  
  # Prepare Plot
  t_title <- paste0(myState, " County Rankings: ", myDataValueType, " of ", myMeasure)
  t_subtitle <- paste0("Year: ", unique(t_data$Year))
  x_title <- "County"
  y_title <- paste0(myDataValueType, " (%)")
  
  # Create Plot
  hchart(t_data, 
         "bar",
         hcaes(x = LocationName, y = Data_Value, color = color)
         ) %>% 
    hc_title(text = t_title) %>% 
    hc_xAxis(title = list(text = x_title), 
             gridLineWidth = 0, 
             categories = t_data$LocationName,
             scrollbar = list(enabled = T),
             min = 0,
             max = 20 # Show 20 counties at a time
             ) %>% 
    hc_yAxis(title = list(text = y_title)
             ) %>% 
    hc_add_theme(hc_theme_538()) %>% 
    hc_tooltip(
      headerFormat = "", # Remove default header
      pointFormat = "<b>{point.LocationName}</b><br>Prevalence: {point.y}%"
    )
  
    
}


# Test
if (F) {
  create_bar("Alabama", 
             "Diagnosed diabetes among adults", 
             "Crude prevalence")
}