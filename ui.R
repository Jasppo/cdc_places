ui <- page_navbar(
  title = "My App",
  nav_panel(title = "One",
            layout_column_wrap(
              width = 1/3,
              input_state,
              input_measure,
              input_measureType
            ), 
            layout_column_wrap(
              width = 1/2,
              highchartOutput("chart_ranking"), 
              p("Under Contruction")
            )
            ),
  nav_panel(title = "Two", p("Second page content")),
  nav_panel(title = "Three", p("Third page content")),
  nav_spacer(),
  nav_menu(
    title = "Links",
    align = "right",
    nav_item(link_shiny),
    nav_item(link_posit)
  )
)