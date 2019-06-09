# Hierarchical clustering ----
x <- rnorm(12, rep(1:3, each = 4), 0.2)
y <- rnorm(12, rep(c(1, 2, 1), each = 4), 0.2)
plot(x, y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))
# Simulate some data in three separate clusters
hClustering <- data.frame(x=x,y=y) %>% dist %>% hclust
plot(hClustering)
# Run the clustering algorithm

# Prettier dendrograms ----
myplclust(hClustering, lab = rep(1:3, each = 4), lab.col = rep(1:3, each = 4))
# Color codes each of the cluster members by their cluster membership

# Using the heatmap() function ----
dataMatrix <- data.frame(x=x,y=y) %>% data.matrix
heatmap(dataMatrix)
# Get a dendrogram associated with both the rows and columns of a matrix
