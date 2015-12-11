<?php
class ei_cuadro extends burgos_v2_ei_cuadro
{
	// public $clasificadores = array();
	// public $personas = array();
	
	function vista_pdf(toba_vista_pdf $salida)
	{
		//Cambio lo márgenes accediendo directamente a la libreríaa PDF
		
		$pdf = $salida->get_pdf();
		$pdf->ezSetMargins(80, 50, 30, 30);	//top, bottom, left, right
		
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
			$pdf->closeObject();		
		}			
	}
}
?>

