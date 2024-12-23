with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed;

package body Day13.Input is
   function Read_Machine_Input ( List : Machine_List := [] ) return Machine_List is
      A_Line, B_Line, Prize_Line : String := Get_Line;

      A_X : Positive_Component := Positive_Component'Value(A_Line(13..14));
      A_Y : Positive_Component := Positive_Component'Value(A_Line(19..20));
      A_Pos : Vector := (A_X, A_Y);

      B_X : Positive_Component := Positive_Component'Value(B_Line(13..14));
      B_Y : Positive_Component := Positive_Component'Value(B_Line(19..20));
      B_Pos : Vector := (B_X, B_Y);

      Comma_Pos : Positive := Ada.Strings.Fixed.Index(Prize_Line, ",");
      P_X : Positive_Component := Positive_Component'Value(Prize_Line(10..(Comma_Pos-1)));
      P_Y : Positive_Component := Positive_Component'Value(Prize_Line((Comma_Pos+4)..Prize_Line'Last));
      Prize_Pos : Vector := (P_X, P_Y);

      Machine_Info : Machine := ( A => A_Pos, B => B_Pos, Prize => Prize_Pos );
   begin
      if End_Of_File then -- Was this the last one?
         return List & Machine_Info;
      else -- Still more to go
         Skip_Line;
         return Read_Machine_Input(List & Machine_Info);
      end if;
   end Read_Machine_Input;
end Day13.Input;