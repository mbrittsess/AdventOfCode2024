with Integer_Vector; use Integer_Vector;
with Day13.Input; use Day13.Input;
with Ada.Text_IO; use Ada.Text_IO;

procedure Day13.Solution is
   Machine_Input : Machine_List := Read_Machine_Input;

   -- Returns 0 if no prize is possible
   function Tokens_Needed ( M : Machine ) return Natural is
      PX_Numerator : Integer := M.A(1) * ( M.Prize(1)*( M.Prize(2) + M.B(2) ) - M.Prize(2)*( M.Prize(1) + M.B(1) ) );
      PX_Denominator : Integer := M.A(1)*M.B(2) - M.A(2)*M.B(1);
      Same_Sign : Boolean := (PX_Numerator < 0) = (PX_Denominator < 0);
   begin
      if Same_Sign and then PX_Numerator < 0 then
         PX_Numerator := abs @;
         PX_Denominator := abs @;
      end if;

      if Same_Sign and then Is_Even_Multiple(PX_Numerator, PX_Denominator) then
         declare
            PX : Natural := PX_Numerator / PX_Denominator;
            A_Mult : Natural := PX / M.A(1);
            B_X_Diff : Natural := M.Prize(1) - PX;
            B_Mult : Natural := B_X_Diff / M.B(1);
         begin
            if A_Mult > 100 or else B_Mult > 100 then
               return 0;
            else
               return A_Mult*3 + B_Mult;
            end if;
         end;
      else
         return 0;
      end if;
   end Tokens_Needed;

   Total_Tokens : Natural := [for Mach of Machine_Input => Tokens_Needed(Mach)]'Reduce("+", Natural'(0));
begin
   Put_Line("Tokens needed: " & Total_Tokens'Image);
end Day13.Solution;