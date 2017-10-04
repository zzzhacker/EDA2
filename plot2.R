##set current working dirctoey where tha data files are present


##load the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##gorup by year and sum the emissions and subset for Baltimore City
td<-aggregate(Emissions ~ year,NEI, sum,subset = (fips==24510))


##creating a base plot and save in a png device
png("plot2.png",width=480,height=480,units="px")
with(td,plot(year,Emissions/1000,type="o",main ="Total PM2.5 Emissions From Baltimore City",xlab = "Year",ylab='Emission(multiple of 10^3)'))
dev.off()