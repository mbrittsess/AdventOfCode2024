package Day11 is
   subtype Stone_Number is Long_Long_Integer range 0 .. Long_Long_Integer'Last;
   type Stone_Sequence is array ( Positive range <> ) of Stone_Number;
   
   function Get_Input_Sequence return Stone_Sequence;
   
   function Count_Digits ( N : Stone_Number ) return Positive;
end Day11;