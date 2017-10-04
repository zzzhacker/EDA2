##set current working dirctoey where tha data files are present

##load the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##gorup by year and sum the emissions
td<-aggregate(Emissions ~ year,NEI, sum)

##creating a base plot and save in a png device
png("plot1.png",width=480,height=480,units="px")
with(td,plot(year,Emissions/10^6,type="o",main ="Total PM2.5 Emissions From All US Sources",xlab = "Year",ylab='Emission(multiple of 10^6)'))
dev.off()