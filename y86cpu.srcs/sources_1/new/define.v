// Global macros
`define RST_EN      1'B1
`define TRUE        1'B1
`define FALSE       1'B0
`define SAOK        3'B000
`define SINS        3'B001
`define SADR        3'B010
`define SHLT        3'B100

// Instruction codes
`define HALT    4'H0
`define NOP     4'H1
`define CXX     4'H2
`define IXX     4'H3
`define RMMOVQ  4'H4
`define MRMOVQ  4'H5
`define OPQ     4'H6
`define JXX     4'H7
`define CALL    4'H8
`define RET     4'H9
`define PUSHQ   4'HA
`define POPQ    4'HB

// Instruction functions
`define RRMOVQ  4'H0
`define CMOVLE  4'H1
`define CMOVL   4'H2
`define CMOVE   4'H3
`define CMOVNE  4'H4
`define CMOVGE  4'H5
`define CMOVG   4'H6

`define IRMOVQ  4'H0
`define IADDQ   4'H1
`define ISUBQ   4'H2
`define IANDQ   4'H3
`define IXORQ   4'H4

`define ADDQ    4'H0
`define SUBQ    4'H1
`define ANDQ    4'H2
`define XORQ    4'H3
`define NOPQ    4'H4

`define JMP     4'H0
`define JLE     4'H1
`define JL      4'H2
`define JE      4'H3
`define JNE     4'H4
`define JGE     4'H5
`define JG      4'H6

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

// Data width
`define ICODE_WIDTH     4
`define IFUN_WIDTH      4
`define BYTE_WIDTH      8
`define ADDR_WIDTH      64
`define DATA_WIDTH      64
`define INST_WIDTH      80

// Buses
`define IFUN_BUS        3:0
`define ICODE_BUS       3:0
`define REG_ADDR_BUS    3:0
`define ADDR_BUS        63:0
`define INST_BUS        79:0
`define DATA_BUS        63:0
`define STAT_BUS        2:0

// Instruction parts
`define ICODE           79:76
`define IFUN            75:72
`define SRCA            71:68
`define SRCB            67:64
`define BYTE8           71:64
`define BYTE7           63:56
`define BYTE6           55:48
`define BYTE5           47:40
`define BYTE4           39:32
`define BYTE3           31:24
`define BYTE2           23:16
`define BYTE1           15:8
`define BYTE0           7:0

// Memory size
`define MEM_SIZE        131071

// Default values
`define ICODE_ZERO      `ICODE_WIDTH'H0
`define IFUN_ZERO       `IFUN_WIDTH'H0
`define DATA_ZERO       `DATA_WIDTH'H0
`define ADDR_ZERO       `ADDR_WIDTH'H0
`define NONE_INST       `INST_WIDTH'H0
`define BYTE_ZERO       `BYTE_WIDTH'H0

