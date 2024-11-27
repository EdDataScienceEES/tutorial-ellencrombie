<p align="left">
  <img src="https://github.com/EdDataScienceEES/tutorial-ellencrombie/blob/b4d472d0d16d8b3c4a36a63fc64683fd34168f8d/coding_club_logo.png?raw=true" alt="Coding Club Logo" width="200">
</p>

___
# Data Visualisation Continued: Interactive Visualisations 
#### Created by Ellen Crombie - last updated 27th November 2024
### Tutorial Sections
- Click on these sections to be taken directly to them!
  
#### <a href="#section1"> 1. Introduction to interactive plots using `plotly` </a>

#### <a href="#section2"> 2. Interactive map visualisations </a>

#### <a href="#section3"> 3. Embedding multiple plots into an app (using shiny) `</a>

### Introduction
---------------------------
This tutorial aims to continue building on skills already introduced on the topic of data visualisation by introducing an interactive element to both graphs and maps. Interactivity is an important aspect of data visualisation in the modern world as it is an important tool used by many websites, including the BBC, see a recent example [here](https://www.bbc.co.uk/news/articles/c0lp48ldgyeo), and other more data centred websites such as [Our World in Data](https://ourworldindata.org/).

Interactivity allows the user to gain greater insight into what the plot or map is actually showing __WITHOUT__ cluttering the visualisation or reducing its readability.
### Aims and Steps
-----------------------------
#### Introduction to interactive plots using `plotly`
1. Overview of plotly - installation and importing
2. Basic plotting - plotly vs ggplotly
3. Customisations of tooltips and hover effects
#### Interactive map visualisations using `leaflet`
4. Use of interactive maps
#### Interactive data dashboards: combining `plotly` and `leaflet`


> #### **Note** - All the files you need to complete this tutorial can be downloaded from [this Github repository](https://github.com/EdDataScienceEES/tutorial-ellencrombie.git). Clone and download the repo as a zip file, then unzip it and set the folder as your working directory by running the code underneath (replace with your actual folder path) or clicking `Session/ Set Working Directory/ Choose Directory` from the RStudio menu.


\
\
<a name="section1"></a>

## 1. Introduction to Interactive Plots using `plotly`
#### Overview
Plotly helps help your data to life! you can zoom, pan, hover ... giving new depths to your charts.

__Key Functions and What They Do__

Here's a glossary of some key function within plotly, we will work through highlighting some in particular, but use this bank as a reference for making your own plotly graphs!

| **Function**         | **What It Does**                                                     |
|----------------------|----------------------------------------------------------------------|
| `plot_ly()`          | creates a new Plotly plot from scratch                        |
| `ggplotly()`         | converts ggplots into interactive Plotly plots            |
| `subplot()`          | combines multiple plots into one interactive dashboard              |
| `add_trace()`        | add new data series to a plot (scatter, lines, bars etc.). |
| `layout()`           | customise the layout (titles, axes, legends, etc.)                  |
| `style()`            | change plot elements like colors and hover information          |
| `highlight_key()`    | highlight specific data points interactively      |
| `saveWidget()`       | save your plotly graph as an interactive HTML file so it can be uploaded to websites etc. |

#### Downloading Data and Loading Libraries

Make a new script file by clicking `File/ New File/ R Script`, give it a title and include relevant information like your name, date, contact information.

Within this example we will be using the 'palmerpenguins' dataset, this data was collected and made available by Dr. Kristen Gorman and the Palmer Station, Antarctica LTER.
\
\
__Meet the penguins!__
<p align="center">
  <img src="https://github.com/user-attachments/assets/da3e6138-44e7-49f2-b0f8-c1421e0bbe72" alt="Description of image" width="300">
	Artwork by @allison_horst.
</p>

Data Citation:
Gorman KB, Williams TD, Fraser WR (2014). Ecological sexual dimorphism and environmental variability within a community of Antarctic penguins (genus Pygoscelis). PLoS ONE 9(3):e90081. https://doi.org/10.1371/journal.pone.0090081

This dataset can be called directly into R within libaries.

> Note: use `install.packages("palmerpenguins")` to install this package. Then you can edit within the "" to install any other necessary packages that are used in this tutorial.

```r
## Interactive Plotting of Penguin Data
## Data visualisation continued: A Coding Club Tutorial
## YOUR NAME
## DATE

# Libraries ----
library(palmerpenguins) # Load penguin dataset for analysis and visualisation.
library(ggplot2) # For creating static data visualisations
library(plotly) # # For interactive data visualistation
library(dplyr) # Used for data organisation
library(shiny) # Combining interactive plots in an app
library(htmlwidgets) # allows saving of interactive plots/maps

# Loading data ----
# assign the data as an object - allows easier exploration, you can open the data table from your environment
penguin_data <- na.omit(penguins) # remove na's for ease of plotting
```

#### Basic Plotting
Let's start simply, plotly has two options when creating interactive graphs. The first being to create it directly, using `plot_ly()`. And the second being to convert a static plot from `ggplot2`(like those you have learned how to make in [previous tutorials](https://ourcodingclub.github.io/tutorials/data-vis-2/).
) to an interactive one using `ggplotly()`. 

