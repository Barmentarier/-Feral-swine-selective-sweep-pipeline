# -Feral-swine-selective-sweep-pipeline
A pipeline to perform analyses provided in Barmentlo et al., 2023

The pipeline generates population structure measurements, and markers and regions under selection. The pipeline is written for wildlife purposes and used on 60k SNP data. Note that especially the sweep analyses might not be appropriate with a different number of SNPs. Please assess the flowchart "Flowchart_selective_sweep" for the order of the scripts. The code was used to generate the results from doi: (Not published yet, please email me if you're interested in the manuscript, n.w.g.barmentlo@vu.nl). I tried writing the pipeline and scripts in such a manner that e.g. an ecologist could use it without too much prior knowledge. Though this was very difficult, so if you have any questions, do not hesitate to contact me. 

Please note that I did not include all scripts used as many were used on multiple populations. Additionally, there were quite a few scripts used to clean the data. I refer the reader to the publication to fully recreate this study. Additionally, I did not describe in detail the code for the software other than R. Please check the documentation for:
- PLINK: https://www.cog-genomics.org/plink/
- SHAPEIT: https://mathgen.stats.ox.ac.uk/genetics_software/shapeit/shapeit.html
- BEAGLE: http://faculty.washington.edu/browning/beagle/beagle.html
- Refined IBD: https://faculty.washington.edu/browning/refined-ibd.html
- ADMIXTURE: https://doi.org/10.1101/gr.094052.109
- bcftools: https://samtools.github.io/bcftools/bcftools.html
- ubuntu (these softwares all require a bash command line): https://help.ubuntu.com/

Populations/clusters used:
- GRSM
- k16: Western Heritage (this is a genetic cluster)
- k17: European wild    (this is a genetic cluster)
- k15: Asian            (this is a genetic cluster)
- NC: North Carolina
- SC: South Carolina
- TN: Tennessee
- WV: West Virginia
