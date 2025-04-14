`ifndef PARALLEL_ADDER_V
`define PARALLEL_ADDER_V

module parallel_adder (
  input [7:0] x, y, 
  input c3,
  output [7:0] out
);

wire [8:0] carry;

assign carry[0] = c3;

generate 
  genvar j;
    for(j = 0; j < 8; j = j + 1)
      begin : vect
        fac inst_fac(.bit_a(x[j]), .bit_b(y[j]), .sum(out[j]), .cin(carry[j]), .cout(carry[j + 1]));
    end
endgenerate

endmodule

`endif