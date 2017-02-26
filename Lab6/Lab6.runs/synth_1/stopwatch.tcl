# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/siqingxu/Desktop/Comp541/Comp541/Lab6/Lab6.cache/wt [current_project]
set_property parent.project_path /home/siqingxu/Desktop/Comp541/Comp541/Lab6/Lab6.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo /home/siqingxu/Desktop/Comp541/Comp541/Lab6/Lab6.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib -sv {
  /home/siqingxu/Desktop/Comp541/Comp541/Lab6/Lab6.srcs/sources_1/imports/new/hexto7seg.sv
  /home/siqingxu/Desktop/Comp541/Comp541/Lab6/Lab6.srcs/sources_1/new/updowncounter.sv
  /home/siqingxu/Desktop/Comp541/Comp541/Lab6/Lab6.srcs/sources_1/new/fsm.sv
  /home/siqingxu/Desktop/Comp541/Comp541/Lab6/Lab6.srcs/sources_1/new/display8digit.sv
  /home/siqingxu/Desktop/Comp541/Comp541/Lab6/Lab6.srcs/sources_1/new/debouncer.sv
  /home/siqingxu/Desktop/Comp541/Comp541/Lab6/Lab6.srcs/sources_1/new/stopwatch.sv
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/siqingxu/Desktop/Comp541/Comp541/Lab6/Lab6.srcs/constrs_1/new/stopwatch.xdc
set_property used_in_implementation false [get_files /home/siqingxu/Desktop/Comp541/Comp541/Lab6/Lab6.srcs/constrs_1/new/stopwatch.xdc]


synth_design -top stopwatch -part xc7a100tcsg324-1


write_checkpoint -force -noxdef stopwatch.dcp

catch { report_utilization -file stopwatch_utilization_synth.rpt -pb stopwatch_utilization_synth.pb }
