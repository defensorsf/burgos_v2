<?php
class dt_expedientes extends toba_datos_tabla
{

	function get_ultimo_registro(){
		$sql = "SELECT max(id) as id FROM expedientes";
		return toba::db('burgos_v2')->consultar($sql)[0];
	}
	function get_descripciones()
	{
		$sql = "SELECT id, numero FROM expedientes ORDER BY numero";
		return toba::db('burgos_v2')->consultar($sql);
	}
	
	function get_expediente_desnormailzado($id){
		//el posfijo dn es por desnormalizado
		//$datos = $this->get();
		$sql= "
		SELECT  
			ex.id,
			COALESCE(TO_CHAR(ex.fecha_presentacion::timestamp,'DD-MM-YYYY'),'') AS fecha_presentacion,
			COALESCE(TO_CHAR(ex.fecha_ultimo_mov::timestamp,'DD-MM-YYYY'),'') AS fecha_ultimo_mov,
			CASE 
				WHEN id_responsable_ingreso IS NULL then ''
				ELSE personal.nombre || ' ' || personal.apellido
				END AS responsable_ingreso, --ex.id_responsable_ingreso
			ex.numero,
			CASE  
				WHEN ex.denuncia_policial THEN 'SI'
				ELSE 'NO' 
				END  AS denuncia_policial ,
			COALESCE(ex.lugar_denuncia,'') AS lugar_denuncia,
			COALESCE(TO_CHAR(ex.fecha_denuncia::timestamp,'DD-MM-YYYY'),'') fecha_denuncia,
			COALESCE(ex.persona_denuncia,'') persona_denuncia,
			COALESCE(ex.lugar_hecho_denuncia,'') lugar_hecho_denuncia,
			COALESCE(TO_CHAR(ex.ultimo_episodio_denuncia::timestamp,'DD-MM-YYYY'),'') ultimo_episodio_denuncia,
			COALESCE(ex.encuadre_legal,'') encuadre_legal,
			COALESCE(ex.aplicacion_ley,'') aplicacion_ley,
			COALESCE(TO_CHAR(ex.fecha_entrada::timestamp,'DD-MM-YYYY'),'') fecha_entrada,
			COALESCE(TO_CHAR(ex.fecha_salida::timestamp,'DD-MM-YYYY'),'') fecha_salida,
			COALESCE(TO_CHAR(ex.fecha_cierre::timestamp,'DD-MM-YYYY'),'') fecha_cierre,
			COALESCE(TO_CHAR(ex.fecha_archivo::timestamp,'DD-MM-YYYY'),'') fecha_archivo,
			COALESCE(ex.procedencia,'') procedencia,
			instituciones.nombre  institucion, --ex.id_institucion,
			COALESCE(ex.origen_presentacion,'') origen_presentacion,
			COALESCE(ex.motivo_consulta,'') motivo_consulta,
			COALESCE(ex.observaciones,'') observaciones,
			COALESCE(ex.organismo,'') organismo,
			COALESCE(ex.dependencia_org,'') dependencia_org,
			ex.lugar,
			COALESCE(ex.tipo_atencion,'') tipo_atencion,
			COALESCE(ambitos.nombre,'') AS ambito, --ex.id_ambito,
			COALESCE(nome_1.nombre,'')   nomeclador_1, -- ex.nomeclador_1,
			COALESCE(nome_2.nombre,'')   nomeclador_2, -- ex.nomeclador_2,
			COALESCE(nome_3.nombre,'')   nomeclador_3, -- ex.nomeclador_3,
			COALESCE(tv_1.nombre,'')  violencia_1,  --ex.violencia_1,
			COALESCE(tv_2.nombre,'')  violencia_2,  --ex.violencia_2,
			COALESCE(tv_3.nombre,'')  violencia_3,  --ex.violencia_3,
			COALESCE(TO_CHAR(ex.fecha_derivacion::timestamp,'DD-MM-YYYY'),'') fecha_derivacion,
			CASE 
				WHEN ex.hubo_violencia THEN 'SI'
				ELSE 'NO' 
				END  AS hubo_violencia,
			CASE 
				WHEN ex.estado = 0 THEN 'En proceso'
				WHEN ex.estado = 1 THEN 'Pase a Archivo'
				WHEN ex.estado = 2 THEN  'Archivado'
				END  AS estado,
			COALESCE(TO_CHAR(ex.fecha_oficio::timestamp,'DD-MM-YYYY'),'') fecha_oficio,
			COALESCE(ex.nro_expediente_judicial,'') nro_expediente_judicial,
			COALESCE(ex.planificacion,'') planificacion,
			COALESCE(ex.evaluacion,'') evaluacion
		FROM expedientes AS ex
		LEFT JOIN personal
			ON personal.id = id_responsable_ingreso
		LEFT JOIN instituciones
			ON instituciones.id = id_institucion
		LEFT JOIN ambitos
			ON ambitos.id = ex.id_ambito
		LEFT JOIN tipos_casos AS  nome_1
			ON nome_1.id = ex.nomeclador_1
		LEFT JOIN tipos_casos AS  nome_2
			ON nome_1.id = ex.nomeclador_2
		LEFT JOIN tipos_casos AS  nome_3
			ON nome_1.id = ex.nomeclador_3
		LEFT JOIN tipos_violencias AS  tv_1
			ON tv_1.id = ex.violencia_1
		LEFT JOIN tipos_violencias AS  tv_2
			ON tv_2.id = ex.violencia_2
		LEFT JOIN tipos_violencias AS  tv_3
			ON tv_3.id = ex.violencia_3
		WHERE ex.id = $id
		LIMIT 1";
		return toba::db('burgos_v2')->consultar($sql);
	}
	
