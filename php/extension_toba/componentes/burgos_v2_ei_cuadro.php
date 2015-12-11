<?php
class burgos_v2_ei_cuadro extends toba_ei_cuadro
{
	protected   $titulo;
	protected   $nombre;
	protected   $id_busqueda;
	
	
	function inicializar($parametros=array())
	{
		parent::inicializar($parametros);
		$this->set_etiqueta_cantidad_filas('cantidad de filas');
		$nombre = $this->controlador()->get_nombre();
		$titulo = $this->controlador()->get_titulo();
	}	
	
	function vista_pdf(toba_vista_pdf $salida)
	{
		
		
		//Cambio lo márgenes accediendo directamente a la librería PDF
		
		$pdf = $salida->get_pdf();
		$pdf->ezSetMargins(80, 50, 30, 30);	//top, bottom, left, right

		//Pie de página
		$formato = 'Página {PAGENUM} de {TOTALPAGENUM}';
		$pdf->ezStartPageNumbers(300, 20, 8, 'left', $formato, 1);	//x, y, size, pos, texto, pagina inicio
		
		//Invoco la salida pdf original del cuadro
		parent::vista_pdf($salida);		
		
		//Encabezado
		foreach ($pdf->ezPages as $pageNum=>$id){
			$pdf->reopenObject($id);
			$imagen = toba::proyecto()->get_path().'/www/img/logo-defe.jpg';
			$pdf->addJpegFromFile($imagen, 50, 780, 58, 48);	//ruta+archivo imagen, x, y, ancho, alto
			$pdf->addText(150,810,16,'<b>DEFENSORÍA DEL  PUEBLO DE SANTA FE</b>',0,'center'  ); //$this->addText($xPos, $yPos, $fsize, $text,,align ); 
			$pdf->closeObject();		
		}		
	}

	// funcion auxiliar para cambiar de cm a puntos( pixels) que es lo que maneja la clase base
	function cm2pix ($medida, $resolucion=72)
	{
	   //// 2.54 cm / pulgada
	   /// $resolucion=72 puntos por pulgada
	   return ($medida/(2.54))*$resolucion;
	}	
}
?>