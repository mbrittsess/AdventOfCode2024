with Character_Grids;
with Integer_Vector; use Integer_Vector;
with Ada.Text_IO; use Ada.Text_IO;

package body Day15.Input is
   function Get_Map return Character_Grids.Grid is
      function Get_Map_Iter ( Old_Grid : Character_Grids.Grid ) return Character_Grids.Grid is
         New_Grid : Character_Grids.Grid(Old_Grid'First(1) .. Old_Grid'Last(1)+1, Old_Grid'Range(2));
         Line : String := Get_Line;
      begin
         if Line = "" then
            return Old_Grid;
         else
            for Row in Old_Grid'Range(1) loop
               for Col in Old_Grid'Range(2) loop
                  New_Grid(Row,Col) := Old_Grid(Row,Col);
               end loop;
            end loop;
            
            for Col in Old_Grid'Range(2) loop
               new_Grid(New_Grid'Last(1), Col) := Line(Col);
            end loop;
            
            return Get_Map_Iter(New_Grid);
         end if;
      end Get_Map_Iter;
   
      First_Row : String := Get_Line;
      First_Grid : Character_Grids.Grid(1..1, First_Row'Range);
   begin
      for Col in First_Row'Range loop
         First_Grid(1,Col) := First_Row(Col);
      end loop;
      
      return Get_Map_Iter(First_Grid);
   end Get_Map;
   
   function Get_Movelist ( Partial : String := "" ) return String is
   begin
      if not End_Of_File then
         return Get_Movelist( Partial & Get_Line );
      else
         return Partial;
      end if;
   end Get_Movelist;
   
   function Get_Robot_Start_Position ( Raw_Grid : Character_Grids.Grid ) return Vector is
   begin
      for Row in Raw_Grid'Range(1) loop
         for Col in Raw_Grid'Range(2) loop
            if Raw_Grid(Row,Col) = '@' then
               return (Col,Row);
            end if;
         end loop;
      end loop;
      raise Constraint_Error with "No robot position found";
   end Get_Robot_Start_Position;
   
   function Raw_Move_To_Move ( Char : Character ) return Direction is
   begin
      case Char is
         when '>' => return Right;
         when '^' => return Up;
         when '<' => return Left;
         when 'v' => return Down;
         when others => raise Constraint_Error with "Unrecognized move character";
      end case;
   end Raw_Move_To_Move;
   
   function Raw_Warehouse_To_Warehouse ( Raw_Grid : Character_Grids.Grid ) return Warehouse_Grids.Grid is
      Ret_Grid : Warehouse_Grids.Grid(Raw_Grid'Range(1), Raw_Grid'Range(2));
   begin
      for Row in Raw_Grid'Range(1) loop
         for Col in Raw_Grid'Range(2) loop
            case Raw_Grid(Row,Col) is
               when '#'    => Ret_Grid(Row,Col) := Wall;
               when 'O'    => Ret_Grid(Row,Col) := Box;
               when '.'    => Ret_Grid(Row,Col) := Empty;
               when '@'    => Ret_Grid(Row,Col) := Robot;
               when others => raise Constraint_Error with "Unrecognized space character";
            end case;
         end loop;
      end loop;
      
      return Ret_Grid;
   end Raw_Warehouse_To_Warehouse;
   
   Raw_Grid : constant Character_Grids.Grid := Get_Map;
   Raw_Movelist : constant String := Get_Movelist;
   
   Start_Pos : constant Vector := Get_Robot_Start_Position(Raw_Grid);
   Mapped_Warehouse : constant Warehouse_Grids.Grid := Raw_Warehouse_To_Warehouse(Raw_Grid);
   Mapped_Movelist : constant Movelist_Type := [for Char of Raw_Movelist => Raw_Move_To_Move(Char)];
   
   function Warehouse_Input return Warehouse_Grids.Grid is (Mapped_Warehouse);
   function Robot_Start_Pos return Vector is (Start_Pos);
   function Movelist_Input return Movelist_Type is (Mapped_Movelist);
end Day15.Input;