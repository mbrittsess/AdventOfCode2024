with Ada.Text_IO; use Ada.Text_IO;
with Grid_Input; use Grid_Input;
with Integer_Vector; use Integer_Vector;

procedure Day4 is
   Grid : constant Character_Grid := Get_Grid_Input;

   Directions : array( 1 .. 8 ) of Vector := (
      ( 1, 0),
      ( 1, 1),
      ( 0, 1),
      (-1, 1),
      (-1, 0),
      (-1,-1),
      ( 0,-1),
      ( 1,-1)
   );

   function In_Grid ( V : Vector ) return Boolean is
      (V(1) in Grid'Range(2) and then V(2) in Grid'Range(1));

   function Char_At ( V : Vector ) return Character is
   begin
      if not In_Grid(V) then
         raise Constraint_Error with "Location " & To_String(V) & " is not in grid, which has bounds "
            & "(1.." & Grid'Length(2)'Image & "," -- Row length, or number of columns
            & "1.." & Grid'Length(1)'Image & ")"; -- Col length, or number of rows
      else
         return Grid(V(2),V(1));
      end if;
   end Char_At;

   Number_Of_Matches : Natural := 0;
begin
   -- Iterate over whole grid
   for Y in Grid'Range(1) loop
      for X in Grid'Range(2) loop
         declare
            Pos : Vector := (X,Y);
            Char : Character := Char_At(Pos);
         begin
            if Char = 'X' then -- Are we at the start of a potential string?
               for Dir of Directions loop -- Try looking in every direction
                  if In_Grid(Pos + Dir*3) then -- Is there enough space to hold the string?
                     if          Char_At(Pos + Dir*1) = 'M'
                        and then Char_At(Pos + Dir*2) = 'A'
                        and then Char_At(Pos + Dir*3) = 'S'
                     then
                        Number_Of_Matches := @ + 1;
                     end if;
                  end if;
               end loop;
            end if;
         end;
      end loop;
   end loop;

   Put_Line("Number of matches: " & Number_Of_Matches'Image);
end Day4;