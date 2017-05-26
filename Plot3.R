#question 3:
#Of the four types of sources indicated by the ???????????????? (point, nonpoint, onroad, nonroad) va
#riable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
#Which have seen increases in emissions from 1999-2008? 
#Use the ggplot2 plotting system to make a plot answer this question.

#let us set the working directory
setwd ("/DataScienceCourse_Coursera/exploratory-data-analysis_Course 5/SampleCode")
getwd ()

#*****Read the data using readRDS****
NEI <- readRDS("datafiles/summarySCC_PM25.rds")

#let us make sure that it was read properly
head(NEI)
#variable names flips scc pollutant emissions type year

# lets us install the dplyr package and call the library dplyr if it does not exist
#The dplyr package makes these steps fast and easy

install.packages ("dplyr")
library(dplyr)

#create a data frame 
NEIDF <- tbl_df(NEI)
# note Baltimore City, Maryland (fips="24510") so let us add this condition using filter in the summarize 

# tabulate Baltimore emissions per year and type using summarize
# so we will add type in the group by 

BaltEmbyTypeYear = summarize(group_by(filter(NEIDF, fips=="24510"), type, year),sum(Emissions))

#let us rename the columns using the colnames and using a vector to assign the new names

colnames(BaltEmbyTypeYear) <- c("Type","Year", "Emissions")

# let us convert the year to character using as.character
BaltEmbyTypeYear$Year <- as.character(BaltEmbyTypeYear$Year)

# we need to install the ggplot2 and load its library the question 
# specifies that we need to use ggplot2 to produce our plot
install.packages ("ggplot2")
library (ggplot2)

#let us plot the graph using ggplot2 geom = is bar plot
# main is the title of the plot
#xlab label for the x axis 
#ylab label for the y axis



qplot(Year, data=BaltEmbyTypeYear, 
            geom="bar", 
            weight=Emissions, 
            facets=.~Type, 
            fill=Year, 
            main='Baltimore City: Emissions (PM 2.5) per year and type', 
            xlab='', 
            ylab = 'Emissions (PM 2.5)')





