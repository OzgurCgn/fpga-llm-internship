# Verification matrix

- **C++ kernel tests:** automatically compiled and run on GitHub-hosted Linux in the CI workflow.
- **RTL simulation:** Icarus Verilog simulates ready/valid traffic and saves stream_source.vcd to CI artifacts.
- **Open-source RTL synthesis:** Yosys reports generic mapped cells for the streaming controller, not a Xilinx FPGA utilization estimate.
- **AMD Vitis HLS / Vivado:** scripts are only preparation material. No IP implementation, device timing, physical FPGA runtime, or LUT/DSP/BRAM conclusions may be claimed without a real vendor-tool run.
- **Swan model inference:** independent test kernels do not constitute an end-to-end Swan 15M checkpoint run.

Inspect Actions > CPU and RTL verification > latest successful run > Artifacts to download logs and the VCD waveform. Preserve the run ID, commit SHA, and timestamp when using generated evidence in an academic report.
