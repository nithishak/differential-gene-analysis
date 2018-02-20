# Project name
Differential gene analysis for microarray data using limma and visualization of analysis though volcano plots

## Environment
- OS: Ubuntu
- R : 3.4.1

## Dataset used
- This project is based on GEO Omnibus's GSE31102 Series. 
- In a nutshell, it was found that a kinase inhibitor GW8510, causes an upregulation of the human equivalent insulin gene(Ins2) in 
pancreatic alpha cells of mice. This could serve as an important therapeutic intervention for individuals suffering from type-1 diabetes where pancreatic beta cells are
unable to express adequate insulin. 
- Gene expression profiling was carried out on mouse alpha and beta cells that were subjected to treatment with either GW8510 or DMSO. There
were 3 biological replicates per condition.
- More details can be found in the README.md in the directory differential-gene-expression.

## Project description
- This project aims to illustrate, how differential gene analysis (dga) can be carried out, and the results analyzed through ggplot. It can
be broken down into 3 main parts.
1. DGA : <br>
To carry out the analysis using R packages such as limma/DESeq/edgeR. As the GSE series we have used contains microarray data, limma was chosen.
2. Finding out the most upregulated and downregulated genes for a particular comparison: <br>
For instance, if the comparison group was defined to be treated alpha cells relative to untreated alpha cells, it is possible to carry out DGA, order the genes according to logFCs, and to extract the top 20 most up-regulated and top 20 most down-regulated genes into a list.
3. Plotting a volcano plot: <br>
A volcano plot plots significance of a fold change (p value) against the logFC for a gene. This way, it is possible to visualize which genes have undergone significant changes upon treatment. For this volcano plot, genes that are deemed to be significantly differentially expressed (adjusted p value < 0.05) have been highlighed in red. Furthermore, the top 20 upregulated and top 20 downregulated genes have been labelled.

## Folders available
1. differential-gene-analysis
2. upreg-downreg-genes
3. volcano-plot

## How to run?
Run the main.py files in differential-gene-analysis, followed by upreg-downreg-genes and lastly, volcano-plot.
