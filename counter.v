`ifndef COUNTER_V
`define COUNTER_V

module counter (
  input clk, rst_b, c0, c4,
  output count7
);

reg [2:0] count;

always@(posedge clk, negedge rst_b) begin
  if(!rst_b) 
    count <=0;
  else if(c0)
    count <= 0;
  else if (c4)
    count <= count + 1;
end

assign count7 = count[0] & count[1] & count[2];

endmodule

`endif