<?php
class dt_niveles_instruccion extends toba_datos_tabla
{
	function get_descripciones()
	{
		$sql = "SELECT id, nombre FROM niveles_instruccion ORDER BY nombre";
		return toba::db('burgos_v2')->consultar($sql);
	}




	function get_listado($filtro=array())
	{
		$where = array();
		if (isset($filtro['nombre'])) {
			$where[] = "nombre ILIKE ".quote("%{$filtro['nombre']}%");
		}
		$sql = "SELECT
			t_ni.id,
			t_ni.nombre
		FROM
			niveles_instruccion as t_ni
		ORDER BY nombre";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('burgos_v2')->consultar($sql);
	}

}
?>