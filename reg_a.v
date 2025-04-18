`ifndef REG_A_V
`define REG_A_V

module reg_a(
  input clk, rst_b, c0, c2, c4, c5, 
  input [7:0] sum,
  output reg a_lsb,
  output reg [7:0] obus, 
  output reg [7:0] a
);

reg a_msb;

always@(posedge clk, negedge rst_b) begin
  if(!rst_b) 
    a <= 0;
  else if (c0)
    a <= 0;
  else if(c2)
    a <= sum;
 else if(c4)begin
    a_lsb <= a[0];
    a_msb <= a[7];
    a <= {a_msb, a[7:1]};
  end

    
end


always @(*) begin
  //if(c5) 
    obus <= a;
  //else obus <= 8'bz;  //aici
end

endmodule

`endif