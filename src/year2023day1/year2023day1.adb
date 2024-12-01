--Used to get some practice with Alire prior to the 2024 challenges

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with Ada.Integer_Text_IO;
with Digit_Text_IO; use Digit_Text_IO;

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
               Right := To_Integer(Letter);
               if First_Found then
                  Left := Right;
               end if;
               First_Found := False;
            end if;
         end loop;
         Total := Total + (Left * 10) + Right;
      end;
   end loop;
   Put_Line("Sum is: " & Total'Image);
end Year2023Day1;