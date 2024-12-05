with Ada.Text_IO; use Ada.Text_IO;
with Day1_Input; use Day1_Input;
with Ada.Containers.Generic_Array_Sort;

procedure Day1Alt is
   type ID_List is array(Input_Index range <>) of Integer;
   
   procedure Sort_ID_List is new Ada.Containers.Generic_Array_Sort(
         Index_Type   => Input_Index,
         Element_Type => Integer,
         Array_Type   => ID_List
      );
   
   Left_List  : ID_List := (for Pair of ID_Pairs => Pair.Left);
   Right_List : ID_List := (for Pair of ID_Pairs => Pair.Right);
   
   Distance_Sum : Integer := 0;
begin
   -- Lists must be sorted
   Sort_ID_List(Left_List);
   Sort_ID_List(Right_List);
   
   -- Compute distances, sum total
   for Idx in Left_List'Range loop
      Distance_Sum := @ + abs (Left_List(Idx) - Right_List(Idx));
   end loop;
   
   Put_Line("Sum is: " & Distance_Sum'Image);
end Day1Alt;