#include <stdint.h>

typedef struct {
    volatile uint32_t DATA;
} GPIO_Type;

#define GPIO_BASE *((volatile  unsigned int*)0x40000000)

void shitty_delay(void) {
    for(volatile uint32_t i = 0; i < 50000; i++);
}

void _start(void) {
    while(1) {
        GPIO_BASE = 1;
        shitty_delay();
        GPIO_BASE = 0;
        shitty_delay();
    }
}
