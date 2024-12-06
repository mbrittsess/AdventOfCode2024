generic
   type Input_Type is private;
   with function To_Input ( C : Character; Row, Col : Positive ) return Input_Type;

package Mapped_Grid_Input is
   type Input_Index is new Positive;
   type Input_Grid is array( Input_Index range <>, Input_Index range <> ) of Input_Type;

   function Get_Grid_Input return Input_Grid;
end Mapped_Grid_Input;