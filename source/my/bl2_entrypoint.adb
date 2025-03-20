
pragma Ada_2022;

with UART0; use UART0;

package body BL2_Entrypoint is

   procedure Entrypoint
     with Export, Convention => C, Link_Name => "bl2_entrypoint";

   procedure Main
     with Import, Convention => C, Link_Name => "main";

   ----------------
   -- Entrypoint --
   ----------------

   procedure Entrypoint is
   begin
      UART0.UART0.RBR.RBR_THR_DLL := Character'Pos ('@');
      --  RBR_THR_DLL.RBR_THR_DLL := Character'Pos ('@');

      Main;
   end Entrypoint;

end BL2_Entrypoint;
