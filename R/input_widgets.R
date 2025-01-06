# background-image: url("../heroImage-cut.jpg");
# background-size: cover;
# background-position: center;
# background-repeat: no-repeat;

# Country/State ------------------------------------------
options_states <- sort(unique(places_county$StateDesc))

input_state <- pickerInput(
  inputId = "input_state",
  label = NULL, 
  choices = options_states,
  selected = "United States",
  options = pickerOptions(container = "body", 
                          liveSearch = TRUE, 
                          style = "btn-primary"
                          ),
  width = "300px"
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
  label = NULL, 
  choices = measures,
  options = pickerOptions(container = "body", 
                          liveSearch = TRUE, 
                          style = "btn-primary"
                          ), 
  width = "300px"
)

# Measure Type ------------------------------------------
measure_type <- sort(unique(places_county$Data_Value_Type))

input_measureType <- pickerInput(
  inputId = "input_measureType",
  label = NULL, 
  choices = measure_type,
  options = pickerOptions(container = "body", 
                          style = "btn-primary"
                          ), 
  width = "300px"
)
