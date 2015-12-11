<?php
class dt_intervenciones extends toba_datos_tabla
{
	function get_listado($filtro=array())
	{
		$where = array();
		if (isset($filtro['id_expediente'])) {
			$where[] = 'id_expediente = '.quote($filtro['id_expediente']);
		}
		if (isset($filtro['id_tipo'])) {
			$where[] = 'id_tipo = '.quote($filtro['id_tipo']);
		}
		if (isset($filtro['fecha'])) {
			$where[] = 'fecha = '.quote($filtro['fecha']);
		}
		if (isset($filtro['observaciones'])) {
			$where[] = 'observaciones ILIKE '.quote("%{$filtro['observaciones']}%");
		}
		if (isset($filtro['quien'])) {
			$where[] = 'quien ILIKE '.quote("%{$filtro['quien']}%");
		}
		$sql = 'SELECT
			t_i.id,
			t_e.numero as id_expediente_nombre,
			t_ti.nombre as id_tipo_nombre,
			t_i.fecha,
			t_i.observaciones,
			t_i.quien
		FROM
			intervenciones as t_i	LEFT OUTER JOIN expedientes as t_e ON (t_i.id_expediente = t_e.id)
			LEFT OUTER JOIN tipos_intervenciones as t_ti ON (t_i.id_tipo = t_ti.id)
		ORDER BY observaciones';
		if (count($where) > 0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('burgos_v2')->consultar($sql);
	}

	function get_descripciones()
	{
		$sql = 'SELECT id, observaciones FROM intervenciones ORDER BY observaciones';
		return toba::db('burgos_v2')->consultar($sql);
	}

}
?>