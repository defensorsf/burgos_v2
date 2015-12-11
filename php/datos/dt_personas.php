<?php
class dt_personas extends toba_datos_tabla
{
	function get_listado($filtro=array())
	{
		$where = array();
		if (isset($filtro['id'])) {
			$where[] = "id = {$filtro['id']}";
		}
		if (isset($filtro['documento_nro'])) {
			$where[] = "documento_nro ILIKE ".quote("%{$filtro['documento_nro']}%");
		}
		if (isset($filtro['nombre'])) {
			$where[] = "t_p.nombre ILIKE ".quote("%{$filtro['nombre']}%");
		}        
		if (isset($filtro['apellido'])) {
			$where[] = "apellido ILIKE ".quote("%{$filtro['apellido']}%");
		}
		$sql = "SELECT
			t_p.*,
			t_g.nombre as id_genero_nombre,
			t_ec.nombre as id_estado_civil_nombre,
			t_dt.nombre as id_documento_tipo_nombre,
			t_p1.nombre as id_pais_nacimiento_nombre,
			t_d.nombre as id_distrito_nombre,
			t_l.nombre as id_localidad_nombre,
			t_ni.nombre as id_nivel_instruccion_nombre,
			t_b.nombre as id_barrio_nombre
			
			
		FROM
			personas as t_p    LEFT OUTER JOIN generos as t_g ON (t_p.id_genero = t_g.id)
			LEFT OUTER JOIN estados_civiles as t_ec ON (t_p.id_estado_civil = t_ec.id)
			LEFT OUTER JOIN paises as t_p1 ON (t_p.id_pais_nacimiento = t_p1.id)
			LEFT OUTER JOIN distritos as t_d ON (t_p.id_distrito = t_d.id)
			LEFT OUTER JOIN localidades as t_l ON (t_p.id_localidad = t_l.id)
			LEFT OUTER JOIN niveles_instruccion as t_ni ON (t_p.id_nivel_instruccion = t_ni.id)
			LEFT OUTER JOIN barrios as t_b ON (t_p.id_barrio = t_b.id),
			documentos_tipos as t_dt
		WHERE
				t_p.id_documento_tipo = t_dt.id
		ORDER BY nombre";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('burgos_v2')->consultar($sql);
	}



	
	function get_seleccion_persona($filtro=array())
	{
		$where = array();
		if (isset($filtro['apellido'])) {
			$where[] = "apellido ILIKE ".quote("%{$filtro['apellido']}%");
		}
		if (isset($filtro['documento_nro'])) {
			$where[] = "documento_nro ILIKE ".quote("%{$filtro['documento_nro']}%");
		}
		$sql = "SELECT
						p.id,
						apellido,
						documento_nro,
						p.nombre || ' ' || apellido || ' ' || dt.nombre || ' ' || documento_nro AS dato 
				FROM
					personas AS p 
				INNER JOIN documentos_tipos AS dt
				ON p.id_documento_tipo = dt.id
				ORDER BY dato";
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		return toba::db('burgos_v2')->consultar($sql);    
	}

}
?>