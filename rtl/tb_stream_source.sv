module tb_stream_source;
logic clk=0; always #5 clk=~clk;
logic rst_n=0,enable=0,tready=0;
wire [31:0] tdata;wire tvalid,done;
integer count=0,cycles=0;
logic [31:0] expected [0:5];
stream_source dut(.clk(clk),.rst_n(rst_n),.enable(enable),.m_axis_tdata(tdata),.m_axis_tvalid(tvalid),.m_axis_tready(tready),.done(done));
initial begin
expected[0]=11;expected[1]=23;expected[2]=17;expected[3]=42;expected[4]=7;expected[5]=90;
$dumpfile("stream_source.vcd");$dumpvars(0,tb_stream_source);
repeat(3) @(negedge clk);rst_n=1;enable=1;
repeat(25) @(negedge clk);
if(count!=6 || !done)$fatal(1,"Incomplete transfer count=%0d",count);
$display("PASS RTL AXI4-Stream ready/valid: %0d items",count);$finish;
end
always @(negedge clk)if(rst_n)begin cycles=cycles+1;tready=!(cycles==5||cycles==6||cycles==11);end
always @(posedge clk)if(rst_n&&tvalid&&tready)begin
if(count>=6||tdata!==expected[count])$fatal(1,"Unexpected transfer count=%0d",count);
count=count+1;end
endmodule
