with Mapped_Input;
with Day1_Types; use Day1_Types;

package Day1_Input is
   package Day1_Mapped is new Mapped_Input(
         Input_Type => ID_Pair,
         To_Input   => To_ID_Pair
      );
      
   subtype Input_Index is Day1_Mapped.Input_Index;
   subtype Input_Collection is Day1_Mapped.Input_Collection;
   
   ID_Pairs : constant Input_Collection := Day1_Mapped.Inputs;
end Day1_Input;