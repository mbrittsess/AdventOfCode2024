package Integer_Vector is
   -- X, Y; not Row, Col
   type Vector is array( Positive range 1 .. 2 ) of Integer;

   function "+" ( L, R : Vector ) return Vector is
      ( L(1)+R(1), L(2)+R(2) );
   
   function "-" ( L, R : Vector ) return Vector is
      ( L(1)-R(1), L(2)-R(2) );
   
   function "*" ( L : Vector; R : Integer ) return Vector is
      ( L(1)*R, L(2)*R );

   function To_String ( V : Vector ) return String is
      ("(" & V(1)'Image & "," & V(2)'Image & ")");
   
   Four_Directions : constant array (Positive range <>) of Vector :=
      (
         ( 1, 0),
         ( 0, 1),
         (-1, 0),
         ( 0,-1)
      );
end Integer_Vector;