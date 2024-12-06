with Ada.Text_IO; use Ada.Text_IO;
with Mapped_Grid_Input;
with Integer_Vector; use Integer_Vector;

procedure Day6 is
   type Position_Content is (Empty, Obstacle);
   type Direction is (Right, Up, Left, Down);

   Dir_Vectors : constant array( Direction ) of Vector := (
      Right => ( 1, 0),
      Up    => ( 0, 1),
      Left  => (-1, 0),
      Down  => ( 0,-1)
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
      (Field_Layout(V(2), V(1)));
   
   procedure Mark_Visited ( V : Vector ) is
   begin
      Visited_Yet(V(1), V(2)) := True;
   end Mark_Visited;

begin
   Mark_Visited(Guard_Pos); -- Mark the starting location
end Day6;