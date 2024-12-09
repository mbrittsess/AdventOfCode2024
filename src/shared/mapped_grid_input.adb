with Grid_Input;

package body Mapped_Grid_Input is
   Raw_Grid : constant Grid_Input.Character_Grid := Grid_Input.Get_Grid_Input;

   Mapped_Grid : constant Input_Grid :=
      (for Row_Idx in Input_Index(Raw_Grid'First(1)) .. Input_Index(Raw_Grid'Last(1)) =>
         (for Col_Idx in Input_Index(Raw_Grid'First(2)) .. Input_Index(Raw_Grid'Last(2)) =>
            To_Input(Raw_Grid(Integer(Row_Idx),Integer(Col_Idx)), Positive(Row_Idx), Positive(Col_Idx))));
   
   function Get_Grid_Input return Input_Grid is
   begin
      return Mapped_Grid;
   end Get_Grid_Input;
end Mapped_Grid_Input;