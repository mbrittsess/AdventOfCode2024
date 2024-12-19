with Grids;
with Map_Grid;
with Character_Grids;
with Get_Input_Grid;

package Day10 is
   subtype Height is Integer range 0 .. 9;
   
   package Height_Grids is new Grids(Height);
   
   function To_Height ( Curs : Character_Grids.Cursor ) return Height is
      (Character'Pos(Character_Grids.Element(Curs)) - Character'Pos('0'));
   
   function Map_Input_To_Height is new Map_Grid
      (
         From_Type  => Character,
         To_Type    => Height,
         From_Grids => Character_Grids,
         To_Grids   => Height_Grids,
         Convert    => To_Height
      );
   
   Raw_Grid : aliased Character_Grids.Grid := Get_Input_Grid;
   
   Height_Map : constant Height_Grids.Grid := Map_Input_To_Height(Raw_Grid'Access);
      
end Day10;