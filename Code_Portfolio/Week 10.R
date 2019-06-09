# Using the kmeans() function ----
dataFrame <- data.frame(x, y)
kmeansObj <- kmeans(dataFrame, centers = 3)
# x is a matrix or data frame of data; centers is either an integer indicating the number of clusters or a matrix indicating the locations of the initial cluster centroids.
kmeansObj$cluster
# See which cluster each data point got assigned to

# Building heatmaps from K-means solutions ----
image(t(dataMatrix)[, nrow(dataMatrix):1], yaxt = "n", main = "Original Data")
image(t(dataMatrix)[, order(kmeansObj$cluster)], yaxt = "n", main = "Clustered Data")
# All of the rows in the same cluster are grouped together; t means transpose

