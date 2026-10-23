module tb_dot4;
reg clk=0;always #5 clk=~clk;
reg rst_n=0,start=0;
reg signed[7:0] a0=2,a1=-3,a2=4,a3=5,b0=3,b1=7,b2=-2,b3=1;
wire signed [18:0] result;wire done;
dot4_serial dut(.*);
initial begin
$dumpfile("dot4.vcd");$dumpvars(0,tb_dot4);
repeat(2) @(negedge clk);rst_n=1;start=1;
repeat(2) @(negedge clk);start=0;
wait(done);@(negedge clk);
if(result !== -18) $fatal(1,"dot4 result mismatch %0d",result);
$display("PASS dot4 signed serial MAC result=%0d",result);$finish;
end
endmodule
