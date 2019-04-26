#set the relevant paths
source env.tcl

# set the basename for the config and floorplan files. 
set basename s35932


#load/import design and constraints and library
#loadConfig $designDir/$basename.conf 1
source $designDir/$basename.global
init_design

# For now we will not use a floorplan specification. Hence, 
# the tool will itself determine the die size based on the design read. 
##loadFPlan "$designDir/s35932.fp"
#loadFPlan "$designDir/s35932.fp.spr"

#Timing Ananlysis preplacement
timeDesign -preplace -outDir preplaceTimingReports

#Set the placement options

#Part 2: Uncomment the following for 2nd part of the problem
#setPlaceMode -cutSequence VVVHHH -timingdriven true

#Part 3: Uncomment the following for 3rd part of problem
#setPlaceMode -cutSequence HHHVVV -timingdriven true

#Place the standard cells
set delaycal_use_default_delay_limit 1000
setPlaceMode -modulePlan false
placeDesign

#Verification
checkPlace

#save placed design
saveDesign $outDir/$basename.placed.enc
defOut -placement -routing -floorplan -netlist $outDir/placed.def

#win commnad is used to view the final design in the GUI mode
win

#report bounding box net length
reportNetLen

#perform timing analysis. Check detail report in timingReports/s35932_bench_preCTS_all.tarpt
timeDesign -preCTS -outDir prectsTimingReports


deleteTrialRoute

##exit
