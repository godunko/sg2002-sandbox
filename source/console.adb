
pragma Restrictions (No_Elaboration_Code);

pragma Ada_2022;

with Interfaces;
with System.Storage_Elements;

package body Console is

   UART0_Base : constant System.Address :=
     System.Storage_Elements.To_Address (16#04140000#);

   type RBR_THR_DLL_Register is record
      RBR_THR_DLL : Interfaces.Unsigned_8;
   end record
     with Object_Size => 32;

   for RBR_THR_DLL_Register use record
      RBR_THR_DLL at 0 range 0 .. 7;
   end record;

   type LSR_Register is record
      THRE : Boolean;
   end record
     with Object_Size => 32;

   for LSR_Register use record
      THRE at 0 range 5 .. 5;
   end record;

   type UART_Registers is record
      RBR : RBR_THR_DLL_Register with Volatile, Full_Access_Only;
      IER : Interfaces.Unsigned_32;
      FCR : Interfaces.Unsigned_32;
      LCR : Interfaces.Unsigned_32;
      MCR : Interfaces.Unsigned_32;
      LSR : LSR_Register         with Volatile, Full_Access_Only;
      MSR : Interfaces.Unsigned_32;
      SPR : Interfaces.Unsigned_32;
   end record;

   UART0 : UART_Registers with Import, Address => UART0_Base;

   ---------
   -- Put --
   ---------

   procedure Put (Item : Character) is
   begin
      while not UART0.LSR.THRE loop
         null;
      end loop;

      UART0.RBR.RBR_THR_DLL := Character'Pos (Item);
   end Put;

   ---------
   -- Put --
   ---------

   procedure Put (Item : String) is
   begin
      for C of Item loop
         Put (C);
      end loop;
   end Put;

   --------------
   -- Put_Line --
   --------------

   procedure Put_Line (Item : String) is
   begin
      Put (Item);
      New_Line;
   end Put_Line;

   --------------
   -- New_Line --
   --------------

   procedure New_Line is
   begin
      Put (ASCII.CR);
      Put (ASCII.LF);
   end New_Line;

end Console;
