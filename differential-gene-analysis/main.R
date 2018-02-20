#Download necessary libraries
library(GEOquery)
library(affy)
library(limma)

##Downloading raw data from GEO series
#Extract phenodata and featuredata and relevant columns
gse <- getGEO("GSE31102", GSEMatrix = TRUE) #extracts info from series matrix file
show(gse) #produces a list
#phenoData
phenoData <- pData(gse[[1]]) 
colnames(phenoData) #view column names to understand different types of data available in phenoData
pd_df <- phenoData[,c(1,6,9,10,11)] #choose relevant columns 
names(pd_df) <- c('treatment_rep','biologicalUnit', 'organism', 'cellType', 'treatment') #rename relevant columns
pd<- AnnotatedDataFrame(pd_df) #change pd from dataframe to annotated dataframe in order to create ExpressionSet object later on
#featureData
featureData <- fData(gse[[1]])
colnames(featureData) #view column names to understand different types of data available in featureData
fd_df <- featureData[,11, drop = FALSE] #choose relevant column, in this case, Gene Symbols 
fd<- AnnotatedDataFrame(fd_df) #change pd from dataframe to annotated dataframe in order to create ExpressionSet object later on

#Extract raw data
filePaths <- getGEOSuppFiles('GSE31102') #downloads raw data into a folder(named as GSE31102) created in the current directory
filePaths #shows downloaded tar files, EXTRACT MANUALLY to cel.gz files in the same directory
data<- ReadAffy(celfile.path='./GSE31102/') #AffyBatch object created, make sure correct path to CEL.gz files specified
sampleNames(data) <- sub('.CEL.gz', '', sampleNames(data)) #renaming sample names(which are assayData column names) to reflect rownames in phenoData

#Normalize raw data and create an ExpressionSet object
es<- rma(data) #Normalization process is carried out (rma method) and an ExpressionSet object is created
head(exprs(es)) #to view assayCounts

phenoData(es) <- pd #add phenoData to ExpressionSet object, can be viewed using pData(es)
featureData(es) <- fd #add featureData to ExpressionSet object, can be viewed using fData(es)

#subset es for only mouse alpha cells from phenoData cellType column
new_es <- es[,es$cellType == 'cell line: aTC1']

#design matrix
f <- factor(new_es$treatment, levels = c('compound: DMSO', 'compound: GW8510'))
design <- model.matrix(~0+f)
colnames(design) <- c('control', 'GW8510_cpd')
fit<- lmFit(new_es,design)

#contrast matrix and differential gene analysis
contrast.matrix <- makeContrasts( GW8510_cpd-control, control-GW8510_cpd, levels= design) #create different comparison groups
fit2 <- contrasts.fit(fit,contrast.matrix)
fit2 <- eBayes(fit2)

#View results for the comparison- GW8510_cpd-control (coef=1 in contrast.matrix)
a_ctrl<- topTable(fit2, coef=1, adjust='BH', sort.by='logFC', resort.by = 'logFC', p.value=0.05, number= Inf) #Sort results by logFc values(biggest to smallest, adjusted p value cutoff os 0.05 and we want to view all genes)
a_ctrl_volcano_plot <- topTable(fit2, coef=1, adjust='BH', sort.by='logFC', resort.by = 'logFC', number= Inf) # we want all genes regardless of adjusted p values to plot volcano plot
print (head(a_ctrl))

#write results to csv files
write.csv(a_ctrl, file = 'A-control_stringent.csv') #please save as filename_stringent.csv for future file manipulation
write.csv(a_ctrl_volcano_plot, file = 'A-control_volcano_plot.csv') #please save as filename_volcano_plot.csv for future file manipulation
