<?php
class cn_oficio_judicial extends burgos_v2_cn
{
	function tabla($id)
	{
		return $this->dep('datos')->tabla($id);
	}
	
	function cargar($condiciones)
	{
		$this->dep('datos')->cargar($condiciones);
	}
	
	function esta_cargada()
	{
		return $this->dep('datos')->esta_cargada();
	}
	
	function resetear()
	{
		$this->dep('datos')->resetear();
	}
	
	function eliminar()
	{
		$this->dep('datos')->eliminar_todo();
	}
	
	function sincronizar()
	{
		$this->dep('datos')->sincronizar();
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
	//---- Tabla: PROFESIONALES
	//--------------------------------------------------------------------------
	function get_profesionales()
	{
		return $this->tabla('profecionales')->get_filas();
	}
	
	function set_datos_profesionales($datos)
	{
		$this->tabla('profesionales')->set($datos);
	}
}
?>