<?php

class toba_mc_comp__2479
{
	static function get_metadatos()
	{
		return array (
  '_info' => 
  array (
    'proyecto' => 'burgos_v2',
    'objeto' => 2479,
    'anterior' => NULL,
    'identificador' => NULL,
    'reflexivo' => NULL,
    'clase_proyecto' => 'toba',
    'clase' => 'toba_ci',
    'subclase' => 'ci_presentacion_expontanea',
    'subclase_archivo' => 'expedientes/ci_presentacion_expontanea.php',
    'objeto_categoria_proyecto' => NULL,
    'objeto_categoria' => NULL,
    'nombre' => 'Presentacion Expontanea',
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
    'creacion' => '2015-06-26 09:59:02',
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
    'posicion_botonera' => 'ambos',
  ),
  '_info_eventos' => 
  array (
    0 => 
    array (
      'evento_id' => 1328,
      'identificador' => 'procesar',
      'etiqueta' => '&Guardar',
      'maneja_datos' => 1,
      'sobre_fila' => NULL,
      'confirmacion' => NULL,
      'estilo' => NULL,
      'imagen_recurso_origen' => 'apex',
      'imagen' => 'guardar.gif',
      'en_botonera' => 1,
      'ayuda' => NULL,
      'ci_predep' => NULL,
      'implicito' => 0,
      'defecto' => 1,
      'grupo' => NULL,
      'accion' => NULL,
      'accion_imphtml_debug' => NULL,
      'accion_vinculo_carpeta' => NULL,
      'accion_vinculo_item' => NULL,
      'accion_vinculo_objeto' => NULL,
      'accion_vinculo_popup' => NULL,
      'accion_vinculo_popup_param' => NULL,
      'accion_vinculo_celda' => NULL,
      'accion_vinculo_target' => NULL,
      'accion_vinculo_servicio' => NULL,
      'es_seleccion_multiple' => 0,
      'es_autovinculo' => 0,
    ),
    1 => 
    array (
      'evento_id' => 1329,
      'identificador' => 'cancelar',
      'etiqueta' => '&Cancelar',
      'maneja_datos' => 0,
      'sobre_fila' => NULL,
      'confirmacion' => NULL,
      'estilo' => NULL,
      'imagen_recurso_origen' => 'apex',
      'imagen' => NULL,
      'en_botonera' => 1,
      'ayuda' => NULL,
      'ci_predep' => NULL,
      'implicito' => 0,
      'defecto' => 0,
      'grupo' => NULL,
      'accion' => NULL,
      'accion_imphtml_debug' => NULL,
      'accion_vinculo_carpeta' => NULL,
      'accion_vinculo_item' => NULL,
      'accion_vinculo_objeto' => NULL,
      'accion_vinculo_popup' => NULL,
      'accion_vinculo_popup_param' => NULL,
      'accion_vinculo_celda' => NULL,
      'accion_vinculo_target' => NULL,
      'accion_vinculo_servicio' => NULL,
      'es_seleccion_multiple' => 0,
      'es_autovinculo' => 0,
    ),
    2 => 
    array (
      'evento_id' => 1402,
      'identificador' => 'imprimir',
      'etiqueta' => '&Imprimir',
      'maneja_datos' => 0,
      'sobre_fila' => NULL,
      'confirmacion' => NULL,
      'estilo' => NULL,
      'imagen_recurso_origen' => 'apex',
      'imagen' => 'impresora.gif',
      'en_botonera' => 1,
      'ayuda' => NULL,
      'ci_predep' => NULL,
      'implicito' => 0,
      'defecto' => 0,
      'grupo' => NULL,
      'accion' => 'H',
      'accion_imphtml_debug' => 0,
      'accion_vinculo_carpeta' => NULL,
      'accion_vinculo_item' => NULL,
      'accion_vinculo_objeto' => NULL,
      'accion_vinculo_popup' => 0,
      'accion_vinculo_popup_param' => NULL,
      'accion_vinculo_celda' => NULL,
      'accion_vinculo_target' => NULL,
      'accion_vinculo_servicio' => NULL,
      'es_seleccion_multiple' => 0,
      'es_autovinculo' => 0,
    ),
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
    'botonera_barra_item' => 1,
  ),
  '_info_ci_me_pantalla' => 
  array (
    0 => 
    array (
      'pantalla' => 1245,
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
      'template' => '<table>
	<tbody>
		<tr>
			<td>
				[dep id=profesional]</td>
		</tr>
		<tr>
			<td>
				[dep id=frm_expediente]</td>
		</tr>
		<tr>
			<td>
				[dep id=frm_roles]</td>
		</tr>
	</tbody>
</table>
<p>&nbsp;</p>',
      'template_impresion' => '<p>[dep id=frm_roles]</p>
<hr />
<p>[dep id=frm_expediente]</p>',
    ),
  ),
  '_info_obj_pantalla' => 
  array (
    0 => 
    array (
      'pantalla' => 1245,
      'proyecto' => 'burgos_v2',
      'objeto_ci' => 2479,
      'dep_id' => 1368,
      'orden' => 0,
      'identificador_pantalla' => 'pant_inicial',
      'identificador_dep' => 'frm_expediente',
    ),
    1 => 
    array (
      'pantalla' => 1245,
      'proyecto' => 'burgos_v2',
      'objeto_ci' => 2479,
      'dep_id' => 1333,
      'orden' => 1,
      'identificador_pantalla' => 'pant_inicial',
      'identificador_dep' => 'frm_roles',
    ),
    2 => 
    array (
      'pantalla' => 1245,
      'proyecto' => 'burgos_v2',
      'objeto_ci' => 2479,
      'dep_id' => 1402,
      'orden' => 2,
      'identificador_pantalla' => 'pant_inicial',
      'identificador_dep' => 'profesional',
    ),
  ),
  '_info_evt_pantalla' => 
  array (
    0 => 
    array (
      'pantalla' => 1245,
      'proyecto' => 'burgos_v2',
      'objeto_ci' => 2479,
      'evento_id' => 1328,
      'identificador_pantalla' => 'pant_inicial',
      'identificador_evento' => 'procesar',
    ),
    1 => 
    array (
      'pantalla' => 1245,
      'proyecto' => 'burgos_v2',
      'objeto_ci' => 2479,
      'evento_id' => 1329,
      'identificador_pantalla' => 'pant_inicial',
      'identificador_evento' => 'cancelar',
    ),
    2 => 
    array (
      'pantalla' => 1245,
      'proyecto' => 'burgos_v2',
      'objeto_ci' => 2479,
      'evento_id' => 1402,
      'identificador_pantalla' => 'pant_inicial',
      'identificador_evento' => 'imprimir',
    ),
  ),
  '_info_dependencias' => 
  array (
    0 => 
    array (
      'identificador' => 'frm_expediente',
      'proyecto' => 'burgos_v2',
      'objeto' => 2524,
      'clase' => 'toba_ei_formulario',
      'clase_archivo' => 'nucleo/componentes/interface/toba_ei_formulario.php',
      'subclase' => NULL,
      'subclase_archivo' => NULL,
      'fuente' => 'burgos_v2',
      'parametros_a' => NULL,
      'parametros_b' => NULL,
    ),
    1 => 
    array (
      'identificador' => 'frm_roles',
      'proyecto' => 'burgos_v2',
      'objeto' => 2491,
      'clase' => 'toba_ei_formulario',
      'clase_archivo' => 'nucleo/componentes/interface/toba_ei_formulario.php',
      'subclase' => 'popup_persona',
      'subclase_archivo' => 'expedientes/popup_persona.php',
      'fuente' => 'burgos_v2',
      'parametros_a' => NULL,
      'parametros_b' => NULL,
    ),
    2 => 
    array (
      'identificador' => 'profesional',
      'proyecto' => 'burgos_v2',
      'objeto' => 2555,
      'clase' => 'toba_ei_formulario',
      'clase_archivo' => 'nucleo/componentes/interface/toba_ei_formulario.php',
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