
#Question 5
#How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

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


# let us change the column headers using colnames and using a vector that has the column names
colnames(BaltEmVehiclebyYear) <- c("Year", "Emissions")

#let us install the ggplot2 package and load the ggplot2 library

install.packages ("ggplot2")
library (ggplot2)

g <- ggplot(BaltEmVehiclebyYear, aes(Year,Emissions))+scale_x_continuous(breaks = c(1999,2002,2005,2008))
g+geom_point(size=4, color='orange')+geom_line(size=1.5,color='green')+labs(title="Baltimore Emissions of vehicles", 
                                                                            x="Years",
                                                                            y="Emissions")


