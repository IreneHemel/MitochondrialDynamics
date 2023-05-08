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

name <- c('FIS1', 'STOML2', 'FAM73B', 'FAM73A', 'MTFP1', 'MIEF2', 'PLD6', 'MIEF1', 'MFF', 'GDAP1', 'DNM2', 'OPA1', 'MSTO1', 'MFN1', 'MFN2', 'MTFR1', 'DNM1L', 'SLC25A46')
genes <- c("STOML2, FAM73B, FAM73A, MTFP1, MIEF2, PLD6, MIEF1, MFF, GDAP1, DNM2, OPA1, MSTO1, MFN1, MFN2, MTFR1, DNM1L, SLC25A46",
           "FIS1, FAM73B, FAM73A, MTFP1, MIEF2, PLD6, MIEF1, MFF, GDAP1, DNM2, OPA1, MSTO1, MFN1, MFN2, MTFR1, DNM1L, SLC25A46",
           "FIS1, STOML2, FAM73A, MTFP1, MIEF2, PLD6, MIEF1, MFF, GDAP1, DNM2, OPA1, MSTO1, MFN1, MFN2, MTFR1, DNM1L, SLC25A46",
           "FIS1, STOML2, FAM73B, MTFP1, MIEF2, PLD6, MIEF1, MFF, GDAP1, DNM2, OPA1, MSTO1, MFN1, MFN2, MTFR1, DNM1L, SLC25A46",
           "FIS1, STOML2, FAM73B, FAM73A, MIEF2, PLD6, MIEF1, MFF, GDAP1, DNM2, OPA1, MSTO1, MFN1, MFN2, MTFR1, DNM1L, SLC25A46",
           "FIS1, STOML2, FAM73B, FAM73A, MTFP1, PLD6, MIEF1, MFF, GDAP1, DNM2, OPA1, MSTO1, MFN1, MFN2, MTFR1, DNM1L, SLC25A46",
           "FIS1, STOML2, FAM73B, FAM73A, MTFP1, MIEF2, MIEF1, MFF, GDAP1, DNM2, OPA1, MSTO1, MFN1, MFN2, MTFR1, DNM1L, SLC25A46",
           "FIS1, STOML2, FAM73B, FAM73A, MTFP1, MIEF2, PLD6, MFF, GDAP1, DNM2, OPA1, MSTO1, MFN1, MFN2, MTFR1, DNM1L, SLC25A46",
           "FIS1, STOML2, FAM73B, FAM73A, MTFP1, MIEF2, PLD6, MIEF1, GDAP1, DNM2, OPA1, MSTO1, MFN1, MFN2, MTFR1, DNM1L, SLC25A46",
           "FIS1, STOML2, FAM73B, FAM73A, MTFP1, MIEF2, PLD6, MIEF1, MFF, DNM2, OPA1, MSTO1, MFN1, MFN2, MTFR1, DNM1L, SLC25A46",
           "FIS1, STOML2, FAM73B, FAM73A, MTFP1, MIEF2, PLD6, MIEF1, MFF, GDAP1, OPA1, MSTO1, MFN1, MFN2, MTFR1, DNM1L, SLC25A46",
           "FIS1, STOML2, FAM73B, FAM73A, MTFP1, MIEF2, PLD6, MIEF1, MFF, GDAP1, DNM2, MSTO1, MFN1, MFN2, MTFR1, DNM1L, SLC25A46",
           "FIS1, STOML2, FAM73B, FAM73A, MTFP1, MIEF2, PLD6, MIEF1, MFF, GDAP1, DNM2, OPA1, MFN1, MFN2, MTFR1, DNM1L, SLC25A46",
           "FIS1, STOML2, FAM73B, FAM73A, MTFP1, MIEF2, PLD6, MIEF1, MFF, GDAP1, DNM2, OPA1, MSTO1, MFN2, MTFR1, DNM1L, SLC25A46",
           "FIS1, STOML2, FAM73B, FAM73A, MTFP1, MIEF2, PLD6, MIEF1, MFF, GDAP1, DNM2, OPA1, MSTO1, MFN1, MTFR1, DNM1L, SLC25A46",
           "FIS1, STOML2, FAM73B, FAM73A, MTFP1, MIEF2, PLD6, MIEF1, MFF, GDAP1, DNM2, OPA1, MSTO1, MFN1, MFN2, DNM1L, SLC25A46",
           "FIS1, STOML2, FAM73B, FAM73A, MTFP1, MIEF2, PLD6, MIEF1, MFF, GDAP1, DNM2, OPA1, MSTO1, MFN1, MFN2, MTFR1, SLC25A46",
           "FIS1, STOML2, FAM73B, FAM73A, MTFP1, MIEF2, PLD6, MIEF1, MFF, GDAP1, DNM2, OPA1, MSTO1, MFN1, MFN2, MTFR1, DNM1L")
  
cutoffs <- "0.5"
l <- "100"
n <- 0

# load visual style from file
vizstyle.file <- file.path(getwd(), "Dynamics.xml")
LoadStyle.cmd = paste('vizmap load file file="',vizstyle.file,'"', sep="")
commandsRun(LoadStyle.cmd)


    for(g in genes) {
      n <- n+1
    string.cmd = paste('string protein query query=\"',g,'\" cutoff=\"',cutoffs,'\" species="Homo sapiens" limit= "0" newNetName=\"STRING',n,'\"', sep='')
    commandsRun(string.cmd)
    string2.cmd <- paste('string expand additionalNodes=\"',l,'\" network=\"CURRENT\"')
    commandsRun(string2.cmd)
    assign(paste("data_",n, sep = ""), getTableColumns('node', 'display name'))
    
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
    }

data_total <- cbind(data_1, data_2, data_3, data_4, data_5, data_6, data_7, data_8, data_9, data_10, data_11, data_12, data_13, data_14, data_15, data_16, data_17, data_18)

write.table(data_total, "leaveE_100_0.5.txt", sep="\t")