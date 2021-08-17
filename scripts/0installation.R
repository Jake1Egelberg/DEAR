#Create text file to update user
update<-data.frame(Update="Status")

#Installing base packages to R
base.packages<-c("BiocManager",
                 "stringr",
                 "RColorBrewer",
                 "gplots",
                 "this.path")
for(i in 1:length(base.packages)){
  tryCatch(find.package(base.packages[i]),
           error=function(e) install.packages(base.packages[i],repos="http://lib.stat.cmu.edu/R/CRAN/"))
}

#Load packages
library("this.path")
library("stringr")

#Get current file path
file.path<-this.dir()

#Generalize to folder
file.path<-str_replace(file.path,"scripts","")

#Create directories
dir.create(paste(file.path,"1fastqfiles",sep=""))
  dir.create(paste(file.path,"1fastqfiles/pair",sep=""))
  dir.create(paste(file.path,"1fastqfiles/history",sep=""))
dir.create(paste(file.path,"2genome",sep=""))
dir.create(paste(file.path,"3annotations",sep=""))
dir.create(paste(file.path,"buildindex",sep=""))
dir.create(paste(file.path,"plots",sep=""))
  dir.create(paste(file.path,"plots/Quality",sep=""))
dir.create(paste(file.path,"progress",sep=""))

#Install BiocManager packages
bioc.packages<-c("Rsubread", 
                 "edgeR",
                 "limma",
                 "Glimma",
                 "org.Mm.eg.db",
                 "org.Hs.eg.db",
                 "fgsea",
                 "reactome.db")
library("BiocManager")
for(i in 1:length(bioc.packages)){
  tryCatch(find.package(bioc.packages[i]),
           error=function(e) {BiocManager::install(bioc.packages[i])
             setwd(paste(file.path,"progress",sep=""))
             write.table(update,paste("Installing ",bioc.packages[i],"... .txt",sep=""))
             })
}

#Get R file path
R.path<-R.home(component="bin")
R.exe<-paste(R.path,"/R.exe",sep="")

#Create .bat files
buildindex.text<-c("@echo on",
                   paste(R.exe,' CMD BATCH ',file.path,"scripts/1buildindex.R",sep=""))
setwd(file.path)
write.table(buildindex.text,file="1BUILD_INDEX.bat",
            sep=",",quote=FALSE,
            row.names=FALSE,col.names = FALSE)

alignreads.text<-c("@echo on",
                   paste(R.exe,' CMD BATCH ',file.path,"scripts/2alignreads.R",sep=""))
setwd(file.path)
write.table(alignreads.text,file="2ALIGN_READS.bat",
            sep=",",quote=FALSE,
            row.names=FALSE,col.names = FALSE)

de.text<-c("@echo on",
           paste(R.exe,' CMD BATCH ',file.path,"scripts/3deanalysis.R",sep=""))
setwd(file.path)
write.table(de.text,file="3DE_ANALYSIS.bat",
            sep=",",quote=FALSE,
            row.names=FALSE,col.names = FALSE)

#Create design csv
design<-matrix(nrow=4,ncol=2)
colnames(design)<-c("Intercept","mutant")
design[,1]<-1
setwd(file.path)
write.csv(design,"design.csv",row.names=FALSE)

#Create metadata csv
metadata<-matrix(nrow=4,ncol=5)
colnames(metadata)<-c("SourceDOI","Accession","SampleType","RefGenome","mutant")
setwd(file.path)
write.csv(metadata,"metadata.csv",row.names=FALSE)

setwd(paste(file.path,"progress",sep=""))
write.table(update,"Installation Complete.txt")
