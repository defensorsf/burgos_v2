<?php
class ci_archivar extends burgos_v2_ci
{
	
	protected $s__datos_filtro;

	//-----------------------------------------------------------------------------------
	//---- cuadro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cuadro(burgos_v2_ei_cuadro $cuadro)
	{
		if (!isset($this->s__datos_filtro)){
			$this->s__datos_filtro['estado'] = 1;
		}
		$cuadro->set_datos($this->dep('datos')->tabla('expedientes')->get_select_expedientes($this->s__datos_filtro));
	}

	function evt__cuadro__seleccion($seleccion)
	{
		toba::db()->ejecutar('UPDATE expedientes SET estado = 2 WHERE id = ' . $seleccion['id']);
		$this->evt__filtro__cancelar();
		
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
		//Agrego esta linea para que solo me tomo los expedientes abiertos (estado = 0)
		$datos["estado"] = 1;
		$this->s__datos_filtro = $datos;        
	}

	function evt__filtro__cancelar()
	{
		unset($this->s__datos_filtro);
	}


}
?>