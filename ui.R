ui <- tagList(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "main.css") # Include the CSS file
  ),
  tags$style("@import url(https://use.fontawesome.com/releases/v6.2.0/css/all.css);"), # Import current version of FontAwesome
  
  page_navbar(
    title = "Public Health Informatics",
    theme = bs_theme(primary = "#1a81f4"),
    
    nav_panel(
      title = "Charts",
      
      # Hero Section
      div(class = "hero-wrapper",
          div(class = "hero-image",
              div(class = "hero-text",
                  h1("Health Equity Dashboard", style = "font-size:50px"),
                  p("Empowering Communities with Data-Driven Insights—Uncover Health Trends, Identify Disparities, and Drive Change with CDC PLACES Data.", style = "font-size:18px")
              ), 
              
              # div(class = "hero-images-row",
              #     img(src = "uncover_health_trends.png", class = "hero-image-box"),
              #     img(src = "identifying_disparities.png", class = "hero-image-box"),
              #     img(src = "driving_change.png", class = "hero-image-box")
              # ), 
              
              div(class = "hero-images-row", 
                  img(src = "Health-eq.png", class = "hero-image-box")
                  ),
              
              br(), br(),
              
              h5(em("Note: Dashboard still under construction"))
              
              )),
      
      br(), br(),
      
      # Global Inputs Selection
      div(
        class = "county_global", 
        style = "display: flex; justify-content: center; align-items: flex-start; gap: 20px;",
        
        # First Input: Select State
        div(
          style = "display: flex; flex-direction: column; align-items: center;",
          tags$h3("Select State", style = "margin-bottom: 5px;"),
          input_state
        ),
        
        # Second Input: Select Measure
        div(
          style = "display: flex; flex-direction: column; align-items: center;",
          tags$h3("Select Measure", style = "margin-bottom: 5px;"),
          input_measure
        ),
        
        # Third Input: Crude or Age-Adjusted
        div(
          style = "display: flex; flex-direction: column; align-items: center;",
          tags$h3("Crude or Age-Adjusted", style = "margin-bottom: 5px;"),
          input_measureType
        )
      ),
      
      br(), br(),
      
      div(class = "charts_section", 
          # Charts
          card(
            card_body(
              layout_column_wrap(
                width = 1/2,
                highchartOutput("chart_ranking", height = 700), 
                leafletOutput("map", height = 700)
              )
            )
          ), 
          h5(em(
            "Data Source: ",
            tags$a(
              href = "https://data.cdc.gov/500-Cities-Places/PLACES-Local-Data-for-Better-Health-County-Data-20/swc5-untb/about_data",
              "CDC PLACES - Local Data for Better Health, County Data 2024 release", # Display text for the link
              target = "_blank" # Opens link in a new tab
            )
          ))),
      
      # Footer Section
      tags$footer(
        class = "app-footer",
        div(
          class = "footer-content",
          # Left Section - Name
          div(
            class = "footer-left",
            HTML("&copy; 2024 Genie Tang")
          ),
          # Middle Section - Version and Last Updated
          div(
            class = "footer-center",
            HTML("<b>Version:</b> 1.0.0 | <b>Last Updated:</b> Dec 30, 2024")
          ),
          # Right Section - Contact and Links
          div(
            class = "footer-right",
            HTML('<a href="mailto:your_email@example.com">Contact</a> | 
              <a href="https://github.com/PublicHealthInformatics/HealthEquity" target="_blank">GitHub Repo</a>')
          )
        )
      ),
      
      # Add CSS for styling
      tags$head(
        tags$style(HTML("
      /* Footer Styling */
      .app-footer {
        background-color: #343a40; /* Dark gray background */
        color: white; /* White text */
        padding: 15px 20px; /* Padding */
        font-size: 14px; /* Font size */
        border-top: 3px solid #007bff; /* Blue border on top */
        width: 100%; /* Full width */
        margin-top: 20px; /* Adds spacing between content and footer */
      }
      .footer-content {
        display: flex;
        justify-content: space-between; /* Equal spacing */
        align-items: center; /* Vertically align content */
      }
      .footer-left, .footer-center, .footer-right {
        flex: 1; /* Equal space for each section */
        text-align: center;
      }
      .footer-right a {
        color: #17a2b8; /* Bootstrap info color */
        text-decoration: none;
        margin: 0 5px;
      }
      .footer-right a:hover {
        text-decoration: underline;
      }
    ")))
      
      
    )
    
)
)