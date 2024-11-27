library(shiny)
library(plotly)

# Define the UI
ui <- fluidPage(
  titlePanel("Penguin Data Visualization"),
  
  sidebarLayout(
    sidebarPanel(
      p("This app displays a scaled interactive bubble map of penguin populations alongside a scatter plot of bill data.")
    ),
    mainPanel(
      plotlyOutput("map"),          # Bubble map output
      plotlyOutput("scatter_plot") # Scatter plot output
    )
  )
)
