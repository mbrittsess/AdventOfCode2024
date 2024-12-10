package body Day7 is
   -- Dumb implementation, but works
   function Num_Digits ( N : Number ) return Number is
      Acc : Number := 10;
      Dig : Number := 1;
   begin
      loop
         if Acc > N then
            return Dig;
         end if;

         Acc := Acc * 10;
         Dig := Dig + 1;
      end loop;
   end Num_Digits;

   function "&" ( L, R : Number ) return Number is
      Digs : Number := Num_Digits(R);
      Scaled_L : Number := L * Number(10**Natural(Digs));
   begin
      return Scaled_L + R;
   end "&";

   function Check_Equation (
      Result : Number;
      Acc : Number;
      Operands : Operand_List;
      Cur_Op_Idx : Positive;
      Do_Part2 : Boolean
   ) return Boolean is
      Cur_Operand : Number := Operands(Cur_Op_Idx);

      Mul_Result : Number := Acc * Cur_Operand;
      Add_Result : Number := Acc + Cur_Operand;
      Cat_Result : Number := Acc & Cur_Operand;

      Mul_Failed : Boolean := Mul_Result > Result;
      Add_Failed : Boolean := Add_Result > Result;
      Cat_Failed : Boolean := Cat_Result > Result;
   begin
      if Cur_Op_Idx = Operands'Last then
         return (if Do_Part2 then Result in Mul_Result | Add_Result | Cat_Result else Result in Mul_Result | Add_Result);
      else
         return ((not Mul_Failed) and then Check_Equation(
            Result,
            Mul_Result,
            Operands,
            Cur_Op_Idx+1,
            Do_Part2
         )) or else ((not Add_Failed) and then Check_Equation(
            Result,
            Add_Result,
            Operands,
            Cur_Op_Idx+1,
            Do_Part2
         )) or else (Do_Part2 and then (not Cat_Failed) and then Check_Equation(
            Result,
            Cat_Result,
            Operands,
            Cur_Op_Idx+1,
            Do_Part2
         ));
      end if;
   end Check_Equation;

   function Can_Be_True ( E : Ref_Equation; Do_Part2 : Boolean := False ) return Boolean is
   begin
      return Check_Equation(
         Result     => E.Result,
         Acc        => E.Operands(1),
         Operands   => E.Operands,
         Cur_Op_Idx => 2,
         Do_Part2   => Do_Part2
      );
   end Can_Be_True;
end Day7;