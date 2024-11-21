<p align="left">
  <img src="https://github.com/EdDataScienceEES/tutorial-ellencrombie/blob/b4d472d0d16d8b3c4a36a63fc64683fd34168f8d/coding_club_logo.png?raw=true" alt="Coding Club Logo" width="200">
</p>

___
# Data Visualisation Continued: Interactive Visualisations 
#### Created by Ellen Crombie - last updated November 2024
### Tutorial Sections
- Click on these sections to be taken directly to them!
  
#### <a href="#section1"> 1. Introduction to interactive plots using `plotly` </a>

#### <a href="#section2"> 2. Interactive map visualisations using `leaflet` </a>

#### <a href="#section3"> 3. Interactive data dashboards: combining `plotly` and `leaflet`</a>

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
library(palmerpenguins) 
library(ggplot2)
library(plotly)
# Loading data ----
penguin_data <- penguins # assign the data as an object - allows easier exploration as 
 # you can open the data table from your environment
```

#### Basic Plotting
Let's start simply, plotly has two options when creating interactive graphs. The first being to create it directly, using `plot_ly()`. And the second being to convert a static plot using `ggplot()`, like those you have learned how to make in [previous tutorials](https://ourcodingclub.github.io/tutorials/data-vis-2/).

As you will be familiar with `ggplot` plots, lets start there!
##### Interactive Scatter Plot
```r
# Create a ggplot2 scatterplot
(penguin_plot <- ggplot(data = penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
  geom_point())
```
Now, lets convert this basic plot into an interactive one !
```r
# Convert ggplot2 to plotly
ggplotly(penguin_plot)
```
<iframe src="code_output/penguin_plotly.html" width="800" height="600"></iframe>

<a name="section2"></a>

## 2. Interactive map visualisations using `leaflet`

You can add more text and code, e.g.

```r
# Create fake data
x_dat <- rnorm(n = 100, mean = 5, sd = 2)  # x data
y_dat <- rnorm(n = 100, mean = 10, sd = 0.2)  # y data
xy <- data.frame(x_dat, y_dat)  # combine into data frame
```

Here you can add some more text if you wish.

```r
xy_fil <- xy %>%  # Create object with the contents of `xy`
	filter(x_dat < 7.5)  # Keep rows where `x_dat` is less than 7.5
```

And finally, plot the data:

```r
ggplot(data = xy_fil, aes(x = x_dat, y = y_dat)) +  # Select the data to use
	geom_point() +  # Draw scatter points
	geom_smooth(method = "loess")  # Draw a loess curve
```

At this point it would be a good idea to include an image of what the plot is meant to look like so students can check they've done it right. Replace `IMAGE_NAME.png` with your own image file:

<center> <img src="{{ site.baseurl }}/IMAGE_NAME.png" alt="Img" style="width: 800px;"/> </center>

<a name="section3"></a>

## 3. Interactive data dashboards: combining `plotly` and `leaflet`

More text, code and images.

This is the end of the tutorial. Summarise what the student has learned, possibly even with a list of learning outcomes. In this tutorial we learned:

##### - how to generate fake bivariate data
##### - how to create a scatterplot in ggplot2
##### - some of the different plot methods in ggplot2

We can also provide some useful links, include a contact form and a way to send feedback.

For more on `ggplot2`, read the official <a href="https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf" target="_blank">ggplot2 cheatsheet</a>.

Everything below this is footer material - text and links that appears at the end of all of your tutorials.

<hr>
<hr>

#### Related Tutorials
- [Data Visualisation: Part 1](https://ourcodingclub.github.io/tutorials/datavis/)
- [Data Visualisation: Part 2](https://ourcodingclub.github.io/tutorials/data-vis-2/)

#### Check out our <a href="https://ourcodingclub.github.io/links/" target="_blank">Useful links</a> page where you can find loads of guides and cheatsheets.

#### If you have any questions about completing this tutorial, please contact us on ourcodingclub@gmail.com

#### <a href="INSERT_SURVEY_LINK" target="_blank">We would love to hear your feedback on the tutorial, whether you did it in the classroom or online!</a>

<ul class="social-icons">
	<li>
		<h3>
			<a href="https://twitter.com/our_codingclub" target="_blank">&nbsp;Follow our coding adventures on Twitter! <i class="fa fa-twitter"></i></a>
		</h3>
	</li>
</ul>
