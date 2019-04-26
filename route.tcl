 
#set the relevant paths
source env.tcl

#load placed design, library, design constraints
restoreDesign s35932.placed.enc.dat float_multiply


#Optimization
optdesign -preCTS -outDir prectsTimingReports

#Clock Tree Synthesis
addCTSCellList {BUFCKX1 BUFCKX2 BUFCKX3}
clockDesign

#Timing Analysis and Optimization
timeDesign -postCTS -outDir postctstimingReports
optDesign -postCTS -outDir postctsOptTimngReports

#perform global routing
globalRoute
#win 
#fit

#perform detail routing

setNanoRouteMode -routeWithTimingDriven true
detailRoute

#globalDetailRoute
timeDesign -postRoute -outDir postrouteTimingReports
optDesign -postRoute -outDir postrouteOptTimingReports

#Verification
verifyGeometry
verifyConnectivity

#exit

