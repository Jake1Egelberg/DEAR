INSTRUCTIONAL VIDEOS (about 5 minutes each):

(1) Installing DEAR: https://youtu.be/L05PSafdiOk

(2) Downloading FASTQ Files: https://youtu.be/wlld8AkRMT8

(3) Setting Parameters: https://youtu.be/DRsgwIjwC_g

(4) Differential Expression Analysis in R: https://youtu.be/5zIpqULUig4

------------------------------------------------------------

INSTALLATION INSTRUCTIONS:

1) Select the green CODE button in the top right of your screen to download the DEAR-main folder. Extract this folder directly onto your hardrive (C:).

*If you are not downloading to a C: file path, edit the 0INSTALLATION.bat file above in a text editor to the file path you are downloading to.

2) Install R version 4.1.1 into the subfolder "R-4.1.1". The resulting file path for R should read "D:/DEAR-main/R-4.1.1/bin/x64/R.exe". R will attempt to create its own "R-4.1.1" subfolder within the one that already exists. Ensure that you edit the file path to prevent this. Windows may ask you to confirm that you would like to install to a folder that already exists. 
	Install R version 4.1.1 here: http://lib.stat.cmu.edu/R/CRAN/

3) Run the 0INSTALLATION.bat file to install packages and create directories. This may take some time. You can track the progress in the "progress" folder created soon after running.

------------------------------------------------------------

GENERAL STEPS OF DEA:

1) Build index of genome of interest
2) Align RNA reads to index
3) Count reads at each location and measure differential expression between high quality reads

------------------------------------------------------------

USING DEAR:

1) Identify sequences to analyze from NCBI SRA (Sequence Read Archive). Must be from human or mouse samples.
	https://www.ncbi.nlm.nih.gov/sra/

*Filter by  Access=Public, Source=RNA, Library Layout=<Your choice>, File Type= .fastq OR .bam
**Order results by taxon to according to which organism you are investigating (Homo sapiens/hg19/hg38 or Mus musculus/mm9/mm10)

2) Download FASTQ/BAM from European Nucleotide Archive (downloading BAM speeds up analysis)
	https://www.ebi.ac.uk/ena/browser/view

3) Extract downloaded FASTQ/BAM to the 1fastqfiles folder in DEAR

*Store old FASTQ files in history folder
**For paired data, ensure one set is added to pair folder in same order

4) Identify the reference genome for your chosen sequences and import its FASTA sequence into the 2genome folder. You can download .fa.gz files from UCSC. This is the index.file parm, and often the ref.genome parm as well.
	https://hgdownload.soe.ucsc.edu/downloads.html

*If the reference genomes are not from the hg19, hg38, mm9, or mm10 builds (e.g. E. coli), then you must also import a GTF annotation file into the "3annotations" folder. Files from NCBI are downloaded as compressed .tar files and must be unzipped with 7zip. Name this file the same as your "ref.genome" input in the parms file. However, differential expression analysis will not run to completion for alternative  genomes.
	https://www.ncbi.nlm.nih.gov/assembly

5) Record sample metadata and configure design matrix

6) Configure parms

RUN THE PROGRAM (see video ):

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

EXAMPLE FASTQ SEQUENCE ACCESSION #S TO START:
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

#The raw (un-indexed) sequence of your chosen genome, the .fa.gz file from UCSC or .fta file from NCBI. Used to build the index for alignment.
index.file: chr1_mm10

#Set TRUE if FASTQ sequences are paired-end
paired.end.status: FALSE

#The name of the genome that will be used to count RNA reads from your alignments, the .gtf file from NCBI. 
  #Mouse (mm9/mm10) and human (hg19/hg38) genome assemblies are built-in. Other annotations (.gtf files) must de downloaded seperately.
ref.genome: mm10

#Set TRUE if using existing feature counts data (re-analyzing raw count data)
use.existing.counts: FALSE

#This specifies the groups to compare. This must be the same as the name of the 2nd column in your design matrix.
interest.group: typeluminal

#The minimum number of raw counts per million a gene must be associated with for it to be included in analysis.
thresh.value: 6

#The minimum number of samples across which the thresh.value must be met for a gene to be included in analysis.
sample.value: 2 

*The index.file and ref.genome inputs can be different because the index for alignment doesn't need to encompass an entire genome. In this case, the index will only be built for chromosome 1 of the mm10 mouse genome (index.file) and sequences will only be aligned to chromosome 1. Then, these alignments will be compared to all known genes in the mm10 genome to count RNA reads (ref.genome). However, index.file and ref.genome will often be the same.

------------------------------------------------------------

ANNOTATED DESIGN MATRIX

#The matrix tells R which groups to compare and can be interpreted in conjunction with known metadata. Each row corresponds to a sample. In this case, samples 1 and 2 are basal cells, while samples 3 and 4 are luminal cells. This matrix would compare gene expression between basal and luminal cells.

Intercept	typeluminal
1		0
1		0
1		1
1		1


------------------------------------------------------------

CITE THIS WORKFLOW:
Jake Egelberg. (2021). Jake1Egelberg/DEAR: DEAR: Differential Expression Analysis in R v1.0.8 (v1.0.8). Zenodo. https://doi.org/10.5281/zenodo.5207146
