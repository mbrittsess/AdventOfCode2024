with Big_Integer_Vector; use Big_Integer_Vector;

package Day13 is
   type Machine is
      record
         A, B, Prize : Vector;
      end record;
   
   type Machine_List is array ( Positive range <> ) of Machine;
   
   function Is_Even_Multiple ( Larger, Smaller : Positive_Component ) return Boolean
      with Pre => Larger >= Smaller;
   
end Day13;