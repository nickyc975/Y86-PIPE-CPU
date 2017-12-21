// Global macros
`define RST_EN      1'B1
`define WRITE_EN    1'B1
`define READ_EN     1'B1
`define TRUE        1'B1
`define FALSE       1'B1
`define CHIP_EN     1'B1
`define INS_VALID   1'B1

// Instructions
`define HALT    8'H00
`define NOP     8'H10
`define RRMOVQ  8'H20
`define CMOVLE  8'H21
`define CMOVL   8'H22
`define CMOVE   8'H23
`define CMOVNE  8'H24
`define CMOVGE  8'H25
`define CMOVG   8'H26
`define IRMOVQ  8'H30
`define IADDQ   8'H31
`define ISUBQ   8'H32
`define IANDQ   8'H33
`define IXORQ   8'H34
`define RMMOVQ  8'H40
`define MRMOVQ  8'H50
`define ADDQ    8'H60
`define SUBQ    8'H61
`define ANDQ    8'H62
`define XORQ    8'H63
`define JMP     8'H70
`define JLE     8'H71
`define JL      8'H72
`define JE      8'H73
`define JNE     8'H74
`define JGE     8'H75
`define JG      8'H76
`define CALL    8'H80
`define RET     8'H90
`define PUSHQ   8'HA0
`define POPQ    8'HB0

// Registers
`define RAX     4'H0
`define RBX     4'H3
`define RCX     4'H1
`define RDX     4'H2
`define RSP     4'H4
`define RBP     4'H5
`define RSI     4'H6
`define RDI     4'H7
`define R8      4'H8
`define R9      4'H9
`define R10     4'HA
`define R11     4'HB
`define R12     4'HC
`define R13     4'HD
`define R14     4'HE
`define NREG    4'HF

// Data info
`define IFUN_WIDTH      4
`define ICODE_WIDTH     4
`define REG_ADDR_WIDTH  4
`define ADDR_WIDTH      64
`define DATA_WIDTH      64
`define INST_WIDTH      80

// Bus info
`define IFUN_BUS        3:0
`define ICODE_BUS       3:0
`define REG_ADDR_BUS    3:0
`define ADDR_BUS        63:0
`define INST_BUS        79:0
`define DATA_BUS        63:0

// Memory
`define MEM_SIZE        131071
`define MEM_ADDR        17

