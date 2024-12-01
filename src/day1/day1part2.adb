with Ada.Text_IO; use Ada.Text_IO;
with Functional_Integer_Text_IO;
with Ada.Containers.Vectors;

procedure Day1Part2 is
   type Location_ID is new Integer;
   
   package ID_Lists is new Ada.Containers.Vectors(
         Index_Type => Natural,
         Element_Type => Location_ID
      );
   use ID_Lists;
   
   package FIIO renames Functional_Integer_Text_IO;
   
   Left_List, Right_List : ID_Lists.Vector := ID_Lists.Empty;
   
   -- Give it a Location_ID (presumably from Left_List) and it
   -- counts up how many times it appears in Right_List, multiplies
   -- the ID by that, and returns that.
   function Similarity_Score ( Left_ID : Location_ID ) return Integer is
      Count : Natural := 0;
   begin
      for Right_ID of Right_List loop
         if Left_ID = Right_ID then
            Count := Count + 1;
         end if;
      end loop;
      
      return Integer(Left_ID) * Count;
   end Similarity_Score;
   
   Total_Similarity : Integer := 0;
begin
   -- Read in lists
   while not End_Of_File loop
      Left_List  := Left_List  & Location_ID(FIIO.Get);
      Right_List := Right_List & Location_ID(FIIO.Get);
   end loop;
   
   -- Iterate through Left_List and sum similarities
   for Left_ID of Left_List loop
      Total_Similarity := Total_Similarity + Similarity_Score(Left_ID);
   end loop;
   
   Put_Line("Total Similarity: " & Total_Similarity'Image);
end Day1Part2;