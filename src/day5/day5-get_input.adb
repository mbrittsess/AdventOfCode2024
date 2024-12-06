with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed;

package body Day5.Get_Input is
   package PNIO renames Day5.Page_Number_IO;
   
   function Read_Rules return Page_Ordering_Rules is
      Rules : Page_Ordering_Rules := ( others => ( others => False ) );
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
   
   function Count_Pages_In_Update ( S : String ) return Natural is
   begin
      return Ada.Strings.Fixed.Count(S, ",")+1;
   end Count_Pages_In_Update;
   
   function Read_Single_Update return access constant Pages_Update is
      Line : String := Get_Line;
      Update : Pages_Update(1 .. Count_Pages_In_Update(Line));
      
      Start_Pos : Positive := 1;
   begin
      for Idx in Update'Range loop
         PNIO.Get(Line(Start_Pos .. Line'Last), Update(Idx), Start_Pos); -- out Update(Idx), out Start_Pos
         Start_Pos := @ + 2;
      end loop;
      
      return new Pages_Update'(Update);
   end Read_Single_Update;
   
   function Read_Updates ( POR : Pages_Update_List := [] )return Pages_Update_List is
   begin
      if not End_Of_File then
         return Read_Updates( POR & [Read_Single_Update] );
      else
         return POR;
      end if;
   end Read_Updates;
   
   -- These two constants must be in this order so that Read_Rules and Read_Updates are called in the right order.
   Rules : constant Page_Ordering_Rules := Read_Rules;
   
   Updates : constant Pages_Update_List := Read_Updates;

   function Get_Rules return Page_Ordering_Rules is
   begin
      return Rules;
   end Get_Rules;
   
   function Get_Updates return Pages_Update_List is
   begin
      return Updates;
   end Get_Updates;
   
end Day5.Get_Input;