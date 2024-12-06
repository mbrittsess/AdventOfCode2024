with Day5; with Day5.Input;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Generic_Array_Sort;

procedure Day5_Solution is
   use Day5;
   use Day5.Input;
   
   function Update_Is_Good ( Update : Pages_Update ) return Boolean is
   begin
      return (for all Early_Page_Idx in Update'First .. Update'Last-1 =>
         (for all Later_Page of Update(Early_Page_Idx+1 .. Update'Last) =>
            Comes_Before(Update(Early_Page_Idx), Later_Page)));
   end Update_Is_Good;
   
   function Middle_Page_Number ( Update : Pages_Update ) return Page_Number is
   begin
      return Update((Update'Last / 2)+1);
   end Middle_Page_Number;
   
   function Sorted_Pages_Update ( Update : Pages_Update ) return Pages_Update is
      function Is_Ordered ( Left, Right : Page_Number ) return Boolean is
         (Comes_Before(Left,Right));
      
      procedure Sort is new Ada.Containers.Generic_Array_Sort(
            Positive,
            Page_Number,
            Pages_Update,
            Is_Ordered
         );
      
      Ret : Pages_Update := Update;
   begin
      Sort(Ret); -- in out Ret
      return Ret;
   end Sorted_Pages_Update;
   
   Correct_Sum, Incorrect_Sum : Natural := 0;
begin
   for Update of Updates loop
      if Update_Is_Good(Update.all) then
         Correct_Sum := @ + Integer(Middle_Page_Number(Update.all));
      else
         Incorrect_Sum := @ + Integer(Middle_Page_Number(Sorted_Pages_Update(Update.all)));
      end if;
   end loop;
   
   Put_Line("Part 1 Sum: " & Correct_Sum'Image);
   Put_Line("Part 2 Sum: " & Incorrect_Sum'Image);
end Day5_Solution;