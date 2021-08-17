#***********************************************************
#*************************RNA SEQ **************************
#***********************************************************

#---------------------LOADING PARMS----------------------
library(this.path)
library(stringr)
#Choose primary workflow file path
file.dir<-this.dir()
file.path<-str_replace(file.dir,"scripts","")

#Load user-set parms file
parms<-read.delim(paste(file.path,"parms.txt",sep=""),sep=":")

#Redefine parms for R
index.file<-trimws(parms[which(parms$RNA_SEQ_PARAMETERS=="index.file"),2])

#Load packages
library(BiocManager)
library(Rsubread)
library(stringr)
set.seed(42)

#Create text file to update user
update<-data.frame(Update="Status")

#Remove existing progress files
progress.files<-list.files(path=paste(file.path,"progress",sep=""),full.names = TRUE)
file.remove(progress.files)

setwd(paste(file.path,"progress",sep=""))
write.table(update,"INDEXING GENOME.txt")

#---------------------BUILD INDEX----------------------

#Get reference genome (index.file from parms)
genome.for.index<-list.files(path=paste(file.path,"2genome/",sep=""),
                       pattern=paste("^",index.file,sep=""),full.names = TRUE)

index.filepath<-paste(file.path,"buildindex",sep="")
setwd(index.filepath)
buildindex(basename=index.file,
           reference=genome.for.index,
           gappedIndex=TRUE,
           indexSplit=TRUE)

setwd(paste(file.path,"progress",sep=""))
write.table(update,"INDEX CONSTRUCTED.txt")
