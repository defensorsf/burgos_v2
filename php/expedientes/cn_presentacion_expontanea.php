<?php
class cn_presentacion_expontanea extends burgos_v2_cn
{
	// function get_listado()
	// {
		// return toba::consulta_php('consultas')->get_datos_persona();
	// }
	
	//--------------------------------------------------------------------------
	//---- Manejo de datos -----------------------------------------------------
	//--------------------------------------------------------------------------
	
	function tabla($id)
	{
		return $this->dep('datos_expedientes')->tabla($id);
	}
	
	function cargar($condiciones)
	{
		$this->dep('datos_expedientes')->cargar($condiciones);
	}
	
	function esta_cargada()
	{
		return $this->dep('datos_expedientes')->esta_cargada();
	}
	
	function resetear()
	{
		$this->dep('datos_expedientes')->resetear();
	}
	
	function eliminar()
	{
		$this->dep('datos_expedientes')->eliminar_todo();
	}
	
	function sincronizar()
	{
		$this->dep('datos_expedientes')->sincronizar();
	}
	
		
	//--------------------------------------------------------------------------
	//---- Tabla: expedientes
	//--------------------------------------------------------------------------
	
	function get_expedientes()
	{
		return $this->tabla('expedientes')->get_filas();
	}
	
	function set_datos_expedientes($datos)
	{
		$this->tabla('expedientes')->set($datos);
	}
	//--------------------------------------------------------------------------
	//---- Tabla: roles
	//--------------------------------------------------------------------------
	function get_roles()
	{
		return $this->tabla('roles')->get_filas();
	}
	
	function set_datos_roles($datos)
	{
		$this->tabla('roles')->set($datos);
	}    
	
	//--------------------------------------------------------------------------
	//---- Tabla: profesionales
	//--------------------------------------------------------------------------
	function get_profesionales()
	{
		return $this->tabla('profesionales')->get_filas();
	}
	
	function set_datos_profesionales($datos)
	{
		$this->tabla('profesionales')->set($datos);
	}


}
?>