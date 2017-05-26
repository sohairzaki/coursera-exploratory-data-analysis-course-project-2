
#Question 2
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips="24510")
##from 1999 to 2008? Use the base plotting system to make a plot answering this question.

#specify working directory
# set the working directory
setwd ("/DataScienceCourse_Coursera/exploratory-data-analysis_Course 5/SampleCode")
getwd ()
#our data is located in datafiles folder inside samplecode
#Source_Classification_Code.rds and summarySCC_PM25

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
# note Baltimore City, Maryland (fips="24510") so let us add this condition using filter in the summarize 

#tabulate emission by year using summarize 
BaltEmbyYear = summarize(group_by(filter (NEIDF,fips=="24510"), year), sum(Emissions))
# let us display it
BaltEmbyYear

# a table 4 x 2
# year and sum(emissions) are the columns

# let us change the column headers
colnames(BaltEmbyYear) <- c("Year", "Emissions")
#*** let us plot will use a bar plot**
# use main argument to specify title of plot
#col argument to specify the color of the bars
#xlab the label for the x axis
#ylab the label for the y axis

barplot(BaltEmbyYear$Emissions, 
        names.arg=BaltEmbyYear$Year, 
        col="green", 
        xlab='Years', 
        ylab='Emissions (PM 2.5)', 
        main =  'Baltimore Emissions (PM 2.5) per year') 


# let us improve the bar by dividing the emissions by million
#new column with emissions in million (for the y axis)

BaltEmbyYear$EmissionsInMillions = BaltEmbyYear$Emissions / 1000000

# let us replot the bar plot again

barplot(BaltEmbyYear$EmissionsInMillions, 
        names.arg=EmbyYear$Year, 
        col="green", 
        xlab='Years', 
        ylab='Emissions (PM 2.5) in Millions', 
        main =  'Baltimore Emissions (PM 2.5) per year') 


# this is better looking



