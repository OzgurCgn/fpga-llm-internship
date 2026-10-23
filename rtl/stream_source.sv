module stream_source #(parameter integer DATA_W=32, COUNT=6)(
input wire clk,rst_n,enable,
output logic [DATA_W-1:0] m_axis_tdata,
output logic m_axis_tvalid,
input wire m_axis_tready,
output logic done
);
logic [2:0] index;
function automatic [DATA_W-1:0] payload(input logic [2:0] i);
case(i)
3'd0:payload=11;3'd1:payload=23;3'd2:payload=17;3'd3:payload=42;3'd4:payload=7;default:payload=90;
endcase
endfunction
always_ff @(posedge clk or negedge rst_n) begin
if(!rst_n)begin index<=0; done<=0; m_axis_tvalid<=0;end
else if(enable && !done)begin
m_axis_tvalid<=1;
if(m_axis_tvalid && m_axis_tready)begin
if(index==COUNT-1)begin done<=1;m_axis_tvalid<=0;end
else index<=index+1;
end
end
end
always_comb m_axis_tdata=payload(index);
endmodule
