<?php
class ci_presentacion_espontanea extends burgos_v2_ci
{
	//-----------------------------------------------------------------------------------
	//---- Configuraciones --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__pant_inicial(toba_ei_pantalla $pantalla)
	{
	}

	//-----------------------------------------------------------------------------------
	//---- frm_expediente ---------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__frm_expediente(burgos_v2_ei_formulario $form)
	{
			$form->set_datos_defecto(array('lugar'=>'SANTA FE'));
			$form->set_datos_defecto(array('fecha_presentacion'=>date('Y-m-d')));
			$form->set_datos_defecto(array('procedencia'=>'Presentación Expontanea'));
			$form->set_datos_defecto(array('fecha_ultimo_mov'=>date('Y-m-d')));
			$form->set_datos_defecto(array('fecha_entrada'=>date('Y-m-d')));
	}

	function evt__frm_expediente__modificacion($datos)
	{
		$this->cn()->set_datos_expedientes($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- frm_persona ------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__frm_persona__modificacion($datos)
	{
		$this->cn()->set_datos_personas($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- frm_profesional --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__frm_profesional__modificacion($datos)
	{
		$this->cn()->set_datos_profesionales($datos);
	}
	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__procesar()
	{				
		//sincronizo contra la base de datos.
		//Este proceso esta tuneado para tambier poner el cursor en el ultimo registro.
		//despues voy a la pantalla de impresión
		$this->cn()->sincronizar();
		$this->set_pantalla('pant_comprobante');
	}

	//-----------------------------------------------------------------------------------
	//---- frm_mostrar_expediente -------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__frm_mostrar_expediente(burgos_v2_ei_formulario $form)
	{
		$form->set_datos($this->cn()->get_expediente());
	}

	//-----------------------------------------------------------------------------------
	//---- frm_mostrar_persona ----------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__frm_mostrar_persona(burgos_v2_ei_formulario $form)
	{
		$form->set_datos($this->cn()->get_primera_persona()[0]);
	}

	//-----------------------------------------------------------------------------------
	//---- frm_mostrar_profesional ------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__frm_mostrar_profesional(burgos_v2_ei_formulario $form)
	{				
		$form->set_datos($this->cn()->get_primer_profesional()[0]);
	}

}
?>