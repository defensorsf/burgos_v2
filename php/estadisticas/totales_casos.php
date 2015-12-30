<?php
class totales_casos extends burgos_v2_ci
{
	protected $s__datos_filtro;

	//-----------------------------------------------------------------------------------
	//---- filtro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function conf__filtro(burgos_v2_ei_filtro $filtro)
	{
		$filtro->columna('fecha')->set_condicion_fija('entre');
		if (isset($this->s__datos_filtro)) {
			$filtro->set_datos($this->s__datos_filtro);
			
		}
	}

	function evt__filtro__filtrar($datos)
	{
		$this->s__datos_filtro = $datos;
	}

	function evt__filtro__cancelar()
	{
		unset($this->s__datos_filtro);
	}

	//-----------------------------------------------------------------------------------
	//---- formulario -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__formulario(burgos_v2_ei_formulario $form)
	{
		if (isset($this->s__datos_filtro)) {
			$consulta = toba::consulta_php('consultas')->expedientes_iniciados(	$this->genera_where($this->s__datos_filtro));
			$form->set_datos($consulta[0]);
		} 
	}

	//-----------------------------------------------------------------------------------
	//---- cuadro_violencias ------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cuadro_violencias(burgos_v2_ei_cuadro $cuadro)
	{
		if (isset($this->s__datos_filtro)) {
			// $consulta = toba::consulta_php('consultas')->conteo_violencias(	$this->s__datos_filtro['fecha']['valor']['desde'],
																			// $this->s__datos_filtro['fecha']['valor']['hasta']);			
			$consulta = toba::consulta_php('consultas')->conteo_violencias_g($this->genera_where($this->s__datos_filtro));			
			$cuadro->set_datos($consulta);
		}	
	}

	//-----------------------------------------------------------------------------------
	//---- cuadro_nomecladores ----------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cuadro_nomecladores(burgos_v2_ei_cuadro $cuadro)
	{
		if (isset($this->s__datos_filtro)) {
			$consulta = toba::consulta_php('consultas')->conteo_nomecladores($this->genera_where($this->s__datos_filtro));			
			$cuadro->set_datos($consulta);
		}	
	}
	
	
	//----------------------------------------------------
	//---------------Generación del where-------------------
	//El where se usa en varios cuadros, por lo que me conviene generarla clausula SQL una sola vez y pasarla directamente 
	//a cada generacion de datos
	function genera_where ($filtro = array()){	
		$where = array();
		if (isset($filtro['fecha'])) {
			$where[] =  "fecha_presentacion  BETWEEN  '" . $filtro['fecha']['valor']['desde'] . "' AND '" . $filtro['fecha']['valor']['hasta'] . "'";
		}
		if (isset($filtro['id_genero'])) {
			//El genero puede ser una lista de valores		
			$where[] =  'pr.id_genero IN (' . implode(',',$filtro['id_genero']['valor']) . ')';
		}
		if (isset($filtro['edad'])) {
			switch ($filtro['edad']['valor']){
				case '0-5':
					$edad_desde = '0';
					$edad_hasta = '5';
					break;
				case '6-10':
					$edad_desde = '6';
					$edad_hasta = '10';
					break;
				case '>60':
					$edad_desde = '60';
					$edad_hasta = '1001';
					break;
				default: 
				//excepto los tres casos anteriores todos los rango son de la formato
				// "xx-yy", así que extraigo los dos primeros y ultimos dígitos respectivamente
					$edad_desde = substr($filtro['edad']['valor'],0,2);
					$edad_hasta = substr($filtro['edad']['valor'],-2);
			}
			$where[] =  "edad  BETWEEN  $edad_desde AND $edad_hasta" ;
		}
		
		return  implode(' AND ', $where);
	}
}
?>