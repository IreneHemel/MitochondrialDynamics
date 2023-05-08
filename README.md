# MitochondrialDynamics

A computational approach for the prediction of novel mitochondrial dynamics candidate proteins was designed based on interactions between proteins.

Several scripts were used to generate networks in Cytoscape:

 - NetworkSetting.R was used to create 16 networks for the selection of an optimal number of interaction and confidence score.
 - LeaveOneOut.R was used to generate networks, containing all but one query protein, to determine how often the left out protein was present in the network upon expansion with the selected number of interactions and confidence score.
 - Network_Analysis.R was used for the eventual analysis.

All additional files required to run the scripts are present in the files folder.
