with Grids;

generic
   type From_Type is private;
   type To_Type is private;
   with package From_Grids is new Grids(From_Type);
   with package To_Grids is new Grids(To_Type);
   with function Convert ( Cur : From_Grids.Cursor ) return To_Type;
function Map_Grid ( From_Grid : From_Grids.Access_Grid ) return To_Grids.Grid;