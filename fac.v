`ifndef FAC_V
`define FAC_V

module fac (

  input bit_a,
  input bit_b,
  input cin,
  output sum,
  output cout

);

assign sum = bit_a ^ bit_b ^ cin;
assign cout = (bit_a & bit_b) | (bit_a & cin) | (bit_b & cin);

endmodule

`endif