<?php
class ci_buscar_profesionales extends burgos_v2_ci
{
	//-----------------------------------------------------------------------------------
	//---- cuadro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cuadro(burgos_v2_ei_cuadro $cuadro)
	{
		$cuadro->desactivar_modo_clave_segura();
		$cuadro->set_datos($this->dep('datos')->tabla('personal')->get_seleccion_profesional());
		
	}
}
?>