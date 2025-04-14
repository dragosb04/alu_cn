`ifndef XOR_GATE_V
`define XOR_GATE_V

module xor_gate (
  input signed [7:0] b,
  input op,
  output reg signed [7:0] result
);

wire signed [7:0] xor_result;
wire signed [7:0] sum;
wire [8:0] carry;

genvar j;
generate
  for (j = 0; j < 8; j = j + 1) begin
    assign xor_result[j] = (b[j] & ~op) | (~b[j] & op);
  end
endgenerate

fac fac_inst1 (
    .bit_a(xor_result[0]),
    .bit_b(1'b1),
    .cin(1'b0),
    .sum(sum[0]),
    .cout(carry[1])
);

genvar i;
generate
    for (i = 1; i < 8; i = i + 1) begin
      fac fac_inst (
        .bit_a(xor_result[i]),
        .bit_b(1'b0),
        .cin(carry[i]),
        .sum(sum[i]),
        .cout(carry[i+1])
      );
    end
endgenerate

always @(*) begin

    case(op)

        1: begin
              result = sum;
           end

        0: begin
              result = xor_result;
          end
        default: result = 8'b0;

    endcase
end

endmodule

`endif