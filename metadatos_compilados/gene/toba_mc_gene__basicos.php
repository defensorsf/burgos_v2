<?php

class toba_mc_gene__basicos
{
	static function info_basica()
	{
		return array (
  'nombre' => 'burgos_v2',
  'descripcion' => 'BURGOS_V2',
  'descripcion_corta' => 'Burgos_v2',
  'estilo' => 'v2_azul',
  'estilo_proyecto' => 'toba',
  'con_frames' => 1,
  'frames_clase' => NULL,
  'frames_archivo' => NULL,
  'salida_impr_html_c' => NULL,
  'salida_impr_html_a' => NULL,
  'menu' => 'css',
  'menu_archivo' => 'nucleo/menu/toba_menu_css.php',
  'path_includes' => NULL,
  'path_browser' => NULL,
  'administrador' => NULL,
  'listar_multiproyecto' => 1,
  'orden' => NULL,
  'palabra_vinculo_std' => NULL,
  'version_toba' => '2.6.1',
  'requiere_validacion' => 1,
  'usuario_anonimo' => NULL,
  'usuario_anonimo_desc' => NULL,
  'usuario_anonimo_grupos_acc' => NULL,
  'validacion_intentos' => NULL,
  'validacion_intentos_min' => 5,
  'validacion_bloquear_usuario' => 1,
  'validacion_debug' => NULL,
  'sesion_tiempo_no_interac_min' => 30,
  'sesion_tiempo_maximo_min' => NULL,
  'sesion_subclase' => NULL,
  'sesion_subclase_archivo' => NULL,
  'contexto_ejecucion_subclase' => NULL,
  'contexto_ejecucion_subclase_archivo' => NULL,
  'usuario_subclase' => NULL,
  'usuario_subclase_archivo' => NULL,
  'encriptar_qs' => 0,
  'registrar_solicitud' => '1',
  'registrar_cronometro' => NULL,
  'item_inicio_sesion' => '2',
  'item_pre_sesion' => '3478',
  'item_pre_sesion_popup' => NULL,
  'item_set_sesion' => NULL,
  'log_archivo' => 1,
  'log_archivo_nivel' => 7,
  'fuente_datos' => 'burgos_v2',
  'version' => NULL,
  'version_fecha' => NULL,
  'version_detalle' => NULL,
  'version_link' => NULL,
  'tiempo_espera_ms' => NULL,
  'navegacion_ajax' => 0,
  'codigo_ga_tracker' => NULL,
  'extension_toba' => true,
  'extension_proyecto' => false,
  'pm_impresion' => 14,
  'pm_sesion' => 14,
  'pm_contexto' => 14,
  'es_css3' => 1,
);
	}

	static function info_fuente__burgos_v2()
	{
		return array (
  'proyecto' => 'burgos_v2',
  'fuente_datos' => 'burgos_v2',
  'descripcion' => 'Fuente burgos_v2',
  'descripcion_corta' => 'burgos_v2',
  'fuente_datos_motor' => 'postgres7',
  'host' => NULL,
  'punto_montaje' => NULL,
  'subclase_archivo' => NULL,
  'subclase_nombre' => NULL,
  'orden' => NULL,
  'schema' => 'public',
  'instancia_id' => 'burgos_v2',
  'administrador' => NULL,
  'link_instancia' => 1,
  'tiene_auditoria' => 0,
  'parsea_errores' => 0,
  'permisos_por_tabla' => 0,
  'usuario' => NULL,
  'clave' => NULL,
  'base' => NULL,
  'link_base_archivo' => 1,
  'motor' => 'postgres7',
  'profile' => NULL,
  'mapeo_tablas_dt' => 
  array (
    'ambitos' => 2367,
    'barrios' => 2373,
    'localidades' => 2376,
    'clasificadores' => 2380,
    'tipos_casos' => 2383,
    'tipos_violencias' => 2384,
    'generos' => 2398,
    'distritos' => 2404,
    'estados_civiles' => 2410,
    'estados_expedientes' => 2416,
    'estados_relatorias' => 2422,
    'intervenciones' => 2428,
    'expedientes' => 2431,
    'tipos_intervenciones' => 2432,
    'tipos_oficios' => 2441,
    'tipos_gestiones' => 2447,
    'personal' => 2453,
    'procedencias' => 2459,
    'documentos_tipos' => 2468,
    'niveles_instruccion' => 2469,
    'paises' => 2470,
    'roles_vinculos' => 2482,
    'personas' => 2492,
    'instituciones' => 2505,
    'grupos_trabajos' => 2512,
    'organismos' => 2525,
    'organismos_dep' => 2526,
    'oficios' => 2547,
    'intituciones_expediente' => 2564,
    'eventos' => 2582,
  ),
);
	}

	static function info_indices_componentes()
	{
		return array (
);
	}

}

?>