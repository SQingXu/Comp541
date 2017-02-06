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
ExecStep $xv_path/bin/xsim CounterMod7_test_behav -key {Behavioral:sim_2:Functional:CounterMod7_test} -tclbatch CounterMod7_test.tcl -log simulate.log
