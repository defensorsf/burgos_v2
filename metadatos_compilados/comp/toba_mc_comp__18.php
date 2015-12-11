<?php

class toba_mc_comp__18
{
	static function get_metadatos()
	{
		return array (
  'molde' => 
  array (
    'proyecto' => 'burgos_v2',
    'molde' => 18,
    'operacion_tipo' => 10,
    'nombre' => 'Tipos de Casos',
    'item' => '3485',
    'carpeta_archivos' => 'tipos_de_casos',
    'prefijo_clases' => '_tipos_de_casos',
    'fuente' => 'burgos_v2',
    'clase' => 'toba_asistente_abms',
  ),
  'molde_abms' => 
  array (
    'proyecto' => 'burgos_v2',
    'molde' => 18,
    'tabla' => 'tipos_casos',
    'gen_usa_filtro' => 1,
    'gen_separar_pantallas' => 1,
    'cuadro_eof' => NULL,
    'cuadro_id' => 'id',
    'filtro_comprobar_parametros' => 0,
    'cuadro_forzar_filtro' => 0,
    'cuadro_eliminar_filas' => 0,
    'cuadro_carga_origen' => 'datos_tabla',
    'cuadro_carga_sql' => 'SELECT
	t_tc.id,
	t_a.nombre as id_ambito_nombre,
	t_tc.nombre
FROM
	tipos_casos as t_tc	LEFT OUTER JOIN ambitos as t_a ON (t_tc.id_ambito = t_a.id)
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
      'molde' => 18,
      'fila' => 133,
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
      'dt_secuencia' => 'seq_tipos_casos',
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
      'molde' => 18,
      'fila' => 134,
      'orden' => '2',
      'columna' => 'id_ambito',
      'etiqueta' => 'Ambito',
      'en_cuadro' => 1,
      'en_form' => 1,
      'en_filtro' => 1,
      'filtro_operador' => '=',
      'cuadro_estilo' => 4,
      'cuadro_formato' => 1,
      'dt_tipo_dato' => 'C',
      'dt_largo' => NULL,
      'dt_secuencia' => '',
      'dt_pk' => 0,
      'elemento_formulario' => 'ef_combo',
      'ef_desactivar_modificacion' => NULL,
      'ef_procesar_javascript' => NULL,
      'ef_obligatorio' => 1,
      'ef_carga_origen' => 'datos_tabla',
      'ef_carga_sql' => 'SELECT id, nombre FROM ambitos ORDER BY nombre',
      'ef_carga_tabla' => 'ambitos',
      'ef_carga_php_include' => NULL,
      'ef_carga_php_clase' => NULL,
      'ef_carga_php_metodo' => NULL,
      'ef_carga_col_clave' => 'id',
      'ef_carga_col_desc' => 'nombre',
    ),
    2 => 
    array (
      'proyecto' => 'burgos_v2',
      'molde' => 18,
      'fila' => 135,
      'orden' => '3',
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
      'ef_obligatorio' => 1,
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