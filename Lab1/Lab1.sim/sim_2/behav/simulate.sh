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
ExecStep $xv_path/bin/xsim fullfadder_test_behav -key {Behavioral:sim_2:Functional:fullfadder_test} -tclbatch fullfadder_test.tcl -log simulate.log
