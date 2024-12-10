with Mapped_Input;
private with Day7.Get_Input;

package Day7.Input is
   Equations : constant Equation_List;
private
   package Equation_Input is new Mapped_Input(
      Input_Type => Ref_Equation,
      To_Input   => Day7.Get_Input.To_Equation
   );

   Equations : constant Equation_List := (for E of Equation_Input.Inputs => E);
end Day7.Input;