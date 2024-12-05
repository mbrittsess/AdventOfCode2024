private with Day5.Get_Input;

package Day5.Input is
   Comes_Before : constant Page_Ordering_Rules;
private
   Comes_Before : constant Page_Ordering_Rules := Day5.Get_Input.Get_Rules;
end Day5.Input;