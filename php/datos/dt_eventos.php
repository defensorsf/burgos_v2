<?php
class dt_eventos extends toba_datos_tabla
{
	function get_listado($filtro=array())
	{
		$where = array();
		if (isset($filtro['fecha'])) {
			$where[] = "fecha = ".quote($filtro['fecha']);
		}
		if (isset($filtro['descripcion'])) {
			$where[] = "descripcion ILIKE ".quote("%{$filtro['descripcion']}%");
		}
		$sql = "SELECT
			*
		FROM
			eventos as t_e
		ORDER BY t_e.fecha";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('burgos_v2')->consultar($sql);
	}




}
?>