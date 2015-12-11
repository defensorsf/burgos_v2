<?php
class ci_gestionar_exp extends burgos_v2_ci
{
	
	protected $s__datos_filtro;
	//-----------------------------------------------------------------------------------
	//---- cuadro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cuadro(burgos_v2_ei_cuadro $cuadro)
	{
		$this->s__datos_filtro['estado'] = 3;
		if (isset($this->s__datos_filtro)){
			$cuadro->set_datos($this->cn()->get_select_expedientes($this->s__datos_filtro));
		}else{
			$cuadro->set_datos($this->cn()->get_select_expedientes());
		}
	}

	function evt__cuadro__seleccion($seleccion)
	{
		//ei_arbol($seleccion);
		$this->cn()->cargar($seleccion);
		$de = $this->cn()->get_expediente_desnormalizado($seleccion['id']);
		$victimas = $this->cn()->get_personas_expedientes($seleccion, 1);  //1 es el id de victima
		
		$titulo = '<table width = "100%"><tr><td>  ';
		foreach ($victimas as $v){
			$titulo .= $v['nombre_persona'] . ', ';
		}
		$titulo = substr($titulo, 0, strlen($titulo) - 2) . '</td>';
		$titulo .= "<td style= 'text-align: right'>Expediente Nº: {$de[0]['numero']}<td></tr></table>";
		toba::memoria()->set_dato('titulo_pantalla',$titulo);
		//$this->pantalla('pant_edicion')->set_titulo($titulo);	
		$this->set_pantalla('pant_edicion');
	}


	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__procesar()
	{
		//toba::notificacion()->agregar('Pasé por->  evt_procesar en ci_gestionar_exp');
		$this->cn()->sincronizar();
	}

	//-----------------------------------------------------------------------------------
	//---- filtro_complejo --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__filtro_complejo(burgos_v2_ei_filtro $filtro)
	{
		$filtro->columna('fecha')->set_condicion_fija('entre');
		if (isset($this->s__datos_filtro)) {
			$filtro->set_datos($this->s__datos_filtro);
		}   
	}

	function evt__filtro_complejo__filtrar($datos)
	{
		//ei_arbol($datos);
		$this->s__datos_filtro = $datos;
	}

	function evt__filtro_complejo__cancelar()
	{
		unset($this->s__datos_filtro);
	}

	//-----------------------------------------------------------------------------------
	//---- Configuraciones --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__pant_edicion(toba_ei_pantalla $pantalla)
	{
		$pantalla->set_titulo(toba::memoria()->get_dato('titulo_pantalla'));
	}

	

}
?>