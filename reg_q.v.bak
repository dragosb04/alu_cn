`ifndef REG_Q_V
`define REG_Q_V

module reg_q(
  input clk, rst_b, c1, c4, c6, 
  input [7:0] ibus,
  input a_lsb,
  output reg q_lsb,
  output reg [7:0] obus
);

reg [7:0] q;

always @(posedge clk, negedge rst_b) begin
  if(!rst_b)
    q <= 0;
  else if (c1) begin
    q <= ibus;
    q_lsb <= ibus[0];
  end
  else if(c4) 
    begin
        q_lsb <= q[0];
        q <= {a_lsb, q[7:1]};
      end

end


always @(*) begin
 // if(c6) 
    obus <= q;
//  else obus <= 8'bz; //si aici
  
end

endmodule

`endif