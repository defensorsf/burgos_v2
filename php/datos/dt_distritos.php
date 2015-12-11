<?php
class dt_distritos extends toba_datos_tabla
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
			t_d.id,
			t_d.nombre,
			t_l.nombre as id_localidad_nombre
		FROM
			distritos as t_d,
			localidades as t_l
		WHERE
				t_d.id_localidad = t_l.id
		ORDER BY nombre";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('burgos_v2')->consultar($sql);
	}

	function get_descripciones()
	{
		$sql = "SELECT id, nombre FROM distritos ORDER BY nombre";
		return toba::db('burgos_v2')->consultar($sql);
	}




}
?>