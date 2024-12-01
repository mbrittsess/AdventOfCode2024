with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Containers.Vectors;

procedure Day1 is
   package ID_Lists is new Ada.Containers.Vectors(
         Index_Type => Natural,
         Element_Type => Integer
      );
   use ID_Lists;
   package ID_List_Sorting is new ID_Lists.Generic_Sorting;
   
   package IIO renames Ada.Integer_Text_IO;
   function Get_Integer return Integer is
      I : Integer;
   begin
      IIO.Get(I);
      return I;
   end Get_Integer;
   
   Left_List, Right_List : ID_Lists.Vector := ID_Lists.Empty;
   
   Distance_Sum : Integer := 0;
begin
   -- Read in lists
   while not End_Of_File loop
      Left_List  := Left_List  & Get_Integer;
      Right_List := Right_List & Get_Integer;
   end loop;
   Put_Line("Lists are " & Left_List.Length'Image & " long");
   
   -- Sort lists
   ID_List_Sorting.Sort(Left_List);
   ID_List_Sorting.Sort(Right_List);
   
   -- Compute distances, sum total
   for Idx in Left_List.First_Index .. Left_List.Last_Index loop
      Distance_Sum := Distance_Sum + abs (Left_List(Idx) - Right_List(Idx));
   end loop;
   
   Put_Line("Sum is: " & Distance_Sum'Image);
end Day1;