<?php
class dt_generos extends toba_datos_tabla
{
	function get_listado($filtro=array())
	{
		$where = array();
		if (isset($filtro['nombre'])) {
			$where[] = "nombre ILIKE ".quote("%{$filtro['nombre']}%");
		}
		$sql = "SELECT
			t_g.id,
			t_g.nombre
		FROM
			generos as t_g
		ORDER BY nombre";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('burgos_v2')->consultar($sql);
	}

	function get_descripciones()
	{
		$sql = "SELECT id, nombre FROM generos ORDER BY nombre";
		return toba::db('burgos_v2')->consultar($sql);
	}




}
?>