#######################################################
#                                                     #
#  Encounter Command Logging File                     #
#  Created on Wed Apr 23 23:05:38 2014                #
#                                                     #
#######################################################

#@(#)CDS: Encounter v11.12-s136_1 (64bit) 09/24/2012 19:26 (Linux 2.6)
#@(#)CDS: NanoRoute v11.12-s009 NR120919-1551/11_10_USR2-UB (database version 2.30, 165.4.1) {superthreading v1.16}
#@(#)CDS: CeltIC v11.12-s025_1 (64bit) 09/20/2012 05:47:24 (Linux 2.6.18-194.el5)
#@(#)CDS: AAE 11.12-s002 (64bit) 09/24/2012 (Linux 2.6.18-194.el5)
#@(#)CDS: CTE 11.12-s098_1 (64bit) Sep 12 2012 04:29:44 (Linux 2.6.18-194.el5)
#@(#)CDS: CPE v11.12-s026
#@(#)CDS: IQRC/TQRC 11.1.1-s334 (64bit) Sun May  6 19:52:51 PDT 2012 (Linux 2.6.18-194.el5)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
win
set init_verilog ./s35932/s35932_netlist_synopsys.v
set init_top_cell float_multiply
set init_design_netlisttype Verilog
set init_design_settop 1
set init_lef_file {/opt/software/cadence/library/fsd0a_90nm_generic_core/lef/header8m026_V55.lef /opt/software/cadence/library/fsd0a_90nm_generic_core/lef/fsd0a_a_generic_core.lef}
set delaycal_use_default_delay_limit 1000
set delaycal_default_net_delay 1000.0ps
set delaycal_default_net_load 0.5pf
set delaycal_input_transition_delay 120.0ps
set extract_shrink_factor 1.0
setLibraryUnit -time 1ns
setLibraryUnit -cap 1pf
set init_pwr_net VCC
set init_gnd_net GND
set init_assign_buffer 0
set init_mmmc_file viewDefinition.tcl
init_design
timeDesign -preplace -outDir preplaceTimingReports
set delaycal_use_default_delay_limit 1000
setPlaceMode -modulePlan false
placeDesign
checkPlace
saveDesign ./outputDir/s35932.placed.enc
defOut -placement -routing -floorplan -netlist ./outputDir/placed.def
win
timeDesign -preCTS -outDir prectsTimingReports
deleteTrialRoute
restoreDesign s35932.placed.enc.dat float_multiply
optDesign -preCTS -outDir prectsTimingReports
clockDesign
timeDesign -postCTS -outDir postctstimingReports
optDesign -postCTS -outDir postctsOptTimngReports
globalRoute
setNanoRouteMode -routeWithTimingDriven true
detailRoute
timeDesign -postRoute -outDir postrouteTimingReports
optDesign -postRoute -outDir postrouteOptTimingReports
verifyGeometry
verifyConnectivity
