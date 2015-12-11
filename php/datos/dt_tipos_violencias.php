<?php
class dt_tipos_violencias extends toba_datos_tabla
{

	function get_descripciones()
	{
		$sql = "SELECT id, nombre FROM tipos_violencias ORDER BY nombre";
		return toba::db('burgos_v2')->consultar($sql);
	}

	

	function get_listado($filtro=array())
	{
		$where = array();
		if (isset($filtro['nombre'])) {
			$where[] = "nombre ILIKE ".quote("%{$filtro['nombre']}%");
		}
		$sql = "SELECT
			t_tv.id,
			t_tv.nombre
		FROM
			tipos_violencias as t_tv
		ORDER BY nombre";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('burgos_v2')->consultar($sql);
	}

}
?>