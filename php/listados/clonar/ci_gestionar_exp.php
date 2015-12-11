<?php
class ci_gestionar_exp extends burgos_v2_ci
{
	
	protected $s__datos_filtro;
	//-----------------------------------------------------------------------------------
	//---- cuadro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cuadro(burgos_v2_ei_cuadro $cuadro)
	{
		if (isset($this->s__datos_filtro)){
			$cuadro->set_datos($this->cn()->get_select_expedientes($this->s__datos_filtro));
		}else{
			$cuadro->set_datos($this->cn()->get_select_expedientes());
		}
	}

	function evt__cuadro__seleccion($seleccion)
	{
		$this->cn()->cargar($seleccion);
		$this->set_pantalla('pant_edicion');
	}


	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__procesar()
	{
		//toba::notificacion()->agregar('Pas� por->  evt_procesar en ci_gestionar_exp');
		$this->cn()->sincronizar();
	}

	//-----------------------------------------------------------------------------------
	//---- filtro_complejo --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__filtro_complejo(burgos_v2_ei_filtro $filtro)
	{
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

}
?>