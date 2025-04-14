`ifndef COUNTER_V
`define COUNTER_V

module counter (
  input clk, rst_b, c0, c4,
  output count31
);

reg [4:0] count;

always@(posedge clk, negedge rst_b) begin
  if(!rst_b) 
    count <=0;
  else if(c0)
    count <= 0;
  else if (c4)
    count <= count + 1;
end

assign count31 = count[0] & count[1] & count[2] & count[3] & count[4];

endmodule

`endif