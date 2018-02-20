source ('functions.r')
#Main code
file_list <- list.files(path = file_path, pattern = file_pattern) #lists all files that match the file pattern
file_list_with_path <- paste0(file_path, file_list) #adds the path before each of the file name
for (file in file_list_with_path){
  upregDownregGeneList <- upreg_downreg_gene(file)
}

