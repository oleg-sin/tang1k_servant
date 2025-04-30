#ifndef GPIO_BASE
#define GPIO_BASE 0x40000000
#endif

// New delay constants - like different pipe diameters!
#ifndef DELAY_500MS
#define DELAY_500MS 0x80000  // Big pipe for long wait
#endif
#ifndef DELAY_100MS
#define DELAY_100MS 0x20000  // Medium clog
#endif
#ifndef DELAY_50MS
#define DELAY_50MS 0x10000   // Small piss stream
#endif

.globl _start
_start:
// Plumbing address same way - two commands better than one, da?
lui a0, %hi(GPIO_BASE)
addi a0, a0, %lo(GPIO_BASE)

li t3, 0 // State counter - now 0-6 like days without vodka

main_loop:
// LED logic - special case for final state
andi t0, t3, 1      // Normal even/odd
xori t0, t0, 1      // Invert
li t4, 6            // Check if in final pause
beq t3, t4, led_off // Force LED off for state6

choose_delay:
beqz t3, state0_delay
addi t4, t3, -1
beqz t4, state1_delay
li t4,6
beq t3, t4, state6_delay
j default_delay

led_off:
li t0, 0 // KILL LIGHT for final pause
j choose_delay

state0_delay:
state6_delay: // Share same big delay
li t1, DELAY_500MS
j write_led

state1_delay:
li t1, DELAY_100MS
j write_led

default_delay:
li t1, DELAY_50MS

write_led:
sb t0, 0(a0) // SLAM LED STATE LIKE DOOR IN KHRUSHCHEVKA

// Delay loop - real man's code
li t2, 0
delay_loop:
addi t2, t2, 1
bne t2, t1, delay_loop

// State machine advance
addi t3, t3, 1
li t4, 7 // Now 7 states (0-6)
blt t3, t4, no_reset
li t3, 0 // Reset like broken elevator

no_reset:
j main_loop
