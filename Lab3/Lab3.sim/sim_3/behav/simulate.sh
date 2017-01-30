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
ExecStep $xv_path/bin/xsim Lab3_test1_behav -key {Behavioral:sim_3:Functional:Lab3_test1} -tclbatch Lab3_test1.tcl -log simulate.log
