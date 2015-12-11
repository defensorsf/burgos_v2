<?php

class toba_mc_comp__23
{
	static function get_metadatos()
	{
		return array (
  'molde' => 
  array (
    'proyecto' => 'burgos_v2',
    'molde' => 23,
    'operacion_tipo' => 10,
    'nombre' => 'Estados relator�as',
    'item' => '3490',
    'carpeta_archivos' => 'estados_relatorias',
    'prefijo_clases' => '_estados_relatorias',
    'fuente' => 'burgos_v2',
    'clase' => 'toba_asistente_abms',
  ),
  'molde_abms' => 
  array (
    'proyecto' => 'burgos_v2',
    'molde' => 23,
    'tabla' => 'estados_relatorias',
    'gen_usa_filtro' => 1,
    'gen_separar_pantallas' => 1,
    'cuadro_eof' => NULL,
    'cuadro_id' => 'id',
    'filtro_comprobar_parametros' => 0,
    'cuadro_forzar_filtro' => 0,
    'cuadro_eliminar_filas' => 0,
    'cuadro_carga_origen' => 'datos_tabla',
    'cuadro_carga_sql' => 'SELECT
	t_er.id,
	t_er.nombre
FROM
	estados_relatorias as t_er
ORDER BY nombre',
    'cuadro_carga_php_include' => NULL,
    'cuadro_carga_php_clase' => NULL,
    'cuadro_carga_php_metodo' => NULL,
    'datos_tabla_validacion' => NULL,
    'apdb_pre' => NULL,
  ),
  'molde_abms_fila' => 
  array (
    0 => 
    array (
      'proyecto' => 'burgos_v2',
      'molde' => 23,
      'fila' => 145,
      'orden' => '1',
      'columna' => 'id',
      'etiqueta' => 'Id',
      'en_cuadro' => 0,
      'en_form' => 0,
      'en_filtro' => 0,
      'filtro_operador' => '=',
      'cuadro_estilo' => 0,
      'cuadro_formato' => 7,
      'dt_tipo_dato' => 'E',
      'dt_largo' => NULL,
      'dt_secuencia' => 'seq_estados_relatorias',
      'dt_pk' => 1,
      'elemento_formulario' => 'ef_editable_numero',
      'ef_desactivar_modificacion' => NULL,
      'ef_procesar_javascript' => NULL,
      'ef_obligatorio' => 0,
      'ef_carga_origen' => NULL,
      'ef_carga_sql' => NULL,
      'ef_carga_tabla' => NULL,
      'ef_carga_php_include' => NULL,
      'ef_carga_php_clase' => NULL,
      'ef_carga_php_metodo' => NULL,
      'ef_carga_col_clave' => NULL,
      'ef_carga_col_desc' => NULL,
    ),
    1 => 
    array (
      'proyecto' => 'burgos_v2',
      'molde' => 23,
      'fila' => 146,
      'orden' => '2',
      'columna' => 'nombre',
      'etiqueta' => 'Nombre',
      'en_cuadro' => 1,
      'en_form' => 1,
      'en_filtro' => 1,
      'filtro_operador' => 'ILIKE',
      'cuadro_estilo' => 4,
      'cuadro_formato' => 1,
      'dt_tipo_dato' => 'C',
      'dt_largo' => NULL,
      'dt_secuencia' => '',
      'dt_pk' => 0,
      'elemento_formulario' => 'ef_editable',
      'ef_desactivar_modificacion' => NULL,
      'ef_procesar_javascript' => NULL,
      'ef_obligatorio' => 0,
      'ef_carga_origen' => NULL,
      'ef_carga_sql' => NULL,
      'ef_carga_tabla' => NULL,
      'ef_carga_php_include' => NULL,
      'ef_carga_php_clase' => NULL,
      'ef_carga_php_metodo' => NULL,
      'ef_carga_col_clave' => NULL,
      'ef_carga_col_desc' => NULL,
    ),
  ),
);
	}

}

?>