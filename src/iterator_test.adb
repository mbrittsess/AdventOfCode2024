with Ada.Text_IO; use Ada.Text_IO;
with Grid_Input;
with Ada.Iterator_Interfaces;
with Integer_Vector; use Integer_Vector;

procedure Iterator_Test is
   In_Grid : aliased Grid_Input.Character_Grid := Grid_Input.Get_Grid_Input;
   
   type Access_Grid is access all Grid_Input.Character_Grid;
   
   type Grid_Cursor is
      record
         Grid : Access_Grid;
         Pos  : Vector;
      end record;
   
   function Element ( C : Grid_Cursor ) return Character is
   begin
      return C.Grid.all(C.Pos(2), C.Pos(1));
   end Element;
   
   function Has_Element ( C : Grid_Cursor ) return Boolean is
   begin
      return C.Pos(1) in C.Grid.all'Range(2) and then C.Pos(2) in C.Grid.all'Range(1);
   end Has_Element;
   
   package Grid_Iterator_Interfaces is new
      Ada.Iterator_Interfaces( Cursor => Grid_Cursor, Has_Element => Has_Element );
   
   type Grid_Iterator is new Grid_Iterator_Interfaces.Forward_Iterator
      with record
         Grid : Access_Grid;
      end record;
   
   overriding function First ( GI : Grid_Iterator ) return Grid_Cursor;
   overriding function Next ( GI : Grid_Iterator ; C : Grid_Cursor ) return Grid_Cursor;
   
   overriding function First ( GI : Grid_Iterator ) return Grid_Cursor is
   begin
      return ( Grid => GI.Grid, Pos => (1,1) );
   end First;
   
   overriding function Next ( GI : Grid_Iterator; C : Grid_Cursor ) return Grid_Cursor is
      At_Row_End : Boolean := C.Pos(1) = C.Grid.all'Last(2);
   begin
      if At_Row_End then
         return ( Grid => C.Grid, Pos => (1, C.Pos(2) + 1) );
      else
         return ( Grid => C.Grid, Pos => (C.Pos(1) + 1, C.Pos(2)) );
      end if;
   end Next;
   
   function Iterate ( G : Access_Grid ) return Grid_Iterator is
   begin
      return ( Grid => G );
   end Iterate;
begin
   Put_Line("Iterator test");
   declare
      L : String := [for Char of In_Grid when Char /= '.' => Char];
      N : Natural := [for Char of In_Grid when Char /= '.' => 1]'Reduce("+", 0);
   begin
      Put_Line(L);
      Put_Line(N'Image);
      for C in Iterate(In_Grid'Access) loop
         Put_Line(To_String(C.Pos));
      end loop;
   end;
end Iterator_Test;