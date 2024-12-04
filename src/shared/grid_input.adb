with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded;

package body Grid_Input is
   package SU renames Ada.Strings.Unbounded;

   type Grid_String is
      record
         Data : SU.Unbounded_String;
         Rows, Cols : Positive;
      end record;

   function Get_Whole_Input return Grid_String is

      First_Line : String := Get_Line;
      Width : constant Positive := First_Line'Length;
      Input : SU.Unbounded_String := SU.To_Unbounded_String(First_Line);
      Num_Lines : Positive := 1;
   begin
      while not End_Of_File loop
         SU.Append( Input, Get_Line ); -- in out Input
         Num_Lines := @ + 1;
      end loop;

      return ( Data => Input, Rows => Num_Lines, Cols => Width );
   end Get_Whole_Input;

   function Get_Grid_Input_From_Standard_Input return Character_Grid is
      GS : Grid_String := Get_Whole_Input;
      Grid : Character_Grid( 1 .. GS.Rows, 1 .. GS.Cols );
   begin
      for Row_Idx in Grid'Range(1) loop
         for Col_Idx in Grid'Range(2) loop
            Grid(Row_Idx, Col_Idx) := SU.Element(GS.Data, ((Row_Idx-1)*GS.Cols) + Col_Idx);
         end loop;
      end loop;

      return Grid;
   end Get_Grid_Input_From_Standard_Input;

   Input_Grid : constant Character_Grid := Get_Grid_Input_From_Standard_Input;

   function Get_Grid_Input return Character_Grid is
   begin
      return Input_Grid;
   end Get_Grid_Input;

end Grid_Input;