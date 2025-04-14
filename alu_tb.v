`include "alu.v"

module alu_tb;

    parameter CLK_PERIOD = 10;

    reg signed [7:0] operand_a;
    reg signed [7:0] operand_b;
    reg [1:0] alu_operation;
    reg ENABLE;
    reg CLK;
    reg RESET;
    wire signed [7:0] result;
    wire carry_out;
    wire [3:0] flags;

    // ALU operations
    localparam ADD    = 4'b0000;
    localparam SUB    = 4'b0001;
    localparam MULT   = 4'b0010;
    localparam DIV    = 4'b0011;
    
    alu alu_inst (
        .operand_a(operand_a),
        .operand_b(operand_b),
        .alu_operation(alu_operation),
        .ENABLE(ENABLE),
        .CLK(CLK),
        .RESET(RESET),
        .result(result),
        .carry_out(carry_out),
        .flags(flags)
    );

    initial begin

        $dumpfile("alu.vcd");
        $dumpvars(0,alu_tb);

        CLK = 0;
        RESET = 0;
        ENABLE = 0;

        #10;
        CLK = 1;
        RESET = 1;

        ENABLE = 1;
        operand_a = -5;
        operand_b = -2;
        alu_operation = ADD;

        $display("Operation\tOperand A\tOperand B\tResult\t\tFlags");
        $monitor("%b\t%d\t%d\t%d\t\t%b", alu_operation, operand_a, operand_b, result, flags);

        #10 CLK = 0;

        #10 CLK = 1;
        operand_a = -3;
        operand_b = -4;
        alu_operation = SUB;

        #10 CLK = 0;

        #10 CLK = 1;
        operand_a = 5;
        operand_b = 3;
        alu_operation = MULT;
        
        #10 CLK = 0;

 /*       #10 CLK = 1;
        operand_a = 21;
        operand_b = 3;
        alu_operation = DIV;
        
        #10 CLK = 0;

        $finish; */
    end

endmodule
