<?php
class ci_inicio extends burgos_v2_ci
{
	//-----------------------------------------------------------------------------------
	//---- Configuraciones --------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__pant_inicial(toba_ei_pantalla $pantalla)
	{
	}

	//-----------------------------------------------------------------------------------
	//---- cuadro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cuadro(burgos_v2_ei_cuadro $cuadro)
	{
		//tomo el mes de hoy y muestro los de este mes
		$mes = date('m');
		$datos = toba::db('burgos_v2')->consultar("SELECT * FROM eventos WHERE EXTRACT(MONTH FROM fecha) =  $mes ");
		ei_arbol($datos);
		$cuadro->set_datos($datos);
	}
	
	function conf__cuadro_dias(burgos_v2_ei_cuadro $cuadro)
	{
		//creo un objeto dia, por defecto se instancia al día de hoy
		//Despues le sumo dos días. si dentro de dos días es sabado o domingo sigo sumando
		$hoy = date_create();
		$manana = date_create()->add(new date_interval('P2D'));
		switch ($mañana->format('D')){
			case 'Sun':
				$mañana->add(new date_in('P1D'));
				break;
			case 'Sut':
				$mañana->add(new date_in('P2D'));
				break;
		}
		toba::notificacion()->agregar($hoy->format('Y-m-d'));
		toba::notificacion()->agregar($manana->format('Y-m-d'));
		
		$datos = toba::db('burgos_v2')->consultar("SELECT * FROM eventos WHERE fecha BETWEEN {$hoy->format('Y-m-d')} AND {$manana->format('Y-m-d')}");
		ei_arbol($datos);
		$cuadro->set_datos($datos);
	}


}
?>