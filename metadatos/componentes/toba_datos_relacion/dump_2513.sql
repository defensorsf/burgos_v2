------------------------------------------------------------
--[2513]--  datos 
------------------------------------------------------------

------------------------------------------------------------
-- apex_objeto
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_objeto (proyecto, objeto, anterior, identificador, reflexivo, clase_proyecto, clase, punto_montaje, subclase, subclase_archivo, objeto_categoria_proyecto, objeto_categoria, nombre, titulo, colapsable, descripcion, fuente_datos_proyecto, fuente_datos, solicitud_registrar, solicitud_obj_obs_tipo, solicitud_obj_observacion, parametro_a, parametro_b, parametro_c, parametro_d, parametro_e, parametro_f, usuario, creacion, posicion_botonera) VALUES (
	'burgos_v2', --proyecto
	'2513', --objeto
	NULL, --anterior
	NULL, --identificador
	NULL, --reflexivo
	'toba', --clase_proyecto
	'toba_datos_relacion', --clase
	'14', --punto_montaje
	NULL, --subclase
	NULL, --subclase_archivo
	NULL, --objeto_categoria_proyecto
	NULL, --objeto_categoria
	'datos', --nombre
	NULL, --titulo
	NULL, --colapsable
	NULL, --descripcion
	'burgos_v2', --fuente_datos_proyecto
	'burgos_v2', --fuente_datos
	NULL, --solicitud_registrar
	NULL, --solicitud_obj_obs_tipo
	NULL, --solicitud_obj_observacion
	NULL, --parametro_a
	NULL, --parametro_b
	NULL, --parametro_c
	NULL, --parametro_d
	NULL, --parametro_e
	NULL, --parametro_f
	NULL, --usuario
	'2015-07-01 12:57:25', --creacion
	NULL  --posicion_botonera
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_objeto_datos_rel
------------------------------------------------------------
INSERT INTO apex_objeto_datos_rel (proyecto, objeto, debug, clave, ap, punto_montaje, ap_clase, ap_archivo, sinc_susp_constraints, sinc_orden_automatico, sinc_lock_optimista) VALUES (
	'burgos_v2', --proyecto
	'2513', --objeto
	'0', --debug
	NULL, --clave
	'2', --ap
	'14', --punto_montaje
	NULL, --ap_clase
	NULL, --ap_archivo
	'0', --sinc_susp_constraints
	'1', --sinc_orden_automatico
	'1'  --sinc_lock_optimista
);

------------------------------------------------------------
-- apex_objeto_dependencias
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'burgos_v2', --proyecto
	'1412', --dep_id
	'2513', --objeto_consumidor
	'2564', --objeto_proveedor
	'derivaciones', --identificador
	'0', --parametros_a
	'1000', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'6'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'burgos_v2', --proyecto
	'1355', --dep_id
	'2513', --objeto_consumidor
	'2431', --objeto_proveedor
	'expedientes', --identificador
	'1', --parametros_a
	'1', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'1'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'burgos_v2', --proyecto
	'1371', --dep_id
	'2513', --objeto_consumidor
	'2512', --objeto_proveedor
	'grupo_trabajo', --identificador
	'0', --parametros_a
	'1000', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'3'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'burgos_v2', --proyecto
	'1389', --dep_id
	'2513', --objeto_consumidor
	'2428', --objeto_proveedor
	'intervenciones', --identificador
	'0', --parametros_a
	'1000', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'4'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'burgos_v2', --proyecto
	'1393', --dep_id
	'2513', --objeto_consumidor
	'2547', --objeto_proveedor
	'oficios', --identificador
	'0', --parametros_a
	'1000', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'5'  --orden
);
INSERT INTO apex_objeto_dependencias (proyecto, dep_id, objeto_consumidor, objeto_proveedor, identificador, parametros_a, parametros_b, parametros_c, inicializar, orden) VALUES (
	'burgos_v2', --proyecto
	'1369', --dep_id
	'2513', --objeto_consumidor
	'2482', --objeto_proveedor
	'roles_personas', --identificador
	'0', --parametros_a
	'1000', --parametros_b
	NULL, --parametros_c
	NULL, --inicializar
	'2'  --orden
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_objeto_datos_rel_asoc
------------------------------------------------------------

--- INICIO Grupo de desarrollo 0
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'burgos_v2', --proyecto
	'2513', --objeto
	'50', --asoc_id
	NULL, --identificador
	'burgos_v2', --padre_proyecto
	'2431', --padre_objeto
	'expedientes', --padre_id
	NULL, --padre_clave
	'burgos_v2', --hijo_proyecto
	'2482', --hijo_objeto
	'roles_personas', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'1'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'burgos_v2', --proyecto
	'2513', --objeto
	'51', --asoc_id
	NULL, --identificador
	'burgos_v2', --padre_proyecto
	'2431', --padre_objeto
	'expedientes', --padre_id
	NULL, --padre_clave
	'burgos_v2', --hijo_proyecto
	'2512', --hijo_objeto
	'grupo_trabajo', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'2'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'burgos_v2', --proyecto
	'2513', --objeto
	'52', --asoc_id
	NULL, --identificador
	'burgos_v2', --padre_proyecto
	'2431', --padre_objeto
	'expedientes', --padre_id
	NULL, --padre_clave
	'burgos_v2', --hijo_proyecto
	'2428', --hijo_objeto
	'intervenciones', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'3'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'burgos_v2', --proyecto
	'2513', --objeto
	'53', --asoc_id
	NULL, --identificador
	'burgos_v2', --padre_proyecto
	'2431', --padre_objeto
	'expedientes', --padre_id
	NULL, --padre_clave
	'burgos_v2', --hijo_proyecto
	'2547', --hijo_objeto
	'oficios', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'4'  --orden
);
INSERT INTO apex_objeto_datos_rel_asoc (proyecto, objeto, asoc_id, identificador, padre_proyecto, padre_objeto, padre_id, padre_clave, hijo_proyecto, hijo_objeto, hijo_id, hijo_clave, cascada, orden) VALUES (
	'burgos_v2', --proyecto
	'2513', --objeto
	'56', --asoc_id
	NULL, --identificador
	'burgos_v2', --padre_proyecto
	'2431', --padre_objeto
	'expedientes', --padre_id
	NULL, --padre_clave
	'burgos_v2', --hijo_proyecto
	'2564', --hijo_objeto
	'derivaciones', --hijo_id
	NULL, --hijo_clave
	NULL, --cascada
	'5'  --orden
);
--- FIN Grupo de desarrollo 0

