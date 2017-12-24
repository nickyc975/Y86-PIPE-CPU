`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/23 16:12:18
// Design Name: 
// Module Name: cpu_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


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
