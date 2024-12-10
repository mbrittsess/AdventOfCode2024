with Day7; use Day7;
with Day7.Input;
with Ada.Text_IO; use Ada.Text_IO;

procedure Day7_Solution is
   Sum1 : Number := [for Eq of Day7.Input.Equations when Can_Be_True(Eq) => Eq.Result]'Reduce("+", 0);
   Sum2 : Number := [for Eq of Day7.Input.Equations when Can_Be_True(Eq, True) => Eq.Result]'Reduce("+", 0);
begin
   Put_Line("Part 1: " & Sum1'Image);
   Put_Line("Part 2: " & Sum2'Image);
end Day7_Solution;