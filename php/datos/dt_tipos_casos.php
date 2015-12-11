<?php
class dt_tipos_casos extends toba_datos_tabla
{
	
	function get_descripciones()
	{
		$sql = "SELECT id, nombre FROM tipos_casos ORDER BY nombre";
		return toba::db('burgos_v2')->consultar($sql);
	}

	

	function get_listado($filtro=array())
	{
		$where = array();
		if (isset($filtro['id_ambito'])) {
			$where[] = "id_ambito = ".quote($filtro['id_ambito']);
		}
		if (isset($filtro['nombre'])) {
			$where[] = "nombre ILIKE ".quote("%{$filtro['nombre']}%");
		}
		$sql = "SELECT
			t_tc.id,
			t_a.nombre as id_ambito_nombre,
			t_tc.nombre
		FROM
			tipos_casos as t_tc	LEFT OUTER JOIN ambitos as t_a ON (t_tc.id_ambito = t_a.id)
		ORDER BY nombre";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('burgos_v2')->consultar($sql);
	}

}
?>