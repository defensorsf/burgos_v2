<?php

class toba_mc_comp__2564
{
	static function get_metadatos()
	{
		return array (
  '_info' => 
  array (
    'proyecto' => 'burgos_v2',
    'objeto' => 2564,
    'anterior' => NULL,
    'identificador' => NULL,
    'reflexivo' => NULL,
    'clase_proyecto' => 'toba',
    'clase' => 'toba_datos_tabla',
    'subclase' => NULL,
    'subclase_archivo' => NULL,
    'objeto_categoria_proyecto' => NULL,
    'objeto_categoria' => NULL,
    'nombre' => 'instituciones',
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
    'creacion' => '2015-09-07 11:14:12',
    'punto_montaje' => 14,
    'clase_editor_proyecto' => 'toba_editor',
    'clase_editor_item' => '1000250',
    'clase_archivo' => 'nucleo/componentes/persistencia/toba_datos_tabla.php',
    'clase_vinculos' => NULL,
    'clase_editor' => '1000250',
    'clase_icono' => 'objetos/datos_tabla.gif',
    'clase_descripcion_corta' => 'datos_tabla',
    'clase_instanciador_proyecto' => NULL,
    'clase_instanciador_item' => NULL,
    'objeto_existe_ayuda' => NULL,
    'ap_clase' => NULL,
    'ap_archivo' => NULL,
    'ap_punto_montaje' => 14,
    'cant_dependencias' => 0,
    'posicion_botonera' => NULL,
  ),
  '_info_estructura' => 
  array (
    'tabla' => 'intituciones_expediente',
    'alias' => NULL,
    'min_registros' => NULL,
    'max_registros' => NULL,
    'ap' => 1,
    'punto_montaje' => 14,
    'ap_sub_clase' => NULL,
    'ap_sub_clase_archivo' => NULL,
    'ap_modificar_claves' => 0,
    'ap_clase' => 'ap_tabla_db_s',
    'ap_clase_archivo' => 'nucleo/componentes/persistencia/toba_ap_tabla_db_s.php',
    'tabla_ext' => NULL,
    'esquema' => NULL,
    'esquema_ext' => 'public',
  ),
  '_info_columnas' => 
  array (
    0 => 
    array (
      'objeto_proyecto' => 'burgos_v2',
      'objeto' => 2564,
      'col_id' => 1101,
      'columna' => 'id',
      'tipo' => 'E',
      'pk' => 1,
      'secuencia' => 'intituciones_expediente_id_seq',
      'largo' => NULL,
      'no_nulo' => NULL,
      'no_nulo_db' => 1,
      'externa' => 0,
      'tabla' => 'intituciones_expediente',
    ),
    1 => 
    array (
      'objeto_proyecto' => 'burgos_v2',
      'objeto' => 2564,
      'col_id' => 1102,
      'columna' => 'id_institucion',
      'tipo' => 'E',
      'pk' => 0,
      'secuencia' => '',
      'largo' => NULL,
      'no_nulo' => NULL,
      'no_nulo_db' => 1,
      'externa' => 0,
      'tabla' => 'intituciones_expediente',
    ),
    2 => 
    array (
      'objeto_proyecto' => 'burgos_v2',
      'objeto' => 2564,
      'col_id' => 1103,
      'columna' => 'id_expediente',
      'tipo' => 'E',
      'pk' => 0,
      'secuencia' => '',
      'largo' => NULL,
      'no_nulo' => NULL,
      'no_nulo_db' => 1,
      'externa' => 0,
      'tabla' => 'intituciones_expediente',
    ),
    3 => 
    array (
      'objeto_proyecto' => 'burgos_v2',
      'objeto' => 2564,
      'col_id' => 1104,
      'columna' => 'accion',
      'tipo' => 'E',
      'pk' => 0,
      'secuencia' => '',
      'largo' => NULL,
      'no_nulo' => NULL,
      'no_nulo_db' => 1,
      'externa' => 0,
      'tabla' => 'intituciones_expediente',
    ),
    4 => 
    array (
      'objeto_proyecto' => 'burgos_v2',
      'objeto' => 2564,
      'col_id' => 1105,
      'columna' => 'observaciones',
      'tipo' => 'X',
      'pk' => 0,
      'secuencia' => '',
      'largo' => NULL,
      'no_nulo' => NULL,
      'no_nulo_db' => 0,
      'externa' => 0,
      'tabla' => 'intituciones_expediente',
    ),
    5 => 
    array (
      'objeto_proyecto' => 'burgos_v2',
      'objeto' => 2564,
      'col_id' => 1106,
      'columna' => 'referente',
      'tipo' => 'C',
      'pk' => 0,
      'secuencia' => '',
      'largo' => 50,
      'no_nulo' => NULL,
      'no_nulo_db' => 0,
      'externa' => 0,
      'tabla' => 'intituciones_expediente',
    ),
  ),
  '_info_externas' => 
  array (
  ),
  '_info_externas_col' => 
  array (
  ),
  '_info_valores_unicos' => 
  array (
  ),
  '_info_fks' => 
  array (
  ),
);
	}

}

?>