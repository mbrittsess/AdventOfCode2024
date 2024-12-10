with Day7; use Day7;
with Day7.Input;
with Ada.Text_IO; use Ada.Text_IO;

procedure Day7_Solution is
   Sum : Number := [for Eq of Day7.Input.Equations when Can_Be_True(Eq) => Eq.Result]'Reduce("+", 0);
begin
   Put_Line(Sum'Image);
end Day7_Solution;