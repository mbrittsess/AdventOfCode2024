--Used to get some practice with Alire prior to the 2024 challenges

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with Ada.Integer_Text_IO;
with Test_Library;
procedure Year2023Day1 is
   package IIO renames Ada.Integer_Text_IO;
    
   Total : Integer := 0;
begin
   while not End_Of_File loop
      declare
         Line : String := Get_Line;
         Left, Right : Integer;
         First_Found : Boolean := True;
      begin
         for Letter of Line loop
            if Is_Digit(Letter) then
               declare
                  S : String(1..1) := (1 => Letter);
                  L : Positive; -- Not used, but need to have it
               begin
                  IIO.Get(S, Right, L); -- out Right, out L
                  if First_Found then
                     Left := Right;
                  end if;
                  First_Found := False;
               end;
            end if;
         end loop;
         Total := Total + (Left * 10) + Right;
      end;
   end loop;
   Put_Line("Sum is: " & Total'Image);
   Put_Line(Test_Library.Test_Function);
end Year2023Day1;