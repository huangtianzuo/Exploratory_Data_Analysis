# The working directory ----
getwd()
# see your current working directory
setwd(dir = "/Users/nphillips/Dropbox/yarrr")
# change my working directory to an existing Dropbox folder called yarrr

# The workspace ----
ls()
# see all the objects defined in your current workspace

#  .RData files ----
study1.df <- data.frame(id = 1:5, 
                        sex = c("m", "m", "f", "f", "m"), 
                        score = c(51, 20, 67, 52, 42))

score.by.sex <- aggregate(score ~ sex, 
                          FUN = mean, 
                          data = study1.df)

study1.htest <- t.test(score ~ sex, 
                       data = study1.df)
save(study1.df, score.by.sex, study1.htest,
     file = "data/study1.RData")
# Save two objects as a new .RData file in the data folder of my current working directory

write.table(x = pirates,
            file = "pirates.txt",  # Save the file as pirates.txt
            sep = "\t")            # Make the columns tab-delimited
# Write the pirates dataframe object to a tab-delimited text file called pirates.txt in my working directory

write.table(x = pirates,
            file = "Users/nphillips/Desktop/pirates.txt",  # Save the file as pirates.txt to my desktop
            sep = "\t")
# Write the pirates dataframe object to a tab-delimited text file called pirates.txt to my desktop

mydata <- read.table(file = 'data/mydata.txt', sep = '\t', header = TRUE, stringsAsFactors = FALSE)
# Read a tab-delimited text file called mydata.txt from the data folder in my working directory into R and store as a new object called mydata

fromweb <- read.table(file = 'http://goo.gl/jTNf6P', sep = '\t', header = TRUE)
# Read a text file from the web

# Excel, SPSS, and other data files ----
# first exporting/saving the original SPSS or Excel files as text .txt. files – both SPSS and Excel have options to do this. Then, once you have exported the data to a .txt file, you can read it into R using
read.table().

