# -Feral-swine-selective-sweep-pipeline
A pipeline to perform analyses provided in Barmentlo et al., 2023

The pipeline generates population structure measurements, and markers and regions under selection. The pipeline is written for wildlife purposes and used on 60k SNP data. Note that especially the sweep analyses might not be appropriate with a different number of SNPs. Please assess the flowchart "Flowchart_selective_sweep" for the order in which the scripts should be used and "Description_file_types.txt" for some file descriptions. The code was used to generate the results from doi: (Not published yet, please email me if you're interested in the manuscript, n.w.g.barmentlo@vu.nl). I tried writing the pipeline and scripts in such a manner that e.g. an ecologist could use it without too much prior knowledge of genomic bioinformatics. Though this was very difficult, so if you have any questions, do not hesitate to contact me. 


## Installation
- R: https://www.r-project.org/
- Rstudio: https://www.rstudio.com/categories/rstudio-ide/
- PLINK: https://www.cog-genomics.org/plink/
- SHAPEIT: https://mathgen.stats.ox.ac.uk/genetics_software/shapeit/shapeit.html
- BEAGLE: http://faculty.washington.edu/browning/beagle/beagle.html
- Refined IBD: https://faculty.washington.edu/browning/refined-ibd.html
- ADMIXTURE: https://doi.org/10.1101/gr.094052.109
- bcftools: https://samtools.github.io/bcftools/bcftools.html
- ubuntu (these softwares all require a bash command line): https://help.ubuntu.com/


### R & Rstudio
Download R from https://www.r-project.org/. R is a standalone language, but for scripting purposes, downloading Rstudio is highly recommended (https://www.rstudio.com/categories/rstudio-ide/).


### PLINK 
PLink is a software to quickly filter and analyse genotype data e.g. SNP data. Download Plink from https://www.cog-genomics.org/plink/ and unzip the downloaded folder. Plink is run from the commandline (e.g. Bash). To check whether the download was succesful, run:

```plink -version``` or alternatively ```./plink -version```


### SHAPEIT
Shapeit is a software that 'phases' genotype data to generate haplotypes. Download Plink from https://mathgen.stats.ox.ac.uk/genetics_software/shapeit/shapeit.html#download. Unzip the folder with:
```tar -zxvf shapeit.v2.r900.glibcv2.17.linux.tar.gz```

### BEAGLE & Refined IBD
Similar to Shapeit, Beagle, in combination with Refined IBD, also phases genotype data. However, Beagle allows assessing whether haplotypes are derived from the same ancestor haplotype. Download Beagle from https://faculty.washington.edu/browning/beagle/beagle.html. Beagle is dependent on java. To check whether the download was succesful, run for example:
```java -Xmx32768m -jar beagle.21Apr21.304.jar```

Download Refined IBD from https://faculty.washington.edu/browning/refined-ibd.html. Refined IBD is dependent on both java and Beagle. To check whether the download was succesful, run for example:
```java -Xmx36409m -jar refined-ibd.17Jan20.102.jar```

### ADMIXTURE

Download ADMIXTURE from http://dalexander.github.io/admixture/download.html/.  
