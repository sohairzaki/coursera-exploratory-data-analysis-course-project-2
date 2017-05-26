#Question 4.	
#Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

#let us set the working directory
#our data files are in a directory named datafiles
setwd ("/DataScienceCourse_Coursera/exploratory-data-analysis_Course 5/SampleCode")
getwd ()

#*****Read the data using readRDS****

NEI <- readRDS("datafiles/summarySCC_PM25.rds")
SCC <- readRDS("datafiles/Source_Classification_Code.rds")

#let us make sure that it was read properly
head(NEI)
head (SCC)
#NEI variable names are flips scc pollutant emissions type year  
#SCC variable names are 

#let us merge the two tables using SCC common column

NEI_SCC <- merge (NEI, SCC, by="SCC")
#let us check how it looks like
head (NEI_SCC)


# lets us install the dplyr package and call the library dplyr if it does not exist
#The dplyr package makes these steps fast and easy

install.packages ("dplyr")
library(dplyr) 

#create a data frame using tbl_DF
NEI_SCC_DF <- tbl_df(NEI_SCC)

# search for "coal" and create boolean column
# we are going to use mutate in the dplyr it's often useful to add new columns that are functions of existing columns.

NEI_SCC_DF <- mutate(NEI_SCC_DF, coal = grepl("coal", NEI_SCC_DF$Short.Name, ignore.case=TRUE)) 
# note Baltimore City, Maryland (fips="24510") so let us add this condition using filter in the summarize 
head(NEI_SCC_DF )


# tabulate coal emissions  using summarize
# so we will add type in the group by condition coal==ture 

CoalEmissionbyYear <- summarize(group_by(filter(NEI_SCC_DF, coal==TRUE),year),sum(Emissions))

#let us rename the columns using the colnames and using a vector to assign the new names

colnames(CoalEmissionbyYear) <- c("Year", "Emissions")

# let us convert the year to character using as.character
CoalEmissionbyYear$Year <- as.character(CoalEmissionbyYear$Year)


# we need to install the ggplot2 and load its library the question 
# specifies that we need to use ggplot2 to produce our plot
install.packages ("ggplot2")
library (ggplot2)

#let us divide the emission by thousand to have a better scale
CoalEmissionbyYear$EmissionsIn1000 = CoalEmissionbyYear$Emissions/1000

#let us plot the graph using ggplot2 geom = is bar plot
# main is the title of the plot
#x the x axis label
#y  the y axis label
# title is the title of the plot
#A aes() objects replaces the default aesthetics.



g <-ggplot(CoalEmissionbyYear, 
            aes(Year, EmissionsIn1000))
            g+geom_bar(stat='identity')+labs(title="Emissions from coal combustion", 
            x="Years",
            y="Emissions (PM 2.5) in 1000")
            
            


