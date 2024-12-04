-- Used for reading in all of standard input at once, provided standard input
-- is in the form of a series of lines all exactly the same width
package Grid_Input is
   -- Index order (row, column)
   type Character_Grid is array( Positive range <>, Positive range <> ) of Character;

   function Get_Grid_Input return Character_Grid;
end Grid_Input;