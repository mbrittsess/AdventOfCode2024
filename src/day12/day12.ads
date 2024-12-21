with Character_Grids;

package Day12 is
   package CG renames Character_Grids;

   subtype Plant_Kind is Character range 'A' .. 'Z';

   type Region_Index is new Natural;
   subtype Valid_Region_Index is Region_Index range 1 .. Region_Index'Last;
   
   Null_Region : constant Region_Index := 0;
   
   type Region_Properties is
      record
         Area, Perimeter : Natural;
      end record;
end Day12;