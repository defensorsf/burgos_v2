<?php
class cn_presentacion_espontanea extends burgos_v2_cn
{
//	private $caminolog = '';

	function get_log_orden(){
		return $this->caminolog;
	}
	
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
		//Apenas sincronizo recupero el ultimo registro......DANGER!!!!!!!!!!!!!
		$this->cargar($this->dep('datos')->tabla('expedientes')->get_ultimo_registro());
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
	
	function get_expediente()
	{//devuelve los datos del expediente cargado en el controlador de negocio
		if ($this->dep('datos')->esta_cargada()) {
			return $this->dep('datos')->tabla('expedientes')->get();
		} 
	}

	//--------------------------------------------------------------------------
	//---- Tabla: personas
	//--------------------------------------------------------------------------
	function get_personas()
	{
		return $this->tabla('personas')->get_filas();
	}
	
	function get_primera_persona()
	{
		$datos = $this->tabla('personas')->get_filas();
		$sql = "SELECT * from personas WHERE id = {$datos[0]['id_persona']} LIMIT 1";
		return toba::db('burgos_v2')->consultar($sql);
	}
	  
	function set_datos_personas($datos)
	{
		$this->tabla('personas')->set($datos);
	}    
	
	//--------------------------------------------------------------------------
	//---- Tabla: profesionales
	//--------------------------------------------------------------------------
	function get_profesionales()
	{
		return $this->tabla('profesionales')->get_filas();
	}
	function get_primer_profesional()
	{
		$datos = $this->tabla('profesionales')->get_filas();
		$sql = "SELECT * from personal WHERE id = {$datos[0]['id_personal']} LIMIT 1";
		return toba::db('burgos_v2')->consultar($sql);
	}
	
	function set_datos_profesionales($datos)
	{
		$this->tabla('profesionales')->set($datos);
	}
}
?>