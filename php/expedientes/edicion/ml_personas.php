<?php
class ml_personas extends burgos_v2_ei_formulario_ml
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
		$columnas = 6;
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

	
	
	
	

	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function extender_objeto_js()
	{
		echo "
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__id_rol__procesar = function(es_inicial, fila)
		{
			  //Me fijo si el rol es 1 , o sea víctima, enm ese caso, el vinculo es victima, pero lo hago invisible.
			  if( this.ef('id_rol').ir_a_fila(fila).get_estado() == 1 ){ 
					this.ef('id_vinculo').ir_a_fila(fila).set_estado(8);
					this.ef('id_vinculo').ir_a_fila(fila).mostrar(false);
			  }else{ //El rol no es victima
					// Si el estado es victima (o sea que el rol recien era victima y lo cambié)
					//lo reseteo. No es logico que alguien que no es victima sea rol victima.
					//Y lo pongo visible.
					if (this.ef('id_vinculo').ir_a_fila(fila).get_estado()== 8 ){
						this.ef('id_vinculo').ir_a_fila(fila).mostrar(true);
						this.ef('id_vinculo').ir_a_fila(fila).resetear_estado();
					 }
					
			  }
		}
		
		//---- Validacion de EFs -----------------------------------
		         
		       
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__id_vinculo__procesar = function(es_inicial, fila)
		{
			if(( this.ef('id_vinculo').ir_a_fila(fila).get_estado() == 8 ) && 
			     this.ef('id_rol').ir_a_fila(fila).get_estado() != 1){
					this.ef('id_vinculo').ir_a_fila(fila).resetear_estado();
			}
		}
		";
	}


}
?>