module dff(d,clk,rst,q);
    input d;
    input clk;
    input rst;
    output reg q;

    always @(posedge clk or posedge rst) begin
        if(rst==1) begin 
            q<=0;
        end
        else begin
            q<=d;
        end
    end

endmodule