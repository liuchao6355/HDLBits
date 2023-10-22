module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    always @(posedge clk) begin
        if(reset)
            q <= 16'h0000;
        else begin
            if(q==16'h9999)
                q <= 16'h0000;
            else if(ena[3]) begin
                q[11:0] <= 12'h000;
                q[15:12] <= q[15:12] + 1; 
            end
            else if(ena[2]) begin
                q[7:0] <= 8'h00;
                q[11:8] <= q[11:8] + 1;
            end
            else if(ena[1]) begin
                q[3:0] <= 4'h0;
                q[7:4] <= q[7:4] + 1;
            end
            else
                q[3:0] <= q[3:0] + 1;
            
            //ena[1] = (q[3:0]==4'd9);
    		//ena[2] = (q[3:0]==4'd9&q[7:4]==4'd9);
    		//ena[3] = (q[3:0]==4'd9&q[7:4]==4'd9&q[11:8]==4'd9);
        end
            
    end
  //  always @(posedge clk) begin
    //    ena[1] = (q[3:0]==4'd9);
    //	ena[2] = (q[3:0]==4'd9&q[7:4]==4'd9);
    //	ena[3] = (q[3:0]==4'd9&q[7:4]==4'd9&q[11:8]==4'd9);
    //end
    assign ena[1] = (q[3:0]==4'd9);
    assign ena[2] = (q[3:0]==4'd9&q[7:4]==4'd9);
    assign ena[3] = (q[3:0]==4'd9&q[7:4]==4'd9&q[11:8]==4'd9);
    
endmodule
