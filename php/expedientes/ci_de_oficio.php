<?php
class ci_de_oficio extends burgos_v2_ci
{
	protected $s__datos_form;
	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__procesar()
	{
		
		$this->cn()->sincronizar();
//        toba::notificacion()->agregar('Se guardó correctamente','info');
//        $this->cn()->resetear();
		$this->set_pantalla('pant_comprobante');
	}

	function evt__cancelar()
	{
	}

	//-----------------------------------------------------------------------------------
	//---- frm_expediente ---------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__frm_expediente(burgos_v2_ei_formulario $form)
	{
		$form->set_datos_defecto(array('lugar'=>'SANTA FE'));
		$form->set_datos_defecto(array('fecha_presentacion'=>date('Y-m-d')));
		$form->set_datos_defecto(array('fecha_ultimo_mov'=>date('Y-m-d')));
		$form->set_datos_defecto(array('fecha_entrada'=>date('Y-m-d')));
		$form->set_datos_defecto(array('procedencia'=>'De Oficio'));
		return $this->s__datos_form;
	}
	
	function get_persona_nombre($id)
	{
		//return consultas::get_persona_nombre($id);
	}


	//-----------------------------------------------------------------------------------
	//---- frm_expedientes ----------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function evt__frm_expediente__modificacion($datos)
	{
		$this->cn()->set_datos_expedientes($datos);
	}

	
	
	//-----------------------------------------------------------------------------------
	//---- frm_roles --------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__frm_roles__modificacion($datos)
	{
		$this->cn()->set_datos_roles($datos);
	}

	//-----------------------------------------------------------------------------------
	//---- frm_profesional --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__frm_profesional__modificacion($datos)
	{
		$this->cn()->set_datos_profesionales($datos);
	}
	
	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function extender_objeto_js()
	{
		echo "
		//---- Eventos ---------------------------------------------
		
		{$this->objeto_js}.evt__guardar = function()
		{
		}
		";
	}


	//-----------------------------------------------------------------------------------
	//---- frm_mostar_expediente --------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__frm_mostar_expediente(burgos_v2_ei_formulario $form)
	{
		$form->set_datos($this->cn()->get_expediente());
	}

	//-----------------------------------------------------------------------------------
	//---- frm_mostrar_profesional ------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__frm_mostrar_profesional(burgos_v2_ei_formulario $form)
	{
		$form->set_datos($this->cn()->get_primer_profesional()[0]);
	}
	 //-----------------------------------------------------------------------------------
	
}
?>