`ifndef ALU_V
`define ALU_V

`include "fac.v"
`include "rca.v"
`include "xor_gate.v"
`include "booth_radix2.v"
`include "non_restoring.v"

module alu(

    input signed [7:0] operand_a,
    input signed [7:0] operand_b,
    input [1:0] alu_operation,
    input ENABLE,
    input CLK,
    input RESET,
    output reg signed [7:0] result,
    output reg carry_out,
    output reg [3:0] flags,
    
    output reg [7:0] result2
);

// ALU operations
localparam ADD  = 4'b00;
localparam SUB  = 4'b01;
localparam MULT = 4'b10;
localparam DIV  = 4'b11;

integer i = 0;
wire signed [7:0] sign_bit;
wire signed [7:0] res;
wire cout;
wire [3:0] flg;
wire signed [7:0] real_b;
reg [7:0] shift_value;
reg sign;

reg [2:0] st;
reg [2:0] st_nxt;
wire booth_stop, div_stop;
wire signed [15:0] booth_result;
wire signed [7:0] division_result;

xor_gate inst1 (.b(operand_b), .op(alu_operation[0]), .result(real_b));

rca inst2 (.operand_a(operand_a), .operand_b(real_b), .CLK(CLK), .result(res), .carry_out(cout), .flags(flg));

booth_radix2 inst3 (.clk(CLK), .bgn(ENABLE), .rst_b(RESET), .ibusa(operand_a), .ibusb(operand_b), .stop(booth_stop), .obus(booth_result));

non_restoring inst4 (.CLK(CLK), .bgn(ENABLE), .RESET(RESET), .ibusa(operand_a), .ibusb(operand_b), .stop(div_stop), .obus(division_result));

always @(*) begin

  flags = 4'b0;
  carry_out = 1'b0;

  case(alu_operation)

        ADD: if (ENABLE) begin
                result = res;
                flags = flg;
                carry_out = cout;
             end
             else begin
                    result = 8'b0;
                    flags = 4'b0;
                    carry_out = 1'b0;
            end

        SUB: if (ENABLE) begin
                result = res;
                flags = flg;
                carry_out = cout;
             end
             else begin
                    result = 8'b0;
                    flags = 4'b0;
                    carry_out = 1'b0;
             end

        MULT: if (ENABLE) begin
                /*result = operand_a * operand_b;*/
                result = booth_result[7:0];
                result2= booth_result[15:8];
                carry_out = booth_stop;
              end
              else begin
                result = 8'b0;
              end

        DIV:  if (ENABLE) begin
                /*result = operand_a / operand_b;*/
                result = division_result;
                carry_out = div_stop;
              end
              else begin
                result = 8'b0;
              end

        default: result = 8'b0;

    endcase
end

endmodule

`endif