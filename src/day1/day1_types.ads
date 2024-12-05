package Day1_Types is
   type ID_Pair is
      record
         Left, Right : Integer;
      end record;
   
   function To_ID_Pair ( S : String ) return ID_Pair;
end Day1_Types;