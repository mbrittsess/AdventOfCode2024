with Ada.Strings.Fixed; use Ada.Strings.Fixed;

package body Day7.Get_Input is
   function Get_Number ( From : in String; Last : out Positive ) return Number is
      Ret : Number;
   begin
      IO.Get(From, Ret, Last); -- out Ret, out Last
      return Ret;
   end Get_Number;

   function To_Equation ( S : String ) return Ref_Equation is
      --Ada.Text_IO.Integer_Text_IO doesn't like the colon right at the end of a number
      Colon_Idx : Natural := Index(S, ":");
      End_Of_Result : Positive;
      Result : Number := Get_Number(S(S'First .. Colon_Idx-1), End_Of_Result);
      Num_Operands : Natural := Count(S, " ");
      Operand_End : Positive := End_Of_Result+1;
      Operands : array(1 .. Num_Operands) of Number;
   begin
      for Op_Idx in Operands'Range loop
         Operands(Op_Idx) := Get_Number(S(Operand_End+1 .. S'Last), Operand_End); -- out Operand_End
      end loop;

      return new Equation'(
         N        => Num_Operands,
         Result   => Result,
         Operands => (for Op of Operands => Op)
      );
   end To_Equation;
end Day7.Get_Input;