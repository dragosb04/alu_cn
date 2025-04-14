`ifndef REG_S_V
`define REG_S_V

module reg_s (
  input CLK, RESET, c0, c2, a_msb,
  output reg q
);

always @(posedge CLK, negedge RESET) begin
  if(!RESET)
    q <= 0;
  else if(c0)
    q <= 0;
  else if(c2)
    q <= a_msb;
  end
  
endmodule

`endif