`timescale 1ns / 1ps

module buzzer(input clk,team1,team2,team3,team4,output reg [2:0] led);

//States
parameter idle=0;
parameter press_done=1;


reg [1:0]state=idle;
reg [1:0] win=0;


reg [31:0] count1=0,count2=0,count3=0;
reg [31:0] temp=0;


always @(posedge clk) 
begin
    case(state)
        idle: begin
                if(team1) 
                begin
                    if(count1<50_000_000)//50_000_000
                        count1<=count1+1;
                     else begin
                        state<=press_done;
                        win<=1;
                    end            
                end
                if(team2) 
                begin
                    if(count2<50_000_000)//50_000_000
                        count2<=count2+1;
                     else begin
                        state<=press_done;  
                        win<=2;
                    end                
                end 
                if(team3) 
                begin
                    if(count3<50_000_000)//50_000_000
                        count3<=count3+1;
                     else begin
                        state<=press_done;  
                        win<=3;
                     end        
                end
            
        end
        press_done: begin
            count1<=0;
            count2<=0;
            count3<=0;
            if(win==1) begin
                if (temp<300_000_000) begin //300_000_000
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
                if (temp<300_000_000) begin //300_000_000
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
                if (temp<300_000_000) begin  //300_000_000
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
endcase   
end

endmodule
