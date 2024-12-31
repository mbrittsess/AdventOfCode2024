with Ada.Text_IO; use Ada.Text_IO;

package body Day15 is
   procedure Print_Warehouse ( Warehouse : Warehouse_Grids.Grid ) is
   begin
      for Row in Warehouse'Range(1) loop
         for Col in Warehouse'Range(2) loop
            Put(Content_To_Character_Map(Warehouse_Grids.Element(Warehouse, Row, Col)));
         end loop;
         New_Line;
      end loop;
   end Print_Warehouse;
end Day15;