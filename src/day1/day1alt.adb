with Mapped_Input;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Containers.Generic_Array_Sort;

procedure Day1Alt is
   type ID_Pair is
      record
         Left, Right : Integer;
      end record;
   
   function To_ID_Pair ( S : String ) return ID_Pair is
      package IIO renames Ada.Integer_Text_IO;
      
      L, R : Integer;
      Last_Pos : Integer;
   begin
      IIO.Get(S, L, Last_Pos); -- out L, out Last_Pos
      IIO.Get(S(Last_Pos+1 .. S'Last), R, Last_Pos); -- out R, out LastPos
      
      return ( Left => L, Right => R );
   end To_ID_Pair;
   
   package Day1_Input is new Mapped_Input(
         Input_Type => ID_Pair,
         To_Input   => To_ID_Pair
      );
   
   type ID_List is array( Day1_Input.Input_Index range <> ) of Integer;
   
   Left_List  : ID_List := (for Pair of Day1_Input.Inputs => Pair.Left);
   Right_List : ID_List := (for Pair of Day1_Input.Inputs => Pair.Right);
   
   procedure Sort_Day1_Input is new Ada.Containers.Generic_Array_Sort(
         Index_Type   => Day1_Input.Input_Index,
         Element_Type => Integer,
         Array_Type   => ID_List
      );
   
   Distance_Sum : Integer := 0;
   
   -- Part 2 stuff
   function Similarity_Score ( Left_ID : Integer ) return Integer is
      Count : Natural := 0;
   begin
      for Right_ID of Right_List loop
         if Left_ID = Right_ID then
            Count := Count + 1;
         end if;
      end loop;
      
      return Left_ID * Count;
   end Similarity_Score;
   
   Total_Similarity : Integer := 0;
begin
   -- Part 1
   -- Sort lists
   Sort_Day1_Input(Left_List);
   Sort_Day1_Input(Right_List);
   
   -- Compute distances, sum totals
   for Idx in Left_List'Range loop
      Distance_Sum := Distance_Sum + abs (Left_List(Idx) - Right_List(Idx));
   end loop;
   
   Put_Line("Part 1: Sum is: " & Distance_Sum'Image);
   
   -- Part 2
   -- Iterate through Left_List and sum similarities
   for Left_ID of Left_List loop
      Total_Similarity := Total_Similarity + Similarity_Score(Left_ID);
   end loop;
   
   Put_Line("Part 2: Total Similarity is: " & Total_Similarity'Image);
end Day1Alt;