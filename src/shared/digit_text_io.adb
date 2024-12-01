package body Digit_Text_IO is
   function To_Integer ( D : Digit ) return Integer is
   begin
      return Digit'Pos(D) - Digit'Pos('0');
   end To_Integer;
end Digit_Text_IO;