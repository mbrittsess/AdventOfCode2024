--with Grids;
--
--generic
--   type From_Type is private;
--   type To_Type is private;
--   with package From_Grids is new Grids(From_Type);
--   with package To_Grids is new Grids(To_Type);
--   with function Convert ( Cur : From_Grids.Cursor ) return To_Type;
function Map_Grid ( From_Grid : From_Grids.Access_Grid ) return To_Grids.Grid is
   Ret_Grid : To_Grids.Grid(From_Grid'Range(1), From_Grid'Range(2));
begin
   for Curs in From_Grids.Iterate(From_Grid) loop
      declare
         Row_Idx : Positive := From_Grids.Position(Curs)(2);
         Col_Idx : Positive := From_Grids.Position(Curs)(1);
      begin
         Ret_Grid(Row_Idx,Col_Idx) := Convert(Curs);
      end;
   end loop;
   
   return Ret_Grid;
end Map_Grid;