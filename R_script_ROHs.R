library(tidyverse)
library(ggplot2)
library(rres)
library(rehh)

####The input for this script is the output of Plink function --homozyg

###Plot all ROHs of all individuals for one chromosome
setwd("/home/barmentarier/Documents/Extra_GRSM/Homozygosity")
#load in data
homozyg<-read.table("GRSM_537_ROH_nohet.hom",header = T) #--homozyg output
bim <- read.table("GRSM_537_ROH.bim")                    # Bim file used for --homozyg

#check data
str(homozyg)
homozyg<-na.omit(homozyg)
values <- c(1:530)
homozyg <- unite(homozyg, MERGE, c(FID, IID), remove=FALSE)
homozyg$MERGE <- as.factor(homozyg$MERGE)
homozyg$NUM <- values[homozyg$MERGE] 
head(homozyg)


#plotting
homozygchr1 <- subset(homozyg, CHR==1)
bimchr1 <- subset(bim, V1==1)
ggplot(data=homozygchr1) + geom_segment(aes(x=POS1 ,y=NUM,xend=POS2,yend=NUM))+theme_classic(base_size = 15)+ 
  theme(axis.text.x = element_text(colour = "black"),axis.text.y = element_text(colour = "black"))+ 
  scale_x_continuous(expand = c(0.01, 0.01), limits = c(0, 2.8*10^8))+
  scale_y_continuous(expand = c(0.02, 0.02), limits = c(0, 537))+
  labs(x="Position (bp)",y="Individual ID")


###Assess presences of markers under putative selection in ROHs
setwd("~/Documents/Extra_GRSM")
snps <- read.table("233_IHS-Markers",header=T) #Markers under selection based on iHS
snps$MARKER<-as.character(snps$V2)

setwd("/home/barmentarier/Documents/Extra_GRSM/Homozygosity")
homsum<-read.table("GRSM_537_ROH_nohet.hom.summary",header=T)
homsum$ORDER<-c(1:length(homsum$CHR))
homsum$MARKER<-as.character(homsum$SNP)
val<-c("grey36",rep(c("Grey","grey36"),4),"Grey",rep(c("Grey","grey36"),4))

merged <- merge(snps, homsum, by = "MARKER")
merged <- merged %>% select(CHR.x,POSITION,UNAFF, ORDER)
ggplot(merged, aes(ORDER, UNAFF,col=as.character(CHR.x))) + geom_point() + 
  geom_segment(x=0,y=mean(merged$UNAFF),xend=60000,yend=mean(merged$UNAFF),col="Red3") +
  labs(x="SNP Order",y="ROH Count")+scale_colour_manual(values = val)+
  theme_classic(base_size = 15)+ 
  theme(axis.title.x = element_blank(),axis.text.x = element_blank(),axis.ticks.x = element_blank())+
  theme(legend.position = "none")+ylim(0,450)+xlim(0,58000)+
  theme(axis.text.x = element_text(colour = "black"),axis.text.y = element_text(colour = "black"))
setwd("/home/barmentarier/Documents/FIGURES_FOR_RESULTS")
ggsave("Suppl_ROH_IHS.png",dpi=900)

homsum1<-homsum[!homsum$SNP %in% snps$MARKER,]
ggplot(homsum, aes(ORDER, UNAFF,col=as.character(CHR))) + geom_point() + 
  geom_segment(x=0,y=mean(homsum1$UNAFF),xend=60000,yend=mean(homsum1$UNAFF),col="Red3") +
  labs(x="SNP Order",y="ROH Count")+scale_colour_manual(values = val)+
  theme_classic(base_size = 15)+ 
  theme(axis.title.x = element_blank(),axis.text.x = element_blank(),axis.ticks.x = element_blank())+
  theme(legend.position = "none")+ylim(0,450)+xlim(0,58000)+
  theme(axis.text.x = element_text(colour = "black"),axis.text.y = element_text(colour = "black"))

ggsave("Suppl_ROH_non-ihs.png",dpi=900)


###Script to calculate fROH for several populations
library(ggplot2)
library(tidyverse)
setwd("/home/barmentarier/Documents/Extra_GRSM/Outlying_GRSM/ROH")
bim<-read.table("GRSM_Outlying_ROH.bim")
bimlength<-0
range<-c(1:18)
for(i in range){ #for loop to calculate # of SNPs on all chromosomes that are included
  bimchr<-subset(bim,V1==i)
  num<-max(bimchr$V4)
  bimlength<-c(bimlength, num)
}
bimlength<-bimlength[-1]
sum(bimlength)/1000 #this gives the total kb potentially in an ROH

Outhomindiv<-read.table("GRSM_Outlying_ROH.hom.indiv",header=T)
Outhomindiv <- Outhomindiv %>% arrange(FID)
Outhomindiv$ORDER<-c(1:length(Outhomindiv$FID))
Outhomindiv$fROH<-Outhomindiv$KB/2264176
Outhomindiv$FID<-as.character(Outhomindiv$FID)

ggplot(Outhomindiv, aes(fROH,color=FID))+geom_density(size=1.5,key_glyph="path")+
  labs(x="fROH",y="Density")+ 
  scale_color_manual(name = "Population ID",values=c("#E41A1C" ,"#377EB8" ,"#4DAF4A" ,"#984EA3" ,"#FF7F00"))+ 
  theme_classic(base_size = 20)+theme(axis.text.x = element_text(colour = "black"),axis.text.y = element_text(colour = "black"))+ 
  scale_x_continuous(expand = c(0, 0), limits = c(0, 0.7))+ 
  scale_y_continuous(expand = c(0, 0), limits = c(0, 8))+ 
  theme(legend.position = c(0.85, 0.8))
setwd("~/Documents/FIGURES_FOR_RESULTS")
ggsave("fROH_outlying.png",dpi=900) 
