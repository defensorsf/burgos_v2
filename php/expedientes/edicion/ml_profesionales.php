<?php
class ml_profesionales extends burgos_v2_ei_formulario_ml
{
 	/* Esta funcion agrega un encabezado  a la impresión Primero agrego lo que quiero y luego llamo al padre*/
	function vista_impresion_html(toba_impresion $salida )
	{
		//Busco los datos del expediente
		$datos = $this->controlador()->cn()->get_expediente();
		//imprimo
		echo "<span class='texto_etiqueta'>EXPEDIENTE Nro:</span> <span class='texto_dato'>{$datos['numero']}</span><br><br>";
		parent::vista_impresion_html($salida);		
	}

}

?>