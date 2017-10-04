##set current working dirctoey where tha data files are present


##load the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


##gorup by year and type and sum the emissions and subset for Baltimore City
td<-aggregate(Emissions ~ year+type,NEI, sum,subset = (fips==24510))

##making the desired plots
library(ggplot2)
png("plot3.png",width=480,height=480,units="px")
ggplot(td, aes(x=year, y=Emissions, group=type)) +
  geom_line(aes(linetype=type, color=type))+
  geom_point(aes(color=type))+
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)"),title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type")) +
  theme(legend.position="top")+
  theme_bw()
dev.off()