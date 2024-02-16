with Uart;

procedure Ada_Riscv_Uart is
begin
   Uart.Init;

   loop
      --  Uart_Interrupt.Put (65);
      null;
   end loop;
end Ada_Riscv_Uart;
