with Ada.Text_IO; use Ada.Text_IO;

package body Day5.Get_Input is
   function Read_Rules return Page_Ordering_Rules is
      Rules : Page_Ordering_Rules := ( others => ( others => False ) );

      package PNIO renames Day5.Page_Number_IO;
   begin
      loop
         declare
            Line : String := Get_Line;
            First, Second : Page_Number;
            Last_Pos : Positive;
         begin
            exit when Line'Length = 0;

            -- Get the first number
            PNIO.Get(Line, First, Last_Pos); -- out First, out Last_Pos
            -- Get the second; skip past the separating vertical-bar
            PNIO.Get(Line(Last_Pos+2 .. Line'Last), Second, Last_Pos); -- out Second, out Last_Pos

            Rules(First,Second) := True;
         end;
      end loop;

      return Rules;
   end Read_Rules;

   Rules : constant Page_Ordering_Rules := Read_Rules;

   function Get_Rules return Page_Ordering_Rules is
   begin
      return Rules;
   end Get_Rules;
end Day5.Get_Input;