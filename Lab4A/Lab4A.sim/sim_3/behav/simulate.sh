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
ExecStep $xv_path/bin/xsim CounterMod7Enable_test_behav -key {Behavioral:sim_3:Functional:CounterMod7Enable_test} -tclbatch CounterMod7Enable_test.tcl -log simulate.log
