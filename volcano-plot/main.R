source('functions.r')
#Main code
file_list <- list.files(path = file_path, pattern = file_pattern)
file_list_with_path <- paste0(file_path, file_list)
for (file in file_list_with_path){
  volcano_plot(file)
}



