# Project name

Plotting a volcano plot based on DGA results

##  Environment 

- OS: Ubuntu
- R 3.4.1

## Objective: 
To plot a volcano plot that highlights genes that are significantly differentially expressed and to label the top 20 most up-regulated and top 20 most down-regulated genes.

## Libraries needed: 
1. ggplot <br>
To install: <br>
```` install.packages("ggplot2") ````
2. ggrepel: <br>
To install:
```` install.packages('ggrepel') ````

## Files available: 
1. config.r- contains input fields 
2. functions.r - contains several helper functions
3. main.r - contains main code which uses the helper functions 

## Details: 
- This file generates a volcano plot: each dot represents a gene, the y axis represents -log(P.Value) and the x axis represents logFC values. 
- Genes which are significantly differentially expressed are marked in red; they were chosen using a adj.P.Value (adjusted p value) threshold value of 0.05.
- The top 20 up-regulated and top 20 down-regulated genes have been labeled using ggrepel.
- The volcano plot looks like this: <br>
![a-control_volcano_plot](https://user-images.githubusercontent.com/35882413/36443921-2048f18a-1648-11e8-9ba0-1fbe06c01e61.png)

## How to run? :
- Change required input fields in the config.r file and set relevant paths. 
- Run main.r file. 
