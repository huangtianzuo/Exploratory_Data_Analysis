# The Base Plotting System ----
data(airquality)
with(airquality, {
  +         plot(Temp, Ozone)
  +         lines(loess.smooth(Temp, Ozone))
  + })
# add a linear regression line or a smoother to it to highlight the trends.
data(cars)
## Create the plot / draw canvas
with(cars, plot(speed, dist))
## Add annotation
title("Speed vs. Stopping distance")

# The Lattice System ----
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4, 1))
# Looks at the relationship between life expectancy and income and how that relationship varies by region in the United States

# The ggplot2 System ----
data(mpg)
qplot(displ, hwy, data = mpg)
# The qplot function in ggplot2 is what you use to “quickly get some data on the screen”.

# The Process of Making a Plot ----
# Where will the plot be made? On the screen? In a file?
# How will the plot be used?
# Is the plot for viewing temporarily on the screen?
# Will it be presented in a web browser?
# Will it eventually end up in a paper that might be printed?
# Are you using it in a presentation?
# Is there a large amount of data going into the plot? Or is it just a few points?
# Do you need to be able to dynamically resize the graphic?
# What graphics system will you use: base, lattice, or ggplot2? These generally cannot be mixed.

# How Does a Plot Get Created? ----
# Make plot appear on screen device
with(faithful, plot(eruptions, waiting)) 
# Annotate with a title
title(main = "Old Faithful Geyser data") 
# Open PDF device; create 'myplot.pdf' in my working directory
pdf(file = "myplot.pdf")  
# Create plot and send to a file (no plot appears on screen)
with(faithful, plot(eruptions, waiting))  
# Annotate plot; still nothing on screen
title(main = "Old Faithful Geyser data")  
# Close the PDF file device
dev.off()  
# Now you can view the file 'myplot.pdf' on your computer

# Multiple Open Graphics Devices ----
dev.cur()
# Find the currently active graphics device
dev.set(<integer>)
# Change the active graphics device

# Copying Plots ----
library(datasets)
# Create plot on screen device
with(faithful, plot(eruptions, waiting))  
# Add a main title
title(main = "Old Faithful Geyser data")  
# Copy my plot to a PNG file
dev.copy(png, file = "geyserplot.png")  
# Don't forget to close the PNG device!
dev.off() 

# Summary ----
# Vector formats are good for line drawings and plots with solid colors using a modest number of points
# Bitmap formats are good for plots with a large number of points, natural scenes or web-based plots

# Variance
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))
# The height of the bars displays how many observations occurred with each x value.
diamonds %>% 
  count(cut)
# Compute these values manually with dplyr::count()
ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = carat), binwidth = 0.5)
# Examine the distribution of a continuous variable
diamonds %>% 
  count(cut_width(carat, 0.5))
# Compute this by hand
smaller <- diamonds %>% 
  filter(carat < 3)
ggplot(data = smaller, mapping = aes(x = carat)) +
  geom_histogram(binwidth = 0.1)
# Zoom into just the diamonds with a size of less than three carats and choose a smaller binwidth
ggplot(data = smaller, mapping = aes(x = carat, colour = cut)) +
  geom_freqpoly(binwidth = 0.1)
# Use geom_freqpoly() to overlay multiple histograms in the same plot
ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = y), binwidth = 0.5) +
  coord_cartesian(ylim = c(0, 50))
# Zoom to small values of the y-axis with coord_cartesian() to see the unusual values
unusual <- diamonds %>% 
  filter(y < 3 | y > 20) %>% 
  select(price, x, y, z) %>%
  arrange(y)
# Check unusual values

# Missing Values
diamonds2 <- diamonds %>% 
  filter(between(y, 3, 20))
# Drop the entire row with the strange values
diamonds2 <- diamonds %>% 
  mutate(y = ifelse(y < 3 | y > 20, NA, y))
# Replace unusual values with NA

# Covariation ----
ggplot(data = diamonds, mapping = aes(x = price, y = ..density..)) + 
  geom_freqpoly(mapping = aes(colour = cut), binwidth = 500)
# The area under each frequency polygon is one.
ggplot(data = diamonds, mapping = aes(x = cut, y = price)) +
  geom_boxplot()
# The distribution of price in boxplot
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy))
# Reorder class based on the median value of hwy
diamonds %>% 
  count(color, cut) %>%  
  ggplot(mapping = aes(x = color, y = cut)) +
  geom_tile(mapping = aes(fill = n))
# Visualise with geom_tile() and the fill aesthetic
ggplot(data = diamonds) + 
  geom_point(mapping = aes(x = carat, y = price), alpha = 1 / 100)
# Use the alpha aesthetic to add transparency
ggplot(data = smaller) +
  geom_bin2d(mapping = aes(x = carat, y = price))
# geom_bin2d() creates rectangular bins
ggplot(data = smaller) +
  geom_hex(mapping = aes(x = carat, y = price))
# geom_hex() creates hexagonal bins.
ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)))
# Bin one continuous variable so it acts like a categorical variable
ggplot(data = smaller, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_number(carat, 20)))
# Display approximately the same number of points in each bin

#  Patterns and models ----
ggplot(data = faithful) + 
  geom_point(mapping = aes(x = eruptions, y = waiting))
# Longer wait times are associated with longer eruptions
library(modelr)
mod <- lm(log(price) ~ log(carat), data = diamonds)
diamonds2 <- diamonds %>% 
  add_residuals(mod) %>% 
  mutate(resid = exp(resid))
ggplot(data = diamonds2) + 
  geom_point(mapping = aes(x = carat, y = resid))
ggplot(data = diamonds2) + 
  geom_boxplot(mapping = aes(x = cut, y = resid))
# Remove the very strong relationship between price and carat so we can explore the subtleties that remain. 

# ggplot2 calls ----
diamonds %>% 
  count(cut, clarity) %>% 
  ggplot(aes(clarity, cut, fill = n)) + 
  geom_tile()
# ggplot2 was created before the pipe was discovered