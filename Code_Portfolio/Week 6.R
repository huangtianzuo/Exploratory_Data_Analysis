# Filter rows with filter() ----
filter(flights, month == 1, day == 1)
# The first argument is the name of the data frame. The second and subsequent arguments are the expressions that filter the data frame. 
filter(flights, month == 11 | month == 12)
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)
# & is “and”, | is “or”, and ! is “not”
nov_dec <- filter(flights, month %in% c(11, 12))
# This will select every row where x is one of the values in y. 
is.na(x)
# Determine if a value is missing, use is.na()

#  Arrange rows with arrange() ----
arrange(flights, desc(dep_delay))
# Use desc() to re-order by a column in descending order
# Missing values are always sorted at the end

# Select columns with select() ----
select(flights, year, month, day)
select(flights, year:day)
select(flights, -(year:day))
# Select() allows you to rapidly zoom in on a useful subset using operations based on the names of the variables.
starts_with("abc")
# Matches names that begin with “abc”.
ends_with("xyz")
# Matches names that end with “xyz”.
contains("ijk")
# Matches names that contain “ijk”.
matches("(.)\\1")
# Selects variables that match a regular expression.
num_range("x", 1:3)
# Matches x1, x2 and x3.
select(flights, time_hour, air_time, everything()) 
# This is useful if you have a handful of variables you’d like to move to the start of the data frame.

# Add new variables with mutate() ----
mutate(flights_sml, gain = dep_delay - arr_delay, speed = distance / air_time * 60)
# mutate() always adds new columns at the end of dataset
transmute(flights, gain = dep_delay - arr_delay, hours = air_time / 60, gain_per_hour = gain / hours)
# Use transmute() to keep the new variables.
transmute(flights, dep_time, hour = dep_time %/% 100, minute = dep_time %% 100)
# Modular arithmetic: %/% (integer division) and %% (remainder)
log()
log2()
log10()
# Logarithms are an incredibly useful transformation for dealing with data that ranges across multiple orders of magnitude. 
lead()
lag()
# Refer to leading or lagging values
cumsum()
cumprod()
cummin()
cummax()
# cumulative means, products, mins, maxes

#  Grouped summaries with summarise() ----
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))
# It collapses a data frame to a single row
by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))
# If we applied exactly the same code to a data frame grouped by date, we get the average delay per date
count(n())
sum(!is.na(x))
# Check that you’re not drawing conclusions based on very small amounts of data.
sd(x)
IQR(x)
mad(x)
# The interquartile range IQR(x) and median absolute deviation mad(x) are robust equivalents that may be more useful if you have outliers.
min(x)
quantile(x, 0.25)
max(x)
# Quantiles are a generalisation of the median.
first(x)
nth(x, 2)
last(x)
# These work similarly to x[1], x[2], and x[length(x)] but let you set a default value if that position does not exist.
n_distinct(x)
# Count the number of distinct (unique) values
daily %>% 
  ungroup() %>%
  summarise(flights = n())
# If you need to remove grouping, and return to operations on ungrouped data, use ungroup().