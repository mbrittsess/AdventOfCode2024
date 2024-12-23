package body Day13 is
   function Is_Even_Multiple ( Larger, Smaller : Positive_Component ) return Boolean is
   begin
      return (Larger mod Smaller) = 0;
   end Is_Even_Multiple;
end Day13;