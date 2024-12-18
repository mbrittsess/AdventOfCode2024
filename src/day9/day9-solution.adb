with Ada.Text_IO; use Ada.Text_IO;

procedure Day9.Solution is
   Disk_Map : array(0 .. Disk_Size-1) of File_Index := ( others => 0 );

   End_Idx : Natural := Input_Blocks'Last;
   Checksum : Long_Long_Integer := 0;
begin
   Put_Line("Input is " & Input_Blocks'Length'Image & " blocks long");
   Put_Line("Disk uses " & Disk_Size'Image & " bytes");

   -- Fill out the disk map
   declare
      Track_Idx : Natural := Disk_Map'First;
   begin
      for Item of Input_Blocks loop
         case Item.Kind is
            when File =>
               for Fill_Idx in Track_Idx .. (Track_Idx+Item.Size-1) loop
                  Disk_Map(Fill_Idx) := Item.Index;
               end loop;
            
            when Empty => null;
         end case;
         Track_Idx := Track_Idx + Item.Size;
      end loop;
   end;

   -- Compute checksum
   declare
      End_Idx : Natural := Disk_Map'Last;
   begin
      for Idx in Input_Blocks(1).Size .. Disk_Map'Last loop
         exit when Idx >= End_Idx;
         
         -- Is this an empty block?
         if Disk_Map(Idx) = 0 then
            -- Find a file block to move
            while Disk_Map(End_Idx) = 0 loop
               End_Idx := End_Idx - 1;
            end loop;
            exit when Idx >= End_Idx; -- Might need to exit early

            -- End_Idx should be sitting on a file block now
            Disk_Map(Idx) := Disk_Map(End_Idx);
            Disk_Map(End_Idx) := 0;
         end if;
      end loop;
   end;

   --for Index of Disk_Map loop
   --   if Index = 0 then
   --      Put(" .");
   --   else
   --      Put(Index'Image);
   --   end if;
   --end loop;

   -- Compute checksum
   for Idx in Disk_Map'Range loop
      Checksum := Checksum + Long_Long_Integer(Idx*Disk_Map(Idx));
   end loop;

   Put_Line("Checksum: " & Checksum'Image);

end Day9.Solution;