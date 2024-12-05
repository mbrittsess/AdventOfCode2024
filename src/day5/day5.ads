with Ada.Text_IO;

package Day5 is
   type Page_Number is range 1 .. 99;

   type Page_Ordering_Rules is array( Page_Number, Page_Number ) of Boolean;

   package Page_Number_IO is new Ada.Text_IO.Integer_IO( Num => Page_Number );
end Day5;