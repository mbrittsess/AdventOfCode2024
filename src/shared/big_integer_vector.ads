package Big_Integer_Vector is
   -- X, Y; not Row, Col
   subtype Vector_Component is Long_Long_Integer;
   subtype Natural_Component is Vector_Component range 0 .. Vector_Component'Last;
   subtype Positive_Component is Vector_Component range 1 .. Vector_Component'Last;
   type Vector is array( Positive range 1 .. 2 ) of Vector_Component;

   function "+" ( L, R : Vector ) return Vector is
      ( L(1)+R(1), L(2)+R(2) );
   
   function "-" ( L, R : Vector ) return Vector is
      ( L(1)-R(1), L(2)-R(2) );
   
   function "*" ( L : Vector; R : Integer ) return Vector is
      ( L(1)*Vector_Component(R), L(2)*Vector_Component(R) );

   function To_String ( V : Vector ) return String is
      ("(" & V(1)'Image & "," & V(2)'Image & ")");
   
   Four_Directions : constant array (Positive range <>) of Vector :=
      (
         ( 1, 0),
         ( 0, 1),
         (-1, 0),
         ( 0,-1)
      );
end Big_Integer_Vector;