package Digit_Text_IO is
   subtype Digit is Character range '0' .. '9';
   
   function To_Integer ( D : Digit ) return Integer;
end Digit_Text_IO;