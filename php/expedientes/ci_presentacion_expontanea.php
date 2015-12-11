<?php
class ci_presentacion_expontanea extends burgos_v2_ci
{
	protected $s__datos_form;
	

	//-----------------------------------------------------------------------------------
	//---- Eventos ----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function evt__procesar()
	{
		$salida = new toba_impr_html;
		toba::notificacion()->agregar('Se ha guardado correctamente','info');
		$this->cn()->sincronizar();
		//$this->vista_impresion_html($salida);
		//$this->cn()->resetear();
		
	}

	//-----------------------------------------------------------------------------------
	//---- frm_expediente ---------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__frm_expediente(burgos_v2_ei_formulario $form)
	{
		$form->set_datos_defecto(array('lugar'=>'SANTA FE'));
		$form->set_datos_defecto(array('fecha_presentacion'=>date('Y-m-d')));
		$form->set_datos_defecto(array('procedencia'=>'Presentaci�n Expontanea'));
		$form->set_datos_defecto(array('fecha_ultimo_mov'=>date('Y-m-d')));
		$form->set_datos_defecto(array('fecha_entrada'=>date('Y-m-d')));
		return $this->s__datos_form;
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
	//---- profesional ------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	function evt__profesional__modificacion($datos)
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
		//---- Eventos ---------------------------------------------
		
		{$this->objeto_js}.evt__procesar = function()
		{
		}
		//---- Eventos ---------------------------------------------
		
		{$this->objeto_js}.evt__imprimir = function()
		{
		}
		";
	}

	function evt__imprimir()
	{
		toba::notificacion()->agregar('Estoy imprimiendo');
		$this->evt__procesar();
	}



}
?>