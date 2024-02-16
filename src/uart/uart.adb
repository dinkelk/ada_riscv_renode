package body Uart is

   procedure Init is
   begin
      Uart.Event_Enable := Rx_Event;
   end;

   procedure Put (Data : Interfaces.Unsigned_32) is
   begin
      Uart.Rx_Tx := Data;
   end Put;

   procedure Interrupt_Handler is
   begin
      Put (Uart.Rx_Tx);
   end Interrupt_Handler;

end Uart;
