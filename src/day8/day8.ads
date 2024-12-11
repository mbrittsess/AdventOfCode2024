with Integer_Vector; use Integer_Vector;

package Day8 is
   -- Might change the type later
   subtype Antenna_Frequency is Character;

   type Antenna is
      record
         Frequency : Antenna_Frequency;
         Position  : Vector;
      end record;
end Day8;