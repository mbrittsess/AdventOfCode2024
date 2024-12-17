with Ada.Text_IO; use Ada.Text_IO;
with Character_Grids;
with Get_Input_Grid;
with Integer_Vector; use Integer_Vector;

-- Feed it the day 8 input
procedure Grid_Test is
   use Character_Grids;
   subtype Character_Grid is Character_Grids.Grid;
   
   Input_Grid : aliased Character_Grid := Get_Input_Grid;
begin
   Put_Line("Hello, world!");
   
   Put_Line(Input_Grid'Length(1)'Image);
   Put_Line(Input_Grid'Length(2)'Image);
   
   for Curs in Iterate(Input_Grid'Access) loop
      Put_Line(To_String(Position(Curs)));
   end loop;
end Grid_Test;