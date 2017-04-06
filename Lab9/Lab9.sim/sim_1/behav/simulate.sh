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
ExecStep $xv_path/bin/xsim mips_test_sqr_behav -key {Behavioral:sim_1:Functional:mips_test_sqr} -tclbatch mips_test_sqr.tcl -log simulate.log
