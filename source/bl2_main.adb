
pragma Ada_2022;

--  with Ada.Numerics.Generic_Elementary_Functions;
with Interfaces;

with Console; use Console;

procedure BL2_Main is

   use Interfaces;
   --  use Ada.Numerics;

   --  package Elementary_Functions is
   --    new Ada.Numerics.Generic_Elementary_Functions (Long_Float);
   --  use Elementary_Functions;

   C : Interfaces.Unsigned_64 := 0 with Volatile;

begin
      New_Line;
      New_Line;
      Put_Line ("--------------------");
      Put_Line ("--  Ada on Board  --");
      Put_Line ("--------------------");
      New_Line;
   --  for K in 1 .. 3 loop
   for J in 1 .. 1_000 loop
      for K in 1 .. 1_000_000 loop
         C := @ + 1;
      end loop;
   end loop;

      New_Line;
      New_Line;
      Put_Line ("--------------------");
      Put_Line ("--  Ada on Board  --");
      Put_Line ("--------------------");
      New_Line;
      Put_Line ("Hello, it's Milk-V Duo 256M/SC2002/RISC-V!");
      Put_Line (Integer'Image (100500));
      --  Put_Line (Long_Float'Image (Sin (Pi / 2.0)));
      New_Line;

      null;
   --  end loop;
end BL2_Main;
