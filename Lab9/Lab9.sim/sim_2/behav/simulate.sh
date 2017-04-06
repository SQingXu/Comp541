#!/bin/bash -f
xv_path="/opt/Xilinx/Vivado/2016.4"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim mips_tester_full_behav -key {Behavioral:sim_2:Functional:mips_tester_full} -tclbatch mips_tester_full.tcl -log simulate.log
