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
ExecStep $xv_path/bin/xsim halfadder_test_behav -key {Behavioral:sim_1:Functional:halfadder_test} -tclbatch halfadder_test.tcl -log simulate.log