As you will be familiar with `ggplot` plots, lets start there!
##### Interactive Scatter Plot
Lets begin with a simple plot, the only extra information I'm adding is specifying `colour = species` so we can distinguish data points by penguin species
```r
# Create a ggplot2 scatterplot
(penguin_plot <- ggplot(data = penguin_data, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point())

# save plot
ggsave(filename = "your_file_path/penguin_plot.png", plot = penguin_plot, width = 8, height = 6, dpi = 300)
```
It should look like this:

<div style="text-align: center;">
<img src="Figures/penguin_plot.png" width="800" height="600" />
</div>
## Interactive Plots of Penguin Data

Now, lets convert this basic plot into an interactive one !
```r
# Convert ggplot2 to plotly
(penguin_plotly <- ggplotly(penguin_plot))
# Save the ggplotly plot as an HTML file
htmlwidgets::saveWidget(as_widget(penguin_plotly), "your_file_path/penguin_plotly.html")
```
<div style="text-align: center;">
<iframe src="Figures/penguin_plotly.html" width="800" height="600"></iframe>
</div>

> ### Try hovering your cursor over points on the plot ... what information do you see?
You should see information on penguin ...
1. Bill length
2. Bill depth
3. Species
   
... that relates to the specific point you are hovering over, and so changes as you move the cursor over the plot.

The information displayed in these tooltips comes from the data supplied when creating the graph in the first place, however the content inside them can be altered to make the interactivity more useful and show information that wouldn't otherwise fit in the plot.

> Tooltips just refer to the little box that appears and provides extra infromation when you hover over data points in plotly graphs.

