##set current working dirctoey where tha data files are present


##load the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Gather the subset of the NEI data which corresponds to vehicles
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

# Subset the vehicles NEI data by each city's fip and add city name.
vehiclesBaltimoreNEI <- vehiclesNEI[vehiclesNEI$fips=="24510",]
vehiclesBaltimoreNEI$city <- "Baltimore City"

vehiclesLANEI <- vehiclesNEI[vehiclesNEI$fips=="06037",]
vehiclesLANEI$city <- "Los Angeles County"

td <- rbind(vehiclesBaltimoreNEI,vehiclesLANEI)
td<-aggregate(Emissions ~ year+city,td, sum)
library(ggplot2)

##creatinf the plot
png("plot6.png",width=480,height=480,units="px")

ggplot(td, aes(x=year, y=Emissions, group=city)) +
     geom_line(aes(linetype=city, color=city))+
     geom_point(aes(color=city))+
     labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)"),title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type")) +
     theme(legend.position="top")+
     theme_bw()
dev.off()

