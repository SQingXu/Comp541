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
ExecStep $xv_path/bin/xsim xycounter_test_behav -key {Behavioral:sim_4:Functional:xycounter_test} -tclbatch xycounter_test.tcl -log simulate.log
