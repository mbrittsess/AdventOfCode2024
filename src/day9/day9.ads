with Ada.Text_IO;

package Day9 is
   type Storage_Kind is (File, Empty);
   subtype File_Index is Natural;

   -- The default value for Kind is required for us to be able to have an array of mixed Block types
   type Block (Kind : Storage_Kind := Empty) is
      record
         Size : Natural;
         case Kind is
            when File =>
               Index : File_Index;
            when others =>
               null;
         end case;
      end record;
   
   Input_Line : constant String := Ada.Text_IO.Get_Line;

   Raw_Input_Blocks : constant array (Positive range <>) of Block :=
      [for Idx in Input_Line'Range =>
         (if Idx mod 2 = 1 then
            (Kind => File, Size => Character'Pos(Input_Line(Idx)) - Character'Pos('0'), Index => (Idx-1)/2)
          else
            (Kind => Empty, Size => Character'Pos(Input_Line(Idx)) - Character'Pos('0')))];
   
   Input_Blocks : constant array (Positive range <>) of Block := [for Bl of Raw_Input_Blocks when Bl.Size /= 0 => Bl];
   
   Disk_Size : constant Positive := [for Bl of Input_Blocks => Bl.Size]'Reduce("+", Natural'(0));
end Day9;