with Integer_Vector; use Integer_Vector;
with Ada.Iterator_Interfaces;

generic
   type Element_Type;
package Grids is
   type Grid is array(Positive range <>, Positive range <>) of Element_Type;

   type Cursor is private;

   function Element ( G : in out constant Grid; Row, Col : Positive ) return Element_Type;
   function Element ( G : in out constant Grid; V : Integer_Vector ) return Element_Type;
   function Element ( C : Cursor ) return Element_Type;

   function Has_Element ( C : Grid_Cursor ) return Boolean;

   package Grid_Iterator_Interfaces is new
      Ada.Iterator_Interfaces( Cursor => Cursor, Has_Element => Has_Element );
end Grids;