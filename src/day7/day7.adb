package body Day7 is
   function Check_Equation (
      Result : Number;
      Acc : Number;
      Operands : Operand_List;
      Cur_Op_Idx : Positive
   ) return Boolean is
      Cur_Operand : Number := Operands(Cur_Op_Idx);

      Mul_Result : Number := Acc * Cur_Operand;
      Add_Result : Number := Acc + Cur_Operand;

      Mul_Failed : Boolean := Mul_Result > Result;
      Add_Failed : Boolean := Add_Result > Result;
   begin
      if Cur_Op_Idx = Operands'Last then
         return Result in Mul_Result | Add_Result;
      else
         return ((not Mul_Failed) and then Check_Equation(
            Result,
            Mul_Result,
            Operands,
            Cur_Op_Idx+1
         )) or else ((not Add_Failed) and then Check_Equation(
            Result,
            Add_Result,
            Operands,
            Cur_Op_Idx+1
         ));
      end if;
   end Check_Equation;

   function Can_Be_True ( E : Ref_Equation ) return Boolean is
   begin
      return Check_Equation(
         Result     => E.Result,
         Acc        => E.Operands(1),
         Operands   => E.Operands,
         Cur_Op_Idx => 2
      );
   end Can_Be_True;
end Day7;