------------------------------------------------------------
-- apex_objeto_rel_columnas_asoc
------------------------------------------------------------
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'burgos_v2', --proyecto
	'2513', --objeto
	'50', --asoc_id
	'2431', --padre_objeto
	'1042', --padre_clave
	'2482', --hijo_objeto
	'991'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'burgos_v2', --proyecto
	'2513', --objeto
	'51', --asoc_id
	'2431', --padre_objeto
	'1042', --padre_clave
	'2512', --hijo_objeto
	'1030'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'burgos_v2', --proyecto
	'2513', --objeto
	'52', --asoc_id
	'2431', --padre_objeto
	'1042', --padre_clave
	'2428', --hijo_objeto
	'918'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'burgos_v2', --proyecto
	'2513', --objeto
	'53', --asoc_id
	'2431', --padre_objeto
	'1042', --padre_clave
	'2547', --hijo_objeto
	'1098'  --hijo_clave
);
INSERT INTO apex_objeto_rel_columnas_asoc (proyecto, objeto, asoc_id, padre_objeto, padre_clave, hijo_objeto, hijo_clave) VALUES (
	'burgos_v2', --proyecto
	'2513', --objeto
	'56', --asoc_id
	'2431', --padre_objeto
	'1042', --padre_clave
	'2564', --hijo_objeto
	'1103'  --hijo_clave
);