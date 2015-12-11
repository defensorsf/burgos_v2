<?php
class dt_organismos_dep extends burgos_v2_datos_tabla
{
	function get_descripciones($organismo)
	{
		if ( empty($organismo)){
			$sql = "SELECT *   FROM organismos_dep  ORDER BY organismo, dependencia";
		} else {
			$sql = "SELECT *   FROM organismos_dep  WHERE organismo = '{$organismo}' ORDER BY organismo, dependencia";
		}
		return toba::db('burgos_v2')->consultar($sql);		
	}
}
?>