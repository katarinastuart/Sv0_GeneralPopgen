##Compiling the global starling sightings

##Complete on cluster

#Command line
module load R/3.5.1
R

#R
setwd("/srv/scratch/z5188231/LitReview")

#data obtained from ebird
starlings <- read.csv("ebd_eursta_prv_relNov-2018.txt", sep="\t", quote = "")


#think only the top one works??
Starlings <- read.csv("ebd_eursta_prv_relNov-2018.txt", sep="\t", quote = "")
starlings <- read.csv("ebd_eursta_prv_relNov-2018.txt",stringsAsFactors=TRUE,sep="\t")
str(Starlings)

starlingsbrief <- Starlings[c(9,26:27)] # Count and location data
str(starlingsbrief) #3673670 obs. of  47 variables imported

write.csv(starlingsbrief,file="starlingsbrief.csv") #can use this in regular GUI R


# Here's the mapping script. Pretty simple. The SHP and CSV files are just coordinates of toad sightings. 
# To this day WA still hasn't sent me their coordinates :( lol. 
# Again, lemme know if you have any questions! 

# http://www.molecularecologist.com/2012/09/making-maps-with-r/

library(maps)
library(mapdata)
library(sp)
library(maptools)
library(Rcpp)
library(colorspace)
library(plyr)
library(scales)
library(ggplot2)
library(ggrepel)
library(dplyr)

setwd("C:/Users/z5188231/Desktop/Coding/Files/Thesis/Chap1LitReview")
#setwd("/srv/scratch/z5188231/LitReview")

# import
starlings <- read.csv("ebd_eursta_prv_relNov-2018.txt",stringsAsFactors=TRUE,sep="\t")
str(starlings)

starlingsfull <- starlings[c(6,8:9,12:13,26:28)] # All important information
str(starlingsfull)
write.csv(starlingsfull,file="starlingsfull.csv")
starlingsfull <- read.csv("starlingsfull.csv",stringsAsFactors=TRUE,sep=",")
str(starlingsfull)

starlingsbrief <- starlings[c(9,26:27)] # Count and location data
str(starlingsbrief)

write.csv(starlingsbrief,file="starlingsbrief.csv")

Starlings <- read.csv("starlingsbrief.csv",stringsAsFactors=TRUE,sep=",")
str(Starlings)

###EFFORT 1

#testdata in US
map("worldHires", col="gray90", fill=TRUE)
points <- read.csv("starlingsbrieftest.csv")
points(points$LONGITUDE, points$LATITUDE, pch=15, col="black", cex=1.0)

#Global starling data
map("worldHires", col="gray90", fill=TRUE)
points <- read.csv("starlingsbrief.csv")
points(points$LONGITUDE, points$LATITUDE, pch=15, col="black", cex=1.0)

###EFFORT 2

#map
w2hr <- map_data("worldHires")
dim(w2hr)

#Special points 
labs <- data.frame(
  long = c(-73.9654, 144.9631, 151.2093, 138.6007, 153.0251, 147.3272, 18.4241, -58.3816, -60.6973, 173.2840, 170.1548, 172.6362, 174.7633, 174.7762),
  lat = c(40.7829, -37.8136, -33.8688, -34.9285, -27.4698, -42.8821, -33.9249, -34.6037, -31.6107, -41.2706, -45.4791, -43.5321, -36.8485, -41.2865),
  names = c("US", "Melbourne","New South Wales","South Australia","Queensland","Tasmania","Cape Town","Buenos Ares","Santa Fe","Nelson","Otago","Christchurch","Auckland","Wellington"),
  dates = c("1980", "1857","1880","1860","1869","1860","1897","1987","2001","1862","1967","1867","1865","1877"),
  stringsAsFactors = FALSE
)


#the birds
starlings <- read.csv("starlingsbrief.csv")
#starlings <- read.csv("starlings.csv",stringsAsFactors=TRUE,sep=",")


#black outlined, grey filled
gg1 <- ggplot() + 
  geom_polygon(data = w2hr, aes(x=long, y = lat, group = group), fill = "gray40", color = "gray40") + 
  coord_fixed(1.3)
  
#Trying to add starlings
gg2 <- gg1 +
  geom_point(data = Starlings, aes(x = LONGITUDE, y = LATITUDE), color = "cadetblue3", size = 1, alpha = 1) +
  geom_point(data = labs, aes(x = long, y = lat), color = "honeydew4", size = 2) +
  geom_point(data = labs, aes(x = long, y = lat), color = "honeydew2", size = 1) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
          panel.background = element_blank(), axis.line = element_blank())

