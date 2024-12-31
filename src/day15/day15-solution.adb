with Day15.Input; use Day15.Input;
with Ada.Text_IO; use Ada.Text_IO;
with Integer_Vector; use Integer_Vector;

procedure Day15.Solution is
   use Warehouse_Grids;
   
   Warehouse : Warehouse_Grids.Grid := Warehouse_Input;
   Robot_Pos : Vector := Robot_Start_Pos;
   Moves : Movelist_Type := Movelist_Input;
   
   procedure Push_Item ( Warehouse : in out Warehouse_Grids.Grid; Item_Pos, Move_Dir : Vector ) is
      Own_Element : All_Space_Content := Element(Warehouse, Item_Pos);
   begin
      if Own_Element not in Robot | Box then
         -- Can't be moved
         return;
      else
         declare
            Dest_Pos : Vector := Item_Pos + Move_Dir;
         begin
            -- Try to push something in case there's something there
            Push_Item(Warehouse, Dest_Pos, Move_Dir);
            -- Then see if there's space to move into
            if Element(Warehouse, Dest_Pos) /= Empty then
               -- No space available and couldn't be moved out of the way
               return;
            else
               -- Update locations
               Assign_Element(Warehouse, Dest_Pos, Own_Element);
               Assign_Element(Warehouse, Item_Pos, Empty);
               return;
            end if;
         end;
      end if;
   end Push_Item;
   
   procedure Advance_Simulation ( Move : Direction ) is
      Move_Vec : Vector := Direction_To_Vector_Map(Move);
      Dest_Pos : Vector := Robot_Pos + Move_Vec;
   begin
      Push_Item(Warehouse, Robot_Pos, Move_Vec);
      if Element(Warehouse, Robot_Pos) = Robot then
         --Robot wasn't able to move
         null;
      else
         Robot_Pos := Dest_Pos;
      end if;
   end Advance_Simulation;
   
   function Compute_Score ( Warehouse : in Warehouse_Grids.Grid ) return Integer is
      Score : Integer := 0;
   begin
      for Row in Warehouse'Range(1) loop
         for Col in Warehouse'Range(1) loop
            if Element(Warehouse, Row, Col) = Box then
               Score := @ + (Row-1)*100 + (Col-1);
            end if;
         end loop;
      end loop;
      
      return Score;
   end Compute_Score;
begin
   --Put_Line("Starting warehouse state:");
   --Print_Warehouse(Warehouse);
   --New_Line;
   
   for Move of Moves loop
      Advance_Simulation(Move);
      --Put_Line("Next state (move " & Move'Image & "):");
      --Print_Warehouse(Warehouse);
      --New_Line;
   end loop;
   
   Put_Line("Score is: " & Compute_Score(Warehouse)'Image);
      
end Day15.Solution;