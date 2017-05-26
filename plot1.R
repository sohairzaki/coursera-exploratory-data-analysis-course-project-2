# set the working directory
setwd ("/DataScienceCourse_Coursera/exploratory-data-analysis_Course 5/SampleCode")
getwd ()

#Question 1.	
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission 
#from all sources for each of the years 1999, 2002, 2005, and 2008. 

#our data is located in datafiles folder inside samplecode
#Source_Classification_Code.rds and summarySCC_PM25

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

#tabulate emission by year using summarize 
EmbyYear = summarize(group_by(NEIDF, year), sum(Emissions))
# let us display it
EmbyYear

# a table 4 x 2
# year and sum(emissions) are the columns

# let us change the column headers
colnames(EmbyYear) <- c("Year", "Emissions")
#*** let us plot will use a bar plot**
# use main argument to specify title of plot
#col argument to specify the color of the bars
#xlab the label for the x axis
#ylab the label for the y axis

barplot(EmbyYear$Emissions, 
        names.arg=EmbyYear$Year, 
        col="red", 
        xlab='Years', 
        ylab='Emissions (PM 2.5)', 
        main =  'Emissions (PM 2.5) per year') 


# let us improve the bar by dividing the emissions by million
#new column with emissions in million (for the y axis)

EmbyYear$EmissionsInMillions = EmbyYear$Emissions / 1000000

# let us replot the bar plot again

barplot(EmbyYear$EmissionsInMillions, 
        names.arg=EmbyYear$Year, 
        col="red", 
        xlab='Years', 
        ylab='Emissions (PM 2.5) in Millions', 
        main =  'Emissions (PM 2.5) per year') 


# this is better looking



