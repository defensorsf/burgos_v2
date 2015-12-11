<?php
class ci_buscar_personas extends burgos_v2_ci
{
	protected $s__datos_filtro;

	//-----------------------------------------------------------------------------------
	//---- cuadro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	/*function evt__cuadro__seleccion($seleccion)
	{
		$this->dep('datos')->cargar($datos);
	}
*/
	function conf__cuadro(burgos_v2_ei_cuadro $cuadro)
	{
		$cuadro->desactivar_modo_clave_segura();
		
		/*if (isset($this->s__datos_filtro)) {
			$cuadro->set_datos($this->dep('datos')->tabla('personas')->get_listado($this->s__datos_filtro));
		} else {
			$cuadro->set_datos($this->dep('datos')->tabla('personas')->get_listado());
		}*/
		$cuadro->set_datos($this->dep('datos')->tabla('personas')->get_seleccion_persona($this->s__datos_filtro));
		
	}

	//-----------------------------------------------------------------------------------
	//---- filtro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__filtro(burgos_v2_ei_formulario $filtro)
	{
		if (isset($this->s__datos_filtro)) {
			$filtro->set_datos($this->s__datos_filtro);
		}
	}

	function evt__Filtro__filtrar($datos)
	{
		$this->s__datos_filtro = $datos;
	}

	function evt__Filtro__cancelar()
	{
		unset($this->s__datos_filtro);
	}
	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__agregar()
	{
		$this->set_pantalla('pant_crear');
	}

	function evt__cancelar()
	{    
		$this->dep('datos')->resetear();
		$this->set_pantalla('pant_seleccion');
	}

	function evt__procesar()
	{
		//toba::notificacion()->agregar('la pucha');
		$this->dep('datos')->sincronizar();
		$this->dep('datos')->resetear();
		//$this->dep('cuadro')->set_datos($this->dep('datos')->tabla('personas')->get_seleccion_persona($this->s__datos_filtro));
		//$this->set_pantalla('pant_seleccion');
	}

	//-----------------------------------------------------------------------------------
	//---- frm_persona ------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__frm_persona__modificacion($datos)
	{
		toba::notificacion()->agregar('la pucha');
	}

}
?>