with Ada.Text_IO;

package Day7 is
   type Number is range 0 .. (2**64)-1;
   subtype Positive_Number is Number range 1 .. Number'Last;

   package IO is new Ada.Text_IO.Integer_IO( Num => Number );

   type Operand_List is array ( Positive range <> ) of Positive_Number;

   type Equation(N : Positive) is
      record
         Result : Positive_Number;
         Operands : Operand_List(1 .. N);
      end record;
   
   type Ref_Equation is access Equation;
   
   type Equation_List is array ( Positive range <> ) of Ref_Equation;
   
   function Can_Be_True ( E : Ref_Equation ) return Boolean;
end Day7;