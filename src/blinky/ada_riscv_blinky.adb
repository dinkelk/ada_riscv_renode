with Interfaces; use Interfaces;
with System.Storage_Elements; use System.Storage_Elements;

procedure Ada_Riscv_Blinky is
   Led : Interfaces.Unsigned_32
      with Import, Convention => Ada, Address => To_Address (16#60000800#),
           Volatile => True;
   Led_Initial : constant Interfaces.Unsigned_32 := 16#0B00#;
   Led_Toggle : constant Interfaces.Unsigned_32 := 16#0B01#;

   procedure Sleep is
      Count : Natural := 9000000;
   begin
      while Count > 0 loop
         Count := Count - 1;
      end loop;
   end Sleep;
begin
   Led := Led_Initial;
   loop
      Led := Led xor Led_Toggle;
      Sleep;
   end loop;
end Ada_Riscv_Blinky;
