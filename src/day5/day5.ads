with Ada.Text_IO;

package Day5 is
   type Page_Number is range 1 .. 99;

   -- Given pages A and B, Page_Ordering_Rules(A,B) indicates if A must come before B
   type Page_Ordering_Rules is array( Page_Number, Page_Number ) of Boolean;

   package Page_Number_IO is new Ada.Text_IO.Integer_IO( Num => Page_Number );
   
   type Pages_Update is array ( Positive range <> ) of Page_Number;
   
   type Pages_Update_List is array ( Positive range <> ) of access constant Pages_Update;
end Day5;