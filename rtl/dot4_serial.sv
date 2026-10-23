module dot4_serial(input wire clk, input wire rst_n, input wire start,
  input wire signed [7:0] a0,a1,a2,a3,b0,b1,b2,b3,
  output reg signed [18:0] result, output reg done);
reg [2:0] i;
reg signed [18:0] acc;
reg signed [7:0] x,y;
always @(*) begin
case(i)
1: begin x=a0;y=b0;end
2: begin x=a1;y=b1;end
3: begin x=a2;y=b2;end
4: begin x=a3;y=b3;end
default:begin x=0;y=0;end
endcase
end
always @(posedge clk or negedge rst_n) begin
if(!rst_n) begin i<=0;acc<=0;result<=0;done<=0;end
else if(start && !done && i==0) begin acc<=0;i<=1;end
else if(i!=0 && i<=4)begin acc<=acc+$signed(x)*$signed(y);i<=i+1;end
else if(i==5)begin result<=acc;done<=1;i<=6;end
end
endmodule
