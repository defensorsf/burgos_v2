<?php
//php_referencia::instancia()->agregar(__FILE__);

class consultas
{
	/*--------------------------------------------
	----------------Personas----------------------
	----------------------------------------------*/
	static function get_persona_datos($id_persona)
	{
		$sql = "SELECT	
					p.id,
					p.nombre,
					apellido,
					documento_nro,
					d.nombre as documento_tipo
				FROM personas AS p 
				INNER JOIN documentos_tipos AS d
				ON p.id_documento_tipo = d.id
				WHERE p.id = ".quote($id_persona);
		return toba::db()->consultar_fila($sql);
	}
	static function get_roles()
	{
		$sql = "SELECT	
					id,
					nombre
				FROM roles 
				ORDER BY nombre";
		return toba::db()->consultar($sql);
	}

	static function get_persona_nombre($id_persona)
	{
		$datos = self::get_persona_datos($id_persona);
		
		if ($datos !== false) {
			return "{$datos['nombre']} {$datos['apellido']} - {$datos['documento_tipo']}:{$datos['documento_nro']}";
		} else {
			return '';	
		}
	}
	
	/*--------------------------------------------
	----------------Vinculos----------------------
	----------------------------------------------*/
	
	static function get_vinculos()
	{
		$sql = "SELECT	
					id,
					nombre
				FROM vinculos
				
				ORDER BY nombre";
		return toba::db()->consultar($sql);
	}
	
	/*--------------------------------------------
	----------------Geografías----------------------
	----------------------------------------------*/
	
	static function get_barrios($localidad){
			
	//Devuelve los barrios de las localiades	
		$sql = "SELECT	
					id,
					nombre
				FROM barrios 
				WHERE id_localidad = " . $localidad;	
		return  toba::db()->consultar($sql);
	
	}

	static function get_distritos($localidad){
	//Devuelve los distritos de las localiades	
		$sql = "SELECT	
					id,
					nombre
				FROM distritos 
				WHERE id_localidad = " . $localidad;
		return toba::db()->consultar($sql);
	}

	
	
	/*--------------------------------------------
	----------------Nomeclaturas----------------------
	----------------------------------------------*/
	static function get_nomeclaturas($ambito){
	//Devuelve los distritos de las localiades	
		$sql = "SELECT	
					id,
					nombre
				FROM tipos_casos 
				WHERE id_ambito = " . $ambito;
		return toba::db()->consultar($sql);
	}


	/*--------------------------------------------
	----------------Hoja de Ruta----------------------
	----------------------------------------------*/
	
	static function get_hoja_de_ruta($where='true')
	{
		$sql = "
			SELECT
			ex.numero as expediente,
			iv.fecha,
			ti.nombre AS tipo_intervencion,
			iv.quien,
			iv.observaciones
			FROM
			intervenciones AS iv
			  INNER JOIN expedientes AS ex  
				ON ex.id = iv.id_expediente
			  INNER JOIN tipos_intervenciones AS ti
				ON iv.id_tipo = ti.id
			WHERE
			$where
		";
		return toba::db()->consultar($sql);
	}

	/*--------------------------------------------
	----------------expedientes----------------------
	----------------------------------------------*/
	
	static function get_expedientes_persona($persona)
	{
		$sql = "
			SELECT * FROM expedientes AS ex
			INNER JOIN roles_vinculo AS rv
			ON rv.id_expediente = ex.id
			WHERE  = 
			
		";
		return toba::db()->consultar($sql);
	}
	
	static function get_datos_expediente($filtro)
	{
		$where = self::operacion_filtro('numero','ex.numero', $filtro);	 
	}
	
	/*--------------------------------------------
	----------------Filtros-----------------------
	----------------------------------------------*/
	static function operacion_filtro($indice,$variable, $filtro){
//Esta función toma como prametros el indice de la variable dentro del arreglo filtro  donde
//vienen los datos del filtro completo. Y devuelve un string sql preparado par filtrar.
//dependiendo de la condicion que viene dado para ese indice dentro del arreglo filtro.
		switch ($filtro[$indice]['condicion']){
				case 'comienza_con':
					return "$variable ILIKE ".quote("{$filtro[$indice]['valor']}%");
					break;
				case 'termina_con':
					return "$variable ILIKE ".quote("%{$filtro[$indice]['valor']}");
					break;
				case 'contiene':
					return "$variable  ILIKE ".quote("%{$filtro[$indice]['valor']}%");
					break;
				case 'no_contiene':
					return "$variable  NOT ILIKE ".quote("%{$filtro[$indice]['valor']}%");
					break;
				case 'es_igual_a':
					return "$variable  = ".quote("{$filtro[$indice]['valor']}");
					break;
				case 'es_distinto_de':
					return "$variable  <> ".quote("{$filtro[$indice]['valor']}");
					break;
				case 'desde':
					return "$variable  >= ".quote("{$filtro[$indice]['valor']}");
					break;
				case 'hasta':
					return "$variable  <= ".quote("{$filtro[$indice]['valor']}");
					break;
				case 'entre':
					return "$variable  BETWEEN  ".quote($filtro[$indice]['valor']['desde']).' AND '.quote($filtro[$indice]['valor']['hasta']);
					break;
			}
		}
	
	
	/*--------------------------------------------
	----------------Estadisticas----------------------
	----------------------------------------------*/
	static function expedientes_iniciados($desde,$hasta){
		$sql= 	"SELECT count(ex.id) AS ex_iniciados
				 FROM expedientes.ex
				 WHERE ex.fecha_presentacion BETWEEN " .quote($desde) . ' AND ' .quote($hasta);
		return toba::db()->consultar($sql);		
	}
	