You should also notice that you can now zoom and pan within the plot, as well as edit how you see see tooltips on this graph, for example you can now 'compare data on hover' this displays multiple tooltips at once. When this is enabled, all data points that share the same x or y coordinate (depending on the plot's layout) display their tooltips simultaneously. This comparison provides additional context by letting you see how multiple points relate to each other.

`hovermode = "x unified"`: Displays tooltips for all points with the same x-coordinate.

`hovermode = "y unified"`: Displays tooltips for all points with the same y-coordinate.

These distinctions are made within `layout()` when you make plot_ly graphs directly, we will further explore this in the next 'plotly graph' section...

> ### Activity : Here you've seen how to make a scatter plot interactive, now try converting some different types of plots using `ggplotly()`.
> 1. Bar Chart of Penguin Abundance (grouped by species)
> 2. Box Plot displaying flipper length
> #### Instructions
> 1. Write code to create the plots using `ggplot2`.
> 2. Convert the plots into interactive graphs using `ggplotly`.
> 3. Check your results against the provided solutions below.

---
#### Check this code after attempting yourself for the best practice !
#### Example code for Basic Bar Chart and Box Plot:
Remember, there are different additions you can make here, so your code might not look exactly the same but still produce a similar (or even better!) plot. These examples just provide a baseline.

```r
# bar Chart
(bar_chart <- ggplot(data = penguin_data, aes(x = species, fill = species)) +
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
htmlwidgets::saveWidget(as_widget(bar_chart_interactive), "your_file_path/penguin_bar_chart.html")
```
```r
# Box Plot
(box_plot <- ggplot(data = penguin_data, aes(x = species, y = flipper_length_mm, fill = species)) +
    geom_boxplot() +
    labs(
      title = "Box Plot of Flipper Length Across Penguin Species",
      x = "Species",
      y = "Flipper Length (mm)"
    ) +
    theme_minimal())

# Convert to interactive plot
(box_plot_interactive <- ggplotly(box_plot))
# save plot
htmlwidgets::saveWidget(as_widget(box_plot_interactive), "your_file_path/penguin_box_plot.html")
```

<details>
  <summary><b>Click to reveal what the graphs could look like</b></summary>

<div style="text-align: center;">
    <iframe src="Figures/penguin_bar_chart.html" width="600" height="400" style="border:none;"></iframe>
</div>

\


<div style="text-align: center;">
    <iframe src="Figures/penguin_box_plot.html" width="600" height="400" style="border:none;"></iframe>
</div>

</details>

##### Plotly graph 

Let's get familiar using the `plot_ly` function to create graphs directly, creating plots directly with this function make it much easier to cutomise the content of the tooltips we just described. So here we will return to the same graph to compare how it can be created using `plot_ly`

`plot_ly` doesnt use `aes()` like `ggplot2`does to map data to visual properties, instead, you directly pass variables from your dataset as arguments to the plotting function using the formula syntax (e.g., ~x, ~y).

Look carefully at the comments on this code before you copy in into your script, as well as customising tooltips it also tidies up the graph, introducing the `layout()` to add custom graph and axes titles.

For the the tooltips specifically, readability is improved by renaming the values incuded to remove any underscores, units (mm) have been added after the values, and the extra information of the `Island` the penguin originated from, and `Sex` has been added. 

Any information that's contained in the data table can be added, so in our case this could include other variables like flipper length or body mass.  

```r
# improved interactive plot
(penguin_plotly_2 <- plot_ly(
  data = penguin_data,
  x = ~bill_length_mm,
  y = ~bill_depth_mm,
  color = ~species,  # different colors for species
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
  layout( # used to add titles to plots and axes
    title = "Interactive Scatter Plot of Penguin Bill Data",
    xaxis = list(title = "Bill Length (mm)"),
    yaxis = list(title = "Bill Depth (mm)")
  ))

# save the improved plot as a HTML file
htmlwidgets::saveWidget(as_widget(penguin_plotly_2), "your_file_path/penguin_plotly_2.html")

```

<div style="text-align: center;">
<iframe src="Figures/penguin_plotly_2.html" width="800" height="600"></iframe>
</div>

That looks clearer now! The use of hover effects and tooltips on your own graphs is entirely determined by what you want to get across so think carefully about the purpose and audience of your plots when making edits to them. 

In our glossary ealier `style()` was introduced, have a play around with this. It is used to edit the appearance of tooltips. Some example code is provided below, this would be added via a pipe `%>%` after our edits made to layout.

To practice this, edit these colours and fonts to get comfortable with the function.

```r
# add this on to previous code from the graph
%>%
  style(  # change the hover text appearance
    hoverlabel = list(
      bgcolor = "white",      # Background color of tooltip
      font = list(size = 12, color = "black"),  # Font size and color
      bordercolor = "black" # Border color of tooltip
    ))) # ensure the correct amount of brackets after adding this. list () and style () need to be closed, and another ) is needed if there is a ( at the 
        # very start of your code

```
<details>
  <summary><b>Click to reveal what these tooltips would look like</b></summary>

<div style="text-align: center;">
<iframe src="Figures/penguin_plotly_3.html" width="800" height="600"></iframe>
</div>

</details>


> the colours of text and background in tooltips can be of particular importance when considering users with colour blindness. You want to ensure the plot is accessible to all viewers so remember to consider clarity.

This introduction to `plot_ly` has focused a on scatter plot but it spans a wide range of graphs, and the tools above can be applied in a similar way to plots such as  line graphs, histograms, box plots, pie charts etc.

> #### As an extension activity you could take the two plots we made in activity 1, and create them directly using `plot_ly`, customising the tooltips on those graphs, as we have just learnt how to. 

<a name="section2"></a>

## 2. Interactive map visualisations

We have focused on graphs in this tutorial so far, however, `plotly's` interactivity is not just limited to plots, it can also be used to create interactive maps.

Such maps are useful when visualising data with a spatial element. For example, we have been working with data on penguins from three different islands in Antartica, and depending on the purpose of your data visualisation, being able to see locations or distributions may be useful.

Lets begin exploring maps by creating a map that pinpoints our three islands. Basic maps like these, that just visualise ditribution, are created by specifying `type = 'scatterboxmap'`within `plot_ly`.

Now, because the palmerpenguins dataset only contains island names, rather than coordinates, we need to do some editing to the date frame to include these. I have found approximate co ordinates using google maps for this tutorial.

I am also adding an column to indicate population size (based on island the penguin came from as this will be integrated into the map as well.

Making additions to data:

```r
# Assign coordinates for each island
penguins_with_coords <- penguins %>%
  mutate(
    latitude = case_when( 
      island == "Torgersen" ~ -64.772645,
      island == "Dream" ~ -64.726345,
      island == "Biscoe" ~ -65.713383,  # Using Renaud Island as the reference for Biscoe
      TRUE ~ NA_real_  # Assign NA for any islands not listed
    ),
    longitude = case_when(
      island == "Torgersen" ~ -64.074500,
      island == "Dream" ~ -64.224375,
      island == "Biscoe" ~ -65.972880,  # Using Renaud Island's longitude
      TRUE ~ NA_real_  # Assign NA for any islands not listed
    ))

# Calculate population size for each island
penguin_population <- penguins_with_coords %>% 
  group_by(island) %>% 
  summarise(population_size = n())

# Merge population into the data set
penguins_with_coords <- penguins_with_coords %>% 
  left_join(penguin_population, by = "island")

```
Now our data is prepared we can start thinking about how to map it. 

__Creating the Map__

It's important to understand what the code we're going to look at is actually doing:

- Data: the `penguins_with_cords` that we have just created provides the location co ordinates for the map and contains other information on the penguins that can be displayed in more complex maps
- Coordinates: `x = ~longitude` and `y= ~latitude` determine where the markers will sit on the map
- Type: `scattermapbox` allows this type of interactive map to be plotted

> Different maps that can be defined include
> 1. `scatterboxmap` - these display data points as markers on a Mapbox map and is commonly used for geospatial scatter plots
> 2. `choroplethmapbox` - displays areas filled with colours based on data values, needs files that define region values to work
> 3. `densitymapbox` - a heatmap style map that displays density represented with colours, it needs coordinate inputs for points, groups into density regions

- Mode: `markers` displays data as individuals points
- Colour: gives each point a different colour based on penguin species
- Tooltips: changes what's displayed when you hover over points (used in the same way it is for graphs!)

__Map Layout__

Edits made to the layout of our map include:

- Adding an informative title
- Specifying the map style using `mapbox =` and within this deciding style, where to centre the map view, and what zoom level to have as the starting point (before users can then zoom in and out)
- We have used the style `carto-positron` in this first map, this offers a light coloured map, with a minimalistic design, but there are different map styles that change what type of map you see your data presented on.

__Code in Action__
```r
# interactive map 
(map_plot <- plot_ly(
  data = penguins_with_coords,  # use the new dataset that has coordinates
  x = ~longitude,              # set longitude for the x-axis
  y = ~latitude,               # set latitude for the y-axis
  type = 'scattermapbox',      # choose map type
  mode = 'markers',            # represent data points as markers
  color = ~species,            # colour points based on penguin species
  hoverinfo = 'text',          # change what appears in tooltips
  text = ~paste("Species:", species,
                "<br>Island:", island,
                "<br>Population Size:", population_size)
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
htmlwidgets::saveWidget(as_widget(map_plot), "your_file_path/penguin_map.html")
```
The map produced should look like this!

<div style="text-align: center;">
    <iframe src="Figures/penguin_map.html" width="800" height="600" style="border:none;"></iframe>
</div>

As you can see, the interactive map now displays data on the penguins (I have chosen to include species, island, and population) while also placing this data in a geographic context. 

Additionally, the markers on the map can also be used to display data, points can be scaled to represent values such as averages or population size. In the map above population size is included in the tooltip info, let's see how to use a bubble map to chnage this and instead display population size as represented by the size of location markers.


```r
# Edits to make scaled Interactive Bubble Map
# directly into plotly function e.g. following 'mode= 'markers',' add
size = ~population_size

```
> don't forget to create this new map under a new variable name, for ease in part three, name it `bubble_map`. And don't forget to save it.


This change creates a map like this:

<div style="text-align: center;">
    <iframe src="Figures/bubble_map.html" width="800" height="600" style="border:none;"></iframe>
</div>

You will notice that the size of the markers remains relative to eachother even as you zoom in and out around the map. This map also shows the difference in styles that can be used as it is `"open-street-map"` as opposed to `"carto-positron"`that was used in the first map. This is better suited to our data as it includes specific island names when you zoom in on the map.

<a name="section3"></a>

## 3. Presenting multiple plots in an interactive application

Being able to present multiple plots together can be useful if their findings relate to one another, and when combining multiple __interactive__ plots this can be achieved through the use of the framework `shiny`.

- shiny can be used to integrate multiple of the plots/maps we have created in this tutorial, lets save our most recent scaled map, and the first interactive plolty plot we made 

To do this we need to determine:

1. __The UI (User Interface)__

The user interface determines what the app looks like and it includes:
- a `titlePanel` displaying an informative title that provides context to what the app does or displays, in our case "Palmer penguins Data Visualisation"
- a `sidebarLayout` that organises the app into two sections
  
  i) the `sidebarPanel` should contain a paragraph describing what the purpose of the app is, and any extra information needed to interpret the plots/maps contained within it
  
  ii) the `mainPanel` is the section where the interactive plot and map will be rendered

