package Functional_Integer_Text_IO is
   function Get return Integer;

   function Get ( From : in String; Last : out Positive ) return Integer;
end;