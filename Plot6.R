

#Question 6
#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources
#in Los Angeles County, California (???????????????? 
# fips=="06037"????
#Which city has seen greater changes over time in motor vehicle emissions?

#specify working directory
# set the working directory
setwd ("/DataScienceCourse_Coursera/exploratory-data-analysis_Course 5/SampleCode")
getwd ()
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

#create a data frame using tbl_df
NEIDF <- tbl_df(NEI)
# note Baltimore City, Maryland (fips="24510") so let us add this condition using filter in the summarize 
# and we need motor vechical so we can add another filter type=='ON-ROAD'

#tabulate emission by year using summarize 
BaltEmVehiclebyYear = summarize(group_by(filter (NEIDF,fips=="24510", type=="ON-ROAD"), year), sum(Emissions))
# let us display it
BaltEmVehiclebyYear
#add place name
BaltEmVehiclebyYear = mutate(BaltEmVehiclebyYear, Place = 'Baltimore')



# note LA (fips="06037") so let us add this condition using filter in the summarize 
# and we need motor vechical so we can add another filter type=='ON-ROAD'

#tabulate emission by year using summarize 
LAEmVehiclebyYear = summarize(group_by(filter (NEIDF,fips=="06037", type=="ON-ROAD"), year), sum(Emissions))
# let us display it
LAEmVehiclebyYear
#add place name
LAEmVehiclebyYear = mutate(LAEmVehiclebyYear, Place ='LA')

#let us join the two tables union them using rbind to combine the rows

BaltLA <- rbind(BaltEmVehiclebyYear,LAEmVehiclebyYear)

# rename columns using colnames and assign a vector with the required column names
colnames (BaltLA) <- c('Year', 'Emissions', 'Place')

BaltLA$Year <- as.character(BaltLA$Year)

#let us install the ggplot2 package and load the ggplot2 library

install.packages ("ggplot2")
library (ggplot2)

#let us plot the graph 
#main title xlab label for the x axis ylab label for the y axis geom type of graph is bar

qplot(Year,data=BaltLA, geom="bar", weight=Emissions, facets=.~Place, fill=Year, main='Baltimore /LA: Emissions of vehicle', xlab='', ylab = 'Emissions ')
