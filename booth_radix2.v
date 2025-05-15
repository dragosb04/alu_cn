`ifndef BOOTH_V
`define BOOTH_V

`include "reg_a.v"
`include "reg_m.v"
`include "reg_q.v"
`include "reg_q1.v"
`include "counter.v"
`include "xor_gate.v"
`include "parallel_adder.v"
`include "fac.v"
`include "control_unit.v"

module booth_radix2 (
  input clk, bgn, rst_b, 
  input [7:0] ibusa,
  input [7:0] ibusb,
  output stop, 
  output reg[15:0] obus
);

wire c0, c1, c2, c3, c4, c5, c6, q_lsb, q_1, count7, a_lsb; 
wire [7:0] m, a, out_sum;
wire [7:0] out_xor;
wire [3:0] flg;
wire [15:0] outbus;
wire cout;
reg [15:0]aux;

reg_m leg1( .clk(clk), .rst_b(rst_b), .c0(c0), .ibus(ibusb), .q(m));

reg_a leg4(.clk(clk), .rst_b(rst_b), .c0(c0), .c2(c2), .c4(c4), .c5(c5), .sum(out_sum), .a_lsb(a_lsb), .a(a), .obus(outbus[15:8]));
reg_q leg3(.clk(clk), .rst_b(rst_b), .c1(c1), .c4(c4), .c6(c6), .a_lsb(a_lsb), .q_lsb(q_lsb), .ibus(ibusa), .obus(outbus[7:0]));
reg_q_1 leg5(.clk(clk), .rst_b(rst_b), .c0(c0), .c4(c4), .q_lsb(q_lsb), .q(q_1));
counter leg6(.clk(clk), .rst_b(rst_b), .c0(c0), .c4(c4), .count7(count7));
control_unit leg7(.clk(clk), .rst_b(rst_b), .bgn(bgn), .q_1(q_1), .q0(q_lsb), .count7(count7), 
                    .c0(c0), .c1(c1), .c2(c2), .c3(c3), .c4(c4), .c5(c5), .c6(c6), .stop(stop));
xor_gate leg8(.b(m), .op(c3), .result(out_xor));
parallel_adder leg9(.x(out_xor), .y(a), .c3(c3), .out(out_sum));

//assign obus = outbus;

always@(posedge clk)begin
  //if(c5 | c6)
    obus <= outbus;
  //aux <= outbus; 
end

//assign obus = aux;

endmodule

`endif