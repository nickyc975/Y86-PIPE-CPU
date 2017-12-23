`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/23 18:56:35
// Design Name: 
// Module Name: alu_tb
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


module alu_tb;
    reg [3:0] E_icode;
    reg [3:0] E_ifun;
    reg [63:0] E_valC;
    reg [63:0] E_valA;
    reg [63:0] E_valB;
    
    wire [63:0] aluA;
    wire [63:0] aluB;
    wire [3:0] fun;
    
    wire [63:0] result;
    wire zf, sf, of;
    
    initial
    begin
        E_icode = 4'HX;
        E_ifun = 4'HX;
        E_valC = 64'HX;
        E_valA = 64'HX;
        E_valB = 64'HX;
    end
    
    alu_args args(
                    .E_icode(E_icode), 
                    .E_ifun(E_ifun), 
                    .E_valC(E_valC), 
                    .E_valA(E_valA), 
                    .E_valB(E_valB), 
                    .aluA(aluA), 
                    .aluB(aluB), 
                    .fun(fun));
    alu test(.aluA(aluA), .aluB(aluB), .fun(fun), .e_valE(result), .ZF(zf), .SF(sf), .OF(of));

endmodule