	function get_select_expedientes($filtro=array(), $rol = null)
	{
		$where = array();
		$campo_persona =  '';
		$join_persona = '';
		if (isset($filtro['numero'])) {
			$where[] = $this->operacion_filtro('numero','ex.numero', $filtro);
		}
		if (isset($filtro['apellido'])) {
			$where[] = $this->operacion_filtro('apellido','per.apellido', $filtro);
			$campo_persona = ",per.nombre  || ' '|| per.apellido || '  --  ' || per.documento_nro AS datos_persona,
			                  roles.nombre AS rol, vinculos.nombre AS vinculo,
							  per.nombre  || ' '|| per.apellido AS persona";
			$join_persona = "
								INNER JOIN roles_vinculos AS rv
									ON ex.id = rv.id_expediente                 
								INNER JOIN personas as per
									ON per.id = rv.id_persona 
								INNER JOIN roles 
								    ON rv.id_rol = roles.id
								INNER JOIN vinculos
								    ON rv.id_vinculo = vinculos.id";
		}
		if (isset($filtro['nombre'])) {
			$where[] = $this->operacion_filtro('nombre','per.nombre', $filtro);
			$campo_persona = ",per.nombre  || ' '|| per.apellido || '  --  ' || per.documento_nro AS datos_persona,
			                  roles.nombre AS rol, vinculos.nombre AS vinculo,
							  per.nombre  || ' '|| per.apellido AS persona";
			$join_persona = "
								INNER JOIN roles_vinculos AS rv
									ON ex.id = rv.id_expediente                 
								INNER JOIN personas as per
									ON per.id = rv.id_persona
								INNER JOIN roles 
								    ON rv.id_rol = roles.id
								INNER JOIN vinculos
								    ON rv.id_vinculo = vinculos.id ";
		}
		if (isset($filtro['estado'])) {
			if ($filtro['estado'] == 3){
				$where[] = 'estado < 2 ';
			}else{
				$where[] = 'estado = ' . $filtro['estado'];
			};
		}
		if (isset($filtro['fecha'])) {
			$where[] = $this->operacion_filtro('fecha','ex.fecha_presentacion', $filtro);
		}
		if (isset($filtro['documento_nro'])) {
			$where[] = $this->operacion_filtro('documento_nro','per.documento_nro',$filtro);
			$campo_persona = ",per.nombre  || ' '|| per.apellido || '  --  ' || per.documento_nro AS datos_persona,
			                  roles.nombre AS rol, vinculos.nombre AS vinculo,
							  per.nombre  || ' '|| per.apellido AS persona	";
			$join_persona = "
								INNER JOIN roles_vinculos AS rv
									ON ex.id = rv.id_expediente                 
								INNER JOIN personas as per
									ON per.id = rv.id_persona
								INNER JOIN roles 
								    ON rv.id_rol = roles.id
								INNER JOIN vinculos
								    ON rv.id_vinculo = vinculos.id";
		}
		$sql = "SELECT DISTINCT
					ex.id,
					ex.numero,
					ex.fecha_presentacion,
					ex.lugar,
					ex.procedencia,
					tc.nombre as nomeclador,
					CASE
						 WHEN estado = 0 THEN 'En proceso'
						 WHEN estado = 1 THEN 'Pase a Archivo'
						 WHEN estado = 2 THEN 'Archivado'
					END AS estado,
					victimas(ex.id),
					responsables(ex.id)
					$campo_persona
					FROM expedientes AS ex
				$join_persona  
				LEFT JOIN tipos_casos AS tc
				ON ex.nomeclador_1 =   tc.id
				ORDER BY 
					ex.numero
				";
		
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		
		return toba::db('burgos_v2')->consultar($sql);
	}

	
	function get_personas_expedientes($filtro=array(), $rol = null)
	//Busca todas las personas que estan involucradas en un expediente	
	{
		$where = array();
		$campo_persona =  '';//',1 AS datos_persona';
		$join_persona = '';
		
		if (isset($rol)) {
			//este es el caso donde paso directamente el rol a buscar
			$where[] = "roles.id = $rol"  ;
		}if (isset($filtro['id'])) {
			//este es el caso donde paso directamente el id del expediente. Es unico
			$where[] = "ex.id = {$filtro['id']}";
		}
		if (isset($filtro['numero'])) {
			$where[] = $this->operacion_filtro('numero','ex.numero', $filtro);
		}
		if (isset($filtro['estado'])) {
			if ($filtro['estado'] == 3){
				$where[] = 'estado < 2 ';
			}else{
				$where[] = 'estado = ' . $filtro['estado'];
			};
		}
		if (isset($filtro['fecha'])) {
			$where[] = $this->operacion_filtro('fecha','ex.fecha_presentacion', $filtro);
		}
		if (isset($filtro['documento_nro'])) {
			$where[] = $this->operacion_filtro('documento_nro','per.documento_nro',$filtro);
			$campo_persona = "";
			$join_persona = "
	";
		}
		$sql = "SELECT DISTINCT
					ex.id,
					ex.numero,
					ex.fecha_presentacion,
					ex.lugar,
					'responsable' AS nombre_responsable_ingreso,
					ex.procedencia,
					tc.nombre as nomeclador,
					vi.nombre AS violencia,
					per.nombre  || ' '|| per.apellido || '  --  ' || per.documento_nro AS datos_persona,
					per.nombre  || ' '|| per.apellido AS nombre_persona,
					roles.nombre as rol
				FROM expedientes AS ex
				INNER JOIN roles_vinculos AS rv
					ON ex.id = rv.id_expediente                 
				INNER JOIN personas as per
					ON per.id = rv.id_persona
				INNER JOIN roles
					ON roles.id = rv.id_rol
				LEFT JOIN tipos_casos AS tc
					ON ex.nomeclador_1 =   tc.id
				LEFT JOIN tipos_violencias  AS vi
					ON vi.id = ex.violencia_1
				ORDER BY 
					ex.numero,  rol
				";
		
		if (count($where)>0) {
			$sql = sql_concatenar_where($sql, $where);
		}
		
		return toba::db('burgos_v2')->consultar($sql);
	}

	
	
	
	function operacion_filtro($indice,$variable, $filtro){
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

}
?>