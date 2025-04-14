module rca_tb;

  parameter CLK_PERIOD = 10;

  reg signed [31:0] operand_a;
  reg signed [31:0] operand_b;
  reg CLK;
  wire signed [31:0] result;
  wire carry_out;
  wire [3:0] flags;

  rca rca_inst (
    .operand_a(operand_a),
    .operand_b(operand_b),
    .CLK(CLK),
    .result(result),
    .carry_out(carry_out),
    .flags(flags)
  );

  always #((CLK_PERIOD)/2) CLK = ~CLK;

  initial begin
    CLK = 0;
    #10;
    operand_a = 10;
    operand_b = 5;

    $display("Operand A\tOperand B\tResult\tCarry Out\tFlags");
    $monitor("%-10d\t%-10d\t%-10d\t%-10b\t%-10b", operand_a, operand_b, result, carry_out, flags);

    #10;
    operand_a = -10;
    operand_b = -5;

    #10;
    operand_a = 0;
    operand_b = 0;

    #10;
    operand_a = 0;
    operand_b = 1;

  end

endmodule