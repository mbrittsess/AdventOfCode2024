with Day8; use Day8;
with Grid_Input;
with Ada.Text_IO; use Ada.Text_IO;
with Integer_Vector; use Integer_Vector;

procedure Day8_Solution is
   -- Arranged in rows, then columns, with row 1 at top
   Raw_Grid : Grid_Input.Character_Grid := Grid_Input.Get_Grid_Input;

   -- I tried some way to get 'Length of an iterator that filtered for non-'.' but I couldn't make it work
   Num_Antenna : constant Positive := [for C of Raw_Grid => (if C = '.' then 0 else 1)]'Reduce("+", Natural'(0));

   -- Arranged in X/Y
   Antinode_Grid1, Antinode_Grid2 : array ( Raw_Grid'Range(2), Raw_Grid'Range(1) ) of Boolean := ( others => ( others => False ) );

   function In_Grid( V : Vector ) return Boolean is
   begin
      return V(1) in Raw_Grid'Range(2) and then V(2) in Raw_Grid'Range(1);
   end In_Grid;

   procedure Mark_Antinode1( V : Vector ) is
   begin
      Antinode_Grid1( V(1), V(2) ) := True;
   end Mark_Antinode1;

   procedure Try_Mark_Antinode1( V : Vector ) is
   begin
      if In_Grid(V) then
         Mark_Antinode1(V);
      end if;
   end Try_Mark_Antinode1;

   procedure Mark_Antinode2( V : Vector ) is
   begin
      Antinode_Grid2( V(1), V(2) ) := True;
   end Mark_Antinode2;

   -- I wish there was a functional way to do this by iterating through Raw_Grid somehow
   Antennae : array ( 1 .. Num_Antenna ) of Antenna;
begin
   --Put_Line("Number of antennae: " & Num_Antenna'Image);

   -- Initialize the list of Antennae
   declare
      Antenna_Idx : Positive := Antennae'First;
   begin
      for Row_Idx in Raw_Grid'Range(1) loop
         for Col_Idx in Raw_Grid'Range(2) loop
            declare
               Char : Character := Raw_Grid(Row_Idx,Col_idx);
               --Pos : Vector := (Col_Idx, (Raw_Grid'Last(1)-Row_Idx)+Raw_Grid'First(1));
               Pos : Vector := (Col_Idx, Row_Idx);
            begin
               if Char /= '.' then
                  Antennae(Antenna_Idx) := ( Frequency => Char, Position => Pos );
                  Antenna_Idx := @ + 1;
               end if;
            end;
         end loop;
      end loop;
   end;

   -- Iterate through all combinations of antennae and mark antinodes
   for A_Idx in Antennae'Range loop
      for B_Idx in Antennae'Range loop
         if A_Idx /= B_Idx then
            declare
               A : Antenna := Antennae(A_Idx);
               B : Antenna := Antennae(B_Idx);
            begin
               if A.Frequency = B.Frequency then
                  -- Part 1 solution
                  declare
                     Antinode : Vector := A.Position + (B.Position-A.Position)*2;
                  begin
                     Try_Mark_Antinode1(Antinode);
                  end;

                  -- Part 2 solution
                  declare
                     Diff : Vector := B.Position - A.Position;
                  begin
                     -- First in one direction...
                     for Scale in 1 .. Integer'Last loop
                        declare
                           Antinode_Pos : Vector := A.Position + Diff*Scale;
                        begin
                           exit when not In_Grid(Antinode_Pos);
                           Mark_Antinode2(Antinode_Pos);
                        end;
                     end loop;

                     -- And then in the other direction
                     for Scale in reverse Integer'First .. -1 loop
                        declare
                           Antinode_Pos : Vector := A.Position + Diff*Scale;
                        begin
                           exit when not In_Grid(Antinode_Pos);
                           Mark_Antinode2(Antinode_Pos);
                        end;
                     end loop;
                  end;
               end if;
            end;
         end if;
      end loop;
   end loop;

   declare
      Num_Antinodes1 : Positive := [for N of Antinode_Grid1 => (if N then 1 else 0)]'Reduce("+", Natural'(0));
      Num_Antinodes2 : Positive := [for N of Antinode_Grid2 => (if N then 1 else 0)]'Reduce("+", Natural'(0));
   begin
      Put_Line("Number of antinodes (part 1): " & Num_Antinodes1'Image);
      Put_Line("Number of antinodes (part 2): " & Num_Antinodes2'Image);
   end;

   --for Row_Idx in Raw_Grid'Range(1) loop
   --   declare
   --      L : String := [for Col_Idx in Raw_Grid'Range(2) => (if Antinode_Grid(Col_Idx, Row_Idx) then 'N' else '.')];
   --   begin
   --      Put_Line(L);
   --   end;
   --end loop;
end Day8_Solution;