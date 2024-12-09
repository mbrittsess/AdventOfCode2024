with Ada.Text_IO; use Ada.Text_IO;
with Mapped_Grid_Input;
with Integer_Vector; use Integer_Vector;

procedure Day6 is
   type Position_Content is (Empty, Obstacle);
   type Direction is (Right, Up, Left, Down);

   Dir_Vectors : constant array( Direction ) of Vector := (
      Right => ( 1, 0),
      Up    => ( 0,-1),
      Left  => (-1, 0),
      Down  => ( 0, 1)
   );

   Rotated_Dirs : constant array( Direction ) of Direction := (
      Right => Down,
      Up    => Right,
      Left  => Up,
      Down  => Left
   );

   Guard_Pos : Vector; -- We don't know the guard's start position yet
   Guard_Dir : Direction := Up; --But we know they start out facing up

   function Input_To_Content ( C : Character; Row, Col : Positive ) return Position_Content is
   begin
      case C is
         when '.' => return Empty;
         when '#' => return Obstacle;
         when '^' =>
            Guard_Pos := ( Col, Row ); -- Convert Row,Col to X,Y; must swap
            return Empty;
         when others => raise Data_Error;
      end case;
   end Input_To_Content;

   package Field_Input is new Mapped_Grid_Input(
         Input_Type => Position_Content,
         To_Input   => Input_To_Content
      );
   
   package FI renames Field_Input;

   -- Field_Layout is in Row,Col
   Field_Layout : constant FI.Input_Grid := FI.Get_Grid_Input;

   -- But Visited_Yet is in X,Y
   Visited_Yet : array( Field_Layout'Range(2), Field_Layout'Range(1) ) of Boolean := ( others => ( others => False ) );

   function Content_At ( V : Vector ) return Position_Content is
      (Field_Layout(FI.Input_Index(V(2)), FI.Input_Index(V(1))));
   
   procedure Mark_Visited ( V : Vector ) is
   begin
      Visited_Yet(FI.Input_Index(V(1)), FI.Input_Index(V(2))) := True;
   end Mark_Visited;

   function Is_Obstructed ( V : Vector ) return Boolean is
   begin
      return Field_Layout(FI.Input_Index(V(2)), FI.Input_Index(V(1))) = Obstacle;
   end Is_Obstructed;

   function Is_Outside ( V : Vector ) return Boolean is
   begin
      return not (FI.Input_Index'Base(V(1)) in Field_Layout'Range(2)) or else not (FI.Input_Index'Base(V(2)) in Field_Layout'Range(1));
   end Is_Outside;

   function Count_Marked_Positions return Natural is
      Count : Natural := 0;
   begin
      for X in Visited_Yet'Range(1) loop
         for Y in Visited_Yet'Range(2) loop
            if Visited_Yet(X,Y) then
               Count := Count + 1;
            end if;
         end loop;
      end loop;

      return Count;
   end Count_Marked_Positions;

begin
   Mark_Visited(Guard_Pos); -- Mark the starting location

   loop
      declare
         New_Pos : Vector := Guard_Pos + Dir_Vectors(Guard_Dir);
      begin
         exit when Is_Outside(New_Pos);

         if Is_Obstructed(New_Pos) then
            Guard_Dir := Rotated_Dirs(Guard_Dir);
         else
            Guard_Pos := New_Pos;
            Mark_Visited(Guard_Pos);
         end if;
      end;
   end loop;

   Put_Line("Number of visited positions: " & Count_Marked_Positions'Image);
end Day6;