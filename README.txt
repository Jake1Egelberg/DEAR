INSTALLATION INSTRUCTIONS:

1) Download this RNAseqV2-main folder onto your hardrive (D:).

*If you do not have a D: file path, edit the 0INSTALLATION.bat file above in a text editor to the file path availible.

2) Install R version 4.1.1 into the subfolder "R-4.1.1". The resulting file path for R should read "D:/RNASeqV2-main/R-4.1.1/bin/x64/R.exe". Windows may ask to confirm that you would like to install to a folder that already exists. 

*Install R version 4.1.1 here: http://lib.stat.cmu.edu/R/CRAN/

3) Run the 0INSTALLATION.bat file to install packages and create directories. This may take some time. Monitor the "libraries" folder in R-4.1.1 to see addition of packages.

------------------------------------------------------------

GENERAL STEPS OF RNA-SEQ:
1) Build index of reference genome (human/hg19/hg38 or mouse/mm9/mm10)
2) Align RNA reads to index
3) Measure differential expression between high quality reads

------------------------------------------------------------

1) Identify sequences to analyze from NCBI SRA (Sequence Read Archive)
	https://www.ncbi.nlm.nih.gov/sra/?term=hg19
*Filter by  Access=Public, Source=RNA, Library Layout=<Your choice>, File Type= .fastq OR .bam
**Order results by taxon to according to which organism you are investigating (human/hg19/hg38 or mouse/mm9/mm10)

2) Download FASTQ/BAM from European Nucleotide Archive (downloading BAM speeds up analysis)
	https://www.ebi.ac.uk/ena/browser/view
*Use "View" function to search by SRR from SRA

3) Import FASTQ/BAM to 1fastqfiles folder in workflow path
	Store old FASTQ files in "history" subfolder
	For paired data, ensure one set is added to pair folder in same order

4) Identify reference genome and import .fa.gz file to 2genome folder
	https://hgdownload.soe.ucsc.edu/downloads.html
*For taxon="Homo sapiens," use genome hg19. For taxon="Mus musculus," use genome mm10

5) Record sample metadata and configure design matrix

6) Configure parms according to sample metadata and design matrix.

7) Run the following .bat files in order:
	1) 1BUILD_INDEX.bat *SKIP THIS IF YOU ALREADY HAVE A BUILT INDEX*
	2) 2ALIGN_READS.bat *SKIP THIS IF YOU DOWNLOADED BAM FILES*
	3) 3DE_ANALYSIS.bat
*THIS CAN TAKE A LONG TIME

8) Monitor program progress as follows:
	a) See "progress" folder for current processes
	b) Monitor the buildindex and 1fastqfiles folders to see addition of new files
	c) Check task manager to ensure that resources are being directed towards RNA-seq program (shows up as Windows Command Processor)
	d) Ensure that analysis is complete in "progress" folder before the command window closes automatically
	e) If analysis stops on 3DE_ANALYSIS, you may need to re-configure threshold and sample values to include more genes


------------------------------------------------------------

EXAMPLE FASTQ SEQUENCES TO START:
SRR1552444
SRR1552445
SRR1552446
SRR1552447
SRR1552448
SRR1552449
SRR1552450
SRR1552451
SRR1552452
SRR1552453
SRR1552454
SRR1552455

Fu, N.Y., Rios, A., Pal, B., Soetanto, R., Lun, A.T.L., Liu, K., Beck, T., Best, S., Vaillant, F., Bouillet, P., Strasser, A., Preiss, T., Smyth, G.K., Lindeman, G., , Visvader, J.: EGF-mediated induction of Mcl-1 at the switch to lactation is essential for alveolar cell survival. Nature Cell Biology 17(4), 365–375 (2015)

------------------------------------------------------------

ANNOTATED PARMS FILE

#Specify reference genome file name (remove ending, .fa.gz implied), file to be indexed
index.file<-"chr1_mm10"

#Set true if data is paired-end
paired.end.status<-FALSE

#Specify reference genome of samples and index file
  #Mouse (mm10) and human (hg19) genome assemblies
ref.genome<-"mm10"

#Specify whether to use existing raw feature counts or not
use.existing.counts: FALSE

#Configure design matrix
  #Groups as column names (factor)
  #Rows are samples (row number should correspond to order of FASTQ)
  #Fill columns with 1 or 0 to indicate status (level)

#Specify group to compare (should be column name in design matrix)
  #Can only compare 2 levels within 1 factor
interest.group<-"typeluminal"

#Specify threshold and sample values for removing lowly expressed genes
thresh.value<-6 #CPM<X selected
sample.value<-2 #Across at least X samples

------------------------------------------------------------

CITE THIS WORKFLOW:
Jake Egelberg. (2021). Jake1Egelberg/RNASeqV2: RNA-seq Workflow v2.0.1 (v2.0.1). Zenodo. https://doi.org/10.5281/zenodo.5207295
