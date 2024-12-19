with Ada.Text_IO; use Ada.Text_IO;
with Integer_Vector; use Integer_Vector;

procedure Day10.Solution is
   package Bool_Grids is new Grids(Boolean);
   
   procedure Search_Trail
      (
         Visited : in out Bool_Grids.Grid;
         Score : in out Natural;
         Position : Vector;
         Prev_Height : Height;
         First : Boolean
      )
   is
      function Cur_Height return Height is (Height_Grids.Element(Height_Map, Position));
   begin
      -- Are we off the map entirely?
      if not Height_Grids.In_Grid(Height_Map, Position) then
         return;
      end if;
      
      -- Are we not at the right height relative to previous square? (ignore if on starting square)
      if not First and then Prev_Height+1 /= Cur_Height then
         return;
      end if;
      
      -- Have we been here before when mapping out this trail?
      if Bool_Grids.Element(Visited, Position) then
         return;
      else
         -- No? Mark it
         Bool_Grids.Assign_Element(Visited, Position, True);
      end if;
      
      -- Are we at a peak?
      if Cur_Height = 9 then
         Score := @ + 1;
         return;
      else
         -- Need to branch out
         for Direction of Four_Directions loop
            Search_Trail(Visited, Score, Position+Direction, Cur_Height, False);
         end loop;
         
         return;
      end if;
   end Search_Trail;
   
   Total_Score : Natural := 0;
begin
   for Row in Height_Map'Range(1) loop
      for Col in Height_Map'Range(2) loop
         if Height_Map(Row,Col) = 0 then
            declare
               Score : Natural := 0;
               Trailhead_Pos : Vector := (Col,Row);
               Visited_Map : Bool_Grids.Grid(Height_Map'Range(1), Height_Map'Range(2)) := ( others => ( others => False ) );
            begin
               Search_Trail(Visited_Map, Score, Trailhead_Pos, 0, True);
               --Put_Line("Trailhead at " & To_String(Trailhead_Pos) & " has score of " & Score'Image);
               Total_Score := Total_Score + Score;
            end;
         end if;
      end loop;
   end loop;
   
   Put_Line("Part 1: " & Total_Score'Image);
end Day10.Solution;