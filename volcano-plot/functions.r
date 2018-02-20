source('config.r')
#Download necessary libraries
library(ggplot2)
library(ggrepel)

volcano_plot <- function(file_name){
  #Read results file from ./Results
  vp <- read.csv(file_name,sep =',', stringsAsFactors = FALSE, row.names = 1, check.names = FALSE)
  
  #This is to color code red for genes for which adj p value < 0.05 and grey for others.
  #Create a new column called "Significant" which labels "FDR<0.05" is adj p value is less than 0.05, and "Not Sig" is not.
  vp$Significant <- ifelse (vp$adj.P.Val<0.05, "FDR<0.05", "Not Sig")
  
  #This is to label top 20 upregulated and top 20 downregulated genes in the volcano plot.
  #Subset a new df that contains only sig genes based on adj p value.
  vp_sig <- subset(vp, adj.P.Val < 0.05)
  #Choose first 20 rows, based on logFC values, afinal contains sorted logFC values from largest to smallest logFC values.
  upreg <- vp_sig[1:20,]
  #Choose the last 20 rows, based on logFC values.
  rows<- nrow(vp_sig)
  target = 19
  downreg <- vp_sig[(rows-target):rows,]
  #Combine upreg and downreg genes into one df.
  sig_genes <- rbind(upreg,downreg)
 
  #Plot volcano plot
  volcanoPlot <- ggplot(vp, aes(logFC,-log10(P.Value), color= Significant)) +
    geom_point() +
    scale_color_manual(values = c("red","grey")) +
    theme_bw (base_size = 16) +
    geom_text_repel (data= sig_genes, aes(label= Gene.Symbol), size= 3, box.padding = 0.25, point.padding = 0.3, color = "black")
    
  print (volcanoPlot)
  image_name <- sub('.*/', '', file_name) #using file name, remove path in front of file name eg. 'path/file_name.csv' changed to 'file_name.csv'
  image_name_modified <- paste0(sub('.csv', '' , image_name), '.png') # replace .csv from image_name to '.png' eg. 'file_name.csv' to 'file_name.png'
  ggsave(image_name_modified, width =8, height = 6, dpi = 84)
  
}