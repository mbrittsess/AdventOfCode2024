with Big_Integer_Vector; use Big_Integer_Vector;
with Day13.Input; use Day13.Input;
with Ada.Text_IO; use Ada.Text_IO;

procedure Day13.Solution is
   subtype Long_Long_Natural is Long_Long_Integer range 0 .. Long_Long_Integer'Last;
   Machine_Input : Machine_List := Read_Machine_Input;

   -- Returns 0 if no prize is possible
   function Tokens_Needed ( M : Machine; Limit_100 : Boolean := True ) return Long_Long_Natural is
      PX_Numerator : Vector_Component := M.Prize(1)*M.B(2) - M.Prize(2)*M.B(1);
      PY_Numerator : Vector_Component := M.Prize(2)*M.A(1) - M.Prize(1)*M.A(2);
      P_Denominator : Vector_Component := M.A(1)*M.B(2) - M.A(2)*M.B(1);
      All_Same_Sign : Boolean := (PX_Numerator < 0) = (P_Denominator < 0) and then (PY_Numerator < 0) = (P_Denominator < 0);
   begin
      if All_Same_Sign and then P_Denominator < 0 then
         PX_Numerator := abs @;
         PY_Numerator := abs @;
         P_Denominator := abs @;
      end if;

      if All_Same_Sign and then Is_Even_Multiple(PX_Numerator, P_Denominator) and then Is_Even_Multiple(PY_Numerator, P_Denominator) then
         declare
            A_Mult : Natural_Component := PX_Numerator / P_Denominator;
            B_Mult : Natural_Component := PY_Numerator / P_Denominator;
         begin
            if Limit_100 and then (A_Mult > 100 or else B_Mult > 100) then
               return 0;
            else
               return Long_Long_Natural(A_Mult*3 + B_Mult);
            end if;
         end;
      else
         return 0;
      end if;
   end Tokens_Needed;

   Total_Tokens_Part1 : Long_Long_Natural := [for Mach of Machine_Input => Tokens_Needed(Mach)]'Reduce("+", Long_Long_Natural'(0));
   Total_Tokens_Part2 : Long_Long_Natural := [for Mach of Machine_Input => 
      Tokens_Needed
      (
         (
            A => Mach.A,
            B => Mach.B,
            Prize => Mach.Prize+(10_000_000_000_000,10_000_000_000_000)
         ),
         False
      )
   ]'Reduce("+", Long_Long_Natural'(0));
begin
   Put_Line("Tokens needed (part 1): " & Total_Tokens_Part1'Image);
   Put_Line("Tokens needed (part 2): " & Total_Tokens_Part2'Image);
end Day13.Solution;