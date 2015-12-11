<?php
class agregar_persona extends burgos_v2_ci
{
	
	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__procesar()
	{
		$this->dep('datos')->resetear();
		$this->set_pantalla('pant_seleccion');
	}

	function evt__cancelar()
	{
        $this->dep('datos')->sincronizar();
		$this->dep('datos')->resetear();
		$this->set_pantalla('pant_seleccion');
	}

}
?>