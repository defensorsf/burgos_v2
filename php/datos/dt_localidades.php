<?php
class dt_localidades extends toba_datos_tabla
{
	function get_descripciones()
	{
		$sql = "SELECT id, nombre FROM localidades ORDER BY nombre";
		return toba::db('burgos_v2')->consultar($sql);
	}





}
?>