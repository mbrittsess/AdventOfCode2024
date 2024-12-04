with Ada.Text_IO; use Ada.Text_IO;
with Grid_Input; use Grid_Input;
with Integer_Vector; use Integer_Vector;
with System.Multiprocessors;

procedure Day4_Multi is
   -- BASIC FUNCTIONALITY FOR PROBLEM
   Grid : constant Character_Grid := Get_Grid_Input;

   type Line_Range is array( 1 .. 2 ) of Positive;

   Directions : array( 1 .. 8 ) of Vector := (
      ( 1, 0),
      ( 1, 1),
      ( 0, 1),
      (-1, 1),
      (-1, 0),
      (-1,-1),
      ( 0,-1),
      ( 1,-1)
   );

   function In_Grid ( V : Vector ) return Boolean is
      (V(1) in Grid'Range(2) and then V(2) in Grid'Range(1));

   function Char_At ( V : Vector ) return Character is
   begin
      if not In_Grid(V) then
         raise Constraint_Error with "Location " & To_String(V) & " is not in grid, which has bounds "
            & "(1.." & Grid'Length(2)'Image & "," -- Row length, or number of columns
            & "1.." & Grid'Length(1)'Image & ")"; -- Col length, or number of rows
      else
         return Grid(V(2),V(1));
      end if;
   end Char_At;

   function Char_At ( X, Y : Integer ) return Character is
   begin
      return Char_At( (X,Y) );
   end Char_At;

   function Count_Part1_Matches ( LR : Line_Range ) return Natural is
      Count : Natural := 0;
   begin
      for Y in LR(1) .. LR(2) loop
         for X in Grid'Range(2) loop
            declare
               Pos : Vector := (X,Y);
               Char : character := Char_At(Pos);
            begin
               if Char = 'X' then -- Are we at the start of a potential string?
                  for Dir of Directions loop -- Try looking in every direction
                     if In_Grid(Pos + Dir*3) then -- Is there enough space to hold the string?
                        if          Char_At(Pos + Dir*1) = 'M'
                           and then Char_At(Pos + Dir*2) = 'A'
                           and then Char_At(Pos + Dir*3) = 'S'
                        then
                           Count := @ + 1;
                        end if;
                     end if;
                  end loop;
               end if;
            end;
         end loop;
      end loop;

      return Count;
   end Count_Part1_Matches;

   function Count_Part2_Matches ( LR : Line_Range ) return Natural is
      Count : Natural := 0;
      Y_Start : Positive := LR(1);
      Y_End   : Positive := LR(2);
   begin
      if Y_Start = Grid'First(1) then
         Y_Start := @ + 1;
      end if;

      if Y_End = Grid'Last(1) then
         Y_End := @ - 1;
      end if;

      for Y in Y_Start .. Y_End loop
         for X in Grid'First(2)+1 .. Grid'Last(2)-1 loop
            if Char_At(X,Y) = 'A' then -- Are we at middle of potential pattern?
               declare
                  UR : Character := Char_At(X+1,Y+1);
                  UL : Character := Char_At(X-1,Y+1);
                  DR : Character := Char_At(X+1,Y-1);
                  DL : Character := Char_At(X-1,Y-1);
               begin
                  if          (        (UR = 'S' and then DL = 'M')
                               or else (UR = 'M' and then DL = 'S'))
                     and then (        (UL = 'S' and then DR = 'M')
                               or else (UL = 'M' and then DR = 'S'))
                  then
                     Count := @ + 1;
                  end if;
               end;
            end if;
         end loop;
      end loop;

      return Count;
   end Count_Part2_Matches;

   -- DIVISION OF WORK AMONG WORKERS
   Number_Of_Workers : constant Positive := Integer(System.Multiprocessors.Number_Of_CPUs) / 2;
   Work_Size : constant Positive := Grid'Length(1) / Number_Of_Workers;

   subtype Worker_ID is Integer range 1 .. Number_Of_Workers;

   Line_Ranges : array( Worker_ID ) of Line_Range :=
      (for ID in Worker_ID'Range => (
         ((ID-1)*Work_Size)+1,
         (if ID /= Worker_ID'Last then ID*Work_Size else Grid'Last(1))));

   -- Used to handle assigning worker IDs and accumulate results from multiple worker tasks
   protected type Coordinator is
      procedure Get_ID ( ID : out Worker_ID );
      procedure Increment ( Amount : Integer );
      function Get_Value return Integer;
   private
      Cur_ID : Natural := 0;
      Value : Integer := 0;
   end Coordinator;

   protected body Coordinator is
      procedure Get_ID ( ID : out Worker_ID ) is
      begin
         Cur_ID := Cur_ID + 1;
         ID := Cur_ID;
      end Get_ID;

      procedure Increment ( Amount : Integer ) is
      begin
         Value := Value + Amount;
      end Increment;

      function Get_Value return Integer is
         (Value);
   end Coordinator;

   -- THE TASKS WHICH RUN TO SOLVE THE PROBLEM
   task Part1 is
      entry Show_Result;
   end Part1;

   task body Part1 is
      Coord : Coordinator;

      function Get_ID return Worker_ID is
         Ret_ID : Worker_ID;
      begin
         Coord.Get_ID(Ret_ID);
         return Ret_ID;
      end Get_ID;

      task type Part1_Worker;

      task body Part1_Worker is
         Own_ID : Worker_ID := Get_ID;
         Own_Range : Line_Range := Line_Ranges(Own_ID);
      begin
         Coord.Increment(Count_Part1_Matches(Own_Range));
      end Part1_Worker;
   begin
      declare -- Used so we can wait on all workers to finish without having to explicitly synchronize
         Workers : array( Worker_ID ) of Part1_Worker;
      begin
         null;
      end;

      accept Show_Result do
         Put_Line("Part 1 Count: " & Coord.Get_Value'Image);
      end Show_Result;
   end Part1;

   task Part2 is
      entry Show_Result;
   end Part2;

   task body Part2 is
      Coord : Coordinator;

      function Get_ID return Worker_ID is
         Ret_ID : Worker_ID;
      begin
         Coord.Get_ID(Ret_ID);
         return Ret_ID;
      end Get_ID;

      task type Part2_Worker;

      task body Part2_Worker is
         Own_ID : Worker_ID := Get_ID;
         Own_Range : Line_Range := Line_Ranges(Own_ID);
      begin
         Coord.Increment(Count_Part2_Matches(Own_Range));
      end Part2_Worker;
   begin
      declare -- Used so we can wait on all workers to finish without having to explicitly synchronize
         Workers : array( Worker_ID ) of Part2_Worker;
      begin
         null;
      end;

      accept Show_Result do
         Put_Line("Part 2 Count: " & Coord.Get_Value'Image);
      end Show_Result;
   end Part2;
begin
   Part1.Show_Result;
   Part2.Show_Result;
end Day4_Multi;