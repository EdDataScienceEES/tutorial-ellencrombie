## Interactive Plotting of Penguin Data
## Data visualisation continued: A Coding Club Tutorial
## by Ellen Crombie (s2314259@ed.ac.uk)
## Last edited 28/11/2024

## YOUR NAME
## DATE

# NOTE: this is the code used to create the tutorial, when saving your own 
 # plots and maps, edit your file path accordingly

# Libraries ----
library(palmerpenguins) # Load penguin dataset for analysis and visualisation.
library(ggplot2) # For creating static data visualisations
library(plotly) # For interactive data visualistation
library(dplyr) # Used for data organisation

# Loading data ----
penguin_data <- na.omit(penguins) # assign the data as an object - allows easier exploration as 
# you can open the data table from your environment


# Converting from ggplot2 to plotly ----
# Create a ggplot2 scatterplot
(penguin_plot <- ggplot(data = penguin_data, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
    geom_point())

# Save the plot
ggsave(filename = "Figures/penguin_plot.png", plot = penguin_plot, width = 8, height = 6, dpi = 300)

# Convert ggplot2 to plotly
(penguin_plotly <- ggplotly(penguin_plot))

# Save the ggplotly plot as an HTML file
htmlwidgets::saveWidget(as_widget(penguin_plotly), "Figures/penguin_plotly.html")

# Activity (gpplot2 -> plotly)----
#
# bar Chart
(bar_chart <- ggplot(data = penguins, aes(x = species, fill = species)) +
  geom_bar() +
  labs(
    title = "Bar Chart of Penguin Species Count",
    x = "Species",
    y = "Count"
  ) +
  theme_minimal())

# convert to interactive plot
(bar_chart_interactive <- ggplotly(bar_chart))
# save plot
htmlwidgets::saveWidget(as_widget(bar_chart_interactive), "Figures/penguin_bar_chart.html")

# Box Plot
(box_plot <- ggplot(data = penguins, aes(x = species, y = flipper_length_mm)) +
    geom_boxplot() +
    labs(
      title = "Box Plot of Flipper Length Across Penguin Species",
      x = "Species",
      y = "Flipper Length (mm)"
    ) +
    theme_minimal())

# convert to interactive plot
(box_plot_interactive <- ggplotly(box_plot))
# save plot
htmlwidgets::saveWidget(as_widget(box_plot_interactive), "Figures/penguin_box_plot.html")


# Improved interactive plot ----
(penguin_plotly_2 <- plot_ly(
  data = penguin_data,
  x = ~bill_length_mm,
  y = ~bill_depth_mm,
  color = ~species,  # Different colors for species
  text = ~paste(
    "Species:", species, # this information specifies what should be inlcuded
    "<br>Bill Length:", bill_length_mm, "mm", # in the tooltips
    "<br>Bill Depth:", bill_depth_mm, "mm",
    "<br>Island:", island,
    "<br>Sex:", sex
  ),
  hoverinfo = "text",  # display the customised text in tooltips
  type = "scatter",
  mode = "markers"     # Scatterplot with points
) %>%
  layout(
    title = "Interactive Scatter Plot of Penguin Bill Data",
    xaxis = list(title = "Bill Length (mm)"),
    yaxis = list(title = "Bill Depth (mm)")
  ))

# save the improved plot as a HTML file
htmlwidgets::saveWidget(as_widget(penguin_plotly_2), "Figures/penguin_plotly_2.html")

## Section 2:
# Interactive Maps ----
# Assign specific coordinates for each island
penguins_with_coords <- penguins %>%
  mutate(
    latitude = case_when( 
      island == "Torgersen" ~ -64.772645,
      island == "Dream" ~ -64.726345,
      island == "Biscoe" ~ -65.713383,  # using Renaud Island as the reference for Biscoe
      TRUE ~ NA_real_  # sssign NA for any islands not listed
    ),
    longitude = case_when(
      island == "Torgersen" ~ -64.074500,
      island == "Dream" ~ -64.224375,
      island == "Biscoe" ~ -65.972880,  
      TRUE ~ NA_real_  
    ))

# interactive map 
(map_plot <- plot_ly(
  data = penguins_with_coords,  # use the new dataset that has coordinates
  x = ~longitude,              # set longitude for the x-axis
  y = ~latitude,               # set latitude for the y-axis
  type = 'scattermapbox',      # choose map type
  mode = 'markers',            # represent data points as markers
  color = ~species,            # colour points based on penguin species
  hoverinfo = 'text',          # change what appears in tooltips
  text = ~paste("Species:", species, "<br>Island:", island)
) %>%
    layout(
      title = "Map of Penguin Population Locations", # informative title
      mapbox = list(
        style = "carto-positron",  # choose map style
        center = list(lon = -64, lat = -65), # where map should be centred when first displayed
        zoom = 5 # how zoomed in it shoud be
      )
    ))

# save the map 
htmlwidgets::saveWidget(as_widget(map_plot), "Figures/penguin_map.html")


