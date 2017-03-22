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
set_property webtalk.parent_dir /home/siqingxu/Desktop/Comp541/Comp541/Lab7/Lab7.cache/wt [current_project]
set_property parent.project_path /home/siqingxu/Desktop/Comp541/Comp541/Lab7/Lab7.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo /home/siqingxu/Desktop/Comp541/Comp541/Lab7/Lab7.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib -sv {
  /home/siqingxu/Desktop/Comp541/Comp541/Lab7/Lab7.srcs/sources_1/new/sounds.sv
  /home/siqingxu/Desktop/Comp541/Comp541/Lab7/Lab7.srcs/sources_1/imports/sources/accelerometer.sv
  /home/siqingxu/Desktop/Comp541/Comp541/Lab7/Lab7.srcs/sources_1/new/keyboard.sv
  /home/siqingxu/Desktop/Comp541/Comp541/Lab7/Lab7.srcs/sources_1/new/io_demo.sv
}
read_vhdl -library xil_defaultlib {
  /home/siqingxu/Desktop/Comp541/Comp541/Lab7/Lab7.srcs/sources_1/imports/sources/SPI_If.vhd
  /home/siqingxu/Desktop/Comp541/Comp541/Lab7/Lab7.srcs/sources_1/imports/sources/ADXL362Ctrl.vhd
  /home/siqingxu/Desktop/Comp541/Comp541/Lab7/Lab7.srcs/sources_1/imports/sources/AccelArithmetics.vhd
  /home/siqingxu/Desktop/Comp541/Comp541/Lab7/Lab7.srcs/sources_1/imports/sources/AccelerometerCtl.vhd
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/siqingxu/Desktop/Comp541/Comp541/Lab7/Lab7.srcs/constrs_1/new/keyboard.xdc
set_property used_in_implementation false [get_files /home/siqingxu/Desktop/Comp541/Comp541/Lab7/Lab7.srcs/constrs_1/new/keyboard.xdc]

read_xdc /home/siqingxu/Desktop/Comp541/Comp541/Lab7/Lab7.srcs/constrs_1/new/sounds.xdc
set_property used_in_implementation false [get_files /home/siqingxu/Desktop/Comp541/Comp541/Lab7/Lab7.srcs/constrs_1/new/sounds.xdc]

read_xdc /home/siqingxu/Desktop/Comp541/Comp541/Lab7/Lab7.srcs/constrs_1/new/soundaccel.xdc
set_property used_in_implementation false [get_files /home/siqingxu/Desktop/Comp541/Comp541/Lab7/Lab7.srcs/constrs_1/new/soundaccel.xdc]

read_xdc /home/siqingxu/Desktop/Comp541/Comp541/Lab7/Lab7.srcs/constrs_1/new/iodemo.xdc
set_property used_in_implementation false [get_files /home/siqingxu/Desktop/Comp541/Comp541/Lab7/Lab7.srcs/constrs_1/new/iodemo.xdc]


synth_design -top io_demo -part xc7a100tcsg324-1


write_checkpoint -force -noxdef io_demo.dcp

catch { report_utilization -file io_demo_utilization_synth.rpt -pb io_demo_utilization_synth.pb }
