#1

comunityURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(comunityURL, destfile = "comunity.csv", method = "curl")

library(dplyr)
comunity <- read.csv("comunity.csv") %>%
  mutate(agricultureLogical = (ACR == 3 & AGS == 6))
top3vect <- which(comunity$agricultureLogical) %>%
  head(3)
top3vect

#2

imageURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(imageURL, destfile = "image.jpeg", mode = "wb")

library(jpeg)
image <- readJPEG("image.jpeg", native = TRUE)
quantileAnswer <- quantile(image,probs = c(.3, .8))
quantileAnswer

#3

df1URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
df2URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(df1URL, destfile = "df1.csv", method = "curl")
download.file(df2URL, destfile = "df2.csv", method = "curl")

df1 <- read.csv("df1.csv", skip = 4, nrows = 190)
df1 <-  df1[, c(1, 2, 4, 5)]
colnames(df1) <- c("CountryCode", "Rankig", "Economy", "GPD")
df2 <- read.csv("df2.csv")
nrow(merge(df1, df2, by = 'CountryCode', all = FALSE))
