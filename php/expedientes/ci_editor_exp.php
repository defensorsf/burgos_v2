<?php
class ci_editor_exp extends burgos_v2_ci
{
	//-----------------------------------------------------------------------------------
	//---- frm_expediente ---------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__frm_expediente(burgos_v2_ei_formulario $form)
	{
		$datos = $this->cn()->get_expediente();
		//ei_arbol($datos);
		return $datos;
		
	}

	function evt__frm_expediente__modificacion($datos)
	{
			$this->cn()->set_datos_expedientes($datos);
	}
	

	//-----------------------------------------------------------------------------------
	//---- ml_profesionales -------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__ml_profesionales(burgos_v2_ei_formulario_ml $form_ml)
	{
		$datos = $this->cn()->get_datos_grupo_trabajo();
		$form_ml->set_datos($datos);
	}
	
	function evt__ml_profesionales__modificacion($datos)
	{
		$this->cn()->set_datos_grupo_trabajo($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- ml_personas ------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__ml_personas(burgos_v2_ei_formulario_ml $form_ml)
	{
		$datos = $this->cn()->get_datos_roles();
		$form_ml->set_datos($datos);
	}

	function evt__ml_personas__modificacion($datos)
	{
		$this->cn()->set_datos_roles($datos);
	}
	
	function get_persona_nombre($id)
	{
		return toba::consulta_php('consultas')->get_persona_nombre($id);
	}

	//-----------------------------------------------------------------------------------
	//---- ml_intevenciones -------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__ml_intevenciones(burgos_v2_ei_formulario_ml $form_ml)
	{
		$datos = $this->cn()->get_datos_intervenciones();
		$form_ml->set_datos($datos);
	}

	function evt__ml_intevenciones__modificacion($datos)
	{
		$this->cn()->set_datos_intervenciones($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- ml_oficios -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__ml_oficios(burgos_v2_ei_formulario_ml $form_ml)
	{
		$datos = $this->cn()->get_datos_oficios();
		$form_ml->set_datos($datos);
	}

	function evt__ml_oficios__modificacion($datos)
	{
		$this->cn()->set_datos_oficios($datos);
	}



	//-----------------------------------------------------------------------------------
	//---- ml_derivaciones --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__ml_derivaciones(ml_derivaciones $form_ml)
	{
		$datos = $this->cn()->get_datos_derivaciones();
		$form_ml->set_datos($datos);
	}

	function evt__ml_derivaciones__modificacion($datos)
	{
		$this->cn()->set_datos_derivaciones($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- frm_planificacion ------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__frm_planificacion(burgos_v2_ei_formulario $form)
	{
		$datos = $this->cn()->get_expediente();
		return $datos;	}

	function evt__frm_planificacion__modificacion($datos)
	{
		$this->cn()->set_datos_expedientes($datos);
	}
}
?>