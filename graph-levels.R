# Read CSV files, redo graphics
library(reshape2)
library(plyr)
library(scales)
mydata1 <- read.table("results/graph_bds_real_vs_syn_denom.csv",header=TRUE,sep=",")
mydata2 <- read.table("results/graph_bds_real_vs_syn_job_creation.csv",header=TRUE,sep=",")

mydata3 <- read.table("results/graph_bds_real_vs_syn_job_creation_births.csv",header=TRUE,sep=",")
mydata4 <- read.table("results/graph_bds_real_vs_syn_job_creation_continuers.csv",header=TRUE,sep=",")

# fix names
names(mydata1)[2:3] <- c("Released","Synthetic")
names(mydata2)[2:3] <- c("Released","Synthetic")
names(mydata3)[2:3] <- c("Released","Synthetic")
names(mydata4)[2:3] <- c("Released","Synthetic")

# there probably is a way to do this in meld
mydata1 <- melt(mydata1,1,c(2,3))
mydata1$type <- "denom"
mydata1$row <- 1
mydata1$col <- 1

mydata2 <- melt(mydata2,1,c(2,3))
mydata2$type <- "job_creation"
mydata2$row <- 1
mydata2$col <- 2

mydata3 <- melt(mydata3,1,c(2,3))
mydata3$type <- "job_creation_births"
mydata3$row <- 2
mydata3$col <- 1

mydata4 <- melt(mydata4,1,c(2,3))
mydata4$type <- "job_creation_continuers"
mydata4$row <- 2
mydata4$col <- 2


# stack them
mydata <- rbind(mydata1,mydata2,mydata3,mydata4)

# get the highest point
mymax <- max(mydata1$value,na.rm = TRUE)
#mymin <- min(mydata$V2,-100,na.rm=TRUE)
library(ggplot2)
# option 1
g1 <- ggplot(data=mydata, aes(x=year2,y=value)) +
  ylab("")+
  xlab("Year")+
  xlim(1976,2001)+
  geom_hline(yintercept=0)+
  geom_line() +
  geom_point(size=3)+
  aes(colour=variable)+
  scale_color_manual(values=c("blue","red")) +
  scale_y_continuous(breaks=round_any(seq(0,mymax,length.out = 10),10E4),
                     expand = c(0,0),labels=comma) +
  aes(shape= variable)+
#  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        axis.text.y = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(colour = "black",linetype = 5),
        panel.grid.minor.y = element_line(colour = "grey",linetype = 3),
        panel.border = element_blank(),
        panel.background = element_blank()
  ) 

g0 <- g1 + facet_grid(row ~ col)
png("results/levels_diff_hidef.png",res = 600,width=5000,height=3000,units = "px")
g0
dev.off()
png("results/levels_diff_8in.png",width=8,height=6,units = "in",res=600)
g0
dev.off()
png("results/levels_diff_hidef.tiff",res = 600,width=5000,height=3000,units = "px")
g0
dev.off()

# option2 

g1 <- g1 %+% mydata1
g1 <- g1 + theme(legend.position = c(0.8,0.2)) + ggtitle("denom")
png("results/graph_bds_real_vs_syn_denom_R.png",res = 600,width=4000,height=3000,units = "px")
g1
dev.off()

g2 <- g1 %+% mydata2
g2 <- g2 +   scale_y_continuous(limits=c(0,max(mydata2$value,na.rm = TRUE)),
                                breaks=round_any(seq(0,max(mydata2$value,na.rm = TRUE)+10E3,length.out = 5),10E4),
                                expand = c(0,0),
                                labels=comma)  + ggtitle("job_creation")
png("results/graph_bds_real_vs_syn_job_creation_R.png",res = 600,width=4000,height=3000,units = "px")
g2
dev.off()

g3 <- g1 %+% mydata3
g3 <- g3 +   scale_y_continuous(limits=c(0,max(mydata3$value,na.rm = TRUE)),
                                breaks=round_any(seq(0,max(mydata3$value,na.rm = TRUE)+10E3,length.out = 5),10E4),
                                expand = c(0,0),
                                labels=comma)  + ggtitle("job_creation_births")
png("results/graph_bds_real_vs_syn_job_creation_births_R.png",res = 600,width=4000,height=3000,units = "px")
g3
dev.off()

g4 <- g1 %+% mydata4
g4 <- g4 +   scale_y_continuous(limits=c(0,max(mydata4$value,na.rm = TRUE)),
                                breaks=round_any(seq(0,max(mydata4$value,na.rm = TRUE)+10E3,length.out = 5),10E4),
                                expand = c(0,0),
                                labels=comma)  + ggtitle("job_creation_continuers")
png("results/graph_bds_real_vs_syn_job_creation_continuers_R.png",res = 600,width=4000,height=3000,units = "px")
g4
dev.off()

# now do a four-way
png("results/levels2_diff_hidef.png",res = 600,width=8000,height=6000,units = "px")
multiplot(plotlist=list(g1,g2,g3,g4),cols=2)
dev.off()
png("results/levels2_diff_8in.png",width=8,height=6,units = "in",res=600)
multiplot(plotlist=list(g1,g2,g3,g4),cols=2)
dev.off()
png("results/levels2_diff_hidef.tiff",res = 600,width=5000,height=3000,units = "px")
multiplot(plotlist=list(g1,g2,g3,g4),cols=2)
dev.off()

