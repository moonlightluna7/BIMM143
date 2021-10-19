#' ---
#' title: "Class 05: ggplot RMD"
#' author: "Jasmine Lee (A15583527)"
#' date: "October 12th, 2021"
#' ---

# Class 05 Data Visualization

# Let's start with a scatterplot
cars

# install.packages("ggplot2")
#Before we can use it, we need need to load it up!
library(ggplot2)

# Every ggplot has a data + aes + geoms
ggplot(data=cars) + aes(x=speed, y=dist) + geom_point()
ggplot(data=cars) + aes(x=speed, y=dist) + geom_point() + geom_line()
ggplot(data=cars) + aes(x=speed, y=dist) + geom_point() + geom_smooth()

# Change to linear model
p <- ggplot(data=cars) + aes(x=speed, y=dist) + 
  geom_point() + geom_smooth(method="lm")

p + labs(title="Speed and Stopping Distances of Cars", 
         x="Speed (MPH)", y="Stopping Distance (ft)")

#Base graphics is shorter
plot(cars)

# Add "black and white" theme
p + labs(title="Speed and Stopping Distances of Cars", 
         x="Speed (MPH)", y="Stopping Distance (ft)") + theme_bw()

# Differential expression data analysis
url <- "https://bioboot.github.io/bimm143_S20/class-material/up_down_expression.txt"
genes <- read.delim(url)
head(genes)

# Determine number of genes in dataset
nrow(genes)

# Determine column names and number of columns
colnames(genes)
ncol(genes)

# Determine number of upregulated genes
table(genes[,"State"])

# Calculate fraction of total genes that are upregulated to 2 sig figs
round(table(genes$State)/nrow(genes)*100, 2)

#Scatterplot of gene expression data
ggplot(data=genes) + aes(x=Condition1, y=Condition2) + geom_point()

# Map State to point color
p <- ggplot(data=genes) + aes(x=Condition1, 
                              y=Condition2, col=State) + geom_point()
p

# Specify color scale
p + scale_colour_manual(values=c("blue","gray","red"))

p + scale_colour_manual(values=c("blue","gray","red")) + 
  labs(title="Gene Expression Changes Upon Drug Treatment", 
       x="Control (no drug)", y="Drug Treatment")

# install.packages("gapminder")
# library(gapminder)

#Animation
# install.packages("gganimate")
# install.packages("gifski")
library(gganimate)
library(gapminder)

ggplot(gapminder) + aes(gdpPercap, lifeExp, size=pop, colour=country) + 
  geom_point(alpha=0.7, show.legend=FALSE) + 
  scale_colour_manual(values=country_colors) + 
  scale_size(range=c(2,12)) + scale_x_log10() + facet_wrap(~continent) + 
  labs(title="Year:{frame_time}", x="GDP per capita", y="life expectancy") + 
  transition_time(year) + shadow_wake(wake_length=0.1, alpha=FALSE)