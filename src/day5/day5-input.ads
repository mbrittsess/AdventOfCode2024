private with Day5.Get_Input;

package Day5.Input is
   Comes_Before : constant Page_Ordering_Rules;
   Updates : constant Pages_Update_List;
private
   Comes_Before : constant Page_Ordering_Rules := Day5.Get_Input.Get_Rules;
   Updates : constant Pages_Update_List := Day5.Get_Input.Get_Updates;
end Day5.Input;