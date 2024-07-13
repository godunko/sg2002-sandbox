        .text
        .section .text,"ax",@progbits
        .globl bl2_entrypoint
bl2_entrypoint:
        j main
        .word 0 /* resvered */
        .word 0 /* BL2 MSID */
        .word 0 /* BL2 version */
        .word 0 /* */
        .word 0
        .word 0
        .word 0

