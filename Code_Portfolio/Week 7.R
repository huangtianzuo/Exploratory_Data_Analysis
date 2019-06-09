# Data Visualization - First Steps ----
ggplot(data = <DATA>) + 
  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))
# The first argument of ggplot() is the dataset to use in the graph. The function geom_point() creates a scatterplot.
# Each geom function in ggplot2 takes a mapping argument. This defines how variables in your dataset are mapped to visual properties. The mapping argument is always paired with aes(), and the x and y arguments of aes() specify which variables to map to the x and y axes. 

# Aesthetic mappings ----
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
# Map the colors of your points to the class variable to reveal the class of each car.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))
# Mapping an unordered variable (class) to an ordered aesthetic (size) is not a good idea.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))
# Map class to the alpha aesthetic, which controls the transparency of the points, or to the shape aesthetic, which controls the shape of the points.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")
# Make all of the points in our plot blue

# Facets ----
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
# The variable that you pass to facet_wrap() should be discrete.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)
# Add facet_grid() to facet your plot on the combination of two variables.

# Geometric objects ----
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
# Creates a scatterplot
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))
# Creates a mooth line
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
# To display multiple geoms in the same plot, add multiple geom functions to ggplot()
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
# ggplot2 will treat these mappings as global mappings that apply to each geom in the graph.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()
# If you place mappings in a geom function, ggplot2 will treat them as local mappings for the layer. It will use these mappings to extend or overwrite the global mappings for that layer only.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)
# The smooth line displays just a subset of the mpg dataset, the subcompact cars. The local data argument in geom_smooth() overrides the global data argument in ggplot() for that layer only.

# Statistical transformations ----
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))
# Display a bar chart of proportion
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )
# Summarises the y values for each unique x value

# Position adjustments ----
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))
# You can colour a bar chart using either the colour aesthetic, or, more usefully, fill
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))
# The bars are automatically stacked. Each colored rectangle represents a combination of cut and clarity.
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")
# position = "identity" will place each object exactly where it falls in the context of the graph. This is not very useful for bars, because it overlaps them. 
# To see that overlapping we either need to make the bars slightly transparent by setting alpha to a small value, or completely transparent by setting fill = NA.
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")
# position = "fill" works like stacking, but makes each set of stacked bars the same height. This makes it easier to compare proportions across groups.
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")
# position = "dodge" places overlapping objects directly beside one another. This makes it easier to compare individual values.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")
# You can avoid this gridding by setting the position adjustment to “jitter”. This spreads the points out because no two points are likely to receive the same amount of random noise.

# Coordinate systems ----
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()
# coord_flip() switches the x and y axes. 
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()
# coord_quickmap() sets the aspect ratio correctly for maps.
bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)
bar + coord_flip()
bar + coord_polar()
# coord_polar() uses polar coordinates.

# The layered grammar of graphics ----
ggplot(data = <DATA>) + 
  <GEOM_FUNCTION>(
    mapping = aes(<MAPPINGS>),
    stat = <STAT>, 
    position = <POSITION>
  ) +
  <COORDINATE_FUNCTION> +
  <FACET_FUNCTION>
# The grammar of graphics is based on the insight that you can uniquely describe any plot as a combination of a dataset, a geom, a set of mappings, a stat, a position adjustment, a coordinate system, and a faceting scheme.