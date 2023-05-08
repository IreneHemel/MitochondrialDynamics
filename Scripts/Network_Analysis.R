# Tested with 
# Cytoscape version 3.7.1 and 3.9.1
# stringApp version 1.5.0
# R version 3.6.0 and 4.1.3
# RCy3 version 2.4.0

if(!"RCy3" %in% installed.packages()){
  install.packages("BiocManager")
  BiocManager::install("RCy3")
}
if(!"igraph" %in% installed.packages()){
  install.packages("BiocManager")
  BiocManager::install("igraph")
}
if(!"rstudioapi" %in% installed.packages()){
  install.packages("BiocManager")
  BiocManager::install("rstudioapi")
}

library(RCy3)
library(igraph)
library(rstudioapi)

cytoscapePing()

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#Create network
genes <- "FIS1, STOML2, FAM73B, FAM73A, MTFP1, MIEF2, PLD6, MIEF1, MFF, GDAP1, DNM2, OPA1, MSTO1, MFN1, MFN2, MTFR1, DNM1L, SLC25A46" 
value <- "0.5"
l <- "100"

# load visual style from file
vizstyle.file <- file.path(getwd(), "Dynamics.xml")
LoadStyle.cmd = paste('vizmap load file file="',vizstyle.file,'"', sep="")
commandsRun(LoadStyle.cmd)

string.cmd = paste('string protein query query=\"',genes,'\" cutoff=\"',value,'\" species="Homo sapiens" limit="0" newNetName=\"STRING',l,'_',value,'\"', sep='')
commandsRun(string.cmd)
string2.cmd <- paste('string expand additionalNodes=\"',l,'\" network=\"CURRENT\"')
commandsRun(string2.cmd)

deleteTableColumn(column = 'stringdb::structures', table='node')
deleteTableColumn(column = 'stringdb::sequence', table='node')
deleteTableColumn(column = 'stringdb::enhancedLabel Passthrough', table='node')
deleteTableColumn(column = 'stringdb::STRING style', table='node')

# apply visual style ()
setVisualStyle('Dynamics')

#Select input nodes
clearSelection()
selectNodes(c('FIS1', 'STOML2', 'FAM73B', 'FAM73A', 'MTFP1', 'MIEF2', 'PLD6', 'MIEF1', 'MFF', 'GDAP1', 'DNM2', 'OPA1', 'MSTO1', 'MFN1', 'MFN2', 'MTFR1', 'DNM1L', 'SLC25A46'), by.col='query term')

Input <- getSelectedNodes()
setNodeShapeBypass(Input,'diamond')

# heat propagation
diffusionBasic()
clearSelection()
setNodeColorMapping("diffusion_output_heat", c(0,0.5), c('#FFFFFF', '#FF0000'), style.name = "Dynamics")
assign(paste("data_",l,'_',value, sep = ""), getTableColumns('node', c('display name', 'diffusion_output_heat', 'diffusion_output_rank')))
