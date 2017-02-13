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
ExecStep $xv_path/bin/xsim displaydriver_10x4_test_behav -key {Behavioral:sim_2:Functional:displaydriver_10x4_test} -tclbatch displaydriver_10x4_test.tcl -log simulate.log
