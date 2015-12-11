<?php
class cn_gestionar_exp extends burgos_v2_cn
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
	
	function get_select_expedientes($filtro=array())
	{
		return $this->dep('datos')->tabla('expedientes')->get_select_expedientes($filtro);
	}    
	
	function get_expedientes()
	{
		return $this->tabla('expedientes')->get_filas();
	}
	
	function set_datos_expedientes($datos)
	{
		//ei_arbol($datos);
		$this->tabla('expedientes')->set($datos);
	}
	function get_expediente()
	{//devuelve los datos del expediente cargado en el controlador de negocio
		if ($this->dep('datos')->esta_cargada()) {
			return $this->dep('datos')->tabla('expedientes')->get();
		} 
	}
	
	function get_expediente_desnormalizado($id)	
	{
		//devuelve los datos del expediente cargado en el controlador de negocio
		//buscando las referencias para desnormalizar las cosas
		 if ($this->dep('datos')->esta_cargada()) {
			// return $this->dep('datos')->tabla('expedientes')->get();
			return $this->dep('datos')->tabla('expedientes')->get_expediente_desnormailzado($id);
		 } else{
			return array();
		 }
		
	}
	
	function get_personas_expedientes($id, $rol){
		
		//devuelve las personas  del expediente cargado en el controlador de negocio
		//teniendo en cuenta el rol de la persona . Los Roles son 1 - Victima 2 - Victimario .....
		 if ($this->dep('datos')->esta_cargada()) {
			// return $this->dep('datos')->tabla('expedientes')->get();
			return $this->dep('datos')->tabla('expedientes')->get_personas_expedientes($id, $rol);
		 } else{
			return array();
		 }
	}
	
	//--------------------------------------------------------------------------
	//---- Tabla: roles_personas
	//--------------------------------------------------------------------------
	function get_datos_roles()
	{
		return $this->tabla('roles_personas')->get_filas();
	}
	
	function set_datos_roles($datos)
	{
		$this->dep('datos')->tabla('roles_personas')->procesar_filas($datos);
	}
	
	function get_rol()
	{
		return $this->dep('datos')->tabla('roles_personas')->get();
	}
	//--------------------------------------------------------------------------
	//---- Tabla: grupo_trabajo
	//--------------------------------------------------------------------------
	function get_datos_grupo_trabajo()
	{
		return  $this->tabla('grupo_trabajo')->get_filas();
	}
	
	function set_datos_grupo_trabajo($datos)
	{
		$this->dep('datos')->tabla('grupo_trabajo')->procesar_filas($datos);
	}
	
	function get_grupo_trabajo()
	{
		return $this->dep('datos')->tabla('grupo_trabajo')->get();
	}  
	//--------------------------------------------------------------------------
	//---- Tabla: intervenciones
	//--------------------------------------------------------------------------
	function get_datos_intervenciones()
	{
		return $this->tabla('intervenciones')->get_filas();
	}
	
	function set_datos_intervenciones($datos)
	{
		$this->dep('datos')->tabla('intervenciones')->procesar_filas($datos);
	}
	
	function get_intervenciones()
	{
		return $this->dep('datos')->tabla('intervenciones')->get();
	}
	//--------------------------------------------------------------------------
	//---- Tabla: oficios
	//--------------------------------------------------------------------------
	function get_datos_oficios()
	{
		return $this->tabla('oficios')->get_filas();
	}
	
	function set_datos_oficios($datos)
	{
		$this->dep('datos')->tabla('oficios')->procesar_filas($datos);
	}

	//--------------------------------------------------------------------------
	//---- Tabla: derivaciones
	//--------------------------------------------------------------------------
	function get_datos_derivaciones()
	{
		return $this->tabla('derivaciones')->get_filas();
	}
	
	function set_datos_derivaciones($datos)
	{
		$this->dep('datos')->tabla('derivaciones')->procesar_filas($datos);
	}

	
}
?>