with Day8; use Day8;
with Character_Grids;
with Get_Input_Grid;
with Ada.Text_IO; use Ada.Text_IO;
with Integer_Vector; use Integer_Vector;

procedure Day8_AltSolution is
   use Character_Grids;
   Raw_Grid : aliased Character_Grids.Grid := Get_Input_Grid;
   
   type Character_List is array(Positive range <>) of Character;
   
   --Antenna_List : array(Positive range <>) of Antenna := [for Curs in Iterate(Raw_Grid'Access) when Element(Curs) /= '.' => (Frequency => Element(Curs), Position => Position(Curs))];
   Char_List : array ( Positive range <> ) of Character := [for Curs in Iterate(Raw_Grid'Access) => Element(Curs)];
begin
   --Put_Line("There are " & Antenna_List'Length'Image & " antennae");
   for Curs in Iterate(Raw_Grid'Access) loop
      Put_Line("!");
   end loop;
end Day8_AltSolution;