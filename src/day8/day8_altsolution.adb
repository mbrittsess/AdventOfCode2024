with Day8; use Day8;
with Character_Grids;
with Grids;
with Get_Input_Grid;
with Ada.Text_IO; use Ada.Text_IO;
with Integer_Vector; use Integer_Vector;

procedure Day8_AltSolution is
   package Bool_Grids is new Grids(Boolean);
   
   use Character_Grids;
   Raw_Grid : aliased Character_Grids.Grid := Get_Input_Grid;
   
   Num_Antennae : constant Positive := [for Char of Raw_Grid when Char /= '.' => 1]'Reduce("+", Natural'(0));
   
   Antenna_List : array( 1 .. Num_Antennae ) of Antenna;
   
   Antinode_Grid_Part1, Antinode_Grid_Part2 : Bool_Grids.Grid(Raw_Grid'Range(1), Raw_Grid'Range(2)) := ( others => ( others => False ) );
begin
   -- Fill in the antenna list
   declare
      Idx : Positive := Antenna_List'First;
   begin
      for Curs in Character_Grids.Iterate(Raw_Grid'Access) loop
         if Element(Curs) /= '.' then
            Antenna_List(Idx) := ( Frequency => Element(Curs), Position => Position(Curs) );
            Idx := @ + 1;
         end if;
      end loop;
   end;
   
   for A_Idx in Antenna_List'Range loop
      for B_Idx in Antenna_List'Range loop
         if A_Idx /= B_Idx then
            declare
               A : Antenna := Antenna_List(A_Idx);
               B : Antenna := Antenna_List(B_Idx);
            begin
               if A.Frequency = B.Frequency then
                  -- Part 1 solution
                  declare
                     Antinode : Vector := A.Position + (B.Position-A.Position)*2;
                  begin
                     if Bool_Grids.In_Grid(Antinode_Grid_Part1, Antinode) then
                        Bool_Grids.Assign_Element(Antinode_Grid_Part1, Antinode, True);
                     end if;
                  end;
                  
                  -- Part 2 solution
                  declare
                     Diff : Vector := B.Position - A.Position;
                  begin
                     -- First in one direction...
                     for Scale in 1 .. Integer'Last loop
                        declare
                           Antinode_Pos : Vector := A.Position + Diff*Scale;
                        begin
                           exit when not Bool_Grids.In_Grid(Antinode_Grid_Part2, Antinode_Pos);
                           Bool_Grids.Assign_Element(Antinode_Grid_Part2, Antinode_Pos, True);
                        end;
                     end loop;
                     
                     -- And then in the other
                     for Scale in reverse Integer'first .. -1 loop
                        declare
                           Antinode_Pos : Vector := A.Position + Diff*Scale;
                        begin
                           exit when not Bool_Grids.In_Grid(Antinode_Grid_Part2, Antinode_Pos);
                           Bool_Grids.Assign_Element(Antinode_Grid_Part2, Antinode_Pos, True);
                        end;
                     end loop;
                  end;
               end if;
            end;
         end if;
      end loop;
   end loop;
   
   declare
      Antinode_Count_1 : constant Positive := [for Present of Antinode_Grid_Part1 when Present => 1]'Reduce("+", Natural'(0));
      Antinode_Count_2 : constant Positive := [for Present of Antinode_Grid_Part2 when Present => 1]'Reduce("+", Natural'(0));
   begin
      Put_Line("Part 1 count: " & Antinode_Count_1'Image);
      Put_Line("Part 2 count: " & Antinode_Count_2'Image);
   end;
end Day8_AltSolution;