2. __The Server Logic__

This handles how the app works, it is responsible for generating the visualisations and getting them to where they should be within UI placeholders.

- `renderPlotly({...})` is used to generate the plots interactively with Plotly

3. __Combining the two__

Running the app (see code below) then combines the UI and server components to create the working app. The app will appear in a viewing window after this has been completed

Below is the code that does this:
```r
# Define the UI for the Shiny app
ui <- fluidPage(
  titlePanel("Palmer Penguins Data Visualisation"),
  sidebarLayout(
    sidebarPanel(
      p("This app displays a scaled interactive bubble map of penguin population and a scatter plot of penguin bill data.")
    ),
    mainPanel(
      plotlyOutput("map"),          # Output the map here
      plotlyOutput("scatter_plot")  # Output the scatter plot here
    )
  )
)

# Define the server logic for the Shiny app
server <- function(input, output, session) {
  
  # Render the map plot (scaled bubble map)
  output$map <- renderPlotly({
    bubble_map
  })
  
  # Render the scatter plot (penguin bill data)
  output$scatter_plot <- renderPlotly({
    penguin_plotly_2
  })
}

# Run the application
shinyApp(ui = ui, server = server)
```

The app that appears in a new window in R should look like this but retain full interactivity (the image below is just a snapshot of the app so you can compare it to yours).

