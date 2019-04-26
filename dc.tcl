#set the correct paths
source env.tcl

#set the target library
set target_library "$libDir/fsd0a_90nm_generic_core/timing/fsd0a_a_generic_core_tt1v25c.db"
set link_library "* $target_library"

#compile
analyze -format verilog "$designDir/s35932.v"

#check
elaborate float_multiply -architecture verilog -library WORK

# specify the wire load model to be used by the synthesis engine for
# timing optimizations
set_wire_load_model -name G50K

# specify the area constraint for the design (note that in default mode)
# the timing constraint will have priority over the area constraints
set_max_area 60000

# create the clock for the design with the period 50 ns
create_clock clk -period 50 -name clk

# set the delay at the input and output ports relative to the clock.
set_input_delay 0 -max -clock clk [all_inputs]
set_output_delay 0 -max -clock clk [all_outputs]

dont_touch_network clk

#Check and compile the design
check_design > $outDir/check_design.txt
check_timing > $outDir/check_timing.txt

#create the unique instances
uniquify

# do the mapping now
compile -map_effort medium -ungroup_all
#compile_ultra

#Export netlist for post-synthesis simulation into synth_netlist.v
change_names -rules verilog -hierarchy
write -format verilog -hierarchy -output $designDir/s35932_netlist_synopsys.v
write_sdc $designDir/s35932.sdc

#Generate reports
report_area > $outDir/area_report.txt
report_timing > $outDir/timing_report.txt
report_power > $outDir/power_report.txt
report_constraint -all_violators > $outDir/violator_report.txt
report_register -level_sensitive > $outDir/latch_report.txt

exit
