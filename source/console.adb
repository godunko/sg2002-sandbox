
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

   type LCR_Register is record
      DLS  : Interfaces.Integer_32 range 0 .. 3;
      NSB  : Interfaces.Integer_32 range 0 .. 1;
      PE   : Interfaces.Integer_32 range 0 .. 1;
      EPS  : Interfaces.Integer_32 range 0 .. 1;
      SP   : Interfaces.Integer_32 range 0 .. 1;
      BCB  : Interfaces.Integer_32 range 0 .. 1;
      DLAB : Boolean;
   end record
     with Object_Size => 32;

   DLS_8N1 : constant := 3;
   NSB_8N1 : constant := 0;
   PE_8N1  : constant := 0;
   EPS_8N1 : constant := 0;
   SP_8N1  : constant := 0;

   for LCR_Register use record
      DLS  at 0 range 0 .. 1;
      NSB  at 0 range 2 .. 2;
      PE   at 0 range 3 .. 3;
      EPS  at 0 range 4 .. 4;
      SP   at 0 range 5 .. 5;
      BCB  at 0 range 6 .. 6;
      DLAB at 0 range 7 .. 7;
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
      LCR : LCR_Register         with Volatile, Full_Access_Only;
      MCR : Interfaces.Unsigned_32;
      LSR : LSR_Register         with Volatile, Full_Access_Only;
      MSR : Interfaces.Unsigned_32;
      --  SPR : Interfaces.Unsigned_32;
   end record;

   UART0 : UART_Registers with Import, Address => UART0_Base;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize is
      UART_Clock : constant := 25_000_000;
      Baud_Rate  : constant := 115_200;
      Divisor    : constant := (UART_Clock + 8 * Baud_Rate) / (16 * Baud_Rate);

   begin
      UART0.LCR.DLS  := DLS_8N1;
      UART0.LCR.NSB  := NSB_8N1;
      UART0.LCR.PE   := PE_8N1;
      UART0.LCR.EPS  := EPS_8N1;
      UART0.LCR.SP   := SP_8N1;

      UART0.LCR.DLAB := True;
      --  UART0.DLL := Divisor and 16#FF#;
   end Initialize;

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
