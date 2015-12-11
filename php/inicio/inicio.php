<?php
class inicio extends burgos_v2_ci
{
	//-----------------------------------------------------------------------------------
	//---- cuadro -----------------------------------------------------------------------
	//-----------------------------------------------------------------------------------

	function conf__cuadro(burgos_v2_ei_cuadro $cuadro)
	{    
		//tomo el mes de hoy y muestro los de este mes
		$mes = date('m');
		$datos = toba::db('burgos_v2')->consultar("SELECT * FROM eventos WHERE EXTRACT(MONTH FROM fecha) =  $mes ORDER BY fecha");
		$cuadro->set_datos($datos);
		//<img src="img/logo_grande.gif"></img>
		$cuadro->set_titulo('<caption><img src="img/logo_cav.png"></img></caption>');
	}

}
?>