with Ada.Integer_Text_IO;

package body Functional_Integer_Text_IO is
   function Get return Integer is
      I : Integer;
   begin
      Ada.Integer_Text_IO.Get(I);
      return I;
   end Get;

   function Get ( From : in String; Last : out Positive ) return Integer is
      I : Integer;
   begin
      Ada.Integer_Text_IO.Get(From, I, Last);
      return I;
   end Get;
end Functional_Integer_Text_IO;