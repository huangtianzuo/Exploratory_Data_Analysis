# Read in your data ----
library(readr)
library(readxl)
ozone <- read_csv("data/hourly_44201_2014.csv", col_types = "ccccinnccccccncnncccccc")
# Each letter represents the class of a column: “c” for character, “n” for numeric“, and”i" for integer. If there are too many columns, you can not specify col_types and read_csv() will try to figure it out for you.
names(ozone) <- make.names(names(ozone))
# rewrite the names of the columns to remove any spaces.

# Check the packaging ----
nrow(ozone)
ncol(ozone)
# check the number of rows and columns.

# Run str() ----
str(ozone)
# examine the classes of each of the columns to make sure they are correctly specified (i.e. numbers are numeric and strings are character, etc.).

# Look at the top and the bottom of your data ----
head(ozone[, c(6:7, 10)])
tail(ozone[, c(6:7, 10)])
# Make sure to check all the columns and verify that all of the data in each column looks the way it’s supposed to look.
# Check your “n”s ---
table(ozone$Time.Local)
library(dplyr)
filter(ozone, Time.Local == "13:14") %>% 
  select(State.Name, County.Name, Date.Local, Time.Local, Sample.Measurement)
filter(ozone, State.Code == "36" & County.Code == "033" & Date.Local == "2014-09-30") %>%
  select(Date.Local, Time.Local, Sample.Measurement) %>% 
  as.data.frame
select(ozone, State.Name) %>% unique %>% nrow
# how many states are represented in this dataset
unique(ozone$State.Name)
# look at the unique elements of the State.Name variable 

# Validate with at least one external data source ----
summary(ozone$Sample.Measurement)
quantile(ozone$Sample.Measurement, seq(0, 1, 0.1))
# looking at deciles of the data.

# Try the easy solution first ----
ranking <- group_by(ozone, State.Name, County.Name) %>%       summarize(ozone = mean(Sample.Measurement)) %>%
  as.data.frame %>%
  arrange(desc(ozone))
head(ranking, 10)
# look at the top 10 counties in this ranking.
tail(ranking, 10)
# look at the 10 lowest counties too.
filter(ozone, State.Name == "California" & County.Name == "Mariposa") %>% nrow
# how many observations there are for this county in the dataset.
ozone <- mutate(ozone, Date.Local = as.Date(Date.Local))
# convert the date variable into a Date class.
filter(ozone, State.Name == "California" & County.Name == "Mariposa") %>%
  mutate(month = factor(months(Date.Local), levels = month.name)) %>%
  group_by(month) %>%
  summarize(ozone = mean(Sample.Measurement))
# split the data by month to look at the average hourly levels
filter(ozone, State.Name == "Oklahoma" & County.Name == "Caddo") %>% nrow
filter(ozone, State.Name == "Oklahoma" & County.Name == "Caddo") %>%
  mutate(month = factor(months(Date.Local), levels = month.name)) %>%
  group_by(month) %>%
  summarize(ozone = mean(Sample.Measurement))

# Challenge your solution ----
set.seed(10234)
N <- nrow(ozone)
idx <- sample(N, N, replace = TRUE)
ozone2 <- ozone[idx, ]
# set our random number generator and resample the indices of the rows of the data frame with replacement
ranking2 <- group_by(ozone2, State.Name, County.Name) %>%
  summarize(ozone = mean(Sample.Measurement)) %>%
  as.data.frame %>%
  arrange(desc(ozone))
# reconstruct our rankings of the counties based on this resampled data
cbind(head(ranking, 10), head(ranking2, 10))
# compare the top 10 counties from our original ranking and the top 10 counties from our ranking based on the resampled data
cbind(tail(ranking, 10), tail(ranking2, 10))

# Basic Data Types ----
# Decimal values are called numerics in R. It is the default computational data type. Furthermore, even if we assign an integer to a variable k, it is still being saved as a numeric value.
# The fact that k is not an integer can be confirmed with the is.integer function.
k = 1 
is.integer(k)
# In order to create an integer variable in R, we invoke the integer function. We can be assured that y is indeed an integer by applying the is.integer function.
y = as.integer(3)
is.integer(y)
# Incidentally, we can coerce a numeric value into an integer with the as.integer function.
as.integer(3.14)
# And we can parse a string for decimal values in much the same way.
as.integer("5.27")
# Often, it is useful to perform arithmetic on logical values. Just like the C language, TRUE has the value 1, while FALSE has value 0.
as.integer(TRUE)
as.integer(FALSE) 
# A complex value in R is defined via the pure imaginary value i.
z = 1 + 2i 
class(z)  
# A logical value is often created via comparison between variables. Standard logical operations are "&" (and), "|" (or), and "!" (negation).
# A character object is used to represent string values in R. We convert objects into character values with the as.character() function
x = as.character(3.14) 
class(x)
fname = "Joe"; lname ="Smith" 
paste(fname, lname)
sprintf("%s has %d dollars", "Sam", 100) 
substr("Mary has a little lamb.", start=3, stop=12) 
sub("little", "big", "Mary has a little lamb.") 