package body Grids is
   function Element ( G : in out Grid; Row, Col : Positive ) return Element_Type is
   begin
      return G(Row,Col);
   end Element;
   
   function Element ( G : in out Grid; V : Vector ) return Element_Type is
   begin
      return G(V(2), V(1));
   end Element;
   
   function Element ( C : Cursor ) return Element_Type is
   begin
      return Element(C.Grid.all, C.Position);
   end Element;
   
   procedure Assign_Element ( G : in out Grid; Row, Col : Positive; Value : Element_Type ) is
   begin
      G(Row,Col) := Value;
   end Assign_Element;
   
   procedure Assign_Element ( G : in out Grid; Pos : Vector; Value : Element_Type ) is
   begin
      Assign_Element(G, Pos(2), Pos(1), Value);
   end Assign_Element;
   
   function Position ( C : Cursor ) return Vector is
   begin
      return C.Position;
   end Position;
   
   function In_Grid ( G : in out Grid; Row, Col : Integer ) return Boolean is
   begin
      return Row in G'Range(1) and then Col in G'Range(2);
   end In_Grid;
   
   function In_Grid ( G : in out Grid; V : Vector ) return Boolean is
   begin
      return In_Grid(G, V(2), V(1));
   end In_Grid;
   
   function Has_Element ( C : Cursor ) return Boolean is
   begin
      return In_Grid(C.Grid.all, C.Position);
   end Has_Element;
   
   overriding function First ( GI : Grid_Iterator ) return Cursor is
   begin
      return ( Grid => GI.Grid, Position => (GI.Grid.all'First(2), GI.Grid.all'First(1)) );
   end First;
   
   overriding function Next ( GI : Grid_Iterator; C : Cursor ) return Cursor is
   begin
      if C.Position(1) = C.Grid.all'Last(2) then -- Last column?
         -- X is now the first column position, Y is one more than it was before
         return ( Grid => C.Grid, Position => (C.Grid.all'First(2), C.Position(2)+1) );
      else
         -- X is now one more than before, Y is the same as before
         return ( Grid => C.Grid, Position => (C.Position(1)+1, C.Position(2)) );
      end if;
   end Next;
   
   function Iterate ( G : Access_Grid ) return Grid_Iterator is
   begin
      return ( Grid => G );
   end Iterate;
end Grids;