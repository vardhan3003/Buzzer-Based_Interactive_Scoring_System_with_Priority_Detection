`timescale 1ns / 1ps
module digits(input clk,score_A,score_B,score_C,input [3:0] SA,SB,SC,output reg [3:0] ones,tens,output reg [2:0] thousands);

reg [9:0] temp_count = 0;

always @(posedge clk) begin
        if (score_A) begin
            temp_count <= SA;
			thousands  <=3'b100;
        end 
		else if (score_B) begin
            temp_count <= SB;
			thousands  <=3'b010;
        end 
		else if (score_C) begin
            temp_count <= SC;
			thousands  <=3'b001;
        end 
		else begin
            temp_count <= 0;
            thousands  <=3'b000;
        end

        ones <= temp_count % 10;
        tens <= (temp_count / 10) % 10;
    
end

endmodule
