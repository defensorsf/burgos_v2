<?php

class toba_mc_comp__2556
{
	static function get_metadatos()
	{
		return array (
  '_info' => 
  array (
    'proyecto' => 'burgos_v2',
    'objeto' => 2556,
    'anterior' => NULL,
    'identificador' => NULL,
    'reflexivo' => NULL,
    'clase_proyecto' => 'toba',
    'clase' => 'toba_ci',
    'subclase' => 'ci_pasar_a_archivo',
    'subclase_archivo' => 'expedientes/pasar_a_archivo/ci_pasar_a_archivo.php',
    'objeto_categoria_proyecto' => NULL,
    'objeto_categoria' => NULL,
    'nombre' => 'Pasar a Archivo',
    'titulo' => NULL,
    'colapsable' => 0,
    'descripcion' => NULL,
    'fuente_proyecto' => NULL,
    'fuente' => NULL,
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
    'creacion' => '2015-08-26 13:15:46',
    'punto_montaje' => 14,
    'clase_editor_proyecto' => 'toba_editor',
    'clase_editor_item' => '1000249',
    'clase_archivo' => 'nucleo/componentes/interface/toba_ci.php',
    'clase_vinculos' => NULL,
    'clase_editor' => '1000249',
    'clase_icono' => 'objetos/multi_etapa.gif',
    'clase_descripcion_corta' => 'ci',
    'clase_instanciador_proyecto' => 'toba_editor',
    'clase_instanciador_item' => '1642',
    'objeto_existe_ayuda' => NULL,
    'ap_clase' => NULL,
    'ap_archivo' => NULL,
    'ap_punto_montaje' => NULL,
    'cant_dependencias' => 3,
    'posicion_botonera' => 'abajo',
  ),
  '_info_eventos' => 
  array (
  ),
  '_info_puntos_control' => 
  array (
  ),
  '_info_ci' => 
  array (
    'ev_procesar_etiq' => NULL,
    'ev_cancelar_etiq' => NULL,
    'objetos' => NULL,
    'ancho' => '900px',
    'alto' => NULL,
    'posicion_botonera' => NULL,
    'tipo_navegacion' => NULL,
    'con_toc' => 0,
    'botonera_barra_item' => 0,
  ),
  '_info_ci_me_pantalla' => 
  array (
    0 => 
    array (
      'pantalla' => 1269,
      'identificador' => 'pant_inicial',
      'etiqueta' => 'Pantalla Inicial',
      'descripcion' => NULL,
      'tip' => NULL,
      'imagen_recurso_origen' => 'apex',
      'imagen' => NULL,
      'objetos' => NULL,
      'eventos' => NULL,
      'orden' => 1,
      'punto_montaje' => 14,
      'subclase' => NULL,
      'subclase_archivo' => NULL,
      'template' => NULL,
      'template_impresion' => NULL,
    ),
  ),
  '_info_obj_pantalla' => 
  array (
    0 => 
    array (
      'pantalla' => 1269,
      'proyecto' => 'burgos_v2',
      'objeto_ci' => 2556,
      'dep_id' => 1404,
      'orden' => 0,
      'identificador_pantalla' => 'pant_inicial',
      'identificador_dep' => 'filtro',
    ),
    1 => 
    array (
      'pantalla' => 1269,
      'proyecto' => 'burgos_v2',
      'objeto_ci' => 2556,
      'dep_id' => 1403,
      'orden' => 1,
      'identificador_pantalla' => 'pant_inicial',
      'identificador_dep' => 'cuadro',
    ),
  ),
  '_info_evt_pantalla' => 
  array (
  ),
  '_info_dependencias' => 
  array (
    0 => 
    array (
      'identificador' => 'cuadro',
      'proyecto' => 'burgos_v2',
      'objeto' => 2557,
      'clase' => 'toba_ei_cuadro',
      'clase_archivo' => 'nucleo/componentes/interface/toba_ei_cuadro.php',
      'subclase' => 'cuadro',
      'subclase_archivo' => 'expedientes/pasar_a_archivo/cuadro.php',
      'fuente' => NULL,
      'parametros_a' => NULL,
      'parametros_b' => NULL,
    ),
    1 => 
    array (
      'identificador' => 'datos',
      'proyecto' => 'burgos_v2',
      'objeto' => 2559,
      'clase' => 'toba_datos_relacion',
      'clase_archivo' => 'nucleo/componentes/persistencia/toba_datos_relacion.php',
      'subclase' => NULL,
      'subclase_archivo' => NULL,
      'fuente' => 'burgos_v2',
      'parametros_a' => NULL,
      'parametros_b' => NULL,
    ),
    2 => 
    array (
      'identificador' => 'filtro',
      'proyecto' => 'burgos_v2',
      'objeto' => 2558,
      'clase' => 'toba_ei_filtro',
      'clase_archivo' => 'nucleo/componentes/interface/toba_ei_filtro.php',
      'subclase' => NULL,
      'subclase_archivo' => NULL,
      'fuente' => 'burgos_v2',
      'parametros_a' => NULL,
      'parametros_b' => NULL,
    ),
  ),
);
	}

}

?>