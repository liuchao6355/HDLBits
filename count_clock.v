module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 

    always @(posedge clk) begin
        if(reset)
            ss = 8'h00;
        else if(ena) begin
                if(ss[7:0]==8'h59)
                    ss[7:0]<=8'h00;
                else begin
                    if(ss[3:0]==4'h9) begin
                        ss[7:4] <= ss[7:4] + 4'd1;
                        ss[3:0] <= 4'd0;
                    end
                    else 
                        ss[3:0] <= ss[3:0] + 4'd1;
                end
        end
        else
           	ss <= ss;
    end
    
    always @(posedge clk) begin
        if(reset)
            mm = 8'h00;
        else begin
            if(ss[7:0]==8'h59) begin
                if(mm[7:0]==8'h59)
                    mm[7:0]<=8'h00;
                else begin
                    if(mm[3:0]==4'h9) begin
                        mm[7:4] <= mm[7:4] + 4'd1;
                        mm[3:0] <= 4'd0;
                    end
                    else 
                        mm[3:0] <= mm[3:0] + 4'd1;
                end
            end
            else
                mm <= mm;
        end
    end
    
    always @(posedge clk) begin
        if(reset) begin
            pm=1'b0;
            hh=8'h12;
        end
        else begin
            if(mm[7:0]==8'h59&ss[7:0]==8'h59)begin
                if(hh[7:0]==8'h11&pm)begin
                    hh[7:0]<=8'h12;pm<=0;
                end
                else if(hh[7:0]==8'h12&pm)
                    hh <= 8'h01;
                else if(~pm&hh==8'h12)
                    hh <= 8'h01;
                else begin                    
                    if(hh[3:0]==4'h9) begin
                        hh[7:4] <= hh[7:4] + 4'd1;
                        hh[3:0] <= 4'd0;
                    end
                    else 
                        hh[3:0] <= hh[3:0] + 4'd1;
                    if(hh==8'h11)
                        pm=1'b1;
                end
            end
            else
                hh <= hh;
        end
    end
    
endmodule
