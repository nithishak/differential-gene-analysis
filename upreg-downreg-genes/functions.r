source ('config.r')
#Generate a list of 20 most up-regulated and 20 most down-regulated genes 
upreg_downreg_gene <- function(file_name){
  #Read results file
  dge_results <- read.csv(file_name,sep =',', stringsAsFactors = FALSE, check.names = FALSE)
  
  #Remove NA values for gene names in column for gene symbols
  dge_results <- dge_results[!is.na(dge_results$Gene.Symbol),]
  
  
  #20 most up-regulated genes (treatment-ctrl LogFC is +ve)
  target <- 20
  target_reached<- FALSE
  while(!target_reached){
    upreg <- dge_results[1:target,]
    if (length(unique(upreg$Gene.Symbol)) < 20){
      target<- target + 1
    }
    else{
      target_reached <- TRUE
      upreg_n <- upreg[!duplicated(upreg$Gene.Symbol), c("Gene.Symbol", "logFC")]
      #print (upreg_n)
      upreg_n$regulation <- "upregulated genes"
      colnames(upreg_n) <- c("Genes", "LogFC", "Regulation")
    }
  }

  #20 most down-regulated genes (treatment-ctrl LogFC is -ve)
  rows <- nrow(dge_results)
  target = 19
  target_reached<- FALSE
  while(!target_reached){
    downreg <- dge_results[(rows-target):rows,]
    if (length(unique(downreg$Gene.Symbol)) < 20){
      target<- target + 1
    }
    else{
      target_reached <- TRUE
      downreg_n <- downreg[!duplicated(downreg$Gene.Symbol), c("Gene.Symbol", "logFC")]
      downreg_n$regulation <- "downregulated genes"
      colnames(downreg_n) <- c("Genes", "LogFC", "Regulation")
    }
  }
  
  gene_list <- rbind(upreg_n,downreg_n)
  save_file_name <- sub('.*/', '', file_name)
  save_file_name_modified <- sub('stringent', 'upreg_downreg', save_file_name)
  write.csv(gene_list, file = save_file_name_modified, row.names = FALSE)
  
}



