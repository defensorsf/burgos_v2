<?php
class dt_instituciones extends toba_datos_tabla
{
	function get_listado()
	{
		$sql = "SELECT
			*
		FROM
			instituciones as t_i
		ORDER BY nombre";
		return toba::db('burgos_v2')->consultar($sql);
	}

	function get_descripciones()
	{
		$sql = "SELECT id, nombre FROM instituciones ORDER BY nombre";
		return toba::db('burgos_v2')->consultar($sql);
	}

}
?>