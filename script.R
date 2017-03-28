##You will need these packages
require(ggplot2)
require(reshape2)
require(RColorBrewer)

## read in the file
mydata<- read.csv("blocked_driveway.csv", header=T, sep=',')

## convert to long form using reshape2 package
md2<- melt(mydata, id=c("Time"))
View(md2)

## order the variables
md2$Time <- factor(md2$Time, levels = unique(md2$Time), ordered = TRUE)
md2$variable <- factor(md2$variable, levels = unique(md2$variable), ordered = TRUE)

##Create a palette using RColorBrewer
myPalette <- colorRampPalette(rev(brewer.pal(11, "Spectral")), space="Lab")

##Create plot using ggplot2
zp1 <- ggplot(md2, aes(x =variable, y = Time, fill = value))
zp1 <- zp1 + geom_tile()
zp1 <- zp1 + scale_fill_gradientn(colours = myPalette(100)) + geom_text(size=4, aes(fill = md2$value, label = round(md2$value))) + xlab("Day") + ylab("Hour")
zp1 <- zp1 + scale_x_discrete(expand = c(0, 0))
zp1 <- zp1 + scale_y_discrete(expand = c(0, 0))
zp1 <- zp1 + theme_bw()
print(zp1)

##puth to plot_ly
ggplotly(zp1) %>% config(displayModeBar = F)
