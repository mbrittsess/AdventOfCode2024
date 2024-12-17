with Ada.Text_IO; use Ada.Text_IO;
with Character_Grids; use Character_Grids;

function Get_Input_Grid return Grid is
   First_Line : String := Get_Line;
   First_Grid : Grid(1..1, First_Line'Range);
   
   function Get_Input ( G : Grid ) return Grid is
   begin
      if End_Of_File then
         return G;
      else
         declare
            Line : String := Get_Line;
            New_G : Grid(G'First(1) .. G'Last(1)+1, G'Range(2));
         begin
            for Row in G'Range(1) loop
               for Col in G'Range(2) loop
                  New_G(Row,Col) := G(Row,Col);
               end loop;
            end loop;
            
            for Col in Line'Range loop
               New_G(New_G'Last(1), Col) := Line(Col);
            end loop;
            
            return Get_Input(New_G);
         end;
      end if;
   end Get_Input;
begin
   return Get_Input(First_Grid);
end Get_Input_Grid;