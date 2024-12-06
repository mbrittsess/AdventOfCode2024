with Grid_Input;

package body Mapped_Grid_Input is
   Raw_Grid : constant Grid_Input.Character_Grid := Grid_Input.Get_Grid_Input;

   Mapped_Grid : constant Input_Grid :=
      (for Row_Idx in Raw_Grid'Range(1) =>
         (for Col_Idx in Raw_Grid'Range(2) =>
            To_Input(Raw_Grid(Row_Idx,Col_Idx), Positive(Row_Idx), Positive(Col_Idx))));
   
   function Get_Grid_Input return Input_Grid is
   begin
      return Mapped_Grid;
   end Get_Grid_Input;
end Mapped_Grid_Input;