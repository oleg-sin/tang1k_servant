#include <stdint.h>

typedef struct {
    volatile uint32_t DATA;
} GPIO_Type;

#define GPIO_BASE 0x40000000

GPIO_Type * const GPIO __attribute__((section(".gpio_registers"))) = (GPIO_Type *)GPIO_BASE;

void shitty_delay(void) {
    for(volatile uint32_t i = 0; i < 50000; i++);
}

void _start(void) {
    while(1) {
        GPIO->DATA ^= (1 << 0);
        shitty_delay();
    }
}