	static function conteo_violencias($desde,$hasta){
		$sql= 	"SELECT conteo.cantidad, tv.nombre
				FROM
					(SELECT COUNT(id) AS cantidad, id_violencia  
					FROM  (
							SELECT id, violencia_1 AS id_violencia 
								FROM expedientes 
								WHERE fecha_presentacion BETWEEN ". quote($desde) . " AND  ". quote($hasta) . "  AND violencia_1 IS NOT NULL
							UNION SELECT id, violencia_2 AS id_violencia 
								FROM expedientes 
								WHERE fecha_presentacion BETWEEN  ". quote($desde) . "  AND ". quote($hasta) . " AND violencia_2 IS NOT NULL
							UNION SELECT id, violencia_3 AS id_violencia 
								FROM expedientes 
								WHERE fecha_presentacion BETWEEN  ". quote($desde) . "  AND ". quote($hasta) . " AND violencia_3 IS NOT NULL
							) AS plano
					GROUP BY id_violencia)AS conteo		
				JOIN tipos_violencias AS tv
				ON tv.id = conteo.id_violencia ";
		return toba::db()->consultar($sql);		
	
	}

	static function conteo_nomecladores($desde,$hasta){
		$sql= 	"SELECT conteo.cantidad, tv.nombre
				FROM
					(SELECT COUNT(id) AS cantidad, id_nomeclador 
					FROM  (
							SELECT id, nomeclador_1 AS id_nomeclador 
								FROM expedientes 
								WHERE fecha_presentacion BETWEEN ". quote($desde) . " AND  ". quote($hasta) . "  AND nomeclador_1 IS NOT NULL
							UNION SELECT id, nomeclador_2 AS id_nomeclador 
								FROM expedientes 
								WHERE fecha_presentacion BETWEEN  ". quote($desde) . "  AND ". quote($hasta) . " AND nomeclador_2 IS NOT NULL
							UNION SELECT id, nomeclador_3 AS id_nomeclador 
								FROM expedientes 
								WHERE fecha_presentacion BETWEEN  ". quote($desde) . "  AND ". quote($hasta) . " AND nomeclador_3 IS NOT NULL
							) AS plano
					GROUP BY id_nomeclador)AS conteo		
				JOIN tipos_nomeclador AS tv
				ON tv.id = conteo.id_nomeclador ";
		return toba::db()->consultar($sql);		
	
	}
	// SELECT count(id), to_char(fecha_presentacion, 'Day' ) AS dia 
// FROM  expedientes
// WHERE fecha_presentacion BETWEEN '2015-07-01' AND  '2015-08-30'
// GROUP BY  dia
	
	/*--------------------------------------------
	----------------Fechas----------------------
	----------------------------------------------*/
	
	/**
		Retorna los dias de la semana
	*/
	static function get_dias_semana()
	{
		$dias[0]['id'] = '0';
		$dias[0]['desc'] = 'Lunes';
		$dias[1]['id'] = '1';
		$dias[1]['desc'] = 'Martes';
		$dias[2]['id'] = '2';
		$dias[2]['desc'] = 'Miercoles';
		$dias[3]['id'] = '3';
		$dias[3]['desc'] = 'Jueves';
		$dias[4]['id'] = '4';
		$dias[4]['desc'] = 'Viernes';
		$dias[5]['id'] = '5';
		$dias[5]['desc'] = 'Sabado';
		$dias[6]['id'] = '6';
		$dias[6]['desc'] = 'Domingo';
		return $dias;
	}

	/**
		Devuelve un dia con el formato que necesita el DAO
	*/
	static function get_dia_semana($dia)
	{
		$dias = self::get_dias_semana();
		$d[0]['desc_dia_semana'] = $dias[$dia]['desc'];
		return $d;
	}

	static function traeme_mis_dias($dias_mios)
	{
		$resultado = array();
		$dias = self::get_dias_semana();
		foreach($dias as $dia) {
			if (in_array($dia['id'], $dias_mios)) {
				$resultado[] =array('dia_semana' => $dia['id'], 'desc_dia_semana' => $dia['desc']);
			}
		}
		return $resultado;
	}

	/**
		Retorna las horas del dia
	*/
	static function get_horas_dia()
	{
		for($a=0;$a<24;$a++){
			$horas[$a]['id'] = $a+1;	
			$horas[$a]['desc'] = str_pad($a+1,2,0,STR_PAD_LEFT);	
		}
		return $horas;
	}
	
}
?>
