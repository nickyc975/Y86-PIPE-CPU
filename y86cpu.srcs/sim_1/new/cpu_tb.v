`timescale 1ns / 1ns

module cpu_tb;
    reg clk;
    reg rst;
    
    initial
        begin
            clk <= 1'B0;
            forever #10 clk <= ~clk;
        end
        
    initial
        begin
            rst <= 1'B1;  
            #5 rst <= 1'B0;  
            #1000 $stop;  
        end
    sopc test(.clk(clk), .rst(rst));
endmodule
