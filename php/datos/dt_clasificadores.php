<?php
class dt_clasificadores extends toba_datos_tabla
{
	function get_listado($filtro=array())
	{
		$where = array();
		if (isset($filtro['id_ambito'])) {
			$where[] = "id_ambito = ".quote($filtro['id_ambito']);
		}
		if (isset($filtro['violencia'])) {
			$where[] = "violencia = ".quote($filtro['violencia']);
		}
		$sql = "SELECT
			t_c.id,
			t_a.nombre as id_ambito_nombre,
			t_tc.nombre as id_tipo1_nombre,
			t_tc1.nombre as id_tipo2_nombre,
			t_tc2.nombre as id_tipo3_nombre,
			t_c.violencia,
			t_tv.nombre as id_tipov1_nombre,
			t_tv3.nombre as id_tipov2_nombre,
			t_tv4.nombre as id_tipov3_nombre
		FROM
			clasificadores as t_c	LEFT OUTER JOIN ambitos as t_a ON (t_c.id_ambito = t_a.id)
			LEFT OUTER JOIN tipos_casos as t_tc ON (t_c.id_tipo1 = t_tc.id)
			LEFT OUTER JOIN tipos_casos as t_tc1 ON (t_c.id_tipo2 = t_tc1.id)
			LEFT OUTER JOIN tipos_casos as t_tc2 ON (t_c.id_tipo3 = t_tc2.id)
			LEFT OUTER JOIN tipos_violencias as t_tv ON (t_c.id_tipov1 = t_tv.id)
			LEFT OUTER JOIN tipos_violencias as t_tv3 ON (t_c.id_tipov2 = t_tv3.id)
			LEFT OUTER JOIN tipos_violencias as t_tv4 ON (t_c.id_tipov3 = t_tv4.id)";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('burgos_v2')->consultar($sql);
	}

}

?>