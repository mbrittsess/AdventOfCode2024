with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed;-- use Ada.Strings.Fixed;

package body Day11 is
   Input_Line : constant String := Get_Line;
   
   Input_Stone_Count : constant Positive := Ada.Strings.Fixed.Count(Input_Line, " ")+1;
   
   Input_Stone_Sequence : Stone_Sequence(1..Input_Stone_Count);
   
   function Get_Input_Sequence return Stone_Sequence is (Input_Stone_Sequence);
   
   package Stone_IO is new Integer_IO(Stone_Number);
   
   function Count_Digits ( N : Stone_Number ) return Positive is
      Num : Stone_Number := N;
      Count : Positive := 1;
   begin
      while Num > 9 loop
         Count := @ + 1;
         Num   := @ / 10;
      end loop;
      
      return Count;
   end Count_Digits;
   
begin
   declare
      Last_String_Idx : Natural := 0;
   begin
      for Sequence_Idx in Input_Stone_Sequence'Range loop
         Stone_IO.Get(Input_Line(Last_String_Idx+1 .. Input_Line'Last), Input_Stone_Sequence(Sequence_Idx), Last_String_Idx);
      end loop;
   end;
end Day11;