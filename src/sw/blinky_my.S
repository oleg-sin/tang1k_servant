.equ LED_ADDR, 0x40000000
.equ DELAY,    0x10000

.globl _start

_start:
    li   a0, LED_ADDR
    li   t1, DELAY

    addi t0, zero, 0

blink:
    sb   t0, 0(a0)
    xori t0, t0, 1
    addi t2, zero, 0

delay:
    addi t2, t2, 1
    bne  t1, t2, delay
    j            blink