#adding labels
gg2 +
  geom_text(data = labs, aes(x = long, y = lat, label=dates),hjust=0.5, vjust=0.5, size = 4) 

  
  
  
##### sorting out native and invasive ranges
Invasive <- read.csv("Invasive.txt", sep="\t", quote = "", header=FALSE)
Invasive <- as.vector(Invasive[,1])
Native <- read.csv("Native.txt", sep="\t", quote = "", header=FALSE)
Native <- as.vector(Native[,1])
ExpandingRange <- read.csv("ExpandingRange.txt", sep="\t", quote = "", header=FALSE)
ExpandingRange <- as.vector(ExpandingRange[,1])

starlingsfull <- read.csv("starlingsfull.csv",stringsAsFactors=TRUE,sep=",")
levels(starlingsfull$COUNTRY)
str(starlingsfull)

ExpandingRangePoints <- starlingsfull[starlingsfull$COUNTRY %in% ExpandingRange,]
InvasivePoints <- starlingsfull[starlingsfull$COUNTRY %in% Invasive,]
NativePoints <- starlingsfull[starlingsfull$COUNTRY %in% Native,]


###EFFORT 3

#map
w2hr <- map_data("worldHires")
dim(w2hr)

#Special points 
labs <- data.frame(
  long = c(-73.9654, 144.9631, 151.2093, 138.6007, 153.0251, 147.3272, 18.4241, -58.3816, -60.6973, 173.2840, 170.1548, 172.6362, 174.7633, 174.7762),
  lat = c(40.7829, -37.8136, -33.8688, -34.9285, -27.4698, -42.8821, -33.9249, -34.6037, -31.6107, -41.2706, -45.4791, -43.5321, -36.8485, -41.2865),
  names = c("US", "Melbourne","New South Wales","South Australia","Queensland","Tasmania","Cape Town","Buenos Ares","Santa Fe","Nelson","Otago","Christchurch","Auckland","Wellington"),
  countries = c("United Statets of America", "Australia","Australia","Australia","Australia","Australia","South Africa","South America","South America","New Zealand","New Zealand","New Zealand","New Zealand","New Zealand"),
  dates = c("1980", "1857","1880","1860","1869","1860","1897","1987","2001","1862","1967","1867","1865","1877"),
  stringsAsFactors = FALSE
)

labsoffset <- data.frame(
  long = c(-65.9654, 151.9631, 158.2093, 129.6007, 163.0251, 137.3272, 18.4241, -50.3816, -51.6973, 165.2840, 180.1548, 182.6362, 182.7633, 180.7762),
  lat = c(40.7829, -37.8136, -33.8688, -34.9285, -27.4698, -42.8821, -37.9249, -36.6037, -31.6107, -41.2706, -48.4791, -44.5321, -35.8485, -41.2865),
  names = c("US", "Melbourne","New South Wales","South Australia","Queensland","Tasmania","Cape Town","Buenos Ares","Santa Fe","Nelson","Otago","Christchurch","Auckland","Wellington"),
  dates = c("1980", "1857","1880","1860","1869","1860","1897","1987","2001","1862","1967","1867","1865","1877"),
  stringsAsFactors = FALSE
) 

#black outlined, grey filled
gg1 <- ggplot() + 
  geom_polygon(data = w2hr, aes(x=long, y = lat, group = group), fill = "gray40", color = "gray40") + 
  coord_fixed(1.3)
  
#Trying to add starlings
gg2 <- gg1 +
  geom_point(data = ExpandingRangePoints, aes(x = LONGITUDE, y = LATITUDE), color = "cadetblue2", size = 0.25, alpha = 1) +
  geom_point(data = InvasivePoints, aes(x = LONGITUDE, y = LATITUDE), color = "lightpink2", size = 0.25, alpha = 1) +
  geom_point(data = NativePoints, aes(x = LONGITUDE, y = LATITUDE), color = "cadetblue2", size = 0.25, alpha = 1) +
  geom_point(data = labs, aes(x = long, y = lat), color = "midnightblue", size = 2) +
  geom_point(data = labs, aes(x = long, y = lat), color = "honeydew3", size = 1) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
          panel.background = element_blank(), axis.line = element_blank())

#adding labels
gg3 <- gg2 +
  geom_text(data = labsoffset, aes(x = long, y = lat, label=dates),hjust=0.5, vjust=0.5, size = 4) 
 
gg3

# Open a pdf file
pdf("StarlingGlobal2.pdf") 
# 2. Create a plot
gg3
# Close the pdf file
dev.off() 

jpeg('StarlingGlobal.jpeg')
gg3
dev.off()

png('StarlingGlobal.png', width = 1050, height = 650)
gg3
dev.off()


