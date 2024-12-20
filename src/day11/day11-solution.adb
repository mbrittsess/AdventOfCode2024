with Ada.Text_IO; use Ada.Text_IO;

procedure Day11.Solution is
   Input_Stones : Stone_Sequence := Get_Input_Sequence;
   
   function Blink ( Seq : Stone_Sequence ) return Stone_Sequence is
      -- Array is (probably) larger than necessary, it gets trimmed when returning
      Ret_Seq : Stone_Sequence(1 .. Seq'Length*2);
      Out_Idx : Positive := Ret_Seq'First;
   begin
      for Stone of Seq loop
         declare
            Num_Digits : Positive := Count_Digits(Stone);
         begin
            if Stone = 0 then
               Ret_Seq(Out_Idx) := 1;
            elsif Num_Digits mod 2 = 0 then
               declare
                  Mod_Size : Positive := 10**(Num_Digits/2);
                  Right_Half : Stone_Number := Stone mod Stone_Number(Mod_Size);
                  Left_Half : Stone_Number := Stone / Stone_Number(Mod_Size);
               begin
                  Ret_Seq(Out_Idx) := Left_Half;
                  Ret_Seq(Out_Idx+1) := Right_Half;
                  Out_Idx := @+1;
               end;
            else
               Ret_Seq(Out_Idx) := Stone*2024;
            end if;
            Out_Idx := @+1;
         end;
      end loop;
      
      return Ret_Seq(Ret_Seq'First .. Out_Idx-1);
   end Blink;
   
   function Recurse_Blink ( Seq : Stone_Sequence; Depth : Natural ) return Stone_Sequence is
   begin
      if Depth = 0 then
         return Seq;
      else
         return Recurse_Blink(Blink(Seq), Depth-1);
      end if;
   end Recurse_Blink;
begin
   Put_Line("Result stone count, part 1: " & Recurse_Blink(Input_Stones, 25)'Length'Image);
   --Put_Line("Result stone count, part 2: " & Recurse_Blink(Input_Stones, 75)'Length'Image);
end Day11.Solution;