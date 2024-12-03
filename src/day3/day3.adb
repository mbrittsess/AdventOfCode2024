with Ada.Text_IO; use Ada.Text_IO;

procedure Day3 is
   subtype Digit is Character range '0' .. '9';

   function To_Integer ( C : Digit ) return Integer is
   begin
      return Integer'Value((1 => C));
   end To_Integer;

   Cur_Char : Character;

   function Get_Character return Character is
   begin
      Get(Cur_Char); -- out Cur_Char
      return Cur_Char;
   end Get_Character;

   function Cur_Digit return Integer is
   begin
      return To_Integer(Cur_Char);
   end Cur_Digit;

   Arg1, Arg2 : Integer;
   Mul_Enabled : Boolean := True;

   Part1_Mul_Total, Part2_Mul_Total : Integer := 0;
begin
   while not End_Of_File loop
      -- The following loop embodies the main parsing state machine
      parse_loop: loop
         Arg1 := 0;
         Arg2 := 0;

         -- First branch: mul, or an enable/disable?
         Get(Cur_Char);
         if Cur_Char = 'm' then -- Take the mul() branch
            case Get_Character is
               when 'u'    => null;
               when others => exit parse_loop;
            end case;

            case Get_Character is
               when 'l'    => null;
               when others => exit parse_loop;
            end case;

            case Get_Character is
               when '('    => null;
               when others => exit parse_loop;
            end case;

            case Get_Character is
               when '0' .. '9' => Arg1 := Cur_Digit;
               when others     => exit parse_loop;
            end case;

            arg1_loop: loop
               case Get_Character is
                  when '0' .. '9' => Arg1 := (Arg1 * 10) + Cur_Digit;
                  when ','        => exit arg1_loop;
                  when others     => exit parse_loop;
               end case;
            end loop arg1_loop;

            case Get_Character is
               when '0' .. '9' => Arg2 := Cur_Digit;
               when others     => exit parse_loop;
            end case;

            arg2_loop: loop
               case Get_Character is
                  when '0' .. '9' => Arg2 := (Arg2 * 10) + Cur_Digit;
                  when ')'        => exit arg2_loop;
                  when others     => exit parse_loop;
               end case;
            end loop arg2_loop;

            -- If reached this point, then we have parsed a complete mul() instruction
            Part1_Mul_Total := Part1_Mul_Total + (Arg1 * Arg2);
            if Mul_Enabled then
               Part2_Mul_Total := Part2_Mul_Total + (Arg1 * Arg2);
            end if;
         
         elsif Cur_Char = 'd' then -- Take the do()/don't() branch
            case Get_Character is
               when 'o'    => null;
               when others => exit parse_loop;
            end case;

            -- Next branch: is it do(), or don't()?
            Get(Cur_Char);
            if Cur_Char = '(' then
               case Get_Character is
                  when ')'    => Mul_Enabled := True;
                  when others => exit parse_loop;
               end case;

            elsif Cur_char = 'n' then
               case Get_Character is
                  when '''    => null;
                  when others => exit parse_loop;
               end case;

               case Get_Character is
                  when 't'    => null;
                  when others => exit parse_loop;
               end case;

               case Get_Character is
                  when '('    => null;
                  when others => exit parse_loop;
               end case;

               case Get_Character is
                  when ')'    => Mul_Enabled := False;
                  when others => exit parse_loop;
               end case;

            else -- Invalid; start parsing again
               null;
            
            end if;
         
         else -- Invalid; keep searching
            null;
         
         end if;
         
         exit parse_loop;
      end loop parse_loop;
   end loop;

   Put_Line("Part 1 Mul Totals: " & Part1_Mul_Total'Image);
   Put_Line("Part 2 Mul Totals: " & Part2_Mul_Total'Image);
end Day3;