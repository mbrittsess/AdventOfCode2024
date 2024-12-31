with Grids;
with Integer_Vector; use Integer_Vector;

package Day15 is
   type All_Space_Content is (Wall, Box, Empty, Robot);
   subtype Space_Content is All_Space_Content range Wall .. Empty;
   type Direction is (Right, Up, Left, Down);
   
   Direction_To_Vector_Map : constant array(Direction) of Vector :=
   (
      Right => ( 1, 0),
      Up    => ( 0,-1),
      Left  => (-1, 0),
      Down  => ( 0, 1)
   );
   
   type Movelist_Type is array(Positive range <>) of Direction;
   
   Content_To_Character_Map : constant array(All_Space_Content) of Character :=
   (
      Wall  => '#',
      Box   => 'O',
      Empty => '.',
      Robot => '@'
   );
   
   package Warehouse_Grids is new Grids(All_Space_Content);
   
   procedure Print_Warehouse (Warehouse : Warehouse_Grids.Grid);
end Day15;