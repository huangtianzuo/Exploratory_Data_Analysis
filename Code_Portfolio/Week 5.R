# Creating matrices and dataframes ----
cbind(1:5, 6:10, 11:15)
# Combine vectors as columns in a matrix
rbind(1:5, 6:10, 11:15)
# Combine vectors as rows in a matrix
matrix(x = 1:12, nrow = 3, ncol = 4)
# Create a matrix from a vector x
data.frame("age" = c(19, 21), sex = c("m", "f"))
# Create a dataframe from named columns
stringsAsFactors = FALSE
# tell R to NOT convert your string columns to factors

# Matrix and dataframe functions ----
head(x), tail(x)
# Print the first few rows (or last few rows)
View(x)
# Open the entire object in a new window
nrow(x), ncol(x), dim(x)
# Count the number of rows and columns
rownames(), colnames(), names()
# 	Show the row (or column) names
str(x), summary(x)
# Show the structure of the dataframe (ie., dimensions and classes) and summary statistics

# Dataframe column names ----
names(ToothGrowth)
# Access the names of a dataframe
ToothGrowth$len
# Access a specific column in a dataframe by name
table(ToothGrowth$supp)
# Get the frequency of each supplement
head(ToothGrowth[c("len", "supp")])
# Put a character vector of column names in brackets to access several columns by name
survey$sex <- c("m", "m", "f", "f", "m")
# Add a new column called sex with a vector of sex data
names(df)[1] <- "a"
# Change the name of a column in a dataframe
names(df)[names(df) == "old.name"] <- "new.name"
# Change column names using a logical vector

# Slicing dataframes ----
df[1, ]
# Return row 1
df[, 5]
# Return column 5
df[1:5, 2]
# Rows 1:5 and column 2
ToothGrowth.VC <- ToothGrowth[ToothGrowth$supp == "VC", ]
# Create a new df with only the rows of ToothGrowth where supp equals VC
ToothGrowth.OJ.a <- ToothGrowth[ToothGrowth$supp == "OJ" & ToothGrowth$dose < 1, ]
# Create a new df with only the rows of ToothGrowth where supp equals OJ and dose < 1
subset(x = ToothGrowth, subset = len > 30 & supp == "VC", select = c(len, dose))
# x: A dataframe you want to subset
# subset: A logical vector indicating the rows to keep
# select: The columns you want to keep

# Combining slicing with functions ----
health$weight + health$height / health$age + 2 * health$height
# Long code
with(health, weight + height / age + 2 * height)
# Short code that does the same thing
