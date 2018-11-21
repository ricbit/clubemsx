mkdir -p solution
cp $1 solution/SOL.BAS
openmsx -machine Sharp_HotBit_1.1 -ext DDX_3.0  -diska solution -script measure.tcl
