with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Strings.Fixed;

procedure Day2 is
   type Report_List is array ( Positive range <> ) of Integer;

   -- Analysis of the input file shows that each line has all numbers separated
   -- by a single space, so counting the number of spaces should correspond
   -- perfectly to the number of integers.
   function Count_Integers ( S : String ) return Natural is
      (Ada.Strings.Fixed.Count(S, " ") + 1);

   function Is_Safe ( RL : Report_List ) return Boolean is
      subtype Safe_Diff_Range is Integer range 1 .. 3;

      function All_Close ( RL : Report_List ) return Boolean is
         (for all Idx in (RL'First+1) .. RL'Last => (abs (RL(Idx) - RL(Idx-1))) in Safe_Diff_Range);
      
      function All_Increasing ( RL : Report_List ) return Boolean is
         (for all Idx in (Rl'First+1) .. RL'Last => RL(Idx) > RL(Idx-1));
      
      function All_Decreasing ( RL : Report_List ) return Boolean is
         (for all Idx in (RL'First+1) .. RL'Last => RL(Idx) < RL(Idx-1));

   begin
      return All_Close(RL) and then (All_Increasing(RL) or else All_Decreasing(RL));
   end Is_Safe;

   function Is_Safe ( S : String ) return Boolean is
      package IIO renames Ada.Integer_Text_IO;

      Levels : Report_List(1 .. Count_Integers(S));
      Cur_Level_Idx : Integer := 1;
      Last_Text_Pos : Integer := 0;
   begin
      -- Need to build up a Report_List and then call the other version of this function
      while Last_Text_Pos < S'Last loop
         IIO.Get(S(Last_Text_Pos+1 .. S'Last), Levels(Cur_Level_Idx), Last_Text_Pos); -- out Levels(~), out Last_Text_Pos
         Cur_Level_Idx := Cur_Level_Idx + 1;
      end loop;

      return Is_Safe(Levels);
   end Is_Safe;

   Num_Safe_Reports : Natural := 0;
begin
   while not End_Of_File loop
      if Is_Safe(Get_Line) then
         Num_Safe_Reports := Num_Safe_Reports + 1;
      end if;
   end loop;

   Put_Line("Number of safe reports: " & Num_Safe_Reports'Image);
end Day2;