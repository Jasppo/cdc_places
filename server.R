server <- function(input, output) {
  
  # County Rankings
  county_ranking_step <- reactive(
    create_bar(myState = input$input_state, 
               myMeasure = input$input_measure,
               myDataValueType = input$input_measureType
             )
    )
  
  output$chart_ranking <- renderHighchart(county_ranking_step())
  
  # Map
  map_step <- reactive(
    create_map(myState = input$input_state, 
               myMeasure = input$input_measure,
               myDataValueType = input$input_measureType
    )
  )
  
  output$map <- renderLeaflet(map_step())
  
}