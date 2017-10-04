##set current working dirctoey where tha data files are present


##load the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset coal combustion related NEI data
combustion <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal<- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustion& coal)
combustionSCC <- SCC[coalCombustion,]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]


##making the desired plots
png("plot4.png",width=480,height=480,units="px")

library(ggplot2)

ggplot(combustionNEI,aes(factor(year),Emissions/10^5)) +
  geom_bar(stat="identity",fill="lightgreen",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))
       
dev.off()