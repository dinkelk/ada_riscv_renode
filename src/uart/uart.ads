with Interfaces; use Interfaces;
with System.Storage_Elements; use System.Storage_Elements;

package Uart is

   procedure Init;
   procedure Put (Data : Interfaces.Unsigned_32);

private

   type Uart_If is record
      Rx_Tx : Unsigned_32;
      Tx_Full : Unsigned_32;
      Rx_Empty : Unsigned_32;
      Event_Status : Unsigned_32;
      Event_Pending : Unsigned_32;
      Event_Enable : Unsigned_32;
   end record;

   Tx_Event : constant Unsigned_32 := 2#01#;
   Rx_Event : constant Unsigned_32 := 2#10#;

   Uart : Uart_If
      with Import, Convention => Ada, Address => To_Address (16#60001800#),
           Volatile => True;

   -- Export this to C, since we implement the actual interrupt handler in C
   -- and have it call this procedure.
   procedure Interrupt_Handler
      with Export, Convention => C, External_Name => "ada_interrupt_handler";

end Uart;
