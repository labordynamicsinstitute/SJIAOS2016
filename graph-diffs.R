# Read CSV files, redo graphics

mydata1 <- read.table("results/graph_bds_real_vs_syn_pct_denom.csv",sep=",",header=TRUE)
mydata2 <- read.table("results/graph_bds_real_vs_syn_pct_job_creation.csv",header=TRUE,sep=",")

mydata3 <- read.table("results/graph_bds_real_vs_syn_pct_job_creation_births.csv",header=TRUE,sep=",")
mydata4 <- read.table("results/graph_bds_real_vs_syn_pct_job_creation_continuers.csv",header=TRUE,sep=",")

# there probably is a way to do this in meld
mydata1$Variable <- sub("pct_","",names(mydata1)[2])
mydata2$Variable <- sub("pct_","",names(mydata2)[2])
mydata3$Variable <- sub("pct_","",names(mydata3)[2])
mydata4$Variable <- sub("pct_","",names(mydata4)[2])
# standardize the second name
names(mydata1)[2] <- c("V2")
names(mydata2)[2] <- c("V2")
names(mydata3)[2] <- c("V2")
names(mydata4)[2] <- c("V2")

# stack them
mydata <- rbind(mydata2,mydata1,mydata3,mydata4)
# get the highest point
mymax <- max(mydata$V2,50,na.rm=TRUE)
mymin <- min(mydata$V2,-100,na.rm=TRUE)
library(ggplot2)

g1 <- ggplot(data=mydata, aes(x=year2,y=V2)) +
    ylim(mymin,mymax)+
    ylab("Percent difference")+
    xlab("Year")+
    xlim(1976,2001)+
    geom_hline(yintercept=0)+
    geom_line() +
    geom_point(size=3)+
    scale_y_continuous(breaks=round(seq(mymin,mymax,by=25),1),minor_breaks = seq(mymin,mymax,by=5)) +
    aes(shape= Variable,colour=Variable)+
    scale_colour_brewer(type = "qual",palette = "Set1")+
  #theme_bw() +
    theme(axis.line = element_line(colour = "black"),
          panel.grid.major.x = element_blank(),
          panel.grid.major.y = element_line(colour = "black",linetype = 5),
          panel.grid.minor.y = element_line(colour = "grey",linetype = 3),
          panel.grid.minor.x = element_blank(),
          panel.border = element_blank(),
          panel.background = element_blank()
          ) 
png("results/pct_diff_hidef.png",res = 600,width=5000,height=3000,units = "px")
g1
dev.off()
png("results/pct_diff_8in.png",width=8,height=6,units = "in",res=600)
g1
dev.off()
tiff("results/pct_diff_hidef.tiff",res = 600,width=5000,height=3000,units = "px")
g1
dev.off()

