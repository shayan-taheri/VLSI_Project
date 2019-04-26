create_constraint_mode -name mode -sdc_files ./s35932/s35932.sdc
create_rc_corner -name rcTyp
update_rc_corner -name rcTyp -preRoute_cap 1
update_rc_corner -name rcTyp -preRoute_res 1
update_rc_corner -name rcTyp -preRoute_clkcap 0.0
update_rc_corner -name rcTyp -preRoute_clkres 0.0
update_rc_corner -name rcTyp -postRoute_cap 1
update_rc_corner -name rcTyp -postRoute_res 1
update_rc_corner -name rcTyp -postRoute_xcap 1
update_rc_corner -name rcTyp -postRoute_clkcap 0.0
update_rc_corner -name rcTyp -postRoute_clkres 0.0
create_library_set -name typLib -timing "/opt/software/cadence/library/fsd0a_90nm_generic_core/timing/fsd0a_a_generic_core_tt1v25c.lib"
create_delay_corner -name typDC -library_set typLib -rc_corner rcTyp
create_analysis_view -name typView -constraint_mode mode -delay_corner typDC
set_analysis_view -setup {typView} -hold {typView}
