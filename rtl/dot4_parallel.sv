module dot4_parallel (
    input wire signed [15:0] a0,a1,a2,a3,
    input wire signed [15:0] b0,b1,b2,b3,
    output wire signed [33:0] result
);
wire signed [31:0] p0 = a0 * b0;
wire signed [31:0] p1 = a1 * b1;
wire signed [31:0] p2 = a2 * b2;
wire signed [31:0] p3 = a3 * b3;
assign result = {{2{p0[31]}},p0} + {{2{p1[31]}},p1}
              + {{2{p2[31]}},p2} + {{2{p3[31]}},p3};
endmodule
