`ifndef REG_A_SUB_V
`define REG_A_SUB_V

module reg_a_sub (
    input CLK, RESET, c0, c2, c4, c5, sign,
    input signed [7:0] sum,
    output reg a_lsb,
    output reg [7:0] obus, 
    output reg [7:0] q
);

reg a_msb;

always @ (posedge CLK, negedge RESET) begin
    if(!RESET) 
        q <= 0;
    else if (c0)
        q <= 0;
    else if(c2)
        q <= sum;
    else if(c4) begin
        a_lsb <= q[0];
        a_msb <= q[7];
        q <= {q[7], q[7:1]};
        q[7] <= a_msb;
    end
end

always @ (*) begin
  if(c5) 
    obus <= q;
  else obus <= 8'bz;
end

endmodule

`endif