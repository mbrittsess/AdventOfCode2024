with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Strings.Fixed;

procedure Day2 is
   type Report_List is array ( Positive range <> ) of Integer;
   
   subtype Safe_Diff_Range is Integer range 1 .. 3;

   -- Analysis of the input file shows that each line has all numbers separated
   -- by a single space, so counting the number of spaces should correspond
   -- perfectly to the number of integers.
   function Count_Integers ( S : String ) return Natural is
      (Ada.Strings.Fixed.Count(S, " ") + 1);
   
   function Get_List return Report_List is
      package IIO renames Ada.Integer_Text_IO;

      Line : String := Get_Line;
      List : Report_List(1 .. Count_Integers(Line));
      Cur_Level_Idx : Integer := 1;
      Last_Text_Pos : Integer := 0;
   begin
      while Last_Text_Pos < Line'Last loop
         IIO.Get(Line(Last_Text_Pos+1 .. Line'Last), List(Cur_Level_Idx), Last_Text_Pos); -- out List(~), out Last_Text_Pos
         Cur_Level_Idx := Cur_Level_Idx + 1;
      end loop;
      
      return List;
   end Get_List;
   
   function Check_List (
      RL : Report_List;
      Idx : Positive;
      Prev_Level : Integer;
      Greater_Than_Result : Boolean;
      Bad_Level_Encountered : Boolean;
      In_Reverse : Boolean := False
   ) return Boolean is
      Cur_Level : Integer := RL(Idx);
      Diff_Magnitude_Good : Boolean := abs (Cur_Level - Prev_Level) in Safe_Diff_Range;
      Diff_Direction_Good : Boolean := (Cur_Level > Prev_Level) = Greater_Than_Result;
      Single_Check_Good : Boolean := Diff_Magnitude_Good and Diff_Direction_Good;
      At_End : Boolean := Idx = (if not In_Reverse then RL'Last else RL'First);
      Next_Idx : Integer := (if not In_Reverse then Idx+1 else Idx-1);
   begin
      if At_End then
         return Single_Check_Good or else not Bad_Level_Encountered;
      elsif Single_Check_Good then
         return Check_List(
            RL => RL,
            Idx => Next_Idx,
            Prev_Level => Cur_Level,
            Greater_Than_Result => Greater_Than_Result,
            Bad_Level_Encountered => Bad_Level_Encountered,
            In_Reverse => In_Reverse
         );
      elsif not Bad_Level_Encountered then -- First time encountering a bad level
         return Check_List(
            RL => RL,
            Idx => Next_Idx,
            Prev_Level => Prev_Level,
            Greater_Than_Result => Greater_Than_Result,
            Bad_Level_Encountered => True,
            In_Reverse => In_Reverse
         );
      else
         return False;
      end if;
   end Check_List;
   
   function Check_Increasing ( RL : Report_List; In_Reverse : Boolean ) return Boolean is
   begin
      if not In_Reverse then
         return Check_List(
            RL => RL,
            Idx => 2,
            Prev_Level => RL(1),
            Greater_Than_Result => True,
            Bad_Level_Encountered => False,
            In_Reverse => False
         );
      else
         return Check_List(
            RL => RL,
            Idx => RL'Last-1,
            Prev_Level => RL(RL'Last),
            Greater_Than_Result => True,
            Bad_Level_Encountered => False,
            In_Reverse => True
         );
      end if;
   end Check_Increasing;
   
   function Check_Decreasing ( RL : Report_List; In_Reverse : Boolean ) return Boolean is
   begin
      if not In_Reverse then
         return Check_List(
            RL => RL,
            Idx => 2,
            Prev_Level => RL(1),
            Greater_Than_Result => False,
            Bad_Level_Encountered => False,
            In_Reverse => False
         );
      else
         return Check_List(
            RL => RL,
            Idx => RL'Last-1,
            Prev_Level => RL(RL'Last),
            Greater_Than_Result => False,
            Bad_Level_Encountered => False,
            In_Reverse => True
         );
      end if;
   end Check_Decreasing;
   
   function Check_Line return Boolean is
      RL : Report_List := Get_List;
   begin
      return Check_Increasing(RL, False) or else Check_Decreasing(RL, False) or else Check_Increasing(RL, True) or else Check_Decreasing(RL, True);
   end Check_Line;

   Num_Safe_Reports : Natural := 0;
begin
   while not End_Of_File loop
      if Check_Line then
         Num_Safe_Reports := Num_Safe_Reports + 1;
      end if;
   end loop;

   Put_Line("Number of safe reports: " & Num_Safe_Reports'Image);
end Day2;