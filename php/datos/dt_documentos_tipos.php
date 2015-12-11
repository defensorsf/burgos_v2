<?php
class dt_documentos_tipos extends toba_datos_tabla
{
	function get_descripciones()
	{
		$sql = "SELECT id, nombre FROM documentos_tipos ORDER BY nombre";
		return toba::db('burgos_v2')->consultar($sql);
	}




}
?>