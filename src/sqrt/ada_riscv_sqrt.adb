with Ada.Numerics.Generic_Elementary_Functions;
with Interfaces; use Interfaces;

procedure Ada_Riscv_Sqrt is
   package F64_Functions is new
      Ada.Numerics.Generic_Elementary_Functions (Interfaces.IEEE_Float_64);
   Value : constant Interfaces.IEEE_Float_64 := 400000000.0;
   Result : Interfaces.IEEE_Float_64;
begin
   Result := F64_Functions.Sqrt (Value);

   while True loop
      null; -- We never get here :(
   end loop;
end Ada_Riscv_Sqrt;
