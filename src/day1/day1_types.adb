with Ada.Integer_Text_IO;

package body Day1_Types is
   package IIO renames Ada.Integer_Text_IO;
   
   function To_ID_Pair ( S : String ) return ID_Pair is
      L, R : Integer;
      Last_Pos : Integer;
   begin
      IIO.Get(S, L, Last_Pos); -- out L, out Last_Pos
      IIO.Get(S(Last_Pos+1 .. S'Last), R, Last_Pos); -- out R, out Last_Pos
      return ( Left => L, Right => R );
   end To_ID_Pair;
end Day1_Types;