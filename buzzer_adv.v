`timescale 1ns / 1ps

module buzzer(input clk,A,B,C,score_on,score_A,score_B,score_C,inc,dec,output reg [2:0] led,output [0:6] seg,output [3:0] digit);

//Score_A,Score_B,SCORE_C Switches to add score for the respective teams
reg [3:0] SA=0;
reg [3:0] SB=0;
reg [3:0] SC=0;
reg flag    =0;

wire [3:0]ones,tens;
wire [2:0] thousands;
//States
parameter idle=0;
parameter press_done=1;
parameter score=2;

//Scores of A,B,C

reg [1:0]state=idle;
reg [1:0] win=0;


reg [31:0] countA=0,countB=0,countC=0,count=0;
reg [31:0] temp=0;

digits d1(clk,score_A,score_B,score_C,SA,SB,SC,ones,tens,thousands);
seven_seg s1(clk,ones,tens,thousands,seg,digit);

always @(posedge clk) 
begin
    case(state)
        idle: begin 
                if (score_on) begin
                    state<=score;
                end
                else begin
                    flag=0;
                    if(A) 
                    begin
                        flag=1;
                        if(countA<5)//50_000_000
                            countA<=countA+1;
                         else begin
                            state<=press_done;
                            win<=1;
                        end            
                    end
                    if(B) 
                    begin
                        flag=1;
                        if(countB<5)//50_000_000
                            countB<=countB+1;
                         else begin
                            state<=press_done;  
                            win<=2;
                        end                
                    end 
                    if(C) 
                    begin
                        flag=1;
                        if(countC<5)//50_000_000
                            countC<=countC+1;
                         else begin
                            state<=press_done;  
                            win<=3;
                         end        
                    end
                    if (flag==0) begin
                        countA<=0;
                        countB<=0;
                        countC<=0;
                    end
                end
            
        end
        press_done: begin
            countA<=0;
            countB<=0;
            countC<=0;
            if(win==1) begin
                if (temp<30) begin //300_000_000
                    led<=3'b100;
                    temp<=temp+1;
                end
                else begin
                    temp<=0;
                    led<=3'b000;
                    state<=idle;
                end
            end
            else if(win==2) begin
                if (temp<30) begin //300_000_000
                    led<=3'b010;
                    temp<=temp+1;
                end
                else begin
                    temp<=0;
                    led<=3'b000;
                    state<=idle;
                end
            end
            else if(win==3) begin
                if (temp<30) begin  //300_000_000
                    led<=3'b001;
                    temp<=temp+1;
                end
                else begin
                    temp<=0;
                    led<=3'b000;
                    state<=idle;
                end
            end
            
        end
        score: begin
            if(score_on) begin
                if(score_A) begin
                    if(inc) begin
                        if(count<25) begin //25_000_000
                            count=count+1;
                        end
                        else begin
                            if(count==25)//25_000_000
                                SA=SA+1;
                            count<=0;
                        end
                    end
                    else if(dec) begin
                        if(count<25) begin//25_000_000
                            count=count+1;
                        end
                        else begin
                            if(count==25)  begin//25_000_000
                                if(SA>0)
                                    SA=SA-1;
                                count<=0;
                            end   
                        end
                    end
                    else
                        count<=0;
                end
                else if(score_B) begin
                    if(inc) begin
                        if(count<25) begin //25_000_000
                            count<=count+1;
                        end
                        else begin
                            if(count==25) //25_000_000
                                SB<=SB+1;
                            count<=0;
                        end
                    end
                    else if(dec) begin
                        if(count<25) begin //25_000_000
                            count<=count+1;
                        end
                        else begin
                            if(count==25) begin //25_000_000 
                                if(SB>0)
                                    SB<=SB-1;
                                count<=0;
                            end
                        end
                    end
                    else
                        count<=0;
                end
                else if(score_C) begin
                    if(inc) begin
                        if(count<25) begin //25_000_000
                            count=count+1;
                        end
                        else begin
                            if(count==25)  //25_000_000
                                SC=SC+1;
                            count<=0;
                        end
                    end
                    else if(dec) begin
                        if(count<25) begin //25_000_000
                            count=count+1;
                        end
                        else begin
                            if(count==25) begin//25_000_000
                                if(SC>0)
                                    SC=SC-1;
                                count<=0;
                             end   
                        end
                    end
                    else
                        count<=0;
                end                      
            end
			else begin
				state<=idle;
			end
        end
endcase   
end
endmodule
