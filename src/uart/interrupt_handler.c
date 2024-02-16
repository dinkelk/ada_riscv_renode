extern void ada_interrupt_handler(void);

// We define this in C, so we can use the fancy RISC-V attribute
void interrupt_handler() __attribute__((interrupt("machine")));

void interrupt_handler()
{
    ada_interrupt_handler();
}
