<?php
class ml_derivaciones extends burgos_v2_ei_formulario_ml
{
	/* Esta funcion agrega un encabezado  a la impresión. Primero agrego lo que quiero y luego llamo al padre*/
	function vista_impresion_html(toba_impresion $salida )
	{
		//Busco los datos del expediente
		$datos = $this->controlador()->cn()->get_expediente();
		//imprimo
		echo "<span class='texto_etiqueta'>EXPEDIENTE Nro:</span> <span class='texto_dato'>{$datos['numero']}</span><br><br>";
		parent::vista_impresion_html($salida);        
	}
	/**
	* Se redefine el encabezado para no incluir los nombres de las columnas
	*/
	function generar_formulario_encabezado()
	{
		
	}
	
	protected function generar_layout_fila($clave_fila)
	{
		$this->set_ancho_etiqueta('90px');
		$columnas = 5;
		$i = 0;
		foreach ($this->get_nombres_ef() as $ef) {
			$ultimo = ($i == $this->get_cantidad_efs());            
			if ($i % $columnas == 0) {
				echo "<td colspan='$columnas' class='{$this->estilo_celda_actual}'>";
			}            
			$this->generar_html_ef($ef);
			$i++;            
			if ($i % $columnas == 0 || $ultimo) {
				echo '</td>';
			}            
		}

	}

	
}
?>