with Integer_Vector; use Integer_Vector;

package Day14 is
   type Robot_Index is new Positive;

   type Robot_Info is
      record
         ID : Robot_Index;
         Start, Velocity : Vector;
      end record;
   
   type Robot_Info_List is array ( Robot_Index range <> ) of Robot_Info;

   type Robot_Position_List is array ( Robot_Index range <> ) of Vector;

end Day14;