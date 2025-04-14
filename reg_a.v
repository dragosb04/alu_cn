`ifndef REG_A_V
`define REG_A_V

module reg_a(
  input clk, rst_b, c0, c2, c4, c5, 
  input [7:0] sum,
  output reg a_lsb,
  output reg [7:0] obus, 
  output reg [7:0] q
);

reg a_msb;

always@(posedge clk, negedge rst_b) begin
  if(!rst_b) 
    q <= 0;
  else if (c0)
    q <= 0;
  else if(c2)
    q <= sum;
 else if(c4)begin
    a_lsb <= q[0];
    a_msb <= q[7];
    q <= {a_msb, q[7:1]};
  end

    
end


always @(*) begin
  if(c5) 
    obus <= q;
  else obus <= 32'bz;
end

endmodule

`endif