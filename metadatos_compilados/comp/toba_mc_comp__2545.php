<?php

class toba_mc_comp__2545
{
	static function get_metadatos()
	{
		return array (
  '_info' => 
  array (
    'proyecto' => 'burgos_v2',
    'objeto' => 2545,
    'anterior' => NULL,
    'identificador' => NULL,
    'reflexivo' => NULL,
    'clase_proyecto' => 'toba',
    'clase' => 'toba_ei_cuadro',
    'subclase' => 'ei_cuadro',
    'subclase_archivo' => 'extension_toba/componentes/hoja_de_ruta/ei_cuadro.php',
    'objeto_categoria_proyecto' => NULL,
    'objeto_categoria' => NULL,
    'nombre' => 'Hoja de Ruta - cuadro',
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
    'creacion' => '2015-07-23 03:02:54',
    'punto_montaje' => 14,
    'clase_editor_proyecto' => 'toba_editor',
    'clase_editor_item' => '1000253',
    'clase_archivo' => 'nucleo/componentes/interface/toba_ei_cuadro.php',
    'clase_vinculos' => NULL,
    'clase_editor' => '1000253',
    'clase_icono' => 'objetos/cuadro_array.gif',
    'clase_descripcion_corta' => 'ei_cuadro',
    'clase_instanciador_proyecto' => 'toba_editor',
    'clase_instanciador_item' => '1843',
    'objeto_existe_ayuda' => NULL,
    'ap_clase' => NULL,
    'ap_archivo' => NULL,
    'ap_punto_montaje' => NULL,
    'cant_dependencias' => 0,
    'posicion_botonera' => 'abajo',
  ),
  '_info_eventos' => 
  array (
  ),
  '_info_puntos_control' => 
  array (
  ),
  '_info_cuadro' => 
  array (
    'titulo' => NULL,
    'subtitulo' => NULL,
    'sql' => NULL,
    'columnas_clave' => NULL,
    'clave_datos_tabla' => 0,
    'archivos_callbacks' => NULL,
    'ancho' => '100%',
    'ordenar' => 1,
    'exportar_paginado' => 1,
    'exportar_xls' => 1,
    'exportar_pdf' => 1,
    'paginar' => 1,
    'tamano_pagina' => 10,
    'tipo_paginado' => 'P',
    'scroll' => 0,
    'alto' => NULL,
    'eof_invisible' => 0,
    'eof_customizado' => 'Ingrese un criterio v�lido de b�squeda',
    'pdf_respetar_paginacion' => NULL,
    'pdf_propiedades' => NULL,
    'asociacion_columnas' => NULL,
    'dao_nucleo_proyecto' => NULL,
    'dao_clase' => NULL,
    'dao_metodo' => NULL,
    'dao_parametros' => NULL,
    'dao_archivo' => '',
    'cc_modo' => 't',
    'cc_modo_anidado_colap' => 1,
    'cc_modo_anidado_totcol' => NULL,
    'cc_modo_anidado_totcua' => NULL,
    'columna_descripcion' => NULL,
    'mostrar_total_registros' => 1,
    'siempre_con_titulo' => 1,
  ),
  '_info_cuadro_columna' => 
  array (
    0 => 
    array (
      'orden' => '1',
      'objeto_cuadro_col' => 1019,
      'titulo' => 'Fecha',
      'estilo_titulo' => 'ei-cuadro-col-tit',
      'estilo' => '4',
      'ancho' => NULL,
      'clave' => 'fecha',
      'formateo' => 'fecha',
      'no_ordenar' => NULL,
      'mostrar_xls' => NULL,
      'mostrar_pdf' => NULL,
      'pdf_propiedades' => NULL,
      'total' => NULL,
      'vinculo_indice' => NULL,
      'usar_vinculo' => NULL,
      'total_cc' => NULL,
      'permitir_html' => 0,
      'grupo' => NULL,
      'evento_asociado' => NULL,
    ),
    1 => 
    array (
      'orden' => '2',
      'objeto_cuadro_col' => 1018,
      'titulo' => 'Tipo de Intervenci�n',
      'estilo_titulo' => 'ei-cuadro-col-tit',
      'estilo' => '4',
      'ancho' => NULL,
      'clave' => 'tipo_intervencion',
      'formateo' => 'NULO',
      'no_ordenar' => NULL,
      'mostrar_xls' => NULL,
      'mostrar_pdf' => NULL,
      'pdf_propiedades' => NULL,
      'total' => NULL,
      'vinculo_indice' => NULL,
      'usar_vinculo' => NULL,
      'total_cc' => NULL,
      'permitir_html' => 0,
      'grupo' => NULL,
      'evento_asociado' => NULL,
    ),
    2 => 
    array (
      'orden' => '3',
      'objeto_cuadro_col' => 1020,
      'titulo' => 'Observaciones',
      'estilo_titulo' => 'ei-cuadro-col-tit',
      'estilo' => '4',
      'ancho' => NULL,
      'clave' => 'observaciones',
      'formateo' => 'NULO',
      'no_ordenar' => NULL,
      'mostrar_xls' => NULL,
      'mostrar_pdf' => NULL,
      'pdf_propiedades' => NULL,
      'total' => NULL,
      'vinculo_indice' => NULL,
      'usar_vinculo' => NULL,
      'total_cc' => NULL,
      'permitir_html' => 0,
      'grupo' => NULL,
      'evento_asociado' => NULL,
    ),
    3 => 
    array (
      'orden' => '4',
      'objeto_cuadro_col' => 1021,
      'titulo' => 'Profesionales',
      'estilo_titulo' => 'ei-cuadro-col-tit',
      'estilo' => '4',
      'ancho' => NULL,
      'clave' => 'quien',
      'formateo' => 'NULO',
      'no_ordenar' => NULL,
      'mostrar_xls' => NULL,
      'mostrar_pdf' => NULL,
      'pdf_propiedades' => NULL,
      'total' => NULL,
      'vinculo_indice' => NULL,
      'usar_vinculo' => NULL,
      'total_cc' => NULL,
      'permitir_html' => 0,
      'grupo' => NULL,
      'evento_asociado' => NULL,
    ),
  ),
  '_info_cuadro_cortes' => 
  array (
    0 => 
    array (
      'orden' => '1',
      'columnas_id' => 'expediente',
      'columnas_descripcion' => 'expediente',
      'identificador' => 'expedeinte',
      'pie_contar_filas' => '1',
      'pie_mostrar_titular' => 0,
      'pie_mostrar_titulos' => 1,
      'modo_inicio_colapsado' => 0,
      'imp_paginar' => NULL,
      'descripcion' => 'Expediente',
      'objeto_cuadro_cc' => 30,
    ),
  ),
  '_info_sum_cuadro_cortes' => 
  array (
  ),
);
	}

}

?>