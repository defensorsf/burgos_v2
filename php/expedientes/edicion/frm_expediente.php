<?php
class frm_expediente extends burgos_v2_ei_formulario
{

/* Esta funcion agrega un encabezado  a la impresion Primero agrego lo que quiero y luego llamo al padre*/
	function vista_impresion_html(toba_impresion $salida )
	{
		//Busco los datos del expediente
		$datos_id = $this->controlador()->cn()->get_expediente();
		$datos = $this->controlador()->cn()->get_expediente_desnormalizado($datos_id['id']);
		//ei_arbol($datos);
		// genero el html a imprimir
		$html = "
				<div id='recuadro_impresion'>
				<table WIDTH ='100%'>
					<tr>
						<td><span class='texto_etiqueta'>EXPEDIENTE Nro: </span> <span class='texto_dato'>{$datos[0]['numero']}</span></td>
						<td><span class='texto_etiqueta'>LUGAR: </span> <span class='texto_dato'>{$datos[0]['lugar']}</span></td>
					</tr>
					<tr>
						<td><span class='texto_etiqueta'>PROCEDENCIA: </span> <span class='texto_dato'>{$datos[0]['procedencia']}</span></td>
						<td><span class='texto_etiqueta'>FECHA DE INICIO: </span> <span class='texto_dato'>{$datos[0]['fecha_presentacion']}</span></td>
					</tr>
					<tr>
						<td colspan='2'><HR></td>
					</tr>
					<tr>
						<td colspan='2'><span class='texto_etiqueta'>MOTIVO DE LA CONSULTA: </span><span class='texto_dato'>{$datos[0]['motivo_consulta']}</span></td>
					</tr>
					<tr>
						<td colspan='2'><BR>CLASIFICADORES<BR><HR></td>
					</tr>
					<tr>
						<td><span class='texto_etiqueta'>AMBITO: </span><span class='texto_dato'>{$datos[0]['ambito']}</span></td>
						<td><span class='texto_etiqueta'>HUBO VIOLENCIA: </span><span class='texto_dato'>{$datos[0]['hubo_violencia']}</span></td>
					</tr>
					";
						
						//primero tengo que abrir el tr. SOLO lo hago si alguna de las dos columnas tiene datos
						//si la primera tiene, lo habro y cargo el dato, sino, me fijo si la segunda tiene datos, en cuyo
						//caso abro la linea pero la cargo con una columna vacï¿½a
						if (!empty($datos[0]['nomeclador_1'])){ 
							$html .= "<tr><td><span class='texto_dato'>{$datos[0]['nomeclador_1']}</span></td>";
						}else{
							if (!empty($datos[0]['violencia_1'])){
								$html .= '<tr><td></td>';
							};
						};
						//hora de ver la segunda columna y cerrar
						if (!empty($datos[0]['violencia_1'])){ 
							$html .= "<td><span class='texto_dato'>{$datos[0]['violencia_1']}</span></td></tr>";
						}else{
							if (!empty($datos[0]['nomeclador_1'])){
								$html .= '<td></td></tr>';
							};
						};
						
						if (!empty($datos[0]['nomeclador_2'])){ 
							$html .= "<tr><td><span class='texto_dato'>{$datos[0]['nomeclador_2']}</span></td>";
						}else{
							if (!empty($datos[0]['violencia_2'])){
								$html .= '<tr><td></td>';
							}
						};
						if (!empty($datos[0]['violencia_2'])){ 
							$html .= "<td><span class='texto_dato'>{$datos[0]['violencia_2']}</span></td></tr>";
						}else{
							if (!empty($datos[0]['nomeclador_2'])){
								$html .= '<td></td></tr>';
							}
						};
						if (!empty($datos[0]['nomeclador_3'])){ 
							$html .= "<tr><td><span class='texto_dato'>{$datos[0]['nomeclador_3']}</span></td>";
						}else{
							if (!empty($datos[0]['violencia_3'])){
								$html .= '<tr><td></td>';
							}
						}
						if (!empty($datos[0]['violencia_3'])){ 
							$html .= "<td><span class='texto_dato'>{$datos[0]['violencia_3']}</span></td></tr>";
						}else{
							if (!empty($datos[0]['nomeclador_3'])){
								$html .= '<td></td></tr>';
							}
						}
					
					if ($datos[0]['denuncia_policial'] == 'SI'){
						$html .= "
								<tr>
									<td colspan='2'><BR>DENUNCIA POLICIAL<BR><HR></td>
								</tr>
								<tr>
									<td colspan='2'><span class='texto_etiqueta'>DENUNCIA POLICIAL: </span><span class='texto_dato'>{$datos[0]['denuncia_policial']}</span></td>
								</tr>
								<tr>
									<td><span class='texto_etiqueta'>DONDE SE RADICÓ LA DENUNCIA: </span><span class='texto_dato'>{$datos[0]['lugar_denuncia']}</span></td>
									<td><span class='texto_etiqueta'>FECHA DE LA DENUNCIA: </span><span class='texto_dato'>{$datos[0]['fecha_denuncia']}</span></td>
								</tr>
								<tr>
									<td><span class='texto_etiqueta'>PERSONA DENUNCIA: </span><span class='texto_dato'>{$datos[0]['persona_denuncia']}</span></td>
									<td><span class='texto_etiqueta'>LUGAR DEL HECHO DENUNCIADO: </span><span class='texto_dato'>{$datos[0]['lugar_hecho_denuncia']}</span></td>
								</tr>
								<tr>
									<td><span class='texto_etiqueta'>ULTIMO EPISODIO: </span><span class='texto_dato'>{$datos[0]['ultimo_episodio_denuncia']}</span></td>
								</tr>
						";
					}
					$html .= "
							<tr>
								<td colspan='2'><BR><HR></td>
							</tr>
							<tr>
								<td><span class='texto_etiqueta'>ENCUADRE LEGAL: </span><span class='texto_dato'>{$datos[0]['encuadre_legal']}</span></td>
								<td><span class='texto_etiqueta'>APLICACION LEY: </span><span class='texto_dato'>{$datos[0]['aplicacion_ley']}</span></td>
							</tr>
							<tr>
								<td><span class='texto_etiqueta'>ORIGEN DE LA PRESENTACIÓN: </span><span class='texto_dato'>{$datos[0]['origen_presentacion']}</span></td>
							</tr>
							";
					if ($datos[0]['procedencia'] == 'Derivaciï¿½n'){
						$html .= "
								<tr>
									<td colspan='2'><BR>DERIVACIÓN<BR><HR></td>
								</tr>
								<tr>
									<td><span class='texto_etiqueta'>ORGANISMO: </span><span class='texto_dato'>{$datos[0]['organismo']}</span></td>
									<td><span class='texto_etiqueta'>DEPENDENCIA: </span><span class='texto_dato'>{$datos[0]['dependencia_org']}</span></td>
								</tr>
						";
					};
					$html .= "
							<tr>
								<td colspan='2'><BR><HR></td>
							</tr>
							<tr>
								<td COLSPAN='2'><span class='texto_etiqueta'>PLANIFICACION: </span><span class='texto_dato'>{$datos[0]['planificacion']}</span></td>
							</tr>
							<tr>
								<td colspan='2'><BR><HR></td>
							</tr>
							<tr>
								<td COLSPAN='2'><span class='texto_etiqueta'>OBSERVACIONES: </span><span class='texto_dato'>{$datos[0]['observaciones']}<br><br></span></td>
							</tr>
							</table>
							</div>
							";
					

							echo $html;	
			//borrado
	}
	

	
	//-----------------------------------------------------------------------------------
	//---- JAVASCRIPT -------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function extender_objeto_js()
	{
		echo "
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__denuncia_policial__procesar = function(es_inicial)
		{
			//me fijo si hubo denuncia policial. SOLO si la hubo muestro los ef de denuncia 
				if (this.ef('denuncia_policial').chequeado()) {
					this.ef('lugar_denuncia').mostrar(true);
					this.ef('fecha_denuncia').mostrar(true);
					this.ef('persona_denuncia').mostrar(true);
					this.ef('lugar_hecho_denuncia').mostrar(true);
					this.ef('ultimo_episodio_denuncia').mostrar(true);                    
				} else {
					this.ef('lugar_denuncia').mostrar(false);
					this.ef('fecha_denuncia').mostrar(false);
					this.ef('persona_denuncia').mostrar(false);
					this.ef('lugar_hecho_denuncia').mostrar(false);                    
					this.ef('ultimo_episodio_denuncia').mostrar(false);                    
		
					// this.ef('lugar_denuncia').resetear_estado();
					// this.ef('fecha_denuncia').set_estado('');
					// this.ef('persona_denuncia').set_estado('');
					// this.ef('lugar_hecho_denuncia').set_estado('');    
					
				}
		}
		//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__hubo_violencia__procesar = function(es_inicial)
		{
				if (this.ef('hubo_violencia').chequeado()) {
					this.ef('violencia_1').mostrar(true);
					this.ef('violencia_2').mostrar(true);
					this.ef('violencia_3').mostrar(true);
				} else {
					this.ef('violencia_1').mostrar(false);
					this.ef('violencia_2').mostrar(false);
					this.ef('violencia_3').mostrar(false);
					this.ef('violencia_1').resetear_estado();
					this.ef('violencia_2').resetear_estado();
					this.ef('violencia_3').resetear_estado();
					
				}
			
		}//---- Procesamiento de EFs --------------------------------
		
		{$this->objeto_js}.evt__id_ambito__procesar = function(es_inicial)
		{
		}
		
		{$this->objeto_js}.ini = function()
		{
			if( this.ef('procedencia').get_estado() == 'Presentación Espontanea'){
					this.ef('organismo').mostrar(false);
					this.ef('dependencia_org').mostrar(false);
			}
			
		}
		
		";
	}


}
?>