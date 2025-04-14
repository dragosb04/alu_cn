`ifndef CU_V
`define CU_V

module control_unit(
  input clk, rst_b, bgn, q_1, q0, count31, 
  output reg c0, c1, c2, c3, c4, c5, c6, stop // stop = end
);


localparam S0 = 3'b000;
localparam S1 = 3'b001;
localparam S2 = 3'b010;
localparam S3 = 3'b011;
localparam S4 = 3'b100;
localparam S5 = 3'b101;
localparam S6 = 3'b110;
localparam S7 = 3'b111;

reg [2:0] st;
reg [2:0] st_nxt;
  
  always@(*) begin
    
    case(st)
      S0 : begin 
            stop = 0;
            c0=0;c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;
            if(bgn) st_nxt = S1;
              else st_nxt = S0;
            end
      S1 : begin
            c0=1;
            st_nxt = S2;
          end 
      S2 : begin
            c0=0; 
            c1 = 1; 
            c4 = 0;
            if(q0 == 0 && q_1 == 1) st_nxt = S3;
            else if(q0 == 1 && q_1 == 0) st_nxt = S4;
            else st_nxt = S5;   
          end
      S3 : begin
            c1=0;
            c2=1;
            st_nxt = S5;
          end
      S4 : begin
            c1=0;
            c2= 1;
            c3 = 1;
            st_nxt = S5;
          end
      S5 : begin
            c1=0;
            c2 = 0;
            c3 = 0;
            c4 = 1;
            if(count31 == 0)
              st_nxt = S2;
            else st_nxt = S6;
          end
          
       S6 : begin
            c1=0;
            c2=0;
            c3=0;
            c4=0;
            c5=1;
            st_nxt = S7;
          end
          
        S7 : begin
            c5=0;
            c6=1;
            stop = 1;
            st_nxt = S0;
          end
    endcase
    
end


always@(posedge clk, negedge rst_b) begin
  if(!rst_b) st <= S0;
  else st <= st_nxt;
end


endmodule

`endif