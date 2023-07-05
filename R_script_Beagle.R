###The input for this script is the output of BEAGLE and REFINED_IBD on multiple distinct populations or clusters

##Calculate the number of shared haplotypes of one cluster/population with the others in your dataset
setwd("~/Documents/Beagle_Ancestry_backup")
ibd<-data.frame(FID1=0,IID1=0,V2=0,FID2=0,IID2=0,V4=0,V5=0,V6=0,V7=0,V8=0,V9=0)
num<-c(1:18)
library(tidyverse)

for(number in num){
  IBDname<-paste0("GRSM_k15k16k17_Merged_chr",number,"_phased_IBD.ibd.gz") #phased haplotypes of GRSM, Asian, Western Heritage and Eu wild
  IBDcur<-read.table(IBDname)
  IBDcur<-separate(IBDcur,V1,into=c("FID1","IID1"),sep="_",extra = "merge")
  IBDcur<-separate(IBDcur,V3,into=c("FID2","IID2"),sep="_",extra = "merge")
  ibd<-rbind(ibd,IBDcur)
}  
ibd<-ibd[-1,]
colnames(ibd)<-c("FID1","IID1","HapID1","FID2","IID2","HapID2", "CHR","START","END","LOD","cM")
write.table(ibd,"TOTAL_IBD(all_columns).txt",quote=F,row.names = F,col.names = T)

ibd<-read.table("TOTAL_IBD(all_columns).txt",header=T)
ibdk15<-subset(ibd,FID1=="15"&FID2=="15")
ibdk16<-subset(ibd,FID1=="16"&FID2=="16")
ibdk17<-subset(ibd,FID1=="17"&FID2=="17")

#calculate cM haplotypes within cluster
ibdGRSM<-subset(ibd,FID1=="GRSM"&FID2=="GRSM") 
mean(ibdGRSM$cM)
mean(ibdk15$cM)
mean(ibdk16$cM) 
mean(ibdk17$cM) 

#Calculate number and size (in cM) of haplotypes one cluster shares with the others. 
#Note that these values below are generally lower than within a cluster, due to genetic differences.
ibdGRSM<-subset(ibd,FID1=="GRSM"|FID2=="GRSM")
ibdk15<-subset(ibdGRSM,FID1=="15"|FID2=="15")
ibdk16<-subset(ibdGRSM,FID1=="16"|FID2=="16")
ibdk17<-subset(ibdGRSM,FID1=="17"|FID2=="17")
sd(ibdk15$cM)
sd(ibdk16$cM) 
sd(ibdk17$cM) 

ibdGRSM<-subset(ibd,FID1=="GRSM"|FID2=="GRSM")
IID<-c(ibdGRSM$IID1,ibdGRSM$IID2)
IIDnumber<-unique(IID) #number of individuals included
START<-as.data.frame(ibdGRSM$START) 
nrow(START) #number of shared haplotypes
STARTnumber<-unique(START) # number of unique haplotypes GRSM shares with at least one other cluster
800251/(12250*529.8889) #Calculate the potential possible shared haplotypes within GRSM;
#Formula is: 
#Relative potential shared haplotypes = number of shared haplotypes within cluster/ 
                                        #(number of observed haplotypes in dataset * Number of individuals within cluster)

ibdk15<-subset(ibd,FID1=="15"&FID2=="15")
IID<-c(ibdk15$IID1,ibdk15$IID2)
IIDnumber<-unique(IID)#570
ibdk15<-subset(ibdGRSM,FID1=="15"|FID2=="15")
START<-as.data.frame(ibdk15$START)#
nrow(START) #number of haplotypes GRSM shares with k15
nrow(START)/(12250*569.3889) #Calculate the potential number of haplotypes shared within GRSM and k15

ibdk16<-subset(ibd,FID1=="16"&FID2=="16")
IID<-c(ibdk16$IID1,ibdk16$IID2)
IIDnumber<-unique(IID)
ibdk16<-subset(ibdGRSM,FID1=="16"|FID2=="16")
START<-as.data.frame(ibdk16$START)
nrow(START)/(12250* 397.1667) 

ibdk17<-subset(ibd,FID1=="17"&FID2=="17")
IID<-c(ibdk17$IID1,ibdk17$IID2)
IIDnumber<-unique(IID)
ibdk17<-subset(ibdGRSM,FID1=="17"|FID2=="17")
START<-as.data.frame(ibdk17$START)
nrow(START)/(12250*276.2778)

##Determine locations of haplotypes GRSM shares with other clusters
setwd("~/Documents/Beagle_Ancestry_backup")

