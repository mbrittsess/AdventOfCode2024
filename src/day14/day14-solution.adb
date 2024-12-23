with Day14.Get_Input;
with Ada.Text_IO; use Ada.Text_IO;
with Integer_Vector; use Integer_Vector;

procedure Day14.Solution is
   Robot_List : Robot_Info_List := Day14.Get_Input;
   Robot_Positions : Robot_Position_List(Robot_List'Range) := [for Robot of Robot_List => Robot.Start];

   -- Space depends on if this is example input or real input
   Space_Width : constant Integer := (if Robot_List'Length = 12 then 11 else 101);
   Space_Height : constant Integer := (if Robot_List'Length = 12 then 7 else 103);

   Middle_Width : constant Integer := Space_Width/2;
   Middle_Height : constant Integer := Space_Height/2;

   type Quadrant is range 1 .. 4;

   Quadrant_Counts : array ( Quadrant'Range ) of Natural := ( others => 0 );

   function In_Quadrant ( V : Vector ) return Boolean is
   begin
      return V(1) /= Middle_Width and then V(2) /= Middle_Height;
   end In_Quadrant;

   function Which_Quadrant ( V : Vector ) return Quadrant is
   begin
      if not In_Quadrant(V) then
         raise Constraint_Error;
      end if;

      if V(1) < Middle_Width then
         if V(2) < Middle_Height then
            return 2;
         else
            return 3;
         end if;
      else
         if V(2) < Middle_Height then
            return 1;
         else
            return 4;
         end if;
      end if;
   end Which_Quadrant;

   procedure Advance_Robots is
   begin
      for Idx in Robot_Positions'Range loop
         Robot_Positions(Idx)(1) := (@ + Robot_List(Idx).Velocity(1)) mod Space_Width;
         Robot_Positions(Idx)(2) := (@ + Robot_List(Idx).Velocity(2)) mod Space_Height;
      end loop;
   end Advance_Robots;
begin
   for Turn in 1 .. 100 loop
      Advance_Robots;
   end loop;

   for Position of Robot_Positions loop
      if In_Quadrant(Position) then
         Quadrant_Counts(Which_Quadrant(Position)) := @ + 1;
      end if;
   end loop;

   declare
      Safety_Factor : Natural := [for Count of Quadrant_Counts => Count]'Reduce("*", Natural'(1));
   begin
      Put_Line("Safety Factor: " & Safety_Factor'Image);
   end;
end Day14.Solution;