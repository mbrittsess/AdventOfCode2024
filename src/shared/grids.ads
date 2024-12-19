with Integer_Vector; use Integer_Vector;
with Ada.Iterator_Interfaces;

generic
   type Element_Type is private;
package Grids is
   type Grid is array(Positive range <>, Positive range <>) of Element_Type;
   
   type Access_Grid is access all Grid;

   type Cursor is private;

   function Element ( G : in Grid; Row, Col : Positive ) return Element_Type;
   function Element ( G : in Grid; V : Vector ) return Element_Type;
   function Element ( C : Cursor ) return Element_Type;
   
   procedure Assign_Element ( G : in out Grid; Row, Col : Positive; Value : Element_Type );
   procedure Assign_Element ( G : in out Grid; Pos : Vector; Value : Element_Type );
   
   function Position ( C : Cursor ) return Vector;
   
   function In_Grid ( G : in Grid; Row, Col : Integer ) return Boolean;
   function In_Grid ( G : in Grid; V : Vector ) return Boolean;

   function Has_Element ( C : Cursor ) return Boolean;

   package Grid_Iterator_Interfaces is new
      Ada.Iterator_Interfaces( Cursor => Cursor, Has_Element => Has_Element );
   
   type Grid_Iterator is new Grid_Iterator_Interfaces.Forward_Iterator
      with record
         Grid : Access_Grid;
      end record;
   
   overriding function First ( GI : Grid_Iterator ) return Cursor;
   overriding function Next ( GI : Grid_Iterator; C : Cursor ) return Cursor;
   
   function Iterate ( G : Access_Grid ) return Grid_Iterator;

private
   type Cursor is
      record
         Grid : Access_Grid;
         Position : Vector;
      end record;
end Grids;