<div align="center">
  <img src="https://github.com/user-attachments/assets/77740abb-c046-4377-ab81-7de4a1e64d23" alt="Description of Image" width="500">
</div>

This was just a brief overview of one way shiny can be used, check out a previous coding club tutorial [here](https://ourcodingclub.github.io/tutorials/shiny/) for more detail on shiny, and on how to export apps running on local links (what you have just created!) into published apps that can be embedded into websites.

Take a minute to recap, in this tutorial we  have learned:

##### - how to convert and make interactive plots
##### - an introduction to interactive map visualisation
##### - how to present multiple plots in an interactive web application

... and all with the help of our penguins !

<p align="center">
  <img src="https://github.com/user-attachments/assets/da3e6138-44e7-49f2-b0f8-c1421e0bbe72" alt="Description of image" width="300">
	Artwork by @allison_horst.
</p>

<hr>
<hr>

#### Related Tutorials
- [Data Visualisation: Part 1](https://ourcodingclub.github.io/tutorials/datavis/)
- [Data Visualisation: Part 2](https://ourcodingclub.github.io/tutorials/data-vis-2/)
- [Shiny](https://ourcodingclub.github.io/tutorials/shiny/)

#### Check out our <a href="https://ourcodingclub.github.io/links/" target="_blank">Useful links</a> page where you can find loads of guides and cheatsheets.

#### If you have any questions about completing this tutorial, please contact us on ourcodingclub@gmail.com


<ul class="social-icons">
	<li>
		<h3>
			<a href="https://twitter.com/our_codingclub" target="_blank">&nbsp;Follow our coding adventures on Twitter! <i class="fa fa-twitter"></i></a>
		</h3>
	</li>
</ul>
