library(shiny)
library(plotly)

# Define the server
server <- function(input, output, session) {
  
  # Render the scaled bubble map
  output$map <- renderPlotly({
    # Replace this with your bubble map object
    plot_ly(
      data = penguins_with_coords,  
      x = ~longitude,              
      y = ~latitude,               
      type = 'scattermapbox',      
      mode = 'markers',            
      size = ~population_size,     
      color = ~species, 
      hoverinfo = 'text',          
      text = ~paste(
        "Species:", species, 
        "<br>Island:", island, 
        "<br>Population Size:", population_size
      )
    ) %>%
      layout(
        title = "Penguin Population Scaled Bubble Map", 
        mapbox = list(
          style = "open-street-map",          
          center = list(lon = -64, lat = -65), 
          zoom = 5                            
        )
      )
  })
  
  # Render the scatter plot
  output$scatter_plot <- renderPlotly({
    # Replace this with your scatter plot object
    plot_ly(
      data = penguin_data,
      x = ~bill_length_mm,
      y = ~bill_depth_mm,
      color = ~species,  
      text = ~paste(
        "Species:", species,
        "<br>Bill Length:", bill_length_mm, "mm",
        "<br>Bill Depth:", bill_depth_mm, "mm",
        "<br>Island:", island,
        "<br>Sex:", sex
      ),
      hoverinfo = "text",
      type = "scatter",
      mode = "markers"
    ) %>%
      layout(
        title = "Interactive Scatter Plot of Penguin Bill Data",
        xaxis = list(title = "Bill Length (mm)"),
        yaxis = list(title = "Bill Depth (mm)")
      )
  })
}
