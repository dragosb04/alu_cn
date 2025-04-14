`ifndef DIVIDE_V
`define DIVIDE_V

`include "xor_gate.v"
`include "reg_a_sub.v"
`include "reg_m_sub.v"
`include "reg_q_sub.v"
`include "reg_s.v"
`include "counter.v"
`include "rca.v"
`include "fac.v"
`include "control_unit_sub.v"

module non_restoring (
  input CLK, bgn, RESET, 
  input signed [31:0] ibusa,
  input signed [31:0] ibusb,
  output stop, 
  output [31:0] obus
);

wire c0, c1, c2, c3, c4, c5, c6, a_msb, sign, count31, a_lsb, s;
wire signed [31:0] m, a, out_sum;
wire signed [31:0] out_xor;
wire carry_out;
wire [3:0] flg;

reg_m_sub inst1( .CLK(CLK), .RESET(RESET), .c0(c0), .ibus(ibusb), .q(m));
reg_a_sub inst2(.CLK(clk), .RESET(rst_b), .c0(c0), .c2(c2), .c4(c4), .c5(c5), .sign(s), .sum(out_sum), .a_lsb(a_lsb), .q(a), .obus(obus));
reg_q_sub inst3( .CLK(clk), .RESET(rst_b), .c1(c1), .c2(c2), .c4(c4), .c6(c6), .a_lsb(a_lsb), .q_lsb(q_lsb), .ibus(ibusa), .obus(obus));
reg_s inst4(.CLK(clk), .RESET(rst_b), .c0(c0), .c2(c2), .a_msb(a_msb), .q(s));
counter inst5(.clk(clk), .rst_b(rst_b), .c0(c0), .c4(c4), .count31(count31));
control_unit_sub inst6(.clk(clk), .rst_b(rst_b), .bgn(bgn), .s(s), .count31(count31), 
                    .c0(c0), .c1(c1), .c2(c2), .c3(c3), .c4(c4), .c5(c5), .c6(c6), .stop(stop));
xor_gate inst7(.b(m), .op(c3), .result(out_xor));
parallel_adder inst8(.x(out_xor), .y(a), .c3(c3), .out(out_sum));

endmodule

`endif
