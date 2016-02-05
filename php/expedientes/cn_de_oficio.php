<?php
class cn_de_oficio extends burgos_v2_cn
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
		//Apenas sincronizo recupero el ultimo registro......DANGER!!!!!!!!!!!!!
		$this->cargar($this->dep('datos')->tabla('expedientes')->get_ultimo_registro());
		// $this->dep('datos')->tabla('expedientes')->get_persistidor()->desactivar_transaccion();
		// $this->dep('datos')->tabla('roles')->get_persistidor()->desactivar_transaccion();
		// $this->dep('datos')->tabla('profesionales')->get_persistidor()->desactivar_transaccion();
		// toba::db()->abrir_transaccion();
		// try {
			// $this->dep('datos')->tabla('expedientes')->sincronizar();
			// $id_expediente = toba::db()->recuperar_secuencia('seq_expedientes');

			// $this->dep('datos')->tabla('roles')->sincronizar();
			// $id_rol = toba::db()->recuperar_secuencia('seq_roles_vinculos');

			// $this->dep('datos')->tabla('profesionales')->sincronizar();
			// $id_profesional = toba::db()->recuperar_secuencia('seq_personal');	
			
			// toba::db()->cerrar_transaccion();
			
			// toba::notificacion()->agregar($id_expediente . '/' . $id_rol . '/' . $id_profesional);
		// }catch(toba_error_db $e ) {
			// toba::db()->abortar_transaccion();
			// throw $e;
	// }

		
		
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
		}else {
			return array('fecha_presentacion'=>'fec nop', 'motivo_consulta' => 'bla bla bla', 'observaciones'=>'Te observo');
		} 
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
	function get_primer_profesional()
	{
		$datos = $this->tabla('profesionales')->get_filas();
		ei_arbol($datos);
		$sql = "SELECT * from personal WHERE id = {$datos[0]['id_personal']} LIMIT 1";
		return toba::db('burgos_v2')->consultar($sql);
	}

}
?>