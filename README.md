# Y86 PIPE CPU

* __项目简介__

这个项目来源于CMU的《深入理解计算机系统》第三版，书中介绍了一个类x86-64的Y86-64指令集。我们的计算机系统课的大作业要求用Verilog实现这个指令集，于是就有了这个项目。但是这个项目最终超出了作业的要求范围，我把它放到这里，作为自己的一点小成果，同时也希望能帮到有需要的人。

* __Y86-64简介__

Y86-64是一个用于教学的类x86-64的简单指令集（不是精简指令集），仅支持简单的逻辑运算和整数运算，全部指令如下：

        0x00                        halt
        0x10                        nop

        0x20rArB                    rrmovq
        0x21rArB                    cmovle
        0x22rArB                    cmovl
        0x23rArB                    cmove
        0x24rArB                    cmovne
        0x25rArB                    cmovge
        0x26rArB                    cmovg

        0x30FrB0000000000000000     irmovq
        0x31FrB0000000000000000     iaddq
        0x32FrB0000000000000000     isubq
        0x33FrB0000000000000000     iandq
        0x34FrB0000000000000000     ixorq

        0x40rArB0000000000000000    rmmovq
        0x50rArB0000000000000000    mrmovq

        0x60rArB                    addq
        0x61rArB                    subq
        0x62rArB                    andq
        0x63rArB                    xorq

        0x700000000000000000        jmp
        0x710000000000000000        jle
        0x720000000000000000        jl
        0x730000000000000000        je
        0x740000000000000000        jne
        0x750000000000000000        jge
        0x760000000000000000        jg

        0x800000000000000000        call
        0x90                        ret
        0xA0rAF                     pushq
        0xB0rAF                     popq

> 注：原书中并不包含iaddq, isubq, iandq, ixorq，这是我自己扩充的。

Y86-64共有15个64位寄存器，编号从0x0到0xE，0xF则表示不使用寄存器：

        0   rax
        1   rcx
        2   rdx
        3   rbx
        4   rsp
        5   rbp
        6   rsi
        7   rdi
        8   r8
        9   r9
        A   r10
        B   r11
        C   r12
        D   r13
        E   r14
        F   NREG

书中的Y86-64的实现有两个版本，一个顺序实现，一个流水线实现。本项目实现的是流水线版本，共5级流水线。