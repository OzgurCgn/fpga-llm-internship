# Optional: execute only with a compatible AMD Vitis HLS installation.
open_project -reset matvec_accel
set_top matvec_tiled
add_files hls/kernels.cpp -cflags "-std=c++17"
add_files -tb tests/testbench.cpp -cflags "-std=c++17"
open_solution -reset solution1
set_part xc7z020clg400-1
create_clock -period 10
csim_design
csynth_design
# Enable after validating toolchain and simulator availability:
# cosim_design
# export_design -format ip_catalog
exit
