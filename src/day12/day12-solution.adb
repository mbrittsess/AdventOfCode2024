with Ada.Text_IO; use Ada.Text_IO;
with Character_Grids;
with Get_Input_Grid;
with Grids;
with Integer_Vector; use Integer_Vector;

procedure Day12.Solution is
   package Plant_Grids renames Character_Grids;
   package Region_Grids is new Grids(Region_Index);
   
   use Plant_Grids; use Region_Grids;
   
   Plant_Map : constant Plant_Grids.Grid := Get_Input_Grid;
   Region_Map : Region_Grids.Grid(Plant_Map'Range(1), Plant_Map'Range(2)) := ( others => ( others => Null_Region ) );
   
   procedure Mark_And_Spread
   (
      Region : Valid_Region_Index;
      Plant : Plant_Kind;
      Position : Vector
   ) is
   begin
      if          In_Grid(Plant_Map, Position)
         and then Element(Plant_Map, Position) = Plant
         and then Element(Region_Map, Position) = Null_Region
      then
         Assign_Element(Region_Map, Position, Region);
         for Dir of Four_Directions loop
            Mark_And_Spread(Region, Plant, Position+Dir);
         end loop;
      else
         return;
      end if;
   end Mark_And_Spread;
   
   Next_Index : Valid_Region_Index := 1;
   function Get_Next_Index return Valid_Region_Index is
      Ret_Index : Valid_Region_Index := Next_Index;
   begin
      Next_Index := @ + 1;
      return Ret_Index;
   end Get_Next_Index;
   
   subtype Long_Long_Natural is Long_Long_Integer range 0 .. Long_Long_Integer'Last;
   function Compute_Region_Price ( Region : Region_Properties ) return Long_Long_Natural is
   begin
      return Long_Long_Integer(Region.Area) * Long_Long_Integer(Region.Perimeter);
   end Compute_Region_Price;
begin
   -- Fill in the region map
   for Row in Plant_Map'Range(1) loop
      for Col in Plant_Map'Range(2) loop
         if Region_Map(Row,Col) = Null_Region then
            Mark_And_Spread(Get_Next_Index, Plant_Map(Row,Col), (Col,Row));
         end if;
      end loop;
   end loop;
   
   -- Calculate price of fencing
   declare
      Last_Region : constant Valid_Region_Index := Next_Index-1;
      Properties : array (1 .. Last_Region) of Region_Properties := ( others => ( Area => 0, Perimeter => 0 ) );
   begin
      -- Calculate area and perimeter of each region
      for Row in Plant_Map'Range(1) loop
         for Col in Plant_Map'Range(2) loop
            declare
               Region : Valid_Region_Index := Region_Map(Row,Col);
               Position : Vector := (Col,Row);
            begin
               Properties(Region).Area := @+1;
               for Dir of Four_Directions loop
                  if not In_Grid(Plant_Map, Position+Dir) or else Element(Region_Map,Position+Dir) /= Region then
                     Properties(Region).Perimeter := @+1;
                  end if;
               end loop;
            end;
         end loop;
      end loop;
      
      Put_Line("Price of fencing: " & Long_Long_Natural'Image([for Prop of Properties => Compute_Region_Price(Prop)]'Reduce("+", Long_Long_Integer'(0))));
   end;
end Day12.Solution;