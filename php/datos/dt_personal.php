<?php
class dt_personal extends toba_datos_tabla
{
	function get_listado($filtro=array())
	{
		$where = array();
		
		if (isset($filtro['id'])) {
			$where[] = "id = {$filtro['id']}";
		}
		if (isset($filtro['apellido'])) {
			$where[] = "apellido ILIKE ".quote("%{$filtro['apellido']}%");
		}
		if (isset($filtro['nombre'])) {
			$where[] = "nombre ILIKE ".quote("%{$filtro['nombre']}%");
		}
		if (isset($filtro['area'])) {
			$where[] = "area ILIKE ".quote("%{$filtro['area']}%");
		}
		$sql = "SELECT
			t_p.id,
			t_p.apellido,
			t_p.nombre,
			t_p.telefono,
			t_p.area,
			t_p.profesional
		FROM
			personal as t_p
		ORDER BY nombre";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('burgos_v2')->consultar($sql);
	}
	
	function get_seleccion_personal($filtro=array())
	{
		$where = array();
		if (isset($filtro['apellido'])) {
			$where[] = "apellido ILIKE ".quote("%{$filtro['apellido']}%");
		}
		if (isset($filtro['nombre'])) {
			$where[] = "nombre ILIKE ".quote("%{$filtro['nombre']}%");
		}
		if (isset($filtro['area'])) {
			$where[] = "area ILIKE ".quote("%{$filtro['area']}%");
		}
		$sql = "SELECT
			t_p.id,
			t_p.apellido,
			t_p.nombre,
			t_p.telefono,
			t_p.area,
			t_p.apellido || ', '|| t_p.nombre || ' : ' || t_p.area AS dato
		FROM
			personal as t_p
		ORDER BY dato";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('burgos_v2')->consultar($sql);
	}
	
		function get_seleccion_profesional($filtro=array())
	{
		$where = array();
		if (isset($filtro['apellido'])) {
			$where[] = "apellido ILIKE ".quote("%{$filtro['apellido']}%");
		}
		if (isset($filtro['nombre'])) {
			$where[] = "nombre ILIKE ".quote("%{$filtro['nombre']}%");
		}
		if (isset($filtro['area'])) {
			$where[] = "area ILIKE ".quote("%{$filtro['area']}%");
		}
		$sql = "SELECT
			t_p.id,
			t_p.apellido,
			t_p.nombre,
			t_p.telefono,
			t_p.area,
			t_p.apellido || ', '|| t_p.nombre || ' : ' || t_p.area AS dato
		FROM
			personal as t_p
		WHERE 
			t_p.profesional = true
		ORDER BY dato";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('burgos_v2')->consultar($sql);
	}
	
	

}
?>