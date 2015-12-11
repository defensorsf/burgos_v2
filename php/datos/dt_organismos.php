<?php
class dt_organismos extends toba_datos_tabla
{
	function get_descripciones()
	{
		$sql = "SELECT nombre  FROM organismos ORDER BY nombre";
		return toba::db('burgos_v2')->consultar($sql);
	}
	function get_descripciones_sin_judicial()
	{
		$sql = "SELECT nombre  FROM organismos WHERE nombre not ilike '%Poder Judicial%' ORDER BY nombre";
		return toba::db('burgos_v2')->consultar($sql);
	}
}
?>