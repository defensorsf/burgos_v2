<?php
class cuadro_hoja_ruta extends burgos_v2_ei_cuadro
{
	function vista_pdf(toba_vista_pdf $salida)
	{
		//busco los datos del encabezado
		$personas = toba::memoria()->get_dato('hoja_ruta');
		//Cambio lo márgenes accediendo directamente a la librería PDF		
		$pdf = $salida->get_pdf();
		$pdf->ezSetMargins(80 +  toba::memoria()->get_dato('cantidad_roles') * 20 , 50, 30, 30);	//top, bottom, left, right
		
		//Pie de página
		$formato = 'Página {PAGENUM} de {TOTALPAGENUM}';
		$pdf->ezStartPageNumbers(300, 20, 8, 'left', $formato, 1);	//x, y, size, pos, texto, pagina inicio
		
		//Invoco la salida pdf original del cuadro
		toba_ei_cuadro::vista_pdf($salida);		
		
		//Encabezado
		foreach ($pdf->ezPages as $pageNum=>$id){
			$pdf->reopenObject($id);
			$imagen = toba::proyecto()->get_path().'/www/img/logo-defe.jpg';
			$pdf->addJpegFromFile($imagen, 50, 780, 58, 48);	//ruta+archivo imagen, x, y, ancho, alto
			$pdf->addText(150,810,12,'<b>Centro de Asistencia a la Víctima y al Testigo del Delito</b>',0,'center'  ); //$this->addText($xPos, $yPos, $fsize, $text,,align ); 
			$pdf->addText(165,790,12,'<b>Defensoría del Pueblo de la Provincia de Santa Fe</b>',0,'center'  ); //$this->addText($xPos, $yPos, $fsize, $text,,align ); 
			$pdf->addText(250,770,14,'<b>HOJA DE RUTA</b>',0,'center'  ); //$this->addText($xPos, $yPos, $fsize, $text,,align ); 

			$rol='';
			$ypos = 760;
			foreach ($personas  AS $persona){
				//si o si esto sucede sólo en la primera interaccion
				//pongo la primera linea el rol y por unica vez el nomeclador
				if($rol == '' ){
					$rol = $persona['rol'];
					$pdf->addText(70,$ypos,9,'<b>Personas Involucradas</b>',0,'left');
					$pdf->addText(400,$ypos,9,'<b>Nomeclador</b>',0,'left');$ypos -= 10; //es como bajar una linea
					$pdf->addText(70,$ypos,9,$rol,0,'left');
					$pdf->addText(400,$ypos,9,$persona['nomeclador'],0,'left');$ypos -= 10; //es como bajar una linea
					$pdf->addText(100,$ypos,9,$persona['nombre_persona'],0,'left');
				}else{
					//es la segunda iteracción para adelante
					//Viene ordenado por rol. Por cada rol distinto lo pongo en el titulo y agrego las personas en ese rol.
					if ($rol <> $persona['rol']){
						$xpos = 100;
						$ypos -= 10;
						$rol = $persona['rol'];
						$pdf->addText(70,$ypos,9,$rol,0,'left');$ypos -= 10;
						$pdf->addText(100,$ypos,9,$persona['nombre_persona'],0,'left');
						$xpos = $xpos + strlen($persona['nombre_persona']) * 5;
					} else {
						//solamente agrego personas 
						$pdf->addText($xpos,$ypos,9,', ' . $persona['nombre_persona'],0,'left');
					}
				}
			}		
			$pdf->closeObject();		
		}			
	}
}

?>