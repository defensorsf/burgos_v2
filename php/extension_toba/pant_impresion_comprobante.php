<?php
class pant_impresion_comprobante extends toba_ei_pantalla
{
	function vista_impresion_html( toba_impresion $salida )
	{
		echo '<img class="encabezado_impresion" src="img/logo_cav.png"> <br><br>';
		if (!isset($this->_info_pantalla['template_impresion']) || trim($this->_info_pantalla['template_impresion']) == '') {
			$salida->titulo( $this->controlador->get_titulo() );
			foreach($this->_dependencias as $dep) {
				$dep->vista_impresion_html( $salida );
			}
		} else {
			$this->generar_layout_template_impresion($salida);
		}
	}
}

?>