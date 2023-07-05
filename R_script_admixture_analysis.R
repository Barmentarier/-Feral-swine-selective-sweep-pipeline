library(rres)
library(tidyverse)
library(ggplot2)

#Input for this script is the the output of the software ADMIXTURE
#In this particular example, the ancestry of the GRSM populations is compared with outlying invasive populations

setwd("~/Documents/Extra_GRSM/Outlying_GRSM/Admixture")
hapmap <- read.table("GRSM_Outlying_Admix.6.Q")
fam <- read.table("GRSM_Outlying_Admix.fam") #.fam file including GRSM, NC, SC, TN, WV
pedi <- fam %>% select(V1)
hapmap<-cbind(pedi,hapmap)
colnames(hapmap)<-c("pedi","V1","V2","V3","V4","V5","V6")
hapmap<-arrange(hapmap,pedi)
num<-c(1:nrow(hapmap))
num<-c(num,num,num,num,num,num)
cluster1<-rep(1,868)
cluster2<-rep(2,868)
cluster3<-rep(3,868)
cluster4<-rep(4,868)
cluster5<-rep(5,868)
cluster6<-rep(6,868)
cluster7<-rep(7,868)
cluster8<-rep(8,868)

cluster<-as.character(c(cluster1,cluster2,cluster3,cluster4,cluster5,cluster6))
Vtot<-c(hapmap$V1,hapmap$V2,hapmap$V3,hapmap$V4,hapmap$V5,hapmap$V6)
hapmapnew<-data.frame(Vtot,num,cluster)
val<-c("#E41A1C" ,"#377EB8" ,"#4DAF4A" ,"#984EA3" ,"#FF7F00" ,"#A65628")
ggplot(hapmapnew, aes(y=Vtot, x=num,fill=cluster)) + 
  theme(axis.text.x = element_text(colour = "black"),axis.text.y = element_text(colour = "black"))+ 
  theme_classic(base_size = 15)+
  geom_bar(position="stack", stat="identity")+labs(x="Individual ID",y="Ancestry")+
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))+
  scale_fill_manual(name="Ancestry cluster",values=val)+ theme(axis.text.x = element_text(colour = "black"),
                                                               axis.text.y = element_text(colour = "black"))
setwd("~/Documents/FIGURES_FOR_RESULTS")
ggsave("Admix_Outlying_K6.png",dpi=900)  