generic
   type Input_Type is private;
   with function To_Input ( S : String ) return Input_Type;

package Mapped_Input is
   type Input_Index is new Positive;
   type Input_Collection is array ( Input_Index range <> ) of Input_Type;
   function Inputs return Input_Collection;
   
end Mapped_Input;