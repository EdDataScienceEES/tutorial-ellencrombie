## Interactive Plotting of Penguin Data
## Data visualisation continued: A Coding Club Tutorial
## by Ellen Crombie (s2314259@ed.ac.uk)
## Last edited 28/11/2024

## YOUR NAME
## DATE

# Libraries ----
library(palmerpenguins) # Load penguin dataset for analysis and visualisation.
library(ggplot2) # For creating static data visualisations
library(plotly) # # For interactive data visualistation

# Loading data ----
penguin_data <- penguins # assign the data as an object - allows easier exploration as 
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



  # direct plotly box plot
plot_ly(
  data = penguin_data, 
  x = ~species,          # Group by species on the x-axis
  y = ~flipper_length_mm, # Flipper length on the y-axis
  type = "box")




