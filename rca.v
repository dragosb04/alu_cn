`ifndef RCA_V
`define RCA_V

`include "fac.v"

module rca (
  input signed [7:0] operand_a,
  input signed [7:0] operand_b,
  input CLK,
  output reg signed [7:0] result,
  output reg carry_out,
  output reg [3:0] flags
);

  wire [7:0] sum;
  wire [8:0] carry;

  fac fac_inst1 (
        .bit_a(operand_a[0]),
        .bit_b(operand_b[0]),
        .cin(1'b0),
        .sum(sum[0]),
        .cout(carry[1])
      );

  genvar i;
  generate
    for (i = 1; i < 8; i = i + 1) begin
      fac fac_inst (
        .bit_a(operand_a[i]),
        .bit_b(operand_b[i]),
        .cin(carry[i]),
        .sum(sum[i]),
        .cout(carry[i+1])
      );
    end
  endgenerate

  always @(*) begin

    result = sum;
    carry_out = carry[7];

    // ZERO (1000)
    flags[3] = ~(|result[6:0]);  

    // NEGATIVE (0100)
    flags[2] = result[7];

    // CARRYS (0010)
    flags[1] = carry[8];  

    // OVERFLOW (0001)
    flags[0] = (operand_a[7] & operand_b[7] & ~result[7]) | (~operand_a[7] & ~operand_b[7] & result[7]);

  end

endmodule

`endif