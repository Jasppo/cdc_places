# Country/State ------------------------------------------
options_states <- sort(unique(places_county$StateDesc))

input_state <- pickerInput(
  inputId = "input_state",
  label = "Select State", 
  choices = options_states,
  selected = "United States",
  options = pickerOptions(container = "body", 
                          liveSearch = TRUE),
  width = "100%"
)

# Measures -----------------------------------------------
categories <- sort(unique(places_county$Category))
measures <- lapply(categories, function(x) {
  places_county %>% 
    filter(Category == x) %>%
    distinct(Measure) %>% 
    arrange(Measure) %>% 
    pull(Measure)
})
names(measures) <- categories

input_measure <- pickerInput(
  inputId = "input_measure",
  label = "Select Measure", 
  choices = measures,
  options = pickerOptions(container = "body", 
                          liveSearch = TRUE), 
  width = "100%"
)

# Measure Type ------------------------------------------
measure_type <- sort(unique(places_county$Data_Value_Type))

input_measureType <- pickerInput(
  inputId = "input_measureType",
  label = "Select Measure Type", 
  choices = measure_type,
  options = pickerOptions(container = "body"), 
  width = "100%"
)
