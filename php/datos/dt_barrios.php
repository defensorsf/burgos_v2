<?php
class dt_barrios extends toba_datos_tabla
{
	function get_listado($filtro=array())
	{
		$where = array();
		if (isset($filtro['nombre'])) {
			$where[] = "nombre ILIKE ".quote("%{$filtro['nombre']}%");
		}
		if (isset($filtro['id_localidad'])) {
			$where[] = "id_localidad = ".quote($filtro['id_localidad']);
		}
		$sql = "SELECT
			t_b.id,
			t_b.nombre,
			t_l.nombre as id_localidad_nombre
		FROM
			barrios as t_b,
			localidades as t_l
		WHERE
				t_b.id_localidad = t_l.id
		ORDER BY nombre";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('burgos_v2')->consultar($sql);
	}

	function get_descripciones()
	{
		$sql = "SELECT id, nombre FROM barrios ORDER BY nombre";
		return toba::db('burgos_v2')->consultar($sql);
	}




}
?>