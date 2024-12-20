with Character_Grids;

package Day12 is
   package CG renames Character_Grids;

   subtype Plant_Kind is Character range 'A' .. 'Z';

   type Region_Index is new Positive;
end Day12;