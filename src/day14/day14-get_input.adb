with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

function Day14.Get_Input return Robot_Info_List is
   function Get_Info ( List : Robot_Info_List := [] ) return Robot_Info_List is
      Line : String := Get_Line;

      -- Find the position of the various markers
      Comma1_Pos : Natural := Index(Line, ",");
      Comma2_Pos : Natural := Index(Line(Comma1_Pos+1..Line'Last), ",");
      Space_Pos : Natural := Index(Line, " ");

      -- Get the value of the various components
      Pos_X : Integer := Integer'Value(Line(3 .. Comma1_Pos-1));
      Pos_Y : Integer := Integer'Value(Line(Comma1_Pos+1 .. Space_Pos-1));
      Vel_X : Integer := Integer'Value(Line(Space_Pos+3 .. Comma2_Pos-1));
      Vel_Y : Integer := Integer'Value(Line(Comma2_Pos+1 .. Line'Last));

      Info : Robot_Info := (
         ID => Robot_Index(List'Length+1),
         Start => (Pos_X, Pos_Y),
         Velocity => (Vel_X, Vel_Y)
      );
   begin
      if End_Of_File then
         return List & Info;
      else
         return Get_Info(List & Info);
      end if;
   end Get_Info;
begin
   return Get_Info;
end Day14.Get_Input;