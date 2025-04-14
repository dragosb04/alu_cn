`ifndef REG_M_V
`define REG_M_V

module reg_m(
  input clk, rst_b, c0, 
  input [7:0] ibus,
  output reg [7:0] q
);

always@(posedge c0, negedge rst_b) begin
  if(!rst_b) 
    q <= 0;
  else if (c0)
    q <= ibus;
  end
endmodule

`endif