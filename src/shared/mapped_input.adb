with Ada.Text_IO; use Ada.Text_IO;

package body Mapped_Input is
   function Get_Inputs ( I : Input_Collection ) return Input_Collection is
   begin
      if End_Of_File then
         return I;
      else
         return Get_Inputs( I & To_Input(Get_Line) );
      end if;
   end Get_Inputs;
   
   function Get_Inputs return Input_Collection is
      I : Input_Collection(1..1) := (1 => To_Input(Get_Line));
   begin
      return Get_Inputs(I);
   end Get_Inputs;
   
   All_Inputs : constant Input_Collection := Get_Inputs;
   
   function Inputs return Input_Collection is
   begin
      return All_Inputs;
   end Inputs;
end Mapped_Input;