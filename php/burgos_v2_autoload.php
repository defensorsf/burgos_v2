<?php
/**
 * Esta clase fue y será generada automáticamente. NO EDITAR A MANO.
 * @ignore
 */
class burgos_v2_autoload 
{
	static function existe_clase($nombre)
	{
		return isset(self::$clases[$nombre]);
	}

	static function cargar($nombre)
	{
		if (self::existe_clase($nombre)) { 
			 require_once(dirname(__FILE__) .'/'. self::$clases[$nombre]); 
		}
	}

	static protected $clases = array(
		'burgos_v2_comando' => 'extension_toba/burgos_v2_comando.php',
		'burgos_v2_modelo' => 'extension_toba/burgos_v2_modelo.php',
		'burgos_v2_ci' => 'extension_toba/componentes/burgos_v2_ci.php',
		'burgos_v2_cn' => 'extension_toba/componentes/burgos_v2_cn.php',
		'burgos_v2_datos_relacion' => 'extension_toba/componentes/burgos_v2_datos_relacion.php',
		'burgos_v2_datos_tabla' => 'extension_toba/componentes/burgos_v2_datos_tabla.php',
		'burgos_v2_ei_arbol' => 'extension_toba/componentes/burgos_v2_ei_arbol.php',
		'burgos_v2_ei_archivos' => 'extension_toba/componentes/burgos_v2_ei_archivos.php',
		'burgos_v2_ei_calendario' => 'extension_toba/componentes/burgos_v2_ei_calendario.php',
		'burgos_v2_ei_codigo' => 'extension_toba/componentes/burgos_v2_ei_codigo.php',
		'burgos_v2_ei_cuadro' => 'extension_toba/componentes/burgos_v2_ei_cuadro.php',
		'burgos_v2_ei_esquema' => 'extension_toba/componentes/burgos_v2_ei_esquema.php',
		'burgos_v2_ei_filtro' => 'extension_toba/componentes/burgos_v2_ei_filtro.php',
		'burgos_v2_ei_firma' => 'extension_toba/componentes/burgos_v2_ei_firma.php',
		'burgos_v2_ei_formulario' => 'extension_toba/componentes/burgos_v2_ei_formulario.php',
		'burgos_v2_ei_formulario_ml' => 'extension_toba/componentes/burgos_v2_ei_formulario_ml.php',
		'burgos_v2_ei_grafico' => 'extension_toba/componentes/burgos_v2_ei_grafico.php',
		'burgos_v2_ei_mapa' => 'extension_toba/componentes/burgos_v2_ei_mapa.php',
		'burgos_v2_servicio_web' => 'extension_toba/componentes/burgos_v2_servicio_web.php',
	);
}
?>