for(number in num){
  IBDname<-paste0("VCF_GRSM_ReferenceSet_chr",number,"_phased_IBD.ibd.gz")
  IBD<-read.table(IBDname)
  IBD<-separate(IBD,V1,into=c("FID1","IID1"),sep="_",extra = "merge")
  IBD<-separate(IBD,V3,into=c("FID2","IID2"),sep="_",extra = "merge")
  colnames(IBD)<-c("FID1","IID1","HapID1","FID2","IID2","HapID2", "CHR","START","END","LOD","cM")
  IBDGRSM<-subset(IBD,FID1=="GRSM"|FID2=="GRSM")
  IBDGRSMk15<-subset(IBDGRSM,FID1=="15"|FID2=="15")
  IBDGRSMk16<-subset(IBDGRSM,FID1=="16"|FID2=="16")
  IBDGRSMk17<-subset(IBDGRSM,FID1=="17"|FID2=="17")
  IBDGRSMk15$dataID<-"k15"
  IBDGRSMk16$dataID<-"k16"
  IBDGRSMk17$dataID<-"k17"
  k15<-select(IBDGRSMk15,dataID,CHR,LOD,cM,START,END,IID1,IID2)
  k16<-select(IBDGRSMk16,dataID,CHR,LOD,cM,START,END,IID1,IID2)
  k17<-select(IBDGRSMk17,dataID,CHR,LOD,cM,START,END,IID1,IID2)
  SharedHaplos<-rbind(SharedHaplos,k15,k16,k17)
}
SharedHaplos<-SharedHaplos[-1,] 

topSharedHaplos<-arrange(SharedHaplos,desc(cM))
topSharedHaplos<-topSharedHaplos[1:(nrow(topSharedHaplos)*1),]
topSharedHaplos<-arrange(topSharedHaplos,CHR,START)
topSharedHaplos$dataID<-as.character(topSharedHaplos$dataID)
topSharedHaplos$dataID[topSharedHaplos$dataID=="k16"]<-"European Heritage"
topSharedHaplos$dataID[topSharedHaplos$dataID=="k17"]<-"Eurpean Wild"
topSharedHaplos$dataID[topSharedHaplos$dataID=="k15"]<-"Asian"

topSharedHaploschr<-subset(topSharedHaplos,CHR==1)
topSharedHaploschr$NUM<-c(1:nrow(topSharedHaploschr))


col<-c("tan2" ,"green3", "royalblue4")
ggplot(data=topSharedHaploschr) + geom_segment(aes(x=START ,y=NUM,xend=END,yend=NUM,color=dataID))+
  theme_classic(base_size = 15)+theme(axis.text.x = element_text(colour = "black"),axis.text.y = element_text(colour = "black"))+
  labs(x="Genetic Position (bp)",y="Haplotype ID")+ scale_color_manual(name = "Population ID",values=col)+
  theme(legend.position = c(0.15, 0.8))+ scale_x_continuous(expand = c(0.01, 0.01), limits = c(0, 2.8*10^8))+ 
  scale_y_continuous(expand = c(0.01, 0.01), limits = c(0, 20000))
setwd("~/Documents/FIGURES_FOR_RESULTS")
ggsave("Beagle_lochaplotypes_chr1.png",dpi=500)  

topSharedHaploschr<-subset(topSharedHaplos,CHR==13)
topSharedHaploschr$NUM<-c(1:nrow(topSharedHaploschr))

col<-c("tan2" ,"green3", "royalblue4")
ggplot(data=topSharedHaploschr) + geom_segment(aes(x=START ,y=NUM,xend=END,yend=NUM,color=dataID))+
  theme_classic(base_size = 15)+theme(axis.text.x = element_text(colour = "black"),axis.text.y = element_text(colour = "black"))+
  labs(x="Genetic Position (bp)",y="Haplotype ID")+ scale_color_manual(name = "Population ID",values=col)+
  theme(legend.position = c(0.15, 0.8))+ scale_x_continuous(expand = c(0.01, 0.01), limits = c(0, 2.8*10^8))+ 
  scale_y_continuous(expand = c(0.01, 0.01), limits = c(0, 20000))

setwd("~/Documents/FIGURES_FOR_RESULTS")
ggsave("Beagle_lochaplotypes_chr13.png",dpi=500) 

##Plot length shared haplotypes 
setwd("~/Documents/Figures_Beagle_IBD")
SharedHaplos<-read.table("SharedHaplos_total_IBD.txt",header= T)
col<-c("tan2" ,"green3", "royalblue4")
SharedHaplos$dataID<-as.character(SharedHaplos$dataID)
SharedHaplos$dataID[SharedHaplos$dataID=="k16"]<-"European Heritage"
SharedHaplos$dataID[SharedHaplos$dataID=="k17"]<-"European Wild"
SharedHaplos$dataID[SharedHaplos$dataID=="k15"]<-"Asian"
ggplot(SharedHaplos,aes(cM,color=dataID))+geom_density(size=1.10,key_glyph="path")+
  labs(x="Genetic Position (Mb)",y="Density")+scale_color_manual(name = "Population ID",values=col)+
  theme_classic(base_size = 15)+theme(axis.text.x = element_text(colour = "black"),axis.text.y = element_text(colour = "black"))+ scale_x_continuous(expand = c(0, 0), limits = c(0, 15))+ 
  scale_y_continuous(expand = c(0, 0), limits = c(0, 0.45))+ 
  theme(legend.position = c(0.9, 0.8))
setwd("~/Documents/FIGURES_FOR_RESULTS")
ggsave("Suppl_cM-Beagle_ref.png",dpi=500)  
