# Project name

Differential gene analysis(DGA) of GSE31102 using Limma

##  Environment 

- OS: Ubuntu
- R 3.4.1

## Objective: 
To carry out differential gene analysis on experimental samples using Limma in order to better understand which genes have been upregulated or downregulated due to treatment or disease when compared to the control group (untreated or healthy samples).

## Project description
- The GEO Omnibus Series (GSE31102), that was used, was taken from "https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE31102"
- The type of information present is microarray data and therefore, R's Limma package was used for differential gene analysis.
- Expression of insulin can be largely attributed to pancreatic beta cells although a small amount can be expressed by other tissues such as the thymus and the brain.
- A small molecule GW8510, which is a CDK2 inhibitor, was found to sercve as an inducer of insulin in pancreatic alpha cells through p53 in a JNK and p38 dependent manner. 
- This could prove invaluable in people suffering from type-1 Diabetes where the ability of pancreatic beta cells to produce insulin is compromised.
- GSE31102 contains 12 samples; aTC1 denotes mice pancreatic alpha cells and bTC3 denotes mice pancreatic beta cells. <br>
The information for each sample is as follows: <br>

| Sample | Treatment |
|--------| :-------: |
| aTC1 rep1 | dmso |
| aTC1 rep2 | dmso |
| aTC1 rep3 | dmso |
| aTC1 rep1 | GW8510 |
| aTC1 rep2 | GW8510 |
| aTC1 rep3 | GW8510 |
| bTC3 rep1 | dmso |
| bTC3 rep2 | dmso |
| bTC3 rep3 | dmso |
| bTC3 rep1 | GW8510 |
| bTC3 rep2 | GW8510 |
| bTC3 rep3 | GW8510 |


## Libraries needed: 
1. GEOquery <br>
To install, type in command line: <br>
````
sudo apt-get install libxml2-dev
sudo apt-get install libcurl4-openssl-dev
````
Type in R: <br>
````
source("http://bioconductor.org/biocLite.R")
biocLite("GEOquery")
````
2. affy <br>
To install, type in R: <br>
````
source("https://bioconductor.org/biocLite.R")
biocLite("affy")
````
3. limma <br>
To install, type in R: <br>
````
source("https://bioconductor.org/biocLite.R")
biocLite("limma")
````

## Files available: 
1. main.py - contains a detailed walkthrough of differential gene analysis with Limma using the GEO series (GSE31102).


## Details: 
- There are a few steps to follow in order to perform differential gene analysis. 
1. The first step is to create an ExpressionSet object within Limma. In order to do this, we need the assayDaya as a dataframe, and the phenoData and featureData as annotated dataframes. 
   1. AssayData: <br>
   Download the raw data(usually a tar extension of CEL files) using GEOquery and extract it to form an affyBatch object using affy. This object is then subject to the RMA normalization method to form expressionset(es) object. The assaydata in es should have Affymetrix Probe set IDs as rows and samples as columns and should look like this: <br>
   ![1 ad](https://user-images.githubusercontent.com/35882413/36443595-37bc8c92-1647-11e8-9c21-8a43b6ca3cd2.png)

   2. PhenoData: <br>
   PhenoData is additional information concerning the samples. This can be extracted from the GEO series matrix file using GEOquery and should always have the column names in AssayData as it's rownames. Once relevant columns have been selected, the phenoData should look like this: <br>
   ![2 pd](https://user-images.githubusercontent.com/35882413/36443596-37dde2de-1647-11e8-96e1-dbab49719047.png)

   3. FeatureData: <br>
   FeatureData is additional information regarding the genes and can be extracted in a similar fashion to phenoData using GEOquery and the GEO series matrix file. For instance, the gene symbols for each Affymetrix Probe set ID can be extracted to look like this: <br>
   ![3 fd](https://user-images.githubusercontent.com/35882413/36443597-37ee26da-1647-11e8-84c1-a9d633c489db.png)

   4. Once the phenoData and featureData have been added to the es object from point 1, the es object should look like this: <br>
   ![4 es](https://user-images.githubusercontent.com/35882413/36443598-3803a0f0-1647-11e8-8481-55f22ffcf8c1.png)

2. Subset data that we wish to use for our analysis. In this case, we would like to only focus on comparing the treated alpha cells to untreated ones and so, we subset for alpha cells from the phenoData column cellType. <br>
```` new_es <- es[,es$cellType == 'cell line: aTC1'] ````

3. Create a design matrix where each sample is classified to be under pre-defined factored treatment types (eg. 'control'/ 'GW8510_cpd'). The row names reflect the sample while columns reflects each unique treatment type. A design matrix looks like this: <br>
![5 design](https://user-images.githubusercontent.com/35882413/36443599-38153914-1647-11e8-81a6-4df9abe32c82.png)

4. Construct a contrast martrix by specifying the comparison groups we wish to analyze. 
```` contrast.matrix <- makeContrasts( GW8510_cpd-control, control-GW8510_cpd, levels= design) ````
Usually, the treatment group is compared to the control group (eg.  GW8510_cpd-control), but the reverse comparison has been added to illustrate coeff in the following steps.  A contrast matrix looks like this: <br>
![6 contrast](https://user-images.githubusercontent.com/35882413/36443600-3825f6aa-1647-11e8-981e-adcae5480822.png)

5. Run the differential gene analysis.

6. View the results using topTable. 
- Coef refers to the makeContrasts group (coef = 1 refers to first defined comparison). logFC shows the log fold change of treatment gene vs control gene (for coef = 1). 
- AveEprs shows the average log2 expression across all all arrays/channels.
- t shows the moderated t statistic.
- F stands for the moderated F statistic.
- p values are denoted by P.Value while adjusted p values are denoted by adj.P.Value.
- Lastly, B stands for log odd that the gene is differentially expressed.
- All information was taken from "https://www.rdocumentation.org/packages/limma/versions/3.28.14/topics/toptable"
- Results can be ordered using the columns above and thresholds can be set on logFC/P.Value/adj.P.Value
The results look like this: <br>
![7 results](https://user-images.githubusercontent.com/35882413/36443601-383ae074-1647-11e8-9e43-10a512b81a98.png)

## How to run? :
- Run main.py file. This file is not automated so please change relevant fields accordingly for your GEO series.
