module tb_dot4_parallel;
reg signed [15:0] a0,a1,a2,a3,b0,b1,b2,b3;
wire signed [33:0] result;
integer i;
reg signed [33:0] expected;
dot4_parallel dut(.*);
task automatic check;
  begin
    expected = $signed(a0)*$signed(b0)+$signed(a1)*$signed(b1)+$signed(a2)*$signed(b2)+$signed(a3)*$signed(b3);
    #1;
    if(result !== expected) $fatal(1,"MISMATCH %0d / %0d",result,expected);
    $display("PASS parallel dot4 result=%0d expected=%0d",result,expected);
  end
endtask
initial begin
  $dumpfile("dot4_parallel.vcd");$dumpvars(0,tb_dot4_parallel);
  a0=2;a1=-3;a2=4;a3=5;b0=3;b1=7;b2=-2;b3=1;check();
  a0=-4;a1=0;a2=1;a3=12;b0=-6;b1=9;b2=7;b3=-2;check();
  a0=32767;a1=-32768;a2=32767;a3=-32768;b0=32767;b1=32767;b2=-32768;b3=-32768;check();
  for(i=0;i<100;i=i+1)begin
    a0=$random;a1=$random;a2=$random;a3=$random;
    b0=$random;b1=$random;b2=$random;b3=$random;
    check();
  end
  $display("PASS all 103 test vectors");
  $finish;
end
endmodule
