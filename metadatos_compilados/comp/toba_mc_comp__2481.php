<?php

class toba_mc_comp__2481
{
	static function get_metadatos()
	{
		return array (
  '_info' => 
  array (
    'proyecto' => 'burgos_v2',
    'objeto' => 2481,
    'anterior' => NULL,
    'identificador' => NULL,
    'reflexivo' => NULL,
    'clase_proyecto' => 'toba',
    'clase' => 'toba_datos_relacion',
    'subclase' => NULL,
    'subclase_archivo' => NULL,
    'objeto_categoria_proyecto' => NULL,
    'objeto_categoria' => NULL,
    'nombre' => 'datos_expedientes',
    'titulo' => NULL,
    'colapsable' => NULL,
    'descripcion' => NULL,
    'fuente_proyecto' => 'burgos_v2',
    'fuente' => 'burgos_v2',
    'solicitud_registrar' => NULL,
    'solicitud_obj_obs_tipo' => NULL,
    'solicitud_obj_observacion' => NULL,
    'parametro_a' => NULL,
    'parametro_b' => NULL,
    'parametro_c' => NULL,
    'parametro_d' => NULL,
    'parametro_e' => NULL,
    'parametro_f' => NULL,
    'usuario' => NULL,
    'creacion' => '2015-06-26 10:08:28',
    'punto_montaje' => 14,
    'clase_editor_proyecto' => 'toba_editor',
    'clase_editor_item' => '1000251',
    'clase_archivo' => 'nucleo/componentes/persistencia/toba_datos_relacion.php',
    'clase_vinculos' => NULL,
    'clase_editor' => '1000251',
    'clase_icono' => 'objetos/datos_relacion.gif',
    'clase_descripcion_corta' => 'datos_relacion',
    'clase_instanciador_proyecto' => NULL,
    'clase_instanciador_item' => NULL,
    'objeto_existe_ayuda' => NULL,
    'ap_clase' => NULL,
    'ap_archivo' => NULL,
    'ap_punto_montaje' => 14,
    'cant_dependencias' => 3,
    'posicion_botonera' => NULL,
  ),
  '_info_estructura' => 
  array (
    'proyecto' => 'burgos_v2',
    'objeto' => 2481,
    'debug' => 0,
    'ap' => 2,
    'punto_montaje' => 14,
    'ap_clase' => NULL,
    'ap_archivo' => NULL,
    'sinc_susp_constraints' => 0,
    'sinc_orden_automatico' => 1,
    'sinc_lock_optimista' => 0,
  ),
  '_info_relaciones' => 
  array (
    0 => 
    array (
      'proyecto' => 'burgos_v2',
      'objeto' => 2481,
      'asoc_id' => 44,
      'padre_proyecto' => 'burgos_v2',
      'padre_objeto' => 2431,
      'padre_id' => 'expedientes',
      'hijo_proyecto' => 'burgos_v2',
      'hijo_objeto' => 2482,
      'hijo_id' => 'roles',
      'cascada' => NULL,
      'orden' => '1',
    ),
    1 => 
    array (
      'proyecto' => 'burgos_v2',
      'objeto' => 2481,
      'asoc_id' => 55,
      'padre_proyecto' => 'burgos_v2',
      'padre_objeto' => 2431,
      'padre_id' => 'expedientes',
      'hijo_proyecto' => 'burgos_v2',
      'hijo_objeto' => 2512,
      'hijo_id' => 'profesionales',
      'cascada' => NULL,
      'orden' => '2',
    ),
  ),
  '_info_dependencias' => 
  array (
    0 => 
    array (
      'identificador' => 'expedientes',
      'proyecto' => 'burgos_v2',
      'objeto' => 2431,
      'clase' => 'toba_datos_tabla',
      'clase_archivo' => 'nucleo/componentes/persistencia/toba_datos_tabla.php',
      'subclase' => 'dt_expedientes',
      'subclase_archivo' => 'datos/dt_expedientes.php',
      'fuente' => 'burgos_v2',
      'parametros_a' => '1',
      'parametros_b' => '1',
    ),
    1 => 
    array (
      'identificador' => 'roles',
      'proyecto' => 'burgos_v2',
      'objeto' => 2482,
      'clase' => 'toba_datos_tabla',
      'clase_archivo' => 'nucleo/componentes/persistencia/toba_datos_tabla.php',
      'subclase' => 'dt_roles_vinculos',
      'subclase_archivo' => 'datos/dt_roles_vinculos.php',
      'fuente' => 'burgos_v2',
      'parametros_a' => '1',
      'parametros_b' => '100',
    ),
    2 => 
    array (
      'identificador' => 'profesionales',
      'proyecto' => 'burgos_v2',
      'objeto' => 2512,
      'clase' => 'toba_datos_tabla',
      'clase_archivo' => 'nucleo/componentes/persistencia/toba_datos_tabla.php',
      'subclase' => 'dt_grupos_trabajo',
      'subclase_archivo' => 'datos/dt_grupos_trabajo.php',
      'fuente' => 'burgos_v2',
      'parametros_a' => '1',
      'parametros_b' => '100',
    ),
  ),
  '_info_columnas_asoc_rel' => 
  array (
    0 => 
    array (
      'asoc_id' => 44,
      'proyecto' => 'burgos_v2',
      'objeto' => 2481,
      'hijo_clave' => 991,
      'hijo_objeto' => 2482,
      'col_hija' => 'id_expediente',
      'padre_objeto' => 2431,
      'padre_clave' => 1042,
      'col_padre' => 'id',
    ),
    1 => 
    array (
      'asoc_id' => 55,
      'proyecto' => 'burgos_v2',
      'objeto' => 2481,
      'hijo_clave' => 1030,
      'hijo_objeto' => 2512,
      'col_hija' => 'id_expediente',
      'padre_objeto' => 2431,
      'padre_clave' => 1042,
      'col_padre' => 'id',
    ),
  ),
);
	}

}

?>