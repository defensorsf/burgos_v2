<?php
class dt_paises extends toba_datos_tabla
{
	function get_descripciones()
	{
		$sql = "SELECT id, nombre FROM paises ORDER BY nombre";
		return toba::db('burgos_v2')->consultar($sql);
	}




}
?>