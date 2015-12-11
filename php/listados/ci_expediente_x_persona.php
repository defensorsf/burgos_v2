<?php
class ci_expediente_x_persona extends burgos_v2_ci
{
	protected $s__datos_filtro;
	//-----------------------------------------------------------------------------------
	//---- cuadro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cuadro(burgos_v2_ei_cuadro $cuadro)
	{
		if (isset($this->s__datos_filtro)){
			$cuadro->set_datos($this->dep('datos')->tabla('expedientes')->get_select_expedientes($this->s__datos_filtro));
		// }else{
			// $cuadro->set_datos($this->dep('datos')->tabla('expedientes')->get_select_expedientes());
		}
	}

	function evt__cuadro__ordenar($columna, $sentido)
	{
	}

	//-----------------------------------------------------------------------------------
	//---- filtro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__filtro(burgos_v2_ei_filtro $filtro)
	{
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

}

?>