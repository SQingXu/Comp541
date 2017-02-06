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
ExecStep $xv_path/bin/xelab -wto f70c54aa73664ec0928f67dc95c94838 -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot CounterMod7Enable_test_behav xil_defaultlib.CounterMod7Enable_test xil_defaultlib.glbl -log elaborate.log
