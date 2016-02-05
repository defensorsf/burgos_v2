--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: responsables(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION responsables(expediente integer) RETURNS text
    LANGUAGE plpgsql
    AS $$declare
	rv  RECORD;
	cadena text;
BEGIN
	cadena = '' ;

	FOR rv IN SELECT id_personal  FROM grupos_trabajos  WHERE id_expediente = expediente AND primera_entrevista LOOP
		cadena = cadena || (SELECT nombre || ' ' ||apellido FROM personal WHERE id = rv.id_personal) || ' / ';
	END LOOP;
   
   RETURN left(cadena, -2);
END;
$$;


ALTER FUNCTION public.responsables(expediente integer) OWNER TO postgres;

--
-- Name: victimas(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION victimas(expediente integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
	rv  RECORD; --el registro para el loop
	cadena text;
BEGIN
	cadena = '' ;
	--id_rol =1 es victima. Hce un loop por todas las victimas del expediente
	FOR rv IN SELECT id_persona, id_rol  FROM roles_vinculos  WHERE id_expediente = expediente AND id_rol = 1 LOOP
		cadena = cadena || (SELECT nombre || ' ' ||apellido FROM personas WHERE id = rv.id_persona) || ' / ';
	END LOOP;
   
   RETURN left(cadena, -2);
END;
$$;


ALTER FUNCTION public.victimas(expediente integer) OWNER TO postgres;

--
-- Name: seq_ambitos; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_ambitos
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_ambitos OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ambitos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ambitos (
    id integer DEFAULT nextval('seq_ambitos'::regclass) NOT NULL,
    nombre character varying(30) DEFAULT NULL::character varying
);


ALTER TABLE public.ambitos OWNER TO postgres;

--
-- Name: seq_barrios; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_barrios
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_barrios OWNER TO postgres;

--
-- Name: barrios; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE barrios (
    id integer DEFAULT nextval('seq_barrios'::regclass) NOT NULL,
    nombre character varying(30) DEFAULT NULL::character varying,
    id_localidad integer NOT NULL
);


ALTER TABLE public.barrios OWNER TO postgres;

--
-- Name: seq_clasificadores; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_clasificadores
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_clasificadores OWNER TO postgres;

--
-- Name: clasificadores; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE clasificadores (
    id integer DEFAULT nextval('seq_clasificadores'::regclass) NOT NULL,
    id_ambito integer,
    id_tipo1 integer,
    id_tipo2 integer,
    id_tipo3 integer,
    violencia boolean,
    id_tipov1 integer,
    id_tipov2 integer,
    id_tipov3 integer
);


ALTER TABLE public.clasificadores OWNER TO postgres;

--
-- Name: cod_postales; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cod_postales (
    id_localidad integer NOT NULL,
    codigo_postal character varying(15) NOT NULL
);


ALTER TABLE public.cod_postales OWNER TO postgres;

--
-- Name: continentes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE continentes (
    id character(2) NOT NULL,
    nombre character varying(20) NOT NULL
);


ALTER TABLE public.continentes OWNER TO postgres;

--
-- Name: seq_distritos; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_distritos
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_distritos OWNER TO postgres;

--
-- Name: distritos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE distritos (
    id integer DEFAULT nextval('seq_distritos'::regclass) NOT NULL,
    nombre character varying(30) DEFAULT NULL::character varying,
    id_localidad integer NOT NULL
);


ALTER TABLE public.distritos OWNER TO postgres;

--
-- Name: seq_documentos_tipos; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_documentos_tipos
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_documentos_tipos OWNER TO postgres;

--
-- Name: documentos_tipos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE documentos_tipos (
    id integer DEFAULT nextval('seq_documentos_tipos'::regclass) NOT NULL,
    nombre character varying(30) NOT NULL,
    "Descipcion" character varying(40) NOT NULL
);


ALTER TABLE public.documentos_tipos OWNER TO postgres;

--
-- Name: seq_dptos_partidos; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_dptos_partidos
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_dptos_partidos OWNER TO postgres;

--
-- Name: dptos_partidos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dptos_partidos (
    id integer DEFAULT nextval('seq_dptos_partidos'::regclass) NOT NULL,
    nombre character varying(60) NOT NULL,
    id_provincia integer NOT NULL,
    estado character(1) DEFAULT 'A'::bpchar NOT NULL,
    CONSTRAINT ck_dptos_partidos_estado CHECK ((estado = ANY (ARRAY['A'::bpchar, 'B'::bpchar])))
);


ALTER TABLE public.dptos_partidos OWNER TO postgres;

--
-- Name: seq_estados_civiles; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_estados_civiles
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_estados_civiles OWNER TO postgres;

--
-- Name: estados_civiles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE estados_civiles (
    id integer DEFAULT nextval('seq_estados_civiles'::regclass) NOT NULL,
    nombre character varying(30)
);


ALTER TABLE public.estados_civiles OWNER TO postgres;

--
-- Name: seq_estados_expedientes; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_estados_expedientes
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_estados_expedientes OWNER TO postgres;

--
-- Name: estados_expedientes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE estados_expedientes (
    id integer DEFAULT nextval('seq_estados_expedientes'::regclass) NOT NULL,
    nombre character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE public.estados_expedientes OWNER TO postgres;

--
-- Name: seq_estados_relatorias; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_estados_relatorias
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_estados_relatorias OWNER TO postgres;

--
-- Name: estados_relatorias; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE estados_relatorias (
    id integer DEFAULT nextval('seq_estados_relatorias'::regclass) NOT NULL,
    nombre character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE public.estados_relatorias OWNER TO postgres;

--
-- Name: eventos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE eventos (
    fecha date NOT NULL,
    descripcion text NOT NULL,
    id integer NOT NULL,
    hora time without time zone
);


ALTER TABLE public.eventos OWNER TO postgres;

--
-- Name: eventos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE eventos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eventos_id_seq OWNER TO postgres;

--
-- Name: eventos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE eventos_id_seq OWNED BY eventos.id;


--
-- Name: seq_expedientes; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_expedientes
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_expedientes OWNER TO postgres;

--
-- Name: seq_numero_expediente; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_numero_expediente
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_numero_expediente OWNER TO postgres;

--
-- Name: expedientes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE expedientes (
    id integer DEFAULT nextval('seq_expedientes'::regclass) NOT NULL,
    id_procedencia integer,
    id_tipogestion integer,
    id_clasificador integer,
    id_estado_expediente integer,
    fecha_presentacion timestamp without time zone,
    fecha_ultimo_mov date,
    id_responsable_ingreso integer,
    numero character varying(50) DEFAULT (('SFE '::text || to_char(now(), 'YYYY'::text)) || to_char(nextval('seq_numero_expediente'::regclass), '00000'::text)),
    denuncia_policial boolean DEFAULT false NOT NULL,
    lugar_denuncia text DEFAULT NULL::character varying,
    fecha_denuncia text DEFAULT NULL::character varying,
    persona_denuncia text,
    lugar_hecho_denuncia text DEFAULT NULL::character varying,
    ultimo_episodio_denuncia date,
    encuadre_legal text,
    aplicacion_ley text DEFAULT NULL::character varying,
    id_estado_relatoria integer,
    fecha_entrada date,
    fecha_salida date,
    fecha_cierre date,
    fecha_archivo date,
    procedencia text NOT NULL,
    id_institucion integer,
    origen_presentacion text,
    motivo_consulta text,
    observaciones text,
    organismo text,
    dependencia_org text,
    lugar text,
    tipo_atencion text,
    id_ambito integer,
    nomeclador_1 integer,
    nomeclador_2 integer,
    nomeclador_3 integer,
    violencia_1 integer,
    violencia_2 integer,
    violencia_3 integer,
    fecha_derivacion timestamp without time zone,
    hubo_violencia boolean DEFAULT false NOT NULL,
    estado integer DEFAULT 0 NOT NULL,
    fecha_oficio date,
    nro_expediente_judicial text,
    planificacion text,
    evaluacion text
);


ALTER TABLE public.expedientes OWNER TO postgres;

--
-- Name: COLUMN expedientes.id_procedencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN expedientes.id_procedencia IS 'Forma en que se presenta la denuncia (espontanea, de oficio, oficio judicial, derivacion))';


--
-- Name: COLUMN expedientes.fecha_presentacion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN expedientes.fecha_presentacion IS 'fecha en que se inicia o crea un expediente';


--
-- Name: COLUMN expedientes.id_responsable_ingreso; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN expedientes.id_responsable_ingreso IS 'persona  que inicio el expediente de oficio';


--
-- Name: COLUMN expedientes.numero; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN expedientes.numero IS 'numero del expediente compuesto del lugar+año+numero (que cicla cada año)';


--
-- Name: COLUMN expedientes.denuncia_policial; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN expedientes.denuncia_policial IS 'existencia de denuncia policial si o no';


--
-- Name: COLUMN expedientes.lugar_denuncia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN expedientes.lugar_denuncia IS 'lugar de la denuncia policial';


--
-- Name: COLUMN expedientes.fecha_denuncia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN expedientes.fecha_denuncia IS 'fecha denuncia policial';


--
-- Name: COLUMN expedientes.persona_denuncia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN expedientes.persona_denuncia IS 'quien realizo la denuncia policial';


--
-- Name: COLUMN expedientes.lugar_hecho_denuncia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN expedientes.lugar_hecho_denuncia IS 'lugar del hecho denunciado policialmente';


--
-- Name: COLUMN expedientes.ultimo_episodio_denuncia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN expedientes.ultimo_episodio_denuncia IS 'ultimo episodio de la denuncia polcial';


--
-- Name: COLUMN expedientes.procedencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN expedientes.procedencia IS 'Forma en que se presenta la denuncia (espontanea, de oficio, oficio judicial, derivacion))';


--
-- Name: COLUMN expedientes.id_institucion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN expedientes.id_institucion IS 'Esto no va, sería el campo organismo';


--
-- Name: COLUMN expedientes.origen_presentacion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN expedientes.origen_presentacion IS 'Si fue persona, telefonica, por correo';


--
-- Name: COLUMN expedientes.organismo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN expedientes.organismo IS 'Organismo que deriva el expediente. De ser una presentación espontanea es nulo';


--
-- Name: COLUMN expedientes.tipo_atencion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN expedientes.tipo_atencion IS 'Tipo de atención (asistencia psicologica, legal o simple))';


--
-- Name: COLUMN expedientes.id_ambito; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN expedientes.id_ambito IS 'El ambito puede ser 1-Institucional; 2-Familiar ; 3-Comunitario. CLos ambitos definen los posibles tipos de casos';


--
-- Name: COLUMN expedientes.hubo_violencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN expedientes.hubo_violencia IS 'Indica si hubo violencia en el caso';


--
-- Name: COLUMN expedientes.estado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN expedientes.estado IS '0-En proceso, 1 - Pase a Archivo, 2 - Archivado';


--
-- Name: COLUMN expedientes.fecha_oficio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN expedientes.fecha_oficio IS 'Fecha en la que se envió el oficio judicial.';


--
-- Name: COLUMN expedientes.nro_expediente_judicial; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN expedientes.nro_expediente_judicial IS 'Cuando se inicia por oficio Judicial. Este es el número con el que viene';


--
-- Name: COLUMN expedientes.planificacion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN expedientes.planificacion IS 'PLANIFICACIÓN Y DISEÑO DE ATENCIÓN';


--
-- Name: COLUMN expedientes.evaluacion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN expedientes.evaluacion IS 'EVALUACIÓN DE PROCESO';


--
-- Name: expedientes_nro_expediente_judicial_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE expedientes_nro_expediente_judicial_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.expedientes_nro_expediente_judicial_seq OWNER TO postgres;

--
-- Name: expedientes_nro_expediente_judicial_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE expedientes_nro_expediente_judicial_seq OWNED BY expedientes.nro_expediente_judicial;


--
-- Name: expedientes_origen_presentacion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE expedientes_origen_presentacion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.expedientes_origen_presentacion_seq OWNER TO postgres;

--
-- Name: expedientes_origen_presentacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE expedientes_origen_presentacion_seq OWNED BY expedientes.origen_presentacion;


--
-- Name: seq_generos; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_generos
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_generos OWNER TO postgres;

--
-- Name: generos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE generos (
    id integer DEFAULT nextval('seq_generos'::regclass) NOT NULL,
    nombre character varying(30) DEFAULT NULL::character varying
);


ALTER TABLE public.generos OWNER TO postgres;

--
-- Name: seq_grupos_trabajos; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_grupos_trabajos
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_grupos_trabajos OWNER TO postgres;

--
-- Name: grupos_trabajos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE grupos_trabajos (
    id integer DEFAULT nextval('seq_grupos_trabajos'::regclass) NOT NULL,
    id_personal integer,
    id_expediente integer,
    activo boolean DEFAULT true,
    primera_entrevista boolean DEFAULT true NOT NULL
);


ALTER TABLE public.grupos_trabajos OWNER TO postgres;

--
-- Name: COLUMN grupos_trabajos.primera_entrevista; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grupos_trabajos.primera_entrevista IS 'Identifica si el profesional estuvo presente en la primera entrevista';


--
-- Name: instituciones; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE instituciones (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    direccion character varying(50),
    telefonos character varying(50)
);


ALTER TABLE public.instituciones OWNER TO postgres;

--
-- Name: instituciones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE instituciones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.instituciones_id_seq OWNER TO postgres;

--
-- Name: instituciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE instituciones_id_seq OWNED BY instituciones.id;


--
-- Name: seq_intervenciones; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_intervenciones
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_intervenciones OWNER TO postgres;

--
-- Name: intervenciones; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE intervenciones (
    id integer DEFAULT nextval('seq_intervenciones'::regclass) NOT NULL,
    id_expediente integer,
    id_tipo integer,
    fecha date,
    observaciones character varying(80) DEFAULT NULL::character varying,
    quien character varying(80) DEFAULT NULL::character varying
);


ALTER TABLE public.intervenciones OWNER TO postgres;

--
-- Name: intituciones_expediente; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE intituciones_expediente (
    id integer NOT NULL,
    id_institucion integer,
    id_expediente integer NOT NULL,
    accion integer NOT NULL,
    observaciones text,
    referente character varying(50),
    organismo character varying(50),
    direccion character varying(50),
    telefono character varying(35)
);


ALTER TABLE public.intituciones_expediente OWNER TO postgres;

--
-- Name: COLUMN intituciones_expediente.accion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN intituciones_expediente.accion IS 'Esto puede ser derivacion o articulación';


--
-- Name: COLUMN intituciones_expediente.referente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN intituciones_expediente.referente IS 'La persona referente en la institucion en esta intervencion en particular';


--
-- Name: COLUMN intituciones_expediente.organismo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN intituciones_expediente.organismo IS 'Se usa este en vez de id_institucion';


--
-- Name: intituciones_expediente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE intituciones_expediente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.intituciones_expediente_id_seq OWNER TO postgres;

--
-- Name: intituciones_expediente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE intituciones_expediente_id_seq OWNED BY intituciones_expediente.id;


--
-- Name: seq_localidades; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_localidades
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_localidades OWNER TO postgres;

--
-- Name: localidades; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE localidades (
    id integer DEFAULT nextval('seq_localidades'::regclass) NOT NULL,
    nombre character varying(30),
    nombre_abreviado character varying(60) NOT NULL,
    id_dpto_partido integer NOT NULL,
    ddn integer
);


ALTER TABLE public.localidades OWNER TO postgres;

--
-- Name: seq_niveles_instruccion; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_niveles_instruccion
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_niveles_instruccion OWNER TO postgres;

--
-- Name: niveles_instruccion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE niveles_instruccion (
    id integer DEFAULT nextval('seq_niveles_instruccion'::regclass) NOT NULL,
    nombre character varying(30) DEFAULT NULL::character varying
);


ALTER TABLE public.niveles_instruccion OWNER TO postgres;

--
-- Name: seq_oficio_respuestas; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_oficio_respuestas
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_oficio_respuestas OWNER TO postgres;

--
-- Name: oficio_respuestas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE oficio_respuestas (
    id integer DEFAULT nextval('seq_oficio_respuestas'::regclass) NOT NULL,
    id_oficio integer,
    respuesta character varying(80) DEFAULT NULL::character varying
);


ALTER TABLE public.oficio_respuestas OWNER TO postgres;

--
-- Name: oficios; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE oficios (
    id integer NOT NULL,
    nro_emision character varying(30) NOT NULL,
    nro_recepcion character varying(30),
    fecha_emision date,
    fecha_recepcion date,
    destino character varying(50),
    persona character varying(50),
    tiempo_respuesta integer,
    contestado boolean,
    fecha_respuesta date,
    habilitado boolean,
    id_expediente integer NOT NULL
);


ALTER TABLE public.oficios OWNER TO postgres;

--
-- Name: oficios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE oficios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oficios_id_seq OWNER TO postgres;

--
-- Name: oficios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE oficios_id_seq OWNED BY oficios.id;


--
-- Name: seq_oficios_notas; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_oficios_notas
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_oficios_notas OWNER TO postgres;

--
-- Name: oficios_notas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE oficios_notas (
    id integer DEFAULT nextval('seq_oficios_notas'::regclass) NOT NULL,
    id_expediente integer,
    fecha_inicio date NOT NULL,
    fecha_recepcion date,
    id_tipo_oficio integer NOT NULL
);


ALTER TABLE public.oficios_notas OWNER TO postgres;

--
-- Name: oficios_recibidos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE oficios_recibidos (
    id integer NOT NULL,
    id_expediente integer NOT NULL,
    fecha_ingreso date,
    organismo character varying(50),
    organismo_dep character varying(50),
    nro_emision character varying(50),
    solicitud text
);


ALTER TABLE public.oficios_recibidos OWNER TO postgres;

--
-- Name: COLUMN oficios_recibidos.organismo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN oficios_recibidos.organismo IS 'Organismo que lo emite';


--
-- Name: COLUMN oficios_recibidos.organismo_dep; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN oficios_recibidos.organismo_dep IS 'dependencia del organismo. Relacionado con el organismo';


--
-- Name: COLUMN oficios_recibidos.nro_emision; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN oficios_recibidos.nro_emision IS 'Nro con el que lo emitio el organismo';


--
-- Name: oficios_recibidos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE oficios_recibidos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oficios_recibidos_id_seq OWNER TO postgres;

--
-- Name: oficios_recibidos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE oficios_recibidos_id_seq OWNED BY oficios_recibidos.id;


--
-- Name: organismos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE organismos (
    nombre character varying NOT NULL
);


ALTER TABLE public.organismos OWNER TO postgres;

--
-- Name: organismos_dep; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE organismos_dep (
    organismo character varying,
    dependencia character varying
);


ALTER TABLE public.organismos_dep OWNER TO postgres;

--
-- Name: origenes_presentaciones; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE origenes_presentaciones (
    nombre character varying(25)
);


ALTER TABLE public.origenes_presentaciones OWNER TO postgres;

--
-- Name: seq_paises; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_paises
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_paises OWNER TO postgres;

--
-- Name: paises; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE paises (
    id integer DEFAULT nextval('seq_paises'::regclass) NOT NULL,
    nombre character varying(60) NOT NULL,
    id_continente character(2) NOT NULL,
    codigo_iso character(2) NOT NULL
);


ALTER TABLE public.paises OWNER TO postgres;

--
-- Name: seq_personal; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_personal
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_personal OWNER TO postgres;

--
-- Name: personal; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE personal (
    id integer DEFAULT nextval('seq_personal'::regclass) NOT NULL,
    apellido character varying(30) NOT NULL,
    nombre character varying(30) NOT NULL,
    telefono character varying(30) NOT NULL,
    area character varying(50) NOT NULL,
    profesional boolean DEFAULT false NOT NULL
);


ALTER TABLE public.personal OWNER TO postgres;

--
-- Name: seq_personas; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_personas
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_personas OWNER TO postgres;

--
-- Name: personas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE personas (
    id integer DEFAULT nextval('seq_personas'::regclass) NOT NULL,
    id_genero integer,
    id_estado_civil integer,
    id_documento_tipo integer NOT NULL,
    id_pais_nacimiento integer,
    id_distrito integer,
    id_localidad integer,
    id_nivel_instruccion integer,
    id_barrio integer,
    documento_nro text,
    apellido text NOT NULL,
    nombre text DEFAULT NULL::character varying,
    fecha_nacimiento date,
    lugar_nacimiento text DEFAULT NULL::character varying,
    nacionalidad text DEFAULT NULL::character varying,
    domicilio_real text DEFAULT NULL::character varying,
    propietario_inmueble boolean,
    telefono text DEFAULT NULL::character varying,
    mail text DEFAULT NULL::character varying,
    ocupacion text DEFAULT NULL::character varying,
    necesidades_especiales text,
    beneficios_sociales text,
    redes_sociales_institucionales text DEFAULT NULL::character varying,
    titulo text,
    antecedente_violencia boolean DEFAULT false NOT NULL,
    beneficio_auh boolean,
    beneficio_tarjeta_ciudadana boolean,
    beneficio_pension_no_contributiva boolean,
    beneficio_jubilacion boolean,
    beneficio_cuota_alimentaria boolean,
    tipo_ocupacion integer
);


ALTER TABLE public.personas OWNER TO postgres;

--
-- Name: COLUMN personas.antecedente_violencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN personas.antecedente_violencia IS 'Si la persona ya ha tenido antecedentes de violencia';


--
-- Name: COLUMN personas.tipo_ocupacion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN personas.tipo_ocupacion IS 'TIpo de ocupación. 0: desocupado, 1:informal, 2 formal';


--
-- Name: seq_procedencias; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_procedencias
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_procedencias OWNER TO postgres;

--
-- Name: procedencias; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE procedencias (
    id integer DEFAULT nextval('seq_procedencias'::regclass) NOT NULL,
    nombre character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE public.procedencias OWNER TO postgres;

--
-- Name: profesionales_intervenciones; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE profesionales_intervenciones (
    id integer NOT NULL,
    intervencion_id integer NOT NULL,
    profesional_id integer NOT NULL,
    nada character(1)
);


ALTER TABLE public.profesionales_intervenciones OWNER TO postgres;

--
-- Name: profesionales_intervenciones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE profesionales_intervenciones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profesionales_intervenciones_id_seq OWNER TO postgres;

--
-- Name: profesionales_intervenciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE profesionales_intervenciones_id_seq OWNED BY profesionales_intervenciones.id;


--
-- Name: seq_provincias; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_provincias
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_provincias OWNER TO postgres;

--
-- Name: provincias; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE provincias (
    id integer DEFAULT nextval('seq_provincias'::regclass) NOT NULL,
    id_pais integer NOT NULL,
    nombre character varying(60) NOT NULL
);


ALTER TABLE public.provincias OWNER TO postgres;

--
-- Name: seq_relatos_observaciones; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_relatos_observaciones
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_relatos_observaciones OWNER TO postgres;

--
-- Name: relatos_observaciones; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE relatos_observaciones (
    id integer DEFAULT nextval('seq_relatos_observaciones'::regclass) NOT NULL,
    relato character varying(150) DEFAULT NULL::character varying,
    id_expediente integer
);


ALTER TABLE public.relatos_observaciones OWNER TO postgres;

--
-- Name: seq_resoluciones; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_resoluciones
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_resoluciones OWNER TO postgres;

--
-- Name: resoluciones; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE resoluciones (
    id integer DEFAULT nextval('seq_resoluciones'::regclass) NOT NULL,
    id_expediente integer NOT NULL,
    fecha character varying NOT NULL
);


ALTER TABLE public.resoluciones OWNER TO postgres;

--
-- Name: seq_resoluciones_relatos; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_resoluciones_relatos
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_resoluciones_relatos OWNER TO postgres;

--
-- Name: resoluciones_relatos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE resoluciones_relatos (
    id integer DEFAULT nextval('seq_resoluciones_relatos'::regclass) NOT NULL,
    id_resolucion integer,
    relato character varying(100) DEFAULT NULL::character varying
);


ALTER TABLE public.resoluciones_relatos OWNER TO postgres;

--
-- Name: seq_roles; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_roles
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_roles OWNER TO postgres;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE roles (
    id integer DEFAULT nextval('seq_roles'::regclass) NOT NULL,
    nombre character varying(30) DEFAULT NULL::character varying
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: seq_roles_vinculos; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_roles_vinculos
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_roles_vinculos OWNER TO postgres;

--
-- Name: roles_vinculos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE roles_vinculos (
    id integer DEFAULT nextval('seq_roles_vinculos'::regclass) NOT NULL,
    id_expediente integer,
    id_persona integer,
    id_rol integer,
    id_vinculo integer,
    edad integer,
    cantidad_hijos integer,
    observacion character varying,
    convive boolean DEFAULT false,
    antecedente_violencia boolean DEFAULT false,
    es_presentante boolean DEFAULT true NOT NULL,
    ocupacion character varying(50),
    otro_dato character varying(50)
);


ALTER TABLE public.roles_vinculos OWNER TO postgres;

--
-- Name: COLUMN roles_vinculos.ocupacion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN roles_vinculos.ocupacion IS 'puede ser referente a Escuela Trabajo Ocupación';


--
-- Name: COLUMN roles_vinculos.otro_dato; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN roles_vinculos.otro_dato IS 'redundancia de observaciones. En teoría es refernte a la ocupación';


--
-- Name: seq_tipos_casos; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_tipos_casos
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_tipos_casos OWNER TO postgres;

--
-- Name: seq_tipos_documentos; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_tipos_documentos
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_tipos_documentos OWNER TO postgres;

--
-- Name: seq_tipos_gestiones; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_tipos_gestiones
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_tipos_gestiones OWNER TO postgres;

--
-- Name: seq_tipos_intervenciones; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_tipos_intervenciones
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_tipos_intervenciones OWNER TO postgres;

--
-- Name: seq_tipos_oficios; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_tipos_oficios
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_tipos_oficios OWNER TO postgres;

--
-- Name: seq_tipos_violencias; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_tipos_violencias
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_tipos_violencias OWNER TO postgres;

--
-- Name: seq_vinculos; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_vinculos
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_vinculos OWNER TO postgres;

--
-- Name: tipos_casos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipos_casos (
    id integer DEFAULT nextval('seq_tipos_casos'::regclass) NOT NULL,
    id_ambito integer,
    nombre character varying(60)
);


ALTER TABLE public.tipos_casos OWNER TO postgres;

--
-- Name: tipos_documentos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipos_documentos (
    id integer DEFAULT nextval('seq_tipos_documentos'::regclass) NOT NULL,
    nombre character varying(20)
);


ALTER TABLE public.tipos_documentos OWNER TO postgres;

--
-- Name: tipos_gestiones; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipos_gestiones (
    id integer DEFAULT nextval('seq_tipos_gestiones'::regclass) NOT NULL,
    nombre character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE public.tipos_gestiones OWNER TO postgres;

--
-- Name: tipos_intervenciones; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipos_intervenciones (
    id integer DEFAULT nextval('seq_tipos_intervenciones'::regclass) NOT NULL,
    nombre character varying(80) DEFAULT NULL::character varying
);


ALTER TABLE public.tipos_intervenciones OWNER TO postgres;

--
-- Name: tipos_oficios; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipos_oficios (
    id integer DEFAULT nextval('seq_tipos_oficios'::regclass) NOT NULL,
    nombre character varying(30) DEFAULT NULL::character varying
);


ALTER TABLE public.tipos_oficios OWNER TO postgres;

--
-- Name: tipos_violencias; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipos_violencias (
    id integer DEFAULT nextval('seq_tipos_violencias'::regclass) NOT NULL,
    nombre character varying(30) DEFAULT NULL::character varying
);


ALTER TABLE public.tipos_violencias OWNER TO postgres;

--
-- Name: vinculos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE vinculos (
    id integer DEFAULT nextval('seq_vinculos'::regclass) NOT NULL,
    nombre character varying(30) DEFAULT NULL::character varying
);


ALTER TABLE public.vinculos OWNER TO postgres;

--
-- Name: vs_database_diagrams; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE vs_database_diagrams (
    name character varying(80),
    diadata text,
    comment character varying(1022),
    preview text,
    lockinfo character varying(80),
    locktime timestamp with time zone,
    version character varying(80)
);


ALTER TABLE public.vs_database_diagrams OWNER TO postgres;

--
-- Name: vw_personas_rol; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW vw_personas_rol AS
 SELECT rv.id_expediente,
    rv.id_persona,
    rv.id_rol,
    rv.id_vinculo,
    rv.edad,
    rv.cantidad_hijos,
    rv.convive,
    rv.antecedente_violencia,
    rv.es_presentante,
    p.id_genero,
    p.id_estado_civil,
    p.id_documento_tipo,
    p.id_pais_nacimiento,
    p.id_distrito,
    p.id_localidad,
    p.id_nivel_instruccion,
    p.id_barrio,
    p.documento_nro,
    p.apellido,
    p.nombre,
    p.fecha_nacimiento,
    p.lugar_nacimiento,
    p.nacionalidad,
    p.domicilio_real,
    p.propietario_inmueble,
    p.telefono,
    p.mail
   FROM (roles_vinculos rv
     LEFT JOIN personas p ON ((p.id = rv.id_persona)));


ALTER TABLE public.vw_personas_rol OWNER TO postgres;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY eventos ALTER COLUMN id SET DEFAULT nextval('eventos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY instituciones ALTER COLUMN id SET DEFAULT nextval('instituciones_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY intituciones_expediente ALTER COLUMN id SET DEFAULT nextval('intituciones_expediente_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oficios ALTER COLUMN id SET DEFAULT nextval('oficios_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oficios_recibidos ALTER COLUMN id SET DEFAULT nextval('oficios_recibidos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY profesionales_intervenciones ALTER COLUMN id SET DEFAULT nextval('profesionales_intervenciones_id_seq'::regclass);


--
-- Data for Name: ambitos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ambitos (id, nombre) FROM stdin;
1	Institucional
2	Familiar
3	Comunitario
\.


--
-- Data for Name: barrios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY barrios (id, nombre, id_localidad) FROM stdin;
1	Centro	1273
2	Centro	2518
3	República Del Oeste	2518
4	Plaza España	2518
5	Mariano Comas	2518
6	Candioti Sur	2518
7	Candioti Norte	2518
8	Siete Jefes	2518
9	Alberdi	2518
10	B° Chaqueño	2518
11	Coronel Dorrego	2518
12	Fomento 9 de Julio	2518
13	Guadalupe Este	2518
14	Jardin Mayoraz	2518
15	San Roque	2518
16	Villa Setubal	2518
17	Amante Melgarejo o La Lona	2518
18	Belgrano	2518
19	Facundo Quiroga	2518
20	General Alvear	2518
21	Guadalupe Oeste	2518
22	Maria Selva	2518
23	Villa Dora	2518
24	Transporte	2518
25	Esmeralda Sur (PARTE)	2518
26	7 Jefes (PARTE)	2518
27	Colastiné Norte	2518
28	El Pozo	2518
29	La Guardia - Colastiné	2518
30	Vuelta del Paraguayo	2518
31	Colastiné Sur	2518
32	La Boca - Alto Verde	2518
33	Pro - Mejoras Alto Verde 	2518
34	Bajada Distefano	2518
35	Las Américas	2518
36	Peñaloza Norte	2518
37	Cabaña Leiva	2518
38	Liceo Norte	2518
39	Nueva Pompeya	2518
40	Policial	2518
41	San José	2518
42	Santa Rita	2518
43	Altos de Noguera	2518
44	El Bergel	2518
45	Las Flores I	2518
46	Las Flores II	2518
47	Los Ángeles	2518
48	Progreso Pompeya Oeste	2518
49	San Martín	2518
50	Villa las Flores	2518
51	Belgrano Oeste	2518
52	Punta Norte	2518
53	René Favaloro	2518
54	29 De Abril II	2518
55	29 De Abril III	2518
56	Guadalupe Noreste	2518
57	La Esmeralda	2518
58	Altos del Valle	2518
59	Esmeralda Norte	2518
60	Judiciales	2518
61	Las Delicias	2518
62	Amsafe-Amdip	2518
63	Esmeralda Este	2518
64	Universitario	2518
65	Nueva Santa Fe	2518
66	Los Cipreses	2518
67	Gremios Solidarios	2518
68	Ledesco I	2518
69	Ledesco II	2518
70	Bobbio	2518
71	El abasto	2518
72	Escarafía	2518
73	Eva Perón	2518
74	La Tablada	2518
75	Estanislao López	2518
76	Los Troncos	2518
77	Norte Unido	2518
78	San Agustín I	2518
79	San Agustín II	2518
80	Santa Marta	2518
81	Sarmiento	2518
82	Yapeyú	2518
83	Acería	2518
84	Cabal	2518
85	Del Tránsito	2518
86	Las Lomas	2518
87	Loyola	2518
88	Santo Domingo	2518
89	Villa Teresa	2518
90	Zaspe	2518
91	Barranquitas Oeste	2518
92	Ciudadela Norte	2518
93	Pro - Adelanto Barranquitas	2518
94	República Los Hornos	2518
95	Schneider	2518
96	Barranquitas Sur	2518
97	Piquete y Las Flores	2518
98	San Pantaleón	2518
99	Unión y Progreso y Lib. Barr.	2518
100	Villa del Parque	2518
101	Villa Oculta	2518
102	Villa Hipódromo	2518
103	Don Bosco	2518
104	Ciudadela	2518
105	Escalante	2518
106	12 de Octubre	2518
107	Arenales	2518
108	General Mosconi	2518
109	Roma	2518
110	San Jerónimo	2518
111	Solidaridad y Progreso S.L.	2518
112	Centenario	2518
113	Chalet	2518
114	Estrada	2518
115	Parque Juan de Garay	2518
116	Parque Saenz Peña	2518
117	Santa Rosa de Lima	2518
118	Varadero Sarsotti 	2518
\.


--
-- Data for Name: clasificadores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY clasificadores (id, id_ambito, id_tipo1, id_tipo2, id_tipo3, violencia, id_tipov1, id_tipov2, id_tipov3) FROM stdin;
\.


--
-- Data for Name: cod_postales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cod_postales (id_localidad, codigo_postal) FROM stdin;
\.


--
-- Data for Name: continentes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY continentes (id, nombre) FROM stdin;
AF	África
AM	América
AS	Asia
EU	Europa
OC	Oceanía
\.


--
-- Data for Name: distritos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY distritos (id, nombre, id_localidad) FROM stdin;
1	Distrito centro	1273
3	Distrito Noroeste	2518
4	Distrito Oeste	2518
5	Distrito Suroeste	2518
6	Distrito La Costa	2518
7	Distrito Norte	2518
8	Distrito Noreste	2518
2	Distrito Centro	2518
9	Distrito Este	2518
\.


--
-- Data for Name: documentos_tipos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY documentos_tipos (id, nombre, "Descipcion") FROM stdin;
1	DU	Documento Unico
2	DNI	Documento Nacional de Identidad
3	LE	Libreta de Enrolamiento
4	LC	Libreta Cívica
5	Pasaporte	Pasaporte
6	CI	Cédula de Identidad
\.


--
-- Data for Name: dptos_partidos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY dptos_partidos (id, nombre, id_provincia, estado) FROM stdin;
102998	Indeterminado	102	A
104998	Indeterminado	104	A
105998	Indeterminado	105	A
107998	Indeterminado	107	A
108998	Indeterminado	108	A
110998	Indeterminado	110	A
111998	Indeterminado	111	A
113998	Indeterminado	113	A
114998	Indeterminado	114	A
116998	Indeterminado	116	A
117998	Indeterminado	117	A
119998	Indeterminado	119	A
120998	Indeterminado	120	A
122998	Indeterminado	122	A
123998	Indeterminado	123	A
125998	Indeterminado	125	A
126998	Indeterminado	126	A
128998	Indeterminado	128	A
129998	Indeterminado	129	A
131998	Indeterminado	131	A
132998	Indeterminado	132	A
134998	Indeterminado	134	A
135998	Indeterminado	135	A
137998	Indeterminado	137	A
138998	Indeterminado	138	A
140998	Indeterminado	140	A
141998	Indeterminado	141	A
143998	Indeterminado	143	A
144998	Indeterminado	144	A
146998	Indeterminado	146	A
147998	Indeterminado	147	A
149998	Indeterminado	149	A
150998	Indeterminado	150	A
152998	Indeterminado	152	A
153998	Indeterminado	153	A
155998	Indeterminado	155	A
156998	Indeterminado	156	A
158998	Indeterminado	158	A
159998	Indeterminado	159	A
161998	Indeterminado	161	A
162998	Indeterminado	162	A
164998	Indeterminado	164	A
165998	Indeterminado	165	A
167998	Indeterminado	167	A
168998	Indeterminado	168	A
170998	Indeterminado	170	A
171998	Indeterminado	171	A
173998	Indeterminado	173	A
174998	Indeterminado	174	A
176998	Indeterminado	176	A
180998	Indeterminado	180	A
149001	Albany	149	A
149005	Allegany	149	A
149009	Bronx	149	A
149013	Broome	149	A
149017	Cattaraugus	149	A
149021	Cayuga	149	A
149025	Chautauqua	149	A
149029	Chemung	149	A
149033	Chenango	149	A
149037	Clinton	149	A
149041	Columbia	149	A
149045	Cortland	149	A
149049	Delaware	149	A
149053	Dutchess	149	A
149057	Erie	149	A
149061	Essex	149	A
149065	Franklin	149	A
149069	Fulton	149	A
149073	Genesee	149	A
149077	Greene	149	A
149081	Hamilton	149	A
149085	Herkimer	149	A
149089	Jefferson	149	A
149093	Kings	149	A
149097	Lewis	149	A
149101	Livingston	149	A
149105	Madison	149	A
149109	Monroe	149	A
149113	Montgomery	149	A
149117	Nassau	149	A
149121	New York	149	A
149125	Niagara	149	A
149129	Oneida	149	A
149133	Onondaga	149	A
149137	Ontario	149	A
149141	Orange	149	A
149145	Orleans	149	A
149149	Oswego	149	A
149153	Otsego	149	A
149157	Putnam	149	A
149161	Queens	149	A
149165	Rensselaer	149	A
149169	Richmond	149	A
149173	Rockland	149	A
149177	St. Lawrence	149	A
149181	Saratoga	149	A
149185	Schenectady	149	A
149189	Schoharie	149	A
149193	Schuyler	149	A
149197	Seneca	149	A
149201	Steuben	149	A
149205	Suffolk	149	A
149209	Sullivan	149	A
149213	Tioga	149	A
149217	Tompkins	149	A
149221	Ulster	149	A
149225	Warren	149	A
149229	Washington	149	A
149233	Wayne	149	A
149237	Westchester	149	A
149241	Wyoming	149	A
149245	Yates	149	A
108001	Alameda	108	A
108003	Alpine	108	A
108005	Amador	108	A
108007	Butte	108	A
108009	Calaveras	108	A
108011	Colusa	108	A
108013	Contra Costa	108	A
108015	Del Norte	108	A
108017	El Dorado	108	A
108019	Fresno	108	A
108021	Glenn	108	A
108023	Humboldt	108	A
108025	Imperial	108	A
108027	Inyo	108	A
108029	Kern	108	A
108031	Kings	108	A
108033	Lake	108	A
108035	Lassen	108	A
108037	Los Angeles	108	A
108039	Madera	108	A
108041	Marin	108	A
108043	Mariposa	108	A
108045	Mendocino	108	A
108047	Merced	108	A
108049	Modoc	108	A
108051	Mono	108	A
108053	Monterey	108	A
108055	Napa	108	A
108057	Nevada	108	A
108059	Orange	108	A
108061	Placer	108	A
108063	Plumas	108	A
108065	Riverside	108	A
108067	Sacramento	108	A
108069	San Benito	108	A
108071	San Bernardino	108	A
108073	San Diego	108	A
108075	San Francisco	108	A
108077	San Joaquin	108	A
108079	San Luis Obispo	108	A
108081	San Mateo	108	A
108083	Santa Barbara	108	A
108085	Santa Clara	108	A
108087	Santa Cruz	108	A
108089	Shasta	108	A
108091	Sierra	108	A
108093	Siskiyou	108	A
108095	Solano	108	A
108097	Sonoma	108	A
108099	Stanislaus	108	A
108101	Sutter	108	A
108103	Tehama	108	A
108105	Trinity	108	A
108107	Tulare	108	A
108109	Tuolumne	108	A
108111	Ventura	108	A
108113	Yolo	108	A
108115	Yuba	108	A
114001	Alachua	114	A
114003	Baker	114	A
114005	Bay	114	A
114007	Bradford	114	A
114009	Brevard	114	A
114011	Broward	114	A
114013	Calhoun	114	A
114015	Charlotte	114	A
114017	Citrus	114	A
114019	Clay	114	A
114021	Collier	114	A
114023	Columbia	114	A
114027	DeSoto	114	A
114029	Dixie	114	A
114031	Duval	114	A
114033	Escambia	114	A
114035	Flagler	114	A
114037	Franklin	114	A
114039	Gadsden	114	A
114041	Gilchrist	114	A
114043	Glades	114	A
114045	Gulf	114	A
114047	Hamilton	114	A
114049	Hardee	114	A
114051	Hendry	114	A
114053	Hernando	114	A
114055	Highlands	114	A
114057	Hillsborough	114	A
114059	Holmes	114	A
114061	Indian River	114	A
114063	Jackson	114	A
114065	Jefferson	114	A
114067	Lafayette	114	A
114069	Lake	114	A
114071	Lee	114	A
114073	Leon	114	A
114075	Levy	114	A
114077	Liberty	114	A
114079	Madison	114	A
114081	Manatee	114	A
114083	Marion	114	A
114085	Martin	114	A
114086	Miami-Dade	114	A
114087	Monroe	114	A
114089	Nassau	114	A
114091	Okaloosa	114	A
114093	Okeechobee	114	A
114095	Orange	114	A
114097	Osceola	114	A
114099	Palm Beach	114	A
114101	Pasco	114	A
114103	Pinellas	114	A
114105	Polk	114	A
114107	Putnam	114	A
114109	Saint Johns	114	A
114111	Saint Lucie	114	A
114113	Santa Rosa	114	A
114115	Sarasota	114	A
114117	Seminole	114	A
114119	Sumter	114	A
114121	Suwannee	114	A
114123	Taylor	114	A
114125	Union	114	A
114127	Volusia	114	A
114129	Wakulla	114	A
114131	Walton	114	A
114133	Washington	114	A
165001	Anderson	165	A
165002	Andrews	165	A
165003	Angelina	165	A
165004	Aransas	165	A
165005	Archer	165	A
165006	Armstrong	165	A
165007	Atascosa	165	A
165008	Austin	165	A
165009	Bailey	165	A
165010	Bandera	165	A
165011	Bastrop	165	A
165012	Baylor	165	A
165013	Bee	165	A
165014	Bell	165	A
165015	Bexar	165	A
165016	Blanco	165	A
165017	Borden	165	A
165018	Bosque	165	A
165019	Bowie	165	A
165020	Brazoria	165	A
165021	Brazos	165	A
165022	Brewster	165	A
165023	Briscoe	165	A
165024	Brooks	165	A
165025	Brown	165	A
165026	Burleson	165	A
165027	Burnet	165	A
165028	Caldwell	165	A
165029	Calhoun	165	A
165030	Callahan	165	A
165031	Cameron	165	A
165032	Camp	165	A
165033	Carson	165	A
165034	Cass	165	A
165035	Castro	165	A
165036	Chambers	165	A
165037	Cherokee	165	A
165038	Childress	165	A
165039	Clay	165	A
165040	Cochran	165	A
165041	Coke	165	A
165042	Coleman	165	A
165043	Collin	165	A
165044	Collingsworth	165	A
165045	Colorado	165	A
165046	Comal	165	A
165047	Comanche	165	A
165048	Concho	165	A
165049	Cooke	165	A
165050	Coryell	165	A
165051	Cottle	165	A
165052	Crane	165	A
165053	Crockett	165	A
165054	Crosby	165	A
165055	Culberson	165	A
165056	Dallam	165	A
165057	Dallas	165	A
165058	Dawson	165	A
165059	Deaf Smith	165	A
165060	Delta	165	A
165061	Denton	165	A
165062	DeWitt	165	A
165063	Dickens	165	A
165064	Dimmit	165	A
165065	Donley	165	A
165066	Duval	165	A
165067	Eastland	165	A
165068	Ector	165	A
165069	Edwards	165	A
165070	El Paso	165	A
165071	Ellis	165	A
165072	Erath	165	A
165073	Falls	165	A
165074	Fannin	165	A
165075	Fayette	165	A
165076	Fisher	165	A
165077	Floyd	165	A
165078	Foard	165	A
165079	Fort Bend	165	A
165080	Franklin	165	A
165081	Freestone	165	A
165082	Frio	165	A
165083	Gaines	165	A
165084	Galveston	165	A
165085	Garza	165	A
165086	Gillespie	165	A
165087	Glasscock	165	A
165088	Goliad	165	A
165089	Gonzales	165	A
165090	Gray	165	A
165091	Grayson	165	A
165092	Gregg	165	A
165093	Grimes	165	A
165094	Guadalupe	165	A
165095	Hale	165	A
165096	Hall	165	A
165097	Hamilton	165	A
165098	Hansford	165	A
165099	Hardeman	165	A
165100	Hardin	165	A
165101	Harris	165	A
165102	Harrison	165	A
165103	Hartley	165	A
165104	Haskell	165	A
165105	Hays	165	A
165106	Hemphill	165	A
165107	Henderson	165	A
165108	Hidalgo	165	A
165109	Hill	165	A
165110	Hockley	165	A
165111	Hood	165	A
165112	Hopkins	165	A
165113	Houston	165	A
165114	Howard	165	A
165115	Hudspeth	165	A
165116	Hunt	165	A
165117	Hutchinson	165	A
165118	Irion	165	A
165119	Jack	165	A
165120	Jackson	165	A
165121	Jasper	165	A
165122	Jeff Davis	165	A
165123	Jefferson	165	A
165124	Jim Hogg	165	A
165125	Jim Wells	165	A
165126	Johnson	165	A
165127	Jones	165	A
165128	Karnes	165	A
165129	Kaufman	165	A
165130	Kendall	165	A
165131	Kenedy	165	A
165132	Kent	165	A
165133	Kerr	165	A
165134	Kimble	165	A
165135	King	165	A
165136	Kinney	165	A
165137	Kleberg	165	A
165138	Knox	165	A
165139	La Salle	165	A
165140	Lamar	165	A
165141	Lamb	165	A
165142	Lampasas	165	A
165143	Lavaca	165	A
165144	Lee	165	A
165145	Leon	165	A
165146	Liberty	165	A
165147	Limestone	165	A
165148	Lipscomb	165	A
165149	Live Oak	165	A
165150	Llano	165	A
165151	Loving	165	A
165152	Lubbock	165	A
165153	Lynn	165	A
165154	Madison	165	A
165155	Marion	165	A
165156	Martin	165	A
165157	Mason	165	A
165158	Matagorda	165	A
165159	Maverick	165	A
165160	McCulloch	165	A
165161	McLennan	165	A
165162	McMullen	165	A
165163	Medina	165	A
165164	Menard	165	A
165165	Midland	165	A
165166	Milam	165	A
165167	Mills	165	A
165168	Mitchell	165	A
165169	Montague	165	A
165170	Montgomery	165	A
165171	Moore	165	A
165172	Morris	165	A
165173	Motley	165	A
165174	Nacogdoches	165	A
165175	Navarro	165	A
165176	Newton	165	A
165177	Nolan	165	A
165178	Nueces	165	A
165179	Ochiltree	165	A
165180	Oldham	165	A
165181	Orange	165	A
165182	Palo Pinto	165	A
165183	Panola	165	A
165184	Parker	165	A
165185	Parmer	165	A
165186	Pecos	165	A
165187	Polk	165	A
165188	Potter	165	A
165189	Presidio	165	A
165190	Rains	165	A
165191	Randall	165	A
165192	Reagan	165	A
165193	Real	165	A
165194	Red River	165	A
165195	Reeves	165	A
165196	Refugio	165	A
165197	Roberts	165	A
165198	Robertson	165	A
165199	Rockwall	165	A
165200	Runnels	165	A
165201	Rusk	165	A
165202	Sabine	165	A
165203	San Augustine	165	A
165204	San Jacinto	165	A
165205	San Patricio	165	A
165206	San Saba	165	A
165207	Schleicher	165	A
165208	Scurry	165	A
165209	Shackelford	165	A
165210	Shelby	165	A
165211	Sherman	165	A
165212	Smith	165	A
165213	Somervell	165	A
165214	Starr	165	A
165215	Stephens	165	A
165216	Sterling	165	A
165217	Stonewall	165	A
165218	Sutton	165	A
165219	Swisher	165	A
165220	Tarrant	165	A
165221	Taylor	165	A
165222	Terrell	165	A
165223	Terry	165	A
165224	Throckmorton	165	A
165225	Titus	165	A
165226	Tom Green	165	A
165227	Travis	165	A
165228	Trinity	165	A
165229	Tyler	165	A
165230	Upshur	165	A
165231	Upton	165	A
165232	Uvalde	165	A
165233	Val Verde	165	A
165234	Van Zandt	165	A
165235	Victoria	165	A
165236	Walker	165	A
165237	Waller	165	A
165238	Ward	165	A
165239	Washington	165	A
165240	Webb	165	A
165241	Wharton	165	A
165242	Wheeler	165	A
165243	Wichita	165	A
165244	Wilbarger	165	A
165245	Willacy	165	A
165246	Williamson	165	A
165247	Wilson	165	A
165248	Winkler	165	A
165249	Wise	165	A
165250	Wood	165	A
165251	Yoakum	165	A
165252	Young	165	A
165253	Zapata	165	A
165254	Zavala	165	A
132001	Barnstable	132	A
132003	Berkshire	132	A
132005	Bristol	132	A
132007	Dukes	132	A
132009	Essex	132	A
132011	Franklin	132	A
132013	Hampden	132	A
132015	Hampshire	132	A
132017	Middlesex	132	A
132019	Nantucket	132	A
132021	Norfolk	132	A
132023	Plymouth	132	A
132025	Suffolk	132	A
132027	Worcester	132	A
120001	Adams	120	A
120003	Alexander	120	A
120005	Bond	120	A
120007	Boone	120	A
120009	Brown	120	A
120011	Bureau	120	A
120013	Calhoun	120	A
120015	Carroll	120	A
120017	Cass	120	A
120019	Champaign	120	A
120021	Christian	120	A
120023	Clark	120	A
120025	Clay	120	A
120027	Clinton	120	A
120029	Coles	120	A
120031	Cook	120	A
120033	Crawford	120	A
120035	Cumberland	120	A
120039	De Witt	120	A
120037	De Kalb	120	A
120041	Douglas	120	A
120043	Du Page	120	A
120045	Edgar	120	A
120047	Edwards	120	A
120049	Effingham	120	A
120051	Fayette	120	A
120053	Ford	120	A
120055	Franklin	120	A
120057	Fulton	120	A
120059	Gallatin	120	A
120061	Greene	120	A
120063	Grundy	120	A
120065	Hamilton	120	A
120067	Hancock	120	A
120069	Hardin	120	A
120071	Henderson	120	A
120073	Henry	120	A
120075	Iroquois	120	A
120077	Jackson	120	A
120079	Jasper	120	A
120081	Jefferson	120	A
120083	Jersey	120	A
120085	Jo Daviess	120	A
120087	Johnson	120	A
120089	Kane	120	A
120091	Kankakee	120	A
120093	Kendall	120	A
120095	Knox	120	A
120097	Lake	120	A
120099	La Salle	120	A
120101	Lawrence	120	A
120103	Lee	120	A
120105	Livingston	120	A
120107	Logan	120	A
120115	Macon	120	A
120117	Macoupin	120	A
120119	Madison	120	A
120121	Marion	120	A
120123	Marshall	120	A
120125	Mason	120	A
120127	Massac	120	A
120109	McDonough	120	A
120111	McHenry	120	A
120113	McLean	120	A
120129	Menard	120	A
120131	Mercer	120	A
120133	Monroe	120	A
120135	Montgomery	120	A
120137	Morgan	120	A
120139	Moultrie	120	A
120141	Ogle	120	A
120143	Peoria	120	A
120145	Perry	120	A
120147	Piatt	120	A
120149	Pike	120	A
120151	Pope	120	A
120153	Pulaski	120	A
120155	Putnam	120	A
120157	Randolph	120	A
120159	Richland	120	A
120161	Rock Island	120	A
120165	Saline	120	A
120167	Sangamon	120	A
120169	Schuyler	120	A
120171	Scott	120	A
120173	Shelby	120	A
120163	St. Clair	120	A
120175	Stark	120	A
120177	Stephenson	120	A
120179	Tazewell	120	A
120181	Union	120	A
120183	Vermilion	120	A
120185	Wabash	120	A
120187	Warren	120	A
120189	Washington	120	A
120191	Wayne	120	A
120193	White	120	A
120195	Whiteside	120	A
120197	Will	120	A
120199	Williamson	120	A
120201	Winnebago	120	A
120203	Woodford	120	A
158001	Adams	158	A
158003	Allegheny	158	A
158005	Armstrong	158	A
158007	Beaver	158	A
158009	Bedford	158	A
158011	Berks	158	A
158013	Blair	158	A
158015	Bradford	158	A
158017	Bucks	158	A
158019	Butler	158	A
158021	Cambria	158	A
158023	Cameron	158	A
158025	Carbon	158	A
158027	Centre	158	A
158029	Chester	158	A
158031	Clarion	158	A
158033	Clearfield	158	A
158035	Clinton	158	A
158037	Columbia	158	A
158039	Crawford	158	A
158041	Cumberland	158	A
158043	Dauphin	158	A
158045	Delaware	158	A
158047	Elk	158	A
158049	Erie	158	A
158051	Fayette	158	A
158053	Forest	158	A
158055	Franklin	158	A
158059	Greene	158	A
158061	Huntingdon	158	A
158063	Indiana	158	A
158065	Jefferson	158	A
158067	Juniata	158	A
158069	Lackawanna	158	A
158071	Lancaster	158	A
158073	Lawrence	158	A
158075	Lebanon	158	A
158077	Lehigh	158	A
158079	Luzerne	158	A
158081	Lycoming	158	A
158083	McKean	158	A
158085	Mercer	158	A
158087	Mifflin	158	A
158089	Monroe	158	A
158091	Montgomery	158	A
158093	Montour	158	A
158095	Northampton	158	A
158097	Northumberland	158	A
158099	Perry	158	A
158101	Filadelfia	158	A
158103	Pike	158	A
158105	Potter	158	A
158107	Schuylkill	158	A
158109	Snyder	158	A
158111	Somerset	158	A
158113	Sullivan	158	A
158115	Susquehanna	158	A
158117	Tioga	158	A
158119	Union	158	A
158121	Venango	158	A
158123	Warren	158	A
158125	Washington	158	A
158127	Wayne	158	A
158129	Westmoreland	158	A
158131	Wyoming	158	A
158133	York	158	A
146001	Atlantic	146	A
146003	Bergen	146	A
146005	Burlington	146	A
146007	Camden	146	A
146009	Cape May	146	A
146011	Cumberland	146	A
146013	Essex	146	A
146015	Gloucester	146	A
146017	Hudson	146	A
146019	Hunterdon	146	A
146021	Mercer	146	A
146023	Middlesex	146	A
146025	Monmouth	146	A
146027	Morris	146	A
146029	Ocean	146	A
146031	Passaic	146	A
146033	Salem	146	A
146035	Somerset	146	A
146037	Sussex	146	A
146039	Union	146	A
146041	Warren	146	A
111001	Fairfield	111	A
111003	Hartford	111	A
111005	Litchfield	111	A
111007	Middlesex	111	A
111009	New Haven	111	A
111011	New London	111	A
111013	Tolland	111	A
111015	Windham	111	A
159001	Bristol	159	A
159003	Kent	159	A
159005	Newport	159	A
159007	Providence	159	A
159009	Washington	159	A
131001	Allegany	131	A
131003	Anne Arundel	131	A
131005	Baltimore	131	A
131510	Baltimore City 	131	A
131009	Calvert	131	A
131011	Caroline	131	A
131013	Carroll	131	A
131015	Cecil	131	A
131017	Charles	131	A
131019	Dorchester	131	A
131021	Frederick	131	A
131023	Garrett	131	A
131025	Harford	131	A
131027	Howard	131	A
131029	Kent	131	A
131031	Montgomery	131	A
131033	Prince George	131	A
131035	Queen Anne	131	A
131037	Saint Mary	131	A
131039	Somerset	131	A
131041	Talbot	131	A
131043	Washington	131	A
131045	Wicomico	131	A
131047	Worcester	131	A
153001	Adams	153	A
153003	Allen	153	A
153005	Ashland	153	A
153007	Ashtabula	153	A
153009	Athens	153	A
153011	Auglaize	153	A
153013	Belmont	153	A
153015	Brown	153	A
153017	Butler	153	A
153019	Carroll	153	A
153021	Champaign	153	A
153023	Clark	153	A
153025	Clermont	153	A
153027	Clinton	153	A
153029	Columbiana	153	A
153031	Coshocton	153	A
153033	Crawford	153	A
153035	Cuyahoga	153	A
153037	Darke	153	A
153039	Defiance	153	A
153041	Delaware	153	A
153043	Erie	153	A
153045	Fairfield	153	A
153047	Fayette	153	A
153049	Franklin	153	A
153051	Fulton	153	A
153053	Gallia	153	A
153055	Geauga	153	A
153057	Greene	153	A
153059	Guernsey	153	A
153061	Hamilton	153	A
153063	Hancock	153	A
153065	Hardin	153	A
153067	Harrison	153	A
153069	Henry	153	A
153071	Highland	153	A
153073	Hocking	153	A
153075	Holmes	153	A
153077	Huron	153	A
153079	Jackson	153	A
153081	Jefferson	153	A
153083	Knox	153	A
153085	Lake	153	A
153087	Lawrence	153	A
153089	Licking	153	A
153091	Logan	153	A
153093	Lorain	153	A
153095	Lucas	153	A
153097	Madison	153	A
153099	Mahoning	153	A
153101	Marion	153	A
153103	Medina	153	A
153105	Meigs	153	A
153107	Mercer	153	A
153109	Miami	153	A
153111	Monroe	153	A
153113	Montgomery	153	A
153115	Morgan	153	A
153117	Morrow	153	A
153119	Muskingum	153	A
153121	Noble	153	A
153123	Ottawa	153	A
153125	Paulding	153	A
153127	Perry	153	A
153129	Pickaway	153	A
153131	Pike	153	A
153133	Portage	153	A
153135	Preble	153	A
153137	Putnam	153	A
153139	Richland	153	A
153141	Ross	153	A
153143	Sandusky	153	A
153145	Scioto	153	A
153147	Seneca	153	A
153149	Shelby	153	A
153151	Stark	153	A
153153	Summit	153	A
153155	Trumbull	153	A
153157	Tuscarawas	153	A
153159	Union	153	A
153161	Van Wert	153	A
153163	Vinton	153	A
153165	Warren	153	A
153167	Washington	153	A
153169	Wayne	153	A
153171	Williams	153	A
153173	Wood	153	A
153175	Wyandot	153	A
170001	Accomack	170	A
170003	Albemarle	170	A
170005	Alleghany	170	A
170007	Amelia	170	A
170009	Amherst	170	A
170011	Appomattox	170	A
170013	Arlington	170	A
170015	Augusta	170	A
170017	Bath	170	A
170019	Bedford	170	A
170021	Bland	170	A
170023	Botetourt	170	A
170025	Brunswick	170	A
170027	Buchanan	170	A
170029	Buckingham	170	A
170031	Campbell	170	A
170033	Caroline	170	A
170035	Carroll	170	A
170036	Charles City	170	A
170037	Charlotte	170	A
170041	Chesterfield	170	A
170043	Clarke	170	A
170045	Craig	170	A
170047	Culpeper	170	A
170049	Cumberland	170	A
170051	Dickenson	170	A
170053	Dinwiddie	170	A
170057	Essex	170	A
170059	Fairfax	170	A
170061	Fauquier	170	A
170063	Floyd	170	A
170065	Fluvanna	170	A
170067	Franklin	170	A
170069	Frederick	170	A
170071	Giles	170	A
170073	Gloucester	170	A
170075	Goochland	170	A
170077	Grayson	170	A
170079	Greene	170	A
170081	Greensville	170	A
170083	Halifax	170	A
170085	Hanover	170	A
170087	Henrico	170	A
170089	Henry	170	A
170091	Highland	170	A
170093	Isle of Wight	170	A
170095	James City	170	A
170097	King and Queen	170	A
170099	King George	170	A
170101	King William	170	A
170103	Lancaster	170	A
170105	Lee	170	A
170107	Loudoun	170	A
170109	Louisa	170	A
170111	Lunenburg	170	A
170113	Madison	170	A
170115	Mathews	170	A
170117	Mecklenburg	170	A
170119	Middlesex	170	A
170121	Montgomery	170	A
170125	Nelson	170	A
170127	New Kent	170	A
170131	Northampton	170	A
170133	Northumberland	170	A
170135	Nottoway	170	A
170137	Orange	170	A
170139	Page	170	A
170141	Patrick	170	A
170143	Pittsylvania	170	A
170145	Powhatan	170	A
170147	Prince Edward	170	A
170149	Prince George	170	A
170153	Prince William	170	A
170155	Pulaski	170	A
170157	Rappahannock	170	A
170159	Richmond	170	A
170161	Roanoke	170	A
170163	Rockbridge	170	A
170165	Rockingham	170	A
170167	Russell	170	A
170169	Scott	170	A
170171	Shenandoah	170	A
170173	Smyth	170	A
170175	Southampton	170	A
170177	Spotsylvania	170	A
170179	Stafford	170	A
170181	Surry	170	A
170183	Sussex	170	A
170185	Tazewell	170	A
170187	Warren	170	A
170191	Washington	170	A
170193	Westmoreland	170	A
170195	Wise	170	A
170197	Wythe	170	A
170199	York	170	A
170510	Alexandria	170	A
170515	Bedford	170	A
170520	Bristol	170	A
170530	Buena Vista	170	A
170540	Charlottesville	170	A
170550	Chesapeake	170	A
170570	Colonial Heights	170	A
170580	Covington	170	A
170590	Danville	170	A
170595	Emporia	170	A
170600	Fairfax	170	A
170610	Falls Church	170	A
170620	Franklin	170	A
170630	Fredericksburg	170	A
170640	Galax	170	A
170650	Hampton	170	A
170660	Harrisonburg	170	A
170670	Hopewell	170	A
170678	Lexington	170	A
170680	Lynchburg	170	A
170683	Manassas	170	A
170685	Manassas Park	170	A
170690	Martinsville	170	A
170700	Newport News	170	A
170710	Norfolk	170	A
170720	Norton	170	A
170730	Petersburg	170	A
170735	Poquoson	170	A
170740	Portsmouth	170	A
170750	Radford	170	A
170760	Richmond	170	A
170770	Roanoke	170	A
170775	Salem	170	A
170790	Staunton	170	A
170800	Suffolk	170	A
170810	Virginia Beach	170	A
170820	Waynesboro	170	A
170830	Williamsburg	170	A
170840	Winchester	170	A
116001	Appling	116	A
116003	Atkinson	116	A
116005	Bacon	116	A
116007	Baker	116	A
116009	Baldwin	116	A
116011	Banks	116	A
116013	Barrow	116	A
116015	Bartow	116	A
116017	Ben Hill	116	A
116019	Berrien	116	A
116021	Bibb	116	A
116023	Bleckley	116	A
116025	Brantley	116	A
116027	Brooks	116	A
116029	Bryan	116	A
116031	Bulloch	116	A
116033	Burke	116	A
116035	Butts	116	A
116037	Calhoun	116	A
116039	Camden	116	A
116043	Candler	116	A
116045	Carroll	116	A
116047	Catoosa	116	A
116049	Charlton	116	A
116051	Chatham	116	A
116053	Chattahoochee	116	A
116055	Chattooga	116	A
116057	Cherokee	116	A
116059	Clarke	116	A
116061	Clay	116	A
116063	Clayton	116	A
116065	Clinch	116	A
116067	Cobb	116	A
116069	Coffee	116	A
116071	Colquitt	116	A
116073	Columbia	116	A
116075	Cook	116	A
116077	Coweta	116	A
116079	Crawford	116	A
116081	Crisp	116	A
116083	Dade	116	A
116085	Dawson	116	A
116087	Decatur	116	A
116089	De Kalb	116	A
116091	Dodge	116	A
116093	Dooly	116	A
116095	Dougherty	116	A
116097	Douglas	116	A
116099	Early	116	A
116101	Echols	116	A
116103	Effingham	116	A
116105	Elbert	116	A
116107	Emanuel	116	A
116109	Evans	116	A
116111	Fannin	116	A
116113	Fayette	116	A
116115	Floyd	116	A
116117	Forsyth	116	A
116119	Franklin	116	A
116121	Fulton	116	A
116123	Gilmer	116	A
116125	Glascock	116	A
116127	Glynn	116	A
116129	Gordon	116	A
116131	Grady	116	A
116133	Greene	116	A
116135	Gwinnett	116	A
116137	Habersham	116	A
116139	Hall	116	A
116141	Hancock	116	A
116143	Haralson	116	A
116145	Harris	116	A
116147	Hart	116	A
116149	Heard	116	A
116151	Henry	116	A
116153	Houston	116	A
116155	Irwin	116	A
116157	Jackson	116	A
116159	Jasper	116	A
116161	Jeff Davis	116	A
116163	Jefferson	116	A
116165	Jenkins	116	A
116167	Johnson	116	A
116169	Jones	116	A
116171	Lamar	116	A
116173	Lanier	116	A
116175	Laurens	116	A
116177	Lee	116	A
116179	Liberty	116	A
116181	Lincoln	116	A
116183	Long	116	A
116185	Lowndes	116	A
116187	Lumpkin	116	A
116193	Macon	116	A
116195	Madison	116	A
116197	Marion	116	A
116189	McDuffie	116	A
116191	McIntosh	116	A
116199	Meriwether	116	A
116201	Miller	116	A
116205	Mitchell	116	A
116207	Monroe	116	A
116209	Montgomery	116	A
116211	Morgan	116	A
116213	Murray	116	A
116215	Muscogee	116	A
116217	Newton	116	A
116219	Oconee	116	A
116221	Oglethorpe	116	A
116223	Paulding	116	A
116225	Peach	116	A
116227	Pickens	116	A
116229	Pierce	116	A
116231	Pike	116	A
116233	Polk	116	A
116235	Pulaski	116	A
116237	Putnam	116	A
116239	Quitman	116	A
116241	Rabun	116	A
116243	Randolph	116	A
116245	Richmond	116	A
116247	Rockdale	116	A
116249	Schley	116	A
116251	Screven	116	A
116253	Seminole	116	A
116255	Spalding	116	A
116257	Stephens	116	A
116259	Stewart	116	A
116261	Sumter	116	A
116263	Talbot	116	A
116265	Taliaferro	116	A
116267	Tattnall	116	A
116269	Taylor	116	A
116271	Telfair	116	A
116273	Terrell	116	A
116275	Thomas	116	A
116277	Tift	116	A
116279	Toombs	116	A
116281	Towns	116	A
116283	Treutlen	116	A
116285	Troup	116	A
116287	Turner	116	A
116289	Twiggs	116	A
116291	Union	116	A
116293	Upson	116	A
116295	Walker	116	A
116297	Walton	116	A
116299	Ware	116	A
116301	Warren	116	A
116303	Washington	116	A
116305	Wayne	116	A
116307	Webster	116	A
116309	Wheeler	116	A
116311	White	116	A
116313	Whitfield	116	A
116315	Wilcox	116	A
116317	Wilkes	116	A
116319	Wilkinson	116	A
116321	Worth	116	A
150001	Alamance	150	A
150003	Alexander	150	A
150005	Alleghany	150	A
150007	Anson	150	A
150009	Ashe	150	A
150011	Avery	150	A
150013	Beaufort	150	A
150015	Bertie	150	A
150017	Bladen	150	A
150019	Brunswick	150	A
150021	Buncombe	150	A
150023	Burke	150	A
150025	Cabarrus	150	A
150027	Caldwell	150	A
150029	Camden	150	A
150031	Carteret	150	A
150033	Caswell	150	A
150035	Catawba	150	A
150037	Chatham	150	A
150039	Cherokee	150	A
150041	Chowan	150	A
150043	Clay	150	A
150045	Cleveland	150	A
150047	Columbus	150	A
150049	Craven	150	A
150051	Cumberland	150	A
150053	Currituck	150	A
150055	Dare	150	A
150057	Davidson	150	A
150059	Davie	150	A
150061	Duplin	150	A
150063	Durham	150	A
150065	Edgecombe	150	A
150067	Forsyth	150	A
150069	Franklin	150	A
150071	Gaston	150	A
150073	Gates	150	A
150075	Graham	150	A
150077	Granville	150	A
150079	Greene	150	A
150081	Guilford	150	A
150083	Halifax	150	A
150085	Harnett	150	A
150087	Haywood	150	A
150089	Henderson	150	A
150091	Hertford	150	A
150093	Hoke	150	A
150095	Hyde	150	A
150097	Iredell	150	A
150099	Jackson	150	A
150101	Johnston	150	A
150103	Jones	150	A
150105	Lee	150	A
150107	Lenoir	150	A
150109	Lincoln	150	A
150111	McDowell	150	A
150113	Macon	150	A
150115	Madison	150	A
150117	Martin	150	A
150119	Mecklenburg	150	A
150121	Mitchell	150	A
150123	Montgomery	150	A
150125	Moore	150	A
150127	Nash	150	A
150129	New Hanover	150	A
150131	Northampton	150	A
150133	Onslow	150	A
150135	Orange	150	A
150137	Pamlico	150	A
150139	Pasquotank	150	A
150141	Pender	150	A
150143	Perquimans	150	A
150145	Person	150	A
150147	Pitt	150	A
150149	Polk	150	A
150151	Randolph	150	A
150153	Richmond	150	A
150155	Robeson	150	A
150157	Rockingham	150	A
150159	Rowan	150	A
150161	Rutherford	150	A
150163	Sampson	150	A
150165	Scotland	150	A
150167	Stanly	150	A
150169	Stokes	150	A
150171	Surry	150	A
150173	Swain	150	A
150175	Transylvania	150	A
150177	Tyrrell	150	A
150179	Union	150	A
150181	Vance	150	A
150183	Wake	150	A
150185	Warren	150	A
150187	Washington	150	A
150189	Watauga	150	A
150191	Wayne	150	A
150193	Wilkes	150	A
150195	Wilson	150	A
150197	Yadkin	150	A
150199	Yancey	150	A
161001	Abbeville	161	A
161003	Aiken	161	A
161005	Allendale	161	A
161007	Anderson	161	A
161009	Bamberg	161	A
161011	Barnwell	161	A
161013	Beaufort	161	A
161015	Berkeley	161	A
161017	Calhoun	161	A
161019	Charleston	161	A
161021	Cherokee	161	A
161023	Chester	161	A
161025	Chesterfield	161	A
161027	Clarendon	161	A
161029	Colleton	161	A
161031	Darlington	161	A
161033	Dillon	161	A
161035	Dorchester	161	A
161037	Edgefield	161	A
161039	Fairfield	161	A
161041	Florence	161	A
161043	Georgetown	161	A
161045	Greenville	161	A
161047	Greenwood	161	A
161049	Hampton	161	A
161051	Horry	161	A
161053	Jasper	161	A
161055	Kershaw	161	A
161057	Lancaster	161	A
161059	Laurens	161	A
161061	Lee	161	A
161063	Lexington	161	A
161067	Marion	161	A
161069	Marlboro	161	A
161065	McCormick	161	A
161071	Newberry	161	A
161073	Oconee	161	A
161075	Orangeburg	161	A
161077	Pickens	161	A
161079	Richland	161	A
161081	Saluda	161	A
161083	Spartanburg	161	A
161085	Sumter	161	A
161087	Union	161	A
161089	Williamsburg	161	A
161091	York	161	A
168001	Addison	168	A
168003	Bennington	168	A
168005	Caledonia	168	A
168007	Chittenden	168	A
168009	Essex	168	A
168011	Franklin	168	A
168013	Grand Isle	168	A
168015	Lamoille	168	A
168017	Orange	168	A
168019	Orleans	168	A
168021	Rutland	168	A
168023	Washington	168	A
168025	Windham	168	A
168027	Windsor	168	A
144001	Belknap	144	A
144003	Carroll	144	A
144005	Cheshire	144	A
144007	Coos	144	A
144009	Grafton	144	A
144011	Hillsborough	144	A
144013	Merrimack	144	A
144015	Rockingham	144	A
144017	Strafford	144	A
144019	Sullivan	144	A
128001	Acadia	128	A
128003	Allen	128	A
128005	Ascension	128	A
128007	Assumption	128	A
128009	Avoyelles	128	A
128011	Beauregard	128	A
128013	Bienville	128	A
128015	Bossier	128	A
128017	Caddo	128	A
128019	Calcasieu	128	A
128021	Caldwell	128	A
128023	Cameron	128	A
128025	Catahoula	128	A
128027	Claiborne	128	A
128029	Concordia	128	A
128031	De Soto	128	A
128033	East Baton Rouge	128	A
128035	East Carroll	128	A
128037	East Feliciana	128	A
128039	Evangeline	128	A
128041	Franklin	128	A
128043	Grant	128	A
128045	Iberia	128	A
128047	Iberville	128	A
128049	Jackson	128	A
128051	Jefferson	128	A
128053	Jefferson Davis	128	A
128055	Lafayette	128	A
128057	Lafourche	128	A
128059	La Salle	128	A
128061	Lincoln	128	A
128063	Livingston	128	A
128065	Madison	128	A
128067	Morehouse	128	A
128069	Natchitoches	128	A
128071	Orleans	128	A
128073	Ouachita	128	A
128075	Plaquemines	128	A
128077	Pointe Coupee	128	A
128079	Rapides	128	A
128081	Red River	128	A
128083	Richland	128	A
128085	Sabine	128	A
128087	Saint Bernard	128	A
128089	Saint Charles	128	A
128091	Saint Helena	128	A
128093	Saint James	128	A
128095	Saint John the Baptist	128	A
128097	Saint Landry	128	A
128099	Saint Martin	128	A
128101	Saint Mary	128	A
128103	Saint Tammany	128	A
128105	Tangipahoa	128	A
128107	Tensas	128	A
128109	Terrebonne	128	A
128111	Union	128	A
128113	Vermilion	128	A
128115	Vernon	128	A
128117	Washington	128	A
128119	Webster	128	A
128121	West Baton Rouge	128	A
128123	West Carroll	128	A
128125	West Feliciana	128	A
128127	Winn	128	A
134001	Alcona	134	A
134003	Alger	134	A
134005	Allegan	134	A
134007	Alpena	134	A
134009	Antrim	134	A
134011	Arenac	134	A
134013	Baraga	134	A
134015	Barry	134	A
134017	Bay	134	A
134019	Benzie	134	A
134021	Berrien	134	A
134023	Branch	134	A
134025	Calhoun	134	A
134027	Cass	134	A
134029	Charlevoix	134	A
134031	Cheboygan	134	A
134033	Chippewa	134	A
134035	Clare	134	A
134037	Clinton	134	A
134039	Crawford	134	A
134041	Delta	134	A
134043	Dickinson	134	A
134045	Eaton	134	A
134047	Emmet	134	A
134049	Genesee	134	A
134051	Gladwin	134	A
134053	Gogebic	134	A
134055	Grand Traverse	134	A
134057	Gratiot	134	A
134059	Hillsdale	134	A
134061	Houghton	134	A
134063	Huron	134	A
134065	Ingham	134	A
134067	Ionia	134	A
134069	Iosco	134	A
134071	Iron	134	A
134073	Isabella	134	A
134075	Jackson	134	A
134077	Kalamazoo	134	A
134079	Kalkaska	134	A
134081	Kent	134	A
134083	Keweenaw	134	A
134085	Lake	134	A
134087	Lapeer	134	A
134089	Leelanau	134	A
134091	Lenawee	134	A
134093	Livingston	134	A
134095	Luce	134	A
134097	Mackinac	134	A
134099	Macomb	134	A
134101	Manistee	134	A
134103	Marquette	134	A
134105	Mason	134	A
134107	Mecosta	134	A
134109	Menominee	134	A
134111	Midland	134	A
134113	Missaukee	134	A
134115	Monroe	134	A
134117	Montcalm	134	A
134119	Montmorency	134	A
134121	Muskegon	134	A
134123	Newaygo	134	A
134125	Oakland	134	A
134127	Oceana	134	A
134129	Ogemaw	134	A
134131	Ontonagon	134	A
134133	Osceola	134	A
134135	Oscoda	134	A
134137	Otsego	134	A
134139	Ottawa	134	A
134141	Presque Isle	134	A
134143	Roscommon	134	A
134145	Saginaw	134	A
134147	St. Clair	134	A
134149	St. Joseph	134	A
134151	Sanilac	134	A
134153	Schoolcraft	134	A
134155	Shiawassee	134	A
134157	Tuscola	134	A
134159	Van Buren	134	A
134161	Washtenaw	134	A
134163	Wayne	134	A
134165	Wexford	134	A
174001	Adams	174	A
174003	Ashland	174	A
174005	Barron	174	A
174007	Bayfield	174	A
174009	Brown	174	A
174011	Buffalo	174	A
174013	Burnett	174	A
174015	Calumet	174	A
174017	Chippewa	174	A
174019	Clark	174	A
174021	Columbia	174	A
174023	Crawford	174	A
174025	Dane	174	A
174027	Dodge	174	A
174029	Door	174	A
174031	Douglas	174	A
174033	Dunn	174	A
174035	Eau Claire	174	A
174037	Florence	174	A
174039	Fond du Lac	174	A
174041	Forest	174	A
174043	Grant	174	A
174045	Green	174	A
174047	Green Lake	174	A
174049	Iowa	174	A
174051	Iron	174	A
174053	Jackson	174	A
174055	Jefferson	174	A
174057	Juneau	174	A
174059	Kenosha	174	A
174061	Kewaunee	174	A
174063	La Crosse	174	A
174065	Lafayette	174	A
174067	Langlade	174	A
174069	Lincoln	174	A
174071	Manitowoc	174	A
174073	Marathon	174	A
174075	Marinette	174	A
174077	Marquette	174	A
174079	Menominee	174	A
174081	Milwaukee	174	A
174083	Monroe	174	A
174085	Oconto	174	A
174087	Oneida	174	A
174089	Outagamie	174	A
174091	Ozaukee	174	A
174093	Pepin	174	A
174095	Pierce	174	A
174097	Polk	174	A
174099	Portage	174	A
174101	Price	174	A
174103	Racine	174	A
174105	Richland	174	A
174107	Rock	174	A
174109	Rusk	174	A
174111	Sauk	174	A
174113	Sawyer	174	A
174115	Shawano	174	A
174117	Sheboygan	174	A
174119	St. Croix	174	A
174121	Taylor	174	A
174123	Trempealeau	174	A
174125	Vernon	174	A
174127	Vilas	174	A
174129	Walworth	174	A
174131	Washburn	174	A
174133	Washington	174	A
174135	Waukesha	174	A
174137	Waupaca	174	A
174139	Waushara	174	A
174141	Winnebago	174	A
174143	Wood	174	A
171001	Adams	171	A
171003	Asotin	171	A
171005	Benton	171	A
171007	Chelan	171	A
171009	Clallam	171	A
171011	Clark	171	A
171013	Columbia	171	A
171015	Cowlitz	171	A
171017	Douglas	171	A
171019	Ferry	171	A
171021	Franklin	171	A
171023	Garfield	171	A
171025	Grant	171	A
171027	Grays Harbor	171	A
171029	Island	171	A
171031	Jefferson	171	A
171033	King	171	A
171035	Kitsap	171	A
171037	Kittitas	171	A
171039	Klickitat	171	A
171041	Lewis	171	A
171043	Lincoln	171	A
171045	Mason	171	A
171047	Okanogan	171	A
171049	Pacific	171	A
171051	Pend Oreille	171	A
171053	Pierce	171	A
171055	San Juan	171	A
171057	Skagit	171	A
171059	Skamania	171	A
171061	Snohomish	171	A
171063	Spokane	171	A
171065	Stevens	171	A
171067	Thurston	171	A
171069	Wahkiakum	171	A
171071	Walla Walla	171	A
171073	Whatcom	171	A
171075	Whitman	171	A
171077	Yakima	171	A
156001	Baker	156	A
156003	Benton	156	A
156005	Clackamas	156	A
156007	Clatsop	156	A
156009	Columbia	156	A
156011	Coos	156	A
156013	Crook	156	A
156015	Curry	156	A
156017	Deschutes	156	A
156019	Douglas	156	A
156021	Gilliam	156	A
156023	Grant	156	A
156025	Harney	156	A
156027	Hood River	156	A
156029	Jackson	156	A
156031	Jefferson	156	A
156033	Josephine	156	A
156035	Klamath	156	A
156037	Lake	156	A
156039	Lane	156	A
156041	Lincoln	156	A
156043	Linn	156	A
156045	Malheur	156	A
156047	Marion	156	A
156049	Morrow	156	A
156051	Multnomah	156	A
156053	Polk	156	A
156055	Sherman	156	A
156057	Tillamook	156	A
156059	Umatilla	156	A
156061	Union	156	A
156063	Wallowa	156	A
156065	Wasco	156	A
156067	Washington	156	A
156069	Wheeler	156	A
156071	Yamhill	156	A
122001	Adams	122	A
122003	Allen	122	A
122005	Bartholomew	122	A
122007	Benton	122	A
122009	Blackford	122	A
122011	Boone	122	A
122013	Brown	122	A
122015	Carroll	122	A
122017	Cass	122	A
122019	Clark	122	A
122021	Clay	122	A
122023	Clinton	122	A
122025	Crawford	122	A
122027	Daviess	122	A
122029	Dearborn	122	A
122031	Decatur	122	A
122033	De Kalb	122	A
122035	Delaware	122	A
122037	Dubois	122	A
122039	Elkhart	122	A
122041	Fayette	122	A
122043	Floyd	122	A
122045	Fountain	122	A
122047	Franklin	122	A
122049	Fulton	122	A
122051	Gibson	122	A
122053	Grant	122	A
122055	Greene	122	A
122057	Hamilton	122	A
122059	Hancock	122	A
122061	Harrison	122	A
122063	Hendricks	122	A
122065	Henry	122	A
122067	Howard	122	A
122069	Huntington	122	A
122071	Jackson	122	A
122073	Jasper	122	A
122075	Jay	122	A
122077	Jefferson	122	A
122079	Jennings	122	A
122081	Johnson	122	A
122083	Knox	122	A
122085	Kosciusko	122	A
122087	La Grange	122	A
122089	Lake	122	A
122091	La Porte	122	A
122093	Lawrence	122	A
122095	Madison	122	A
122097	Marion	122	A
122099	Marshall	122	A
122101	Martin	122	A
122103	Miami	122	A
122105	Monroe	122	A
122107	Montgomery	122	A
122109	Morgan	122	A
122111	Newton	122	A
122113	Noble	122	A
122115	Ohio	122	A
122117	Orange	122	A
122119	Owen	122	A
122121	Parke	122	A
122123	Perry	122	A
122125	Pike	122	A
122127	Porter	122	A
122129	Posey	122	A
122131	Pulaski	122	A
122133	Putnam	122	A
122135	Randolph	122	A
122137	Ripley	122	A
122139	Rush	122	A
122141	St. Joseph	122	A
122143	Scott	122	A
122145	Shelby	122	A
122147	Spencer	122	A
122149	Starke	122	A
122151	Steuben	122	A
122153	Sullivan	122	A
122155	Switzerland	122	A
122157	Tippecanoe	122	A
122159	Tipton	122	A
122161	Union	122	A
122163	Vanderburgh	122	A
122165	Vermillion	122	A
122167	Vigo	122	A
122169	Wabash	122	A
122171	Warren	122	A
122173	Warrick	122	A
122175	Washington	122	A
122177	Wayne	122	A
122179	Wells	122	A
122181	White	122	A
122183	Whitley	122	A
105001	Apache	105	A
105003	Cochise	105	A
105005	Coconino	105	A
105007	Gila	105	A
105009	Graham	105	A
105011	Greenlee	105	A
105012	La Paz	105	A
105013	Maricopa	105	A
105015	Mohave	105	A
105017	Navajo	105	A
105019	Pima	105	A
105021	Pinal	105	A
105023	Santa Cruz	105	A
105025	Yavapai	105	A
105027	Yuma	105	A
164001	Anderson	164	A
164003	Bedford	164	A
164005	Benton	164	A
164007	Bledsoe	164	A
164009	Blount	164	A
164011	Bradley	164	A
164013	Campbell	164	A
164015	Cannon	164	A
164017	Carroll	164	A
164019	Carter	164	A
164021	Cheatham	164	A
164023	Chester	164	A
164025	Claiborne	164	A
164027	Clay	164	A
164029	Cocke	164	A
164031	Coffee	164	A
164033	Crockett	164	A
164035	Cumberland	164	A
164037	Davidson	164	A
164039	Decatur	164	A
164041	De Kalb	164	A
164043	Dickson	164	A
164045	Dyer	164	A
164047	Fayette	164	A
164049	Fentress	164	A
164051	Franklin	164	A
164053	Gibson	164	A
164055	Giles	164	A
164057	Grainger	164	A
164059	Greene	164	A
164061	Grundy	164	A
164063	Hamblen	164	A
164065	Hamilton	164	A
164067	Hancock	164	A
164069	Hardeman	164	A
164071	Hardin	164	A
164073	Hawkins	164	A
164075	Haywood	164	A
164077	Henderson	164	A
164079	Henry	164	A
164081	Hickman	164	A
164083	Houston	164	A
164085	Humphreys	164	A
164087	Jackson	164	A
164089	Jefferson	164	A
164091	Johnson	164	A
164093	Knox	164	A
164095	Lake	164	A
164097	Lauderdale	164	A
164099	Lawrence	164	A
164101	Lewis	164	A
164103	Lincoln	164	A
164105	Loudon	164	A
164111	Macon	164	A
164113	Madison	164	A
164115	Marion	164	A
164117	Marshall	164	A
164119	Maury	164	A
164107	McMinn	164	A
164109	McNairy	164	A
164121	Meigs	164	A
164123	Monroe	164	A
164125	Montgomery	164	A
164127	Moore	164	A
164129	Morgan	164	A
164131	Obion	164	A
164133	Overton	164	A
164135	Perry	164	A
164137	Pickett	164	A
164139	Polk	164	A
164141	Putnam	164	A
164143	Rhea	164	A
164145	Roane	164	A
164147	Robertson	164	A
164149	Rutherford	164	A
164151	Scott	164	A
164153	Sequatchie	164	A
164155	Sevier	164	A
164157	Shelby	164	A
164159	Smith	164	A
164161	Stewart	164	A
164163	Sullivan	164	A
164165	Sumner	164	A
164167	Tipton	164	A
164169	Trousdale	164	A
164171	Unicoi	164	A
164173	Union	164	A
164175	Van Buren	164	A
164177	Warren	164	A
164179	Washington	164	A
164181	Wayne	164	A
164183	Weakley	164	A
164185	White	164	A
164187	Williamson	164	A
164189	Wilson	164	A
147001	Bernalillo	147	A
147003	Catron	147	A
147005	Chaves	147	A
147006	Cibola	147	A
147007	Colfax	147	A
147009	Curry	147	A
147011	De Baca	147	A
147013	Doña Ana	147	A
147015	Eddy	147	A
147017	Grant	147	A
147019	Guadalupe	147	A
147021	Harding	147	A
147023	Hidalgo	147	A
147025	Lea	147	A
147027	Lincoln	147	A
147028	Los Alamos	147	A
147029	Luna	147	A
147031	McKinley	147	A
147033	Mora	147	A
147035	Otero	147	A
147037	Quay	147	A
147039	Rio Arriba	147	A
147041	Roosevelt	147	A
147043	Sandoval	147	A
147045	San Juan	147	A
147047	San Miguel	147	A
147049	Santa Fe	147	A
147051	Sierra	147	A
147053	Socorro	147	A
147055	Taos	147	A
147057	Torrance	147	A
147059	Union	147	A
147061	Valencia	147	A
167001	Beaver	167	A
167003	Box Elder	167	A
167005	Cache	167	A
167007	Carbon	167	A
167009	Daggett	167	A
167011	Davis	167	A
167013	Duchesne	167	A
167015	Emery	167	A
167017	Garfield	167	A
167019	Grand	167	A
167021	Iron	167	A
167023	Juab	167	A
167025	Kane	167	A
167027	Millard	167	A
167029	Morgan	167	A
167031	Piute	167	A
167033	Rich	167	A
167035	Salt Lake	167	A
167037	San Juan	167	A
167039	Sanpete	167	A
167041	Sevier	167	A
167043	Summit	167	A
167045	Tooele	167	A
167047	Uintah	167	A
167049	Utah	167	A
167051	Wasatch	167	A
167053	Washington	167	A
167055	Wayne	167	A
167057	Weber	167	A
143510	Carson City	143	A
143001	Churchill	143	A
143003	Clark	143	A
143005	Douglas	143	A
143007	Elko	143	A
143009	Esmeralda	143	A
143011	Eureka	143	A
143013	Humboldt	143	A
143015	Lander	143	A
143017	Lincoln	143	A
143019	Lyon	143	A
143021	Mineral	143	A
143023	Nye	143	A
143027	Pershing	143	A
143029	Storey	143	A
143031	Washoe	143	A
143033	White Pine	143	A
110001	Adams	110	A
110003	Alamosa	110	A
110005	Arapahoe	110	A
110007	Archuleta	110	A
110009	Baca	110	A
110011	Bent	110	A
110013	Boulder	110	A
110014	Broomfield	110	A
110015	Chaffee	110	A
110017	Cheyenne	110	A
110019	Clear Creek	110	A
110021	Conejos	110	A
110023	Costilla	110	A
110025	Crowley	110	A
110027	Custer	110	A
110029	Delta	110	A
110031	Denver	110	A
110033	Dolores	110	A
110035	Douglas	110	A
110037	Eagle	110	A
110041	El Paso	110	A
110039	Elbert	110	A
110043	Fremont	110	A
110045	Garfield	110	A
110047	Gilpin	110	A
110049	Grand	110	A
110051	Gunnison	110	A
110053	Hinsdale	110	A
110055	Huerfano	110	A
110057	Jackson	110	A
110059	Jefferson	110	A
110061	Kiowa	110	A
110063	Kit Carson	110	A
110067	La Plata	110	A
110065	Lake	110	A
110069	Larimer	110	A
110071	Las Animas	110	A
110073	Lincoln	110	A
110075	Logan	110	A
110077	Mesa	110	A
110079	Mineral	110	A
110081	Moffat	110	A
110083	Montezuma	110	A
110085	Montrose	110	A
110087	Morgan	110	A
110089	Otero	110	A
110091	Ouray	110	A
110093	Park	110	A
110095	Phillips	110	A
110097	Pitkin	110	A
110099	Prowers	110	A
110101	Pueblo	110	A
110103	Rio Blanco	110	A
110105	Rio Grande	110	A
110107	Routt	110	A
110109	Saguache	110	A
110111	San Juan	110	A
110113	San Miguel	110	A
110115	Sedgwick	110	A
110117	Summit	110	A
110119	Teller	110	A
110121	Washington	110	A
110123	Weld	110	A
110125	Yuma	110	A
113001	Kent	113	A
113003	New Castle	113	A
113005	Sussex	113	A
138001	Adair	138	A
138003	Andrew	138	A
138005	Atchison	138	A
138007	Audrain	138	A
138009	Barry	138	A
138011	Barton	138	A
138013	Bates	138	A
138015	Benton	138	A
138017	Bollinger	138	A
138019	Boone	138	A
138021	Buchanan	138	A
138023	Butler	138	A
138025	Caldwell	138	A
138027	Callaway	138	A
138029	Camden	138	A
138031	Cape Girardeau	138	A
138033	Carroll	138	A
138035	Carter	138	A
138037	Cass	138	A
138039	Cedar	138	A
138041	Chariton	138	A
138043	Christian	138	A
138045	Clark	138	A
138047	Clay	138	A
138049	Clinton	138	A
138051	Cole	138	A
138053	Cooper	138	A
138055	Crawford	138	A
138057	Dade	138	A
138059	Dallas	138	A
138061	Daviess	138	A
138063	De Kalb	138	A
138065	Dent	138	A
138067	Douglas	138	A
138069	Dunklin	138	A
138071	Franklin	138	A
138073	Gasconade	138	A
138075	Gentry	138	A
138077	Greene	138	A
138079	Grundy	138	A
138081	Harrison	138	A
138083	Henry	138	A
138085	Hickory	138	A
138087	Holt	138	A
138089	Howard	138	A
138091	Howell	138	A
138093	Iron	138	A
138095	Jackson	138	A
138097	Jasper	138	A
138099	Jefferson	138	A
138101	Johnson	138	A
138103	Knox	138	A
138105	Laclede	138	A
138107	Lafayette	138	A
138109	Lawrence	138	A
138111	Lewis	138	A
138113	Lincoln	138	A
138115	Linn	138	A
138117	Livingston	138	A
138119	McDonald	138	A
138121	Macon	138	A
138123	Madison	138	A
138125	Maries	138	A
138127	Marion	138	A
138129	Mercer	138	A
138131	Miller	138	A
138133	Mississippi	138	A
138135	Moniteau	138	A
138137	Monroe	138	A
138139	Montgomery	138	A
138141	Morgan	138	A
138143	New Madrid	138	A
138145	Newton	138	A
138147	Nodaway	138	A
138149	Oregon	138	A
138151	Osage	138	A
138153	Ozark	138	A
138155	Pemiscot	138	A
138157	Perry	138	A
138159	Pettis	138	A
138161	Phelps	138	A
138163	Pike	138	A
138165	Platte	138	A
138167	Polk	138	A
138169	Pulaski	138	A
138171	Putnam	138	A
138173	Ralls	138	A
138175	Randolph	138	A
138177	Ray	138	A
138179	Reynolds	138	A
138181	Ripley	138	A
138183	St. Charles	138	A
138185	St. Clair	138	A
138187	Ste. Genevieve	138	A
138189	St. Francois	138	A
138191	St. Louis	138	A
138193	Saline	138	A
138195	Schuyler	138	A
138197	Scotland	138	A
138199	Scott	138	A
138201	Shannon	138	A
138203	Shelby	138	A
138205	Stoddard	138	A
138207	Stone	138	A
138209	Sullivan	138	A
138211	Taney	138	A
138213	Texas	138	A
138215	Vernon	138	A
138217	Warren	138	A
138219	Washington	138	A
138221	Wayne	138	A
138223	Webster	138	A
138225	Worth	138	A
138227	Wright	138	A
138229	St. Louis City	138	A
126001	Adair	126	A
126003	Allen	126	A
126005	Anderson	126	A
126007	Ballard	126	A
126009	Barren	126	A
126011	Bath	126	A
126013	Bell	126	A
126015	Boone	126	A
126017	Bourbon	126	A
126019	Boyd	126	A
126021	Boyle	126	A
126023	Bracken	126	A
126025	Breathitt	126	A
126027	Breckinridge	126	A
126029	Bullitt	126	A
126031	Butler	126	A
126033	Caldwell	126	A
126035	Calloway	126	A
126037	Campbell	126	A
126039	Carlisle	126	A
126041	Carroll	126	A
126043	Carter	126	A
126045	Casey	126	A
126047	Christian	126	A
126049	Clark	126	A
126051	Clay	126	A
126053	Clinton	126	A
126055	Crittenden	126	A
126057	Cumberland	126	A
126059	Daviess	126	A
126061	Edmonson	126	A
126063	Elliott	126	A
126065	Estill	126	A
126067	Fayette	126	A
126069	Fleming	126	A
126071	Floyd	126	A
126073	Franklin	126	A
126075	Fulton	126	A
126077	Gallatin	126	A
126079	Garrard	126	A
126081	Grant	126	A
126083	Graves	126	A
126085	Grayson	126	A
126087	Green	126	A
126089	Greenup	126	A
126091	Hancock	126	A
126093	Hardin	126	A
126095	Harlan	126	A
126097	Harrison	126	A
126099	Hart	126	A
126101	Henderson	126	A
126103	Henry	126	A
126105	Hickman	126	A
126107	Hopkins	126	A
126109	Jackson	126	A
126111	Jefferson	126	A
126113	Jessamine	126	A
126115	Johnson	126	A
126117	Kenton	126	A
126119	Knott	126	A
126121	Knox	126	A
126123	Larue	126	A
126125	Laurel	126	A
126127	Lawrence	126	A
126129	Lee	126	A
126131	Leslie	126	A
126133	Letcher	126	A
126135	Lewis	126	A
126137	Lincoln	126	A
126139	Livingston	126	A
126141	Logan	126	A
126143	Lyon	126	A
126145	McCracken	126	A
126147	McCreary	126	A
126149	McLean	126	A
126151	Madison	126	A
126153	Magoffin	126	A
126155	Marion	126	A
126157	Marshall	126	A
126159	Martin	126	A
126161	Mason	126	A
126163	Meade	126	A
126165	Menifee	126	A
126167	Mercer	126	A
126169	Metcalfe	126	A
126171	Monroe	126	A
126173	Montgomery	126	A
126175	Morgan	126	A
126177	Muhlenberg	126	A
126179	Nelson	126	A
126181	Nicholas	126	A
126183	Ohio	126	A
126185	Oldham	126	A
126187	Owen	126	A
126189	Owsley	126	A
126191	Pendleton	126	A
126193	Perry	126	A
126195	Pike	126	A
126197	Powell	126	A
126199	Pulaski	126	A
126201	Robertson	126	A
126203	Rockcastle	126	A
126205	Rowan	126	A
126207	Russell	126	A
126209	Scott	126	A
126211	Shelby	126	A
126213	Simpson	126	A
126215	Spencer	126	A
126217	Taylor	126	A
126219	Todd	126	A
126221	Trigg	126	A
126223	Trimble	126	A
126225	Union	126	A
126227	Warren	126	A
126229	Washington	126	A
126231	Wayne	126	A
126233	Webster	126	A
126235	Whitley	126	A
126237	Wolfe	126	A
126239	Woodford	126	A
135001	Aitkin	135	A
135003	Anoka	135	A
135005	Becker	135	A
135007	Beltrami	135	A
135009	Benton	135	A
135011	Big Stone	135	A
135013	Blue Earth	135	A
135015	Brown	135	A
135017	Carlton	135	A
135019	Carver	135	A
135021	Cass	135	A
135023	Chippewa	135	A
135025	Chisago	135	A
135027	Clay	135	A
135029	Clearwater	135	A
135031	Cook	135	A
135033	Cottonwood	135	A
135035	Crow Wing	135	A
135037	Dakota	135	A
135039	Dodge	135	A
135041	Douglas	135	A
135043	Faribault	135	A
135045	Fillmore	135	A
135047	Freeborn	135	A
135049	Goodhue	135	A
135051	Grant	135	A
135053	Hennepin	135	A
135055	Houston	135	A
135057	Hubbard	135	A
135059	Isanti	135	A
135061	Itasca	135	A
135063	Jackson	135	A
135065	Kanabec	135	A
135067	Kandiyohi	135	A
135069	Kittson	135	A
135071	Koochiching	135	A
135073	Lac qui Parle	135	A
135075	Lake	135	A
135077	Lake of the Woods	135	A
135079	Le Sueur	135	A
135081	Lincoln	135	A
135083	Lyon	135	A
135085	McLeod	135	A
135087	Mahnomen	135	A
135089	Marshall	135	A
135091	Martin	135	A
135093	Meeker	135	A
135095	Mille Lacs	135	A
135097	Morrison	135	A
135099	Mower	135	A
135101	Murray	135	A
135103	Nicollet	135	A
135105	Nobles	135	A
135107	Norman	135	A
135109	Olmsted	135	A
135111	Otter Tail	135	A
135113	Pennington	135	A
135115	Pine	135	A
135117	Pipestone	135	A
135119	Polk	135	A
135121	Pope	135	A
135123	Ramsey	135	A
135125	Red Lake	135	A
135127	Redwood	135	A
135129	Renville	135	A
135131	Rice	135	A
135133	Rock	135	A
135135	Roseau	135	A
135137	Scott	135	A
135139	Sherburne	135	A
135141	Sibley	135	A
135143	St. Louis	135	A
135145	Stearns	135	A
135147	Steele	135	A
135149	Stevens	135	A
135151	Swift	135	A
135153	Todd	135	A
135155	Traverse	135	A
135157	Wabasha	135	A
135159	Wadena	135	A
135161	Waseca	135	A
135163	Washington	135	A
135165	Watonwan	135	A
135167	Wilkin	135	A
135169	Winona	135	A
135171	Wright	135	A
135173	Yellow Medicine	135	A
102001	Autauga	102	A
102003	Baldwin	102	A
102005	Barbour	102	A
102007	Bibb	102	A
102009	Blount	102	A
102011	Bullock	102	A
102013	Butler	102	A
102015	Calhoun	102	A
102017	Chambers	102	A
102019	Cherokee	102	A
102021	Chilton	102	A
102023	Choctaw	102	A
102025	Clarke	102	A
102027	Clay	102	A
102029	Cleburne	102	A
102031	Coffee	102	A
102033	Colbert	102	A
102035	Conecuh	102	A
102037	Coosa	102	A
102039	Covington	102	A
102041	Crenshaw	102	A
102043	Cullman	102	A
102045	Dale	102	A
102047	Dallas	102	A
102049	DeKalb	102	A
102051	Elmore	102	A
102053	Escambia	102	A
102055	Etowah	102	A
102057	Fayette	102	A
102059	Franklin	102	A
102061	Geneva	102	A
102063	Greene	102	A
102065	Hale	102	A
102067	Henry	102	A
102069	Houston	102	A
102071	Jackson	102	A
102073	Jefferson	102	A
102075	Lamar	102	A
102077	Lauderdale	102	A
102079	Lawrence	102	A
102081	Lee	102	A
102083	Limestone	102	A
102085	Lowndes	102	A
102087	Macon	102	A
102089	Madison	102	A
102091	Marengo	102	A
102093	Marion	102	A
102095	Marshall	102	A
102097	Mobile	102	A
102099	Monroe	102	A
102101	Montgomery	102	A
102103	Morgan	102	A
102105	Perry	102	A
102107	Pickens	102	A
102109	Pike	102	A
102111	Randolph	102	A
102113	Russell	102	A
102115	St. Clair	102	A
102117	Shelby	102	A
102119	Sumter	102	A
102121	Talladega	102	A
102123	Tallapoosa	102	A
102125	Tuscaloosa	102	A
102127	Walker	102	A
102129	Washington	102	A
102131	Wilcox	102	A
102133	Winston	102	A
107001	Arkansas	107	A
107003	Ashley	107	A
107005	Baxter	107	A
107007	Benton	107	A
107009	Boone	107	A
107011	Bradley	107	A
107013	Calhoun	107	A
107015	Carroll	107	A
107017	Chicot	107	A
107019	Clark	107	A
107021	Clay	107	A
107023	Cleburne	107	A
107025	Cleveland	107	A
107027	Columbia	107	A
107029	Conway	107	A
107031	Craighead	107	A
107033	Crawford	107	A
107035	Crittenden	107	A
107037	Cross	107	A
107039	Dallas	107	A
107041	Desha	107	A
107043	Drew	107	A
107045	Faulkner	107	A
107047	Franklin	107	A
107049	Fulton	107	A
107051	Garland	107	A
107053	Grant	107	A
107055	Greene	107	A
107057	Hempstead	107	A
107059	Hot Spring	107	A
107061	Howard	107	A
107063	Independence	107	A
107065	Izard	107	A
107067	Jackson	107	A
107069	Jefferson	107	A
107071	Johnson	107	A
107073	Lafayette	107	A
107075	Lawrence	107	A
107077	Lee	107	A
107079	Lincoln	107	A
107081	Little River	107	A
107083	Logan	107	A
107085	Lonoke	107	A
107087	Madison	107	A
107089	Marion	107	A
107091	Miller	107	A
107093	Mississippi	107	A
107095	Monroe	107	A
107097	Montgomery	107	A
107099	Nevada	107	A
107101	Newton	107	A
107103	Ouachita	107	A
107105	Perry	107	A
107107	Phillips	107	A
107109	Pike	107	A
107111	Poinsett	107	A
107113	Polk	107	A
107115	Pope	107	A
107117	Prairie	107	A
107119	Pulaski	107	A
107121	Randolph	107	A
107123	St. Francis	107	A
107125	Saline	107	A
107127	Scott	107	A
107129	Searcy	107	A
107131	Sebastian	107	A
107133	Sevier	107	A
107135	Sharp	107	A
107137	Stone	107	A
107139	Union	107	A
107141	Van Buren	107	A
107143	Washington	107	A
107145	White	107	A
107147	Woodruff	107	A
107149	Yell	107	A
125001	Allen	125	A
125003	Anderson	125	A
125005	Atchison	125	A
125007	Barber	125	A
125009	Barton	125	A
125011	Bourbon	125	A
125013	Brown	125	A
125015	Butler	125	A
125017	Chase	125	A
125019	Chautauqua	125	A
125021	Cherokee	125	A
125023	Cheyenne	125	A
125025	Clark	125	A
125027	Clay	125	A
125029	Cloud	125	A
125031	Coffey	125	A
125033	Comanche	125	A
125035	Cowley	125	A
125037	Crawford	125	A
125039	Decatur	125	A
125041	Dickinson	125	A
125043	Doniphan	125	A
125045	Douglas	125	A
125047	Edwards	125	A
125049	Elk	125	A
125051	Ellis	125	A
125053	Ellsworth	125	A
125055	Finney	125	A
125057	Ford	125	A
125059	Franklin	125	A
125061	Geary	125	A
125063	Gove	125	A
125065	Graham	125	A
125067	Grant	125	A
125069	Gray	125	A
125071	Greeley	125	A
125073	Greenwood	125	A
125075	Hamilton	125	A
125077	Harper	125	A
125079	Harvey	125	A
125081	Haskell	125	A
125083	Hodgeman	125	A
125085	Jackson	125	A
125087	Jefferson	125	A
125089	Jewell	125	A
125091	Johnson	125	A
125093	Kearny	125	A
125095	Kingman	125	A
125097	Kiowa	125	A
125099	Labette	125	A
125101	Lane	125	A
125103	Leavenworth	125	A
125105	Lincoln	125	A
125107	Linn	125	A
125109	Logan	125	A
125111	Lyon	125	A
125113	McPherson	125	A
125115	Marion	125	A
125117	Marshall	125	A
125119	Meade	125	A
125121	Miami	125	A
125123	Mitchell	125	A
125125	Montgomery	125	A
125127	Morris	125	A
125129	Morton	125	A
125131	Nemaha	125	A
125133	Neosho	125	A
125135	Ness	125	A
125137	Norton	125	A
125139	Osage	125	A
125141	Osborne	125	A
125143	Ottawa	125	A
125145	Pawnee	125	A
125147	Phillips	125	A
125149	Pottawatomie	125	A
125151	Pratt	125	A
125153	Rawlins	125	A
125155	Reno	125	A
125157	Republic	125	A
125159	Rice	125	A
125161	Riley	125	A
125163	Rooks	125	A
125165	Rush	125	A
125167	Russell	125	A
125169	Saline	125	A
125171	Scott	125	A
125173	Sedgwick	125	A
125175	Seward	125	A
125177	Shawnee	125	A
125179	Sheridan	125	A
125181	Sherman	125	A
125183	Smith	125	A
125185	Stafford	125	A
125187	Stanton	125	A
125189	Stevens	125	A
125191	Sumner	125	A
125193	Thomas	125	A
125195	Trego	125	A
125197	Wabaunsee	125	A
125199	Wallace	125	A
125201	Washington	125	A
125203	Wichita	125	A
125205	Wilson	125	A
125207	Woodson	125	A
125209	Wyandotte	125	A
155001	Adair	155	A
155003	Alfalfa	155	A
155005	Atoka	155	A
155007	Beaver	155	A
155009	Beckham	155	A
155011	Blaine	155	A
155013	Bryan	155	A
155015	Caddo	155	A
155017	Canadian	155	A
155019	Carter	155	A
155021	Cherokee	155	A
155023	Choctaw	155	A
155025	Cimarron	155	A
155027	Cleveland	155	A
155029	Coal	155	A
155031	Comanche	155	A
155033	Cotton	155	A
155035	Craig	155	A
155037	Creek	155	A
155039	Custer	155	A
155041	Delaware	155	A
155043	Dewey	155	A
155045	Ellis	155	A
155047	Garfield	155	A
155049	Garvin	155	A
155051	Grady	155	A
155053	Grant	155	A
155055	Greer	155	A
155057	Harmon	155	A
155059	Harper	155	A
155061	Haskell	155	A
155063	Hughes	155	A
155065	Jackson	155	A
155067	Jefferson	155	A
155069	Johnston	155	A
155071	Kay	155	A
155073	Kingfisher	155	A
155075	Kiowa	155	A
155077	Latimer	155	A
155079	Le Flore	155	A
155081	Lincoln	155	A
155083	Logan	155	A
155085	Love	155	A
155093	Major	155	A
155095	Marshall	155	A
155097	Mayes	155	A
155087	McClain	155	A
155089	McCurtain	155	A
155091	McIntosh	155	A
155099	Murray	155	A
155101	Muskogee	155	A
155103	Noble	155	A
155105	Nowata	155	A
155107	Okfuskee	155	A
155109	Oklahoma	155	A
155111	Okmulgee	155	A
155113	Osage	155	A
155115	Ottawa	155	A
155117	Pawnee	155	A
155119	Payne	155	A
155121	Pittsburg	155	A
155123	Pontotoc	155	A
155125	Pottawatomie	155	A
155127	Pushmataha	155	A
155129	Roger Mills	155	A
155131	Rogers	155	A
155133	Seminole	155	A
155135	Sequoyah	155	A
155137	Stephens	155	A
155139	Texas	155	A
155141	Tillman	155	A
155143	Tulsa	155	A
155145	Wagoner	155	A
155147	Washington	155	A
155149	Washita	155	A
155151	Woods	155	A
155153	Woodward	155	A
141001	Adams	141	A
141003	Antelope	141	A
141005	Arthur	141	A
141007	Banner	141	A
141009	Blaine	141	A
141011	Boone	141	A
141013	Box Butte	141	A
141015	Boyd	141	A
141017	Brown	141	A
141019	Buffalo	141	A
141021	Burt	141	A
141023	Butler	141	A
141025	Cass	141	A
141027	Cedar	141	A
141029	Chase	141	A
141031	Cherry	141	A
141033	Cheyenne	141	A
141035	Clay	141	A
141037	Colfax	141	A
141039	Cuming	141	A
141041	Custer	141	A
141043	Dakota	141	A
141045	Dawes	141	A
141047	Dawson	141	A
141049	Deuel	141	A
141051	Dixon	141	A
141053	Dodge	141	A
141055	Douglas	141	A
141057	Dundy	141	A
141059	Fillmore	141	A
141061	Franklin	141	A
141063	Frontier	141	A
141065	Furnas	141	A
141067	Gage	141	A
141069	Garden	141	A
141071	Garfield	141	A
141073	Gosper	141	A
141075	Grant	141	A
141077	Greeley	141	A
141079	Hall	141	A
141081	Hamilton	141	A
141083	Harlan	141	A
141085	Hayes	141	A
141087	Hitchcock	141	A
141089	Holt	141	A
141091	Hooker	141	A
141093	Howard	141	A
141095	Jefferson	141	A
141097	Johnson	141	A
141099	Kearney	141	A
141101	Keith	141	A
141103	Keya Paha	141	A
141105	Kimball	141	A
141107	Knox	141	A
141109	Lancaster	141	A
141111	Lincoln	141	A
141113	Logan	141	A
141115	Loup	141	A
141119	Madison	141	A
141117	McPherson	141	A
141121	Merrick	141	A
141123	Morrill	141	A
141125	Nance	141	A
141127	Nemaha	141	A
141129	Nuckolls	141	A
141131	Otoe	141	A
141133	Pawnee	141	A
141135	Perkins	141	A
141137	Phelps	141	A
141139	Pierce	141	A
141141	Platte	141	A
141143	Polk	141	A
141145	Red Willow	141	A
141147	Richardson	141	A
141149	Rock	141	A
141151	Saline	141	A
141153	Sarpy	141	A
141155	Saunders	141	A
141157	Scotts Bluff	141	A
141159	Seward	141	A
141161	Sheridan	141	A
141163	Sherman	141	A
141165	Sioux	141	A
141167	Stanton	141	A
141169	Thayer	141	A
141171	Thomas	141	A
141173	Thurston	141	A
141175	Valley	141	A
141177	Washington	141	A
141179	Wayne	141	A
141181	Webster	141	A
141183	Wheeler	141	A
141185	York	141	A
137001	Adams	137	A
137003	Alcorn	137	A
137005	Amite	137	A
137007	Attala	137	A
137009	Benton	137	A
137011	Bolivar	137	A
137013	Calhoun	137	A
137015	Carroll	137	A
137017	Chickasaw	137	A
137019	Choctaw	137	A
137021	Claiborne	137	A
137023	Clarke	137	A
137025	Clay	137	A
137027	Coahoma	137	A
137029	Copiah	137	A
137031	Covington	137	A
137033	De Soto	137	A
137035	Forrest	137	A
137037	Franklin	137	A
137039	George	137	A
137041	Greene	137	A
137043	Grenada	137	A
137045	Hancock	137	A
137047	Harrison	137	A
137049	Hinds	137	A
137051	Holmes	137	A
137053	Humphreys	137	A
137055	Issaquena	137	A
137057	Itawamba	137	A
137059	Jackson	137	A
137061	Jasper	137	A
137063	Jefferson	137	A
137065	Jefferson Davis	137	A
137067	Jones	137	A
137069	Kemper	137	A
137071	Lafayette	137	A
137073	Lamar	137	A
137075	Lauderdale	137	A
137077	Lawrence	137	A
137079	Leake	137	A
137081	Lee	137	A
137083	Leflore	137	A
137085	Lincoln	137	A
137087	Lowndes	137	A
137089	Madison	137	A
137091	Marion	137	A
137093	Marshall	137	A
137095	Monroe	137	A
137097	Montgomery	137	A
137099	Neshoba	137	A
137101	Newton	137	A
137103	Noxubee	137	A
137105	Oktibbeha	137	A
137107	Panola	137	A
137109	Pearl River	137	A
137111	Perry	137	A
137113	Pike	137	A
137115	Pontotoc	137	A
137117	Prentiss	137	A
137119	Quitman	137	A
137121	Rankin	137	A
137123	Scott	137	A
137125	Sharkey	137	A
137127	Simpson	137	A
137129	Smith	137	A
137131	Stone	137	A
137133	Sunflower	137	A
137135	Tallahatchie	137	A
137137	Tate	137	A
137139	Tippah	137	A
137141	Tishomingo	137	A
137143	Tunica	137	A
137145	Union	137	A
137147	Walthall	137	A
137149	Warren	137	A
137151	Washington	137	A
137153	Wayne	137	A
137155	Webster	137	A
137157	Wilkinson	137	A
137159	Winston	137	A
137161	Yalobusha	137	A
137163	Yazoo	137	A
123001	Adair	123	A
123003	Adams	123	A
123005	Allamakee	123	A
123007	Appanoose	123	A
123009	Audubon	123	A
123011	Benton	123	A
123013	Black Hawk	123	A
123015	Boone	123	A
123017	Bremer	123	A
123019	Buchanan	123	A
123021	Buena Vista	123	A
123023	Butler	123	A
123025	Calhoun	123	A
123027	Carroll	123	A
123029	Cass	123	A
123031	Cedar	123	A
123033	Cerro Gordo	123	A
123035	Cherokee	123	A
123037	Chickasaw	123	A
123039	Clarke	123	A
123041	Clay	123	A
123043	Clayton	123	A
123045	Clinton	123	A
123047	Crawford	123	A
123049	Dallas	123	A
123051	Davis	123	A
123053	Decatur	123	A
123055	Delaware	123	A
123057	Des Moines	123	A
123059	Dickinson	123	A
123061	Dubuque	123	A
123063	Emmet	123	A
123065	Fayette	123	A
123067	Floyd	123	A
123069	Franklin	123	A
123071	Fremont	123	A
123073	Greene	123	A
123075	Grundy	123	A
123077	Guthrie	123	A
123079	Hamilton	123	A
123081	Hancock	123	A
123083	Hardin	123	A
123085	Harrison	123	A
123087	Henry	123	A
123089	Howard	123	A
123091	Humboldt	123	A
123093	Ida	123	A
123095	Iowa	123	A
123097	Jackson	123	A
123099	Jasper	123	A
123101	Jefferson	123	A
123103	Johnson	123	A
123105	Jones	123	A
123107	Keokuk	123	A
123109	Kossuth	123	A
123111	Lee	123	A
123113	Linn	123	A
123115	Louisa	123	A
123117	Lucas	123	A
123119	Lyon	123	A
123121	Madison	123	A
123123	Mahaska	123	A
123125	Marion	123	A
123127	Marshall	123	A
123129	Mills	123	A
123131	Mitchell	123	A
123133	Monona	123	A
123135	Monroe	123	A
123137	Montgomery	123	A
123139	Muscatine	123	A
123141	O'Brien	123	A
123143	Osceola	123	A
123145	Page	123	A
123147	Palo Alto	123	A
123149	Plymouth	123	A
123151	Pocahontas	123	A
123153	Polk	123	A
123155	Pottawattamie	123	A
123157	Poweshiek	123	A
123159	Ringgold	123	A
123161	Sac	123	A
123163	Scott	123	A
123165	Shelby	123	A
123167	Sioux	123	A
123169	Story	123	A
123171	Tama	123	A
123173	Taylor	123	A
123175	Union	123	A
123177	Van Buren	123	A
123179	Wapello	123	A
123181	Warren	123	A
123183	Washington	123	A
123185	Wayne	123	A
123187	Webster	123	A
123189	Winnebago	123	A
123191	Winneshiek	123	A
123193	Woodbury	123	A
123195	Worth	123	A
123197	Wright	123	A
202998	Indeterminado	202	A
204998	Indeterminado	204	A
207998	Indeterminado	207	A
208998	Indeterminado	208	A
210998	Indeterminado	210	A
212998	Indeterminado	212	A
214998	Indeterminado	214	A
216998	Indeterminado	216	A
218998	Indeterminado	218	A
220998	Indeterminado	220	A
222998	Indeterminado	222	A
224998	Indeterminado	224	A
226998	Indeterminado	226	A
204001	Alberni-Clayoquot	204	A
204002	Bulkley-Nechako	204	A
204003	Capital	204	A
204004	Cariboo	204	A
204005	Central Coast	204	A
204006	Central Kootenay	204	A
204007	Central Okanagan	204	A
204008	Columbia-Shuswap	204	A
204009	Comox Valley	204	A
204010	Cowichan Valley	204	A
204011	East Kootenay	204	A
204012	Fraser Valley	204	A
204013	Fraser-Fort George	204	A
204014	Greater Vancouver	204	A
204015	Kitimat-Stikine	204	A
204016	Kootenay Boundary	204	A
204017	Mount Waddington	204	A
204018	Nanaimo	204	A
204019	North Okanagan	204	A
204020	Northern Rockies	204	A
204021	Okanagan-Similkameen	204	A
204022	Peace River	204	A
204023	Powell River	204	A
204024	Skeena-Queen Charlotte	204	A
204025	Squamish-Lillooet	204	A
204026	Stikine Region	204	A
204027	Strathcona	204	A
204028	Sunshine Coast	204	A
204029	Thompson-Nicola	204	A
210001	Albert	210	A
210002	Carleton	210	A
210003	Charlotte	210	A
210004	Gloucester	210	A
210005	Kent	210	A
210006	Kings	210	A
210007	Madawaska	210	A
210008	Northumberland	210	A
210009	Queens	210	A
210010	Restigouche	210	A
210011	Saint John	210	A
210012	Sunbury	210	A
210013	Victoria	210	A
210014	Westmorland	210	A
210015	York	210	A
212001	Annapolis	212	A
212002	Antigonish	212	A
212003	Cape Breton	212	A
212004	Colchester	212	A
212005	Cumberland	212	A
212006	Digby	212	A
212007	Guysborough	212	A
212008	Halifax	212	A
212009	Hants	212	A
212010	Inverness	212	A
212011	Kings	212	A
212012	Lunenburg	212	A
212013	Pictou	212	A
212014	Queens	212	A
212015	Richmond	212	A
212016	Shelburne	212	A
212017	Victoria	212	A
212018	Yarmouth	212	A
218001	Abitibi-Témiscamingue	218	A
218002	Bas-Saint-Laurent	218	A
218003	Capitale-Nationale	218	A
218004	Centre-du-Québec	218	A
218005	Chaudière-Appalaches	218	A
218006	Côte-Nord	218	A
218007	Estrie	218	A
218008	Gaspésie-Îles-de-la-Madeleine	218	A
218009	Lanaudière	218	A
218010	Laurentides	218	A
218011	Laval	218	A
218012	Mauricie	218	A
218013	Montérégie	218	A
218014	Montréal	218	A
218015	Nord-du-Québec	218	A
218016	Outaouais	218	A
218017	Saguenay-Lac-Saint-Jean	218	A
4002998	Indeterminado	4002	A
4004998	Indeterminado	4004	A
4006998	Indeterminado	4006	A
4008998	Indeterminado	4008	A
4010998	Indeterminado	4010	A
4012998	Indeterminado	4012	A
4014998	Indeterminado	4014	A
4016998	Indeterminado	4016	A
4018998	Indeterminado	4018	A
4020998	Indeterminado	4020	A
4022998	Indeterminado	4022	A
4024998	Indeterminado	4024	A
4026998	Indeterminado	4026	A
4028998	Indeterminado	4028	A
4030998	Indeterminado	4030	A
4032998	Indeterminado	4032	A
4034998	Indeterminado	4034	A
4036998	Indeterminado	4036	A
4038998	Indeterminado	4038	A
4040998	Indeterminado	4040	A
4042998	Indeterminado	4042	A
4044998	Indeterminado	4044	A
4046998	Indeterminado	4046	A
4048998	Indeterminado	4048	A
4050998	Indeterminado	4050	A
4054998	Indeterminado	4054	A
4056998	Indeterminado	4056	A
4058998	Indeterminado	4058	A
4060998	Indeterminado	4060	A
4062998	Indeterminado	4062	A
4064998	Indeterminado	4064	A
4066998	Indeterminado	4066	A
4002001	Azua de Compostela	4002	A
4002003	Estebanía	4002	A
4002005	Guayabal	4002	A
4002007	Las Charcas	4002	A
4002009	Las Yayas de Viajama	4002	A
4002011	Padre Las Casas	4002	A
4002013	Peralta	4002	A
4002015	Pueblo Viejo	4002	A
4002017	Sabana Yegua	4002	A
4002019	Tábara Arriba	4002	A
4004001	Neiba	4004	A
4004003	Galván	4004	A
4004005	Los Ríos	4004	A
4004007	Tamayo	4004	A
4004009	Villa Jaragua	4004	A
4006001	Santa Cruz de Barahona	4006	A
4006003	Cabral	4006	A
4006005	El Peñón	4006	A
4006007	Enriquillo	4006	A
4006009	Fundación	4006	A
4006011	Jaquimeyes	4006	A
4006013	La Ciénaga	4006	A
4006015	Las Salinas	4006	A
4006017	Polo	4006	A
4006019	Paraíso	4006	A
4006021	Vicente Noble	4006	A
4008001	Dajabón	4008	A
4008003	El Pino	4008	A
4008005	Loma de Cabrera	4008	A
4008007	Partido	4008	A
4008009	Restauración	4008	A
4010001	San Francisco de Macorís	4010	A
4010003	Arenoso	4010	A
4010005	Castillo	4010	A
4010007	Eugenio María de Hostos	4010	A
4010009	Las Guáranas	4010	A
4010011	Pimentel	4010	A
4010013	Villa Riva	4010	A
4012001	Comendador	4012	A
4012003	Bánica	4012	A
4012005	El Llano	4012	A
4012007	Hondo Valle	4012	A
4012009	Juan Santiago	4012	A
4012011	Pedro Santana	4012	A
4014001	Santa Cruz del Seibo	4014	A
4014003	Miches	4014	A
4016001	Gaspar Hernández	4016	A
4016003	Moca	4016	A
4016005	Jamao Al Norte	4016	A
4016007	Cayetano Germosén	4016	A
4018001	Hato Mayor del Rey	4018	A
4018003	Sabana de la Mar	4018	A
4018005	El Valle	4018	A
4020001	Salcedo	4020	A
4020003	Tenares	4020	A
4020005	Villa Tapia	4020	A
4022001	Jimaní	4022	A
4022003	Cristóbal	4022	A
4022005	Duvergé	4022	A
4022007	La Descubierta	4022	A
4022009	Mella	4022	A
4022011	Postrer Río	4022	A
4024001	Salvaleón de Higüey	4024	A
4024003	San Rafael del Yuma	4024	A
4026001	Higüeral	4026	A
4026003	Guaymate	4026	A
4026005	La Romana	4026	A
4026007	Villa Hermosa	4026	A
4028001	Concepción de La Vega	4028	A
4028003	Constanza	4028	A
4028005	Jarabacoa	4028	A
4028007	Jima Abajo	4028	A
4030001	Nagua	4030	A
4030003	Cabrera	4030	A
4030005	El Factor	4030	A
4030007	Río San Juan	4030	A
4032001	Bonao	4032	A
4032003	Maimón	4032	A
4032005	Piedra Blanca	4032	A
4034001	Castañuelas	4034	A
4034003	Guayubín	4034	A
4034005	Las Matas de Santa Cruz	4034	A
4034007	Pepillo Salcedo	4034	A
4034009	San Fernando de Montecristi	4034	A
4034011	Villa Vásquez	4034	A
4036001	Monte Plata	4036	A
4036003	Bayaguana	4036	A
4036005	Peralvillo	4036	A
4036007	Sabana Grande de Boyá	4036	A
4036009	Yamasá	4036	A
4038001	Pedernales	4038	A
4038003	Oviedo	4038	A
4040001	Baní	4040	A
4040003	Nizao	4040	A
4042001	Puerto Plata	4042	A
4042003	Altamira	4042	A
4042005	Guananico	4042	A
4042007	Imbert	4042	A
4042009	Los Hidalgos	4042	A
4042011	Luperón	4042	A
4042013	Sosúa	4042	A
4042015	Villa Isabela	4042	A
4042017	Villa Montellano	4042	A
4044001	Santa Bárbara de Samaná	4044	A
4044003	Las Terrenas	4044	A
4044005	Sánchez	4044	A
4046001	Cotuí	4046	A
4046003	Cevicos	4046	A
4046005	Fantino	4046	A
4046007	La Mata	4046	A
4048001	San Cristóbal	4048	A
4048003	Bajos de Haina	4048	A
4048005	Cambita Garabito	4048	A
4048007	Los Cacaos	4048	A
4048009	Sabana Grande de Palenque	4048	A
4048011	San Gregorio de Nigua	4048	A
4048013	Yaguate	4048	A
4048015	Villa Altagracia	4048	A
4050001	San José de Ocoa	4050	A
4050003	Rancho Arriba	4050	A
4050005	Sabana Larga	4050	A
4054001	San Juan de la Maguana	4054	A
4054003	Juan de Herrera	4054	A
4054005	Bohechío	4054	A
4054007	El Cercado	4054	A
4054009	Las Matas de Farfán	4054	A
4054011	Vallejuelo	4054	A
4056001	San Pedro de Macorís	4056	A
4056003	Consuelo	4056	A
4056005	Guayacanes	4056	A
4056007	San José de Los Llanos	4056	A
4056009	Quisqueya	4056	A
4056011	Ramón Santana	4056	A
4058001	Jánico	4058	A
4058003	Licey al Medio	4058	A
4058005	Puñal	4058	A
4058007	Sabana Iglesia	4058	A
4058009	Santiago de los Caballeros	4058	A
4058011	San José de Las Matas	4058	A
4058013	Tamboril	4058	A
4058015	Villa Bisonó	4058	A
4058017	Villa González	4058	A
4060001	San Ignacio de Sabaneta	4060	A
4060003	Monción	4060	A
4060005	Villa Los Almácigos	4060	A
4062001	Los Alcarrizos	4062	A
4062003	Boca Chica	4062	A
4062005	Pedro Brand	4062	A
4062007	San Antonio de Guerra	4062	A
4062009	Santo Domingo Este	4062	A
4062011	Santo Domingo Norte	4062	A
4062013	Santo Domingo Oeste	4062	A
4064001	Mao	4064	A
4064003	Esperanza	4064	A
4064005	Laguna Salada	4064	A
4066001	Distrito Nacional	4066	A
701998	Indeterminado	701	A
702998	Indeterminado	702	A
703998	Indeterminado	703	A
704998	Indeterminado	704	A
705998	Indeterminado	705	A
706998	Indeterminado	706	A
707998	Indeterminado	707	A
708998	Indeterminado	708	A
709998	Indeterminado	709	A
710998	Indeterminado	710	A
711998	Indeterminado	711	A
712998	Indeterminado	712	A
713998	Indeterminado	713	A
714998	Indeterminado	714	A
715998	Indeterminado	715	A
716998	Indeterminado	716	A
717998	Indeterminado	717	A
718998	Indeterminado	718	A
719998	Indeterminado	719	A
720998	Indeterminado	720	A
721998	Indeterminado	721	A
722998	Indeterminado	722	A
723998	Indeterminado	723	A
724998	Indeterminado	724	A
725998	Indeterminado	725	A
726998	Indeterminado	726	A
727998	Indeterminado	727	A
728998	Indeterminado	728	A
729998	Indeterminado	729	A
730998	Indeterminado	730	A
731998	Indeterminado	731	A
732998	Indeterminado	732	A
733998	Indeterminado	733	A
734998	Indeterminado	734	A
735998	Indeterminado	735	A
736998	Indeterminado	736	A
737998	Indeterminado	737	A
738998	Indeterminado	738	A
739998	Indeterminado	739	A
740998	Indeterminado	740	A
741998	Indeterminado	741	A
742998	Indeterminado	742	A
743998	Indeterminado	743	A
744998	Indeterminado	744	A
745998	Indeterminado	745	A
746998	Indeterminado	746	A
747998	Indeterminado	747	A
748998	Indeterminado	748	A
749998	Indeterminado	749	A
750998	Indeterminado	750	A
751998	Indeterminado	751	A
752998	Indeterminado	752	A
753998	Indeterminado	753	A
754998	Indeterminado	754	A
755998	Indeterminado	755	A
756998	Indeterminado	756	A
757998	Indeterminado	757	A
758998	Indeterminado	758	A
759998	Indeterminado	759	A
760998	Indeterminado	760	A
761998	Indeterminado	761	A
762998	Indeterminado	762	A
763998	Indeterminado	763	A
764998	Indeterminado	764	A
765998	Indeterminado	765	A
766998	Indeterminado	766	A
767998	Indeterminado	767	A
768998	Indeterminado	768	A
769998	Indeterminado	769	A
770998	Indeterminado	770	A
771998	Indeterminado	771	A
772998	Indeterminado	772	A
773998	Indeterminado	773	A
774998	Indeterminado	774	A
775998	Indeterminado	775	A
776998	Indeterminado	776	A
778998	Indeterminado	778	A
779998	Indeterminado	779	A
780998	Indeterminado	780	A
781998	Indeterminado	781	A
782998	Indeterminado	782	A
783998	Indeterminado	783	A
784998	Indeterminado	784	A
746001	Kingisepp	746	A
3101998	Indeterminado	3101	A
3102998	Indeterminado	3102	A
3103998	Indeterminado	3103	A
3104998	Indeterminado	3104	A
3105998	Indeterminado	3105	A
3106998	Indeterminado	3106	A
3107998	Indeterminado	3107	A
3108998	Indeterminado	3108	A
3109998	Indeterminado	3109	A
3110998	Indeterminado	3110	A
3111998	Indeterminado	3111	A
3112998	Indeterminado	3112	A
3103001	Aa en Hunze	3103	A
3103004	Assen	3103	A
3103007	Borger-Odoorn	3103	A
3103010	Coevorden	3103	A
3103013	De Wolden	3103	A
3103016	Emmen	3103	A
3103019	Hoogeveen	3103	A
3103022	Meppel	3103	A
3103025	Midden-Drenthe	3103	A
3103028	Noordenveld	3103	A
3103031	Tynaarlo	3103	A
3103034	Westerveld	3103	A
3104001	Almere	3104	A
3104004	Dronten	3104	A
3104007	Lelystad	3104	A
3104010	Noordoostpolder	3104	A
3104013	Urk	3104	A
3104016	Zeewolde	3104	A
3105001	Achtkarspelen	3105	A
3105004	Ameland	3105	A
3105007	Boarnsterhim	3105	A
3105010	Dantumadiel	3105	A
3105016	Dongeradeel	3105	A
3105019	Ferwerderadiel	3105	A
3105022	Franekeradeel	3105	A
3105025	Gaasterlân-Sleat	3105	A
3105028	Harlingen	3105	A
3105031	Heerenveen	3105	A
3105034	Het Bildt	3105	A
3105037	Kollumerland	3105	A
3105040	Leeuwarden	3105	A
3105043	Leeuwarderadeel	3105	A
3105045	Lemsterland	3105	A
3105049	Littenseradiel	3105	A
3105052	Menaldumadeel	3105	A
3105055	Ooststellingwerf	3105	A
3105058	Opsterland	3105	A
3105061	Schiermonnikoog	3105	A
3105064	Skarsterlân	3105	A
3105067	Smallingerland	3105	A
3105070	Súdwest Fryslân	3105	A
3105073	Terschelling	3105	A
3105076	Tytsjerksteradiel	3105	A
3105079	Vlieland	3105	A
3105082	Weststellingwerf	3105	A
3106001	Aalten	3106	A
3106004	Apeldoorn	3106	A
3106007	Arnhem	3106	A
3106010	Barneveld	3106	A
3106013	Berkelland	3106	A
3106016	Beuningen	3106	A
3106019	Bronckhorst	3106	A
3106022	Brummen	3106	A
3106025	Buren	3106	A
3106028	Culemborg	3106	A
3106031	Doesburg	3106	A
3106034	Doetinchem	3106	A
3106037	Druten	3106	A
3106040	Duiven	3106	A
3106043	Ede	3106	A
3106046	Elburg	3106	A
3106049	Epe	3106	A
3106052	Ermelo	3106	A
3106055	Geldermalsen	3106	A
3106058	Groesbeek	3106	A
3106061	Harderwijk	3106	A
3106064	Hattem	3106	A
3106067	Heerde	3106	A
3106070	Heumen	3106	A
3106073	Lingewaal	3106	A
3106076	Lingewaard	3106	A
3106079	Lochem	3106	A
3106082	Maasdriel	3106	A
3106085	Millingen aan de Rijn	3106	A
3106088	Montferland	3106	A
3106091	Neder-Betuwe	3106	A
3106094	Neerijnen	3106	A
3106097	Nijkerk	3106	A
3106100	Nunspeet	3106	A
3106103	Oldebroek	3106	A
3106106	Oude IJsselstreek	3106	A
3106109	Overbetuwe	3106	A
3106112	Oost Gelre	3106	A
3106115	Putten	3106	A
3106118	Renkum	3106	A
3106121	Rheden	3106	A
3106124	Rijnwaarden	3106	A
3106127	Rozendaal	3106	A
3106130	Scherpenzeel	3106	A
3106133	Tiel	3106	A
3106136	Ubbergen	3106	A
3106139	Voorst	3106	A
3106142	Wageningen	3106	A
3106145	West Maas en Waal	3106	A
3106148	Westervoort	3106	A
3106151	Wijchen	3106	A
3106154	Winterswijk	3106	A
3106157	Zaltbommel	3106	A
3106160	Zevenaar	3106	A
3106163	Zutphen	3106	A
3107001	Appingedam	3107	A
3107004	Bedum	3107	A
3107007	Bellingwedde	3107	A
3107010	De Marne	3107	A
3107013	Delfzijl	3107	A
3107016	Eemsmond	3107	A
3107019	Groningen	3107	A
3107022	Grootegast	3107	A
3107025	Haren	3107	A
3107028	Hoogezand-Sappemeer	3107	A
3107031	Leek	3107	A
3107034	Loppersum	3107	A
3107037	Marum	3107	A
3107040	Menterwolde	3107	A
3107043	Oldambt	3107	A
3107046	Pekela	3107	A
3107049	Slochteren	3107	A
3107052	Stadskanaal	3107	A
3107055	Ten Boer	3107	A
3107058	Veendam	3107	A
3107061	Vlagtwedde	3107	A
3107064	Winsum	3107	A
3107067	Zuidhorn	3107	A
3108001	Beek 	3108	A
3108004	Beesel 	3108	A
3108007	Bergen 	3108	A
3108010	Brunssum 	3108	A
3108013	Echt-Susteren 	3108	A
3108016	Eijsden-Margraten 	3108	A
3108019	Gennep 	3108	A
3108022	Gulpen-Wittem 	3108	A
3108025	Heerlen 	3108	A
3108028	Horst aan de Maas 	3108	A
3108031	Kerkrade 	3108	A
3108034	Landgraaf 	3108	A
3108037	Leudal 	3108	A
3108040	Maasgouw 	3108	A
3108043	Maastricht 	3108	A
3108046	Meerssen 	3108	A
3108049	Mook en Middelaar 	3108	A
3108052	Nederweert 	3108	A
3108055	Nuth 	3108	A
3108058	Onderbanken 	3108	A
3108061	Peel en Maas 	3108	A
3108064	Roerdalen 	3108	A
3108067	Roermond 	3108	A
3108070	Schinnen 	3108	A
3108073	Simpelveld 	3108	A
3108076	Sittard-Geleen 	3108	A
3108079	Stein 	3108	A
3108082	Vaals 	3108	A
3108085	Valkenburg aan de Geul 	3108	A
3108088	Venlo 	3108	A
3108091	Venray 	3108	A
3108094	Voerendaal 	3108	A
3108097	Weert 	3108	A
3109001	Aalburg	3109	A
3109004	Alphen-Chaam	3109	A
3109007	Asten	3109	A
3109010	Baarle-Nassau	3109	A
3109013	Bergeijk	3109	A
3109016	Bergen op Zoom	3109	A
3109019	Bernheze	3109	A
3109022	Berkel-Enschot	3109	A
3109025	Best	3109	A
3109028	Bladel	3109	A
3109031	Boekel	3109	A
3109034	Boxmeer	3109	A
3109037	Boxtel	3109	A
3109040	Breda	3109	A
3109043	Cranendonck	3109	A
3109046	Cuijk	3109	A
3109049	Deurne	3109	A
3109052	Dongen	3109	A
3109055	Drimmelen	3109	A
3109058	Eersel	3109	A
3109061	Eindhoven	3109	A
3109064	Etten-Leur	3109	A
3109067	Geertruidenberg	3109	A
3109070	Geldrop-Mierlo	3109	A
3109073	Gemert-Bakel	3109	A
3109076	Gilze en Rijen	3109	A
3109079	Goirle	3109	A
3109082	Grave	3109	A
3109085	Haaren	3109	A
3109088	Halderberge	3109	A
3109091	Heeze-Leende	3109	A
3109094	Helmond	3109	A
3109097	's-Hertogenbosch	3109	A
3109100	Heusden	3109	A
3109103	Hilvarenbeek	3109	A
3109106	Laarbeek	3109	A
3109109	Landerd	3109	A
3109112	Loon op Zand	3109	A
3109115	Maasdonk	3109	A
3109118	Mill en Sint Hubert	3109	A
3109121	Moerdijk	3109	A
3109124	Nuenen, Gerwen en Nederwetten	3109	A
3109127	Oirschot	3109	A
3109130	Oisterwijk	3109	A
3109133	Oosterhout	3109	A
3109136	Oss	3109	A
3109139	Reusel-De Mierden	3109	A
3109142	Roosendaal	3109	A
3109145	Rucphen	3109	A
3109148	Schaijk	3109	A
3109151	Schijndel	3109	A
3109154	Sint Anthonis	3109	A
3109157	Sint-Michielsgestel	3109	A
3109160	Sint-Oedenrode	3109	A
3109163	Someren	3109	A
3109166	Son en Breugel	3109	A
3109169	Steenbergen	3109	A
3109172	Tilburg	3109	A
3109175	Uden	3109	A
3109178	Valkenswaard	3109	A
3109181	Veghel	3109	A
3109184	Veldhoven	3109	A
3109187	Vught	3109	A
3109190	Waalre	3109	A
3109193	Waalwijk	3109	A
3109196	Werkendam	3109	A
3109199	Woensdrecht	3109	A
3109202	Woudrichem	3109	A
3109205	Zevenbergen	3109	A
3109208	Zundert	3109	A
3110001	Almelo	3110	A
3110002	Borne	3110	A
3110003	Dalfsen	3110	A
3110004	Deventer	3110	A
3110005	Dinkelland	3110	A
3110006	Enschede	3110	A
3110007	Haaksbergen	3110	A
3110008	Hardenberg	3110	A
3110009	Hellendoorn	3110	A
3110010	Hengelo	3110	A
3110011	Hof van Twente	3110	A
3110012	Kampen	3110	A
3110013	Losser	3110	A
3110014	Oldenzaal	3110	A
3110015	Olst-Wijhe	3110	A
3110016	Ommen	3110	A
3110017	Raalte	3110	A
3110018	Rijssen-Holten	3110	A
3110019	Staphorst	3110	A
3110020	Steenwijkerland	3110	A
3110021	Tubbergen	3110	A
3110022	Twenterand	3110	A
3110023	Wierden	3110	A
3110024	Zwartewaterland	3110	A
3110025	Zwolle	3110	A
3102001	Aalsmeer	3102	A
3102004	Alkmaar	3102	A
3102007	Amstelveen	3102	A
3102010	Amsterdam	3102	A
3102013	Anna Paulowna	3102	A
3102016	Beemster	3102	A
3102019	Bergen	3102	A
3102022	Beverwijk	3102	A
3102025	Blaricum	3102	A
3102028	Bloemendaal	3102	A
3102031	Bussum	3102	A
3102034	Castricum	3102	A
3102037	Den Helder	3102	A
3102040	Diemen	3102	A
3102043	Drechterland	3102	A
3102046	Edam-Volendam	3102	A
3102049	Enkhuizen	3102	A
3102052	Graft-De Rijp	3102	A
3102055	Haarlem	3102	A
3102058	Haarlemmerliede en Spaarnwoude	3102	A
3102061	Haarlemmermeer	3102	A
3102064	Harenkarspel	3102	A
3102067	Heemskerk	3102	A
3102070	Heemstede	3102	A
3102073	Heerhugowaard	3102	A
3102076	Heiloo	3102	A
3102079	Hilversum	3102	A
3102082	Hoorn	3102	A
3102085	Huizen	3102	A
3102088	Koggenland	3102	A
3102091	Landsmeer	3102	A
3102094	Langedijk	3102	A
3102097	Laren	3102	A
3102100	Medemblik	3102	A
3102103	Muiden	3102	A
3102106	Naarden	3102	A
3102109	Niedorp	3102	A
3102112	Oostzaan	3102	A
3102115	Opmeer	3102	A
3102118	Ouder-Amstel	3102	A
3102121	Purmerend	3102	A
3102124	Schagen	3102	A
3102127	Schermer	3102	A
3102130	Stede Broec	3102	A
3102133	Texel	3102	A
3102136	Uitgeest	3102	A
3102139	Uithoorn	3102	A
3102142	Velsen	3102	A
3102145	Waterland	3102	A
3102148	Weesp	3102	A
3102151	Wieringen	3102	A
3102154	Wieringermeer	3102	A
3102157	Wijdemeren	3102	A
3102160	Wormerland	3102	A
3102163	Zaanstad	3102	A
3102166	Zandvoort	3102	A
3102169	Zeevang	3102	A
3102172	Zijpe	3102	A
3101001	Alblasserdam	3101	A
3101004	Albrandswaard	3101	A
3101007	Alphen aan den Rijn	3101	A
3101010	Barendrecht	3101	A
3101013	Bergambacht	3101	A
3101016	Bernisse	3101	A
3101019	Binnenmaas	3101	A
3101022	Bodegraven	3101	A
3101025	Boskoop	3101	A
3101028	Brielle	3101	A
3101031	Capelle aan den IJssel	3101	A
3101034	Cromstrijen	3101	A
3101037	Delft	3101	A
3101040	Dirksland	3101	A
3101043	Dordrecht	3101	A
3101046	Giessenlanden	3101	A
3101049	Goedereede	3101	A
3101052	Gorinchem	3101	A
3101055	Gouda	3101	A
3101058	Graafstroom	3101	A
3101061	Hardinxveld-Giessendam	3101	A
3101064	Hellevoetsluis	3101	A
3101067	Hendrik-Ido-Ambacht	3101	A
3101070	Hillegom	3101	A
3101073	Kaag en Braassem	3101	A
3101076	Katwijk	3101	A
3101079	Korendijk	3101	A
3101082	Krimpenaand en IJssel	3101	A
3101085	Lansingerland	3101	A
3101088	Leerdam	3101	A
3101091	Leiden	3101	A
3101094	Leiderdorp	3101	A
3101097	Leidschendam-Voorburg	3101	A
3101100	Liesveld	3101	A
3101103	Lisse	3101	A
3101106	Maassluis	3101	A
3101109	Middelharnis	3101	A
3101112	Midden-Delfland	3101	A
3101115	Nederlek	3101	A
3101118	Nieuwkoop	3101	A
3101121	Nieuw-Lekkerland	3101	A
3101124	Noordwijk	3101	A
3101127	Noordwijkerhout	3101	A
3101130	Oegstgeest	3101	A
3101133	Oostflakkee	3101	A
3101136	Oud-Beijerland	3101	A
3101139	Ouderkerk	3101	A
3101142	Papendrecht	3101	A
3101145	Pijnacker-Nootdorp	3101	A
3101148	Reeuwijk	3101	A
3101151	Ridderkerk	3101	A
3101154	Rijnwoude	3101	A
3101157	Rijswijk	3101	A
3101160	Rotterdam	3101	A
3101163	Schiedam	3101	A
3101166	Schoonhoven	3101	A
3101169	Sliedrecht	3101	A
3101172	Spijkenisse	3101	A
3101175	Strijen	3101	A
3101178	Teylingen	3101	A
3101181	La Haya	3101	A
3101184	Vlaardingen	3101	A
3101187	Vlist	3101	A
3101190	Voorschoten	3101	A
3101193	Waddinxveen	3101	A
3101196	Wassenaar	3101	A
3101199	Westland	3101	A
3101202	Westvoorne	3101	A
3101205	Zederik	3101	A
3101208	Zoetermeer	3101	A
3101211	Zoeterwoude	3101	A
3101214	Zuidplas	3101	A
3101217	Zwijndrecht	3101	A
3111004	Amersfoort	3111	A
3111007	Baarn	3111	A
3111013	Bunnik	3111	A
3111016	Bunschoten	3111	A
3111019	De Bilt	3111	A
3111022	De Ronde Venen	3111	A
3111025	Eemnes	3111	A
3111028	Houten	3111	A
3111031	IJsselstein	3111	A
3111034	Leusden	3111	A
3111040	Lopik	3111	A
3111046	Montfoort	3111	A
3111049	Nieuwegein	3111	A
3111052	Oudewater	3111	A
3111055	Renswoude	3111	A
3111058	Rhenen	3111	A
3111061	Soest	3111	A
3111062	Stichtse Vecht 	3111	A
3111064	Utrecht	3111	A
3111067	Utrechtse Heuvelrug	3111	A
3111070	Veenendaal	3111	A
3111073	Vianen	3111	A
3111079	Wijk bij Duurstede	3111	A
3111082	Woerden	3111	A
3111085	Woudenberg	3111	A
3111088	Zeist	3111	A
3112001	Borsele	3112	A
3112004	Goes	3112	A
3112007	Hulst	3112	A
3112010	Kapelle	3112	A
3112013	Middelburg	3112	A
3112016	Noord-Beveland	3112	A
3112019	Reimerswaal	3112	A
3112022	Schouwen-Duiveland	3112	A
3112025	Sluis	3112	A
3112028	Terneuzen	3112	A
3112031	Tholen	3112	A
3112034	Veere 	3112	A
3112037	Vlissingen	3112	A
3201998	Indeterminado	3201	A
3204998	Indeterminado	3204	A
3208998	Indeterminado	3208	A
3212998	Indeterminado	3212	A
3216998	Indeterminado	3216	A
3220998	Indeterminado	3220	A
3224998	Indeterminado	3224	A
3228998	Indeterminado	3228	A
3232998	Indeterminado	3232	A
3236998	Indeterminado	3236	A
3240998	Indeterminado	3240	A
3200001	Amberes	3201	A
3200004	Malinas	3201	A
3200008	Turnhout	3201	A
3200010	Hal-Vilvoorde	3204	A
3200012	Lovaina	3204	A
3208001	Nivelles	3208	A
3212001	Bruselas	3212	A
3216001	Aalst	3216	A
3216002	Dendermonde	3216	A
3216003	Eeklo	3216	A
3216004	Gante	3216	A
3216005	Oudenaarde	3216	A
3216006	Sint-Niklaas	3216	A
3220001	Brujas	3220	A
3220002	Diksmuide	3220	A
3220003	Ostend	3220	A
3220004	Roeselare	3220	A
3220005	Tielt	3220	A
3220006	Kortrijk	3220	A
3220007	Ypres	3220	A
3220008	Veurne	3220	A
3224001	Ath	3224	A
3224002	Charleroi	3224	A
3224003	Mons	3224	A
3224004	Mouscron	3224	A
3224005	Soignies	3224	A
3224006	Thuin	3224	A
3224007	Tournai	3224	A
3228001	Huy	3228	A
3228002	Lieja	3228	A
3228003	Verviers	3228	A
3228004	Waremme	3228	A
3232001	Hasselt	3232	A
3232002	Maaseik	3232	A
3232003	Tongeren	3232	A
3236001	Arlon	3236	A
3236002	Bastogne	3236	A
3236003	Marche-en-Famenne	3236	A
3236004	Neufchâteau	3236	A
3236005	Virton	3236	A
3240001	Dinant	3240	A
3240002	Namur	3240	A
3240003	Philippeville	3240	A
3301998	Indeterminado	3301	A
3305998	Indeterminado	3305	A
3309998	Indeterminado	3309	A
3313998	Indeterminado	3313	A
3317998	Indeterminado	3317	A
3321998	Indeterminado	3321	A
3325998	Indeterminado	3325	A
3329998	Indeterminado	3329	A
3333998	Indeterminado	3333	A
3337998	Indeterminado	3337	A
3341998	Indeterminado	3341	A
3345998	Indeterminado	3345	A
3349998	Indeterminado	3349	A
3353998	Indeterminado	3353	A
3357998	Indeterminado	3357	A
3361998	Indeterminado	3361	A
3367998	Indeterminado	3367	A
3371998	Indeterminado	3371	A
3373998	Indeterminado	3373	A
3375998	Indeterminado	3375	A
3379998	Indeterminado	3379	A
3383998	Indeterminado	3383	A
3387998	Indeterminado	3387	A
3391998	Indeterminado	3391	A
3395998	Indeterminado	3395	A
3399998	Indeterminado	3399	A
33010004	Alto Rin	3301	A
33010008	Bajo Rin	3301	A
33050004	Eure	3305	A
33050008	Sena Marítimo	3305	A
33090004	Dordoña	3309	A
33090008	Gironda	3309	A
33090012	Landas	3309	A
33090016	Lot y Garona	3309	A
33090020	Pirineos Atlánticos	3309	A
33130004	Allier	3313	A
33130008	Cantal	3313	A
33130012	Alto Loira	3313	A
33130016	Puy-de-Dôme	3313	A
33170004	Côte-d Or	3317	A
33170008	Nièvre	3317	A
33170012	Saône-et-Loire	3317	A
33170016	Yonne	3317	A
33210004	Côtes-d Armor	3321	A
33210008	Finisterre	3321	A
33210012	Ille et Vilaine	3321	A
33210016	Morbihan	3321	A
33250004	Cher	3325	A
33250008	Eure-et-Loir	3325	A
33250012	Indre	3325	A
33250016	Indre-et-Loire	3325	A
33250020	Loir-et-Cher	3325	A
33250024	Loiret	3325	A
33290004	Ardenas	3329	A
33290008	Aube	3329	A
33290012	Marne	3329	A
33290016	Alto Marne	3329	A
33330004	Córcega del Sur	3333	A
33330008	Alta Córcega	3333	A
33370004	Doubs	3337	A
33370008	Jura	3337	A
33370012	Haute-Saône	3337	A
33370016	Territorio de Belfort	3337	A
33410004	Essonne	3341	A
33410008	Hauts-de-Seine	3341	A
33410012	París	3341	A
33410016	Seine-Saint-Denis	3341	A
33410020	Seine-et-Marne	3341	A
33410024	Val-de-Marne	3341	A
33410028	Val-d Oise	3341	A
33410032	Yvelines	3341	A
33450004	Corrèze	3345	A
33450008	Creuse	3345	A
33450012	Haute-Vienne	3345	A
33490004	Aude	3349	A
33490008	Gard	3349	A
33490012	Hérault	3349	A
33490016	Lozère	3349	A
33490020	Pirineos Orientales	3349	A
33530004	Meurthe y Moselle	3353	A
33530008	Meuse	3353	A
33530012	Moselle	3353	A
33530016	Vosgos	3353	A
33570004	Ariège	3357	A
33570008	Aveyron	3357	A
33570012	Gers	3357	A
33570016	Alto Garona	3357	A
33570020	Altos Pirineos	3357	A
33570024	Lot	3357	A
33570028	Tarn	3357	A
33570032	Tarn y Garona	3357	A
33610004	Nord	3361	A
33610008	Pas-de-Calais	3361	A
33670004	Calvados	3367	A
33670008	Manche	3367	A
33670012	Orne	3367	A
33710004	Loira Atlántico	3371	A
33710008	Maine y Loira	3371	A
33710012	Mayenne	3371	A
33710016	Sarthe	3371	A
33710020	Vendée	3371	A
33730004	Aisne	3373	A
33730008	Oise	3373	A
33730012	Somme	3373	A
33750004	Charente	3375	A
33750008	Charente Marítimo	3375	A
33750012	Deux-Sèvres	3375	A
33750016	Vienne	3375	A
33790004	Alpes-de-Haute-Provence	3379	A
33790008	Alpes-Maritimes	3379	A
33790012	Bouches-du-Rhône	3379	A
33790016	Hautes-Alpes	3379	A
33790020	Var	3379	A
33790024	Vaucluse	3379	A
33830004	Ain	3383	A
33830008	Alta Saboya	3383	A
33830012	Ardèche	3383	A
33830016	Drôme	3383	A
33830020	Isère	3383	A
33830024	Loira	3383	A
33830028	Ródano	3383	A
33830032	Saboya	3383	A
33870004	Guadalupe	3387	A
33910004	Martinica	3391	A
33950004	Guayana	3395	A
33990004	Reunion	3399	A
3405124	Almería	3405	A
3405248	Cádiz	3405	A
3405372	Córdoba	3405	A
3405496	Granada	3405	A
3405620	Huelva	3405	A
3405744	Jaén	3405	A
3405868	Málaga	3405	A
3405992	Sevilla	3405	A
3405998	Indeterminado	3405	A
3410300	Huesca	3410	A
3410600	Teruel	3410	A
3410900	Zaragoza	3410	A
3410998	Indeterminado	3410	A
3415500	Asturias 	3415	A
3415998	Indeterminado	3415	A
3420500	Cantabria 	3420	A
3420998	Indeterminado	3420	A
3425198	Albacete	3425	A
3425396	Ciudad Real	3425	A
3425594	Cuenca	3425	A
3425792	Guadalajara	3425	A
3425990	Toledo  	3425	A
3425998	Indeterminado	3425	A
3430110	Avila	3430	A
3430220	Burgos	3430	A
3430330	León	3430	A
3430440	Palencia	3430	A
3430550	Salamanca	3430	A
3430660	Segovia	3430	A
3430770	Soria	3430	A
3430880	Valladolid	3430	A
3430990	Zamora	3430	A
3430998	Indeterminado	3430	A
3435248	Barcelona	3435	A
3435496	Girona	3435	A
3435744	Lleida	3435	A
3435992	Tarragona	3435	A
3435998	Indeterminado	3435	A
3440400	Badajoz	3440	A
3440800	Cáceres	3440	A
3440998	Indeterminado	3440	A
3445248	A Coruña	3445	A
3445496	Lugo	3445	A
3445744	Ourense	3445	A
3445992	Pontevedra	3445	A
3445998	Indeterminado	3445	A
3450500	Islas Baleares 	3450	A
3450998	Indeterminado	3450	A
3455400	Las Palmas	3455	A
3455800	Santa Cruz de Tenerife	3455	A
3455998	Indeterminado	3455	A
3460500	La Rioja 	3460	A
3460998	Indeterminado	3460	A
3465500	Madrid 	3465	A
3465998	Indeterminado	3465	A
3470500	Murcia 	3470	A
3470998	Indeterminado	3470	A
3475500	Navarra 	3475	A
3475998	Indeterminado	3475	A
3480330	Alava	3480	A
3480660	Guipuzcoa	3480	A
3480990	Vizcaya	3480	A
3480998	Indeterminado	3480	A
3485330	Alicante	3485	A
3485660	Castellón	3485	A
3485990	Valencia	3485	A
3485998	Indeterminado	3485	A
3490500	Ceuta 	3490	A
3490998	Indeterminado	3490	A
3495500	Melilla 	3495	A
3495998	Indeterminado	3495	A
3498998	Indeterminado	3498	A
3904998	Indeterminado	3904	A
3908998	Indeterminado	3908	A
3912998	Indeterminado	3912	A
3916998	Indeterminado	3916	A
3920998	Indeterminado	3920	A
3924998	Indeterminado	3924	A
3928998	Indeterminado	3928	A
3932998	Indeterminado	3932	A
3936998	Indeterminado	3936	A
3940998	Indeterminado	3940	A
3944998	Indeterminado	3944	A
3948998	Indeterminado	3948	A
3952998	Indeterminado	3952	A
3956998	Indeterminado	3956	A
3960998	Indeterminado	3960	A
3964998	Indeterminado	3964	A
3968998	Indeterminado	3968	A
3972998	Indeterminado	3972	A
3976998	Indeterminado	3976	A
3980998	Indeterminado	3980	A
3904007	Chieti	3904	A
3904014	L'Aquila	3904	A
3904021	Pescara	3904	A
3904028	Teramo	3904	A
3908007	Bari	3908	A
3908014	Brindisi	3908	A
3908021	Foggia	3908	A
3908028	Lecce	3908	A
3908035	Taranto	3908	A
3912007	Matera	3912	A
3912014	Potenza	3912	A
3916007	Catanzaro	3916	A
3916014	Cosenza	3916	A
3916021	Crotone	3916	A
3916028	Reggio Calabria	3916	A
3916035	Vibo-Valentia	3916	A
3920007	Avellino	3920	A
3920014	Benevento	3920	A
3920021	Caserta	3920	A
3920028	Napoli	3920	A
3920035	Salerno	3920	A
3924007	Cagliari	3924	A
3924014	Nuoro	3924	A
3924021	Oristano	3924	A
3924028	Sassari	3924	A
3928007	Bologna	3928	A
3928014	Ferrara	3928	A
3928021	Forlì-Cesena	3928	A
3928028	Modena	3928	A
3928035	Parma	3928	A
3928042	Piacenza	3928	A
3928049	Ravenna	3928	A
3928056	Reggio Emilia	3928	A
3928063	Rimini	3928	A
3932007	Gorizia	3932	A
3932014	Pordenone	3932	A
3932021	Trieste	3932	A
3932028	Udine	3932	A
3936007	Ancona	3936	A
3936014	Ascoli Piceno	3936	A
3936021	Macerata	3936	A
3936028	Pesaro e Urbino	3936	A
3940007	Frosinone	3940	A
3940014	Latina	3940	A
3940021	Rieti	3940	A
3940028	Roma	3940	A
3940035	Viterbo	3940	A
3944007	Genova	3944	A
3944014	Imperia	3944	A
3944021	La Spezia	3944	A
3944028	Savona	3944	A
3948007	Bergamo	3948	A
3948014	Brescia	3948	A
3948021	Como	3948	A
3948028	Cremona	3948	A
3948035	Lecco	3948	A
3948042	Lodi	3948	A
3948049	Mantova	3948	A
3948056	Milano	3948	A
3948063	Pavia	3948	A
3948070	Sondrio	3948	A
3948077	Varese	3948	A
3952007	Campobasso	3952	A
3952014	Isernia	3952	A
3956007	Alessandria	3956	A
3956014	Asti	3956	A
3956021	Biella	3956	A
3956028	Cuneo	3956	A
3956035	Novara	3956	A
3956042	Torino	3956	A
3956049	Verbano Cusio Ossola	3956	A
3956056	Vercelli	3956	A
3960007	Agrigento	3960	A
3960014	Caltanissetta	3960	A
3960021	Catania	3960	A
3960028	Enna	3960	A
3960035	Messina	3960	A
3960042	Palermo	3960	A
3960049	Ragusa	3960	A
3960056	Siracusa	3960	A
3960063	Trapani	3960	A
3964007	Arezzo	3964	A
3964014	Firenze	3964	A
3964021	Grosseto	3964	A
3964028	Livorno	3964	A
3964035	Lucca	3964	A
3964042	Massa Carrara	3964	A
3964049	Pisa	3964	A
3964056	Pistoia	3964	A
3964063	Prato	3964	A
3964070	Siena	3964	A
3968007	Bolzano	3968	A
3968014	Trento	3968	A
3972007	Perugia	3972	A
3972014	Terni	3972	A
3976500	Aosta	3976	A
3980007	Belluno	3980	A
3980014	Padova	3980	A
3980021	Rovigo	3980	A
3980028	Treviso	3980	A
3980035	Venezia	3980	A
3980042	Verona	3980	A
3980049	Vicenza	3980	A
3998998	Indeterminado	3998	A
3924010	Carbonia-Iglesias	3924	A
3924012	Medio Campidano	3924	A
3924017	Olbia-Tempio	3924	A
3924019	Ogliastra	3924	A
3908011	Barletta-Andria-Trani	3908	A
3936018	Fermo	3936	A
3948060	Monza y Brianza	3948	A
4101998	Indeterminado	4101	A
4101043	Appenzell Ausser-Rhoden, Inner-Rhoden	4101	A
4101086	Argovia	4101	A
4101129	Berna	4101	A
4101172	Basilea	4101	A
4101215	Friburgo	4101	A
4101258	Ginebra	4101	A
4101301	Glarus	4101	A
4101344	Grisones	4101	A
4101387	Jura	4101	A
4101430	Lucerna	4101	A
4101473	Neuchâtel	4101	A
4101516	Nidwalden y Obwalden	4101	A
4101559	Sankt Gallen	4101	A
4101602	Schaffhausen	4101	A
4101645	Schwyz	4101	A
4101688	Solothurn	4101	A
4101731	Ticino	4101	A
4101774	Turgovia	4101	A
4101817	Uri	4101	A
4101860	Valais	4101	A
4101903	Vaud	4101	A
4101946	Zug	4101	A
4101989	Zúrich	4101	A
4401998	Indeterminado	4401	A
4402998	Indeterminado	4402	A
4403998	Indeterminado	4403	A
4404998	Indeterminado	4404	A
4405998	Indeterminado	4405	A
4406998	Indeterminado	4406	A
4407998	Indeterminado	4407	A
4408998	Indeterminado	4408	A
4409998	Indeterminado	4409	A
4430998	Indeterminado	4430	A
4450998	Indeterminado	4450	A
4470998	Indeterminado	4470	A
4401001	London	4401	A
4402001	Derbyshire	4402	A
4402002	Derby	4402	A
4402003	Nottinghamshire	4402	A
4402004	Nottingham	4402	A
4402005	Lincolnshire	4402	A
4402006	Leicestershire	4402	A
4402007	Leicester	4402	A
4402008	Rutland	4402	A
4402009	Northamptonshire	4402	A
4403001	Thurrock	4403	A
4403002	Southend-on-Sea	4403	A
4403003	Essex	4403	A
4403004	Hertfordshire	4403	A
4403005	Luton	4403	A
4403006	Bedford	4403	A
4403007	Central Bedfordshire	4403	A
4403008	Cambridgeshire	4403	A
4403009	Peterborough	4403	A
4403010	Norfolk	4403	A
4403011	Suffolk	4403	A
4404001	Northumberland	4404	A
4404002	Newcastle upon Tyne	4404	A
4404003	Gateshead	4404	A
4404004	North Tyneside	4404	A
4404005	South Tyneside	4404	A
4404006	Sunderland	4404	A
4404007	Durham	4404	A
4404008	Darlington	4404	A
4404009	Hartlepool	4404	A
4404010	Stockton-on-Tees	4404	A
4404011	Redcar and Cleveland	4404	A
4404012	Middlesbrough	4404	A
4405001	Cheshire	4405	A
4405002	Cumbria	4405	A
4405003	Greater Manchester *	4405	A
4405004	Lancashire	4405	A
4405005	Blackpool	4405	A
4405006	Blackburn with Darwen	4405	A
4405007	Merseyside	4405	A
4406001	Berkshire	4406	A
4406002	Buckinghamshire	4406	A
4406003	East Sussex	4406	A
4406004	Hampshire	4406	A
4406005	Isle of Wight	4406	A
4406006	Kent	4406	A
4406007	Oxfordshire	4406	A
4406008	Surrey	4406	A
4406009	West Sussex	4406	A
4407001	Somerset	4407	A
4407002	Bristol	4407	A
4407003	Gloucestershire	4407	A
4407004	Wiltshire	4407	A
4407005	Dorset	4407	A
4407006	Devon	4407	A
4407007	Cornwall	4407	A
4408001	Herefordshire	4408	A
4408002	Shropshire	4408	A
4408003	Staffordshire	4408	A
4408004	Stoke-on-Trent	4408	A
4408005	Warwickshire	4408	A
4408006	West Midlands	4408	A
4408007	Worcestershire	4408	A
4409001	South Yorkshire	4409	A
4409002	West Yorkshire	4409	A
4409003	North Yorkshire	4409	A
4409004	York	4409	A
4409005	East Riding of Yorkshire	4409	A
4409006	Kingston upon Hull	4409	A
4409007	Lincolnshire	4409	A
4430001	Aberdeen	4430	A
4430003	Aberdeenshire	4430	A
4430005	Angus	4430	A
4430007	Argyll and Bute	4430	A
4430009	Clackmannanshire	4430	A
4430011	Dumfries and Galloway	4430	A
4430013	Dundee	4430	A
4430015	East Ayrshire	4430	A
4430017	East Dunbartonshire	4430	A
4430019	East Lothian	4430	A
4430021	East Renfrewshire	4430	A
4430023	Edinburgh	4430	A
4430025	Falkirk	4430	A
4430027	Fife	4430	A
4430029	Glasgow	4430	A
4430031	Highland	4430	A
4430033	Inverclyde	4430	A
4430035	Midlothian	4430	A
4430037	Moray	4430	A
4430039	Na h-Eileanan Siar	4430	A
4430041	North Ayrshire	4430	A
4430043	North Lanarkshire	4430	A
4430045	Orkney	4430	A
4430047	Perth and Kinross	4430	A
4430049	Renfrewshire	4430	A
4430051	Scottish Borders	4430	A
4430053	Shetland	4430	A
4430055	South Ayrshire	4430	A
4430057	South Lanarkshire	4430	A
4430059	Stirling	4430	A
4430061	West Dunbartonshire	4430	A
4430063	West Lothian	4430	A
4450001	Blaenau Gwent	4450	A
4450002	Bridgend (Pen-y-bont ar Ogwr)	4450	A
4450003	Caerphilly (Caerffili)	4450	A
4450004	Cardiff (Caerdydd)	4450	A
4450005	Carmarthenshire (Sir Gaerfyrddin)	4450	A
4450006	Ceredigion	4450	A
4450007	Conwy	4450	A
4450008	Denbighshire (Sir Ddinbych)	4450	A
4450009	Flintshire (Sir y Fflint)	4450	A
4450010	Gwynedd	4450	A
4450011	Isle of Anglesey (Ynys Môn)	4450	A
4450012	Merthyr Tydfil (Merthyr Tudful)	4450	A
4450013	Monmouthshire (Sir Fynwy)	4450	A
4450014	Neath Port Talbot (Castell-nedd Port Talbot)	4450	A
4450015	Newport (Casnewydd)	4450	A
4450016	Pembrokeshire (Sir Benfro)	4450	A
4450017	Powys	4450	A
4450018	Rhondda Cynon Taf	4450	A
4450019	Swansea (Abertawe)	4450	A
4450020	Torfaen (Tor-faen)	4450	A
4450021	Vale of Glamorgan (Bro Morgannwg)	4450	A
4450022	Wrexham	4450	A
4470022	Antrim	4470	A
4470023	Ards	4470	A
4470024	Armagh	4470	A
4470025	Ballymena	4470	A
4470026	Ballymoney	4470	A
4470027	Banbridge	4470	A
4470028	Belfast	4470	A
4470029	Carrickfergus	4470	A
4470030	Castlereagh	4470	A
4470031	Coleraine	4470	A
4470032	Cookstown	4470	A
4470033	Craigavon	4470	A
4470034	Derry	4470	A
4470035	Down	4470	A
4470036	Dungannon and South Tyrone	4470	A
4470037	Fermanagh	4470	A
4470038	Larne	4470	A
4470039	Limavady	4470	A
4470040	Lisburn	4470	A
4470041	Magherafelt	4470	A
4470042	Moyle	4470	A
4470043	Newry and Mourne	4470	A
4470044	Newtownabbey	4470	A
4470045	North Down	4470	A
4470046	Omagh	4470	A
4470047	Strabane	4470	A
4400001	Indeterminado	4401	A
4906998	Indeterminado	4906	A
4912998	Indeterminado	4912	A
4918998	Indeterminado	4918	A
4924998	Indeterminado	4924	A
4930998	Indeterminado	4930	A
4936998	Indeterminado	4936	A
4942998	Indeterminado	4942	A
4948998	Indeterminado	4948	A
4954998	Indeterminado	4954	A
4960998	Indeterminado	4960	A
4966998	Indeterminado	4966	A
4972998	Indeterminado	4972	A
4975998	Indeterminado	4975	A
4978998	Indeterminado	4978	A
4984998	Indeterminado	4984	A
4990998	Indeterminado	4990	A
4906023	Alb-Donau	4906	A
4906046	Baden-Baden	4906	A
4906069	Biberach	4906	A
4906092	Böblingen	4906	A
4906115	Bodenseekreis	4906	A
4906138	Breisgau-Hochschwarzwald	4906	A
4906161	Calw	4906	A
4906184	Emmendingen	4906	A
4906207	Enzkreis	4906	A
4906230	Esslingen	4906	A
4906253	Freiburg im Breisgau	4906	A
4906276	Freudenstadt	4906	A
4906299	Friburgo	4906	A
4906322	Göppingen	4906	A
4906345	Heidelberg	4906	A
4906368	Heidenheim	4906	A
4906391	Heilbronn	4906	A
4906414	Hohenlohekreis	4906	A
4906437	Karlsruhe	4906	A
4906460	Konstanz	4906	A
4906483	Lörrach	4906	A
4906506	Ludwigsburg	4906	A
4906529	Main-Tauber	4906	A
4906552	Mannheim	4906	A
4906575	Neckar-Odenwald	4906	A
4906598	Ortenau	4906	A
4906621	Ostalbkreis	4906	A
4906644	Pforzheim	4906	A
4906667	Rastatt	4906	A
4906690	Ravensburg	4906	A
4906713	Rems-Murr	4906	A
4906736	Reutlingen	4906	A
4906759	Rhein-Neckar	4906	A
4906782	Rottweil	4906	A
4906805	Schwäbisch Hall	4906	A
4906828	Schwarzwald-Baar	4906	A
4906851	Sigmaringen	4906	A
4906874	Stuttgart	4906	A
4906897	Tubingen	4906	A
4906920	Tuttlingen	4906	A
4906943	Ulm	4906	A
4906954	Villingen	4906	A
4906966	Waldshut	4906	A
4906989	Zollernalbkreis	4906	A
4924043	Charlottenburg	4924	A
4924086	Friedrichshain	4924	A
4924129	Hellersdorf	4924	A
4924172	Hohenschönhausen	4924	A
4924215	Köpenick	4924	A
4924258	Kreuzberg	4924	A
4924301	Lichtenberg	4924	A
4924344	Marzahn	4924	A
4924387	Mitte	4924	A
4924430	Neukölln	4924	A
4924473	Pankow	4924	A
4924516	Prenzlauer Berg	4924	A
4924559	Reinickendorf	4924	A
4924602	Schöneberg	4924	A
4924645	Spandau	4924	A
4924688	Steglitz	4924	A
4924731	Tempelhof	4924	A
4924774	Tiergarten	4924	A
4924817	Treptow	4924	A
4924860	Wedding	4924	A
4924903	Weissensee	4924	A
4924946	Wilmersdorf	4924	A
4924989	Zehlendorf	4924	A
4930043	Barnim	4930	A
4930086	Brandeburgo	4930	A
4930129	Cottbus	4930	A
4930172	Dahme-Spreewald	4930	A
4930215	Elbe-Elster	4930	A
4930258	Fráncfort del Oder	4930	A
4930301	Havelland	4930	A
4930344	Märkisch-Oderland	4930	A
4930387	Oberhavel	4930	A
4930430	Oberspreewald-Lausitz	4930	A
4930473	Oder-Spree	4930	A
4930516	Ostprignitz-Ruppin	4930	A
4930559	Potsdam	4930	A
4930602	Potsdam-Mittelmark	4930	A
4930645	Prignitz	4930	A
4930688	Spree-Neisse	4930	A
4930731	Teltow-Fläming	4930	A
4930774	Uckermark	4930	A
4942142	Altona	4942	A
4942284	Bergedorf	4942	A
4942426	Eimsbüttel	4942	A
4942568	Hamburg Mitte	4942	A
4942710	Hamburg Nord	4942	A
4942852	Harburg	4942	A
4942994	Wandsbek	4942	A
4948039	Bergstrasse	4948	A
4948078	Darmstadt	4948	A
4948117	Darmstadt-Dieburg	4948	A
4948156	Francfort del Meno (Frankfurt am Main)	4948	A
4948195	Fulda	4948	A
4948234	Giessen	4948	A
4948273	Gross-Gerau	4948	A
4948312	Hersfeld-Rotenburg	4948	A
4948351	Hochtaunuskreis	4948	A
4948390	Kassel (ciudad)	4948	A
4948429	Lahn-Dill-Kreis (Wetzlar)	4948	A
4948468	Limburg-Weilburg	4948	A
4948507	Main-Kinzig-Kreis	4948	A
4948546	Main-Taunus-Kreis	4948	A
4948585	Marburgo-Biedenkopf	4948	A
4948624	Odenwaldkreis	4948	A
4948663	Offenbach	4948	A
4948702	Offenbach del Meno	4948	A
4948741	Rheingau-Taunus-Kreis	4948	A
4948780	Schwalm-Eder-Kreis	4948	A
4948819	Vogelsbergkreis	4948	A
4948858	Waldeck-Frankenberg	4948	A
4948897	Werra-Meissner-Kreis	4948	A
4948936	Wetteraukreis	4948	A
4948975	Wiesbaden	4948	A
4954055	Demmin	4954	A
4954110	Greifswald	4954	A
4954165	Güstrow	4954	A
4954220	Ludwigslust	4954	A
4954275	Mecklenburg-Strelitz	4954	A
4954330	Müritz	4954	A
4954385	Neubrandenburg	4954	A
4954440	Nor-Mecklenburgo Occidental (Nordwestmecklenburg)	4954	A
4954495	Parchim	4954	A
4954550	Pomerania del Norte (Nordvorpommern)	4954	A
4954605	Pomerania Occidental Oriente (Ostvorpommern)	4954	A
4954660	Rostock	4954	A
4954715	Rügen	4954	A
4954770	Schwerin	4954	A
4954825	Stralsund	4954	A
4954935	Uecker-Randow	4954	A
4954990	Wismar	4954	A
4960018	Aquisgrán (Aachen)	4960	A
4960036	Bielefeld	4960	A
4960054	Bochum	4960	A
4960072	Bonn	4960	A
4960090	Borken	4960	A
4960108	Bottrop	4960	A
4960126	Cléveris (Kleve)	4960	A
4960144	Coesfeld	4960	A
4960162	Colonia	4960	A
4960180	Dortmund	4960	A
4960198	Duisburgo	4960	A
4960216	Düren	4960	A
4960234	Düsseldorf	4960	A
4960252	Ennepe-Ruhr	4960	A
4960270	Essen	4960	A
4960288	Euskirchen	4960	A
4960306	Gelsenkirchen	4960	A
4960324	Gütersloh	4960	A
4960342	Hagen	4960	A
4960360	Hamm	4960	A
4960378	Heinsberg	4960	A
4960396	Herford	4960	A
4960414	Herne	4960	A
4960432	Hochsauerland	4960	A
4960450	Höxter	4960	A
4960468	Krefeld	4960	A
4960486	Leverkusen	4960	A
4960504	Lippe	4960	A
4960522	Märkischer Kreis	4960	A
4960540	Mettmann	4960	A
4960558	Minden-Lübbecke	4960	A
4960576	Mönchengladbach	4960	A
4960594	Mülheim an der Ruhr	4960	A
4960612	Münster	4960	A
4960630	Oberbergischer Kreis	4960	A
4960648	Oberhausen	4960	A
4960666	Olpe	4960	A
4960684	Paderborn	4960	A
4960702	Recklinghausen	4960	A
4960720	Remscheid	4960	A
4960738	Rheinisch-Bergischer Kreis	4960	A
4960756	Rin Neuss	4960	A
4960774	Rin-Erft	4960	A
4960792	Rin-Sieg	4960	A
4960810	Siegen-Wittgenstein	4960	A
4960828	Soest	4960	A
4960846	Solingen	4960	A
4960864	Steinfurt	4960	A
4960882	Unna	4960	A
4960900	Viersen	4960	A
4960918	Warendorf	4960	A
4960936	Wesel	4960	A
4960954	Wuppertal	4960	A
4966041	Ahrweiler	4966	A
4966082	Altenkirchen	4966	A
4966123	Alzey-Worms	4966	A
4966164	Bad Dürkheim	4966	A
4966205	Bad Kreuznach	4966	A
4966246	Bernkastel-Wittlich	4966	A
4966287	Birkenfeld	4966	A
4966328	Bitburg-Prüm	4966	A
4966369	Cochem-Zell	4966	A
4966410	Vulkaneifel	4966	A
4966451	Donnersbergkreis	4966	A
4966492	Germersheim	4966	A
4966533	Kaiserslautern	4966	A
4966574	Kusel	4966	A
4966615	Mainz-Bingen	4966	A
4966656	Mayen-Koblenz	4966	A
4966697	Neuwied	4966	A
4966738	Rhein-Hunsrück-Kreis	4966	A
4966779	Rhein-Lahn-Kreis	4966	A
4966820	Rhein-Pfalz-Kreis	4966	A
4966861	Südliche Weinstrasse	4966	A
4966902	Südwestpfalz	4966	A
4966943	Trier-Saarburg	4966	A
4966984	Westerwaldkreis	4966	A
4972105	Bautzen	4972	A
4972140	Chemnitz	4972	A
4972210	Distrito de Chemnitzer	4972	A
4972245	Leipzig (Distrito)	4972	A
4972315	Dresde	4972	A
4972385	Görlitz	4972	A
4972490	Leipzig	4972	A
4972560	Meissen	4972	A
4972875	Vogtlandkreis	4972	A
4972945	Zwickau	4972	A
4975041	Altmarkkreis Salzwedel	4975	A
4975082	Anhalt-Zerbst	4975	A
4975164	Bernburg	4975	A
4975205	Bitterfeld	4975	A
4975246	Bördekreis	4975	A
4975287	Burgenlandkreis	4975	A
4975328	Dessau	4975	A
4975369	Halberstadt	4975	A
4975410	Halle (Saale)	4975	A
4975451	Jerichower	4975	A
4975492	Köthen	4975	A
4975533	Magdeburgo	4975	A
4975574	Mansfelder	4975	A
4975615	Merseburg-Querfurt	4975	A
4975656	Ohrekreis	4975	A
4975697	Quedlinburg	4975	A
4975738	Saalkreis	4975	A
4975779	Sangerhausen	4975	A
4975820	Schönebeck	4975	A
4975861	Stendal	4975	A
4975902	Weissenfels	4975	A
4975943	Wernigerode	4975	A
4975984	Wittenberg	4975	A
4978166	Merzig-Wadern	4978	A
4978322	Neunkirchen	4978	A
4978478	Saarlouis	4978	A
4978634	Sankt Wendel	4978	A
4978790	Saarpfalz	4978	A
4978946	Stadtverband Saarbrücken (Sarrebruck)	4978	A
4990049	Altenburger Land	4990	A
4990196	Eisenach	4990	A
4990245	Erfurt	4990	A
4990294	Gera	4990	A
4990343	Gotha	4990	A
4990392	Greiz	4990	A
4990490	Jena	4990	A
4990637	Nordhausen	4990	A
4990784	Sömmerda	4990	A
4990882	Sonneberg	4990	A
4990931	Suhl	4990	A
4990980	Weimar	4990	A
4912001	Ammerland	4912	A
4912002	Aurich	4912	A
4912003	Grafschaft Bentheim	4912	A
4912004	Celle	4912	A
4912005	Cloppenburg	4912	A
4912006	Cuxhaven	4912	A
4912007	Diepholz	4912	A
4912008	Emsland	4912	A
4912009	Friesland	4912	A
4912010	Gifhorn	4912	A
4912011	Goslar	4912	A
4912012	Göttingen	4912	A
4912013	Hameln-Pyrmont	4912	A
4912014	Hannover	4912	A
4912015	Harburg	4912	A
4912016	Helmstedt	4912	A
4912017	Hildesheim	4912	A
4912018	Holzminden	4912	A
4912019	Leer	4912	A
4912020	Lüchow-Dannenberg	4912	A
4912021	Lüneburg	4912	A
4912022	Nienburg	4912	A
4912023	Northeim	4912	A
4912024	Oldenburg	4912	A
4912025	Osnabrück	4912	A
4912026	Osterholz	4912	A
4912027	Osterode	4912	A
4912028	Peine	4912	A
4912029	Rotenburg	4912	A
4912030	Schaumburg	4912	A
4912031	Soltau-Fallingbostel	4912	A
4912032	Stade	4912	A
4912033	Uelzen	4912	A
4912034	Vechta	4912	A
4912035	Verden	4912	A
4912036	Wesermarsch	4912	A
4912037	Wittmund	4912	A
4912038	Wolfenbüttel	4912	A
4912039	Braunschweig	4912	A
4912040	Delmenhorst	4912	A
4912041	Emden	4912	A
4912042	Hannover Ciudad	4912	A
4912043	Oldenburg Ciudad	4912	A
4912044	Osnabrück Ciudad	4912	A
4912045	Salzgitter	4912	A
4912046	Wilhelmshaven	4912	A
4912047	Wolfsburg	4912	A
4948398	Kassel	4948	A
4954045	Bad Doberan	4954	A
4966475	Frankenthal	4966	A
4966551	Kaiserslautern (distrito)	4966	A
4966563	Koblenz	4966	A
4966583	Landau	4966	A
4966595	Ludwigshafen	4966	A
4966607	Mainz	4966	A
4966671	Neustadt	4966	A
4966683	Pirmasens	4966	A
4966845	Speyer	4966	A
4966927	Trier	4966	A
4966989	Worms	4966	A
4966995	Zweibrücken	4966	A
4972330	Erzgebirgskreis	4972	A
4972610	Mittelsachsen	4972	A
4972670	Nordsachsen	4972	A
4972775	Sächsische Schweiz-Osterzgebirge	4972	A
4975061	Anhalt-Bitterfeld	4975	A
4975123	Harz	4975	A
4975389	Salzland	4975	A
4990090	Eichsfeld	4990	A
4990430	Hildburghausen	4990	A
4990460	Ilm-Kreis	4990	A
4990550	Kyffhäuserkreis	4990	A
4990649	Saale-Holzland	4990	A
4990690	Saale-Orla	4990	A
4990710	Saalfeld-Rudolstadt	4990	A
4990745	Schmalkalden-Meiningen	4990	A
4990941	Unstrut-Hainich	4990	A
4990953	Wartburgkreis	4990	A
4990985	Weimarer Land	4990	A
4984001	Dithmarschen	4984	A
4984003	Flensburg	4984	A
4984005	Kiel	4984	A
4984007	Lauenburg	4984	A
4984009	Lübeck	4984	A
4984011	Neumünster	4984	A
4984013	Nordfriesland	4984	A
4984015	Ostholstein	4984	A
4984017	Pinneberg	4984	A
4984019	Plön	4984	A
4984021	Rendsburg-Eckernförde	4984	A
4984023	Schleswig-Flensburg	4984	A
4984025	Segeberg	4984	A
4984027	Steinburg	4984	A
4984029	Stormarn	4984	A
4918014	Aichach-Friedberg	4918	A
4918028	Algovia Oriental	4918	A
4918042	Alta Algovia	4918	A
4918056	Altötting	4918	A
4918070	Amberg	4918	A
4918084	Ansbach	4918	A
4918098	Aschaffenburgo	4918	A
4918112	Augsburgo	4918	A
4918126	Bad Kissingen	4918	A
4918140	Bad Tölz	4918	A
4918154	Baja Algovia	4918	A
4918168	Bamberg	4918	A
4918182	Bayreuth	4918	A
4918196	Berchtesgadener	4918	A
4918210	Cham	4918	A
4918224	Coburg	4918	A
4918238	Dachau	4918	A
4918252	Danubio-Ries 19. Ebersberg	4918	A
4918266	Deggendorf	4918	A
4918280	Dilinga	4918	A
4918294	Dingolfing	4918	A
4918308	Eichstätt	4918	A
4918322	Erding	4918	A
4918336	Erlangen-Höchstadt	4918	A
4918350	Forchheim	4918	A
4918364	Freyung	4918	A
4918378	Freising	4918	A
4918392	Fürstenfeldbruck	4918	A
4918406	Fürth	4918	A
4918420	Garmisch	4918	A
4918434	Gunzburgo	4918	A
4918448	Haßberge	4918	A
4918462	Hof	4918	A
4918466	Ingolstadt	4918	A
4918470	Kaufbeuren	4918	A
4918476	Kelheim	4918	A
4918482	Kempten	4918	A
4918490	Kitzingen	4918	A
4918504	Kronach	4918	A
4918518	Kulmbach	4918	A
4918532	Landsberg	4918	A
4918538	Landshut	4918	A
4918546	Lichtenfels	4918	A
4918560	Lindau	4918	A
4918574	Main-Spessart	4918	A
4918480	Memmingen	4918	A
4918588	Miesbach	4918	A
4918602	Miltenberg	4918	A
4918616	Mühldorf	4918	A
4918630	Munich	4918	A
4918644	Neuburg	4918	A
4918658	Neumarkt	4918	A
4918672	Neustadt	4918	A
4918686	Neu-Ulm	4918	A
4918700	Nuremberg	4918	A
4918714	Passau	4918	A
4918728	Pfaffenhofen	4918	A
4918736	Regen	4918	A
4918742	Regensburg (Ratisbona)	4918	A
4918756	Rhön	4918	A
4918770	Rosenheim	4918	A
4918784	Roth	4918	A
4918798	Rottal-Inn	4918	A
4918804	Schwabach	4918	A
4918812	Schwandorf	4918	A
4918826	Schweinfurt	4918	A
4918840	Starnberg	4918	A
4918854	Straubing	4918	A
4918868	Tirschenreu	4918	A
4918882	Traunstein	4918	A
4918888	Weiden	4918	A
4918896	Weilheim	4918	A
4918910	Weissenburg	4918	A
4918924	Wunsiedel	4918	A
4918938	Wurzburgo	4918	A
5120998	Indeterminado	5120	A
5124998	Indeterminado	5124	A
5126998	Indeterminado	5126	A
5128998	Indeterminado	5128	A
5132998	Indeterminado	5132	A
5136998	Indeterminado	5136	A
5140998	Indeterminado	5140	A
5144998	Indeterminado	5144	A
5148998	Indeterminado	5148	A
5152998	Indeterminado	5152	A
5156998	Indeterminado	5156	A
5160998	Indeterminado	5160	A
5164998	Indeterminado	5164	A
5168998	Indeterminado	5168	A
5172998	Indeterminado	5172	A
5176998	Indeterminado	5176	A
5180998	Indeterminado	5180	A
5184998	Indeterminado	5184	A
5188998	Indeterminado	5188	A
5192998	Indeterminado	5192	A
5196998	Indeterminado	5196	A
5104142	Bagua	5104	A
5104284	Bongará	5104	A
5104426	Condorcanqui	5104	A
5104568	Chachapoyas	5104	A
5104710	Luya	5104	A
5104852	Rodríguez de Mendoza	5104	A
5104994	Utcubamba	5104	A
5104998	Indeterminado	5104	A
5108049	Aija	5108	A
5108098	Antonio Raimondi	5108	A
5108147	Asunción	5108	A
5108196	Bolognesi	5108	A
5108245	Carhuáz	5108	A
5108294	Casma	5108	A
5108343	Corongo	5108	A
5108392	Huaraz	5108	A
5108441	Huari	5108	A
5108490	Huarmey	5108	A
5108539	Huaylas	5108	A
5108588	Mariscal Luzuriaga	5108	A
5108637	Ocros	5108	A
5108686	Pallasca	5108	A
5108735	Pomabamba	5108	A
5108784	Recuay	5108	A
5108833	Carlos Fermín Fitzcarrald	5108	A
5108882	Santa	5108	A
5108931	Sihuas	5108	A
5108980	Yungay	5108	A
5108998	Indeterminado	5108	A
5112142	Abancay	5112	A
5112284	Andahuaylas	5112	A
5112426	Antabamba	5112	A
5112568	Aymaraes	5112	A
5112710	Chincheros	5112	A
5112852	Cotabambas	5112	A
5112994	Grau	5112	A
5112998	Indeterminado	5112	A
5116124	Arequipa	5116	A
5116248	Camaná	5116	A
5116372	Caravelí	5116	A
5116496	Castilla	5116	A
5116620	Caylloma	5116	A
5116744	Condesuyos	5116	A
5116868	Islay	5116	A
5116992	La Unión	5116	A
5116998	Indeterminado	5116	A
5120090	Cangallo	5120	A
5120180	Victor Fajardo	5120	A
5120270	Huamanga	5120	A
5120360	Huanca Sancos	5120	A
5120450	Huanta	5120	A
5120540	La Mar	5120	A
5120630	Lucanas	5120	A
5120720	Parinacochas	5120	A
5120810	Paucar del Sara Sara	5120	A
5120900	Sucre	5120	A
5120990	Vilcas Huamán	5120	A
5124076	Cajabamba	5124	A
5124152	Cajamarca	5124	A
5124228	Celendín	5124	A
5124304	Contumazá	5124	A
5124380	Cutervo	5124	A
5124456	Chota	5124	A
5124532	Hualgayoc	5124	A
5124608	Jaén	5124	A
5124684	San Ignacio	5124	A
5124760	San Marcos	5124	A
5124836	San Miguel	5124	A
5124912	San Pablo	5124	A
5124988	Santa Cruz	5124	A
5126150	CALLAO	5126	A
5126300	BELLAVISTA	5126	A
5126450	CARMEN DE LA LEGUA REYNOSO	5126	A
5126600	LA PERLA	5126	A
5126750	LA PUNTA	5126	A
5126900	VENTANILLA	5126	A
5128076	Acomayo	5128	A
5128152	Anta	5128	A
5128154	Acomayo	5128	A
5128228	Calca	5128	A
5128304	Canas	5128	A
5128380	Canchis	5128	A
5128456	La Convención	5128	A
5128532	Cuzco	5128	A
5128608	Chumbivilcas	5128	A
5128684	Espinar	5128	A
5128760	Paruro	5128	A
5128836	Paucartambo	5128	A
5128912	Quispicanchi	5128	A
5128988	Urubamba	5128	A
5132090	Ambo	5132	A
5132180	Dos de Mayo	5132	A
5132270	Huacaybamba	5132	A
5132360	Huamalíes	5132	A
5132450	Huánuco	5132	A
5132540	Lauricocha	5132	A
5132630	Leoncio Prado	5132	A
5132720	Marañón	5132	A
5132810	Pachitea	5132	A
5132900	Puerto Inca	5132	A
5132990	Yarowilca	5132	A
5136142	Acobamba	5136	A
5136284	Angaraes	5136	A
5136426	Castrovirreyna	5136	A
5136568	Churcampa	5136	A
5136710	Huancavelica	5136	A
5136852	Huaytará	5136	A
5136994	Tayacaja	5136	A
5140199	Chincha	5140	A
5140398	Ica	5140	A
5140597	Nazca	5140	A
5140796	Palpa	5140	A
5140995	Pisco	5140	A
5144110	Concepción	5144	A
5144220	Chanchamayo	5144	A
5144330	Chupaca	5144	A
5144440	Huancayo	5144	A
5144550	Jauja	5144	A
5144660	Junín	5144	A
5144770	Satipo	5144	A
5144880	Tarma	5144	A
5144990	Yauli	5144	A
5148083	Ascope	5148	A
5148166	Bolívar	5148	A
5148249	Chepén	5148	A
5148332	Gran Chimú	5148	A
5148415	Julcán	5148	A
5148498	Otuzco	5148	A
5148581	Pacasmayo	5148	A
5148664	Pataz	5148	A
5148747	Sánchez Carrión	5148	A
5148830	Santiago de Chuco	5148	A
5148913	Trujillo	5148	A
5148996	Virú	5148	A
5152300	Chiclayo	5152	A
5152600	Ferreñafe	5152	A
5152900	Lambayeque	5152	A
5156099	Barranca	5156	A
5156198	Cajatambo	5156	A
5156297	Canta	5156	A
5156396	Cañete	5156	A
5156495	Huaral	5156	A
5156594	Huarochiri	5156	A
5156693	Huaura	5156	A
5156792	Lima	5156	A
5156891	Oyón	5156	A
5156990	Yauyos	5156	A
5160166	Alto Amazonas	5160	A
5160249	Datem del Marañón	5160	A
5160332	Loreto	5160	A
5160498	Mariscal Ramón Castilla	5160	A
5160664	Maynas	5160	A
5160830	Requena	5160	A
5160996	Ucayali	5160	A
5164300	Manu	5164	A
5164600	Tahuamanu	5164	A
5164900	Tambopata	5164	A
5168300	General Sánchez Cerro	5168	A
5168600	Ilo	5168	A
5168900	Mariscal Nieto	5168	A
5172300	Daniel Alcides Carrión	5172	A
5172600	Oxapampa	5172	A
5172900	Pasco	5172	A
5176124	Ayabaca	5176	A
5176248	Huancabamba	5176	A
5176372	Morropón	5176	A
5176496	Paita	5176	A
5176620	Piura	5176	A
5176744	Sechura	5176	A
5176868	Sullana	5176	A
5176992	Talara	5176	A
5180076	Azángaro	5180	A
5180152	Carabaya	5180	A
5180228	Chucuito	5180	A
5180304	El Collao	5180	A
5180380	Huancané	5180	A
5180456	Lampa	5180	A
5180532	Melgar	5180	A
5180608	Moho	5180	A
5180684	Puno	5180	A
5180760	Sandia	5180	A
5180836	San Antonio de Putina	5180	A
5180912	San Román	5180	A
5180988	Yunguyo	5180	A
5184099	Bellavista	5184	A
5184198	El Dorado	5184	A
5184297	Huallaga	5184	A
5184396	Lamas	5184	A
5184495	Mariscal Cáceres	5184	A
5184594	Moyobamba	5184	A
5184693	Picota	5184	A
5184792	Rioja	5184	A
5184891	San Martín	5184	A
5184990	Tocache	5184	A
5188249	Candarave	5188	A
5188498	Jorge Basadre	5188	A
5188747	Tacna	5188	A
5188996	Tarata	5188	A
5192300	Contralmirante Villar	5192	A
5192600	Tumbes	5192	A
5192900	Zarumilla	5192	A
5196249	Atalaya	5196	A
5196498	Coronel Portillo	5196	A
5196747	Padre Abad	5196	A
5196996	Purús	5196	A
5203090	Aguascalientes	5203	A
5203180	Asientos	5203	A
5203270	Calvillo	5203	A
5203360	Cosío	5203	A
5203450	Jesús María	5203	A
5203540	Pabellón de Arteaga	5203	A
5203630	Palo Alto	5203	A
5203720	Rincón de Romos	5203	A
5203810	San Francisco de los Romo	5203	A
5203900	San José de Gracia	5203	A
5203990	Tepezalá	5203	A
5203998	Indeterminado	5203	A
5206199	Ensenada	5206	A
5206398	Mexicali	5206	A
5206597	Rosarito	5206	A
5206796	Tecate	5206	A
5206995	Tijuana	5206	A
5206998	Indeterminado	5206	A
5209199	Comondú	5209	A
5209398	La Paz	5209	A
5209597	Loreto	5209	A
5209796	Los Cabos	5209	A
5209995	Mulegé	5209	A
5209998	Indeterminado	5209	A
5212083	Calakmul	5212	A
5212166	Calkini	5212	A
5212249	Campeche	5212	A
5212332	Candelaria	5212	A
5212415	Cd. del Carmen	5212	A
5212498	Champoton	5212	A
5212581	Escárcega	5212	A
5212664	Hecelchakan	5212	A
5212747	Hopelchen	5212	A
5212830	Palizada	5212	A
5212913	Tenabo	5212	A
5212998	Indeterminado	5212	A
5215008	Acacoyagua	5215	A
5215016	Acala	5215	A
5215024	Acapetahua	5215	A
5215032	Aldama	5215	A
5215040	Altamirano	5215	A
5215048	Amatán	5215	A
5215056	Amatenango de la Frontera	5215	A
5215064	Amatenango del Valle	5215	A
5215072	Angel Albino Corzo	5215	A
5215080	Arriaga	5215	A
5215088	Bejucal de Ocampo	5215	A
5215096	Bella Vista	5215	A
5215104	Benemérito de las Américas	5215	A
5215112	Berriozabal	5215	A
5215120	Bochil	5215	A
5215128	El Bosque	5215	A
5215136	Cacahoatan	5215	A
5215144	Catajaza	5215	A
5215152	Cintalapa	5215	A
5215160	Coapilla	5215	A
5215168	Comitán de Dominguez	5215	A
5215176	Copainala	5215	A
5215184	Chalchiuhitán	5215	A
5215192	Chamula	5215	A
5215200	Chanal	5215	A
5215208	Chapultenango	5215	A
5215216	Chenalhó	5215	A
5215224	Chiapa de Corzo	5215	A
5215232	Chiapilla	5215	A
5215240	Chicoasén	5215	A
5215248	Chicomuselo	5215	A
5215256	Chilón	5215	A
5215264	El Porvenir	5215	A
5215272	Escuintla	5215	A
5215280	Francisco León	5215	A
5215288	Frontera Comalapa	5215	A
5215296	Frontera hidalgo	5215	A
5215304	Huehuetán	5215	A
5215312	Huitiupán	5215	A
5215320	Huixtán	5215	A
5215328	Huixtla	5215	A
5215336	Ixhuatán	5215	A
5215344	Ixtacomitán	5215	A
5215352	Ixtapa	5215	A
5215360	Ixtapangajoya	5215	A
5215368	Jiquipilas	5215	A
5215376	Jitotol	5215	A
5215384	Juárez	5215	A
5215392	La Concordia	5215	A
5215400	La Grandeza	5215	A
5215408	La Independencia	5215	A
5215416	La Libertad	5215	A
5215424	Las Margaritas	5215	A
5215432	Larráinzar	5215	A
5215440	Las Rosas	5215	A
5215448	La Trinitaria	5215	A
5215456	Maravilla Tanejapa	5215	A
5215464	Marquéz de Comillas	5215	A
5215472	Mapastepec	5215	A
5215480	Mazapa de Madero	5215	A
5215488	Mazatán	5215	A
5215496	Metapa	5215	A
5215504	Mitontic	5215	A
5215512	Motozintla	5215	A
5215520	NicolásRuiz	5215	A
5215528	Ocosingo	5215	A
5215536	Ocotepec	5215	A
5215544	Ocozocoautla de Espinosa	5215	A
5215552	Ostuacán	5215	A
5215560	Osumacinta	5215	A
5215568	Oxchuc	5215	A
5215576	Palenque	5215	A
5215584	Pantelhó	5215	A
5215592	Pantepec	5215	A
5215600	Pichucalco	5215	A
5215608	Pijijiapan	5215	A
5215616	Pueblo Nuevo Solistahuacán	5215	A
5215624	Rayón	5215	A
5215632	Reforma	5215	A
5215640	Sabanilla	5215	A
5215648	Salto de Agua	5215	A
5215656	San Andrés Duraznal	5215	A
5215664	San Cristóbal de las Casas	5215	A
5215672	San Fernando	5215	A
5215680	San Lucas	5215	A
5215688	San Juan Cancuc	5215	A
5215696	Santiago del Pinar	5215	A
5215704	Siltepec	5215	A
5215712	Simojovel	5215	A
5215720	Sitala	5215	A
5215728	Socoltenango	5215	A
5215736	Solosuchiapa	5215	A
5215744	Soyalo	5215	A
5215752	Suchiapa	5215	A
5215760	Suchiate	5215	A
5215768	Sunuapa	5215	A
5215776	Tapachula	5215	A
5215784	Tapalapa	5215	A
5215792	Tapilula	5215	A
5215800	Tecpatán	5215	A
5215808	Tenejapa	5215	A
5215816	Teopisca	5215	A
5215824	Tila	5215	A
5215832	Tonalá	5215	A
5215840	Totolapa	5215	A
5215848	Tumbala	5215	A
5215856	Tuxtla Gutiérrez	5215	A
5215864	Tuxtla Chico	5215	A
5215872	Tuzantán	5215	A
5215880	Tzimol	5215	A
5215888	Unión Juárez	5215	A
5215896	Venustiano Carranza	5215	A
5215904	Villaflores	5215	A
5215912	Villacomaltitlán	5215	A
5215920	Villa Corzo	5215	A
5215928	Yajalón	5215	A
5215936	Zinacantán	5215	A
5215998	Indeterminado	5215	A
5218014	Ahumada	5218	A
5218028	Aldama	5218	A
5218042	Allende	5218	A
5218056	Aquiles Serdan	5218	A
5218070	Ascensión	5218	A
5218084	Bachiniva	5218	A
5218098	Balleza	5218	A
5218112	Batopilas	5218	A
5218126	Bocoyna	5218	A
5218140	Buenaventura	5218	A
5218154	Camargo	5218	A
5218168	Carichi	5218	A
5218182	Casas Grandes	5218	A
5218196	Chihuahua	5218	A
5218210	Chinipas	5218	A
5218224	Coronado	5218	A
5218238	Coyame	5218	A
5218252	Cuauhtémoc	5218	A
5218266	Cusihuiriachi	5218	A
5218280	Delicias	5218	A
5218294	Dr. Belisario Domínguez	5218	A
5218308	El Tule	5218	A
5218322	Galeana	5218	A
5218336	Gómez Farías	5218	A
5218350	Gran Morelos	5218	A
5218364	Guachochi	5218	A
5218378	Guadalupe	5218	A
5218392	Guadalupe y Calvo	5218	A
5218406	Guazapares	5218	A
5218420	Guerrero	5218	A
5218434	Hidalgo del Parral	5218	A
5218448	Huejotitán	5218	A
5218462	Ignacio Zaragoza	5218	A
5218476	Janos	5218	A
5218490	Jiménez	5218	A
5218504	Juárez	5218	A
5218518	Julimes	5218	A
5218532	La Cruz	5218	A
5218546	López	5218	A
5218560	Madera	5218	A
5218574	Maguarichi	5218	A
5218588	Manuel Benavides	5218	A
5218602	Matachi	5218	A
5218616	Matamoros	5218	A
5218630	Meoqui	5218	A
5218644	Morelos	5218	A
5218658	Moris	5218	A
5218672	Namiquipa	5218	A
5218686	Nonoava	5218	A
5218700	Nuevo Casas Grandes	5218	A
5218714	Ocampo	5218	A
5218728	Ojinaga	5218	A
5218742	Praxedis G. Guerrero	5218	A
5218756	Riva Palacio	5218	A
5218770	Rosales	5218	A
5218784	Rosario	5218	A
5218798	San Francisco de Borja	5218	A
5218812	San Francisco de Conchos	5218	A
5218826	San Francisco del Oro	5218	A
5218840	Santa Barbara	5218	A
5218854	Santa Isabel	5218	A
5218868	Satevo	5218	A
5218882	Saucillo	5218	A
5218896	Temosachi	5218	A
5218910	Urique	5218	A
5218924	Uruachi	5218	A
5218938	Valle Zaragoza	5218	A
5218998	Indeterminado	5218	A
5221026	Abasolo	5221	A
5221052	Acuña	5221	A
5221078	Allende	5221	A
5221104	Arteaga	5221	A
5221130	Candela	5221	A
5221156	Castaños	5221	A
5221182	Cuatrociénegas	5221	A
5221208	Escobedo	5221	A
5221234	Francisco I. Madero	5221	A
5221260	Frontera	5221	A
5221286	General Cepeda	5221	A
5221312	Guerrero	5221	A
5221338	Hidalgo	5221	A
5221364	Jiménez	5221	A
5221390	Juárez	5221	A
5221416	Lamadrid	5221	A
5221442	Matamoros	5221	A
5221468	Monclova	5221	A
5221494	Morelos	5221	A
5221520	Múzquiz	5221	A
5221546	Nadadores	5221	A
5221572	Nava	5221	A
5221598	Ocampo	5221	A
5221624	Parras	5221	A
5221650	Piedras Negras	5221	A
5221676	Progreso	5221	A
5221702	Ramos Arizpe	5221	A
5221728	Sabinas	5221	A
5221754	Sacramento	5221	A
5221780	Saltillo	5221	A
5221806	San Juan de Sabinas	5221	A
5221832	San Pedro	5221	A
5221858	Sanbuenaventura	5221	A
5221884	Sierra Mojada	5221	A
5221910	Torreón	5221	A
5221936	Viesca	5221	A
5221962	Villa Unión	5221	A
5221988	Zaragoza	5221	A
5221998	Indeterminado	5221	A
5224099	Alvarez	5224	A
5224198	Armería	5224	A
5224297	Colima	5224	A
5224396	Comala	5224	A
5224495	Coquimatlán	5224	A
5224594	Cuauhtémoc	5224	A
5224693	Ixtlahuacán	5224	A
5224792	Manzanillo	5224	A
5224891	Minatitlán	5224	A
5224990	Tecomán	5224	A
5224998	Indeterminado	5224	A
5227062	Alvaro Obregón	5227	A
5227124	Azcapotzalco	5227	A
5227186	Benito Juárez	5227	A
5227248	Coyoacán	5227	A
5227310	Cuajimalpa de Morelos	5227	A
5227372	Cuauhtémoc	5227	A
5227434	Gustavo A. Madero	5227	A
5227496	Iztacalco	5227	A
5227558	Iztapalapa	5227	A
5227620	La Magdalena Contreras	5227	A
5227682	Miguel Hidalgo	5227	A
5227744	Milpa Alta	5227	A
5227806	Tláhuac	5227	A
5227868	Tlalpan	5227	A
5227930	Venustiano Carranza	5227	A
5227992	Xochimilco	5227	A
5227998	Indeterminado	5227	A
5230025	Canatlán	5230	A
5230050	Canelas	5230	A
5230075	Coneto de Comonfort	5230	A
5230100	Cuencamé	5230	A
5230125	Durango	5230	A
5230150	El Oro	5230	A
5230175	Gómez Palacio	5230	A
5230200	Guadalupe Victoria	5230	A
5230225	Guanaceví	5230	A
5230250	Hidalgo	5230	A
5230275	Indé	5230	A
5230300	Lerdo	5230	A
5230325	Mapimí	5230	A
5230350	Mezquital	5230	A
5230375	Nazas	5230	A
5230400	Nombre de Dios	5230	A
5230425	Nuevo Ideal	5230	A
5230450	Ocampo	5230	A
5230475	Otáez	5230	A
5230500	Pánuco de Coronado	5230	A
5230525	Peñón Blanco	5230	A
5230550	Poanas	5230	A
5230575	Pueblo Nuevo	5230	A
5230600	Rodeo	5230	A
5230625	San Bernardo	5230	A
5230650	San Dimas	5230	A
5230675	San Juan de Guadalupe	5230	A
5230700	San Juan del Río	5230	A
5230725	San Luis del Cordero	5230	A
5230750	San Pedro del Gallo	5230	A
5230775	Santa Clara	5230	A
5230800	Santiago Papasquiaro	5230	A
5230825	Simón Bolívar	5230	A
5230850	Suchil	5230	A
5230875	Tamazula	5230	A
5230900	Tepehuanes	5230	A
5230925	Tlahualilo	5230	A
5230950	Topia	5230	A
5230975	Vicente Guerrero 	5230	A
5230998	Indeterminado	5230	A
5233008	Acambay	5233	A
5233016	Acolman	5233	A
5233024	Aculco	5233	A
5233032	Almoloya de Alquisiras	5233	A
5233040	Almoloya de Juarez	5233	A
5233048	Almoloya del Rio	5233	A
5233056	Amanalco	5233	A
5233064	Amatepec	5233	A
5233072	Amecameca	5233	A
5233080	Apaxco	5233	A
5233088	Atenco	5233	A
5233096	Atizapán	5233	A
5233104	Atizapán de Zaragoza	5233	A
5233112	Atlacomulco	5233	A
5233120	Atlautla	5233	A
5233128	Axapusco	5233	A
5233136	Ayapango	5233	A
5233144	Calimaya	5233	A
5233152	Capulhuac	5233	A
5233160	Chalco	5233	A
5233168	Chapa de Mota	5233	A
5233176	Chapultepec	5233	A
5233184	Chiautla	5233	A
5233192	Chicoloapan	5233	A
5233200	Chiconcuac	5233	A
5233208	Chimalhuacan	5233	A
5233216	Coacalco	5233	A
5233224	Coatepec Harinas	5233	A
5233232	Cocotitlán	5233	A
5233240	Coyotepec	5233	A
5233248	Cuautitlán	5233	A
5233256	Cuautitlán Izcalli	5233	A
5233264	Donato Guerra	5233	A
5233272	Ecatepec	5233	A
5233280	Ecatzingo	5233	A
5233288	El oro	5233	A
5233296	Huehuetoca	5233	A
5233304	Hueypoxtla	5233	A
5233312	Huixquilucan	5233	A
5233320	Isidro Fabela	5233	A
5233328	Ixtapaluca	5233	A
5233336	Ixtapan de la Sal	5233	A
5233344	Ixtapan del Oro	5233	A
5233352	Ixtlahuaca	5233	A
5233360	Jaltenco	5233	A
5233368	Jilotepec	5233	A
5233376	Jilotzingo	5233	A
5233384	Jiquipilco	5233	A
5233392	Jocotitlán	5233	A
5233400	Joquicingo	5233	A
5233408	Juchitepec	5233	A
5233416	La Paz	5233	A
5233424	Lerma	5233	A
5233432	Malinalco	5233	A
5233440	Melchor Ocampo	5233	A
5233448	Metepec	5233	A
5233456	Mexicalcingo	5233	A
5233464	Naucalpan	5233	A
5233472	Nextlalpan	5233	A
5233480	Nezahualcóyotl	5233	A
5233488	Nicolás Romero	5233	A
5233496	Nopaltepec	5233	A
5233504	Ocoyoacac	5233	A
5233512	Ocuilán	5233	A
5233520	Otumba	5233	A
5233528	Otzoloapán	5233	A
5233536	Otzolotepec	5233	A
5233544	Ozumba	5233	A
5233552	Papalotla	5233	A
5233560	Polotitlán	5233	A
5233568	Rayón	5233	A
5233576	San Antonio la Isla	5233	A
5233584	San Bartolo Morelos	5233	A
5233592	San Felipe del Progreso,	5233	A
5233600	San Martín de las Pirámides	5233	A
5233608	San Mateo Atenco	5233	A
5233616	San Simón de Guerrero	5233	A
5233624	Santiago Tianguistenco	5233	A
5233632	Santo Tomás	5233	A
5233640	Solidaridad	5233	A
5233648	Soyaniquilpan de Juárez	5233	A
5233656	Sultepec	5233	A
5233664	Tecamac	5233	A
5233672	Tejupilco	5233	A
5233680	Temamatla	5233	A
5233688	Temascalapa	5233	A
5233696	Temascalcingo	5233	A
5233704	Temascaltepec	5233	A
5233712	Temoaya	5233	A
5233720	Tenancingo	5233	A
5233728	Tenango del Aire	5233	A
5233736	Tenango del Valle	5233	A
5233744	Teoloyucan	5233	A
5233752	Teotihuacan	5233	A
5233760	Tepetlaoxtoc	5233	A
5233768	Tepetlixpa	5233	A
5233776	Tepotzotlán	5233	A
5233784	Tequixquiac	5233	A
5233792	Texcaltitlán	5233	A
5233800	Texcalyacac	5233	A
5233808	Texcoco	5233	A
5233816	Tezoyuca	5233	A
5233824	Timilpan	5233	A
5233832	Tlalmanaco	5233	A
5233840	Tlalnepantla	5233	A
5233848	Tlatlaya	5233	A
5233856	Toluca	5233	A
5233864	Tonatico	5233	A
5233872	Tultepec	5233	A
5233880	Tultitlán	5233	A
5233888	Valle de Bravo	5233	A
5233896	Valle de Chalco	5233	A
5233904	Villa de Allende	5233	A
5233912	Villa del Carbón	5233	A
5233920	Villa Guerrero	5233	A
5233928	Villa Victoria	5233	A
5233936	Xalatlaco	5233	A
5233944	Xonacatlán	5233	A
5233952	Zacazonapan	5233	A
5233960	Zacualpan	5233	A
5233968	Zinacantepec	5233	A
5233976	Zumpahuacán 	5233	A
5233998	Indeterminado	5233	A
5236021	Abasolo	5236	A
5236042	Acámbaro	5236	A
5236063	Allende	5236	A
5236084	Apaseo el Alto	5236	A
5236105	Apaseo el Grande	5236	A
5236126	Atarjea	5236	A
5236147	Celaya	5236	A
5236168	Comonfort	5236	A
5236189	Coroneo	5236	A
5236210	Cortázar	5236	A
5236231	Cueramarao	5236	A
5236252	Doctor Mora	5236	A
5236273	Dolores Hidalgo	5236	A
5236294	Guanajuato	5236	A
5236315	Huanimaro	5236	A
5236336	Irapuato	5236	A
5236357	Jaral del Progreso	5236	A
5236378	Jerecuaro	5236	A
5236399	León	5236	A
5236420	Manuel Doblado	5236	A
5236441	Moroleón	5236	A
5236462	Ocampo	5236	A
5236483	Pénjamo	5236	A
5236504	Pueblo Nuevo	5236	A
5236525	Purísima del Rincón	5236	A
5236546	Romita	5236	A
5236567	Salamanca	5236	A
5236588	Salvatierra	5236	A
5236609	San Diego de la Unión	5236	A
5236630	San Felipe	5236	A
5236651	San Francisco del Rincón	5236	A
5236672	San José Iturbide	5236	A
5236693	San Luis de la Paz	5236	A
5236714	Santa Catarina	5236	A
5236735	Santa Cruz de Juventino Rosas	5236	A
5236756	Santiago Maravatío	5236	A
5236777	Silao	5236	A
5236798	Tarandacuao	5236	A
5236819	Tarimoro	5236	A
5236840	Tierra Blanca	5236	A
5236861	Uriangato	5236	A
5236882	Valle de Santiago	5236	A
5236903	Victoria	5236	A
5236924	Villagran	5236	A
5236945	Xichu	5236	A
5236966	Yuriria	5236	A
5236998	Indeterminado	5236	A
5239013	Acapulco de Juárez	5239	A
5239026	Acatepec	5239	A
5239039	Ahuacuotzingo	5239	A
5239052	Ajuchitlán del Progreso	5239	A
5239065	Alcozauca de Guerrero	5239	A
5239078	Alpoyeca	5239	A
5239091	Apaxtla	5239	A
5239104	Arcelia	5239	A
5239117	Atenango del Río	5239	A
5239130	Atlamajalcingo del Monte	5239	A
5239143	Atlixtac	5239	A
5239156	Atoyac de Alvarez	5239	A
5239169	Ayutla de los Libres	5239	A
5239182	Azoyu	5239	A
5239195	Benito Juárez	5239	A
5239208	Buenavista de Cuéllar	5239	A
5239221	Chilapa de Alvarez	5239	A
5239234	Chilpancingo de los Bravo	5239	A
5239247	Coahuayutla de José María Izazaga	5239	A
5239260	Cocula	5239	A
5239273	Copala	5239	A
5239286	Copalillo	5239	A
5239299	Copanatoyac	5239	A
5239312	Coyuca de Benitez	5239	A
5239325	Coyuca de Catalán	5239	A
5239338	Cuajinicuilapa	5239	A
5239351	Cualac	5239	A
5239364	Cuautepec	5239	A
5239377	Cuetzala de Progreso	5239	A
5239390	Cutzamala de Pinzón	5239	A
5239403	Eduardo Neri	5239	A
5239416	Florencio Villarreal	5239	A
5239429	General Heliodoro Castillo	5239	A
5239442	Gral. Canuto A. Neri	5239	A
5239455	Huamuxtitlán	5239	A
5239468	Huitzuco de los Figueroa	5239	A
5239481	Iguala de la Independencia	5239	A
5239494	Igualapa	5239	A
5239507	Ixcateopan de Cuahutémoc	5239	A
5239520	José Azueta	5239	A
5239533	Juan R. Escudero	5239	A
5239546	La Unión de Isidoro Montes de Oca	5239	A
5239559	Leonardo Bravo	5239	A
5239572	Malinaltepec	5239	A
5239585	Martir de Cuilapan	5239	A
5239598	Metlatoc	5239	A
5239611	Mochitlán	5239	A
5239624	Olinala	5239	A
5239637	Ometepec	5239	A
5239650	Pedro Ascencio Alquistras	5239	A
5239663	Petatlán	5239	A
5239676	Pilcaya	5239	A
5239689	Pungarabato	5239	A
5239702	Quechultenango	5239	A
5239715	San Luis Acatlán	5239	A
5239728	San Marcos	5239	A
5239741	San Miguel Totolapan	5239	A
5239754	Taxco de Alarcón	5239	A
5239767	Tecoanapa	5239	A
5239780	Tecpan de Galeana	5239	A
5239793	Teloloapan	5239	A
5239806	Tepecuacuilco de Trujano	5239	A
5239819	Tetipac	5239	A
5239832	Tixtla de Guerrero	5239	A
5239845	Tlacoachistlahuaca	5239	A
5239858	Tlacoapa	5239	A
5239871	Tlalchapa	5239	A
5239884	Tlalixtaquilla de Maldonado	5239	A
5239897	Tlapa de Comonfort	5239	A
5239910	Tlapehuala	5239	A
5239923	Xalpatláhuac	5239	A
5239936	Xochihuehuetlán	5239	A
5239949	Xochistlahuaca	5239	A
5239962	Zapotitlán Tablas	5239	A
5239975	Zirandaro	5239	A
5239988	Zitlala	5239	A
5239998	Indeterminado	5239	A
5242011	Acatlán	5242	A
5242022	Acaxochitlán	5242	A
5242033	Actopan	5242	A
5242044	Agua Blanca de Iturbide	5242	A
5242055	Ajacuba	5242	A
5242066	Alfajayucan	5242	A
5242077	Almoloya	5242	A
5242088	Apan	5242	A
5242099	Atitalaquia	5242	A
5242110	Atlapexco	5242	A
5242121	Atotonilco de Tula	5242	A
5242132	Atotonilco el Grande	5242	A
5242143	Calnali	5242	A
5242154	Cardonal	5242	A
5242165	Chapantongo	5242	A
5242176	Chapulhuacán	5242	A
5242187	Chilcuautla	5242	A
5242198	Cuautepec de Hinojosa	5242	A
5242209	El Arenal	5242	A
5242220	Eloxochitlán	5242	A
5242231	Emiliano Zapata	5242	A
5242242	Epazoyucán	5242	A
5242253	Francisco I. Madero	5242	A
5242264	Huasca de Ocampo	5242	A
5242275	Huautla	5242	A
5242286	Huazalingo	5242	A
5242297	Huehuetla	5242	A
5242308	Huehuetla de Reyes	5242	A
5242319	Huichapan	5242	A
5242330	Ixmiquilpan	5242	A
5242341	Jacala de Ledezma	5242	A
5242352	Jaltocán	5242	A
5242363	Juárez Hidalgo	5242	A
5242374	La Misión	5242	A
5242385	Lolotla	5242	A
5242396	Metepec	5242	A
5242407	Metztitlán	5242	A
5242418	Mineral de la Reforma	5242	A
5242429	Mineral del Chico	5242	A
5242440	Mineral del Monte	5242	A
5242451	Mixquiahuala de Juárez	5242	A
5242462	Molango de Escamilla	5242	A
5242473	Nicolás Flores	5242	A
5242484	Nopala de Villagran	5242	A
5242495	Omitlán de Juárez	5242	A
5242506	Pachuca de Soto	5242	A
5242517	Pácula	5242	A
5242528	Pisaflores	5242	A
5242539	Progreso de Obregón	5242	A
5242550	San Agustín Metzquititlán	5242	A
5242561	San Agustin Tlaxiaca	5242	A
5242572	San Bartolo Tutotepec	5242	A
5242583	San Felipe Orizatlán	5242	A
5242594	San Salvador	5242	A
5242605	Santiago de Anaya	5242	A
5242616	SantiagoTulantepec de Lugo Guerrero	5242	A
5242627	Singuilucán	5242	A
5242638	Tasquillo	5242	A
5242649	Tecozautla	5242	A
5242660	Tenango de Doria	5242	A
5242671	Tepeapulco	5242	A
5242682	Tepehuacán de Guerrero	5242	A
5242693	Tepejí del Río de Ocampo	5242	A
5242704	Tepetitlán	5242	A
5242715	Tetepango	5242	A
5242726	Tezontepec de Aldama	5242	A
5242737	Tianguistengo	5242	A
5242748	Tizayuca	5242	A
5242759	Tlahuelilpan	5242	A
5242770	Tlahuiltepa	5242	A
5242781	Tlanalapa	5242	A
5242792	Tlanchinol	5242	A
5242803	Tlaxcoapan	5242	A
5242814	Tolcayuca	5242	A
5242825	Tula de Allende	5242	A
5242836	Tulancingo de Bravo	5242	A
5242847	Villa de Tezontepec	5242	A
5242858	Xochiatipán	5242	A
5242869	Xochicoatlán	5242	A
5242880	Yahualica	5242	A
5242891	Zacualtipán de Angeles	5242	A
5242902	Zapotlán de Juárez	5242	A
5242913	Zempoala	5242	A
5242924	Zimapán	5242	A
5242998	Indeterminado	5242	A
5245008	Acatic	5245	A
5245016	Acatlán de Juárez	5245	A
5245024	Ahualulco de Mercado	5245	A
5245032	Amacueca	5245	A
5245040	Amatitán	5245	A
5245048	Ameca	5245	A
5245056	Arandas	5245	A
5245064	Arenal	5245	A
5245072	Atemajac de Brizuela	5245	A
5245080	Atengo	5245	A
5245088	Atenguillo	5245	A
5245096	Atotonilco el Alto	5245	A
5245104	Atoyac	5245	A
5245112	Autlán de Navarro	5245	A
5245120	Ayotlán	5245	A
5245128	Ayutla	5245	A
5245136	Bolaños	5245	A
5245144	Cabo Corrientes	5245	A
5245152	Cañadas de Obregón	5245	A
5245160	Casimiro Castillo	5245	A
5245168	Chapala	5245	A
5245176	Chimaltitán	5245	A
5245184	Chiquilistlán	5245	A
5245192	Cihuatlán	5245	A
5245200	Cocula	5245	A
5245208	Colotlán	5245	A
5245216	Concepción de Buenos Aires	5245	A
5245224	Cuautitlán	5245	A
5245232	Cuautitlán de García Barragán	5245	A
5245240	Cuquío	5245	A
5245248	Degollado	5245	A
5245256	Ejutla	5245	A
5245264	El Grullo	5245	A
5245272	El Limón	5245	A
5245280	El Salto	5245	A
5245288	Encarnación de Díaz	5245	A
5245296	Etzatlán	5245	A
5245304	Gómez Farías	5245	A
5245312	Guachinango	5245	A
5245320	Guadalajara	5245	A
5245328	Hostotipaquillo	5245	A
5245336	Huejúcar	5245	A
5245344	Huejuquilla el Alto	5245	A
5245352	Ixtlahuacán de los Membrillos	5245	A
5245360	Ixtlahuacán del Río	5245	A
5245368	Jalostotitlán	5245	A
5245376	Jamay	5245	A
5245384	Jesús María	5245	A
5245392	Jilotlán de los Dolores	5245	A
5245400	Jocotepec	5245	A
5245408	Juanacatlán	5245	A
5245416	Juchitlán	5245	A
5245424	La Barca	5245	A
5245432	La Huerta	5245	A
5245440	La Manzanilla de la Paz	5245	A
5245448	Lagos de Moreno	5245	A
5245456	Magdalena	5245	A
5245464	Manuel M. Diéguez	5245	A
5245472	Mascota	5245	A
5245480	Mazamitla	5245	A
5245488	Mexticacán	5245	A
5245496	Mezquitic	5245	A
5245504	Mixtlán	5245	A
5245512	Ocotlán	5245	A
5245520	Ojuelos	5245	A
5245528	Pihuamo	5245	A
5245536	Poncitlán	5245	A
5245544	Puerto Vallarta	5245	A
5245552	Quitupan	5245	A
5245560	San Cristóbal de la Barranca	5245	A
5245568	San Diego de Alejandría	5245	A
5245576	San Gabriel	5245	A
5245584	San Juan de los Lagos	5245	A
5245592	San Juanito de Escobedo	5245	A
5245600	San Julián	5245	A
5245608	San Marcos	5245	A
5245616	San Martín de Bolaños	5245	A
5245624	San Martín Hidalgo	5245	A
5245632	San Miguel el Alto	5245	A
5245640	San Sebastían del Oeste	5245	A
5245648	Santa María de los Ángeles,	5245	A
5245656	Sayula	5245	A
5245664	Tala	5245	A
5245672	Talpa de Allende	5245	A
5245680	Tamazula de Gordiano	5245	A
5245688	Tapalpa	5245	A
5245696	Tecalitlán	5245	A
5245704	Techaluta de Montenegro	5245	A
5245712	Tecolotlán	5245	A
5245720	Tenamaxtlán	5245	A
5245728	Teocaltiche	5245	A
5245736	Teocuitatlán de Corona	5245	A
5245744	Tepatitlán de Morelos	5245	A
5245752	Tequila	5245	A
5245760	Teuchitlán	5245	A
5245768	Tizapán el Alto	5245	A
5245776	Tlajomulco de Zúñiga	5245	A
5245784	Tlaquepaque	5245	A
5245792	Tolimán	5245	A
5245800	Tomatlán	5245	A
5245808	Tonalá	5245	A
5245816	Tonaya	5245	A
5245824	Tonila	5245	A
5245832	Totatiche	5245	A
5245840	Tototlán	5245	A
5245848	Tuxcacuesco	5245	A
5245856	Tuxcueca	5245	A
5245864	Tuxpan	5245	A
5245872	Unión de San Antonio	5245	A
5245880	Unión de Tula	5245	A
5245888	Valle de Guadalupe	5245	A
5245896	Valle de Juárez	5245	A
5245904	Villa Corona	5245	A
5245912	Villa Guerrero	5245	A
5245920	Villa Hidalgo	5245	A
5245928	Villa Purificación	5245	A
5245936	Yahualica de González Gallo	5245	A
5245944	Zacoalco de Torres	5245	A
5245952	Zapopan	5245	A
5245960	Zapotiltic	5245	A
5245968	Zapotitlán de Vadillo	5245	A
5245976	Zapotlán del Rey	5245	A
5245984	Zapotlán el Grande	5245	A
5245992	Zapotlanejo	5245	A
5245998	Indeterminado	5245	A
5248008	Acuitzio	5248	A
5248016	Acuitzio del Canje	5248	A
5248024	Aguililla	5248	A
5248032	Alvaro Obregón	5248	A
5248040	Angamacutiro	5248	A
5248048	Angangueo	5248	A
5248056	Apatzingán	5248	A
5248064	Aporo	5248	A
5248072	Aquila	5248	A
5248080	Ario	5248	A
5248088	Arteaga	5248	A
5248096	Briseñas	5248	A
5248104	Buenavista	5248	A
5248112	Carácuaro	5248	A
5248120	Charapán	5248	A
5248128	Charo	5248	A
5248136	Chavinda	5248	A
5248144	Cherán	5248	A
5248152	Chilchota	5248	A
5248160	Chinicuila	5248	A
5248168	Chucándiro	5248	A
5248176	Churintzio	5248	A
5248184	Churumuco	5248	A
5248192	Coahuayana	5248	A
5248200	Coalcaomán de Vázquez Pallares	5248	A
5248208	Coeneo	5248	A
5248216	Cojumatlán de Regules	5248	A
5248224	Contepec	5248	A
5248232	Copándaro	5248	A
5248240	Cotija	5248	A
5248248	Cuitzeo	5248	A
5248256	Ecuadureo	5248	A
5248264	Epitacio Huerta	5248	A
5248272	Erongarícuaro	5248	A
5248280	Gabriel Zamora	5248	A
5248288	Hidalgo	5248	A
5248296	Huamdacareo	5248	A
5248304	Huaniqueo	5248	A
5248312	Huetamo	5248	A
5248320	Huiramba	5248	A
5248328	Indaparapeo	5248	A
5248336	Irimbo	5248	A
5248344	Ixtlán	5248	A
5248352	Jacona	5248	A
5248360	Jiménez	5248	A
5248368	Jiquilpan	5248	A
5248376	Juárez	5248	A
5248384	Jungapeo	5248	A
5248392	La Huacana	5248	A
5248400	La Piedad	5248	A
5248408	La Quiroga	5248	A
5248416	Lagunillas	5248	A
5248424	Lagunillas	5248	A
5248432	Lázaro Cárdenas	5248	A
5248440	Los Reyes	5248	A
5248448	Madero	5248	A
5248456	Maravatío	5248	A
5248464	Maravatío	5248	A
5248472	Marcos Castellanos	5248	A
5248480	Morelia	5248	A
5248488	Morelos	5248	A
5248496	Mugica	5248	A
5248504	Nahuatzen	5248	A
5248512	Nocupétaro	5248	A
5248520	Nuevo Parangaricutiro	5248	A
5248528	Nuevo Urecho	5248	A
5248536	Numarán	5248	A
5248544	Ocampo	5248	A
5248552	Pajacuarán	5248	A
5248560	Panindícuaro	5248	A
5248568	Paracho	5248	A
5248576	Parácuaro	5248	A
5248584	Pátzcuaro	5248	A
5248592	Penjamillo	5248	A
5248600	Peribán	5248	A
5248608	Purépero	5248	A
5248616	Puruándiro	5248	A
5248624	Queréndaro	5248	A
5248632	Quiroga	5248	A
5248640	Sahuayo	5248	A
5248648	Salvador Escalante	5248	A
5248656	San Lucas	5248	A
5248664	Santa Ana Maya	5248	A
5248672	Senguio	5248	A
5248680	Susupuato	5248	A
5248688	Tacámbaro	5248	A
5248696	Tancítaro	5248	A
5248704	Tangamandapio	5248	A
5248712	Tangancícuaro	5248	A
5248720	Tanhuato	5248	A
5248728	Taretán	5248	A
5248736	Tarímbaro	5248	A
5248744	Tepalcaltepec	5248	A
5248752	Tingambato	5248	A
5248760	Tinguindín	5248	A
5248768	Tiquicheo de Nicolás Romero	5248	A
5248776	Tiricato	5248	A
5248784	Tlalpujahua	5248	A
5248792	Tlazazalca	5248	A
5248800	Tocumbo	5248	A
5248808	Tumbiscatio	5248	A
5248816	Tuxpan	5248	A
5248824	Tuzantla	5248	A
5248832	Tzintzuntzan	5248	A
5248840	Tzitzio	5248	A
5248848	Uruapan	5248	A
5248856	Venustiano Carranza	5248	A
5248864	Villamar	5248	A
5248872	Vista Hermosa	5248	A
5248880	Yurécuaro	5248	A
5248888	Zacapu	5248	A
5248896	Zamora	5248	A
5248904	Zinapécuaro	5248	A
5248998	Indeterminado	5248	A
5251030	Amacuzac	5251	A
5251060	Atlatlahucán	5251	A
5251090	Axochiapan	5251	A
5251120	Ayala	5251	A
5251150	Coatlán del Río	5251	A
5251180	Cuautla	5251	A
5251210	Cuernavaca	5251	A
5251240	Emiliano Zapata	5251	A
5251270	Huitzilac	5251	A
5251300	Jantetelco	5251	A
5251330	Jiutepec	5251	A
5251360	Jojutla	5251	A
5251390	Jonacatepec	5251	A
5251420	Mazatepec	5251	A
5251450	Miacatlán	5251	A
5251480	Ocuituco	5251	A
5251510	Puente de Ixtla	5251	A
5251540	Temixco	5251	A
5251570	Temoac	5251	A
5251600	Tepalcingo	5251	A
5251630	Tepoztlán	5251	A
5251660	Tetecala	5251	A
5251690	Tetela del Volcán	5251	A
5251720	Tlalnepantla	5251	A
5251750	Tlaltizapán	5251	A
5251780	Tlaquiltenango	5251	A
5251810	Tlayacapan	5251	A
5251840	Totolapan	5251	A
5251870	Xochitepec	5251	A
5251900	Yautepec	5251	A
5251930	Yecapixtla	5251	A
5251960	Zacatepec	5251	A
5251990	Zacualpan	5251	A
5251998	Indeterminado	5251	A
5254049	Acaponeta	5254	A
5254098	Ahuacatlán	5254	A
5254147	Amatlán de Cañas	5254	A
5254196	Bahía de Banderas	5254	A
5254245	Compostela	5254	A
5254294	El Nayar	5254	A
5254343	Huajicori	5254	A
5254392	Ixtlán del Río	5254	A
5254441	Jala	5254	A
5254490	La Yesca	5254	A
5254539	Rosamorada	5254	A
5254588	Ruíz	5254	A
5254637	San Blas	5254	A
5254686	San Pedro Lagunillas	5254	A
5254735	Santa María del Oro	5254	A
5254784	Santiago Ixcuintla	5254	A
5254833	Tecuala	5254	A
5254882	Tepic	5254	A
5254931	Tuxpan	5254	A
5254980	Xalisco	5254	A
5254998	Indeterminado	5254	A
5257019	Abasolo	5257	A
5257038	Agualeguas	5257	A
5257057	Aldamas	5257	A
5257076	Allende	5257	A
5257095	Anáhuac	5257	A
5257114	Apodaca	5257	A
5257133	Aramberri	5257	A
5257152	Bustamante	5257	A
5257171	Cadereyta Jiménez	5257	A
5257190	Carmen	5257	A
5257209	Cerralvo	5257	A
5257228	China	5257	A
5257247	Ciénaga de Flores	5257	A
5257266	Doctor Arroyo	5257	A
5257285	Doctor Coss	5257	A
5257304	Doctor González	5257	A
5257323	Galeana	5257	A
5257342	García	5257	A
5257361	General Bravo	5257	A
5257380	General Escobedo	5257	A
5257399	General Terán	5257	A
5257418	General Treviño	5257	A
5257437	General Zaragoza	5257	A
5257456	General Zuazua	5257	A
5257475	Guadalupe	5257	A
5257494	Higueras	5257	A
5257513	Hualahuises	5257	A
5257532	Iturbide	5257	A
5257551	Juárez	5257	A
5257570	Lampazos de Naranjo	5257	A
5257589	Linares	5257	A
5257608	Los Herreras	5257	A
5257627	Los Hidalgo	5257	A
5257646	Los Ramones	5257	A
5257665	Marín	5257	A
5257684	Melchor Ocampo	5257	A
5257703	Mier y Noriega	5257	A
5257722	Mina	5257	A
5257741	Montemorelos	5257	A
5257760	Monterrey	5257	A
5257779	Parás	5257	A
5257798	Pesquería	5257	A
5257817	Rayones	5257	A
5257836	Sabinas Hidalgo	5257	A
5257855	Salinas Victoria	5257	A
5257874	San Nicolás de los Garza	5257	A
5257893	San Pedro Garza García	5257	A
5257912	Santa Catarina	5257	A
5257931	Santiago	5257	A
5257950	Vallecillo	5257	A
5257969	Villaldama	5257	A
5257998	Indeterminado	5257	A
5260002	Abejones	5260	A
5260003	Acatlán de Pérez Figueroa	5260	A
5260004	Animas Trujano	5260	A
5260005	Asunción Cacalotepec	5260	A
5260006	Asunción Cuyotepeji	5260	A
5260007	Asunción Ixtaltepec	5260	A
5260008	Asunción Nochixtlán	5260	A
5260009	Asunción Ocotlán	5260	A
5260010	Asunción Tlacolulita	5260	A
5260011	Ayoquezco de Aldama	5260	A
5260012	Ayotzintepec	5260	A
5260013	Calihuala	5260	A
5260014	Candelaria Loxicha	5260	A
5260015	Capulalpam de Méndez	5260	A
5260016	Chahuites	5260	A
5260017	Chalcatongo de Hidalgo	5260	A
5260018	Ciénega de Zimatlán	5260	A
5260019	Ciudad Ixtepec	5260	A
5260020	Coatecas Altas	5260	A
5260021	Coicoyan de las Flores	5260	A
5260022	Concepción Buenavista	5260	A
5260023	Concepción Papalo	5260	A
5260024	Constancia del Rosario	5260	A
5260025	Cosolapa	5260	A
5260026	Cosoltepec	5260	A
5260027	Cuilapam de Guerrero	5260	A
5260028	Cuyamecalco Villa de Zaragoza	5260	A
5260029	Ejutla de Crespo	5260	A
5260030	El Barrio de la Soledad	5260	A
5260031	El Espinal	5260	A
5260032	Eloxochitlán de Flores Magón	5260	A
5260033	Fresnillo de Trujano	5260	A
5260034	Guadalupe de Ramírez	5260	A
5260035	Guadalupe Etla	5260	A
5260036	Guelatao de Juárez	5260	A
5260037	Guevea de Humboldt	5260	A
5260038	Heroica Ciudad de Tlaxiaco	5260	A
5260039	Huajapam de León	5260	A
5260040	Huautepec	5260	A
5260041	Huautla de Jiménez	5260	A
5260042	Ixpantepec Nieves	5260	A
5260043	Ixtlán de Juárez	5260	A
5260044	Juchitán de Zaragoza	5260	A
5260045	La Compañía	5260	A
5260046	La Pe	5260	A
5260047	La Reforma	5260	A
5260048	La Trinidad Vista Hermosa	5260	A
5260049	Loma Bonita	5260	A
5260050	Magdalena Apasco	5260	A
5260051	Magdalena Jaltepec	5260	A
5260052	Magdalena Mixtepec	5260	A
5260053	Magdalena Ocotlán	5260	A
5260054	Magdalena Peñasco	5260	A
5260055	Magdalena Teitipac	5260	A
5260056	Magdalena Tequisistlán	5260	A
5260057	Magdalena Tlacotepec	5260	A
5260058	Magdalena Yodocono de Porfirio Díaz	5260	A
5260059	Magdalena Zahuatlán	5260	A
5260060	Mariscala de Juárez	5260	A
5260061	Mártires de Tacubaya	5260	A
5260062	Matías Romero	5260	A
5260063	Mazatlán Villa de Flores	5260	A
5260064	Mesones Hidalgo	5260	A
5260065	Miahuatlán de Porfirio Díaz	5260	A
5260066	Mixistlán de la Reforma	5260	A
5260067	Monjas	5260	A
5260068	Natividad	5260	A
5260069	Nazareno Etla	5260	A
5260070	Nejapa de Madero	5260	A
5260071	Nuevo Soyaltepec	5260	A
5260072	Nuevo Zoquiapam	5260	A
5260073	Oaxaca de Juárez	5260	A
5260074	Ocotlán de Morelos	5260	A
5260075	Pinotepa de Don Luis	5260	A
5260076	Pluma Hidalgo	5260	A
5260077	Putla Villa de Guerrero	5260	A
5260078	Reforma de Pineda	5260	A
5260079	Reyes Etla	5260	A
5260080	Rojas de Cuauhtémoc	5260	A
5260081	Salina Cruz	5260	A
5260082	San Agustín Amatengo	5260	A
5260083	San Agustín Atenango	5260	A
5260084	San Agustín Chayuco	5260	A
5260085	San Agustín de las Juntas	5260	A
5260086	San Agustín Etla	5260	A
5260087	San Agustín Loxicha	5260	A
5260088	San Agustín Tlacotepec	5260	A
5260089	San Agustín Yatareni	5260	A
5260090	San Andrés Cabecera Nva.	5260	A
5260091	San Andrés Dinicuiti	5260	A
5260092	San Andrés Huaxpaltepec	5260	A
5260093	San Andrés Huayapam	5260	A
5260094	San Andrés Ixtlahuaca	5260	A
5260095	San Andrés Lagunas	5260	A
5260096	San Andrés Nuxiño	5260	A
5260097	San Andrés Paxtlan	5260	A
5260098	San Andrés Sinaxtla	5260	A
5260099	San Andrés Solaga	5260	A
5260100	San Andrés Teotilalpam	5260	A
5260101	San Andrés Tepetlapa	5260	A
5260102	San Andrés Yaa	5260	A
5260103	San Andrés Zabache	5260	A
5260104	San Andrés Zautla	5260	A
5260105	San Antonino Castillo Velasco	5260	A
5260106	San Antonino El Alto	5260	A
5260107	San Antonino Monte Verde	5260	A
5260108	San Antonio Acutla	5260	A
5260109	San Antonio de la Cal	5260	A
5260110	San Antonio Huitepec	5260	A
5260111	San Antonio Nanahuatipam	5260	A
5260112	San Antonio Sinicahua	5260	A
5260113	San Antonio Tepetlapa	5260	A
5260114	San Baltazar Chichicapam	5260	A
5260115	San Baltazar Loxicha	5260	A
5260116	San Baltazar Yatzechi el Bajo	5260	A
5260117	San Bartolo Coyotepec	5260	A
5260118	San Bartolo Soyaltepec	5260	A
5260119	San Bartolo Yautepec	5260	A
5260120	San Bartolome Ayautla	5260	A
5260121	San Bartolome Loxicha	5260	A
5260122	San Bartolome Quialana	5260	A
5260123	San Bartolome Yucuañe	5260	A
5260124	San Bartolome Zoogocho	5260	A
5260125	San Bernardo Mixtepec	5260	A
5260126	San Blas Atempa	5260	A
5260127	San Carlos Yautepec	5260	A
5260128	San Cristóbal Amatlán	5260	A
5260129	San Cristóbal Amoltepec	5260	A
5260130	San Cristóbal Lachirioag	5260	A
5260131	San Cristóbal Suchixtlahuaca	5260	A
5260132	San Dionisio del Mar	5260	A
5260133	San Dionisio Ocotepec	5260	A
5260134	San Dionisio Ocotlán	5260	A
5260135	San Esteban Atatlahuca	5260	A
5260136	San Felipe Jalapa de Díaz	5260	A
5260137	San Felipe Tejalapam	5260	A
5260138	San Felipe Usila	5260	A
5260139	San Francisco Cahuacua	5260	A
5260140	San Francisco Cajonos	5260	A
5260141	San Francisco Chapulapa	5260	A
5260142	San Francisco Chindua	5260	A
5260143	San Francisco del Mar	5260	A
5260144	San Francisco Huehuetlán	5260	A
5260145	San Francisco Ixhuatán	5260	A
5260146	San Francisco Jaltepetongo	5260	A
5260147	San Francisco Lachigolo	5260	A
5260148	San Francisco Logueche	5260	A
5260149	San Francisco Nuxalo	5260	A
5260150	San Francisco Ozolotepec	5260	A
5260151	San Francisco Sola	5260	A
5260152	San Francisco Telixtlahuaca	5260	A
5260153	San Francisco Teopan	5260	A
5260154	San Francisco Tlapancingo	5260	A
5260155	San Gabriel Mixtepec	5260	A
5260156	San Ildefonso Amatlán	5260	A
5260157	San Ildefonso Sola	5260	A
5260158	San Ildefonso Villa Alta	5260	A
5260159	San Jacinto Amilpas	5260	A
5260160	San Jacinto Tlacotepec	5260	A
5260161	San Jerónimo Coatlán	5260	A
5260162	San Jerónimo Silacayoapilla	5260	A
5260163	San Jerónimo Sosola	5260	A
5260164	San Jerónimo Taviche	5260	A
5260165	San Jerónimo Tecoatl	5260	A
5260166	San Jerónimo Tlacochahuaya	5260	A
5260167	San Jorge Nuchita	5260	A
5260168	San José Ayuquila	5260	A
5260169	San José Chiltepec	5260	A
5260170	San José del Peñasco	5260	A
5260171	San José del Progreso	5260	A
5260172	San José Estancia Grande	5260	A
5260173	San José Independencia	5260	A
5260174	San José Lachiguiri	5260	A
5260175	San José Tenango	5260	A
5260176	San Juan Achiutla	5260	A
5260177	San Juan Atepec	5260	A
5260178	San Juan Bautista Atatlahuca	5260	A
5260179	San Juan Bautista Coixtlahuaca	5260	A
5260180	San Juan Bautista Cuicatlán	5260	A
5260181	San Juan Bautista Guelache	5260	A
5260182	San Juan Bautista Jayacatlán	5260	A
5260183	San Juan Bautista lo de Soto	5260	A
5260184	San Juan Bautista Suchitepec	5260	A
5260185	San Juan Bautista Tlachichilco	5260	A
5260186	San Juan Bautista Tlacoazintepec	5260	A
5260187	San Juan Bautista Tuxtepec	5260	A
5260188	San Juan Bautista Valle Nacional	5260	A
5260189	San Juan Cacahuatepec	5260	A
5260190	San Juan Chicomezuchil	5260	A
5260191	San Juan Chilateca	5260	A
5260192	San Juan Chiquihuitlán	5260	A
5260193	San Juan Cieneguilla	5260	A
5260194	San Juan Coatzospam	5260	A
5260195	San Juan Colorado	5260	A
5260196	San Juan Comaltepec	5260	A
5260197	San Juan Cotzocon	5260	A
5260198	San Juan de los Cues	5260	A
5260199	San Juan del Estado	5260	A
5260200	San Juan del Río	5260	A
5260201	San Juan Diuxi	5260	A
5260202	San Juan Evangelista Analco	5260	A
5260203	San Juan Guelavia	5260	A
5260204	San Juan Guichicovi	5260	A
5260205	San Juan Ihualtepec	5260	A
5260206	San Juan Juquila Mixes	5260	A
5260207	San Juan Juquila Vijanos	5260	A
5260208	San Juan Lachao	5260	A
5260209	San Juan Lachigalla	5260	A
5260210	San Juan Lajarcia	5260	A
5260211	San Juan Lalana	5260	A
5260212	San Juan Mazatlán	5260	A
5260213	San Juan Mixtepec	5260	A
5260214	San Juan Mixtepec	5260	A
5260215	San Juan Ñumi	5260	A
5260216	San Juan Ozolotepec	5260	A
5260217	San Juan Petlapa	5260	A
5260218	San Juan Quiahije	5260	A
5260219	San Juan Quiotepec	5260	A
5260220	San Juan Sayultepec	5260	A
5260221	San Juan Tabaa	5260	A
5260222	San Juan Tamazola	5260	A
5260223	San Juan Teita	5260	A
5260224	San Juan Teitipac	5260	A
5260225	San Juan Tepeuxila	5260	A
5260226	San Juan Teposcolula	5260	A
5260227	San Juan Yaee	5260	A
5260228	San Juan Yatzona	5260	A
5260229	San Juan Yucuita	5260	A
5260230	San Lorenzo	5260	A
5260231	San Lorenzo Albarradas	5260	A
5260232	San Lorenzo Cacaotepec	5260	A
5260233	San Lorenzo Cuaunecuiltitla	5260	A
5260234	San Lorenzo Texmelucan	5260	A
5260235	San Lorenzo Victoria	5260	A
5260236	San Lucas Camotlán	5260	A
5260237	San Lucas Ojitlán	5260	A
5260238	San Lucas Quiavini	5260	A
5260239	San Lucas Zoquiapam	5260	A
5260240	San Luis Amatlán	5260	A
5260241	San Marcial Ozolotepec	5260	A
5260242	San Marcos Arteaga	5260	A
5260243	San Martin de los Cansecos	5260	A
5260244	San Martin Huamelulpam	5260	A
5260245	San Martin Itunyoso	5260	A
5260246	San Martin Lachila	5260	A
5260247	San Martin Peras	5260	A
5260248	San Martin Tilcajete	5260	A
5260249	San Martin Toxpalan	5260	A
5260250	San Martin Zacatepec	5260	A
5260251	San Mateo Cajonos	5260	A
5260252	San Mateo del Mar	5260	A
5260253	San Mateo Etlatongo	5260	A
5260254	San Mateo Nejapam	5260	A
5260255	San Mateo Peñasco	5260	A
5260256	San Mateo Piñas	5260	A
5260257	San Mateo Río Hondo	5260	A
5260258	San Mateo Sindihui	5260	A
5260259	San Mateo Tlapiltepec	5260	A
5260260	San Mateo Yoloxochitlán	5260	A
5260261	San Melchor Betaza	5260	A
5260262	San Miguel Achiutla	5260	A
5260263	San Miguel Ahuehuetitlán	5260	A
5260264	San Miguel Aloapam	5260	A
5260265	San Miguel Amatitlán	5260	A
5260266	San Miguel Amatlán	5260	A
5260267	San Miguel Chicahua	5260	A
5260268	San Miguel Chimalapa	5260	A
5260269	San Miguel Coatlán	5260	A
5260270	San Miguel del Puerto	5260	A
5260271	San Miguel del Río	5260	A
5260272	San Miguel Ejutla	5260	A
5260273	San Miguel El Grande	5260	A
5260274	San Miguel Huautla	5260	A
5260275	San Miguel Mixtepec	5260	A
5260276	San Miguel Panixtlahuaca	5260	A
5260277	San Miguel Peras	5260	A
5260278	San Miguel Piedras	5260	A
5260279	San Miguel Quetzaltepec	5260	A
5260280	San Miguel Santa Flor	5260	A
5260281	San Miguel Suchixtepec	5260	A
5260282	San Miguel Talea de Castro	5260	A
5260283	San Miguel Tecomatlán	5260	A
5260284	San Miguel Tenango	5260	A
5260285	San Miguel Tequixtepec	5260	A
5260286	San Miguel Tilquiapam	5260	A
5260287	San Miguel Tlacamama	5260	A
5260288	San Miguel Tlacotepec	5260	A
5260289	San Miguel Tulancingo	5260	A
5260290	San Miguel Yotao	5260	A
5260291	San Nicolás	5260	A
5260292	San Nicolás Hidalgo	5260	A
5260293	San Pablo Coatlán	5260	A
5260294	San Pablo Cuatro Venados	5260	A
5260295	San Pablo Etla	5260	A
5260296	San Pablo Huitzo	5260	A
5260297	San Pablo Huixtepec	5260	A
5260298	San Pablo Macuiltianguis	5260	A
5260299	San Pablo Tijaltepec	5260	A
5260300	San Pablo Villa de Mitla	5260	A
5260301	San Pablo Yaganiza	5260	A
5260302	San Pedro Amuzgos	5260	A
5260303	San Pedro Apostol	5260	A
5260304	San Pedro Atoyac	5260	A
5260305	San Pedro Cajonos	5260	A
5260306	San Pedro Cántaros Coxcaltepec	5260	A
5260307	San Pedro Comitancillo	5260	A
5260308	San Pedro El Alto	5260	A
5260309	San Pedro Huamelula	5260	A
5260310	San Pedro Huilotepec	5260	A
5260311	San Pedro Ixcatlán	5260	A
5260312	San Pedro Ixtlahuaca	5260	A
5260313	San Pedro Jaltepetongo	5260	A
5260314	San Pedro Jicayan	5260	A
5260315	San Pedro Jocotipac	5260	A
5260316	San Pedro Juchatengo	5260	A
5260317	San Pedro Mártir	5260	A
5260318	San Pedro Mártir Quiechapa	5260	A
5260319	San Pedro Mártir Yucuxaco	5260	A
5260320	San Pedro Mixtepec	5260	A
5260321	San Pedro Mixtepec	5260	A
5260322	San Pedro Molinos	5260	A
5260323	San Pedro Nopala	5260	A
5260324	San Pedro Ocopetatillo	5260	A
5260325	San Pedro Ocotepec	5260	A
5260326	San Pedro Pochutla	5260	A
5260327	San Pedro Quiatoni	5260	A
5260328	San Pedro Sochiapam	5260	A
5260329	San Pedro Tapanatepec	5260	A
5260330	San Pedro Taviche	5260	A
5260331	San Pedro Teozacoalco	5260	A
5260332	San Pedro Teutila	5260	A
5260333	San Pedro Tidaa	5260	A
5260334	San Pedro Topiltepec	5260	A
5260335	San Pedro Totolapan	5260	A
5260336	San Pedro Tututepec	5260	A
5260337	San Pedro y San Pablo Ayutla	5260	A
5260338	San Pedro y San Pablo Teposcolula	5260	A
5260339	San Pedro y San Pablo Tequixtepec	5260	A
5260340	San Pedro Yaneri	5260	A
5260341	San Pedro Yolox	5260	A
5260342	San Pedro Yucunama	5260	A
5260343	San Raymundo Jalpan	5260	A
5260344	San Sebastián Abasolo	5260	A
5260345	San Sebastián Coatlán	5260	A
5260346	San Sebastián Ixcapa	5260	A
5260347	San Sebastián Nicananduta	5260	A
5260348	San Sebastián Río Hondo	5260	A
5260349	San Sebastián Tecomaxtlahuaca	5260	A
5260350	San Sebastián Teitipac	5260	A
5260351	San Sebastián Tutla	5260	A
5260352	San Simón Almolongas	5260	A
5260353	San Simón Zahuatlán	5260	A
5260354	San Vicente Coatlán	5260	A
5260355	San Vicente Lachixio	5260	A
5260356	San Vicente Nuñu	5260	A
5260357	Santa Ana	5260	A
5260358	Santa Ana Ateixtlahuaca	5260	A
5260359	Santa Ana Cuauhtémoc	5260	A
5260360	Santa Ana del Valle	5260	A
5260361	Santa Ana Tavela	5260	A
5260362	Santa Ana Tlapacoyan	5260	A
5260363	Santa Ana Yareni	5260	A
5260364	Santa Ana Zegache	5260	A
5260365	Santa Catalina Quieri	5260	A
5260366	Santa Catarina Cuixtla	5260	A
5260367	Santa Catarina Ixtepeji	5260	A
5260368	Santa Catarina Juquila	5260	A
5260369	Santa Catarina Lachatao	5260	A
5260370	Santa Catarina Loxicha	5260	A
5260371	Santa Catarina Mechoacan	5260	A
5260372	Santa Catarina Minas	5260	A
5260373	Santa Catarina Quiane	5260	A
5260374	Santa Catarina Tayata	5260	A
5260375	Santa Catarina Ticua	5260	A
5260376	Santa Catarina Yosonotu	5260	A
5260377	Santa Catarina Zapoquila	5260	A
5260378	Santa Cruz Acatepec	5260	A
5260379	Santa Cruz Amilpas	5260	A
5260380	Santa Cruz de Bravo	5260	A
5260381	Santa Cruz Itundujia	5260	A
5260382	Santa Cruz Mixtepec	5260	A
5260383	Santa Cruz Nundaco	5260	A
5260384	Santa Cruz Papalutla	5260	A
5260385	Santa Cruz Tacache de Mina	5260	A
5260386	Santa Cruz Tacahua	5260	A
5260387	Santa Cruz Tayata	5260	A
5260388	Santa Cruz Xitla	5260	A
5260389	Santa Cruz Xoxocotlán	5260	A
5260390	Santa Cruz Zenzontepec	5260	A
5260391	Santa Gertrudis	5260	A
5260392	Santa Inés de Zaragoza	5260	A
5260393	Santa Inés del Monte	5260	A
5260394	Santa Inés Yatzeche	5260	A
5260395	Santa Lucía del Camino	5260	A
5260396	Santa Lucía Miahuatlán	5260	A
5260397	Santa Lucía Monte Verde	5260	A
5260398	Santa Lucía Ocotlán	5260	A
5260399	Santa María Alotepec	5260	A
5260400	Santa María Apazco	5260	A
5260401	Santa María Atzompa	5260	A
5260402	Santa María Camotlán	5260	A
5260403	Santa María Chachoapam	5260	A
5260404	Santa María Chilapa de Díaz	5260	A
5260405	Santa María Chilchotla	5260	A
5260406	Santa María Chimalapa	5260	A
5260407	Santa María Colotepec	5260	A
5260408	Santa María Cortijo	5260	A
5260409	Santa María Coyotepec	5260	A
5260410	Santa María del Rosario	5260	A
5260411	Santa María del Tule	5260	A
5260412	Santa María Ecatepec	5260	A
5260413	Santa María Guelace	5260	A
5260414	Santa María Guienagati	5260	A
5260415	Santa María Huatulco	5260	A
5260416	Santa María Huazolotitlán	5260	A
5260417	Santa María Ipalapa	5260	A
5260418	Santa María Ixcatlán	5260	A
5260419	Santa María Jacatepec	5260	A
5260420	Santa María Jalapa de Márquez	5260	A
5260421	Santa María Jaltianguis	5260	A
5260422	Santa María la Asunción	5260	A
5260423	Santa María Lachixio	5260	A
5260424	Santa María Mixtequilla	5260	A
5260425	Santa María Nativitas	5260	A
5260426	Santa María Nduayaco	5260	A
5260427	Santa María Ozolotepec	5260	A
5260428	Santa María Papalo	5260	A
5260429	Santa María Peñoles	5260	A
5260430	Santa María Petapa	5260	A
5260431	Santa María Quiegolani	5260	A
5260432	Santa María Sola	5260	A
5260433	Santa María Tataltepec	5260	A
5260434	Santa María Tecomavaca	5260	A
5260435	Santa María Temaxcalapa	5260	A
5260436	Santa María Temaxcaltepec	5260	A
5260437	Santa María Teopoxco	5260	A
5260438	Santa María Tepantlali	5260	A
5260439	Santa María Texcatitlán	5260	A
5260440	Santa María Tlahuitoltepec	5260	A
5260441	Santa María Tlalixtac	5260	A
5260442	Santa María Tonameca	5260	A
5260443	Santa María Totolapilla	5260	A
5260444	Santa María Xadani	5260	A
5260445	Santa María Yalina	5260	A
5260446	Santa María Yavesia	5260	A
5260447	Santa María Yolotepec	5260	A
5260448	Santa María Yosoyua	5260	A
5260449	Santa María Yucuhiti	5260	A
5260450	Santa María Zacatepec	5260	A
5260451	Santa María Zaniza	5260	A
5260452	Santa María Zoquitlán	5260	A
5260453	Santiago Amoltepec	5260	A
5260454	Santiago Apoala	5260	A
5260455	Santiago Apóstol	5260	A
5260456	Santiago Astata	5260	A
5260457	Santiago Atitlán	5260	A
5260458	Santiago Ayuquililla	5260	A
5260459	Santiago Cacaloxtepec	5260	A
5260460	Santiago Camotlán	5260	A
5260461	Santiago Chazumba	5260	A
5260462	Santiago Choapam	5260	A
5260463	Santiago Comaltepec	5260	A
5260464	Santiago del Río	5260	A
5260465	Santiago Huajolotitlán	5260	A
5260466	Santiago Huauclilla	5260	A
5260467	Santiago Ihuitlán plumas	5260	A
5260468	Santiago Ixcuintepec	5260	A
5260469	Santiago Ixtayutla	5260	A
5260470	Santiago Jamiltepec	5260	A
5260471	Santiago Jocotepec	5260	A
5260472	Santiago Juxtlahuaca	5260	A
5260473	Santiago Lachiguiri	5260	A
5260474	Santiago Lalopa	5260	A
5260475	Santiago Laollaga	5260	A
5260476	Santiago Laxopa	5260	A
5260477	Santiago Llano Grande	5260	A
5260478	Santiago Matatlán	5260	A
5260479	Santiago Miltepec	5260	A
5260480	Santiago Minas	5260	A
5260481	Santiago Nacaltepec	5260	A
5260482	Santiago Nejapilla	5260	A
5260483	Santiago Niltepe	5260	A
5260484	Santiago Nundiche	5260	A
5260485	Santiago Nuyoo	5260	A
5260486	Santiago Pinotepa Nacional	5260	A
5260487	Santiago Suchilquitongo	5260	A
5260488	Santiago Tamazola	5260	A
5260489	Santiago Tapextla	5260	A
5260490	Santiago Tenango	5260	A
5260491	Santiago Tepetlapa	5260	A
5260492	Santiago Tetepec	5260	A
5260493	Santiago Texcalcingo	5260	A
5260494	Santiago Textitlán	5260	A
5260495	Santiago Tilantongo	5260	A
5260496	Santiago Tillo	5260	A
5260497	Santiago Tlazoyaltepec	5260	A
5260498	Santiago Xanica	5260	A
5260499	Santiago Xiacui	5260	A
5260500	Santiago Yaitepec	5260	A
5260501	Santiago Yaveo	5260	A
5260502	Santiago Yolomecatl	5260	A
5260503	Santiago Yosondua	5260	A
5260504	Santiago Yucuyachi	5260	A
5260505	Santiago Zacatepec	5260	A
5260506	Santiago Zoochila	5260	A
5260507	Santo Domingo Albarradas	5260	A
5260508	Santo Domingo Armenta	5260	A
5260509	Santo Domingo Chihuitán	5260	A
5260510	Santo Domingo de Morelos	5260	A
5260511	Santo Domingo Ingenio	5260	A
5260512	Santo Domingo Ixcatlán	5260	A
5260513	Santo Domingo Nuxaa	5260	A
5260514	Santo Domingo Ozolotepec	5260	A
5260515	Santo Domingo Petapa	5260	A
5260516	Santo Domingo Roayaga	5260	A
5260517	Santo Domingo Tehuantepec	5260	A
5260518	Santo Domingo Teojomulco	5260	A
5260519	Santo Domingo Tepuxtepec	5260	A
5260520	Santo Domingo Tlatayapam	5260	A
5260521	Santo Domingo Tomaltepec	5260	A
5260522	Santo Domingo Tonalá	5260	A
5260523	Santo Domingo Tonaltepec	5260	A
5260524	Santo Domingo Xagacia	5260	A
5260525	Santo Domingo Yanhuitlán	5260	A
5260526	Santo Domingo Yodohino	5260	A
5260527	Santo Domingo Zanatepec	5260	A
5260528	Santo Tomás Jalieza	5260	A
5260529	Santo Tomás Mazaltepec	5260	A
5260530	Santo Tomás Ocotepec	5260	A
5260531	Santo Tomás Tamazulapam	5260	A
5260532	Santos Reyes Nopala	5260	A
5260533	Santos Reyes Papalo	5260	A
5260534	Santos Reyes Tepejillo	5260	A
5260535	Santos Reyes Yucuna	5260	A
5260536	Silacayoapam	5260	A
5260537	Sitio de Xitlapehua	5260	A
5260538	Soledad Etla	5260	A
5260539	Sta. Catarina Quioquitani	5260	A
5260540	Sta. Magdalena Jicotlán	5260	A
5260541	Tamazulapam del Espíritu Sto.	5260	A
5260542	Tanetze de Zaragoza	5260	A
5260543	Taniche	5260	A
5260544	Tataltepec de Valdez	5260	A
5260545	Teococuilco de Marcos Pérez	5260	A
5260546	Teotitlán de Flores Magón	5260	A
5260547	Teotitlán del Valle	5260	A
5260548	Teotongo	5260	A
5260549	Tepelmeme Villa de Morelos	5260	A
5260550	Tezoatlán de Segura y Luna	5260	A
5260551	Tlacolula de Matamoros	5260	A
5260552	Tlacotepec Plumas	5260	A
5260553	Tlalixtac de Cabrera	5260	A
5260554	Totontepec Villa de Morelos	5260	A
5260555	Trinidad Zaachila	5260	A
5260556	Unión Hidalgo	5260	A
5260557	Valerio Trujano	5260	A
5260558	Villa de Díaz Ordaz	5260	A
5260559	Villa de Etla	5260	A
5260560	Villa de Tamazulapam del Progreso	5260	A
5260561	Villa de Zaachila	5260	A
5260562	Villa Hidalgo	5260	A
5260563	Villa Sola de Vega	5260	A
5260564	Villa Tejupam de la Unión	5260	A
5260565	Yaxe	5260	A
5260566	Yogana	5260	A
5260567	Yutanduchi de Guerrero	5260	A
5260568	Zapotitlán del Río	5260	A
5260569	Zapotitlán Lagunas	5260	A
5260570	Zapotitlán Palmas	5260	A
5260571	Zimatlán de Alvarez	5260	A
5260998	Indeterminado	5260	A
5263004	Acajete	5263	A
5263008	Acateno	5263	A
5263012	Acatlán	5263	A
5263016	Acatzingo	5263	A
5263020	Acteopan	5263	A
5263024	Ahuacatlán	5263	A
5263028	Ahuatlán	5263	A
5263032	Ahuazotepec	5263	A
5263036	Ahuehuetitla	5263	A
5263040	Ajalpan	5263	A
5263044	Albino Zertuche	5263	A
5263048	Aljojuca	5263	A
5263052	Altepexi	5263	A
5263056	Amixtlán	5263	A
5263060	Amozoc	5263	A
5263064	Aquixtla	5263	A
5263068	Atempan	5263	A
5263072	Atexcal	5263	A
5263076	Atlequizayán	5263	A
5263080	Atlixco	5263	A
5263084	Atoyatempan	5263	A
5263088	Atzala	5263	A
5263092	Atzitzihuacán	5263	A
5263096	Atzitzintla	5263	A
5263100	Axutla	5263	A
5263104	Ayotoxco de Guerrero	5263	A
5263108	Calpan	5263	A
5263112	Caltepec	5263	A
5263116	Camocuautla	5263	A
5263120	Cañada de Morelos	5263	A
5263124	Caxhuacán	5263	A
5263128	Chalchicomula de Sesma	5263	A
5263132	Chapulco	5263	A
5263136	Chiautla	5263	A
5263140	Chiautzingo	5263	A
5263144	Chichiquila	5263	A
5263148	Chiconcuautla	5263	A
5263152	Chietla	5263	A
5263156	Chigmecatitlán	5263	A
5263160	Chignahuapan	5263	A
5263164	Chignautla	5263	A
5263168	Chila	5263	A
5263172	Chila de la Sal	5263	A
5263176	Chila Honey	5263	A
5263180	Chilchotla	5263	A
5263184	Chinantla	5263	A
5263188	Coatepec	5263	A
5263192	Coatzingo	5263	A
5263196	Cohetzala	5263	A
5263200	Cohuecán	5263	A
5263204	Coronango	5263	A
5263208	Coxcatlán	5263	A
5263212	Coyomeapan	5263	A
5263216	Coyotepec	5263	A
5263220	Cuahutinchán	5263	A
5263224	Cuapiaxtla de Madero	5263	A
5263228	Cuatlancingo	5263	A
5263232	Cuautempan	5263	A
5263236	Cuayuca de Andrade	5263	A
5263240	Cuetzalán del Progreso	5263	A
5263244	Cuyoaco	5263	A
5263248	Domingo Arenas	5263	A
5263252	Eloxochitlán	5263	A
5263256	Epatlán	5263	A
5263260	Esperanza	5263	A
5263264	Francisco Z. Mena	5263	A
5263268	General Felipe Angeles	5263	A
5263272	Guadalupe	5263	A
5263276	Guadalupe Victoria	5263	A
5263280	Hermenegildo Galeana	5263	A
5263284	Huachinango	5263	A
5263288	Huaquechula	5263	A
5263292	Huatlatlauca	5263	A
5263296	Huehuetla	5263	A
5263300	Huehuetlán el Chico	5263	A
5263304	Huehuetlán el Grande	5263	A
5263308	Huejotzingo	5263	A
5263312	Hueyapan	5263	A
5263316	Hueytamalco	5263	A
5263320	Hueytlalpan	5263	A
5263324	Huitzilán de Serdán	5263	A
5263328	Huitziltepec	5263	A
5263332	Ixcamilpa de Guerrero	5263	A
5263336	Ixcaquixtla	5263	A
5263340	Ixtacamaxtitlán	5263	A
5263344	Ixtepec	5263	A
5263348	Izúcar de Matamoros	5263	A
5263352	Jalpan	5263	A
5263356	Jolalpan	5263	A
5263360	Jonotla	5263	A
5263364	Jopala	5263	A
5263368	Juan C. Bonilla	5263	A
5263372	Juan Galindo	5263	A
5263376	Juan N. Méndez	5263	A
5263380	La Magdalena Tlatlauquitepec	5263	A
5263384	Lafragua	5263	A
5263388	Libres	5263	A
5263392	Los Reyes de Juárez	5263	A
5263396	Mazapiltepec de Juárez	5263	A
5263400	Mixtla	5263	A
5263404	Molcaxac	5263	A
5263408	Naupan	5263	A
5263412	Nauzontla	5263	A
5263416	Nealticán	5263	A
5263420	Nicolás Bravo	5263	A
5263424	Nopalucan	5263	A
5263428	Ocotepec	5263	A
5263432	Ocoyucan	5263	A
5263436	Olintla	5263	A
5263440	Oriental	5263	A
5263444	Pahuatlán	5263	A
5263448	Palmar de Bravo	5263	A
5263452	Pantepec	5263	A
5263456	Petlalcingo	5263	A
5263460	Piaxtla	5263	A
5263464	Puebla	5263	A
5263468	Quecholac	5263	A
5263472	Quimixtlán	5263	A
5263476	Rafael Lara Grajales	5263	A
5263480	San Andrés Cholula	5263	A
5263484	San Antonio Cañada	5263	A
5263488	San Diego la Mesa Tochimiltzingo	5263	A
5263492	San Felipe Teotlalcingo	5263	A
5263496	San Felipe Tepatlán	5263	A
5263500	San Gabriel Chilac	5263	A
5263504	San Gregorio Atzompa	5263	A
5263508	San Jerónimo Tecuanipán	5263	A
5263512	San Jerónimo Xacayatlán	5263	A
5263516	San José Chiapa	5263	A
5263520	San José Miahuatlán	5263	A
5263524	San Juan Atenco	5263	A
5263528	San Juan Atzompa	5263	A
5263532	San Martín Texmelucán	5263	A
5263536	San Martín Totoltepec	5263	A
5263540	San Matías Tlalancaleca	5263	A
5263544	San Miguel Ixitlán	5263	A
5263548	San Miguel Xoxtla	5263	A
5263552	San Nicolás Buenos Aires	5263	A
5263556	San Nicolás de los Ranchos	5263	A
5263560	San Pablo Anicano	5263	A
5263564	San Pedro Cholula	5263	A
5263568	San Pedro Yeloixtlahuaca	5263	A
5263572	San Salvador el Seco	5263	A
5263576	San Salvador el Verde	5263	A
5263580	San Salvador Huixcolotla	5263	A
5263584	San Sebastián Tlacotepec	5263	A
5263588	Santiago Miahuatlán	5263	A
5263592	Soltepec	5263	A
5263596	Sta. Catarina Tlaltempan	5263	A
5263600	Sta. Inés Ahuatempan	5263	A
5263604	Sta. Isabel Cholula	5263	A
5263608	Sto. Tomás Hueyotlipan	5263	A
5263612	Tecali de Herrera	5263	A
5263616	Tecamachalco	5263	A
5263620	Tecomatlán	5263	A
5263624	Tehuacán	5263	A
5263628	Tehuitzingo	5263	A
5263632	Tenampulco	5263	A
5263636	Teopantlán	5263	A
5263640	Teotlalco	5263	A
5263644	Tepanco de López	5263	A
5263648	Tepango de Rodríguez	5263	A
5263652	Tepatlaxco de Hidalgo	5263	A
5263656	Tepeaca	5263	A
5263660	Tepemaxalco	5263	A
5263664	Tepeojuma	5263	A
5263668	Tepetzintla	5263	A
5263672	Tepexco	5263	A
5263676	Tepexi de Rodríguez	5263	A
5263680	Tepeyahualco	5263	A
5263684	Tepeyahualco de Cuauhtémoc	5263	A
5263688	Tetela de Ocampo	5263	A
5263692	Teteles de Avila Castillo	5263	A
5263696	Teziutlán	5263	A
5263700	Tianguismanalco	5263	A
5263704	Tilapa	5263	A
5263708	Tlachichuca	5263	A
5263712	Tlacotepec de Benito Juárez	5263	A
5263716	Tlacuilotepec	5263	A
5263720	Tlahuapan	5263	A
5263724	Tlalnepantla	5263	A
5263728	Tlaltenango	5263	A
5263732	Tlaola	5263	A
5263736	Tlapacoya	5263	A
5263740	Tlapanala	5263	A
5263744	Tlatlauquitepec	5263	A
5263748	Tlaxco	5263	A
5263752	Tochimilco	5263	A
5263756	Tochtepec	5263	A
5263760	Toltepec de Guerrero	5263	A
5263764	Tulcingo	5263	A
5263768	Tuzamapan de Galeana	5263	A
5263772	Tzicatlacoyán	5263	A
5263776	Venustiano Carranza	5263	A
5263780	Vicente Guerrero	5263	A
5263784	Xayacatlán de Bravo	5263	A
5263788	Xicotepec	5263	A
5263792	Xicotlán	5263	A
5263796	Xiutetelco	5263	A
5263800	Xochiapulco	5263	A
5263804	Xochiltepec	5263	A
5263808	Xochitlán de Vicente Suárez	5263	A
5263812	Xochitlán Todos Santos	5263	A
5263816	Yaonahuac	5263	A
5263820	Yehualtepec	5263	A
5263824	Zacapala	5263	A
5263828	Zacapoaxtla	5263	A
5263832	Zacatlán	5263	A
5263836	Zapotitlán	5263	A
5263840	Zapotitlán de Méndez	5263	A
5263844	Zaragoza	5263	A
5263848	Zautla	5263	A
5263852	Zihuateutla	5263	A
5263856	Zinacatepec	5263	A
5263860	Zongozotla	5263	A
5263864	Zoquiapan	5263	A
5263868	Zoquitlán	5263	A
5263998	Indeterminado	5263	A
5266045	Amealco	5266	A
5266090	Arroyo Seco	5266	A
5266135	Cadereyta	5266	A
5266180	Colón	5266	A
5266225	Corregidora	5266	A
5266270	El Marquéz	5266	A
5266315	Ezequiel Montes	5266	A
5266360	Huimilpan	5266	A
5266405	Jalpan	5266	A
5266450	Landa de Matamoros	5266	A
5266495	Pedro Escobedo	5266	A
5266540	Peñamiller	5266	A
5266585	Pinal de Amoles	5266	A
5266630	Querétaro	5266	A
5266675	San Joaquín	5266	A
5266720	San Juan del Río	5266	A
5266765	Tequisquiapan	5266	A
5266810	Tolimán	5266	A
5266998	Indeterminado	5266	A
5269124	Benito Juárez	5269	A
5269248	Cozumel	5269	A
5269372	Felipe Carrillo Puerto	5269	A
5269496	Isla Mujeres	5269	A
5269620	José María Morelos	5269	A
5269744	Lázaro Cárdenas	5269	A
5269868	Othón P. Blanco	5269	A
5269992	Solidaridad	5269	A
5269998	Indeterminado	5269	A
5272016	Ahualulco	5272	A
5272032	Alaquines	5272	A
5272048	Aquismón	5272	A
5272064	Armadillo de los Infante	5272	A
5272080	Axtla	5272	A
5272096	Cárdenas	5272	A
5272112	Cedral	5272	A
5272128	Cerritos	5272	A
5272144	Cerro de San Pedro	5272	A
5272160	Chalchicuautla	5272	A
5272176	Charcas	5272	A
5272192	Ciudad del Maíz	5272	A
5272208	Ciudad Fernández	5272	A
5272224	Ciudad Valles	5272	A
5272240	Coxcatlán	5272	A
5272256	Ebano	5272	A
5272272	El Naranjo	5272	A
5272288	Guadalcázar	5272	A
5272304	Huehuetlán	5272	A
5272320	Lagunillas	5272	A
5272336	Matehuala	5272	A
5272352	Matlapa	5272	A
5272368	Mexquitic de Carmona	5272	A
5272384	Moctezuma	5272	A
5272400	Rayón	5272	A
5272416	Real de Catorce	5272	A
5272432	Rioverde	5272	A
5272448	Salinas de Hidalgo	5272	A
5272464	San Antonio	5272	A
5272480	San Ciro de Acosta	5272	A
5272496	San Luis Potosí	5272	A
5272512	San Martín	5272	A
5272528	San NicolásTolentino	5272	A
5272544	San Vicente Tancuayalab	5272	A
5272560	Santa Catarina	5272	A
5272576	Santa María del Río	5272	A
5272592	Santo Domingo	5272	A
5272608	Soledad de Graciano Sánchez	5272	A
5272624	Tamasopo	5272	A
5272640	Tamazunchale	5272	A
5272656	Tampacán	5272	A
5272672	Tampamolón Corona	5272	A
5272688	Tamuín	5272	A
5272704	Tancanhuitz de Santos	5272	A
5272720	Tanlajaz	5272	A
5272736	Tanquián de Escobedo	5272	A
5272752	Tierranueva	5272	A
5272768	Vanegas	5272	A
5272784	Venado	5272	A
5272800	Villa de Arista	5272	A
5272816	Villa de Arriaga	5272	A
5272832	Villa de Guadalupe	5272	A
5272848	Villa de la Paz	5272	A
5272864	Villa de Ramos	5272	A
5272880	Villa de Reyes	5272	A
5272896	Villa de Zaragoza	5272	A
5272912	Villa Hidalgo	5272	A
5272928	Villa Juárez	5272	A
5272944	Xilitla	5272	A
5272998	Indeterminado	5272	A
5275055	Ahome	5275	A
5275110	Angostura	5275	A
5275165	Badiraguato	5275	A
5275220	Choix	5275	A
5275275	Concordia	5275	A
5275330	Cosalá	5275	A
5275385	Culiacán	5275	A
5275440	El Fuerte	5275	A
5275495	Elota	5275	A
5275550	Escuinapa	5275	A
5275605	Guasave	5275	A
5275660	Mazatlán	5275	A
5275715	Mocorito	5275	A
5275770	Navolato	5275	A
5275825	Rosario	5275	A
5275880	Salvador Alvarado	5275	A
5275935	San Ignacio	5275	A
5275990	Sinaloa	5275	A
5275998	Indeterminado	5275	A
5278013	Aconchi	5278	A
5278026	Agua Prieta	5278	A
5278039	Alamos	5278	A
5278052	Altar	5278	A
5278065	Arivechi	5278	A
5278078	Arizpe	5278	A
5278091	Atil	5278	A
5278104	Bacadehuachi	5278	A
5278117	Bacanora	5278	A
5278130	Bacerac	5278	A
5278143	Bacoachi	5278	A
5278156	Bácum	5278	A
5278169	Banámichi	5278	A
5278182	Baviácora	5278	A
5278195	Bavispe	5278	A
5278208	Benito Juárez	5278	A
5278221	Benjamín Hill	5278	A
5278234	Caborca	5278	A
5278247	Cajeme	5278	A
5278260	Cananea	5278	A
5278273	Carbó	5278	A
5278286	Cucurpe	5278	A
5278299	Cumpas	5278	A
5278312	Divisaderos	5278	A
5278325	Empalme	5278	A
5278338	Etchojoa	5278	A
5278351	Fronteras	5278	A
5278364	Granados	5278	A
5278377	Guaymas	5278	A
5278390	Hermosillo	5278	A
5278403	Huachinera	5278	A
5278416	Huásabas	5278	A
5278429	Huatabampo	5278	A
5278442	Huépac	5278	A
5278455	Imuris	5278	A
5278468	La Colorada	5278	A
5278481	Magdalena	5278	A
5278494	Mazatán	5278	A
5278507	Moctezuma	5278	A
5278520	Naco	5278	A
5278533	Nácori Chico	5278	A
5278546	Nacozari	5278	A
5278559	Navojoa	5278	A
5278572	Nogales	5278	A
5278585	Onavas	5278	A
5278598	Opodepe	5278	A
5278611	Oquitoa	5278	A
5278624	Pitiquito	5278	A
5278637	Plutarco Elías Calles	5278	A
5278650	Puerto Peñasco	5278	A
5278663	Quiriego	5278	A
5278676	Rayón	5278	A
5278689	Rosario	5278	A
5278702	Sahuaripa	5278	A
5278715	San Felipe de Jesús	5278	A
5278728	San Ignacio Río Muerto	5278	A
5278741	San Javier	5278	A
5278754	San Luis Río Colorado	5278	A
5278767	San Miguel de Horcasitas	5278	A
5278780	San Pedro de la Cueva	5278	A
5278793	Santa Ana	5278	A
5278806	Santa Cruz	5278	A
5278819	Sáric	5278	A
5278832	Soyopa	5278	A
5278845	Suaqui Grande	5278	A
5278858	Tepache	5278	A
5278871	Trincheras	5278	A
5278884	Tubutama	5278	A
5278897	Ures	5278	A
5278910	Villa Hidalgo	5278	A
5278923	Villa Pesqueira	5278	A
5278936	Yécora	5278	A
5278998	Indeterminado	5278	A
5281058	Balancan	5281	A
5281116	Cárdenas	5281	A
5281174	Centla	5281	A
5281232	Centro	5281	A
5281290	Comalcalco	5281	A
5281348	Cunduacán	5281	A
5281406	Emiliano Zapata	5281	A
5281464	Huimanquillo	5281	A
5281522	Jalapa	5281	A
5281580	Jalpa de Méndez	5281	A
5281638	Jonuta	5281	A
5281696	Macuspana	5281	A
5281754	Nacajuca	5281	A
5281812	Paraiso	5281	A
5281870	Tacotalpa	5281	A
5281928	Teapa	5281	A
5281986	Tenosquique	5281	A
5281998	Indeterminado	5281	A
5284023	Abasolo	5284	A
5284046	Aldama	5284	A
5284069	Altamira	5284	A
5284092	Antigüo Morelos	5284	A
5284115	Burgos	5284	A
5284138	Bustamante	5284	A
5284161	Casas	5284	A
5284184	Cd. Camargo	5284	A
5284207	Cd. Victoria	5284	A
5284230	Cruillas	5284	A
5284253	Díaz Ordáz	5284	A
5284276	Gómez Farías	5284	A
5284299	González	5284	A
5284322	Güémez	5284	A
5284345	Guerrero	5284	A
5284368	Hidalgo	5284	A
5284391	Jaumave	5284	A
5284414	Jiménez	5284	A
5284437	Llera	5284	A
5284460	Madero	5284	A
5284483	Mainero	5284	A
5284506	Mante	5284	A
5284529	Matamoros	5284	A
5284552	Méndez	5284	A
5284575	Mier	5284	A
5284598	Miguel Alemán	5284	A
5284621	Miquihuana	5284	A
5284644	Nuevo Laredo	5284	A
5284667	Nuevo Morelos	5284	A
5284690	Ocampo	5284	A
5284713	Padilla	5284	A
5284736	Palmillas	5284	A
5284759	Reynosa	5284	A
5284782	Río Bravo	5284	A
5284805	San Carlos	5284	A
5284828	San Fernando	5284	A
5284851	San Nicolás	5284	A
5284874	Soto La Marina	5284	A
5284897	Tampico	5284	A
5284920	Tula	5284	A
5284943	Valle Hermoso	5284	A
5284966	Villagrán	5284	A
5284989	Xicoténcatl	5284	A
5284998	Indeterminado	5284	A
5287016	Acuamanala de Miguel Hidalgo	5287	A
5287032	Altzayanca	5287	A
5287048	Amaxac de Guerrero	5287	A
5287064	Apetatitlan de Antonio Carvajal	5287	A
5287080	Apizaco	5287	A
5287096	Atlangatepec	5287	A
5287112	Benito Juárez	5287	A
5287128	Calpulalpan	5287	A
5287144	Chiautempan	5287	A
5287160	Contla de Juan	5287	A
5287176	Cuamatzi	5287	A
5287192	Cuapiaxtla	5287	A
5287208	Cuaxomulco	5287	A
5287224	El Carmen Tequexquitla	5287	A
5287240	Emiliano Zapata,	5287	A
5287256	Españita	5287	A
5287272	Huamantla	5287	A
5287288	Hueyotlipan	5287	A
5287304	Ixtacuixtla de Mariano Matamoros	5287	A
5287320	Ixtenco	5287	A
5287336	La Magdalena Tlaltelulco	5287	A
5287352	Lazaro Cárdenas	5287	A
5287368	Mazatecochco de Jose Maria Morelos	5287	A
5287384	Muñoz de Domingo Arenas	5287	A
5287400	Nanacamilpa de Mariano Arista	5287	A
5287416	Nativitas	5287	A
5287432	Panotla	5287	A
5287448	Papalotla de Xicohtencatl	5287	A
5287464	San Damian Texoloc,	5287	A
5287480	San Francisco Tetlanohcan	5287	A
5287496	San Jerónimo Zacualpan	5287	A
5287512	San Juan Huactzinco	5287	A
5287528	San Lorenzo Axocomanitla	5287	A
5287544	San Lucas Tecopilco	5287	A
5287560	San Pablo del Monte	5287	A
5287576	Sanctorum de Lázaro Cárdenas	5287	A
5287592	Santa Ana Nopalucan	5287	A
5287608	Santa Apolonia Teacalco	5287	A
5287624	Santa Catarina Ayometla	5287	A
5287640	Santa Cruz Quilehtla	5287	A
5287656	Santa Cruz Tlaxcala	5287	A
5287672	Santa Isabel Xiloxoxtla	5287	A
5287688	Tenancingo	5287	A
5287704	Teolocholco	5287	A
5287720	Tepetitla de Lardizabal	5287	A
5287736	Tepeyanco	5287	A
5287752	Terrenate	5287	A
5287768	Tetla de la Solidaridad	5287	A
5287784	Tetlatlahuca	5287	A
5287800	Tlaxcala	5287	A
5287816	Tlaxco	5287	A
5287832	Tocatlán	5287	A
5287848	Totolac	5287	A
5287864	Tzompantepec	5287	A
5287880	Xalostoc	5287	A
5287896	Xaltocan	5287	A
5287912	Xicohtzinco	5287	A
5287928	Yauhquemecan	5287	A
5287944	Zacatelco	5287	A
5287960	Zitlaltepec de Trinidad Sanchez Santos	5287	A
5287998	Indeterminado	5287	A
5290005	Acajete	5290	A
5290010	Acatlán	5290	A
5290015	Acayucán	5290	A
5290020	Actopan	5290	A
5290025	Acula	5290	A
5290030	Acultzingo	5290	A
5290035	Agua Dulce	5290	A
5290040	Alpatlahuac	5290	A
5290045	Alto Lucero	5290	A
5290050	Altotonga	5290	A
5290055	Alvarado	5290	A
5290060	Amatitlán	5290	A
5290065	Amatlán de los Reyes	5290	A
5290070	Angel R.Cabada	5290	A
5290075	Apazapan	5290	A
5290080	Aquila	5290	A
5290085	Astacinga	5290	A
5290090	Atlahuilco Tlaltetela	5290	A
5290095	Atoyac	5290	A
5290100	Atzacan	5290	A
5290105	Atzalan	5290	A
5290110	Ayahualulco	5290	A
5290115	Banderilla	5290	A
5290120	Benito Juárez	5290	A
5290125	Calcahualco	5290	A
5290130	Camarón de Tejeda	5290	A
5290135	Camerino Z. Mendoza	5290	A
5290140	Carlos A. Carrillo	5290	A
5290145	Carrillo Puerto	5290	A
5290150	Castillo de Teayo	5290	A
5290155	Catemaco	5290	A
5290160	Cazones de Herrera	5290	A
5290165	Cerro Azul	5290	A
5290170	Chacaltianguis	5290	A
5290175	Chalma	5290	A
5290180	Chiconamel	5290	A
5290185	Chicontpec	5290	A
5290190	Chinameca	5290	A
5290195	Chinampa de Gorostiza	5290	A
5290200	Chocamán	5290	A
5290205	Chontla	5290	A
5290210	Chumatlán	5290	A
5290215	Coacoatzintla	5290	A
5290220	Coahuitlán	5290	A
5290225	Coatepec	5290	A
5290230	Coatzintla	5290	A
5290235	Coetzala	5290	A
5290240	Colipa	5290	A
5290245	Comapa	5290	A
5290250	Cosamaloapan	5290	A
5290255	Cosautlán de Carvajal	5290	A
5290260	Coscomatepec	5290	A
5290265	Cosoleacaque	5290	A
5290270	Cotaxtla	5290	A
5290275	Coxquihui	5290	A
5290280	Coyutla	5290	A
5290285	Cuichapa	5290	A
5290290	Cuitláhuac	5290	A
5290295	El Higo	5290	A
5290300	Emiliano Zapata	5290	A
5290305	Espinal	5290	A
5290310	Filomeno Mata	5290	A
5290315	Fortín Gutiérrez Zamora	5290	A
5290320	Hidalgotitlán	5290	A
5290325	Huatusco	5290	A
5290330	Huayacocotla	5290	A
5290335	Hueyápan de Ocampo	5290	A
5290340	Huiloapan de Cuauhtémoc	5290	A
5290345	Ignacio de la Llave	5290	A
5290350	Ilamatlán, Isla Ixcatepec	5290	A
5290355	Ixhuacán de los Reyes	5290	A
5290360	Ixhuatlán de Madero	5290	A
5290365	Ixhuatlán del Café	5290	A
5290370	Ixhuatlán del Sureste	5290	A
5290375	Ixhuatlancillo	5290	A
5290380	Ixtaczoquitlán	5290	A
5290385	Jalacingo	5290	A
5290390	Jalcomulco	5290	A
5290395	Jaltipán	5290	A
5290400	Jaltipán	5290	A
5290405	Jamapa	5290	A
5290410	Jesús Carrranza	5290	A
5290415	Jilotepec	5290	A
5290420	José Azueta	5290	A
5290425	Juchique de Ferrer	5290	A
5290430	La Perla	5290	A
5290435	Landero y Coss	5290	A
5290440	Las Choapas	5290	A
5290445	Las Minas	5290	A
5290450	Las Vigas de Ramírez	5290	A
5290455	Lerdo de Tejada, Magdalena	5290	A
5290460	Los Reyes	5290	A
5290465	Maltrata	5290	A
5290470	Manlio Fabio Altamirano	5290	A
5290475	Mariano Escobedo	5290	A
5290480	Martínez de la Torre	5290	A
5290485	Mecatlán	5290	A
5290490	Mecayapán	5290	A
5290495	Medellín	5290	A
5290500	Mihuatlán	5290	A
5290505	Minatitlán	5290	A
5290510	Misantla	5290	A
5290515	Mixtla de Altamirano	5290	A
5290520	Moloacán	5290	A
5290525	Nanchital de Lázaro Cárdenas del Río	5290	A
5290530	Naolinco	5290	A
5290535	Naranjal	5290	A
5290540	Nautla	5290	A
5290545	Nogales	5290	A
5290550	Oluta	5290	A
5290555	Omealca	5290	A
5290560	Otatitlán	5290	A
5290565	Oteapan	5290	A
5290570	Ozulama	5290	A
5290575	Pajapan	5290	A
5290580	Pánuco	5290	A
5290585	Papantla	5290	A
5290590	Paso de las Ovejas	5290	A
5290595	Paso del Macho	5290	A
5290600	Perote	5290	A
5290605	Platón Sánchez	5290	A
5290610	Poza Rica Hidalgo	5290	A
5290615	Pueblo Viejo	5290	A
5290620	Puente Nacional	5290	A
5290625	Rafael Delgado	5290	A
5290630	Rafael Lucio,	5290	A
5290635	Río Blanco	5290	A
5290640	Saltabarranca	5290	A
5290645	San Andrés Tenejepan	5290	A
5290650	San Andrés Tuxtla	5290	A
5290655	San Juan Evangelista	5290	A
5290660	Santiago Tuxtla	5290	A
5290665	Sayula de Alemán	5290	A
5290670	Sochiapa	5290	A
5290675	Soconusco	5290	A
5290680	Soledad Atzompa	5290	A
5290685	Soledad de Doblado	5290	A
5290690	Soteapan	5290	A
5290695	Tamalin	5290	A
5290700	Tamiahua	5290	A
5290705	Tampico Alto	5290	A
5290710	Tancoco	5290	A
5290715	Tantima	5290	A
5290720	Tatahuicapan	5290	A
5290725	Tatatila	5290	A
5290730	Tecolutla	5290	A
5290735	Tehuipango	5290	A
5290740	Temapache	5290	A
5290745	Tempoal	5290	A
5290750	Tenampa	5290	A
5290755	Tenochtitlán	5290	A
5290760	Teocelo	5290	A
5290765	Tepetlán	5290	A
5290770	Tepetzintla, Tequila	5290	A
5290775	Texcatepec	5290	A
5290780	Texhuacán	5290	A
5290785	Texistepec	5290	A
5290790	Tezonapa	5290	A
5290795	Tierra Blanca	5290	A
5290800	Tihuatlán	5290	A
5290805	Tlachichilco	5290	A
5290810	Tlacojalpan	5290	A
5290815	Tlacolulan	5290	A
5290820	Tlacotalpan	5290	A
5290825	Tlacotepec de Mejía	5290	A
5290830	Tlalixcoyan	5290	A
5290835	Tlalnelhuayocán	5290	A
5290840	Tlapacoyan	5290	A
5290845	Tlaquilpan	5290	A
5290850	Tlilapan	5290	A
5290855	Tonayán	5290	A
5290860	Tres Valles	5290	A
5290865	Tuxpam	5290	A
5290870	Tuxtilla	5290	A
5290875	Ursulo Galván	5290	A
5290880	Uxpanapa	5290	A
5290885	Vega de Alatorre	5290	A
5290890	Veracruz	5290	A
5290895	Villa Aldama	5290	A
5290900	Xico	5290	A
5290905	Xoxocotla	5290	A
5290910	Yanga	5290	A
5290915	Yecuatla	5290	A
5290920	Zacualpan	5290	A
5290925	Zaragoza	5290	A
5290930	Zentla	5290	A
5290935	Zongolica	5290	A
5290940	Zontecomatlán	5290	A
5290945	Zozocolco de Hidalgo	5290	A
5290998	Indeterminado	5290	A
5293009	Abala	5293	A
5293018	Acanceh	5293	A
5293027	Akil	5293	A
5293036	Baca	5293	A
5293045	Bokoba	5293	A
5293054	Buctzotz	5293	A
5293063	Cacalchen	5293	A
5293072	Calotmul	5293	A
5293081	Cansahca	5293	A
5293090	Cantamayec	5293	A
5293099	Celestun	5293	A
5293108	Cenotillo	5293	A
5293117	Chacsinkin	5293	A
5293126	Chancom	5293	A
5293135	Chapab	5293	A
5293144	Chemax	5293	A
5293153	Chichimila	5293	A
5293162	Chicxulub Pueblo	5293	A
5293171	Chikindzonot	5293	A
5293180	Chochola	5293	A
5293189	Chumayel	5293	A
5293198	Conkal	5293	A
5293207	Cuncunul	5293	A
5293216	Cuzama	5293	A
5293225	Didzantun	5293	A
5293234	Dzan	5293	A
5293243	Dzemul	5293	A
5293252	Dzilam de Bravo	5293	A
5293261	Dzilam González	5293	A
5293270	Dzitas	5293	A
5293279	Dzoncauich	5293	A
5293288	Espita	5293	A
5293297	Halacho	5293	A
5293306	Hocaba	5293	A
5293315	Hoctun	5293	A
5293324	Homun	5293	A
5293333	Huhi	5293	A
5293342	Hunucma	5293	A
5293351	Ixil	5293	A
5293360	Izamal	5293	A
5293369	Kanasil	5293	A
5293378	Kantunil	5293	A
5293387	Kaua	5293	A
5293396	Kinchil	5293	A
5293405	Kopoma	5293	A
5293414	Mama	5293	A
5293423	Mani	5293	A
5293432	Maxcanu	5293	A
5293441	Mayapan	5293	A
5293450	Mérida	5293	A
5293459	Mococha	5293	A
5293468	Motul	5293	A
5293477	Muna	5293	A
5293486	Muxupip	5293	A
5293495	Opichen	5293	A
5293504	Oxkutzcab	5293	A
5293513	Panaba	5293	A
5293522	Peto	5293	A
5293531	Progreso	5293	A
5293540	Quintana Roo	5293	A
5293549	Río Lagartos	5293	A
5293558	Sacalum	5293	A
5293567	Samahil	5293	A
5293576	San Felipe	5293	A
5293585	Sanahcat	5293	A
5293594	Santa Elena	5293	A
5293603	Seye	5293	A
5293612	Sinanche	5293	A
5293621	Sotuta	5293	A
5293630	Sucila	5293	A
5293639	Sudzal	5293	A
5293648	Suma	5293	A
5293657	Tahdziu	5293	A
5293666	Tahmek	5293	A
5293675	Teabo	5293	A
5293684	Tecoh	5293	A
5293693	Tecom	5293	A
5293702	Tekal de Venegas	5293	A
5293711	Tekanto	5293	A
5293720	Tekax	5293	A
5293729	Tekit	5293	A
5293738	Telchac Pueblo	5293	A
5293747	Telchac Puerto	5293	A
5293756	Temax	5293	A
5293765	Temozón	5293	A
5293774	Tepakán	5293	A
5293783	Tetiz	5293	A
5293792	Teya	5293	A
5293801	Ticul	5293	A
5293810	Timucuy	5293	A
5293819	Tinum	5293	A
5293828	Tixcacalcupul	5293	A
5293837	Tixkokob	5293	A
5293846	Tixmeuac	5293	A
5293855	Tixpeual	5293	A
5293864	Tizimin	5293	A
5293873	Tunkas	5293	A
5293882	Tzucacab	5293	A
5293891	Uayma	5293	A
5293900	Ucu	5293	A
5293909	Uman	5293	A
5293918	Valladolid	5293	A
5293927	Xocchel	5293	A
5293936	Yaxcaba	5293	A
5293945	Yaxkukul	5293	A
5293954	Yobain	5293	A
5293998	Indeterminado	5293	A
5296017	Apozol	5296	A
5296034	Apulco	5296	A
5296051	Atolinga	5296	A
5296068	Benito Juárez	5296	A
5296085	Calera de Víctor Rosales	5296	A
5296102	Concepción del Oro	5296	A
5296119	Cañitas de Felipe Pescador	5296	A
5296136	Cd. Cuauhtémoc	5296	A
5296153	Chalchihuites	5296	A
5296170	El Salvador	5296	A
5296187	Francisco R. Murguía	5296	A
5296204	Fresnillo	5296	A
5296221	García de la Cadena	5296	A
5296238	Genaro Codina	5296	A
5296255	Gral. Joaquín Amaro	5296	A
5296272	Gral. Enrique Estrada	5296	A
5296289	Guadalupe	5296	A
5296306	Huanusco	5296	A
5296323	Jalpa	5296	A
5296340	Jerez de García Salinas	5296	A
5296357	Jiménez del Téul,	5296	A
5296374	Juan Aldama	5296	A
5296391	Gral. Pánfilo Natera	5296	A
5296408	Juchipila	5296	A
5296425	Loreto	5296	A
5296442	Luis Moya	5296	A
5296459	Mazapil	5296	A
5296476	Melchor Ocampo	5296	A
5296493	Mezquital del Oro	5296	A
5296510	Miguel Auza	5296	A
5296527	Momax	5296	A
5296544	Monte Escobedo	5296	A
5296561	Morelos	5296	A
5296578	Moyahua	5296	A
5296595	Nochistlán	5296	A
5296612	Noria de Angeles	5296	A
5296629	Ojocaliente	5296	A
5296646	Pánuco	5296	A
5296663	Pinos	5296	A
5296680	Río Grande	5296	A
5296697	Saín Alto	5296	A
5296714	Sombrerete	5296	A
5296731	Susticacán	5296	A
5296748	Tabasc	5296	A
5296765	Tepechitlán	5296	A
5296782	Tepetongo	5296	A
5296799	Téul de González Ortega	5296	A
5296816	Tlaltenango de Sánchez Román	5296	A
5296833	Valparaíso	5296	A
5296850	Vetagrande	5296	A
5296867	Villa de Cos	5296	A
5296884	Villa García	5296	A
5296901	Villa González Ortega	5296	A
5296918	Villa Hidalgo	5296	A
5296935	Villanueva	5296	A
5296952	Zacatecas	5296	A
5296998	Indeterminado	5296	A
53002998	Indeterminado	53002	A
53004998	Indeterminado	53004	A
53006998	Indeterminado	53006	A
53008998	Indeterminado	53008	A
53010998	Indeterminado	53010	A
53012998	Indeterminado	53012	A
53014998	Indeterminado	53014	A
53016998	Indeterminado	53016	A
53018998	Indeterminado	53018	A
53020998	Indeterminado	53020	A
53022998	Indeterminado	53022	A
53024998	Indeterminado	53024	A
53026998	Indeterminado	53026	A
53028998	Indeterminado	53028	A
53030998	Indeterminado	53030	A
53032998	Indeterminado	53032	A
53002101	Mariel	53002	A
53002102	Guanajay	53002	A
53002103	Caimito	53002	A
53002104	Bauta	53002	A
53002105	San Antonio de los Baños	53002	A
53002106	Güira de Melena	53002	A
53002107	Alquízar	53002	A
53002108	Artemisa	53002	A
53002109	Bahía Honda	53002	A
53002110	Candelaria	53004	A
53002111	San Cristóbal	53004	A
53004101	Camagüey	53004	A
53004102	Guáimaro	53004	A
53004103	Nuevitas	53004	A
53004104	Céspedes	53004	A
53004105	Jimaguayú	53004	A
53004106	Sibanicú	53004	A
53004107	Esmeralda	53004	A
53004108	Minas	53002	A
53004109	Sierra de Cubitas	53006	A
53004110	Florida	53006	A
53004111	Najasa	53006	A
53004112	Vertientes	53006	A
53004113	Santa Cruz del Sur	53006	A
53006101	Baraguá	53006	A
53006102	Bolivia	53006	A
53006103	Chambas	53006	A
53006104	Ciego de Ávila	53006	A
53006105	Ciro Redondo	53006	A
53006106	Florencia	53006	A
53006107	Majagua	53006	A
53006108	Morón	53006	A
53006109	Primero de Enero	53006	A
53006110	Venezuela	53006	A
53008101	Abreus	53008	A
53008102	Aguada de Pasajeros	53008	A
53008103	Cienfuegos	53008	A
53008104	Cruces	53008	A
53008105	Cumanayagua	53008	A
53008106	Lajas	53008	A
53008107	Palmira	53008	A
53008108	Rodas	53008	A
53010101	Bartolomé Masó	53010	A
53010102	Bayamo	53010	A
53010103	Buey Arriba	53010	A
53010104	Campechuela	53010	A
53010105	Cauto Cristo	53010	A
53010106	Guisa	53010	A
53010107	Jiguaní	53010	A
53010108	Manzanillo	53010	A
53010109	Media Luna	53010	A
53010110	Niquero	53010	A
53010111	Pilón	53010	A
53010112	Río Cauto	53010	A
53010113	Yara	53010	A
53012101	Baracoa	53012	A
53012102	Caimanera	53012	A
53012103	El Salvador	53012	A
53012104	Guantánamo	53012	A
53012105	Imías	53012	A
53012106	Maisí	53012	A
53012107	Manuel Tames	53012	A
53012108	Niceto Pérez	53012	A
53012109	San Antonio del Sur	53012	A
53012110	Yateras	53012	A
53014101	Antilla	53014	A
53014102	Báguanos	53014	A
53014103	Banes	53014	A
53014104	Cacocum	53014	A
53014105	Calixto García	53014	A
53014106	Cueto	53014	A
53014107	Frank País	53014	A
53014108	Gibara	53014	A
53014109	Holguín	53014	A
53014110	Mayarí	53014	A
53014111	Moa	53014	A
53014112	Rafael Freyre	53014	A
53014113	Sagua de Tánamo	53014	A
53014114	Urbano Noris	53014	A
53016101	Arroyo Naranjo	53016	A
53016103	Centro Habana	53016	A
53016104	Cerro	53016	A
53016105	Cotorro	53016	A
53016106	Diez de Octubre	53016	A
53016107	Guanabacoa	53016	A
53016108	La Habana del Este	53016	A
53016109	La Habana Vieja	53016	A
53016110	La Lisa	53016	A
53016111	Marianao	53016	A
53016112	Playa	53016	A
53016113	Plaza de la Revolución	53016	A
53016114	Regla	53016	A
53016102	San Miguel del Padrón	53016	A
53018101	Amancio	53018	A
53018102	Colombia	53018	A
53018103	Jesús Menéndez	53018	A
53018104	Jobabo	53018	A
53018105	Las Tunas	53018	A
53018106	Majibacoa	53018	A
53018107	Manatí	53018	A
53018108	Puerto Padre	53018	A
53020101	Calimete	53020	A
53020102	Cárdenas	53020	A
53020103	Ciénaga de Zapata	53020	A
53020104	Colón	53020	A
53020105	Jagüey Grande	53020	A
53020106	Jovellanos	53020	A
53020107	Limonar	53020	A
53020108	Los Arabos	53020	A
53020109	Martí	53020	A
53020110	Matanzas	53020	A
53020111	Pedro Betancourt	53020	A
53020112	Perico	53020	A
53020113	Unión de Reyes	53020	A
53022101	Batabanó	53022	A
53022102	Bejucal	53022	A
53022103	Güines	53022	A
53022104	Jaruco	53022	A
53022105	Madruga	53022	A
53022106	Melena del Sur	53022	A
53022107	Nueva Paz	53022	A
53022108	Quivicán	53022	A
53022109	San José de las Lajas	53022	A
53022110	San Nicolás de Bari	53022	A
53022111	Santa Cruz del Norte	53022	A
53024101	Consolación del Sur	53024	A
53024102	Guane	53024	A
53024103	La Palma	53024	A
53024104	Los Palacios	53024	A
53024105	Mantua	53024	A
53024106	Minas de Matahambre	53024	A
53024107	Pinar del Río	53024	A
53024108	San Juan y Martínez	53024	A
53024109	San Luis	53024	A
53024110	Sandino	53024	A
53024111	Viñales	53024	A
53026101	Cabaiguán	53026	A
53026102	Fomento	53026	A
53026103	Jatibonico	53026	A
53026104	La Sierpe	53026	A
53026105	Sancti Spíritus	53026	A
53026106	Taguasco	53026	A
53026107	Trinidad	53026	A
53026108	Yaguajay	53026	A
53028101	Contramaestre	53028	A
53028102	Guamá	53028	A
53028103	Mella	53028	A
53028104	Palma Soriano	53028	A
53028105	San Luis	53028	A
53028106	Santiago de Cuba	53028	A
53028107	Segundo Frente	53028	A
53028108	Songo-La Maya	53028	A
53028109	Tercer Frente	53028	A
53030101	Caibarién	53030	A
53030102	Camajuaní	53030	A
53030103	Cifuentes	53030	A
53030104	Corralillo	53030	A
53030105	Encrucijada	53030	A
53030106	Manicaragua	53030	A
53030107	Placetas	53030	A
53030108	Quemado de Güines	53030	A
53030109	Ranchuelo	53030	A
53030110	Remedios	53030	A
53030111	Sagua la Grande	53030	A
53030112	Santa Clara	53030	A
53030113	Santo Domingo	53030	A
53032101	Isla de la Juventud	53032	A
5402998	Indeterminado	5402	A
5402000	Ciudad Autónoma de Buenos Aires	5402	A
5406998	Indeterminado	5406	A
5406007	Adolfo Alsina	5406	A
5406014	Adolfo González Chaves	5406	A
5406021	Alberti	5406	A
5406028	Almirante Brown	5406	A
5406035	Avellaneda	5406	A
5406042	Ayacucho	5406	A
5406049	Azul	5406	A
5406056	Bahia Blanca	5406	A
5406063	Balcarce	5406	A
5406070	Baradero	5406	A
5406077	Arrecifes	5406	A
5406084	Benito Juárez	5406	A
5406091	Berazategui	5406	A
5406098	Berisso	5406	A
5406105	Bolívar	5406	A
5406112	Bragado	5406	A
5406119	Brandsen	5406	A
5406126	Campana	5406	A
5406133	Cañuelas	5406	A
5406140	Capitán Sarmiento	5406	A
5406147	Carlos Casares	5406	A
5406154	Carlos Tejedor	5406	A
5406161	Carmen de Areco	5406	A
5406168	Castelli	5406	A
5406175	Colón	5406	A
5406182	Coronel de Marina Leonardo Rosales	5406	A
5406189	Coronel Dorrego	5406	A
5406196	Coronel Pringles	5406	A
5406203	Coronel Suárez	5406	A
5406210	Chacabuco	5406	A
5406217	Chascomús	5406	A
5406224	Chivilcoy	5406	A
5406231	Daireaux	5406	A
5406238	Dolores	5406	A
5406245	Ensenada	5406	A
5406252	Escobar	5406	A
5406259	Esteban Echeverría	5406	A
5406266	Exaltación de la Cruz	5406	A
5406270	Ezeiza	5406	A
5406273	Florencio Varela	5406	A
5406277	Florentino Ameghino	5406	A
5406280	General Alvarado	5406	A
5406287	General Alvear	5406	A
5406294	General Arenales	5406	A
5406301	General Belgrano	5406	A
5406308	General Juan Guido	5406	A
5406315	General Madariaga	5406	A
5406322	General La Madrid	5406	A
5406329	General Las Heras	5406	A
5406336	General Lavalle	5406	A
5406343	General Paz	5406	A
5406351	General Pinto	5406	A
5406357	General Pueyrredón	5406	A
5406364	General Rodríguez	5406	A
5406371	General San Martín	5406	A
5406385	General Viamonte	5406	A
5406392	General Villegas	5406	A
5406399	Guaminí	5406	A
5406406	Hipólito Yrigoyen	5406	A
5406408	Hurlingham	5406	A
5406410	Ituzaingó	5406	A
5406412	José C. Paz	5406	A
5406413	Junín	5406	A
5406420	La Costa	5406	A
5406427	La Matanza	5406	A
5406434	Lanús	5406	A
5406441	La Plata	5406	A
5406448	Laprida	5406	A
5406455	Las Flores	5406	A
5406462	Leandro N. Alem	5406	A
5406469	Lincoln	5406	A
5406476	Lobería	5406	A
5406483	Lobos	5406	A
5406490	Lomas de Zamora	5406	A
5406497	Luján	5406	A
5406504	Magdalena	5406	A
5406511	Maipú	5406	A
5406515	Malvinas Argentinas	5406	A
5406518	Mar Chiquita	5406	A
5406525	Marcos Paz	5406	A
5406532	Mercedes	5406	A
5406539	Merlo	5406	A
5406547	Monte	5406	A
5406553	Monte Hermoso	5406	A
5406560	Moreno	5406	A
5406567	Morón	5406	A
5406574	Navarro	5406	A
5406581	Necochea	5406	A
5406588	9 de Julio	5406	A
5406595	Olavarría	5406	A
5406602	Patagones	5406	A
5406609	Pehuajó	5406	A
5406616	Pellegrini	5406	A
5406623	Pergamino	5406	A
5406630	Pila	5406	A
5406637	Pilar	5406	A
5406644	Pinamar	5406	A
5406648	Presidente Perón	5406	A
5406652	Puán	5406	A
5406655	Punta Indio	5406	A
5406658	Quilmes	5406	A
5406665	Ramallo	5406	A
5406672	Rauch	5406	A
5406679	Rivadavia	5406	A
5406686	Rojas	5406	A
5406693	Roque Pérez	5406	A
5406700	Saavedra	5406	A
5406707	Saladillo	5406	A
5406714	Salto	5406	A
5406721	Salliqueló	5406	A
5406728	San Andrés de Giles	5406	A
5406735	San Antonio de Areco	5406	A
5406742	San Cayetano	5406	A
5406749	San Fernando	5406	A
5406756	San Isidro	5406	A
5406760	San Miguel	5406	A
5406763	San Nicolas	5406	A
5406770	San Pedro	5406	A
5406777	San Vicente	5406	A
5406784	Suipacha	5406	A
5406791	Tandil	5406	A
5406798	Tapalqué	5406	A
5406805	Tigre	5406	A
5406812	Tordillo	5406	A
5406819	Tornquist	5406	A
5406826	Trenque Lauquen	5406	A
5406833	Tres Arroyos	5406	A
5406840	Tres de Febrero	5406	A
5406847	Tres Lomas	5406	A
5406854	25 de Mayo	5406	A
5406861	Vicente López	5406	A
5406868	Villa Gesell	5406	A
5406875	Villarino	5406	A
5406882	Zárate	5406	A
5406466	Lezama	5406	A
5410998	Indeterminado	5410	A
5410007	Ambato	5410	A
5410014	Ancasti	5410	A
5410021	Andalgalá	5410	A
5410035	Belén	5410	A
5410042	Capayán	5410	A
5410049	Capital	5410	A
5410056	El Alto	5410	A
5410063	Fray Mamerto Esquiú	5410	A
5410070	La Paz	5410	A
5410077	Paclín	5410	A
5410084	Pomán	5410	A
5410091	Santa María	5410	A
5410098	Santa Rosa	5410	A
5410105	Tinogasta	5410	A
5410112	Valle Viejo	5410	A
5410028	Antofagasta de la Sierra	5410	A
5414998	Indeterminado	5414	A
5414007	Calamuchita	5414	A
5414014	Capital	5414	A
5414021	Colón	5414	A
5414028	Cruz del Eje	5414	A
5414035	General Roca	5414	A
5414042	General San Martín	5414	A
5414049	Ischilín	5414	A
5414056	Juárez Celman	5414	A
5414063	Marcos Juárez	5414	A
5414070	Minas	5414	A
5414077	Pocho	5414	A
5414084	Presidente Roque Sáenz Peña	5414	A
5414091	Punilla	5414	A
5414098	Río Cuarto	5414	A
5414105	Río Primero	5414	A
5414112	Río Seco	5414	A
5414119	Río Segundo	5414	A
5414126	San Alberto	5414	A
5414133	San Javier	5414	A
5414140	San Justo	5414	A
5414147	Santa María	5414	A
5414154	Sobremonte	5414	A
5414161	Tercero Arriba	5414	A
5414168	Totoral	5414	A
5414175	Tulumba	5414	A
5414182	Unión	5414	A
5418998	Indeterminado	5418	A
5418007	Bella Vista	5418	A
5418014	Berón de Astrada	5418	A
5418021	Capital	5418	A
5418028	Concepción	5418	A
5418035	Curuzú Cuatiá	5418	A
5418042	Empedrado	5418	A
5418049	Esquina	5418	A
5418056	General Alvear	5418	A
5418063	General Paz	5418	A
5418070	Goya	5418	A
5418077	Itatí	5418	A
5418084	Ituzaingó	5418	A
5418091	Lavalle	5418	A
5418098	Mburucuyá	5418	A
5418105	Mercedes	5418	A
5418112	Monte Caseros	5418	A
5418119	Paso de los Libres	5418	A
5418126	Saladas	5418	A
5418133	San Cosme	5418	A
5418140	San Luis del Palmar	5418	A
5418147	San Martín	5418	A
5418154	San Miguel	5418	A
5418161	San Roque	5418	A
5418168	Santo Tomé	5418	A
5418175	Sauce	5418	A
5422998	Indeterminado	5422	A
5422007	Almirante Brown	5422	A
5422014	Bermejo	5422	A
5422021	Comandante Fernández	5422	A
5422028	Chacabuco	5422	A
5422035	12 de Octubre	5422	A
5422039	2 de Abril	5422	A
5422042	Fray Justo Santa María de Oro	5422	A
5422049	General Belgrano	5422	A
5422056	General Donovan	5422	A
5422063	General Güemes	5422	A
5422070	Independencia	5422	A
5422077	Libertad	5422	A
5422084	Libertador General San Martín	5422	A
5422091	Maipú	5422	A
5422098	Mayor Luis J.Fontana	5422	A
5422105	9 de Julio	5422	A
5422112	O' Higgins	5422	A
5422119	Presidencia de la Plaza	5422	A
5422126	1º de Mayo	5422	A
5422133	Quitilipi	5422	A
5422140	San Fernando	5422	A
5422147	San Lorenzo	5422	A
5422154	Sargento Cabral	5422	A
5422161	Tapenagá	5422	A
5422168	25 de Mayo	5422	A
5426998	Indeterminado	5426	A
5426007	Biedma	5426	A
5426014	Cushamen	5426	A
5426021	Escalante	5426	A
5426028	Florentino Ameghino	5426	A
5426035	Futaleufú	5426	A
5426042	Gaiman	5426	A
5426049	Gastre	5426	A
5426056	Languiñeo	5426	A
5426063	Mártires	5426	A
5426070	Paso de Indios	5426	A
5426077	Rawson	5426	A
5426084	Río Senguer	5426	A
5426091	Sarmiento	5426	A
5426098	Techuelches	5426	A
5426105	Telsen	5426	A
5430998	Indeterminado	5430	A
5430007	Colón	5430	A
5430014	Concordia	5430	A
5430021	Diamante	5430	A
5430028	Federación	5430	A
5430035	Federal	5430	A
5430042	Feliciano	5430	A
5430049	Gualeguay	5430	A
5430056	Gualeguaychú	5430	A
5430063	Islas del Ibicuy	5430	A
5430070	La Paz	5430	A
5430077	Nogoyá	5430	A
5430084	Paraná	5430	A
5430088	San Salvador	5430	A
5430091	Tala	5430	A
5430098	Uruguay	5430	A
5430105	Victoria	5430	A
5430112	Villaguay	5430	A
5434998	Indeterminado	5434	A
5434007	Bermejo	5434	A
5434014	Formosa	5434	A
5434021	Laishi	5434	A
5434028	Matacos	5434	A
5434035	Patiño	5434	A
5434042	Pilagás	5434	A
5434049	Pilcomayo	5434	A
5434056	Pirané	5434	A
5434063	Ramón Lista	5434	A
5438998	Indeterminado	5438	A
5438007	Cochinoca	5438	A
5438014	El Carmen	5438	A
5438021	Doctor Manuel Belgrano	5438	A
5438028	Humahuaca	5438	A
5438035	Ledesma	5438	A
5438042	Palpalá	5438	A
5438049	Rinconada	5438	A
5438056	San Antonio	5438	A
5438063	San Pedro	5438	A
5438070	Santa Bárbara	5438	A
5438077	Santa Catalina	5438	A
5438084	Susques	5438	A
5438094	Tilcara	5438	A
5438098	Tumbaya	5438	A
5438105	Valle Grande	5438	A
5438112	Yaví	5438	A
5442998	Indeterminado	5442	A
5442007	Atreucó	5442	A
5442014	Caleu Caleu	5442	A
5442021	Capital	5442	A
5442028	Catriló	5442	A
5442035	Conhelo	5442	A
5442042	Curacó	5442	A
5442049	Chalileo	5442	A
5442056	Chapaleufú	5442	A
5442063	Chical Co	5442	A
5442070	Guatraché	5442	A
5442077	Hucal	5442	A
5442084	Lihuel Calel	5442	A
5442091	Limay Mahuida	5442	A
5442098	Loventué	5442	A
5442105	Maracó	5442	A
5442112	Puelén	5442	A
5442119	Quemú Quemú	5442	A
5442126	Rancul	5442	A
5442133	Realicó	5442	A
5442140	Toay	5442	A
5442147	Trenel	5442	A
5442154	Utracán	5442	A
5446998	Indeterminado	5446	A
5446007	Arauco	5446	A
5446014	Capital	5446	A
5446021	Castro Barros	5446	A
5446028	Coronel Felipe Varela	5446	A
5446035	Chamical	5446	A
5446042	Chilecito	5446	A
5446049	Famatina	5446	A
5446056	General Angel Vicente Peñaloza	5446	A
5446063	General Belgrano	5446	A
5446070	Gral. Juan F. Quiroga	5446	A
5446077	General Lamadrid	5446	A
5446084	General Ocampo	5446	A
5446091	General San Martín	5446	A
5446098	Vinchina	5446	A
5446105	Independencia	5446	A
5446112	Rosario Vera Peñaloza	5446	A
5446119	San Blas de los Sauces	5446	A
5446126	Sanagasta	5446	A
5450998	Indeterminado	5450	A
5450007	Capital	5450	A
5450014	General Alvear	5450	A
5450021	Godoy Cruz	5450	A
5450028	Guaymallén	5450	A
5450035	Junín	5450	A
5450042	La Paz	5450	A
5450049	Las Heras	5450	A
5450056	Lavalle	5450	A
5450063	Luján de Cuyo	5450	A
5450070	Maipú	5450	A
5450077	Malargüe	5450	A
5450084	Rivadavia	5450	A
5450091	San Carlos	5450	A
5450098	San Martín	5450	A
5450105	San Rafael	5450	A
5450112	Santa Rosa	5450	A
5450119	Tunuyán	5450	A
5450126	Tupungato	5450	A
5454998	Indeterminado	5454	A
5454007	Apóstoles	5454	A
5454014	Cainguás	5454	A
5454021	Candelaria	5454	A
5454028	Capital	5454	A
5454035	Concepción	5454	A
5454042	Eldorado	5454	A
5454049	General Manuel Belgrano	5454	A
5454056	Guaraní	5454	A
5454063	Iguazú	5454	A
5454070	Leandro N. Alem	5454	A
5454077	Libertador General San Martín	5454	A
5454084	Montecarlo	5454	A
5454091	Oberá	5454	A
5454098	San Ignacio	5454	A
5454105	San Javier	5454	A
5454112	San Pedro	5454	A
5454119	25 de Mayo	5454	A
5458998	Indeterminado	5458	A
5458007	Aluminé	5458	A
5458014	Añelo	5458	A
5458021	Catán Lil	5458	A
5458028	Collón Cura	5458	A
5458035	Confluencia	5458	A
5458042	Chos Malal	5458	A
5458049	Huiliches	5458	A
5458056	Lácar	5458	A
5458063	Loncopué	5458	A
5458070	Los Lagos	5458	A
5458077	Minas	5458	A
5458084	Ñorquin	5458	A
5458091	Pehuenches	5458	A
5458098	Picún Leufú	5458	A
5458105	Picunches	5458	A
5458112	Zapala	5458	A
5462998	Indeterminado	5462	A
5462007	Adolfo Alsina	5462	A
5462014	Avellaneda	5462	A
5462021	Bariloche	5462	A
5462028	Conesa	5462	A
5462035	El Cuy	5462	A
5462042	General Roca	5462	A
5462049	9 de Julio	5462	A
5462056	Ñorquinco	5462	A
5462063	Pichi Mahuida	5462	A
5462070	Pilcaniyeu	5462	A
5462077	San Antonio	5462	A
5462084	Valcheta	5462	A
5462091	25 de Mayo	5462	A
5466998	Indeterminado	5466	A
5466007	Anta	5466	A
5466014	Cachi	5466	A
5466021	Cafayate	5466	A
5466028	Capital	5466	A
5466035	Cerrillos	5466	A
5466042	Chicoana	5466	A
5466049	General Güemes	5466	A
5466056	General José de San Martín	5466	A
5466063	Guachipas	5466	A
5466070	Iruya	5466	A
5466077	La Caldera	5466	A
5466084	La Candelaria	5466	A
5466091	La Poma	5466	A
5466098	La Viña	5466	A
5466105	Los Andes	5466	A
5466112	Metán	5466	A
5466119	Molinos	5466	A
5466126	Orán	5466	A
5466133	Rivadavia	5466	A
5466140	Rosario de la Frontera	5466	A
5466147	Rosario de Lerma	5466	A
5466154	San Carlos	5466	A
5466161	Santa Victoria	5466	A
5470998	Indeterminado	5470	A
5470007	Albardón	5470	A
5470014	Angaco	5470	A
5470021	Calingasta	5470	A
5470028	Capital	5470	A
5470035	Caucete	5470	A
5470042	Chimbas	5470	A
5470049	Iglesia	5470	A
5470056	Jáchal	5470	A
5470063	9 de Julio	5470	A
5470070	Pocito	5470	A
5470077	Rawson	5470	A
5470084	Rivadavia	5470	A
5470091	San Martín	5470	A
5470098	Santa Lucía	5470	A
5470105	Sarmiento	5470	A
5470112	Ullum	5470	A
5470119	Valle Fértil	5470	A
5470126	25 de Mayo	5470	A
5470133	Zonda	5470	A
5474998	Indeterminado	5474	A
5474007	Ayacucho	5474	A
5474014	Belgrano	5474	A
5474021	Coronel Pringles	5474	A
5474028	Chacabuco	5474	A
5474035	General Pedernera	5474	A
5474042	Gobernador Dupuy	5474	A
5474049	Junín	5474	A
5474056	La Capital	5474	A
5474063	Libertador General San Martín	5474	A
5478998	Indeterminado	5478	A
5478007	Corpen Aike	5478	A
5478014	Deseado	5478	A
5478021	Güer Aike	5478	A
5478028	Lago Argentino	5478	A
5478035	Lago Buenos Aires	5478	A
5478042	Magallanes	5478	A
5478049	Río Chico	5478	A
5482998	Indeterminado	5482	A
5482007	Belgrano	5482	A
5482014	Caseros	5482	A
5482021	Castellanos	5482	A
5482028	Constitución	5482	A
5482035	Garay	5482	A
5482042	General López	5482	A
5482049	General Obligado	5482	A
5482056	Iriondo	5482	A
5482063	La Capital	5482	A
5482070	Las Colonias	5482	A
5482077	9 de Julio	5482	A
5482084	Rosario	5482	A
5482091	San Cristóbal	5482	A
5482098	San Javier	5482	A
5482105	San Jerónimo	5482	A
5482112	San Justo	5482	A
5482119	San Lorenzo	5482	A
5482126	San Martín	5482	A
5482133	Vera	5482	A
5486998	Indeterminado	5486	A
5486007	Aguirre	5486	A
5486014	Alberdi	5486	A
5486021	Atamisqui	5486	A
5486028	Avellaneda	5486	A
5486035	Banda	5486	A
5486042	Belgrano	5486	A
5486049	Capital	5486	A
5486056	Copo	5486	A
5486063	Choya	5486	A
5486070	Figeroa	5486	A
5486077	General Taboada	5486	A
5486084	Guasayán	5486	A
5486091	Jiménez	5486	A
5486098	Juan F. Ibarra	5486	A
5486105	Loreto	5486	A
5486112	Mitre	5486	A
5486119	Moreno	5486	A
5486126	Ojo de Agua	5486	A
5486133	Pellegrini	5486	A
5486140	Quebrachos	5486	A
5486147	Río Hondo	5486	A
5486154	Rivadavia	5486	A
5486161	Robles	5486	A
5486168	Salavina	5486	A
5486175	San Martín	5486	A
5486182	Sarmiento	5486	A
5486189	Silípica	5486	A
5490998	Indeterminado	5490	A
5490007	Burruyacú	5490	A
5490014	Cruz Alta	5490	A
5490021	Chicligasta	5490	A
5490028	Famaillá	5490	A
5490035	Graneros	5490	A
5490042	Juan B. Alberdi	5490	A
5490049	La Cocha	5490	A
5490056	Leales	5490	A
5490063	Lules	5490	A
5490070	Monteros	5490	A
5490077	Río Chico	5490	A
5490084	Capital	5490	A
5490091	Simoca	5490	A
5490098	Tafí del Valle	5490	A
5490105	Tafí Viejo	5490	A
5490112	Trancas	5490	A
5490119	Yerba Buena	5490	A
5494998	Indeterminado	5494	A
5494007	Río Grande	5494	A
5494014	Ushuaia	5494	A
5494021	Islas del Atlántico Sur	5494	A
5494028	Antártida Argentina	5494	A
5503998	Indeterminado	5503	A
5506998	Indeterminado	5506	A
5509998	Indeterminado	5509	A
5512998	Indeterminado	5512	A
5515998	Indeterminado	5515	A
5518998	Indeterminado	5518	A
5521998	Indeterminado	5521	A
5524998	Indeterminado	5524	A
5527998	Indeterminado	5527	A
5530998	Indeterminado	5530	A
5533998	Indeterminado	5533	A
5536998	Indeterminado	5536	A
5539998	Indeterminado	5539	A
5542998	Indeterminado	5542	A
5545998	Indeterminado	5545	A
5548998	Indeterminado	5548	A
5551998	Indeterminado	5551	A
5554998	Indeterminado	5554	A
5557998	Indeterminado	5557	A
5560998	Indeterminado	5560	A
5563998	Indeterminado	5563	A
5566998	Indeterminado	5566	A
5569998	Indeterminado	5569	A
5572998	Indeterminado	5572	A
5575998	Indeterminado	5575	A
5578998	Indeterminado	5578	A
5581998	Indeterminado	5581	A
5625998	Indeterminado	5625	A
5653998	Indeterminado	5653	A
5607249	AISEN	5607	A
5607498	CAPITAN PRAT	5607	A
5607747	COIHAIQUE	5607	A
5607996	GENERAL CARRERA	5607	A
5607998	Indeterminado	5607	A
5614300	ANTOFAGASTA	5614	A
5614600	EL LOA	5614	A
5614900	TOCOPILLA	5614	A
5614998	Indeterminado	5614	A
5621200	CAUTIN	5621	A
5621700	MALLECO	5621	A
5621998	Indeterminado	5621	A
5628300	CHAÑARAL	5628	A
5628600	COPIAPO	5628	A
5628900	HUASCO	5628	A
5628998	Indeterminado	5628	A
5635249	ARAUCO	5635	A
5635498	BIOBIO	5635	A
5635747	CONCEPCION	5635	A
5635996	ÑUBLE	5635	A
5635998	Indeterminado	5635	A
5642300	CHOAPA	5642	A
5642600	ELQUI	5642	A
5642900	LIMARI	5642	A
5642998	Indeterminado	5642	A
5649300	CACHAPOAL	5649	A
5649600	CARDENAL CARO	5649	A
5649900	COLCHAGUA	5649	A
5649998	Indeterminado	5649	A
5656199	CHILOE	5656	A
5656398	LLANQUIHUE	5656	A
5656597	OSORNO	5656	A
5656796	PALENA	5656	A
5656998	Indeterminado	5656	A
5663249	ANTARTICA CHILENA	5663	A
5663498	MAGALLANES	5663	A
5663747	TIERRA DEL FUEGO	5663	A
5663996	ULTIMA ESPERANZA	5663	A
5663998	Indeterminado	5663	A
5670249	CAUQUENES	5670	A
5670498	CURICO	5670	A
5670747	LINARES	5670	A
5670996	TALCA	5670	A
5670998	Indeterminado	5670	A
5677166	CHACABUCO	5677	A
5677332	CORDILLERA	5677	A
5677498	MAIPO	5677	A
5677664	MELIPILLA	5677	A
5677830	SANTIAGO	5677	A
5677996	TALAGANTE	5677	A
5677998	Indeterminado	5677	A
5684600	IQUIQUE	5684	A
5684998	Indeterminado	5684	A
5691142	ISLA DE PASCUA	5691	A
5691284	LOS ANDES	5691	A
5691426	PETORCA	5691	A
5691568	QUILLOTA	5691	A
5691710	SAN ANTONIO	5691	A
5691852	SAN FELIPE DE ACONCAGUA	5691	A
5691994	VALPARAISO	5691	A
5691998	Indeterminado	5691	A
5656995	VALDIVIA	5653	A
5656996	RANCO	5653	A
5684300	ARICA	5625	A
5684900	PARINACOTA	5625	A
5684800	TAMARUGAL	5684	A
5691300	MARGA MARGA	5691	A
5703998	Indeterminado	5703	A
5706998	Indeterminado	5706	A
5709998	Indeterminado	5709	A
5712998	Indeterminado	5712	A
5716998	Indeterminado	5716	A
5719998	Indeterminado	5719	A
5722998	Indeterminado	5722	A
5725998	Indeterminado	5725	A
5728998	Indeterminado	5728	A
5732998	Indeterminado	5732	A
5735998	Indeterminado	5735	A
5738998	Indeterminado	5738	A
5741998	Indeterminado	5741	A
5744998	Indeterminado	5744	A
5748998	Indeterminado	5748	A
5751998	Indeterminado	5751	A
5752998	Indeterminado	5752	A
5754998	Indeterminado	5754	A
5757998	Indeterminado	5757	A
5760998	Indeterminado	5760	A
5764998	Indeterminado	5764	A
5767998	Indeterminado	5767	A
5770998	Indeterminado	5770	A
5773998	Indeterminado	5773	A
5776998	Indeterminado	5776	A
5780998	Indeterminado	5780	A
5783998	Indeterminado	5783	A
5786998	Indeterminado	5786	A
5789998	Indeterminado	5789	A
5792998	Indeterminado	5792	A
5796998	Indeterminado	5796	A
5797998	Indeterminado	5797	A
5799998	Indeterminado	5799	A
5706001	Bajo Cauca	5706	A
5706002	Magdalena Medio	5706	A
5706003	Nordeste	5706	A
5706004	Norte	5706	A
5706005	Occidente	5706	A
5706006	Oriente	5706	A
5706007	Suroeste	5706	A
5706008	Urabá	5706	A
5706009	Valle de Aburrá	5706	A
5722001	Centro (Boyacá)	5722	A
5722002	Gutiérrez	5722	A
5722003	La Libertad	5722	A
5722004	Lengupá	5722	A
5722005	Márquez	5722	A
5722006	Neira	5722	A
5722007	Norte	5722	A
5722008	Occidente	5722	A
5722009	Oriente	5722	A
5722010	Ricaurte	5722	A
5722011	Sugamuxi	5722	A
5722012	Tundama	5722	A
5722013	Valderrama	5722	A
5722014	Zona de Manejo Especial de Boyacá	5722	A
5722015	Distrito Fronterizo	5722	A
5725001	Alto Occidente	5725	A
5725002	Alto Oriente	5725	A
5725003	Bajo Occidente	5725	A
5725004	Centrosur	5725	A
5725005	Magdalena Caldense	5725	A
5725006	Norte	5725	A
5735001	Oriente	5735	A
5735002	Occidente	5735	A
5735003	Sur	5735	A
5735004	Centro	5735	A
5735005	Norte	5735	A
5741001	Acandí	5741	A
5741002	Alto Baudó	5741	A
5741003	Atrato	5741	A
5741004	Bagadó	5741	A
5741005	Bahía Solano	5741	A
5741006	Bajo Baudó	5741	A
5741007	Bojayá	5741	A
5741008	El Cantón del San Pablo	5741	A
5741009	Carmen del Darién	5741	A
5741010	Cértegui	5741	A
5741011	Condoto	5741	A
5741012	El Carmen de Atrato	5741	A
5741013	El Litoral del San Juan	5741	A
5741014	Istmina	5741	A
5741015	Juradó	5741	A
5741016	Lloró	5741	A
5741017	Medio Atrato	5741	A
5741018	Medio Baudó	5741	A
5741019	Medio San Juan	5741	A
5741020	Nóvita	5741	A
5741021	Nuquí	5741	A
5741022	Río Iró	5741	A
5741023	Río Quito	5741	A
5741024	Riosucio	5741	A
5741025	San José del Palmar	5741	A
5741026	Sipí	5741	A
5741027	Tadó	5741	A
5741028	Unguía	5741	A
5741029	Unión Panamericana	5741	A
5748001	Almeidas	5748	A
5748002	Alto Magdalena	5748	A
5748003	Bajo Magdalena 	5748	A
5748004	Gualivá	5748	A
5748005	Guavio	5748	A
5748006	Magdalena Centro	5748	A
5748007	Medina	5748	A
5748008	Oriente	5748	A
5748009	Rionegro	5748	A
5748010	Sabana Centro	5748	A
5748011	Sabana Occidente	5748	A
5748012	Soacha	5748	A
5748013	Sumapaz	5748	A
5748014	Tequendama	5748	A
5748015	Ubaté	5748	A
57540001	Subnorte	5754	A
57540002	Subcentro	5754	A
57540003	Suboccidente	5754	A
57540004	Subsur	5754	A
57570001	Norte	5757	A
57570002	Sur (Padilla)	5757	A
57640001	Ariari	5764	A
57640002	Capital	5764	A
57640003	Piedemonte	5764	A
57640004	Río Meta	5764	A
57670001	Tumaco-Barbacoas	5767	A
57670002	Obando	5767	A
57670003	La Unión	5767	A
57670004	Pasto	5767	A
57670005	Túquerres	5767	A
57700001	Centro	5770	A
57700002	Norte	5770	A
57700003	Occidente	5770	A
57700004	Oriente	5770	A
57700005	Sur-occidente	5770	A
57700006	Sur-oriente	5770	A
57860001	Comunera	5786	A
57860002	Garcia Rovira	5786	A
57860003	Guanentá	5786	A
57860004	Mares	5786	A
57860005	Soto	5786	A
57860006	Vélez	5786	A
57890001	La Mojana	5789	A
57890002	Montes de María	5789	A
57890003	Morrosquillo	5789	A
57890004	Sabanas	5789	A
57890005	San Jorge	5789	A
57920001	Ibagué	5792	A
57920002	Nevados	5792	A
57920003	Norte	5792	A
57920004	Oriente	5792	A
57920005	Sur	5792	A
57920006	Suroriente	5792	A
57960001	Centro	5796	A
57960002	Norte	5796	A
57960003	Occidente	5796	A
57960004	Oriente	5796	A
57960005	Sur	5796	A
5803998	Indeterminado	5803	A
5806998	Indeterminado	5806	A
5809998	Indeterminado	5809	A
5812998	Indeterminado	5812	A
5815998	Indeterminado	5815	A
5818998	Indeterminado	5818	A
5821998	Indeterminado	5821	A
5824998	Indeterminado	5824	A
5827998	Indeterminado	5827	A
5830998	Indeterminado	5830	A
5833998	Indeterminado	5833	A
5836998	Indeterminado	5836	A
5839998	Indeterminado	5839	A
5842998	Indeterminado	5842	A
5845998	Indeterminado	5845	A
5848998	Indeterminado	5848	A
5851998	Indeterminado	5851	A
5854998	Indeterminado	5854	A
5857998	Indeterminado	5857	A
5860998	Indeterminado	5860	A
5863998	Indeterminado	5863	A
5866998	Indeterminado	5866	A
5869998	Indeterminado	5869	A
5872998	Indeterminado	5872	A
5875998	Indeterminado	5875	A
5803004	ALTO ORINOCO	5803	A
5803008	ATABAPO	5803	A
5803012	ATURES	5803	A
5803016	AUTANA	5803	A
5803020	MANAPIARE	5803	A
5803024	MAROA	5803	A
5803028	RIO NEGRO	5803	A
5806004	ANACO	5806	A
5806008	ARAGUA	5806	A
5806012	SIMON BOLIVAR	5806	A
5806016	BRUZUAL	5806	A
5806020	CAJIGAL	5806	A
5806024	CARVAJAL	5806	A
5806028	DIEGO B. URBANETA	5806	A
5806032	FREITES	5806	A
5806036	GUANIPA	5806	A
5806040	GUANTA	5806	A
5806044	INDEPENDENCIA	5806	A
5806048	LIBERTAD	5806	A
5806052	MC GREGOR	5806	A
5806056	MIRANDA	5806	A
5806060	MONAGAS	5806	A
5806064	PEÑALVER	5806	A
5806068	PIRITU	5806	A
5806072	SAN JUAN DE CAPISTRANO	5806	A
5806076	SANTA ANA	5806	A
5806080	SIMON RODRIGUEZ	5806	A
5806084	SOTILLO	5806	A
5809004	ACHAGUAS	5809	A
5809008	BIRUACA	5809	A
5809012	MUÑOZ	5809	A
5809016	PAEZ	5809	A
5809020	PEDRO CAMEJO	5809	A
5809024	ROMULO GALLEGOS	5809	A
5809028	SOTILLO	5809	A
5812004	BOLIVAR	5812	A
5812008	CAMATAGUA	5812	A
5812012	FRANCISCO LINARES	5812	A
5812016	GIRARDOT	5812	A
5812020	JOSE ANGEL LAMAS	5812	A
5812024	JOSE FELIX RIBAS	5812	A
5812028	JOSE RAFAEL REVENGA	5812	A
5812035	LIBERTADOR	5812	A
5812036	MARIO BRICEÑO IRRIGORRY	5812	A
5812040	OCUMARE DE LA COSTA DE ORO	5812	A
5812044	SAN CASIMIRO	5812	A
5812048	SAN SEBASTIAN	5812	A
5812052	SANTIAGO MARIÑO	5812	A
5812056	SANTOS MICHELENA	5812	A
5812060	SUCRE	5812	A
5812064	TOVAR	5812	A
5812068	URDANETA	5812	A
5812072	ZAMORA	5812	A
5815004	ALBERTO ARVELO TORREALBA	5815	A
5815008	ANDRES ELOY BLANCO	5815	A
5815012	SUCRE	5815	A
5815016	ARISMENDI	5815	A
5815020	BARINAS	5815	A
5815024	BOLIVAR	5815	A
5815028	CRUZ PAREDES	5815	A
5815032	EZEQUIEL ZAMORA	5815	A
5815036	OBISPOS	5815	A
5815040	PEDRAZA	5815	A
5815044	ROJAS	5815	A
5815048	SOSA	5815	A
5818004	CARONI	5818	A
5818008	CEDEÑO	5818	A
5818012	EL CALLAO	5818	A
5818016	GRAN SABANA	5818	A
5818020	HERES	5818	A
5818024	PIAR	5818	A
5818028	ANGOSTURA	5818	A
5818032	ROSCIO	5818	A
5818036	SIFONTES	5818	A
5818040	SUCRE	5818	A
5818044	PADRE PEDRO CHIEN	5818	A
5821004	BEJUMA	5821	A
5821008	CARLOS ARVELO	5821	A
5821012	DIEGO IBARRA	5821	A
5821016	GUACARA	5821	A
5821020	JUAN JOSE MORA	5821	A
5821024	LIBERTADOR	5821	A
5821028	LOS GUAYOS	5821	A
5821032	MIRANDA	5821	A
5821036	MONTALBAN	5821	A
5821040	NAGUANAGUA	5821	A
5821044	PUERTO CABELLO	5821	A
5821048	SAN DIEGO	5821	A
5821052	SAN JOAQUIN	5821	A
5821056	VALENCIA	5821	A
5824004	ANZOATEGUI	5824	A
5824008	FALCON	5824	A
5824012	GIRARDOT	5824	A
5824014	EZEQUIEL ZAMORA	5824	A
5824020	LIMA BLANCO	5824	A
5824024	PAO DE SAN JUAN BAUTISTA	5824	A
5824028	RICAURTE	5824	A
5824032	ROMULO GALLEGOS	5824	A
5824036	TINACO	5824	A
5827004	ANTONIO DIAZ	5827	A
5827008	CASACOIMA	5827	A
5827012	PEDERNALES	5827	A
5827014	TUCUPITA	5827	A
5833001	LIBERTADOR	5833	A
5836004	ACOSTA	5836	A
5836008	BOLIVAR	5836	A
5836012	BUCHIVACOA	5836	A
5836016	CACIQUE MANAURE	5836	A
5836020	CARIBUBANA	5836	A
5836024	COLINA	5836	A
5836028	DABAJURO	5836	A
5836032	DEMOCRACIA	5836	A
5836036	FALCON	5836	A
5836040	FEDERACION	5836	A
5836044	JACURA	5836	A
5836048	LOS TAQUES	5836	A
5836052	MAUROA	5836	A
5836056	MIRANDA	5836	A
5836060	MONSEÑOR ITURRIZA	5836	A
5836064	PALMASOLA	5836	A
5836068	PETIT	5836	A
5836072	PIRITU	5836	A
5836076	SAN FRANCISCO	5836	A
5836080	SILVA	5836	A
5836084	SUCRE	5836	A
5836088	TOCOPERO	5836	A
5836092	UNION	5836	A
5836096	URUMACO	5836	A
5836100	ZAMORA	5836	A
5839004	CAMAGUAN	5839	A
5839008	CHAGUARAMAS	5839	A
5839012	JUAN GERMAN ROSCIO	5839	A
5839016	FRANCISCO DE MIRANDA	5839	A
5839020	JOSE FELIX RIBAS	5839	A
5839024	JOSE TADEO MONAGAS	5839	A
5839028	JUAN GERMAN ROSCIO	5839	A
5839032	JULIAN MELLADO	5839	A
5839036	LAS MERCEDES	5839	A
5839040	LEONARDO INFANTE	5839	A
5839044	PEDRO DE ZARAZA	5839	A
5839048	ORTIZ	5839	A
5839052	SAN JERONIMO DE GUAYABAL	5839	A
5839056	SAN JOSE DE GUARIBE	5839	A
5839060	SANTA MARIA DE IPIRE	5839	A
5842004	ANDRES E. BLANCO	5842	A
5842008	CRESPO	5842	A
5842012	IRIBARREN	5842	A
5842016	JIMENEZ	5842	A
5842020	MORAN	5842	A
5842024	PALAVECINO	5842	A
5842028	SIMON PLANAS	5842	A
5842032	TORRES	5842	A
5842036	URDANETA	5842	A
5845004	ALBERTO ADRIANI	5845	A
5845008	ANDRES BELLO	5845	A
5845012	ANTONIO PINTO SALINAS	5845	A
5845016	ARICAGUA	5845	A
5845020	ARZOBISCPO CHACON	5845	A
5845024	CAMPO ELIAS	5845	A
5845028	CARACCIOLO PARRA OLMEDO	5845	A
5845032	CARDENAL QUINTERO	5845	A
5845036	GUARAQUE	5845	A
5845040	JULIO C. SALAS	5845	A
5845044	JUSTO BRICEÑO	5845	A
5845048	LIBERTADOR	5845	A
5845052	MIRANDA	5845	A
5845056	OBISPO RAMOS DE LORA	5845	A
5845060	PADRE NOGUERA	5845	A
5845064	PUEBLO LLANO	5845	A
5845068	RANGEL	5845	A
5845072	RIVAS DAVILA	5845	A
5845076	SANTOS MARQUINA	5845	A
5845080	SUCRE	5845	A
5845084	TOVAR	5845	A
5845088	TULIO FEBRES CORDERO	5845	A
5845092	ZEA	5845	A
5848004	ACEVEDO	5848	A
5848008	ANDRES BELLO	5848	A
5848012	BARUTA	5848	A
5848016	BRION	5848	A
5848020	BUROZ	5848	A
5848024	CARRIZAL	5848	A
5848028	CHACAO	5848	A
5848032	CRISTOBAL ROJAS	5848	A
5848036	EL HATILLO	5848	A
5848040	GUAICAIPURO	5848	A
5848044	INDEPENDENCIA	5848	A
5848048	LANDER	5848	A
5848052	LOS SALIAS	5848	A
5848056	PAEZ	5848	A
5848060	PAZ CASTILLO	5848	A
5848064	PEDRO GUAL	5848	A
5848072	PLAZA	5848	A
5848076	SIMON BOLIVAR	5848	A
5848096	SUCRE	5848	A
5848100	URDANETA	5848	A
5848104	ZAMORA	5848	A
5851004	ACOSTA	5851	A
5851008	AGUASAY	5851	A
5851012	BOLIVAR	5851	A
5851016	CARIPE	5851	A
5851020	CEDEÑO	5851	A
5851024	EZEQUIEL ZAMORA	5851	A
5851028	LIBERTADOR	5851	A
5851032	MATURIN	5851	A
5851036	PIAR	5851	A
5851040	PUNCERES	5851	A
5851044	SANTA BARBARA	5851	A
5851048	SOTILLO	5851	A
5851052	URACOA	5851	A
5854001	ANTOLIN DEL CAMPO	5854	A
5854003	ARISMENDI	5854	A
5854005	DIAZ	5854	A
5854007	SANTIAGO MARIÑO	5854	A
5854011	GARCIA	5854	A
5854015	GOMEZ	5854	A
5854019	MANEIRO	5854	A
5854023	MARCANO	5854	A
5854025	PENINSULA DE MACANAO	5854	A
5854027	TUBORES	5854	A
5854031	VILLALBA	5854	A
5854048	JAUREGUI	5854	A
5857004	AGUA BLANCA	5857	A
5857008	ARAURE	5857	A
5857012	ESTELLER	5857	A
5857016	GUANARE	5857	A
5857020	GUANARITO	5857	A
5857024	MONSEÑOR JOSE V. DE UNDA	5857	A
5857028	OSPINO	5857	A
5857032	PAEZ	5857	A
5857036	PAPELON	5857	A
5857040	SAN GENRANO DE BOCONOITO	5857	A
5857044	SAN RAFAEL DE ONOTO	5857	A
5857048	SANTA ROSALIA	5857	A
5857052	SUCRE	5857	A
5857056	TUREN	5857	A
5860004	ANDRES ELOY BLANCO	5860	A
5860008	ANDRES MATA	5860	A
5860012	ARISMENDI	5860	A
5860016	BENITEZ	5860	A
5860020	BERMUDEZ	5860	A
5860024	BOLIVAR	5860	A
5860028	CAJIGAL	5860	A
5860032	CRUZ SALMERON ACOSTA	5860	A
5860036	LIBERTADOR	5860	A
5860040	MARIÑO	5860	A
5860044	MEJIA	5860	A
5860048	MONTES	5860	A
5860052	RIBERO	5860	A
5860056	SAN CRISTOBAL	5860	A
5860060	VALDEZ	5860	A
5863004	ANDRES BELLO	5863	A
5863008	ANTONIO R. COSTA	5863	A
5863012	AYACUHO	5863	A
5863016	BOLIVAR	5863	A
5863020	CARDENAS	5863	A
5863024	CORDOBA	5863	A
5863028	FERNADEZ FEO	5863	A
5863032	FRANCISCO DE MIRANDA	5863	A
5863036	GARCIA DE HEVIA	5863	A
5863040	GUASIMOS	5863	A
5863044	INDEPENDENCIA	5863	A
5863048	JAUREGUI	5863	A
5863052	JOSE MA. VARGAS	5863	A
5863056	JUNIN	5863	A
5863060	LIBERTAD	5863	A
5863064	LIBERTADOR	5863	A
5863068	LOBATERA	5863	A
5863072	MICHELENA	5863	A
5863076	PANAMERICANO	5863	A
5863080	PEDRO MA. UREÑA	5863	A
5863084	RAFAEL URDANETA	5863	A
5863088	SAMUEL D. MALDONADO	5863	A
5863092	SAN CRISTOBAL	5863	A
5863096	SEROBUCO	5863	A
5863100	SIMON RODRIGUEZ	5863	A
5863104	SUCRE	5863	A
5863108	TORBES	5863	A
5863112	URIBANTE	5863	A
5863116	SAN JUDAS TADEO	5863	A
5866004	ANDRES BELLO	5866	A
5866008	BOCONO	5866	A
5866012	BOLIVAR	5866	A
5866016	CANDELARIA	5866	A
5866020	CARACHE	5866	A
5866024	ESCUQUE	5866	A
5866028	JOSE F. MARQUEZ CAÑIZARES	5866	A
5866032	JUAN V. CAMPOS ELIAS	5866	A
5866036	LA CEIBA	5866	A
5866040	MIRANDA	5866	A
5866044	MONTE CARMELO	5866	A
5866048	MOTANTAN	5866	A
5866052	PAMPAN	5866	A
5866056	PAMPANITO	5866	A
5866060	RAFAEL RANGEL	5866	A
5866064	SAN RAFAEL DE CARVAJAL	5866	A
5866068	SUCRE	5866	A
5866072	URDANETA	5866	A
5866092	TRUJILLO	5866	A
5866100	VALERA	5866	A
5869001	VARGAS	5869	A
5872001	SAN FELIPE	5872	A
5872004	ARISTIDES BASTIAS	5872	A
5872008	BOLIVAR	5872	A
5872012	BRUZUAL	5872	A
5872016	COCOROTE	5872	A
5872020	INDEPENDENCIA	5872	A
5872024	JOSE ANTONIO PAEZ	5872	A
5872028	LA TRINIDAD	5872	A
5872032	MANUEL MONGE	5872	A
5872036	NIRGUA	5872	A
5872040	PEÑA	5872	A
5872048	SUCRE	5872	A
5872052	URACHICHE	5872	A
5872056	VEROES	5872	A
5875004	ALMIRANTE PADILLA	5875	A
5875008	BARALT	5875	A
5875012	CABIMAS	5875	A
5875016	CATATUMBO	5875	A
5875020	COLON	5875	A
5875024	FRANCISCO JAVIER PULGAR	5875	A
5875028	JESUS E. LOSADA	5875	A
5875032	JESUS MA. SEMPRUN	5875	A
5875036	LA CAÑADA DE URDANETA	5875	A
5875040	LAGUNILLAS	5875	A
5875044	MACHIQUES DE PERIJA	5875	A
5875048	MARA	5875	A
5875052	MARACAIBO	5875	A
5875056	MIRANDA	5875	A
5875060	PAEZ	5875	A
5875064	ROSARIO DE PERIJA	5875	A
5875068	SAN FRANCISCO	5875	A
5875072	SANTA RITA	5875	A
5875076	SIMON BOLIVAR	5875	A
5875080	SUCRE	5875	A
5875084	VALMORE RODRIGUEZ	5875	A
6405998	Indeterminado	6405	A
6410998	Indeterminado	6410	A
6415998	Indeterminado	6415	A
6420998	Indeterminado	6420	A
6425998	Indeterminado	6425	A
6430998	Indeterminado	6430	A
6435998	Indeterminado	6435	A
6440998	Indeterminado	6440	A
6445998	Indeterminado	6445	A
6450998	Indeterminado	6450	A
6455998	Indeterminado	6455	A
6460998	Indeterminado	6460	A
6465998	Indeterminado	6465	A
6470998	Indeterminado	6470	A
6475998	Indeterminado	6475	A
6480998	Indeterminado	6480	A
6485998	Indeterminado	6485	A
8102998	Indeterminado	8102	A
8104998	Indeterminado	8104	A
8106998	Indeterminado	8106	A
8108998	Indeterminado	8108	A
8110998	Indeterminado	8110	A
8112998	Indeterminado	8112	A
8114998	Indeterminado	8114	A
8116998	Indeterminado	8116	A
8118998	Indeterminado	8118	A
8120998	Indeterminado	8120	A
8122998	Indeterminado	8122	A
8124998	Indeterminado	8124	A
8126998	Indeterminado	8126	A
8128998	Indeterminado	8128	A
8130998	Indeterminado	8130	A
8132998	Indeterminado	8132	A
8134998	Indeterminado	8134	A
8136998	Indeterminado	8136	A
8138998	Indeterminado	8138	A
8140998	Indeterminado	8140	A
8142998	Indeterminado	8142	A
8144998	Indeterminado	8144	A
8146998	Indeterminado	8146	A
8148998	Indeterminado	8148	A
8150998	Indeterminado	8150	A
8152998	Indeterminado	8152	A
8154998	Indeterminado	8154	A
8156998	Indeterminado	8156	A
8158998	Indeterminado	8158	A
8160998	Indeterminado	8160	A
8162998	Indeterminado	8162	A
8164998	Indeterminado	8164	A
8166998	Indeterminado	8166	A
8168998	Indeterminado	8168	A
8170998	Indeterminado	8170	A
8172998	Indeterminado	8172	A
8174998	Indeterminado	8174	A
8176998	Indeterminado	8176	A
8178998	Indeterminado	8178	A
8180998	Indeterminado	8180	A
8182998	Indeterminado	8182	A
8184998	Indeterminado	8184	A
8186998	Indeterminado	8186	A
8188998	Indeterminado	8188	A
8190998	Indeterminado	8190	A
8192998	Indeterminado	8192	A
8194998	Indeterminado	8194	A
8102021	Aichi	8102	A
8102042	Aisai	8102	A
8102063	Ama	8102	A
8102084	Anjo	8102	A
8102105	Atsumi	8102	A
8102126	Bisai	8102	A
8102147	Chiryu	8102	A
8102168	Chita	8102	A
8102189	Gamagori	8102	A
8102210	Haguri	8102	A
8102231	Handa	8102	A
8102252	Hazu	8102	A
8102273	Hekinan	8102	A
8102294	Higashikamo	8102	A
8102315	Hoi	8102	A
8102336	Ichinomiya	8102	A
8102357	Inazawa	8102	A
8102378	Inuyama	8102	A
8102399	Iwakura	8102	A
8102420	Kariya	8102	A
8102441	Kasugai	8102	A
8102462	Kitashitara	8102	A
8102483	Komaki	8102	A
8102504	Konan	8102	A
8102525	Minamishitara	8102	A
8102546	Nagoya	8102	A
8102567	Nakashima	8102	A
8102588	Nishikamo	8102	A
8102609	Nishikasugai	8102	A
8102630	Nishio	8102	A
8102651	Nisshin	8102	A
8102672	Niwa	8102	A
8102693	Nukata	8102	A
8102714	Obu	8102	A
8102735	Okazaki	8102	A
8102756	Owariasahi	8102	A
8102777	Seto	8102	A
8102798	Shinshiro	8102	A
8102819	Tahara	8102	A
8102840	Takahama	8102	A
8102861	Tokoname	8102	A
8102882	Toukai	8102	A
8102903	Toyoake	8102	A
8102924	Toyohashi	8102	A
8102945	Toyokawa	8102	A
8102966	Toyota	8102	A
8102987	Tsushima	8102	A
8104055	Akita	8104	A
8104110	Daisen	8104	A
8104165	Hiraka	8104	A
8104220	Honjo	8104	A
8104275	Kaduno	8104	A
8104330	Kawabe	8104	A
8104385	Kazuno	8104	A
8104440	Kitaakita	8104	A
8104495	Minamiakita	8104	A
8104550	Noshiro	8104	A
8104605	Odate	8104	A
8104660	Oga	8104	A
8104715	Ogachi	8104	A
8104770	Senboku	8104	A
8104825	Yamamoto	8104	A
8104880	Yokote	8104	A
8104935	Yuri	8104	A
8104990	Yuzawa	8104	A
8106062	Aomori	8106	A
8106124	Goshogawara	8106	A
8106186	Hachinohe	8106	A
8106248	Higashitsugaru	8106	A
8106310	Hirosaki	8106	A
8106372	Kamikita	8106	A
8106434	Kitatsugaru	8106	A
8106496	Kuroishi	8106	A
8106558	Minamitsugaru	8106	A
8106620	Misawa	8106	A
8106682	Mutsu	8106	A
8106744	Nakatsugaru	8106	A
8106806	Nishitsugaru	8106	A
8106868	Sannohe	8106	A
8106930	Shimokita	8106	A
8106992	Towada	8106	A
8108023	Abiko	8106	A
8108046	Asahi	8106	A
8108069	Awa	8106	A
8108092	Chiba	8106	A
8108115	Chosei	8106	A
8108138	Choshi	8106	A
8108161	Funabashi	8106	A
8108184	Futtsu	8106	A
8108207	Higashikatsushika	8106	A
8108230	Ichihara	8106	A
8108253	Ichikawa	8106	A
8108276	Inba	8106	A
8108299	Inzai	8106	A
8108322	Isumi	8106	A
8108345	Kaijo	8106	A
8108368	Kamagaya	8106	A
8108391	Kamogawa	8106	A
8108414	Kashiwa	8106	A
8108437	Katori	8106	A
8108460	Katsuura	8106	A
8108483	Kimitsu	8106	A
8108506	Kisarazu	8106	A
8108529	Matsudo	8106	A
8108552	Mobara	8106	A
8108575	Nagareyama	8106	A
8108598	Narashino	8106	A
8108621	Narita	8106	A
8108644	Noda	8106	A
8108667	Sakura	8106	A
8108690	Sanbu	8106	A
8108713	Sawara	8106	A
8108736	Shiroi	8106	A
8108759	Sodegaura	8106	A
8108782	Sosa	8106	A
8108805	Tateyama	8106	A
8108828	Togane	8106	A
8108851	Tomisato	8106	A
8108874	Urayasu	8106	A
8108897	Yachimata	8106	A
8108920	Yachiyo	8106	A
8108943	Yokaichiba	8106	A
8108966	Yotsukaido	8106	A
8110043	Higashiuwa	8110	A
8110086	Hojo	8110	A
8110129	Imabari	8110	A
8110215	Iyo	8110	A
8110258	Iyomishima	8110	A
8110301	Kamiukena	8110	A
8110344	Kawanoe	8110	A
8110387	Kita	8110	A
8110430	Kitauwa	8110	A
8110473	Matsuyama	8110	A
8110516	Minamiuwa	8110	A
8110559	Niihama	8110	A
8110602	Nishiuwa	8110	A
8110645	Ochi	8110	A
8110688	Onsen	8110	A
8110731	Oozu	8110	A
8110774	Saijo	8110	A
8110817	Shuso	8110	A
8110860	Toyo	8110	A
8110903	Uma	8110	A
8110946	Uwajima	8110	A
8110989	Yawatahama	8110	A
8112062	Awara	8112	A
8112124	Echizen	8112	A
8112186	Fukui	8112	A
8112248	Imadate	8112	A
8112310	Katsuyama	8112	A
8112372	Mikata	8112	A
8112434	Mikatakaminaka	8112	A
8112558	Nanjo	8112	A
8112620	Obama	8112	A
8112682	Oi	8112	A
8112744	Ono	8112	A
8112806	Sabae	8112	A
8112868	Sakai	8112	A
8112930	Tsuruga	8112	A
8112992	Yoshida	8112	A
8114024	Amagi	8114	A
8114048	Asakura	8114	A
8114072	Buzen	8114	A
8114096	Chikugo	8114	A
8114120	Chikujo	8114	A
8114144	Chikushi	8114	A
8114168	Chikushino	8114	A
8114192	Dazaifu	8114	A
8114216	Fukuoka	8114	A
8114240	Iizuka	8114	A
8114264	Itoshima	8114	A
8114288	Kaho	8114	A
8114312	Kasuga	8114	A
8114360	Kitakyushu	8114	A
8114384	Koga	8114	A
8114408	Kurate	8114	A
8114432	Kurume	8114	A
8114456	Maebaru	8114	A
8114480	Mii	8114	A
8114504	Miike	8114	A
8114528	Miyako	8114	A
8114552	Mizuma	8114	A
8114600	Munakata	8114	A
8114624	Nakama	8114	A
8114648	Nogata	8114	A
8114672	Ogori	8114	A
8114696	Okawa	8114	A
8114720	Omuta	8114	A
8114744	Onga	8114	A
8114768	Onojo	8114	A
8114792	Tagawa	8114	A
8114840	Ukiha	8114	A
8114864	Yamada	8114	A
8114888	Yamato	8114	A
8114912	Yame	8114	A
8114960	Yanagawa	8114	A
8114984	Yukuhashi	8114	A
8116043	Adachi	8116	A
8116086	Aizuwakamatsu	8116	A
8116129	Date	8116	A
8116172	Fukushima	8116	A
8116215	Futaba	8116	A
8116258	Haramachi	8116	A
8116301	Higashishirakawa	8116	A
8116344	Ishikawa	8116	A
8116387	Iwaki	8116	A
8116430	Iwase	8116	A
8116473	Kawanuma	8116	A
8116516	Kitaaizu	8116	A
8116559	Kitakata	8116	A
8116602	Koriyama	8116	A
8116645	Minamiaizu	8116	A
8116688	Nihonmatsu	8116	A
8116731	Nishishirakawa	8116	A
8116774	Onuma	8116	A
8116817	Shirakawa	8116	A
8116860	Soma	8116	A
8116903	Sukagawa	8116	A
8116946	Tamura	8116	A
8116989	Yama	8116	A
8118035	Anpachi	8118	A
8118070	Ena	8118	A
8118105	Fuwa	8118	A
8118140	Gifu	8118	A
8118175	Gujou	8118	A
8118210	Hashima	8118	A
8118245	Ibi	8118	A
8118280	Kaidu	8118	A
8118315	Kakamigahara	8118	A
8118350	Kamo	8118	A
8118385	Kani	8118	A
8118420	Mashita	8118	A
8118455	Mino	8118	A
8118490	Minokamo	8118	A
8118525	Mizuho	8118	A
8118560	Mizunami	8118	A
8118595	Motosu	8118	A
8118630	Mugi	8118	A
8118665	Nakatsugawa	8118	A
8118700	Ogaki	8118	A
8118735	Oono	8118	A
8118770	Seki	8118	A
8118805	Tajimi	8118	A
8118840	Takayama	8118	A
8118875	Toki	8118	A
8118910	Yamagata	8118	A
8118945	Yoshiki	8118	A
8118980	Yourou	8118	A
8120083	Annaka	8120	A
8120166	Fujioka	8120	A
8120249	Haruna	8120	A
8120332	Isesaki	8120	A
8120415	Kiryu	8120	A
8120498	Maebashi	8120	A
8120581	Numata	8120	A
8120664	Ota	8120	A
8120747	Shibukawa	8120	A
8120830	Takasaki	8120	A
8120913	Tatebayashi	8120	A
8120996	Tomioka	8120	A
8122036	Aki	8122	A
8122072	Fuchu	8122	A
8122108	Fukayasu	8122	A
8122144	Fukuyama	8122	A
8122180	Futami	8122	A
8122216	Hatsukaichi	8122	A
8122252	Hiba	8122	A
8122288	Higashihiroshima	8122	A
8122324	Hiroshima	8122	A
8122360	Innoshima	8122	A
8122396	Jinseki	8122	A
8122432	Kamo	8122	A
8122468	Konu	8122	A
8122504	Kure	8122	A
8122540	Mihara	8122	A
8122576	Mitsugi	8122	A
8122612	Miyoshi	8122	A
8122648	Numakuma	8122	A
8122684	Onomichi	8122	A
8122720	Otake	8122	A
8122756	Saeki	8122	A
8122792	Sera	8122	A
8122828	Shobara	8122	A
8122864	Takata	8122	A
8122900	Takehara	8122	A
8122936	Toyota	8122	A
8122972	Yamagata	8122	A
8124049	Abashiri	8124	A
8124098	Akanko	8124	A
8124147	Asahikawa	8124	A
8124196	Biei	8124	A
8124245	Furano	8124	A
8124294	Hakodate	8124	A
8124343	Jozankei	8124	A
8124392	Kushiro	8124	A
8124441	Kussharoko	8124	A
8124490	Mashuko	8124	A
8124539	Noboribetsu	8124	A
8124588	Obihiro	8124	A
8124637	Otaru	8124	A
8124686	Sapporo	8124	A
8124735	Shikotsuko	8124	A
8124784	Shiretoko	8124	A
8124833	Sounkyo	8124	A
8124882	Tokachigawa	8124	A
8124931	Touyako	8124	A
8124980	Wakkanai	8124	A
8126025	Aioi	8126	A
8126050	Akashi	8126	A
8126075	Ako	8126	A
8126100	Amagasaki	8126	A
8126125	Asagó	8126	A
8126150	Ashiya	8126	A
8126175	Auadyi	8126	A
8126200	Himeji	8126	A
8126225	Ibo	8126	A
8126250	Itami	8126	A
8126275	Kako	8126	A
8126300	Kakogawa	8126	A
8126325	Kansaki	8126	A
8126350	Kasai	8126	A
8126375	Kato	8126	A
8126400	Kawabe	8126	A
8126425	Kawanishi	8126	A
8126450	Kobe	8126	A
8126475	Mikata	8126	A
8126500	Miki	8126	A
8126525	Minami-Auadyi	8126	A
8126550	Nishinomiya	8126	A
8126575	Nishiwaki	8126	A
8126600	Ono	8126	A
8126625	Sanda	8126	A
8126650	Sasayama	8126	A
8126675	Sayo	8126	A
8126700	Shikama	8126	A
8126725	Shiso	8126	A
8126750	Siso	8126	A
8126775	Sumoto	8126	A
8126800	Taka	8126	A
8126825	Takarazuka	8126	A
8126850	Takasago	8126	A
8126875	Tamba	8126	A
8126900	Tatsuno	8126	A
8126925	Toyooka	8126	A
8126950	Tsuna	8126	A
8126975	Yabu	8126	A
8128027	Bando	8128	A
8128054	Chikusei	8128	A
8128081	Higashiibaraki	8128	A
8128108	Hiotachi-omiya	8128	A
8128135	Hitachi	8128	A
8128162	Hitachinaka	8128	A
8128189	Hitachiota	8128	A
8128216	Hokota	8128	A
8128243	Inashiki	8128	A
8128270	Ishioaka	8128	A
8128297	Itako	8128	A
8128324	Joso	8128	A
8128351	Kamisu	8128	A
8128378	Kasama	8128	A
8128405	Kashima	8128	A
8128432	Kasumigaura	8128	A
8128459	Kitaibaraki	8128	A
8128486	Kitasouma	8128	A
8128513	Koga	8128	A
8128540	Kuji	8128	A
8128567	Mito	8128	A
8128594	Moriya	8128	A
8128621	Naka	8128	A
8128648	Namegata	8128	A
8128675	Omitama	8128	A
8128702	Ryugasaki	8128	A
8128729	Sakuragawa	8128	A
8128756	Sashima	8128	A
8128783	Shimotsuma	8128	A
8128810	Takahagi	8128	A
8128837	Toride	8128	A
8128864	Tsuchiura	8128	A
8128891	Tsukuba	8128	A
8128918	Tsukubamirai	8128	A
8128945	Ushiku	8128	A
8128972	Yuki	8128	A
8130071	Enuma	8130	A
8130142	Fugeshi	8130	A
8130213	Hakui	8130	A
8130284	Ishikawa	8130	A
8130355	Kaga	8130	A
8130426	Kahoku	8130	A
8130497	Kanazawa	8130	A
8130568	Kashima	8130	A
8130639	Komatsu	8130	A
8130710	Matto	8130	A
8130781	Nanao	8130	A
8130852	Nomi	8130	A
8130923	Suzu	8130	A
8130994	Wajima	8130	A
8132039	Esashi	8132	A
8132078	Hanamaki	8132	A
8132117	Hienuki	8132	A
8132156	Higashiiwai	8132	A
8132195	Ichinoseki	8132	A
8132234	Isawa	8132	A
8132273	Iwate	8132	A
8132312	Kamaishi	8132	A
8132351	Kamihei	8132	A
8132390	Kesen	8132	A
8132429	Kitakami	8132	A
8132468	Kuji	8132	A
8132507	Kunohe	8132	A
8132546	Miyako	8132	A
8132585	Mizusawa	8132	A
8132624	Morioka	8132	A
8132663	Ninohe	8132	A
8132702	Ninohe	8132	A
8132741	Nishiiwai	8132	A
8132780	Ofunato	8132	A
8132819	Rikuzentakata	8132	A
8132858	Shimohei	8132	A
8132897	Shiwa	8132	A
8132936	Tono	8132	A
8132975	Waga	8132	A
8134076	Ayauta	8134	A
8134152	Higashikagawa	8134	A
8134228	Kagawa	8134	A
8134304	Kanonji	8134	A
8134380	Kita	8134	A
8134456	Marugame	8134	A
8134532	Mitoyo	8134	A
8134608	Nakatado	8134	A
8134684	Sakaide	8134	A
8134760	Sanuki	8134	A
8134836	Shouzu	8134	A
8134912	Takamatsu	8134	A
8134988	Zentsuji	8134	A
8136043	Aira	8136	A
8136086	Akune	8136	A
8136129	Hioki	8136	A
8136172	Ibusuki	8136	A
8136215	Isa	8136	A
8136258	Izumi	8136	A
8136301	Kagoshima	8136	A
8136344	Kanoya	8136	A
8136387	Kaseda	8136	A
8136430	Kawanabe	8136	A
8136473	Kimotsuki	8136	A
8136516	Kokubu	8136	A
8136559	Kumage	8136	A
8136602	Kushikino	8136	A
8136645	Makurazaki	8136	A
8136688	Naze	8136	A
8136731	Nishinoomote	8136	A
8136774	Okuchi	8136	A
8136817	Oshima	8136	A
8136860	Satsuma	8136	A
8136903	Sendai	8136	A
8136946	Soo	8136	A
8136989	Tarumizu	8136	A
8138052	Atsugi	8138	A
8138104	Ayase	8138	A
8138156	Chigasaki	8138	A
8138208	Ebina	8138	A
8138260	Fujisawa	8138	A
8138312	Hadano	8138	A
8138364	Hiratsuka	8138	A
8138416	Isehara	8138	A
8138468	Kamakura	8138	A
8138520	Kawasaki	8138	A
8138572	Minamiashigara	8138	A
8138624	Miura	8138	A
8138676	Odawara	8138	A
8138728	Sagamihara	8138	A
8138780	Yamato	8138	A
8138832	Yokohama	8138	A
8138884	Yokosuka	8138	A
8138936	Zama	8138	A
8138988	Zushi	8138	A
8140066	Agawa	8140	A
8140122	Aki	8140	A
8140178	Hata	8140	A
8140234	Kami	8140	A
8140290	Kochi	8140	A
8140346	Muroto	8140	A
8140402	Nagaoka	8140	A
8140458	Nakamura	8140	A
8140514	Nankoku	8140	A
8140570	Sukumo	8140	A
8140626	Susaki	8140	A
8140682	Takaoka	8140	A
8140738	Tosa	8140	A
8140850	Tosashimizu	8140	A
8142055	Amakusa	8142	A
8142110	Arao	8142	A
8142165	Ashikita	8142	A
8142220	Aso	8142	A
8142275	Hitoyoshi	8142	A
8142330	Hondo	8142	A
8142385	Kamimashiki	8142	A
8142440	Kamoto	8142	A
8142495	Kikuchi	8142	A
8142550	Kuma	8142	A
8142605	Kumamoto	8142	A
8142660	Minamata	8142	A
8142715	Shimomashiki	8142	A
8142770	Tamana	8142	A
8142825	Ushibuka	8142	A
8142880	Uto	8142	A
8142935	Yamaga	8142	A
8142990	Yatsushiro	8142	A
8144041	Amata	8144	A
8144082	Ayabe	8144	A
8144123	Fukuchiyama	8144	A
8144164	Funai	8144	A
8144205	Joyo	8144	A
8144246	Kameoka	8144	A
8144287	Kasa	8144	A
8144328	Kitakuwada	8144	A
8144369	Kumano	8144	A
8144410	Kuse	8144	A
8144451	Kyotanabe	8144	A
8144492	Kyoto	8144	A
8144533	Maizuru	8144	A
8144574	Miyazu	8144	A
8144615	Muko	8144	A
8144656	Nagaokakyo	8144	A
8144697	Naka	8144	A
8144738	Otokuni	8144	A
8144779	Soraku	8144	A
8144820	Takeno	8144	A
8144861	Tsuzuki	8144	A
8144902	Uji	8144	A
8144943	Yawata	8144	A
8144984	Yosa	8144	A
8146039	Age	8146	A
8146078	Ayama	8146	A
8146117	Hisai	8146	A
8146156	Ichishi	8146	A
8146195	Iinan	8146	A
8146234	Inabe	8146	A
8146273	Ise	8146	A
8146312	Kameyama	8146	A
8146351	Kitamuro	8146	A
8146390	Kumano	8146	A
8146429	Kuwana	8146	A
8146468	Matsusaka	8146	A
8146507	Mie	8146	A
8146546	Minamimuro	8146	A
8146585	Nabari	8146	A
8146624	Naga	8146	A
8146663	Owase	8146	A
8146702	Shima	8146	A
8146741	Suzuka	8146	A
8146780	Taki	8146	A
8146819	Toba	8146	A
8146858	Tsu	8146	A
8146897	Ueno	8146	A
8146936	Watarai	8146	A
8146975	Yokkaichi	8146	A
8148043	Higashimatsushima	8148	A
8148086	Igu	8148	A
8148129	Ishinomaki	8148	A
8148172	Iwanuma	8148	A
8148215	Kakuda	8148	A
8148258	Kami	8148	A
8148301	Katta	8148	A
8148344	Kesennuma	8148	A
8148387	Kurihara	8148	A
8148430	Kurokawa	8148	A
8148473	Miyagi	8148	A
8148516	Motoyoshi	8148	A
8148559	Natori	8148	A
8148602	Osaki	8148	A
8148645	Oshika	8148	A
8148688	Sendai	8148	A
8148731	Shibata	8148	A
8148774	Shiogama	8148	A
8148817	Shiroishi	8148	A
8148860	Tagajo	8148	A
8148903	Toda	8148	A
8148946	Tome	8148	A
8148989	Watari	8148	A
8150062	Ebino	8150	A
8150124	Higashimorokata	8150	A
8150186	Higashiusuki	8150	A
8150248	Hyuga	8150	A
8150310	Kitamorokata	8150	A
8150372	Kobayashi	8150	A
8150434	Koyu	8150	A
8150496	Kushima	8150	A
8150558	Minaminaka	8150	A
8150620	Miyakonojo	8150	A
8150682	Miyazaki	8150	A
8150744	Nichinan	8150	A
8150806	Nishimorokata	8150	A
8150868	Nishiusuki	8150	A
8150930	Nobeoka	8150	A
8150992	Saito	8150	A
8152031	Chiisagata	8152	A
8152062	Chikuma	8152	A
8152093	Chino	8152	A
8152124	Hanishina	8152	A
8152155	Higashichikuma	8152	A
8152186	Iida	8152	A
8152217	Iiyama	8152	A
8152248	Ina	8152	A
8152279	Kamiina	8152	A
8152310	Kamiminochi	8152	A
8152341	Kamitakai	8152	A
8152372	Kiso	8152	A
8152403	Kitaadumi	8152	A
8152434	Kitasaku	8152	A
8152465	Komagane	8152	A
8152496	Komoro	8152	A
8152527	Matsumoto	8152	A
8152558	Minamiadumi	8152	A
8152589	Minamisaku	8152	A
8152620	Nagano	8152	A
8152651	Nakano	8152	A
8152682	Okaya	8152	A
8152713	Omachi	8152	A
8152744	Saku	8152	A
8152775	Sarashina	8152	A
8152806	Shimoina	8152	A
8152837	Shimominochi	8152	A
8152868	Shimotakai	8152	A
8152899	Shiojiri	8152	A
8152930	Suwa	8152	A
8152961	Suzaka	8152	A
8152992	Ueda	8152	A
8154052	Goto	8154	A
8154104	Higashisonogi	8154	A
8154156	Hirado	8154	A
8154208	Iki	8154	A
8154260	Isahaya	8154	A
8154312	Kitamatsuura	8154	A
8154364	Kitatakaki	8154	A
8154416	Matsuura	8154	A
8154468	Minamimatsuura	8154	A
8154520	Minamishimabara	8154	A
8154572	Minamitakaki	8154	A
8154624	Nagasaki	8154	A
8154676	Nishisonogi	8154	A
8154728	Omura	8154	A
8154780	Saikai	8154	A
8154832	Sasebo	8154	A
8154884	Shimabara	8154	A
8154936	Tsushima	8154	A
8154988	Unzen	8154	A
8156055	Gojo	8156	A
8156110	Gose	8156	A
8156165	Ikoma	8156	A
8156220	Kashiba	8156	A
8156275	Kashihara	8156	A
8156330	Katsuragi	8156	A
8156385	Kitakatsuragi	8156	A
8156440	Nara	8156	A
8156495	Sakurai	8156	A
8156550	Shiki	8156	A
8156605	Takaichi	8156	A
8156660	Tenri	8156	A
8156770	Uda	8156	A
8156825	Yamabe	8156	A
8156880	Yamatokoriyama	8156	A
8156935	Yamatotakada	8156	A
8156990	Yoshino	8156	A
8158055	Gosen	8158	A
8158110	Itoigawa	8158	A
8158165	Joetsu	8158	A
8158220	Kamo	8158	A
8158275	Kashiwazaki	8158	A
8158330	Minamiuonuma	8158	A
8158385	Mitsuke	8158	A
8158440	Murakami	8158	A
8158495	Myokho (Arai)	8158	A
8158550	Nagaoka	8158	A
8158605	Niigata	8158	A
8158660	Ojiya	8158	A
8158715	Sado	8158	A
8158770	Sanjo	8158	A
8158825	Shibata	8158	A
8158880	Tokamachi	8158	A
8158935	Tsubame	8158	A
8158990	Uonuma	8158	A
8160090	Beppu	8160	A
8160180	Bungotakada	8160	A
8160270	Hita	8160	A
8160360	Kitsuki	8160	A
8160450	Nakatsu	8160	A
8160540	Oita	8160	A
8160630	Saiki	8160	A
8160720	Taketa	8160	A
8160810	Tsukumi	8160	A
8160900	Usa	8160	A
8160990	Usuki	8160	A
8162035	Aida	8162	A
8162070	Akaiwa	8162	A
8162105	Asakuchi	8162	A
8162140	Atetsu	8162	A
8162175	Bizen	8162	A
8162210	Ibara	8162	A
8162245	Joubou	8162	A
8162280	Kasaoka	8162	A
8162315	Katsuta	8162	A
8162350	Kawakami	8162	A
8162385	Kibi	8162	A
8162420	Kojima	8162	A
8162455	Kume	8162	A
8162490	Kurashiki	8162	A
8162525	Maniwa	8162	A
8162560	Mitsu	8162	A
8162595	Niimi	8162	A
8162630	Oda	8162	A
8162665	Okayama	8162	A
8162700	Oku	8162	A
8162735	Shitsuki	8162	A
8162770	Soja	8162	A
8162805	Takahashi	8162	A
8162840	Tamano	8162	A
8162875	Tomata	8162	A
8162910	Tsukubo	8162	A
8162945	Tsuyama	8162	A
8162980	Wake	8162	A
8166026	Daito	8166	A
8166052	Fujiidera	8166	A
8166078	Habikino	8166	A
8166104	Hannan	8166	A
8166130	Higashiosaka	8166	A
8166156	Hirakata	8166	A
8166182	Ibaraki	8166	A
8166208	Ikeda	8166	A
8166234	Izumi	8166	A
8166260	Izumiotsu	8166	A
8166286	Izumisano	8166	A
8166312	Kadoma	8166	A
8166338	Kaizuka	8166	A
8166364	Kashiwara	8166	A
8166390	Katano	8166	A
8166416	Kawachinagano	8166	A
8166442	Kishiwada	8166	A
8166468	Matsubara	8166	A
8166494	Minamikawachi	8166	A
8166520	Minoo	8166	A
8166546	Mishima	8166	A
8166572	Moriguchi	8166	A
8166598	Neyagawa	8166	A
8166624	Osaka	8166	A
8166650	Osakasayama	8166	A
8166676	Sakai	8166	A
8166702	Senboku	8166	A
8166728	Sennan	8166	A
8166754	Settsu	8166	A
8166780	Shijonawate	8166	A
8166806	Suita	8166	A
8166832	Takaishi	8166	A
8166858	Takatsuki	8166	A
8166884	Tondabayashi	8166	A
8166910	Toyonaka	8166	A
8166936	Toyono	8166	A
8166962	Yao	8166	A
8168142	Imari	8168	A
8168284	Karatsu	8168	A
8168426	Kashima	8168	A
8168568	Saga	8168	A
8168710	Takeo	8168	A
8168852	Taku	8168	A
8168994	Tosu	8168	A
8170020	Ageo	8170	A
8170040	Asaka	8170	A
8170060	Chichibu	8170	A
8170080	Fujimi	8170	A
8170100	Fukaya	8170	A
8170120	Gyôda	8170	A
8170140	Hanno	8170	A
8170160	Hanyu	8170	A
8170180	Hasuda	8170	A
8170200	Hatogaya	8170	A
8170220	Hidaka	8170	A
8170240	Higashimatsuyama	8170	A
8170260	Hiki	8170	A
8170280	Honjo	8170	A
8170300	Iruma	8170	A
8170320	Iwatsuki	8170	A
8170340	Kamifukuoka	8170	A
8170360	Kasukabe	8170	A
8170380	Kawagoe	8170	A
8170400	Kawaguchi	8170	A
8170420	Kazo	8170	A
8170440	Kitaadachi	8170	A
8170460	Kitakatsushika	8170	A
8170480	Kitamoto	8170	A
8170500	Kitasaitama	8170	A
8170520	Kodama	8170	A
8170540	Kônosu	8170	A
8170560	Koshigaya	8170	A
8170580	Kuki	8170	A
8170600	Kumagaya	8170	A
8170620	Minamisaitama	8170	A
8170640	Misato	8170	A
8170660	Niiza	8170	A
8170680	Okegawa	8170	A
8170700	Oosata	8170	A
8170720	Saitama	8170	A
8170740	Sakado	8170	A
8170760	Satte	8170	A
8170780	Sayama	8170	A
8170800	Shiki	8170	A
8170820	Sôka	8170	A
8170840	Toda	8170	A
8170860	Tokorozawa	8170	A
8170880	Tsurugashima	8170	A
8170900	Wakô	8170	A
8170920	Warabi	8170	A
8170940	Yashio	8170	A
8170960	Yoshikawa	8170	A
8172052	Echi	8172	A
8172104	Gamou	8172	A
8172156	Higashiazai	8172	A
8172208	Hikone	8172	A
8172260	Ika	8172	A
8172312	Inukami	8172	A
8172364	Kanzaki	8172	A
8172416	Kouka	8172	A
8172468	Kusatsu	8172	A
8172520	Moriyama	8172	A
8172572	Nagahama	8172	A
8172624	Omihachiman	8172	A
8172676	Otsu	8172	A
8172728	Ritto	8172	A
8172780	Sakata	8172	A
8172832	Shiga	8172	A
8172884	Takashima	8172	A
8172936	Yasu	8172	A
8172988	Yokaichi	8172	A
8174049	Gotsu	8174	A
8174098	Hamada	8174	A
8174147	Hikawa	8174	A
8174196	Hirata	8174	A
8174245	Iishi	8174	A
8174294	Izumo	8174	A
8174343	Kanoashi	8174	A
8174392	Masuda	8174	A
8174441	Matsue	8174	A
8174490	Mino	8174	A
8174539	Naka	8174	A
8174588	Nima	8174	A
8174637	Nita	8174	A
8174686	Nogi	8174	A
8174735	Ochi	8174	A
8174784	Oda	8174	A
8174833	Ohara	8174	A
8174882	Oki	8174	A
8174931	Yasugi	8174	A
8174980	Yatsuka	8174	A
8176033	Atami	8176	A
8176066	Fuji	8176	A
8176099	Fujieda	8176	A
8176132	Fujinomiya	8176	A
8176165	Fukuroi	8176	A
8176198	Gotenba	8176	A
8176231	Haibara	8176	A
8176264	Hamakita	8176	A
8176297	Hamamatsu	8176	A
8176330	Hamana	8176	A
8176363	Ihara	8176	A
8176396	Inasa	8176	A
8176429	Ito	8176	A
8176462	Iwata	8176	A
8176495	Kakegawa	8176	A
8176528	Kamo	8176	A
8176561	Kosai	8176	A
8176594	Mishima	8176	A
8176627	Numazu	8176	A
8176660	Ogasa	8176	A
8176693	Shida	8176	A
8176726	Shimada	8176	A
8176759	Shimoda	8176	A
8176792	Shizuoka	8176	A
8176825	Shuuchi	8176	A
8176858	Suntou	8176	A
8176891	Susono	8176	A
8176924	Tagata	8176	A
8176957	Tenryuu	8176	A
8176990	Yaidu	8176	A
8178052	Ashikaga	8178	A
8178104	Aso	8178	A
8178156	Haga	8178	A
8178208	Imaichi	8178	A
8178260	Kamitsuga	8178	A
8178312	Kanuma	8178	A
8178364	Kawachi	8178	A
8178416	Kuroiso	8178	A
8178468	Mooka	8178	A
8178520	Nasu	8178	A
8178572	Nikko	8178	A
8178624	Otawara	8178	A
8178676	Oyama	8178	A
8178728	Sano	8178	A
8178780	Shimotsuga	8178	A
8178832	Shioya	8178	A
8178884	Tochigi	8178	A
8178936	Utsunomiya	8178	A
8178988	Yaita	8178	A
8180071	Anan	8180	A
8180142	Awa	8180	A
8180213	Itano	8180	A
8180284	Kaifu	8180	A
8180355	Katsuura	8180	A
8180426	Komatsushima	8180	A
8180497	Mima	8180	A
8180568	Miyoshi	8180	A
8180639	Myoudou	8180	A
8180710	Myouzai	8180	A
8180781	Naka	8180	A
8180852	Naruto	8180	A
8180923	Oe	8180	A
8180994	Tokushima	8180	A
8182043	Adachi	8182	A
8182086	Arakawa	8182	A
8182129	Bunkyo	8182	A
8182172	Chiyoda	8182	A
8182215	Chuo	8182	A
8182258	Edogawa	8182	A
8182301	Itabashi	8182	A
8182344	Katsushika	8182	A
8182387	Kita	8182	A
8182430	Koto	8182	A
8182473	Meguro	8182	A
8182516	Minato	8182	A
8182559	Nakano	8182	A
8182602	Nerima	8182	A
8182645	Ota	8182	A
8182688	Setagaya	8182	A
8182731	Shibuya	8182	A
8182774	Shinagawa	8182	A
8182817	Shinjuku	8182	A
8182860	Suginami	8182	A
8182903	Sumida	8182	A
8182946	Taito	8182	A
8182989	Toshima	8182	A
8184099	Hino	8184	A
8184188	Iwami	8184	A
8184277	Ketaka	8184	A
8184366	Kurayoshi	8184	A
8184455	Saihaku	8184	A
8184544	Sakaiminato	8184	A
8184633	Tohaku	8184	A
8184722	Tottori	8184	A
8184811	Yazu	8184	A
8184900	Yonago	8184	A
8186083	Himi	8186	A
8186166	Izumi	8186	A
8186249	Kurobe	8186	A
8186332	Nakaniikawa	8186	A
8186415	Namerikawa	8186	A
8186498	Nanto	8186	A
8186581	Oyabe	8186	A
8186664	Shimoniikawa	8186	A
8186747	Takaoka	8186	A
8186830	Tonami	8186	A
8186913	Toyama	8186	A
8186996	Uozu	8186	A
8188076	Arida	8188	A
8188152	Gobo	8188	A
8188228	Hashimoto	8188	A
8188304	Hidaka	8188	A
8188380	Higashimuro	8188	A
8188456	Ito	8188	A
8188532	Kainan	8188	A
8188608	Kaisou	8188	A
8188684	Naga	8188	A
8188760	Nishimuro	8188	A
8188836	Shingu	8188	A
8188912	Tanabe	8188	A
8188988	Wakayama	8188	A
8190076	Higashine	8190	A
8190152	Kaminoyama	8190	A
8190228	Murayama	8190	A
8190304	Nagai	8190	A
8190380	Nanyo	8190	A
8190456	Obanazawa	8190	A
8190532	Sagae	8190	A
8190608	Sakata	8190	A
8190684	Shinjo	8190	A
8190760	Tendo	8190	A
8190836	Tsuruoka	8190	A
8190912	Yamagata	8190	A
8190988	Yonezawa	8190	A
8192045	Abu	8192	A
8192090	Asa	8192	A
8192135	Hagi	8192	A
8192180	Hikari	8192	A
8192225	Hofu	8192	A
8192270	Iwakuni	8192	A
8192315	Kudamatsu	8192	A
8192360	Kuga	8192	A
8192405	Kumage	8192	A
8192450	Mine	8192	A
8192495	Nagato	8192	A
8192540	Onoda	8192	A
8192585	Ooshima	8192	A
8192630	Ootsu	8192	A
8192675	Saba	8192	A
8192720	Shimonoseki	8192	A
8192765	Shunan	8192	A
8192810	Toyoura	8192	A
8192855	Ube	8192	A
8192900	Yamaguchi	8192	A
8192945	Yanai	8192	A
8192990	Yoshiki	8192	A
8194062	Enzan	8194	A
8194124	Fujiyoshida	8194	A
8194186	Higashiyamanashi	8194	A
8194248	Higashiyatsushiro	8194	A
8194310	Kitakoma	8194	A
8194372	Kitatsuru	8194	A
8194434	Kofu	8194	A
8194496	Minami-arupusu	8194	A
8194558	Minamikoma	8194	A
8194620	Minamitsuru	8194	A
8194682	Nakakoma	8194	A
8194744	Nirasaki	8194	A
8194806	Nishiyatsushiro	8194	A
8194868	Otsuki	8194	A
8194930	Tsuru	8194	A
8194992	Yamanashi	8194	A
8209998	Indeterminado	8209	A
8218998	Indeterminado	8218	A
8227998	Indeterminado	8227	A
8236998	Indeterminado	8236	A
8245998	Indeterminado	8245	A
8254998	Indeterminado	8254	A
8263998	Indeterminado	8263	A
8272998	Indeterminado	8272	A
8281998	Indeterminado	8281	A
8290998	Indeterminado	8290	A
35303998	Indeterminado	35303	A
35306998	Indeterminado	35306	A
35309998	Indeterminado	35309	A
35315998	Indeterminado	35315	A
35318998	Indeterminado	35318	A
35321998	Indeterminado	35321	A
35324998	Indeterminado	35324	A
35327998	Indeterminado	35327	A
35330998	Indeterminado	35330	A
35333998	Indeterminado	35333	A
35336998	Indeterminado	35336	A
35339998	Indeterminado	35339	A
35342998	Indeterminado	35342	A
35345998	Indeterminado	35345	A
35348998	Indeterminado	35348	A
35351998	Indeterminado	35351	A
35354998	Indeterminado	35354	A
35357998	Indeterminado	35357	A
35360998	Indeterminado	35360	A
35363998	Indeterminado	35363	A
35369998	Indeterminado	35369	A
35372998	Indeterminado	35372	A
35375998	Indeterminado	35375	A
35378998	Indeterminado	35378	A
35366998	Indeterminado	35366	A
35368998	Indeterminado	35368	A
35312998	Indeterminado	35312	A
35304050	Dublin	35318	A
35304100	Dun Laoghaire-Rathdown	35318	A
35304150	Fingal	35318	A
35304200	South Dublin	35318	A
35312050	Cork City	35312	A
35339050	Limerick City	35339	A
35369050	Waterford City	35369	A
35321050	Galway City	35321	A
50401998	Indeterminado	50401	A
50404998	Indeterminado	50404	A
50407998	Indeterminado	50407	A
50410998	Indeterminado	50410	A
50413998	Indeterminado	50413	A
50416998	Indeterminado	50416	A
50419998	Indeterminado	50419	A
50422998	Indeterminado	50422	A
50425998	Indeterminado	50425	A
50428998	Indeterminado	50428	A
50431998	Indeterminado	50431	A
50434998	Indeterminado	50434	A
50437998	Indeterminado	50437	A
50440998	Indeterminado	50440	A
50443998	Indeterminado	50443	A
50446998	Indeterminado	50446	A
50449998	Indeterminado	50449	A
50452998	Indeterminado	50452	A
50401101	Arizona	50401	A
50401102	El Porvenir	50401	A
50401103	Esparta	50401	A
50401104	Jutiapa	50401	A
50401105	La Ceiba	50401	A
50401106	La Masica	50401	A
50401107	San Francisco	50401	A
50401108	Tela	50401	A
50404101	Trujillo	50404	A
50404102	Balfate	50404	A
50404103	Iriona	50404	A
50404104	Limón	50404	A
50404105	Sabá	50404	A
50404106	Santa Fe	50404	A
50404107	Santa Rosa de Aguán	50404	A
50404108	Sonaguera	50404	A
50404109	Tocoa	50404	A
50404110	Bonito Oriental	50404	A
50407101	Comayagua	50407	A
50407102	Ajuterique	50407	A
50407103	El Rosario	50407	A
50407104	Esquías	50407	A
50407105	Humuya	50407	A
50407106	La libertad	50407	A
50407107	Lamaní	50407	A
50407108	La Trinidad	50407	A
50407109	Lejamani	50407	A
50407110	Meambar	50407	A
50407111	Minas de Oro	50407	A
50407112	Ojos de Agua	50407	A
50407113	San Jerónimo (Honduras)	50407	A
50407114	San José de Comayagua	50407	A
50407115	San José del Potrero	50407	A
50407116	San Luis	50407	A
50407117	San Sebastián	50407	A
50407118	Siguatepeque	50407	A
50407119	Villa de San Antonio	50407	A
50407120	Las Lajas	50407	A
50407121	Taulabé	50407	A
50410101	Santa Rosa de Copán	50410	A
50410102	Concepción	50410	A
50410103	Corquín	50410	A
50410104	Dolores	50410	A
50410105	El Paraíso	50410	A
50410106	La Jigua	50410	A
50410107	Nueva Arcadia	50410	A
50410108	San Antonio	50410	A
50410109	San José	50410	A
50410110	San Juan de Opoa	50410	A
50410111	San Nicolás	50410	A
50410112	San Pedro	50410	A
50410113	Santa Rita	50410	A
50410114	Trinidad de Copán	50410	A
50410115	Veracruz	50410	A
50413101	San Pedro Sula	50413	A
50413102	Choloma	50413	A
50413103	Omoa	50413	A
50413104	Pimienta	50413	A
50413105	Potrerillos	50413	A
50413106	Puerto Cortés	50413	A
50413107	San Antonio de Cortés	50413	A
50413108	San Francisco de Yojoa	50413	A
50413109	San Manuel	50413	A
50413110	Santa Cruz de Yojoa	50413	A
50413111	Villanueva	50413	A
50413112	La Lima	50413	A
50416101	Choluteca	50416	A
50416102	Apacilagua	50416	A
50416103	Concepción de María	50416	A
50416104	Duyure	50416	A
50416105	El Corpus	50416	A
50416106	El Triunfo	50416	A
50416107	Marcovia	50416	A
50416108	Morolica	50416	A
50416109	Namasigue	50416	A
50416110	Orocuina	50416	A
50416111	Pespire	50416	A
50416112	San Antonio de Flores	50416	A
50416113	San Isidro	50416	A
50416114	San José	50416	A
50416115	San Marcos de Colón	50416	A
50416116	Santa Ana de Yusguare	50416	A
50419101	Yuscarán	50419	A
50419102	Alauca	50419	A
50419103	Danlí	50419	A
50419104	El Paraíso	50419	A
50419105	Güinope	50419	A
50419106	Jacaleapa	50419	A
50419107	Liure	50419	A
50419108	Morocelí	50419	A
50419109	Oropolí	50419	A
50419110	Potrerillos	50419	A
50419111	San Antonio de Flores	50419	A
50419112	San Lucas	50419	A
50419113	San Matías	50419	A
50419114	Soledad	50419	A
50419115	Teupasenti	50419	A
50419116	Texiguat	50419	A
50419117	Vado Ancho	50419	A
50419118	Yauyupe	50419	A
50419119	Trojes	50419	A
50422101	Distrito Central	50422	A
50422102	Alubarén	50422	A
50422103	Cedros	50422	A
50422104	Curarén	50422	A
50422105	El Porvenir	50422	A
50422106	Guaimaca	50422	A
50422107	La Libertad	50422	A
50422108	La Venta	50422	A
50422109	Lepaterique	50422	A
50422110	Maraita	50422	A
50422111	Marale	50422	A
50422112	Nueva Armenia	50422	A
50422113	Ojojona	50422	A
50422114	Orica	50422	A
50422115	Reitoca	50422	A
50422116	Sabanagrande	50422	A
50422117	San Antonio de Oriente	50422	A
50422118	San Buenaventura	50422	A
50422119	San Ignacio	50422	A
50422120	San Juan de Flores	50422	A
50422121	San Miguelito	50422	A
50422122	Santa Ana	50422	A
50422123	Santa Lucía	50422	A
50422124	Talanga	50422	A
50422125	Tatumbla	50422	A
50422126	Valle de Ángeles	50422	A
50422127	Villa de San Francisco	50422	A
50422128	Vallecillo	50422	A
50425101	Puerto Lempira	50425	A
50425102	Brus Laguna	50425	A
50425103	Ahuas	50425	A
50425104	Juan Francisco Bulnes	50425	A
50425105	Ramón Villeda Morales	50425	A
50425106	Wampusirpe	50425	A
50428101	La Esperanza	50428	A
50428102	Camasca	50428	A
50428103	Colomoncagua	50428	A
50428104	Concepción	50428	A
50428105	Dolores	50428	A
50428106	Intibucá	50428	A
50428107	Jesús de Otoro	50428	A
50428108	Magdalena	50428	A
50428109	Masaguara	50428	A
50428110	San Antonio	50428	A
50428111	San Isidro	50428	A
50428112	San Juan	50428	A
50428113	San Marcos de la Sierra	50428	A
50428114	San Miguel Guancapla	50428	A
50428115	Santa Lucía	50428	A
50428116	Yamaranguila	50428	A
50428117	San Francisco de Opalaca	50428	A
50431101	Roatán	50431	A
50431102	Guanaja	50431	A
50431103	José Santos Guardiola	50431	A
50431104	Utila	50431	A
50434101	La Paz	50434	A
50434102	Aguanqueterique	50434	A
50434103	Cabañas	50434	A
50434104	Cane	50434	A
50434105	Chinacla	50434	A
50434106	Guajiquiro	50434	A
50434107	Lauterique	50434	A
50434108	Marcala	50434	A
50434109	Mercedes de Oriente	50434	A
50434110	Opatoro	50434	A
50434111	San Antonio del Norte	50434	A
50434112	San José	50434	A
50434113	San Juan	50434	A
50434114	San Pedro de Tutule	50434	A
50434115	Santa Ana	50434	A
50434116	Santa Elena	50434	A
50434117	Santa María	50434	A
50434118	Santiago de Puringla	50434	A
50434119	Yarula	50434	A
50437101	Gracias	50437	A
50437102	Belén	50437	A
50437103	Candelaria	50437	A
50437104	Cololaca	50437	A
50437105	Erandique	50437	A
50437106	Gualcince	50437	A
50437107	Guarita	50437	A
50437108	La Campa	50437	A
50437109	La Iguala	50437	A
50437110	Las Flores	50437	A
50437111	La Unión	50437	A
50437112	La Virtud	50437	A
50437113	Lepaera	50437	A
50437114	Mapulaca	50437	A
50437115	Piraera	50437	A
50437116	San Andrés	50437	A
50437117	San Francisco	50437	A
50437118	San Juan Guarita	50437	A
50437119	San Manuel Colohete	50437	A
50437120	San Rafael	50437	A
50437121	San Sebastián	50437	A
50437122	Santa Cruz	50437	A
50437123	Talgua	50437	A
50437124	Tambla	50437	A
50437125	Tomalá	50437	A
50437126	Valladolid	50437	A
50437127	Virginia	50437	A
50437128	San Marcos de Caiquín	50437	A
50440101	Ocotepeque	50440	A
50440102	Belén Gualcho	50440	A
50440103	Concepción	50440	A
50440104	Dolores Merendón	50440	A
50440105	Fraternidad	50440	A
50440106	La Encarnación	50440	A
50440107	La Labor	50440	A
50440108	Lucerna	50440	A
50440109	Mercedes	50440	A
50440110	San Fernando	50440	A
50440111	San Francisco del Valle	50440	A
50440112	San Jorge	50440	A
50440113	San Marcos	50440	A
50440114	Santa Fe	50440	A
50440115	Sensenti	50440	A
50440116	Sinuapa	50440	A
50443101	Juticalpa	50443	A
50443102	Campamento	50443	A
50443103	Catacamas	50443	A
50443104	Concordia	50443	A
50443105	Dulce Nombre de Culmí	50443	A
50443106	El Rosario	50443	A
50443107	Esquipulas del Norte	50443	A
50443108	Gualaco	50443	A
50443109	Guarizama	50443	A
50443110	Guata	50443	A
50443111	Guayape	50443	A
50443112	Jano	50443	A
50443113	La Unión	50443	A
50443114	Mangulile	50443	A
50443115	Manto	50443	A
50443116	Salamá	50443	A
50443117	San Esteban	50443	A
50443118	San Francisco de Becerra	50443	A
50443119	San Francisco de la Paz	50443	A
50443120	Santa María del Real	50443	A
50443121	Silca	50443	A
50443122	Yocón	50443	A
50443123	Patuca	50443	A
50446101	Santa Bárbara	50446	A
50446102	Arada	50446	A
50446103	Atima	50446	A
50446104	Azacualpa	50446	A
50446105	Ceguaca	50446	A
50446106	Concepción del Norte	50446	A
50446107	Concepción del Sur	50446	A
50446108	Chinda	50446	A
50446109	El Níspero	50446	A
50446110	Gualala	50446	A
50446111	Ilama	50446	A
50446112	Las Vegas	50446	A
50446113	Macuelizo	50446	A
50446114	Naranjito	50446	A
50446115	Nuevo Celilac	50446	A
50446116	Nueva Frontera	50446	A
50446117	Petoa	50446	A
50446118	Protección	50446	A
50446119	Quimistán	50446	A
50446120	San Francisco de Ojuera	50446	A
50446121	San José de las Colinas	50446	A
50446122	San Luis	50446	A
50446123	San Marcos	50446	A
50446124	San Nicolás	50446	A
50446125	San Pedro Zacapa	50446	A
50446126	San Vicente Centenario	50446	A
50446127	Santa Rita	50446	A
50446128	Trinidad	50446	A
50449101	Nacaome	50449	A
50449102	Alianza	50449	A
50449103	Amapala	50449	A
50449104	Aramecina	50449	A
50449105	Caridad	50449	A
50449106	Goascorán	50449	A
50449107	Langue	50449	A
50449108	San Francisco de Coray	50449	A
50449109	San Lorenzo	50449	A
50452101	Yoro	50452	A
50452102	Arenal	50452	A
50452103	El Negrito	50452	A
50452104	El Progreso	50452	A
50452105	Jocón	50452	A
50452106	Morazán	50452	A
50452107	Olanchito	50452	A
50452108	Santa Rita	50452	A
50452109	Sulaco	50452	A
50452110	Victoria	50452	A
50452111	Yorito	50452	A
50613998	Indeterminado	50613	A
50665998	Indeterminado	50665	A
50678998	Indeterminado	50678	A
50613066	Alajuela	50613	A
50613132	Zarcero	50613	A
50613198	Atenas	50613	A
50613264	Grecia	50613	A
50613330	Guatuso	50613	A
50613396	Los Chiles	50613	A
50613462	Naranjo	50613	A
50613528	Orotina	50613	A
50613594	Palmares	50613	A
50613660	Poás	50613	A
50613726	San Carlos	50613	A
50613792	San Mateo	50613	A
50613858	San Ramón	50613	A
50613924	Upala	50613	A
50613990	Valverde Vega	50613	A
50626124	Alvarado	50626	A
50626248	Cartago	50626	A
50626372	El Guarco	50626	A
50626496	Jiménez	50626	A
50626620	La Unión	50626	A
50626744	Oreamuno	50626	A
50626868	Paraíso	50626	A
50626992	Turrialba	50626	A
50626998	Indeterminado	50626	A
50639090	Abangares	50639	A
50639180	Bagaces	50639	A
50639270	Cañas	50639	A
50639360	Carrillo	50639	A
50639450	Hojancha	50639	A
50639540	La Cruz	50639	A
50639630	Liberia	50639	A
50639720	Nandayure	50639	A
50639810	Nicoya	50639	A
50639900	Santa Cruz	50639	A
50639990	Tilarán	50639	A
50639998	Indeterminado	50639	A
50652090	Barva	50652	A
50652180	Belén	50652	A
50652270	Flores	50652	A
50652360	Heredia	50652	A
50652450	San Isidro	50652	A
50652540	San Pablo	50652	A
50652630	San Rafael	50652	A
50652720	Santa Bárbara	50652	A
50652810	Santo Domingo	50652	A
50652900	Sarapiquí	50652	A
50652998	Indeterminado	50652	A
50665165	Guácimo	50665	A
50665330	Limón	50665	A
50665495	Matina	50665	A
50665660	Pococí	50665	A
50665825	Siquirres	50665	A
50665990	Talamanca	50665	A
50678083	Aguirre	50678	A
50678166	Buenos Aires	50678	A
50678249	Corredores	50678	A
50678332	Coto Brus	50678	A
50678415	Esparza	50678	A
50678498	Garabito	50678	A
50678581	Golfito	50678	A
50678664	Montes de Oro	50678	A
50678747	Osa	50678	A
50678830	Parrita	50678	A
50678913	Puntarenas	50678	A
50691047	Acosta	50691	A
50691094	Alajuelita	50691	A
50691141	Aserrí	50691	A
50691188	Curridabat	50691	A
50691235	Desamparados	50691	A
50691282	Dota	50691	A
50691329	Escazú	50691	A
50691376	Goicoechea	50691	A
50691423	León Cortés	50691	A
50691470	Montes de Oca	50691	A
50691517	Mora	50691	A
50691564	Moravia	50691	A
50691611	Pérez Zeledón	50691	A
50691658	Puriscal	50691	A
50691705	San José	50691	A
50691752	Santa Ana	50691	A
50691799	Tarrazú	50691	A
50691846	Tibás	50691	A
50691893	Turrubares	50691	A
50691940	Vázquez de Coronado	50691	A
50691998	Indeterminado	50691	A
59102998	Indeterminado	59102	A
59103998	Indeterminado	59103	A
59104998	Indeterminado	59104	A
59105998	Indeterminado	59105	A
59106998	Indeterminado	59106	A
59107998	Indeterminado	59107	A
59108998	Indeterminado	59108	A
59109998	Indeterminado	59109	A
59110998	Indeterminado	59110	A
59102101	Cercado	59102	A
59102102	Antonio Vaca Díez	59102	A
59102103	General José Ballivián Segurola	59102	A
59102104	Yacuma	59102	A
59102105	Moxos	59102	A
59102106	Marbán	59102	A
59102107	Mamoré	59102	A
59102108	Iténez	59102	A
59103101	Oropeza	59103	A
59103102	Azurduy	59103	A
59103103	Jaime Zudáñez	59103	A
59103104	Tomina	59103	A
59103105	Hernando Siles	59103	A
59103106	Yamparáez	59103	A
59103107	Nor Cinti	59103	A
59103108	Sud Cinti	59103	A
59103109	Belisario Boeto	59103	A
59103110	Luis Calvo	59103	A
59104101	Araní	59104	A
59104102	Esteban Arce	59104	A
59104103	Arque	59104	A
59104104	Ayopaya	59104	A
59104105	Campero	59104	A
59104106	Capinota	59104	A
59104107	Cercado	59104	A
59104108	Carrasco	59104	A
59104109	Chapare	59104	A
59104110	Germán Jordán	59104	A
59104111	Mizque	59104	A
59104112	Punata	59104	A
59104113	Quillacollo	59104	A
59104114	Tapacarí	59104	A
59104115	Bolívar	59104	A
59104116	Tiraque	59104	A
59105101	Aroma	59105	A
59105102	Juan Bautista Saavedra	59105	A
59105103	Abel Iturralde	59105	A
59105104	Caranavi	59105	A
59105105	Eliodoro Camacho	59105	A
59105106	Franz Tamayo Solares	59105	A
59105107	Gualberto Villaroel López	59105	A
59105108	Ingavi	59105	A
59105109	Inquisivi	59105	A
59105110	General José Manuel Pando	59105	A
59105111	Larecaja	59105	A
59105112	José Ramón Loayza	59105	A
59105113	Los Andes	59105	A
59105114	Manco Kapac	59105	A
59105115	Muñecas	59105	A
59105116	Nor Yungas	59105	A
59105117	Omasuyos	59105	A
59105118	Pacajes	59105	A
59105119	Pedro Domingo Murillo	59105	A
59105120	Sud Yungas	59105	A
59106101	Carangas	59106	A
59106102	Cercado	59106	A
59106103	Eduardo Avaroa	59106	A
59106104	Ladislao Cabrera	59106	A
59106105	Litoral de Atacama	59106	A
59106106	Mejillones	59106	A
59106107	Nor Carangas	59106	A
59106108	Pantaleón Dalence	59106	A
59106109	Poopó	59106	A
59106110	Sabaya	59106	A
59106111	Sajama	59106	A
59106112	San Pedro de Totora	59106	A
59106113	Saucarí	59106	A
59106114	Sebastián Pagador	59106	A
59106115	Sud Carangas	59106	A
59106116	Tomas Barrón	59106	A
59108101	Alonso de Ibáñez	59108	A
59108102	Antonio Quijarro	59108	A
59108103	Bernardino Bilbao Rioja	59108	A
59108104	Charcas	59108	A
59108105	Chayanta	59108	A
59108106	Cornelio Saavedra	59108	A
59108107	Daniel Campos	59108	A
59108108	Enrique Baldivieso	59108	A
59108109	José María Linares	59108	A
59108110	Modesto Omiste	59108	A
59108111	Nor Chichas	59108	A
59108112	Nor Lípez	59108	A
59108113	Rafael Bustillo	59108	A
59108114	Sud Chichas	59108	A
59108115	Sud Lípez	59108	A
59108116	Tomás Frías	59108	A
59107101	Abuná	59107	A
59107102	Federico Román	59107	A
59107103	Madre de Dios	59107	A
59107104	Manuripi	59107	A
59107105	Nicolás Suárez	59107	A
59109101	Andrés Ibáñez	59109	A
59109102	Ángel Sandóval	59109	A
59109103	Caballero	59109	A
59109104	Chiquitos	59109	A
59109105	Cordillera	59109	A
59109106	Florida	59109	A
59109107	Germán Busch	59109	A
59109108	Guarayos	59109	A
59109109	Ichilo	59109	A
59109110	Ñuflo de Chaves	59109	A
59109111	Obispo Santistevan	59109	A
59109112	Sara	59109	A
59109113	Vallegrande	59109	A
59109114	Velasco	59109	A
59109115	Warnes	59109	A
59110101	Aniceto Arce	59110	A
59110102	Burnett O'Connor	59110	A
59110103	Cercado	59110	A
59110104	Eustaquio Méndez	59110	A
59110105	Gran Chaco	59110	A
59110106	José María Avilés	59110	A
59304998	Indeterminado	59304	A
59308998	Indeterminado	59308	A
59312998	Indeterminado	59312	A
59316998	Indeterminado	59316	A
59320998	Indeterminado	59320	A
59324998	Indeterminado	59324	A
59328998	Indeterminado	59328	A
59332998	Indeterminado	59332	A
59336998	Indeterminado	59336	A
59340998	Indeterminado	59340	A
59344998	Indeterminado	59344	A
59348998	Indeterminado	59348	A
59352998	Indeterminado	59352	A
59356998	Indeterminado	59356	A
59360998	Indeterminado	59360	A
59364998	Indeterminado	59364	A
59368998	Indeterminado	59368	A
59372998	Indeterminado	59372	A
59376998	Indeterminado	59376	A
59377998	Indeterminado	59377	A
59379998	Indeterminado	59379	A
59380998	Indeterminado	59380	A
59384998	Indeterminado	59384	A
59388998	Indeterminado	59388	A
59304071	Chordeleg	59304	A
59304142	Cuenca	59304	A
59304213	El Pan	59304	A
59304284	Girón	59304	A
59304355	Guachepala	59304	A
59304426	Gualaceo	59304	A
59304497	Mabón	59304	A
59304568	Oña	59304	A
59304639	Paute	59304	A
59304710	Pucará	59304	A
59304781	San Fernando	59304	A
59304852	Santa Isabel	59304	A
59304923	Sevilla de Oro	59304	A
59304994	Sigsig	59304	A
59308142	Caluma	59308	A
59308284	Chillanes	59308	A
59308426	Chimbo	59308	A
59308568	Echeandía	59308	A
59308710	Guaranda	59308	A
59308852	Las Naves	59308	A
59308994	San Miguel	59308	A
59312166	Azogues	59312	A
59312332	Biblián	59312	A
59312498	Cañar	59312	A
59312664	Déleg	59312	A
59312830	El Tambo	59312	A
59312996	La Troncal	59312	A
59316166	Bolívar	59316	A
59316332	Espejo	59316	A
59316498	Huaca	59316	A
59316664	Mira	59316	A
59316830	Montúfar	59316	A
59316996	Tulcán	59316	A
59320124	Alausí	59320	A
59320248	Chunchi	59320	A
59320372	Colta	59320	A
59320496	Guamote	59320	A
59320620	Guano	59320	A
59320744	Pallatanga	59320	A
59320868	Penipe	59320	A
59320992	Riobamba	59320	A
59324166	La Maná	59324	A
59324332	Latacunga	59324	A
59324498	Pangua	59324	A
59324664	Pujilí	59324	A
59324830	Salcedo	59324	A
59324996	Sigchos	59324	A
59328071	Arenillas	59328	A
59328142	Atahualpa	59328	A
59328213	Balsas	59328	A
59328284	Chilla	59328	A
59328355	El Guabo	59328	A
59328426	Huaquillas	59328	A
59328497	Las Lajas	59328	A
59328568	Machala	59328	A
59328639	Marcabellí	59328	A
59328710	Pasaje	59328	A
59328781	Piñas	59328	A
59328852	Portovelo	59328	A
59328923	Santa Rosa	59328	A
59328994	Zaruma	59328	A
59332166	Atacames	59332	A
59332332	Eloy Alfaro	59332	A
59332498	Esmeraldas	59332	A
59332664	Muisne	59332	A
59332830	Quinindé	59332	A
59332996	San Lorenzo	59332	A
59336332	Isabela	59336	A
59336664	San Cristóbal	59336	A
59336996	Santa Cruz	59336	A
59340038	Balao	59340	A
59340076	Balzar	59340	A
59340114	Baquerizo Moreno	59340	A
59340152	Colimes	59340	A
59340190	Coronel. Marcelino Maridueña	59340	A
59340228	Daule	59340	A
59340266	El Empalme	59340	A
59340304	El Triunfo	59340	A
59340342	Eloy Alfaro	59340	A
59340380	Guayaquil	59340	A
59340418	Jado	59340	A
59340456	Lomas de Sargentillo	59340	A
59340494	Milagro	59340	A
59340532	Naranjal	59340	A
59340570	Naranjito	59340	A
59340608	Nobol	59340	A
59340646	Palestina	59340	A
59340684	Pedro Carbo	59340	A
59340722	Playas	59340	A
59340798	Samborondón	59340	A
59340874	Santa Lucía	59340	A
59340912	Simón Bolívar	59340	A
59340950	Urbina	59340	A
59340988	Yaguachi	59340	A
59344166	Antonio Ante	59344	A
59344332	Cotacachi	59344	A
59344498	Ibarra	59344	A
59344664	Otavalo	59344	A
59344830	Pimampiro	59344	A
59344996	San Miguel de Urcuquí	59344	A
59348066	Alamor	59348	A
59348132	Calvas	59348	A
59348198	Catamayo	59348	A
59348264	Celica	59348	A
59348330	Chaguarpamba	59348	A
59348396	Gonzanamá	59348	A
59348462	Loja	59348	A
59348528	Macará	59348	A
59348594	Paltas	59348	A
59348660	Pindal	59348	A
59348726	Puyango	59348	A
59348792	Quilanga	59348	A
59348858	Saraguro	59348	A
59348924	Sozoranga	59348	A
59348990	Zapotillo	59348	A
59352083	Baba	59352	A
59352166	Babahoyo	59352	A
59352249	Catarama	59352	A
59352332	Mocache	59352	A
59352415	Montalvo	59352	A
59352498	Palenque	59352	A
59352581	Puebloviejo	59352	A
59352664	Quevedo	59352	A
59352747	Urdaneta	59352	A
59352830	Valencia	59352	A
59352913	Ventanas	59352	A
59352996	Vinces	59352	A
59356062	24 de Mayo	59356	A
59356124	Bolívar	59356	A
59356186	Chone	59356	A
59356248	El Carmen	59356	A
59356310	Flavio Alfaro	59356	A
59356372	Jipijapa	59356	A
59356434	Junín	59356	A
59356496	Manta	59356	A
59356558	Montecristi	59356	A
59356620	Paján	59356	A
59356682	Pichincha	59356	A
59356744	Portoviejo	59356	A
59356806	Rocafuerte	59356	A
59356868	Santa Ana	59356	A
59356930	Sucre	59356	A
59356992	Tosagua	59356	A
59360124	Gral. Leonidas	59360	A
59360248	Gualaquiza	59360	A
59360372	Huamboya	59360	A
59360496	Macas	59360	A
59360620	Palora	59360	A
59360744	San Juan Bosco	59360	A
59360868	Santiago	59360	A
59360992	Sucúa	59360	A
59364199	Archidona	59364	A
59364398	Baeza	59364	A
59364597	El Chaco	59364	A
59364796	Quijos	59364	A
59364995	Tena	59364	A
59368249	Aguarico	59368	A
59368498	Francisco de Orellana	59368	A
59368747	La Joya de los Sachas	59368	A
59368996	Loreto	59368	A
59372332	Mera	59372	A
59372664	Pastaza	59372	A
59372996	Santa Clara	59372	A
59376142	Cayambe	59376	A
59376284	Mejía	59376	A
59376426	Pedro Moncayo	59376	A
59376568	Quito	59376	A
59376710	Rumiñahui	59376	A
59376852	San Miguel de los Bancos	59376	A
59380166	Cascales	59380	A
59380332	Gonzalo Pizarro	59380	A
59380498	Lago Agrío	59380	A
59380664	Putumayo	59380	A
59380830	Shushufindi	59380	A
59380996	Sucumbíos	59380	A
59384110	Ambato	59384	A
59384220	Baños	59384	A
59384330	Cevallos	59384	A
59384440	Mocha	59384	A
59384550	Patate	59384	A
59384660	Quero	59384	A
59384770	San Pedro de Pelileo	59384	A
59384880	Santiago de Píllaro	59384	A
59384990	Tisaleo	59384	A
59388166	Centinela del Cóndor	59388	A
59388332	Chinchipe	59388	A
59388498	El Pangui	59388	A
59388664	Nangaritza	59388	A
59388830	Yacuambi	59388	A
59388996	Zamora	59388	A
59340760	Salinas	59377	A
59340836	Santa Elena	59377	A
59376994	Santo Domingo	59379	A
59377010	La Libertad	59377	A
59376480	Pedro Vicente Maldonado	59376	A
59376520	Puerto Quito	59376	A
59501998	Indeterminado	59501	A
59501040	ALTO PARAGUAY	59501	A
59501080	ALTO PARANÁ	59501	A
59501120	AMAMBAY	59501	A
59501200	BOQUERÓN	59501	A
59501240	CAAGUAZÚ	59501	A
59501280	CAAZAPA	59501	A
59501320	CANINDEYÚ	59501	A
59501360	CENTRAL	59501	A
59501400	CONCEPCIÓN	59501	A
59501440	CORDILLERA	59501	A
59501480	DISTRITO CAPITAL	59501	A
59501520	GUAIRA	59501	A
59501560	ITAPUA	59501	A
59501600	MISIONES	59501	A
59501640	ÑEEMBUCÚ	59501	A
59501680	PARAGUARÍ	59501	A
59501720	PRESIDENTE HAYES	59501	A
59501760	SAN PEDRO	59501	A
59801998	Indeterminado	59801	A
59801045	Artigas	59801	A
59801090	Canelones	59801	A
59801135	Cerro Largo	59801	A
59801180	Colonia	59801	A
59801225	Durazno	59801	A
59801270	Flores	59801	A
59801315	Florida	59801	A
59801360	Lavalleja	59801	A
59801405	Maldonado	59801	A
59801450	Montevideo	59801	A
59801495	Paysandú	59801	A
59801540	Rio Negro	59801	A
59801585	Rivera	59801	A
59801630	Rocha	59801	A
59801675	Salto	59801	A
59801720	San José	59801	A
59801765	Soriano	59801	A
59801810	Tacuarembó	59801	A
59801855	Treinta y Tres	59801	A
96601998	Indeterminado	96601	A
9660001	Riyadh	96601	A
97201998	Indeterminado	97201	A
97204998	Indeterminado	97204	A
97207998	Indeterminado	97207	A
97210998	Indeterminado	97210	A
97213998	Indeterminado	97213	A
97216998	Indeterminado	97216	A
97201101	Central	97201	A
97204102	Haifa	97204	A
97204103	Hadera	97204	A
97207104	Jerusalén	97210	A
97210105	Norte	97207	A
97213106	Meridional	97213	A
97216107	Tel Aviv	97216	A
999998998	Indeterminado	999998	A
999898998	Indeterminado	999898	A
999798998	Indeterminado	999798	A
999698998	Indeterminado	999698	A
999598998	Indeterminado	999598	A
198998	Indeterminado	198	A
298998	Indeterminado	298	A
398998	Indeterminado	398	A
498998	Indeterminado	498	A
598998	Indeterminado	598	A
798998	Indeterminado	798	A
2098998	Indeterminado	2098	A
2798998	Indeterminado	2798	A
3098998	Indeterminado	3098	A
3198998	Indeterminado	3198	A
3298998	Indeterminado	3298	A
3398998	Indeterminado	3398	A
3698998	Indeterminado	3698	A
4098998	Indeterminado	4098	A
4198998	Indeterminado	4198	A
4398998	Indeterminado	4398	A
4498998	Indeterminado	4498	A
4598998	Indeterminado	4598	A
4698998	Indeterminado	4698	A
4798998	Indeterminado	4798	A
4898998	Indeterminado	4898	A
4998998	Indeterminado	4998	A
5198998	Indeterminado	5198	A
5298998	Indeterminado	5298	A
5398998	Indeterminado	5398	A
5498998	Indeterminado	5498	A
5598998	Indeterminado	5598	A
5698998	Indeterminado	5698	A
5798998	Indeterminado	5798	A
5898998	Indeterminado	5898	A
6098998	Indeterminado	6098	A
6198998	Indeterminado	6198	A
6298998	Indeterminado	6298	A
6398998	Indeterminado	6398	A
6498998	Indeterminado	6498	A
6598998	Indeterminado	6598	A
6698998	Indeterminado	6698	A
8198998	Indeterminado	8198	A
8298998	Indeterminado	8298	A
8498998	Indeterminado	8498	A
8698998	Indeterminado	8698	A
9098998	Indeterminado	9098	A
9198998	Indeterminado	9198	A
9298998	Indeterminado	9298	A
9398998	Indeterminado	9398	A
9498998	Indeterminado	9498	A
9598998	Indeterminado	9598	A
9898998	Indeterminado	9898	A
21298998	Indeterminado	21298	A
21398998	Indeterminado	21398	A
21698998	Indeterminado	21698	A
21898998	Indeterminado	21898	A
22098998	Indeterminado	22098	A
22198998	Indeterminado	22198	A
22298998	Indeterminado	22298	A
22398998	Indeterminado	22398	A
22498998	Indeterminado	22498	A
22598998	Indeterminado	22598	A
22698998	Indeterminado	22698	A
22798998	Indeterminado	22798	A
22998998	Indeterminado	22998	A
23098998	Indeterminado	23098	A
23198998	Indeterminado	23198	A
23298998	Indeterminado	23298	A
23398998	Indeterminado	23398	A
23498998	Indeterminado	23498	A
23598998	Indeterminado	23598	A
23698998	Indeterminado	23698	A
23798998	Indeterminado	23798	A
23898998	Indeterminado	23898	A
23998998	Indeterminado	23998	A
24098998	Indeterminado	24098	A
24198998	Indeterminado	24198	A
24298998	Indeterminado	24298	A
24398998	Indeterminado	24398	A
24498998	Indeterminado	24498	A
24598998	Indeterminado	24598	A
24998998	Indeterminado	24998	A
25098998	Indeterminado	25098	A
25298998	Indeterminado	25298	A
25498998	Indeterminado	25498	A
25598998	Indeterminado	25598	A
25698998	Indeterminado	25698	A
25798998	Indeterminado	25798	A
25898998	Indeterminado	25898	A
26098998	Indeterminado	26098	A
26198998	Indeterminado	26198	A
26298998	Indeterminado	26298	A
26398998	Indeterminado	26398	A
26498998	Indeterminado	26498	A
26598998	Indeterminado	26598	A
26698998	Indeterminado	26698	A
26798998	Indeterminado	26798	A
26898998	Indeterminado	26898	A
26998998	Indeterminado	26998	A
29098998	Indeterminado	29098	A
29198998	Indeterminado	29198	A
35198998	Indeterminado	35198	A
35298998	Indeterminado	35298	A
35398998	Indeterminado	35398	A
35498998	Indeterminado	35498	A
35598998	Indeterminado	35598	A
35698998	Indeterminado	35698	A
35798998	Indeterminado	35798	A
35898998	Indeterminado	35898	A
35998998	Indeterminado	35998	A
37098998	Indeterminado	37098	A
37198998	Indeterminado	37198	A
37298998	Indeterminado	37298	A
37398998	Indeterminado	37398	A
37498998	Indeterminado	37498	A
37598998	Indeterminado	37598	A
37698998	Indeterminado	37698	A
37798998	Indeterminado	37798	A
37898998	Indeterminado	37898	A
37998998	Indeterminado	37998	A
38098998	Indeterminado	38098	A
38198998	Indeterminado	38198	A
38598998	Indeterminado	38598	A
38698998	Indeterminado	38698	A
38798998	Indeterminado	38798	A
38998998	Indeterminado	38998	A
42098998	Indeterminado	42098	A
42198998	Indeterminado	42198	A
42398998	Indeterminado	42398	A
50198998	Indeterminado	50198	A
50298998	Indeterminado	50298	A
50398998	Indeterminado	50398	A
50498998	Indeterminado	50498	A
50598998	Indeterminado	50598	A
50698998	Indeterminado	50698	A
50798998	Indeterminado	50798	A
50998998	Indeterminado	50998	A
59198998	Indeterminado	59198	A
59298998	Indeterminado	59298	A
59398998	Indeterminado	59398	A
59498998	Indeterminado	59498	A
59598998	Indeterminado	59598	A
59698998	Indeterminado	59698	A
59798998	Indeterminado	59798	A
59898998	Indeterminado	59898	A
59998998	Indeterminado	59998	A
67298998	Indeterminado	67298	A
67398998	Indeterminado	67398	A
67498998	Indeterminado	67498	A
67598998	Indeterminado	67598	A
67698998	Indeterminado	67698	A
67798998	Indeterminado	67798	A
67898998	Indeterminado	67898	A
67998998	Indeterminado	67998	A
68098998	Indeterminado	68098	A
68598998	Indeterminado	68598	A
68698998	Indeterminado	68698	A
68798998	Indeterminado	68798	A
68898998	Indeterminado	68898	A
68998998	Indeterminado	68998	A
69098998	Indeterminado	69098	A
69198998	Indeterminado	69198	A
69298998	Indeterminado	69298	A
85098998	Indeterminado	85098	A
85398998	Indeterminado	85398	A
85698998	Indeterminado	85698	A
88098998	Indeterminado	88098	A
88698998	Indeterminado	88698	A
96098998	Indeterminado	96098	A
96198998	Indeterminado	96198	A
96298998	Indeterminado	96298	A
96398998	Indeterminado	96398	A
96498998	Indeterminado	96498	A
96598998	Indeterminado	96598	A
96698998	Indeterminado	96698	A
96798998	Indeterminado	96798	A
96898998	Indeterminado	96898	A
97198998	Indeterminado	97198	A
97298998	Indeterminado	97298	A
97398998	Indeterminado	97398	A
97498998	Indeterminado	97498	A
97598998	Indeterminado	97598	A
97698998	Indeterminado	97698	A
97798998	Indeterminado	97798	A
99398998	Indeterminado	99398	A
99498998	Indeterminado	99498	A
99598998	Indeterminado	99598	A
99898998	Indeterminado	99898	A
86898998	Indeterminado	86898	A
126898998	Indeterminado	126898	A
124298998	Indeterminado	124298	A
124698998	Indeterminado	124698	A
176798998	Indeterminado	176798	A
147398998	Indeterminado	147398	A
186998998	Indeterminado	186998	A
178498998	Indeterminado	178498	A
175898998	Indeterminado	175898	A
99298998	Indeterminado	99298	A
99698998	Indeterminado	99698	A
7798998	Indeterminado	7798	A
67098998	Indeterminado	67098	A
38298998	Indeterminado	38298	A
25398998	Indeterminado	25398	A
25198998	Indeterminado	25198	A
24898998	Indeterminado	24898	A
22898998	Indeterminado	22898	A
85598998	Indeterminado	85598	A
28398998	Indeterminado	28398	A
\.


--
-- Data for Name: estados_civiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY estados_civiles (id, nombre) FROM stdin;
1	Soltero
2	Casado
3	Divorciado
4	Viudo
\.


--
-- Data for Name: estados_expedientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY estados_expedientes (id, nombre) FROM stdin;
1	En curso
2	Parado
3	Desaparecido
\.


--
-- Data for Name: estados_relatorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY estados_relatorias (id, nombre) FROM stdin;
\.


--
-- Data for Name: eventos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY eventos (fecha, descripcion, id, hora) FROM stdin;
2015-10-15	Segundo evento	2	\N
2015-10-16	Reunión de autoridades en algún lado interesante.	3	\N
2015-10-13	Comienzo Rosh Hashana	4	\N
2015-10-16	Día Internacional de la Protección de la Capa de Ozono Se realiza en conmemoración al día en que se firmó el Protocolo de Montreal, en 1987, relativo a las sustancias que agotan la capa de ozono (Resolución 49/114 del 19 de diciembre).	6	\N
2015-10-17	1861\nSe produce la batalla de Pavón entre las fuerzas comandadas por el general Bartolomé Mitre y las tropas del general Justo José de Urquiza, gobernador de la provincia de Entre Ríos. El general Mitre resultó vencedor de la contienda y entró en Rosario, Santa Fe el 6 de octubre del mismo año. El doctor Santiago Derqui, presidente de la Confederación, renunció el 5 de noviembre y refugiándose en Montevideo. Mitre asumió así el gobierno provisoriamente y asumió como presidente constitucional de la República Argentina el 12 de octubre de 1862, tras celebrar elecciones.	8	\N
2015-10-18	1931: Japón inicia la invasión de Dongbei Pingyuan (Manchuria).	5	\N
2015-10-19	1955: Tras la renuncia del general Juan Domingo Perón, se forma una Junta Militar, que establece la plena vigencia del estado de sitio.	10	15:30:00
2015-10-17	1898:\nMuere en Londres, Inglaterra, Manuela Rosas de Terrero, conocida como Manuelita. Fue hija del general Juan Manuel de Rosas y Encarnación de Ezcurra y Arguibel. Tuvo una destacada actuación durante el prolongado gobierno de su padre, durante el cual intervino en varias ocasiones en asuntos de Estado.	9	12:15:00
2015-10-16	1882 - Ricardo Rojas.\nNació en Tucumán el 16 de setiembre de 1882 don Ricardo Rojas, poeta, pensador, dramaturgo, historiador, crítico y político. Fue profesor de literatura castellana, director del Instituto de Literatura Argentina de la Facultad de Filosofía y Letras de Buenos Aires, rector de la Universidad de Buenos Aires.	7	10:00:00
2015-10-15	primer evento	1	22:00:00
2016-01-26	hola	11	09:00:00
\.


--
-- Name: eventos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('eventos_id_seq', 11, true);


--
-- Data for Name: expedientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY expedientes (id, id_procedencia, id_tipogestion, id_clasificador, id_estado_expediente, fecha_presentacion, fecha_ultimo_mov, id_responsable_ingreso, numero, denuncia_policial, lugar_denuncia, fecha_denuncia, persona_denuncia, lugar_hecho_denuncia, ultimo_episodio_denuncia, encuadre_legal, aplicacion_ley, id_estado_relatoria, fecha_entrada, fecha_salida, fecha_cierre, fecha_archivo, procedencia, id_institucion, origen_presentacion, motivo_consulta, observaciones, organismo, dependencia_org, lugar, tipo_atencion, id_ambito, nomeclador_1, nomeclador_2, nomeclador_3, violencia_1, violencia_2, violencia_3, fecha_derivacion, hubo_violencia, estado, fecha_oficio, nro_expediente_judicial, planificacion, evaluacion) FROM stdin;
55	\N	1	\N	\N	2015-08-03 00:00:00	2015-08-03	4	SFE 2015 00052	t	lugar	2015-07-30	persona	lugar hecho	2015-07-29	encuadre	ley	\N	2015-08-03	\N	\N	\N	Presentación Expontanea	\N	Telefónica	un motivo	algo algo	Defensoría del Pueblo	\N	SANTA FE	Legal	3	31	38	39	2	5	1	\N	t	0	\N	1	\N	\N
56	\N	\N	\N	\N	2015-08-03 00:00:00	2015-08-03	6	SFE 2015 00053	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-08-03	\N	\N	\N	Presentación Expontanea	\N	Personal	\N	dasdasda	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	2	\N	\N
57	\N	\N	\N	\N	2015-08-03 00:00:00	2015-08-03	5	SFE 2015 00054	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-08-03	\N	\N	\N	Presentación Expontanea	\N	Personal	\N	GSDFGSDGSDFF	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	3	\N	\N
58	\N	\N	\N	\N	2015-08-03 00:00:00	2015-08-03	5	SFE 2015 00055	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-08-03	\N	\N	\N	Presentación Expontanea	\N	Personal	\N	gsfgsdgsd	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	4	\N	\N
59	\N	\N	\N	\N	2015-08-03 00:00:00	2015-08-03	5	SFE 2015 00056	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-08-03	\N	\N	\N	Presentación Expontanea	\N	Personal	\N	rewqgfsd	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	6	\N	\N
60	\N	\N	\N	\N	2015-08-03 00:00:00	2015-08-03	6	SFE 2015 00057	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-08-03	\N	\N	\N	Presentación Expontanea	\N	Personal	\N	dfas	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	8	\N	\N
61	\N	\N	\N	\N	2015-08-03 00:00:00	2015-08-03	5	SFE 2015 00058	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-08-03	\N	\N	\N	Presentación Expontanea	\N	Personal	\N	gfsd	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	9	\N	\N
63	\N	\N	\N	\N	2015-08-24 00:00:00	2015-08-24	1	SFE 2015 00060	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-08-24	\N	\N	\N	Derivación	\N	Personal	mot consulta	observo	Ministerio de Educación	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	2015-08-24 00:00:00	f	0	\N	10	\N	\N
42	\N	\N	\N	\N	2015-07-31 00:00:00	2015-07-31	5	SFE 2015 00039	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-31	\N	\N	\N	Presentación Expontanea	\N	Correo Electrónico	\N	chau chau chau	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	14	\N	\N
43	\N	\N	\N	\N	2015-07-31 00:00:00	2015-07-31	3	SFE 2015 00040	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-31	\N	\N	\N	Derivación	\N	Telefónica	\N	mal mal mal	Defensoría del Pueblo	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-29 00:00:00	f	0	\N	15	\N	\N
44	\N	\N	\N	\N	2015-07-31 00:00:00	2015-07-31	1	SFE 2015 00041	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-31	\N	\N	\N	Derivación	\N	Personal	\N	dsadsadsa	Defensoría del Pueblo	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-14 00:00:00	f	0	\N	16	\N	\N
47	\N	\N	\N	\N	2015-07-31 00:00:00	2015-07-31	6	SFE 2015 00044	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-31	\N	\N	\N	Presentación Expontanea	\N	Correo Electrónico	\N	dwdadw	\N	\N	SANTA FE	Legal	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	19	\N	\N
48	\N	\N	\N	\N	2015-07-31 00:00:00	2015-07-31	6	SFE 2015 00045	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-31	\N	\N	\N	Presentación Expontanea	\N	Personal	\N	oooooo	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	20	\N	\N
49	\N	\N	\N	\N	2015-07-31 00:00:00	2015-07-31	3	SFE 2015 00046	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-31	\N	\N	\N	Derivación	\N	Correo Electrónico	\N	ssdfsdfsdf	Defensoría del Pueblo	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-01 00:00:00	f	0	\N	21	\N	\N
50	\N	\N	\N	\N	2015-07-31 00:00:00	2015-07-31	6	SFE 2015 00047	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-31	\N	\N	\N	Presentación Expontanea	\N	Personal	hghdfhdfhdf	rtrtrtrtrtrtrt	Ministerio de Educación	\N	SANTA FE	Asistencia psicologica	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	22	\N	\N
51	\N	\N	\N	\N	2015-07-31 00:00:00	2015-07-31	6	SFE 2015 00048	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-31	\N	\N	\N	Derivación	\N	Personal	rrrrrrrrrrrrr	wwwwwwwwwwwwwwwww	Ministerio de Educación	Escuela Publica/Privada	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-22 00:00:00	f	0	\N	23	\N	\N
52	\N	\N	\N	\N	2015-07-31 00:00:00	2015-07-31	5	SFE 2015 00049	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-31	\N	\N	\N	Presentación Expontanea	\N	Personal	\N	eeeeeeeeeeeeeeeeeeee	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	24	\N	\N
53	\N	\N	\N	\N	2015-07-31 00:00:00	2015-07-31	5	SFE 2015 00050	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-31	\N	\N	\N	Presentación Expontanea	\N	Personal	\N	observo\nobservo\nobservo	\N	\N	SANTA FE	Legal	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	26	\N	\N
54	\N	\N	\N	\N	2015-08-03 00:00:00	2015-08-03	3	SFE 2015 00051	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-08-03	\N	\N	\N	Presentación Expontanea	\N	Personal	\N	xzasd	\N	\N	SANTA FE	Legal	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	27	\N	\N
62	\N	\N	\N	\N	2015-08-24 00:00:00	2015-08-24	6	SFE 2015 00059	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-08-24	\N	\N	\N	Derivación	\N	Personal	CONSULTA	\N	Ministerio de Educación	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	2015-08-17 00:00:00	f	0	\N	28	\N	\N
38	\N	\N	\N	\N	2015-07-29 00:00:00	2015-07-29	3	SFE 2015 00035	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-29	\N	\N	\N	Presentación Expontanea	\N	Personal	\N	No hay	\N	\N	SANTA FE	Asistencia psicologica	\N	\N	\N	\N	\N	\N	\N	\N	f	1	\N	31	\N	\N
66	\N	\N	\N	\N	2015-09-10 00:00:00	\N	\N	SFE 2015 00063	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Presentación Expontanea	\N	Personal	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	35	\N	\N
68	\N	\N	\N	\N	2015-09-10 00:00:00	\N	\N	SFE 2015 00065	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Presentación Expontanea	\N	Personal	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	36	\N	\N
72	\N	\N	\N	\N	2015-09-13 00:00:00	2015-09-13	8	SFE 2015 00069	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-09-13	\N	\N	\N	De Oficio	\N	\N	Probar el sistema	caso de prueba	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	37	\N	\N
73	\N	\N	\N	\N	2015-09-14 00:00:00	2015-09-14	\N	SFE 2015 00070	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-09-14	\N	\N	\N	Oficio Judicial	\N	\N	causa del oficio	algo mas del oficio	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	38	\N	\N
74	\N	\N	\N	\N	2015-09-14 00:00:00	2015-09-14	\N	SFE 2015 00071	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-09-14	\N	\N	\N	Oficio Judicial	\N	\N	dfas	fdasfsadf	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	39	\N	\N
75	\N	\N	\N	\N	2015-09-14 00:00:00	2015-09-14	\N	SFE 2015 00072	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-09-14	\N	\N	\N	Oficio Judicial	\N	\N	motivo oficial	te observo	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	2015-09-15	45451/2015	\N	\N
76	\N	\N	\N	\N	2015-09-14 00:00:00	2015-09-14	\N	SFE 2015 00073	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-09-14	\N	\N	\N	Oficio Judicial	\N	\N	fasdf	fasdf	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	2015-09-17	fdasfas	\N	\N
77	\N	\N	\N	\N	2015-09-22 00:00:00	\N	\N	SFE 2015 00074	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
30	\N	\N	\N	\N	2015-07-17 00:00:00	2015-07-17	3	SFE 2015 00027	t	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-17	\N	\N	\N	Presentación Espontanea	\N	\N	\N	Observo el sistema	Defensoría del Pueblo	\N	SANTA FE	Asistencia psicologica	3	31	33	\N	3	2	\N	\N	t	1	\N	30	\N	\N
79	\N	\N	\N	\N	2015-10-09 00:00:00	\N	\N	SFE 2015 00076	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
78	\N	\N	\N	\N	2015-10-08 00:00:00	2015-10-08	13	SFE 2015 00075	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-08	\N	\N	\N	De Oficio	\N	\N	\N	Esto es un comentario	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
80	\N	\N	\N	\N	2015-10-09 00:00:00	2015-10-09	\N	SFE 2015 00077	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-09	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
81	\N	\N	\N	\N	2015-10-09 00:00:00	2015-10-09	\N	SFE 2015 00078	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-09	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
82	\N	\N	\N	\N	2015-10-09 00:00:00	2015-10-09	\N	SFE 2015 00079	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-09	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
83	\N	\N	\N	\N	2015-10-09 00:00:00	2015-10-09	\N	SFE 2015 00080	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-09	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
84	\N	\N	\N	\N	2015-10-09 00:00:00	2015-10-09	\N	SFE 2015 00081	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-09	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
85	\N	\N	\N	\N	2015-10-09 00:00:00	2015-10-09	\N	SFE 2015 00082	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-09	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
86	\N	\N	\N	\N	2015-10-09 00:00:00	2015-10-09	\N	SFE 2015 00083	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-09	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
41	\N	\N	\N	\N	2015-07-31 00:00:00	2015-07-31	4	SFE 2015 00038	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-31	\N	\N	\N	Presentación Expontanea	\N	Telefónica	\N	prueba2	\N	\N	SANTA FE	Asistencia psicologica	\N	\N	\N	\N	\N	\N	\N	\N	f	1	\N	13	\N	\N
39	\N	\N	\N	\N	2015-07-31 00:00:00	2015-07-31	6	SFE 2015 00036	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-31	\N	\N	\N	Presentación Expontanea	\N	Personal	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	1	\N	11	\N	\N
40	\N	\N	\N	\N	2015-07-31 00:00:00	2015-07-31	4	SFE 2015 00037	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-31	\N	\N	\N	Derivación	\N	Personal	\N	hhhh	INADI	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-31 00:00:00	f	1	\N	12	\N	\N
46	\N	\N	\N	\N	2015-07-31 00:00:00	2015-07-31	1	SFE 2015 00043	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-31	\N	\N	\N	Presentación Expontanea	\N	Personal	\N	gsgerg	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	1	\N	18	\N	\N
45	\N	\N	\N	\N	2015-07-31 00:00:00	2015-07-31	1	SFE 2015 00042	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-31	\N	\N	\N	Derivación	\N	Personal	\N	dfgsfefzds	Defensoría del Pueblo	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-01 00:00:00	f	1	\N	17	\N	\N
33	\N	\N	\N	\N	2015-07-23 00:00:00	2015-07-23	6	SFE 2015 00030	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-23	\N	\N	\N	Presentación Espontanea	\N	Personal	\N	\N	\N	\N	SANTA FE	Asistencia psicologica	\N	\N	\N	\N	\N	\N	\N	\N	f	2	\N	32	\N	\N
35	\N	\N	\N	\N	2015-07-23 00:00:00	2015-07-23	4	SFE 2015 00032	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-23	\N	\N	\N	Presentación Expontanea	\N	Personal	\N	\N	\N	\N	SANTA FE	Legal	\N	\N	\N	\N	\N	\N	\N	\N	f	1	\N	7	\N	hgkhg
36	\N	\N	\N	\N	2015-07-23 00:00:00	2015-07-23	6	SFE 2015 00033	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-23	\N	\N	\N	Derivación	\N	Personal	\N	Te observo	Organismos nacionales	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-08 00:00:00	f	1	\N	33	\N	\N
37	\N	\N	\N	\N	2015-07-27 00:00:00	2015-07-27	3	SFE 2015 00034	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-27	\N	\N	\N	Presentación Expontanea	\N	Personal	\N	asdwdasd	Ministerio de Seguridad	\N	SANTA FE	Simple	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	25	\N	\N
87	\N	\N	\N	\N	2015-10-09 00:00:00	2015-10-09	\N	SFE 2015 00084	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-09	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
88	\N	\N	\N	\N	2015-10-09 00:00:00	2015-10-09	\N	SFE 2015 00085	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-09	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
89	\N	\N	\N	\N	2015-10-09 00:00:00	2015-10-09	\N	SFE 2015 00086	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-09	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
90	\N	\N	\N	\N	2015-10-09 00:00:00	2015-10-09	\N	SFE 2015 00087	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-09	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
91	\N	\N	\N	\N	2015-10-09 00:00:00	2015-10-09	\N	SFE 2015 00088	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-09	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
92	\N	\N	\N	\N	2015-10-09 00:00:00	2015-10-09	\N	SFE 2015 00089	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-09	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
93	\N	\N	\N	\N	2015-10-09 00:00:00	2015-10-09	\N	SFE 2015 00090	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-09	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
94	\N	\N	\N	\N	2015-10-09 00:00:00	2015-10-09	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-09	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
95	\N	\N	\N	\N	2015-10-09 00:00:00	2015-10-09	\N	SFE 2015 00092	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-09	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
96	\N	\N	\N	\N	2015-10-09 00:00:00	2015-10-09	\N	SFE 2015 00093	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-09	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
97	\N	\N	\N	\N	2015-10-09 00:00:00	2015-10-09	\N	SFE 2015 00094	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-09	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
98	\N	\N	\N	\N	2015-10-09 00:00:00	2015-10-09	\N	SFE 2015 00095	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-09	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
99	\N	\N	\N	\N	2015-10-12 00:00:00	2015-10-12	\N	SFE 2015 00096	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-12	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
100	\N	\N	\N	\N	2015-10-12 00:00:00	2015-10-12	\N	SFE 2015 00097	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-12	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
101	\N	\N	\N	\N	2015-10-12 00:00:00	2015-10-12	\N	SFE 2015 00098	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-12	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
102	\N	\N	\N	\N	2015-10-12 00:00:00	2015-10-12	\N	SFE 2015 00099	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-12	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
103	\N	\N	\N	\N	2015-10-12 00:00:00	2015-10-12	\N	SFE 2015 00100	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-12	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
104	\N	\N	\N	\N	2015-10-12 00:00:00	2015-10-12	\N	SFE 2015 00101	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-12	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
105	\N	\N	\N	\N	2015-10-12 00:00:00	2015-10-12	\N	SFE 2015 00102	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-12	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
106	\N	\N	\N	\N	2015-10-12 00:00:00	2015-10-12	\N	SFE 2015 00103	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-12	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
107	\N	\N	\N	\N	2015-10-12 00:00:00	2015-10-12	\N	SFE 2015 00104	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-12	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
108	\N	\N	\N	\N	2015-10-12 00:00:00	2015-10-12	\N	SFE 2015 00105	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-12	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
109	\N	\N	\N	\N	2015-10-12 00:00:00	2015-10-12	\N	SFE 2015 00106	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-12	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
110	\N	\N	\N	\N	2015-10-12 00:00:00	2015-10-12	\N	SFE 2015 00107	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-12	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
111	\N	\N	\N	\N	2015-10-12 00:00:00	2015-10-12	\N	SFE 2015 00108	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-12	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
112	\N	\N	\N	\N	2015-10-13 00:00:00	2015-10-13	\N	SFE 2015 00109	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-13	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
113	\N	\N	\N	\N	2015-10-14 00:00:00	2015-10-14	\N	SFE 2015 00110	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-14	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
114	\N	\N	\N	\N	2015-10-15 00:00:00	2015-10-15	\N	SFE 2015 00111	f	\N	\N	\N	\N	\N	VF 11.529	Medida de protección	\N	2015-10-15	\N	\N	\N	Presentación Expontanea	\N	Presencial	Relata que sufre violencia por parte de su pareja. Solicita asesoramiento legal, social y psicológico.	\N	\N	\N	SANTA FE	\N	2	19	10	5	1	2	3	\N	t	0	\N	\N	\N	\N
115	\N	\N	\N	\N	2015-10-15 00:00:00	2015-10-15	\N	SFE 2015 00112	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-15	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
116	\N	\N	\N	\N	2015-10-15 00:00:00	2015-10-15	\N	SFE 2015 00113	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-15	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
117	\N	\N	\N	\N	2015-10-16 00:00:00	2015-10-16	14	SFE 2015 00114	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-16	\N	\N	\N	De Oficio	\N	\N	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
118	\N	\N	\N	\N	2015-10-16 00:00:00	2015-10-16	\N	SFE 2015 00115	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-16	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
119	\N	\N	\N	\N	2015-10-16 00:00:00	2015-10-16	\N	SFE 2015 00116	t	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-16	\N	\N	\N	Presentación Expontanea	\N	Presencial	Solicita asesoramiento legal, apoyo psicológico y asistencia social.	\N	\N	\N	SANTA FE	\N	2	73	\N	\N	2	1	3	\N	t	0	\N	\N	Tratamiento psi, gestionar documentación, consulta expte judicial.	\N
34	\N	\N	\N	\N	2015-07-23 00:00:00	2015-07-23	5	SFE 2015 00031	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-23	\N	\N	\N	Derivación	\N	Personal	\N	\N	Municipalidad	Adultos Mayores	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-14 00:00:00	f	1	\N	5	\N	\N
123	\N	\N	\N	\N	2015-10-23 00:00:00	2015-10-23	1	SFE 2015 00120	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-23	\N	\N	\N	De Oficio	\N	\N	consulta	ooo	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
124	\N	\N	\N	\N	2015-10-23 00:00:00	2015-10-23	8	SFE 2015 00121	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-23	\N	\N	\N	De Oficio	\N	\N	otro	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
120	\N	\N	\N	\N	2015-10-21 00:00:00	2015-10-21	\N	SFE 2015 00117	t	en la comisaria 10	2015-10-14	La víctima	En el domicilio de la víctima	2015-10-13	Ley de protección integral para la mujer	26.485	\N	2015-10-21	\N	\N	\N	Presentación Expontanea	\N	Presencial	Refiere violencia por parte de su ex-pareja. Solicita asesoramiento legal, apoyo psicológico y social.	ninguna	\N	\N	SANTA FE	\N	2	10	19	24	1	2	3	\N	t	0	\N	\N	Averiguación de estado de la denuncia, fortalecimiento psi y contactar redes familiares.	\N
121	\N	\N	\N	\N	2015-10-23 00:00:00	2015-10-23	8	SFE 2015 00118	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-23	\N	\N	\N	De Oficio	\N	\N	anda	observaciones	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
122	\N	\N	\N	\N	2015-10-23 00:00:00	2015-10-23	\N	SFE 2015 00119	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-23	\N	\N	\N	Derivación	\N	Presencial	motivo	Observo	Municipalidad	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-07 00:00:00	f	0	\N	\N	\N	\N
130	\N	\N	\N	\N	2015-11-15 00:00:00	2015-11-12	9	SFE 2015 00127	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-11-12	\N	\N	\N	De Oficio	\N	\N	motivo de exp	obser	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
125	\N	\N	\N	\N	2015-10-23 00:00:00	2015-10-23	\N	SFE 2015 00122	t	Comisaria 10	2015-10-21	la víctima	en la casa de pepe a las 5 am	2015-10-14	Ley 11.529	Medida de protección, medida de distancia.	\N	2015-10-23	\N	\N	\N	Presentación Expontanea	\N	Presencial	Refiere Violencia por parte de su pareja.	Pide que no le comentemos a familiares cercanos lo que esta pasando. Se observaron delirios paranoides. Usa lentes.	\N	\N	SANTA FE	\N	2	10	19	28	2	1	3	\N	t	0	\N	\N	Se va a realizar una averiguación en comisaria sobre la denuncia. Tto psi en relación a límites vinculares. apoyo social.	\N
126	\N	\N	\N	\N	2015-10-23 00:00:00	2015-10-23	\N	SFE 2015 00123	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-10-23	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
131	\N	\N	\N	\N	2015-11-12 00:00:00	2015-11-12	\N	SFE 2015 00128	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-11-12	\N	\N	\N	Derivación	\N	Presencial	motivo de derivación y exp	se derivo por ....	Defensoría del Pueblo	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	2015-11-12 00:00:00	f	0	\N	\N	\N	\N
127	\N	\N	\N	\N	2015-11-04 00:00:00	2015-11-04	\N	SFE 2015 00124	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-11-04	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
128	\N	\N	\N	\N	2015-11-22 00:00:00	2015-11-06	22	SFE 2015 00125	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-11-06	\N	\N	\N	De Oficio	\N	\N	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
132	\N	\N	\N	\N	2015-11-12 00:00:00	2015-11-12	\N	SFE 2015 00129	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-11-12	\N	\N	\N	Oficio Judicial	\N	\N	algun motivo	obser	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	2015-11-02	12-35847	\N	\N
31	\N	1	\N	\N	2015-07-17 00:00:00	2015-07-17	6	SFE 2015 00028	t	acá nomas	2015-10-19	\N	\N	\N	\N	\N	\N	2015-07-17	\N	\N	\N	Presentación Espontanea	\N	\N	motivo-motivo	Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"	\N	\N	SANTA FE	Asistencia psicologica	3	35	\N	\N	2	5	1	\N	t	1	\N	34	Etapa de planificación	\N
129	\N	\N	\N	\N	2015-11-11 00:00:00	2015-11-11	\N	SFE 2015 00126	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-11-11	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
133	\N	\N	\N	\N	2015-11-12 00:00:00	2015-11-12	\N	SFE 2015 00130	t	lugar de radicacion	2015-11-01	una persona	policia	2015-11-01	encuadre	aplicación	\N	2015-11-12	\N	\N	\N	Presentación Expontanea	\N	Presencial	alguno	observaciones	Defensoría del Pueblo	Salud	SANTA FE	\N	3	31	33	34	3	2	5	\N	t	0	\N	\N	plan y diseño	asdasdasd\nasdasd\nadsasdasdadadsadsads\nasdasdasd
134	\N	\N	\N	\N	2015-12-22 00:00:00	2015-12-22	\N	SFE 2015 00131	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-12-22	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
135	\N	\N	\N	\N	2016-01-21 00:00:00	2016-01-21	\N	SFE 2016 00132	f	\N	\N	\N	\N	\N	\N	\N	\N	2016-01-21	\N	\N	\N	Oficio Judicial	\N	\N	asdasd	holadsafwse	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	2016-01-21	2165484	\N	\N
136	\N	\N	\N	\N	2016-01-25 00:00:00	2016-01-25	3	SFE 2016 00133	f	\N	\N	\N	\N	\N	\N	\N	\N	2016-01-25	\N	\N	\N	De Oficio	\N	\N	asd	asd	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
137	\N	\N	\N	\N	2016-01-25 00:00:00	2016-01-25	\N	SFE 2016 00134	f	\N	\N	\N	\N	\N	\N	\N	\N	2016-01-25	\N	\N	\N	Derivación	\N	Presencial	asd	asd	Ministerio de Desarrollo Social	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	2016-01-25 00:00:00	f	0	\N	\N	\N	\N
138	\N	\N	\N	\N	2016-01-25 00:00:00	2016-01-25	\N	SFE 2016 00135	f	\N	\N	\N	\N	\N	\N	\N	\N	2016-01-25	\N	\N	\N	Oficio Judicial	\N	\N	asd	asd	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	2016-01-26	2323	\N	\N
32	\N	\N	\N	\N	2015-07-21 00:00:00	2015-07-21	1	SFE 2015 00029	f	\N	\N	\N	\N	\N	\N	\N	\N	2015-07-21	\N	\N	\N	Presentación Espontanea	\N	Personal	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	1	\N	29	\N	Otra evaluación
139	\N	\N	\N	\N	2016-02-01 00:00:00	2016-02-01	12	SFE 2016 00136	f	\N	\N	\N	\N	\N	\N	\N	\N	2016-02-01	\N	\N	\N	De Oficio	\N	\N	le paso algo.\nle paso a alguien.\nQue mas	Esta es una observacional.\nEsta es otra observación.	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
140	\N	\N	\N	\N	2016-02-01 00:00:00	2016-02-01	9	SFE 2016 00137	f	\N	\N	\N	\N	\N	\N	\N	\N	2016-02-01	\N	\N	\N	De Oficio	\N	\N	pepe\npepe\nfofofof\nfofof	algo\nalgo\nalgo	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
141	\N	\N	\N	\N	2016-02-01 00:00:00	2016-02-01	\N	SFE 2016 00138	f	\N	\N	\N	\N	\N	\N	\N	\N	2016-02-01	\N	\N	\N	Presentación Expontanea	\N	Presencial	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
142	\N	\N	\N	\N	2016-02-01 00:00:00	2016-02-01	22	SFE 2016 00139	f	\N	\N	\N	\N	\N	\N	\N	\N	2016-02-01	\N	\N	\N	De Oficio	\N	\N	fasd\nfad\nfdas\nfd	ºfa\nfas\nfda\nsd	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
143	\N	\N	\N	\N	2016-02-01 00:00:00	2016-02-01	8	SFE 2016 00140	f	\N	\N	\N	\N	\N	\N	\N	\N	2016-02-01	\N	\N	\N	De Oficio	\N	\N	fsadf	fdsafsa	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
144	\N	\N	\N	\N	2016-02-01 00:00:00	2016-02-01	11	SFE 2016 00141	f	\N	\N	\N	\N	\N	\N	\N	\N	2016-02-01	\N	\N	\N	De Oficio	\N	\N	\N	\N	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
145	\N	\N	\N	\N	2016-02-01 00:00:00	2016-02-01	11	SFE 2016 00142	f	\N	\N	\N	\N	\N	\N	\N	\N	2016-02-01	\N	\N	\N	De Oficio	\N	\N	ffffffffffffff	fffffffffffff\nfrrrrrrrrrrrrr\ngggggggggggggggg	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
147	\N	\N	\N	\N	2016-02-05 00:00:00	2016-02-05	22	SFE 2016 00144	f	\N	\N	\N	\N	\N	\N	\N	\N	2016-02-05	\N	\N	\N	De Oficio	\N	\N	aaaaaa	bbbbbbbbb	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
148	\N	\N	\N	\N	2016-02-05 00:00:00	2016-02-05	22	SFE 2016 00145	f	\N	\N	\N	\N	\N	\N	\N	\N	2016-02-05	\N	\N	\N	De Oficio	\N	\N	dddddddddd	ppppppppppppppp	\N	\N	SANTA FE	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	0	\N	\N	\N	\N
\.


--
-- Name: expedientes_nro_expediente_judicial_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('expedientes_nro_expediente_judicial_seq', 39, true);


--
-- Name: expedientes_origen_presentacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('expedientes_origen_presentacion_seq', 4, true);


--
-- Data for Name: generos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY generos (id, nombre) FROM stdin;
2	Mujer
3	Varón Trans
1	Varón
4	Mujer Trans
5	Intersex
\.


--
-- Data for Name: grupos_trabajos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY grupos_trabajos (id, id_personal, id_expediente, activo, primera_entrevista) FROM stdin;
7	3	31	t	t
8	6	31	t	t
9	1	31	t	t
10	4	37	t	t
11	3	37	t	t
12	6	37	t	t
13	4	30	t	t
14	4	55	t	t
15	1	55	t	t
16	4	63	t	t
17	6	62	t	t
18	4	62	t	f
19	1	66	t	t
20	1	68	t	t
21	1	72	t	t
22	6	73	t	t
23	6	74	t	t
24	5	75	t	t
25	5	76	t	t
26	5	77	t	t
27	6	78	t	t
28	4	79	t	t
29	\N	80	t	t
30	\N	81	t	t
31	\N	82	t	t
32	\N	83	t	t
33	\N	84	t	t
34	\N	85	t	t
35	\N	86	t	t
36	\N	87	t	t
37	\N	88	t	t
38	\N	89	t	t
39	\N	90	t	t
40	3	91	t	t
41	4	92	t	t
42	4	93	t	t
43	4	94	t	t
44	3	94	t	t
46	3	95	t	t
47	3	96	t	t
48	4	97	t	t
49	1	98	t	t
50	3	99	t	t
51	3	100	t	t
52	3	101	t	t
53	1	102	t	t
54	3	103	t	t
55	1	104	t	t
56	13	105	t	t
57	3	106	t	t
58	3	107	t	t
59	11	108	t	t
60	4	109	t	t
61	3	110	t	t
62	3	111	t	t
63	4	112	t	t
64	4	113	t	t
65	19	114	t	t
66	20	114	t	t
67	3	115	t	t
68	12	116	t	t
69	18	117	t	t
70	1	118	t	t
71	21	119	t	t
72	12	119	t	t
73	15	119	t	t
74	16	120	t	t
75	9	120	t	t
76	15	120	t	t
78	12	120	t	f
79	4	121	t	t
80	4	122	t	t
81	4	123	t	t
82	11	124	t	t
83	1	125	t	t
84	9	125	t	t
85	14	125	t	f
86	9	125	t	f
87	3	126	t	t
88	16	127	t	t
89	11	128	t	t
90	9	129	t	t
91	14	130	t	t
92	11	131	t	t
93	9	132	t	t
94	10	133	t	t
95	9	133	t	f
96	13	134	t	t
97	4	135	t	t
98	6	136	t	t
99	6	137	t	t
100	6	138	t	t
101	4	139	t	t
102	3	140	t	t
103	13	141	t	t
104	12	142	t	t
105	14	143	t	t
106	17	144	t	t
107	16	145	t	t
108	1	147	t	t
109	17	148	t	t
\.


--
-- Data for Name: instituciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY instituciones (id, nombre, direccion, telefonos) FROM stdin;
3	Institución 3	\N	\N
4	Institución 4	\N	\N
5	Institución 5	\N	\N
1	Facebook	\N	\N
2	Tweeter	\N	\N
\.


--
-- Name: instituciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('instituciones_id_seq', 5, true);


--
-- Data for Name: intervenciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY intervenciones (id, id_expediente, id_tipo, fecha, observaciones, quien) FROM stdin;
1	31	6	2015-07-16	\N	\N
2	31	4	2015-07-17	a él	yo
3	33	4	2015-07-25	\N	\N
4	33	6	2015-07-17	\N	\N
5	33	16	2015-07-09	\N	\N
6	33	2	2015-07-15	\N	\N
7	31	14	2015-07-16	\N	\N
8	37	4	2015-07-17	zxs	ssss
9	37	3	2015-07-13	aaa	aaa
10	30	12	2015-08-12	\N	\N
11	55	1	2015-08-03	victima	profesional
12	55	5	2015-08-03	entidad	grupo profesional
13	32	6	2015-09-07	\N	\N
14	62	13	2015-09-04	\N	\N
15	114	1	2015-10-16	\N	\N
20	120	1	2015-10-21	\N	Nadalich, Asensio, Miniti
21	120	30	2015-10-21	\N	Miniti
22	120	28	2015-10-21	\N	Nadalich
23	120	12	2015-10-21	\N	\N
24	125	26	2015-10-23	\N	\N
25	125	15	2015-10-23	\N	Maria Laura
26	125	5	2015-10-23	\N	\N
27	125	4	2015-10-24	\N	\N
28	133	1	2015-11-12	\N	profesional
29	133	15	2015-11-16	\N	\N
30	133	6	2015-11-17	\N	\N
\.


--
-- Data for Name: intituciones_expediente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY intituciones_expediente (id, id_institucion, id_expediente, accion, observaciones, referente, organismo, direccion, telefono) FROM stdin;
1	1	31	1	aa	Sr Director	Ministerio de Desarrollo Social	sa	222222222
31	\N	129	1	gggggg	dsfsdf	Ministerio de Salud	asdasd	\N
32	\N	32	1	,kjh	jlkjhlk	Ministerio de Desarrollo Social	\N	\N
\.


--
-- Name: intituciones_expediente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('intituciones_expediente_id_seq', 32, true);


--
-- Data for Name: localidades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY localidades (id, nombre, nombre_abreviado, id_dpto_partido, ddn) FROM stdin;
5482998	Indeterminada	Indeterminada	5482998	\N
5482007	Indeterminada	Indeterminada	5482007	\N
5482014	Indeterminada	Indeterminada	5482014	\N
5482021	Indeterminada	Indeterminada	5482021	\N
5482028	Indeterminada	Indeterminada	5482028	\N
5482035	Indeterminada	Indeterminada	5482035	\N
5482042	Indeterminada	Indeterminada	5482042	\N
5482049	Indeterminada	Indeterminada	5482049	\N
5482056	Indeterminada	Indeterminada	5482056	\N
5482063	Indeterminada	Indeterminada	5482063	\N
5482070	Indeterminada	Indeterminada	5482070	\N
5482077	Indeterminada	Indeterminada	5482077	\N
5482084	Indeterminada	Indeterminada	5482084	\N
5482091	Indeterminada	Indeterminada	5482091	\N
5482098	Indeterminada	Indeterminada	5482098	\N
5482105	Indeterminada	Indeterminada	5482105	\N
5482112	Indeterminada	Indeterminada	5482112	\N
5482119	Indeterminada	Indeterminada	5482119	\N
5482126	Indeterminada	Indeterminada	5482126	\N
5482133	Indeterminada	Indeterminada	5482133	\N
1272	LA CERAMICA Y CUYO	LA CERAMICA Y CUYO	5482084	\N
1273	ROSARIO	ROSARIO	5482084	341
1276	ALBARELLOS	ALBARELLOS	5482084	3402
1277	MONTE FLORES	MONTE FLORES	5482084	\N
1278	VILLA AMELIA	VILLA AMELIA	5482084	3402
1280	COLONIA ESCRIBANO	COLONIA ESCRIBANO	5482084	\N
1281	CORONEL BOGADO (EX PUEBLO NAVA	CORONEL BOGADO (EX PUEBLO NAVARRO)	5482084	3402
1282	JUAN B. MOLINA	JUAN B. MOLINA	5482028	3460
1285	STEPHENSON	STEPHENSON	5482028	\N
1286	CAÑADA RICA	CAÑADA RICA	5482028	3460
1287	CEPEDA	CEPEDA	5482028	3460
1289	CORONEL RODOLFO S. DOMINGUEZ	CORONEL RODOLFO S. DOMINGUEZ	5482084	3402
1290	EL CARAMELO	EL CARAMELO	5482084	\N
1291	ESTANCIA LA MARIA	ESTANCIA LA MARIA	5482084	\N
1292	LA CAROLINA	LA CAROLINA	5482084	\N
1293	LA VANGUARDIA	LA VANGUARDIA	5482028	3460
1294	LOS MUCHACHOS	LOS MUCHACHOS	5482028	\N
1295	PEREYRA LUCENA	PEREYRA LUCENA	5482084	\N
1296	SARGENTO CABRAL	SARGENTO CABRAL	5482028	3460
1297	URANGA	URANGA	5482084	3469
1298	ZAMPONI	ZAMPONI	5482084	\N
1299	ALVAREZ	ALVAREZ	5482084	3402
1300	ESTANCIA SAN ANTONIO	ESTANCIA SAN ANTONIO	5482084	\N
1301	SOLDINI	SOLDINI	5482084	341
1302	ACEBAL	ACEBAL	5482084	3469
1303	CAMPO RUEDA	CAMPO RUEDA	5482028	\N
1304	CARMEN DEL SAUCE	CARMEN DEL SAUCE	5482084	3469
1305	PAVON ARRIBA	PAVON ARRIBA	5482028	3469
1306	FRANCISCO PAZ	FRANCISCO PAZ	5482028	\N
1307	SANTA TERESA	SANTA TERESA	5482028	\N
1308	PEYRANO	PEYRANO	5482028	3460
1310	COLONIA VALDEZ	COLONIA VALDEZ	5482028	\N
1311	LA CELIA	LA CELIA	5482028	\N
1312	LA OTHILA	LA OTHILA	5482028	\N
1313	MAXIMO PAZ	MAXIMO PAZ	5482028	3460
1314	RODOLFO ALCORTA	RODOLFO ALCORTA	5482028	\N
1315	ALCORTA	ALCORTA	5482028	3465
1316	LOMA VERDE	LOMA VERDE	5482028	\N
1317	ARMINDA	ARMINDA	5482084	3469
1318	BENARD	BENARD	5482084	\N
1319	ERASTO	ERASTO	5482084	\N
1320	MAIZALES	MAIZALES	5482119	3469
1321	PIÑERO	PIÑERO	5482084	3402
1322	PUEBLO MUÑOZ	PUEBLO MUÑOZ	5482084	3469
1323	PEREZ	PEREZ	5482084	341
1324	SAN SEBASTIAN	SAN SEBASTIAN	5482084	\N
1326	VILLA AMERICA	VILLA AMERICA	5482084	\N
1328	CAMPO CALVO	CAMPO CALVO	5482084	\N
1329	COLONIA CLODOMIRA	COLONIA CLODOMIRA	5482119	\N
1330	CORONEL ARNOLD	CORONEL ARNOLD	5482119	341
1331	FUENTES	FUENTES	5482119	3464
1332	PUJATO	PUJATO	5482119	3464
1333	VILLA PORUCCI	VILLA PORUCCI	5482119	\N
1334	ZAVALLA	ZAVALLA	5482084	341
1336	CORONEL AGUIRRE	CORONEL AGUIRRE	5482084	341
1337	PUEBLO NUEVO	PUEBLO NUEVO	5482077	341
1338	VEINTIDOS DE AGOSTO	VEINTIDOS DE AGOSTO	5482084	\N
1340	VILLA GOBERNADOR GALVEZ	VILLA GOBERNADOR GALVEZ	5482084	341
1341	VILLA SAN DIEGO	VILLA SAN DIEGO	5482084	\N
1342	ALVEAR	ALVEAR	5482084	341
1343	CAMINO MONTE FLORES	CAMINO MONTE FLORES	5482084	\N
1344	CRESTA	CRESTA	5482084	\N
1345	FIGHIERA	FIGHIERA	5482084	3402
1346	GENERAL LAGOS	GENERAL LAGOS	5482084	3402
1347	LA LATA	LA LATA	5482084	\N
1348	PUEBLO ESTHER	PUEBLO ESTHER	5482084	3402
1349	ARROYO SECO	ARROYO SECO	5482084	3402
1352	FUNES	FUNES	5482084	341
1354	LICEO AERONAUTICO MILITAR	LICEO AERONAUTICO MILITAR	5482084	\N
1356	ROLDAN	ROLDAN	5482119	341
1357	SAN GERONIMO	SAN GERONIMO	5482119	\N
1358	SAN JERONIMO SUD	SAN JERONIMO SUD	5482119	341
1359	CARCARAÑA	CARCARAÑA	5482119	\N
1360	COLONIA EL CARMEN	COLONIA EL CARMEN	5482119	341
1362	CAMPO MEDINA	CAMPO MEDINA	5482056	\N
1364	IBARLUCEA	IBARLUCEA	5482084	341
1366	LA SALADA	LA SALADA	5482119	\N
1367	LUCIO V. LOPEZ	LUCIO V. LOPEZ	5482056	3476
1368	LUIS PALACIOS	LUIS PALACIOS	5482119	3476
1369	SALTO GRANDE	SALTO GRANDE	5482056	3493
1370	SANTA TERESA	SANTA TERESA	5482056	3460
1372	CAMPO HORQUESCO	CAMPO HORQUESCO	5482056	\N
1373	COLONIA MEDICI	COLONIA MEDICI	5482056	\N
1374	LARGUIA	LARGUIA	5482056	\N
1375	TOTORAS	TOTORAS	5482056	3493
1376	CLASON	CLASON	5482056	3471
1377	LOS LEONES	LOS LEONES	5482056	\N
1378	SAN GENARO	SAN GENARO	5482105	3401
1379	SAN GENARO NORTE	SAN GENARO NORTE	5482105	3401
1380	VILLA BIOTA	VILLA BIOTA	5482105	\N
1381	CAMPO CASTRO	CAMPO CASTRO	5482126	\N
1382	CASAS	CASAS	5482126	3401
1383	CENTENO	CENTENO	5482105	3401
1384	LAS BANDURRIAS	LAS BANDURRIAS	5482126	3401
1385	VILLA GUASTALLA	VILLA GUASTALLA	5482105	\N
1389	GRANADERO BAIGORRIA	GRANADERO BAIGORRIA	5482084	341
1390	PAGANINI	PAGANINI	5482084	\N
1392	CAPITAN BERMUDEZ	CAPITAN BERMUDEZ	5482119	341
1393	JUAN ORTIZ	JUAN ORTIZ	5482119	\N
1395	VILLA CASSINI	VILLA CASSINI	5482119	\N
1396	ARSENAL DE GUERRA SAN LORENZO	ARSENAL DE GUERRA SAN LORENZO	5482119	\N
1397	BORGHI	BORGHI	5482119	\N
1398	FABRICA MILITAR SAN LORENZO	FABRICA MILITAR SAN LORENZO	5482119	\N
1399	FRAY LUIS BELTRAN	FRAY LUIS BELTRAN	5482119	341
1402	VILLA GARIBALDI	VILLA GARIBALDI	5482119	\N
1403	VILLA MARGARITA	VILLA MARGARITA	5482119	\N
1406	CANDELARIA SUD	CANDELARIA SUD	5482014	\N
1407	CASILDA	CASILDA	5482014	3464
1408	COLONIA CANDELARIA	COLONIA CANDELARIA	5482014	\N
1409	COLONIA LA COSTA	COLONIA LA COSTA	5482014	\N
1410	CAMPO PESOA	CAMPO PESOA	5482014	\N
1411	CHABAS	CHABAS	5482014	3464
1412	LA MERCED	LA MERCED	5482014	\N
1413	SANFORD	SANFORD	5482014	3464
1414	VILLADA	VILLADA	5482014	3465
1415	BARLETT	BARLETT	5482119	\N
1416	VILLA MUGUETA	VILLA MUGUETA	5482119	3464
1417	BIGAND	BIGAND	5482014	3464
1418	BOMBAL	BOMBAL	5482028	3465
1419	LOS MOLINOS	LOS MOLINOS	5482014	3464
1420	AREQUITO	AREQUITO	5482014	3464
1421	LA VIUDA	LA VIUDA	5482014	\N
1422	LOS NOGALES	LOS NOGALES	5482014	3467
1423	CAMPO CRENNA	CAMPO CRENNA	5482014	\N
1426	SAN JOSE DE LA ESQUINA	SAN JOSE DE LA ESQUINA	5482014	3467
1427	ARTEAGA	ARTEAGA	5482014	3467
1428	COLONIA LAGO DI COMO	COLONIA LAGO DI COMO	5482014	\N
1433	LAS QUINTAS	LAS QUINTAS	5482119	\N
1434	PINO DE SAN LORENZO	PINO DE SAN LORENZO	5482119	\N
1435	PUERTO SAN LORENZO	PUERTO SAN LORENZO	5482119	3493
1436	SAN LORENZO	SAN LORENZO	5482119	3493
1437	RICARDONE	RICARDONE	5482119	3476
1439	CERANA	CERANA	5482119	\N
1442	PUEBLO KIRSTON	PUEBLO KIRSTON	5482119	\N
1443	PUERTO GENERAL SAN MARTIN	PUERTO GENERAL SAN MARTIN	5482119	3476
1444	JESUS MARIA	JESUS MARIA	5482119	\N
1445	TIMBUES	TIMBUES	5482119	3493
1446	CAMPO PALETTA	CAMPO PALETTA	5482056	\N
1447	OLIVEROS	OLIVEROS	5482056	3476
1448	RINCON DE GRONDONA	RINCON DE GRONDONA	5482056	\N
1449	GABOTO	GABOTO	5482105	3476
1450	MACIEL	MACIEL	5482105	3476
1451	PUERTO GABOTO	PUERTO GABOTO	5482105	3476
1452	CAMPO GALLOSO	CAMPO GALLOSO	5482105	\N
1453	MONJE	MONJE	5482105	3466
1454	ALDAO	ALDAO	5482119	3476
1455	ANDINO	ANDINO	5482056	3476
1456	CAMPO RAFFO	CAMPO RAFFO	5482056	\N
1457	COLONIA TRES MARIAS	COLONIA TRES MARIAS	5482056	\N
1458	SERODINO	SERODINO	5482056	3493
1459	CARRIZALES (EST. CLARKE)	CARRIZALES (EST. CLARKE)	5482056	\N
1460	CLARKE	CLARKE	5482056	3476
1461	DIAZ	DIAZ	5482105	3466
1462	CAMPO GARCIA	CAMPO GARCIA	5482105	\N
1463	CAMPO MOURE	CAMPO MOURE	5482105	\N
1464	CARCEL MODELO CORONDA	CARCEL MODELO CORONDA	5482105	\N
1465	COLONIA CORONDINA	COLONIA CORONDINA	5482105	\N
1466	CORONDA	CORONDA	5482105	342
1467	LARRECHEA	LARRECHEA	5482105	3404
1469	AROCENA	AROCENA	5482105	3466
1470	BARRIO CAIMA	BARRIO CAIMA	5482105	3466
1471	DESVIO ARIJON	DESVIO ARIJON	5482105	342
1472	PUENTE COLASTINE	PUENTE COLASTINE	5482105	342
1473	SAN FABIAN	SAN FABIAN	5482105	3466
1474	BARRANCAS	BARRANCAS	5482105	3466
1475	PUERTO ARAGON	PUERTO ARAGON	5482105	3466
1476	BERNARDO DE IRIGOYEN	BERNARDO DE IRIGOYEN	5482105	3466
1477	CAMPO BRARDA	CAMPO BRARDA	5482105	\N
1478	CAMPO CARIGNANO	CAMPO CARIGNANO	5482105	\N
1479	CAMPO GENERO	CAMPO GENERO	5482105	\N
1480	CASALEGNO	CASALEGNO	5482105	3466
1482	IRIGOYEN	IRIGOYEN	5482105	\N
1484	COLONIA PIAGGIO	COLONIA PIAGGIO	5482105	\N
1485	GALVEZ	GALVEZ	5482105	3404
1486	CAMPO GIMENEZ	CAMPO GIMENEZ	5482105	\N
1487	GESSLER	GESSLER	5482105	3404
1488	LOMA ALTA	LOMA ALTA	5482105	3404
1490	SAN EUGENIO	SAN EUGENIO	5482105	3404
1491	CAMPO RODRIGUEZ	CAMPO RODRIGUEZ	5482070	3404
1492	LOPEZ	LOPEZ	5482105	3404
1493	RIGBY	RIGBY	5482105	\N
1494	SAN MARTIN DE TOURS	SAN MARTIN DE TOURS	5482105	\N
1495	COLONIA BELGRANO	COLONIA BELGRANO	5482126	3404
1497	WILDERMUTH	WILDERMUTH	5482126	\N
1500	SANTA CLARA DE BUENA VISTA	SANTA CLARA DE BUENA VISTA	5482070	3404
1503	COLONIA BELLA ITALIA	COLONIA BELLA ITALIA	5482021	3492
1504	RAFAELA	RAFAELA	5482021	3492
1505	CAPILLA SAN JOSE	CAPILLA SAN JOSE	5482021	\N
1506	COLONIA CASTELLANOS	COLONIA CASTELLANOS	5482021	3492
1507	COLONIA FIDELA	COLONIA FIDELA	5482021	\N
1508	COLONIA SAN ANTONIO	COLONIA SAN ANTONIO	5482021	3492
1509	CORONEL FRAGA	CORONEL FRAGA	5482021	3492
1510	EGUSQUIZA	EGUSQUIZA	5482021	3492
1511	PRESIDENTE ROCA	PRESIDENTE ROCA	5482021	3492
1512	PUEBLO MARINI	PUEBLO MARINI	5482021	\N
1513	PUEBLO RAMONA	PUEBLO RAMONA	5482021	3492
1514	PUEBLO SAN ANTONIO	PUEBLO SAN ANTONIO	5482021	\N
1515	SAGUIER	SAGUIER	5482021	3492
1516	SUSANA	SUSANA	5482021	3492
1517	VILA	VILA	5482021	3492
1518	VILLA SAN JOSE	VILLA SAN JOSE	5482021	3492
1520	ANGELICA	ANGELICA	5482021	3492
1523	LEHMANN	LEHMANN	5482021	3492
1525	ATALIVA	ATALIVA	5482021	3493
1527	GALISTEO	GALISTEO	5482021	\N
1529	HUMBERTO I'	HUMBERTO I'	5482021	3493
1531	REINA MARGARITA	REINA MARGARITA	5482021	\N
1532	SAN MIGUEL	SAN MIGUEL	5482021	\N
1534	CAPIVARA	CAPIVARA	5482091	3408
1535	COLONIA MAUA	COLONIA MAUA	5482021	\N
1536	CONSTANZA	CONSTANZA	5482091	3409
1537	ITUZAINGO	ITUZAINGO	5482070	\N
1538	VIRGINIA	VIRGINIA	5482021	3409
1539	COLONIA BERLIN	COLONIA BERLIN	5482091	\N
1540	COLONIA ORTIZ	COLONIA ORTIZ	5482091	\N
1542	DOCE CASAS	DOCE CASAS	5482091	\N
1543	MOISES VILLE	MOISES VILLE	5482091	3409
1544	MUTCHNIK	MUTCHNIK	5482091	\N
1546	VEINTICUATRO CASAS	VEINTICUATRO CASAS	5482091	\N
1548	ESTACION SAGUIER	ESTACION SAGUIER	5482021	\N
1549	CASABLANCA	CASABLANCA	5482021	\N
1550	COLONIA ALDAO	COLONIA ALDAO	5482021	3493
1551	COLONIA BICHA	COLONIA BICHA	5482021	3493
1552	COLONIA BIGAND	COLONIA BIGAND	5482021	\N
1553	EUSEBIA	EUSEBIA	5482021	3493
1554	HUGENTOBLER	HUGENTOBLER	5482021	\N
1555	RINCON DE TACURALES	RINCON DE TACURALES	5482021	\N
1556	AURELIA	AURELIA	5482021	3492
1557	AURELIA NORTE	AURELIA NORTE	5482021	3492
1558	AURELIA SUD	AURELIA SUD	5482021	3492
1560	RAQUEL	RAQUEL	5482021	3493
1561	SUNCHALES	SUNCHALES	5482021	3493
1562	COLONIA TACURALES	COLONIA TACURALES	5482021	3493
1563	TACURAL	TACURAL	5482021	3493
1564	BEALISTOCK	BEALISTOCK	5482091	\N
1565	COLONIA BOSSI	COLONIA BOSSI	5482091	3409
1566	LAS PALMERAS	LAS PALMERAS	5482091	3409
1567	PALACIOS	PALACIOS	5482091	3409
1568	ZADOCKHAN	ZADOCKHAN	5482091	\N
1569	CERES	CERES	5482091	3491
1575	COLONIA MONTEFIORE	COLONIA MONTEFIORE	5482077	3491
1576	LA ELSA	LA ELSA	5482077	\N
1578	LA MARINA	LA MARINA	5482077	\N
1580	CAMPO EL MATACO	CAMPO EL MATACO	5482091	\N
1581	CURUPAITY	CURUPAITY	5482091	\N
1582	LA RUBIA	LA RUBIA	5482091	3491
1583	MONIGOTES	MONIGOTES	5482091	3409
1584	ARRUFO	ARRUFO	5482091	3491
1586	COLONIA ANA	COLONIA ANA	5482091	\N
1587	VILLA TRINIDAD	VILLA TRINIDAD	5482091	3491
1588	COLONIA MACKINLAY	COLONIA MACKINLAY	5482091	\N
1589	COLONIA MALHMAN SUD	COLONIA MALHMAN SUD	5482091	\N
1590	COLONIA ROSA	COLONIA ROSA	5482091	\N
1591	SAN GUILLERMO	SAN GUILLERMO	5482091	3562
1595	COLONIA RIPAMONTI	COLONIA RIPAMONTI	5482091	\N
1597	MONTE OBSCURIDAD	MONTE OBSCURIDAD	5482091	\N
1598	RIPAMONTI	RIPAMONTI	5482091	\N
1599	SUARDI	SUARDI	5482091	3562
1600	AMBROSETTI	AMBROSETTI	5482091	3491
1601	HERSILIA	HERSILIA	5482091	3491
1679	VILLANI	VILLANI	5482021	\N
1681	ESMERALDITA	ESMERALDITA	5482126	\N
1683	SAN JOSE FRONTERA	SAN JOSE FRONTERA	5482126	\N
1684	BAUER Y SIGEL	BAUER Y SIGEL	5482021	3492
1686	COLONIA JOSEFINA	COLONIA JOSEFINA	5482021	3492
1687	ESTACION JOSEFINA	ESTACION JOSEFINA	5482021	3492
1688	JOSE MANUEL ESTRADA	JOSE MANUEL ESTRADA	5482021	\N
1689	COLONIA CELLO	COLONIA CELLO	5482021	3492
1690	SANTA CLARA DE SAGUIER	SANTA CLARA DE SAGUIER	5482021	3492
1691	CAMPO CLUCELLAS	CAMPO CLUCELLAS	5482021	\N
1692	CAMPO ROMERO	CAMPO ROMERO	5482021	\N
1693	CAMPO ZURBRIGGEN	CAMPO ZURBRIGGEN	5482021	\N
1694	CLUCELLAS	CLUCELLAS	5482021	3492
1695	ESTACION CLUCELLAS	ESTACION CLUCELLAS	5482021	3492
1696	EUSTOLIA	EUSTOLIA	5482021	\N
1699	ESTRADA	ESTRADA	5482021	\N
1701	ZENON PEREYRA	ZENON PEREYRA	5482021	3564
1719	DESVIO BOERO	DESVIO BOERO	5482021	\N
1810	FRONTERA	FRONTERA	5482021	\N
1812	CAMPO FAGGIANO	CAMPO FAGGIANO	5482126	\N
1813	SASTRE	SASTRE	5482126	3406
1814	CRISPI	CRISPI	5482126	3406
1815	COLONIA MARGARITA	COLONIA MARGARITA	5482021	3492
1816	GARIBALDI	GARIBALDI	5482021	3406
1817	CRISTOLIA	CRISTOLIA	5482021	\N
1818	ESTACION MARIA JUANA	ESTACION MARIA JUANA	5482021	3406
1819	MANGORE	MANGORE	5482021	\N
1820	MARIA JUANA	MARIA JUANA	5482021	3406
1821	LOS SEMBRADOS	LOS SEMBRADOS	5482021	\N
1822	SAN VICENTE	SAN VICENTE	5482021	3492
1823	AVENA	AVENA	5482126	\N
1824	SAN MARTIN DE LAS ESCOBAS	SAN MARTIN DE LAS ESCOBAS	5482126	3406
1825	COLONIA LA YERBA	COLONIA LA YERBA	5482126	\N
1826	COLONIA SANTA ANITA	COLONIA SANTA ANITA	5482126	\N
1827	LAS PETACAS	LAS PETACAS	5482126	3406
1828	SAN JORGE	SAN JORGE	5482126	3406
1829	CARLOS PELLEGRINI	CARLOS PELLEGRINI	5482126	3401
1830	CAÑADA ROSQUIN	CAÑADA ROSQUIN	5482126	3401
1832	ESMERALDA	ESMERALDA	5482021	3492
1835	TRAILL	TRAILL	5482126	3406
1836	CAÑADA DE GOMEZ	CAÑADA DE GOMEZ	5482056	3471
1837	BERRETTA	BERRETTA	5482056	\N
1838	BUSTINZA	BUSTINZA	5482056	3471
1839	GRANJA SAN MANUEL	GRANJA SAN MANUEL	5482056	\N
1840	MARIA LUISA CORREA	MARIA LUISA CORREA	5482056	\N
1841	SAN ESTANISLAO	SAN ESTANISLAO	5482056	\N
1842	SAN RICARDO	SAN RICARDO	5482056	\N
1843	VILLA ELOISA	VILLA ELOISA	5482056	3471
1844	CAMPO LA RIVIERE	CAMPO LA RIVIERE	5482007	\N
1845	CAMPO SANTA ISABEL	CAMPO SANTA ISABEL	5482007	\N
1846	LAS PAREJAS	LAS PAREJAS	5482007	3471
1847	CORREA	CORREA	5482056	3471
1849	ARMSTRONG	ARMSTRONG	5482007	3471
1850	CAMPO GIMBATTI	CAMPO GIMBATTI	5482007	\N
1851	CAMPO LA AMISTAD	CAMPO LA AMISTAD	5482007	\N
1852	CAMPO CHARO	CAMPO CHARO	5482007	\N
1854	CAMPO LA PAZ	CAMPO LA PAZ	5482007	\N
1855	SAN GUILLERMO	SAN GUILLERMO	5482007	\N
1856	TORTUGAS	TORTUGAS	5482007	3471
1857	LA CALIFORNIA	LA CALIFORNIA	5482007	\N
1858	LAS ROSAS	LAS ROSAS	5482007	3471
1859	MONTES DE OCA	MONTES DE OCA	5482007	3471
1860	BOUQUET	BOUQUET	5482007	3471
1864	COLONIA SAN FRANCISCO	COLONIA SAN FRANCISCO	5482126	\N
1865	MARIA SUSANA	MARIA SUSANA	5482126	3401
1866	PIAMONTE	PIAMONTE	5482014	3401
1868	LANDETA	LANDETA	5482126	3406
1869	LOS CARDOS	LOS CARDOS	5482126	3401
1870	EL TREBOL	EL TREBOL	5482126	3401
1871	TAIS	TAIS	5482126	\N
1938	SAN MARCOS DE VENADO TUERTO	SAN MARCOS DE VENADO TUERTO	5482042	3462
1939	VENADO TUERTO	VENADO TUERTO	5482042	3462
1940	LA CHISPA	LA CHISPA	5482042	3462
1941	LA INGLESITA	LA INGLESITA	5482042	\N
1942	MURPHY	MURPHY	5482042	3462
1943	SAN FRANCISCO DE SANTA FE	SAN FRANCISCO DE SANTA FE	5482042	3462
1945	CHAPUY	CHAPUY	5482042	3462
1946	OTTO BEMBERG	OTTO BEMBERG	5482042	\N
1948	SANTA ISABEL	SANTA ISABEL	5482042	3462
1949	CAMPO QUIRNO	CAMPO QUIRNO	5482042	\N
1951	LAS ENCADENADAS	LAS ENCADENADAS	5482042	\N
1952	VILLA CAÑAS	VILLA CAÑAS	5482042	3462
1953	COLONIA MORGAN	COLONIA MORGAN	5482042	\N
1954	COLONIA SANTA LUCIA	COLONIA SANTA LUCIA	5482042	\N
1955	MARIA TERESA	MARIA TERESA	5482042	3462
1956	ESTACION CHRISTOPHERSEN	ESTACION CHRISTOPHERSEN	5482042	3462
1957	RUNCIMAN	RUNCIMAN	5482042	\N
1958	LA MOROCHA	LA MOROCHA	5482042	\N
1959	SAN GREGORIO	SAN GREGORIO	5482042	3382
1960	LA GAMA	LA GAMA	5482042	\N
1961	SAN EDUARDO	SAN EDUARDO	5482042	3462
1962	SANCTI SPIRITU	SANCTI SPIRITU	5482042	3462
1963	CARMEN	CARMEN	5482042	3462
1965	MAGGIOLO	MAGGIOLO	5482042	3462
1974	FIRMAT	FIRMAT	5482042	3465
1975	VILLA FREDRICKSON	VILLA FREDRICKSON	5482042	\N
1976	VILLA REGULES	VILLA REGULES	5482042	\N
1977	CORA	CORA	5482042	\N
1979	MIGUEL TORRES	MIGUEL TORRES	5482042	3465
1980	VILLA DIVISA DE MAYO	VILLA DIVISA DE MAYO	5482042	3465
1981	CHOVET	CHOVET	5482042	3465
1982	CAÑADA DEL UCLE	CAÑADA DEL UCLE	5482042	3465
1983	CARLOS DOSE	CARLOS DOSE	5482042	\N
1984	COLONIA HANSEN	COLONIA HANSEN	5482014	\N
1986	LOS QUIRQUINCHOS	LOS QUIRQUINCHOS	5482014	3465
1987	BERABEVU	BERABEVU	5482014	3465
1988	CAMPO NUEVO	CAMPO NUEVO	5482014	\N
1989	COLONIA FERNANDEZ	COLONIA FERNANDEZ	5482014	\N
1990	COLONIA GOMEZ	COLONIA GOMEZ	5482014	\N
1993	COLONIA PIAMONTESA	COLONIA PIAMONTESA	5482014	\N
1994	COLONIA SANTA NATALIA	COLONIA SANTA NATALIA	5482014	\N
1995	COLONIA VALENCIA	COLONIA VALENCIA	5482014	\N
1996	CUATRO ESQUINAS	CUATRO ESQUINAS	5482014	3469
1997	GODEKEN	GODEKEN	5482014	3465
1999	SANTA NATALIA	SANTA NATALIA	5482014	\N
2000	CAFFERATA	CAFFERATA	5482042	3468
2001	CHAÑAR LADEADO	CHAÑAR LADEADO	5482014	3468
2002	EL CANTOR	EL CANTOR	5482042	\N
2080	GENERAL GELLY	GENERAL GELLY	5482028	2477
2131	LOS ARCOS	LOS ARCOS	5482042	\N
2134	WHEELWRIGHT	WHEELWRIGHT	5482042	2473
2135	EL BAGUAL	EL BAGUAL	5482028	\N
2137	JUNCAL	JUNCAL	5482028	2473
2138	HUGHES	HUGHES	5482042	2473
2139	MERCEDITAS	MERCEDITAS	5482042	\N
2140	SANTA EMILIA	SANTA EMILIA	5482042	\N
2141	LABORDEBOY	LABORDEBOY	5482042	3465
2143	MELINCUE	MELINCUE	5482042	3465
2144	SAN URBANO	SAN URBANO	5482042	\N
2145	CARRERAS	CARRERAS	5482042	3465
2146	CUATRO DE FEBRERO	CUATRO DE FEBRERO	5482042	\N
2147	EL JARDIN	EL JARDIN	5482042	\N
2148	ELORTONDO	ELORTONDO	5482042	3462
2454	EMPALME VILLA CONSTITUCION	EMPALME VILLA CONSTITUCION	5482028	3400
2455	PAVON	PAVON	5482028	3400
2456	THEOBALD	THEOBALD	5482028	3400
2457	ESTACION VILLA CONSTITUCION	ESTACION VILLA CONSTITUCION	5482028	3400
2458	VILLA CONSTITUCION	VILLA CONSTITUCION	5482028	3400
2459	GODOY	GODOY	5482028	3460
2460	MORANTE	MORANTE	5482028	\N
2461	ORATORIO MORANTE	ORATORIO MORANTE	5482028	\N
2462	RUEDA	RUEDA	5482028	3400
2463	TRES ESQUINAS	TRES ESQUINAS	5482028	\N
2499	BARRANQUITAS	BARRANQUITAS	5482063	\N
2500	BARRIO BELGRANO	BARRIO BELGRANO	5482126	\N
2516	PIQUETE	PIQUETE	5482063	\N
2518	SANTA FE	SANTA FE	5482063	342
2519	VILLA DON BOSCO	VILLA DON BOSCO	5482063	\N
2520	VILLA MARIA SELVA	VILLA MARIA SELVA	5482063	\N
2521	VILLA YAPEYU	VILLA YAPEYU	5482063	\N
2522	ALTO VERDE	ALTO VERDE	5482063	342
2523	ARROYO LEYES	ARROYO LEYES	5482063	342
2526	CAMPO CRESPO	CAMPO CRESPO	5482063	\N
2527	CAMPO DEL MEDIO	CAMPO DEL MEDIO	5482035	\N
2528	ITURRASPE	ITURRASPE	5482035	\N
2529	CAYASTA	CAYASTA	5482035	3405
2530	COLASTINE	COLASTINE	5482063	342
2531	COLASTINE NORTE	COLASTINE NORTE	5482063	342
2532	COLONIA MASCIAS	COLONIA MASCIAS	5482035	3482
2533	COLONIA NUEVA NARCISO	COLONIA NUEVA NARCISO	5482035	\N
2534	COLONIA SAN JOAQUIN	COLONIA SAN JOAQUIN	5482035	\N
2535	EL LAUREL	EL LAUREL	5482035	\N
2536	EL POZO	EL POZO	5482035	\N
2538	LA NORIA	LA NORIA	5482035	\N
2539	LOS CERRILLOS	LOS CERRILLOS	5482035	\N
2540	LOS ZAPALLOS	LOS ZAPALLOS	5482035	342
2541	RINCON NORTE	RINCON NORTE	5482063	\N
2542	RINCON POTREROS	RINCON POTREROS	5482063	\N
2544	SALADERO M. CABAL	SALADERO M. CABAL	5482035	3482
2545	SAN JOAQUIN	SAN JOAQUIN	5482035	\N
2546	SAN JOSE DEL RINCON	SAN JOSE DEL RINCON	5482063	342
2547	SANTA ROSA	SANTA ROSA	5482035	342
2548	VILLA VIVEROS	VILLA VIVEROS	5482063	\N
2549	HELVECIA	HELVECIA	5482035	3482
2550	COLONIA CALIFORNIA	COLONIA CALIFORNIA	5482035	\N
2551	COLONIA FRANCESA	COLONIA FRANCESA	5482098	\N
2552	COLONIA TERESA	COLONIA TERESA	5482098	3482
2554	SAN JAVIER	SAN JAVIER	5482098	3405
2555	EMPALME SAN CARLOS	EMPALME SAN CARLOS	5482070	342
2556	EL TROPEZON	EL TROPEZON	5482070	\N
2557	FRANCK	FRANCK	5482070	342
2558	LAS TUNAS	LAS TUNAS	5482070	342
2559	SAN CARLOS NORTE	SAN CARLOS NORTE	5482070	3404
2560	SAN JERONIMO DEL SAUCE	SAN JERONIMO DEL SAUCE	5482070	3404
2561	CAMPO MAGNIN	CAMPO MAGNIN	5482070	\N
2562	MARIANO SAAVEDRA	MARIANO SAAVEDRA	5482070	\N
2563	SA PEREIRA	SA PEREIRA	5482070	3404
2564	SAN JERONIMO NORTE	SAN JERONIMO NORTE	5482070	3404
2565	SAN MARIANO	SAN MARIANO	5482070	3404
2566	SANTA MARIA	SANTA MARIA	5482070	3404
2567	BARRIO SUR (SAN CARLOS CENTRO)	BARRIO SUR (SAN CARLOS CENTRO)	5482070	3404
2568	COLONIA MATILDE	COLONIA MATILDE	5482070	342
2569	CORONEL RODRIGUEZ	CORONEL RODRIGUEZ	5482070	3404
2570	ESTACION MATILDE	ESTACION MATILDE	5482070	342
2571	LAS HIGUERITAS	LAS HIGUERITAS	5482070	\N
2572	MATILDE	MATILDE	5482070	342
2573	SAN CARLOS CENTRO	SAN CARLOS CENTRO	5482070	3404
2574	SAN CARLOS SUD	SAN CARLOS SUD	5482070	3404
2575	ANGEL GALLARDO	ANGEL GALLARDO	5482063	342
2576	ARROYO AGUIAR	ARROYO AGUIAR	5482063	342
2577	ASCOCHINGAS	ASCOCHINGAS	5482063	\N
2578	CAMPO LEHMANN	CAMPO LEHMANN	5482021	\N
2579	CONSTITUYENTES	CONSTITUYENTES	5482063	342
2582	MONTE VERA	MONTE VERA	5482063	342
2583	NUEVA POMPEYA	NUEVA POMPEYA	5482063	\N
2585	SAN PEDRO SUR	SAN PEDRO SUR	5482063	\N
2591	SAN JOSE	SAN JOSE	5482070	342
2592	SANTO TOME	SANTO TOME	5482063	342
2593	VILLA LUJAN	VILLA LUJAN	5482063	\N
2594	BAJO LAS TUNAS	BAJO LAS TUNAS	5482063	\N
2595	ESTACION SAN AGUSTIN	ESTACION SAN AGUSTIN	5482998	342
2596	SAN AGUSTIN	SAN AGUSTIN	5482070	342
2597	SAUCE VIEJO	SAUCE VIEJO	5482063	342
2599	GOBERNADOR CANDIOTI	GOBERNADOR CANDIOTI	5482063	342
2600	IRIONDO	IRIONDO	5482063	\N
2601	RECREO	RECREO	5482063	342
2606	LAGUNA PAIVA	LAGUNA PAIVA	5482063	342
2607	REYNALDO CULLEN	REYNALDO CULLEN	5482063	\N
2608	SAN GUILLERMO	SAN GUILLERMO	5482063	\N
2609	CAMPO ANDINO	CAMPO ANDINO	5482063	3497
2610	EL GALPON	EL GALPON	5482063	\N
2611	LA CLORINDA	LA CLORINDA	5482112	\N
2612	LOS HORNOS	LOS HORNOS	5482063	\N
2614	SAN PEDRO NORTE	SAN PEDRO NORTE	5482063	\N
2615	CULULU	CULULU	5482070	3497
2616	HIPATIA	HIPATIA	5482070	3497
2617	INGENIERO BOASI	INGENIERO BOASI	5482070	\N
2619	MANUCHO	MANUCHO	5482063	342
2620	PROGRESO	PROGRESO	5482070	3497
2622	SARMIENTO	SARMIENTO	5482070	3497
2624	COLONIA CLARA	COLONIA CLARA	5482091	\N
2625	LA CLARA	LA CLARA	5482091	\N
2626	PERICOTA	PERICOTA	5482070	\N
2627	PROVIDENCIA	PROVIDENCIA	5482070	3497
2628	SANTO DOMINGO	SANTO DOMINGO	5482070	3497
2629	SOLEDAD	SOLEDAD	5482091	3498
2630	SOUTOMAYOR	SOUTOMAYOR	5482070	3497
2631	LA PELADA	LA PELADA	5482070	3497
2632	MARIA LUISA	MARIA LUISA	5482070	3497
2633	COLONIA ADOLFO ALSINA	COLONIA ADOLFO ALSINA	5482070	\N
2634	JACINTO ARAUZ	JACINTO ARAUZ	5482070	3497
2635	ELISA	ELISA	5482070	3498
2636	NELSON	NELSON	5482063	342
2637	AROMOS	AROMOS	5482063	\N
2638	CABAL	CABAL	5482063	\N
2639	COLONIA CAMPO BOTTO	COLONIA CAMPO BOTTO	5482063	\N
2640	EMILIA	EMILIA	5482063	3497
2641	ESTER	ESTER	5482112	3497
2642	LASSAGA	LASSAGA	5482063	\N
2643	LLAMBI CAMPBELL	LLAMBI CAMPBELL	5482063	3497
2645	CAYASTACITO	CAYASTACITO	5482112	3497
2648	ESQUINA GRANDE	ESQUINA GRANDE	5482112	\N
2649	FORTIN ALMAGRO	FORTIN ALMAGRO	5482112	\N
2650	SAN JUSTO	SAN JUSTO	5482112	3498
2651	VERA MUJICA	VERA MUJICA	5482112	\N
2653	CACIQUE ARIACAIQUIN	CACIQUE ARIACAIQUIN	5482098	3405
2654	JOSE M. MACIAS	JOSE M. MACIAS	5482112	\N
2655	LOS SALADILLOS	LOS SALADILLOS	5482112	\N
2656	MASCIAS	MASCIAS	5482035	\N
2657	ABIPONES	ABIPONES	5482112	\N
2658	COLONIA EL OCHENTA	COLONIA EL OCHENTA	5482112	\N
2659	COLONIA SILVA	COLONIA SILVA	5482112	\N
2660	LA ROSA	LA ROSA	5482112	\N
2661	MARCELINO ESCALADA	MARCELINO ESCALADA	5482112	3498
2662	RAMAYON	RAMAYON	5482112	3498
2663	VILLA LASTENIA	VILLA LASTENIA	5482112	\N
2665	GOBERNADOR CRESPO	GOBERNADOR CRESPO	5482112	3498
2666	CAMPO ZAVALLA	CAMPO ZAVALLA	5482098	\N
2667	COLONIA DOLORES	COLONIA DOLORES	5482112	3498
2668	COLONIA LA MORA	COLONIA LA MORA	5482098	\N
2670	LA BRAVA	LA BRAVA	5482098	3482
2671	SAN MARTIN NORTE	SAN MARTIN NORTE	5482112	3498
2672	ARRASCAETA	ARRASCAETA	5482112	\N
2673	CAMPO BERRAZ	CAMPO BERRAZ	5482112	\N
2674	COLONIA MANUEL MENCHACA	COLONIA MANUEL MENCHACA	5482112	\N
2675	EL SOMBRERERO	EL SOMBRERERO	5482112	\N
2677	LA JULIA	LA JULIA	5482112	\N
2679	LAS TRES MARIAS	LAS TRES MARIAS	5482035	\N
2680	LOS OLIVOS	LOS OLIVOS	5482112	\N
2681	MIGUEL ESCALADA	MIGUEL ESCALADA	5482112	\N
2682	NARE	NARE	5482112	3498
2683	NUEVA UKRANIA	NUEVA UKRANIA	5482112	\N
2684	PAIKIN	PAIKIN	5482112	\N
2685	PETRONILA	PETRONILA	5482091	\N
2686	RINCON DE SAN ANTONIO	RINCON DE SAN ANTONIO	5482091	\N
2687	VILLA SARALEGUI	VILLA SARALEGUI	5482091	\N
2688	COLONIA SOL DE MAYO	COLONIA SOL DE MAYO	5482112	\N
2689	COLONIA TRES REYES	COLONIA TRES REYES	5482112	\N
2690	LUCIANO LEIVA	LUCIANO LEIVA	5482112	\N
2691	PUEBLO SAN BERNARDO	PUEBLO SAN BERNARDO	5482112	3498
2692	VIDELA	VIDELA	5482112	3498
2693	CALCHAQUI	CALCHAQUI	5482133	3483
2695	LA HOSCA	LA HOSCA	5482133	\N
2696	LOS GALPONES	LOS GALPONES	5482133	\N
2698	ALEJANDRA	ALEJANDRA	5482098	3405
2699	EL PAJARO BLANCO	EL PAJARO BLANCO	5482098	\N
2700	LOS CORRALITOS	LOS CORRALITOS	5482098	\N
2701	LOS OSOS	LOS OSOS	5482098	\N
2703	COLONIA LA BLANCA	COLONIA LA BLANCA	5482112	\N
2704	LA CRIOLLA	LA CRIOLLA	5482112	3498
2705	COLONIA LA NEGRA	COLONIA LA NEGRA	5482133	\N
2706	FIVES LILLE	FIVES LILLE	5482112	\N
2707	GUARANIES	GUARANIES	5482112	\N
2708	LA CAMILA	LA CAMILA	5482112	3498
2709	LA ORIENTAL	LA ORIENTAL	5482133	\N
2710	PEDRO GOMEZ CELLO	PEDRO GOMEZ CELLO	5482112	3483
2711	VERA Y PINTADO	VERA Y PINTADO	5482112	3498
2712	CAMPO COUBERT	CAMPO COUBERT	5482098	\N
2713	COLONIA LA MARIA	COLONIA LA MARIA	5482133	\N
2714	COLONIA LA NICOLASA	COLONIA LA NICOLASA	5482098	\N
2715	ESPIN	ESPIN	5482133	\N
2716	LA GUAMPITA	LA GUAMPITA	5482133	\N
2717	MARGARITA	MARGARITA	5482133	3483
2718	ESTANCIA LAS GAMAS	ESTANCIA LAS GAMAS	5482133	\N
2719	ESTANCIA LOS PALMARES	ESTANCIA LOS PALMARES	5482133	\N
2720	ESTANCIA PAVENHAN	ESTANCIA PAVENHAN	5482133	\N
2722	LA GALLARETA	LA GALLARETA	5482133	3483
2723	LA SARNOSA	LA SARNOSA	5482133	\N
2724	LOS PALMARES	LOS PALMARES	5482133	\N
2726	CAMPO SAN JOSE	CAMPO SAN JOSE	5482077	\N
2727	EL AMARGO	EL AMARGO	5482077	\N
2728	EL MARIANO	EL MARIANO	5482077	\N
2730	FORTIN ARGENTINA	FORTIN ARGENTINA	5482077	\N
2731	FORTIN CACIQUE	FORTIN CACIQUE	5482077	\N
2732	FORTIN CHARRUA	FORTIN CHARRUA	5482133	\N
2733	FORTIN TOSTADO	FORTIN TOSTADO	5482077	\N
2735	LA BOMBILLA	LA BOMBILLA	5482077	\N
2736	LOS CHARABONES	LOS CHARABONES	5482077	\N
2737	TOSTADO	TOSTADO	5482077	3491
2738	ANTONIO PINI	ANTONIO PINI	5482077	\N
2739	CABEZA DE CHANCHO	CABEZA DE CHANCHO	5482077	\N
2741	EL NOCHERO	EL NOCHERO	5482077	\N
2742	FORTIN ATAHUALPA	FORTIN ATAHUALPA	5482077	3491
2743	FORTIN SEIS DE CABALLERIA	FORTIN SEIS DE CABALLERIA	5482077	\N
2744	GREGORIA PEREZ DE DENIS	GREGORIA PEREZ DE DENIS	5482077	3491
2748	LAS CHUÑAS	LAS CHUÑAS	5482998	\N
2749	PADRE PEDRO ITURRALDE	PADRE PEDRO ITURRALDE	5482077	\N
2750	POZO BORRADO	POZO BORRADO	5482077	3491
2751	SAN BERNARDO	SAN BERNARDO	5482077	\N
2752	SANTA MARGARITA	SANTA MARGARITA	5482077	3491
2753	TRES POZOS	TRES POZOS	5482077	\N
2754	VILLA MINETTI	VILLA MINETTI	5482077	3491
2807	CAMPO GARAY	CAMPO GARAY	5482077	\N
2808	COLONIA INDEPENDENCIA	COLONIA INDEPENDENCIA	5482077	\N
2809	ESTEBAN RAMS	ESTEBAN RAMS	5482077	3491
2810	FORTIN ALERTA	FORTIN ALERTA	5482077	\N
2812	LOGROÑO	LOGROÑO	5482077	3491
2813	PORTALIS	PORTALIS	5482077	\N
2815	BARRIO SAN JOSE	BARRIO SAN JOSE	5482070	\N
2816	DHO	DHO	5482091	\N
2817	EL AGUARA	EL AGUARA	5482091	\N
2818	LOS MOLLES	LOS MOLLES	5482091	\N
2819	SAN CRISTOBAL	SAN CRISTOBAL	5482091	3408
2820	AGUARA GRANDE	AGUARA GRANDE	5482091	3408
2821	PORTUGALETE	PORTUGALETE	5482091	3408
2822	ÑANDUCITA	ÑANDUCITA	5482091	3408
2823	LA LUCILA	LA LUCILA	5482091	\N
2824	LUCILA	LUCILA	5482091	\N
2825	MARIA EUGENIA	MARIA EUGENIA	5482091	\N
2826	AGUARA	AGUARA	5482091	\N
2827	COLONIA EL SIMBOL	COLONIA EL SIMBOL	5482091	\N
2828	LA CABRAL	LA CABRAL	5482091	3408
2829	LA POLVAREDA	LA POLVAREDA	5482091	\N
2830	LAS AVISPAS	LAS AVISPAS	5482091	\N
2831	NUEVA ITALIA	NUEVA ITALIA	5482077	\N
2832	SANTURCE	SANTURCE	5482091	3408
2833	HUANQUEROS	HUANQUEROS	5482091	3408
2835	LA VERDE	LA VERDE	5482091	\N
2836	LAGUNA VERDE	LAGUNA VERDE	5482091	\N
2837	PUJATO NORTE	PUJATO NORTE	5482070	3496
2838	COLONIA PUJOL	COLONIA PUJOL	5482070	3496
2839	ESPERANZA	ESPERANZA	5482070	3496
2840	LA ORILLA	LA ORILLA	5482070	\N
2841	LARRECHEA	LARRECHEA	5482070	\N
2842	PASO VINAL	PASO VINAL	5482063	\N
2843	PUEBLO ABC	PUEBLO ABC	5482070	\N
2844	RINCON DEL PINTADO	RINCON DEL PINTADO	5482070	\N
2845	CAVOUR	CAVOUR	5482070	3496
2846	COLONIA LA NUEVA	COLONIA LA NUEVA	5482070	\N
2847	HUMBOLDT	HUMBOLDT	5482070	3496
2848	HUMBOLDT CHICO	HUMBOLDT CHICO	5482070	3496
2849	RIVADAVIA	RIVADAVIA	5482070	\N
2850	GRUTLY	GRUTLY	5482070	3496
2851	GRUTLY NORTE	GRUTLY NORTE	5482070	\N
2852	PILAR	PILAR	5482070	3404
2853	FELICIA	FELICIA	5482070	3496
2854	NUEVO TORINO	NUEVO TORINO	5482070	3496
5370	CAMPO GOLA	CAMPO GOLA	5482049	\N
5371	CAMPO URDANIZ	CAMPO URDANIZ	5482049	\N
5372	CAMPO VERGE	CAMPO VERGE	5482049	\N
5375	FLORENCIA	FLORENCIA	5482049	3482
5377	LAS MERCEDES	LAS MERCEDES	5482049	\N
5380	PUERTO PIRACUA	PUERTO PIRACUA	5482049	\N
5490	GATO COLORADO	GATO COLORADO	5482077	3491
5521	VELAZQUEZ	VELAZQUEZ	5482133	\N
5522	VERA	VERA	5482133	3483
5523	CAÑADA OMBU	CAÑADA OMBU	5482133	3482
5524	CAMPO MONTE LA VIRUELA	CAMPO MONTE LA VIRUELA	5482133	\N
5525	COLMENA	COLMENA	5482133	\N
5526	DESVIO KILOMETRO 282	DESVIO KILOMETRO 282	5482133	\N
5528	DESVIO KILOMETRO 392	DESVIO KILOMETRO 392	5482049	\N
5529	ESTANCIA LA GOLONDRINA	ESTANCIA LA GOLONDRINA	5482133	\N
5530	GARABATO	GARABATO	5482133	3482
5531	GOLONDRINA	GOLONDRINA	5482133	3483
5532	GUAYCURU	GUAYCURU	5482133	\N
5533	INTIYACO	INTIYACO	5482133	3482
5537	LA BLANCA	LA BLANCA	5482998	\N
5538	LA SELVA	LA SELVA	5482049	\N
5539	LA ZULEMA	LA ZULEMA	5482049	\N
5540	LAS DELICIAS	LAS DELICIAS	5482049	\N
5541	LOS AMORES	LOS AMORES	5482133	3482
5542	LOS CLAROS	LOS CLAROS	5482049	\N
5543	LOS LEONES	LOS LEONES	5482049	\N
5544	LOS TABANOS	LOS TABANOS	5482133	\N
5545	OGILVIE	OGILVIE	5482133	3483
5546	POZO DE LOS INDIOS	POZO DE LOS INDIOS	5482133	\N
5547	SANTA FELICIA	SANTA FELICIA	5482133	\N
5548	TOBA	TOBA	5482133	\N
5549	ÑANDU	ÑANDU	5482091	\N
5551	COLONIA DURAN	COLONIA DURAN	5482098	\N
5552	COLONIA EL TOBA	COLONIA EL TOBA	5482098	\N
5553	COLONIA SAGER	COLONIA SAGER	5482098	\N
5554	COSTA DEL TOBA	COSTA DEL TOBA	5482133	\N
5556	FORTIN CHILCAS	FORTIN CHILCAS	5482133	\N
5557	FORTIN OLMOS	FORTIN OLMOS	5482133	3483
5560	SANTA LUCIA	SANTA LUCIA	5482133	\N
5561	CAMPO HUBER	CAMPO HUBER	5482098	\N
5562	LA LOMA	LA LOMA	5482098	\N
5563	LAS PALMAS	LAS PALMAS	5482049	\N
5564	LOS CUERVOS	LOS CUERVOS	5482098	\N
5565	NUEVA ROMANG	NUEVA ROMANG	5482098	3482
5566	ROMANG	ROMANG	5482098	3482
5567	CARAGUATAY	CARAGUATAY	5482133	\N
5569	LA ESMERALDA	LA ESMERALDA	5482049	\N
5570	RECONQUISTA	RECONQUISTA	5482049	3482
5571	AVELLANEDA	AVELLANEDA	5482049	3482
5572	EL CARMEN DE AVELLANEDA	EL CARMEN DE AVELLANEDA	5482049	3482
5573	EL TIMBO	EL TIMBO	5482049	\N
5574	EWALD	EWALD	5482049	\N
5575	LA VANGUARDIA	LA VANGUARDIA	5482049	\N
5576	MOUSSY	MOUSSY	5482049	3482
5577	COLONIA SAN MANUEL	COLONIA SAN MANUEL	5482049	3482
5578	EL ARAZA	EL ARAZA	5482049	3482
5579	LA POTASA	LA POTASA	5482049	\N
5580	LA SARITA	LA SARITA	5482049	3482
5581	NICANOR E. MOLINAS	NICANOR E. MOLINAS	5482049	3482
5582	VICTOR MANUEL II	VICTOR MANUEL II	5482049	3482
5583	ARROYO DEL REY	ARROYO DEL REY	5482049	\N
5584	EL TAJAMAR	EL TAJAMAR	5482133	\N
5585	FLORIDA	FLORIDA	5482049	\N
5588	LA JOSEFINA	LA JOSEFINA	5482049	\N
5589	SAN ALBERTO	SAN ALBERTO	5482049	\N
5590	TARTAGAL	TARTAGAL	5482133	3482
5593	LA LOLA	LA LOLA	5482049	3482
5594	LOS LAURELES	LOS LAURELES	5482049	\N
5595	PUERTO RECONQUISTA	PUERTO RECONQUISTA	5482049	3482
5596	CAMPO EL ARAZA	CAMPO EL ARAZA	5482049	\N
5597	CAMPO FURRER	CAMPO FURRER	5482049	\N
5599	DOCTOR BARROS PAZOS	DOCTOR BARROS PAZOS	5482049	3482
5600	LA CELIA 	LA CELIA 	5482049	\N
5601	LA DIAMELA	LA DIAMELA	5482049	\N
5602	CAMPO GARABATO	CAMPO GARABATO	5482049	\N
5603	CAMPO RAMSEYER	CAMPO RAMSEYER	5482049	\N
5604	COLONIA ALTHUAUS	COLONIA ALTHUAUS	5482049	\N
5605	COLONIA ELLA	COLONIA ELLA	5482049	\N
5606	COLONIA SANTA CATALINA	COLONIA SANTA CATALINA	5482049	\N
5607	EL RICARDITO	EL RICARDITO	5482049	\N
5608	LA CATALINA	LA CATALINA	5482098	\N
5609	MALABRIGO	MALABRIGO	5482049	3482
5610	CAPILLA GUADALUPE NORTE	CAPILLA GUADALUPE NORTE	5482049	\N
5611	GUADALUPE NORTE	GUADALUPE NORTE	5482049	\N
5612	LAS GARZAS	LAS GARZAS	5482049	3482
5613	ARROYO CEIBAL	ARROYO CEIBAL	5482049	3482
5614	CAMPO GRANDE	CAMPO GRANDE	5482049	\N
5615	CAMPO SIETE PROVINCIAS	CAMPO SIETE PROVINCIAS	5482049	3482
5617	EL CEIBALITO	EL CEIBALITO	5482049	\N
5618	EL TAPIALITO	EL TAPIALITO	5482049	\N
5619	FLOR DE ORO	FLOR DE ORO	5482049	3482
5620	INGENIERO CHANOURDIE	INGENIERO CHANOURDIE	5482049	3482
5621	LANTERI	LANTERI	5482049	3482
5622	LAS SIETE PROVINCIAS	LAS SIETE PROVINCIAS	5482049	3482
5623	LOS LAPACHOS	LOS LAPACHOS	5482049	\N
5624	SANTA ANA	SANTA ANA	5482049	\N
5626	PUERTO OCAMPO	PUERTO OCAMPO	5482049	\N
5627	SAN VICENTE	SAN VICENTE	5482049	\N
5628	VILLA OCAMPO	VILLA OCAMPO	5482049	3482
5629	CAMPO REDONDO	CAMPO REDONDO	5482049	\N
5631	GUASUNCHO	GUASUNCHO	5482049	3482
5632	ISLETA	ISLETA	5482049	\N
5634	LA RESERVA	LA RESERVA	5482049	\N
5635	MOCOVI	MOCOVI	5482049	\N
5636	VILLA ADELA	VILLA ADELA	5482049	\N
5637	VILLA ANA (ESTACION)	VILLA ANA	5482049	3482
5638	ISLA TIGRE	ISLA TIGRE	5482049	\N
5639	KM 41 (DPTO. GRAL. OBLIGADO)	KM 41 (DPTO. GRAL. OBLIGADO)	5482049	\N
5641	EL SOMBRERITO	EL SOMBRERITO	5482049	\N
5644	LA CLARITA	LA CLARITA	5482049	\N
5645	PAUL GROUSSAC	PAUL GROUSSAC	5482049	\N
5646	CAMPO YAGUARETE	CAMPO YAGUARETE	5482049	\N
5649	LAS TOSCAS	LAS TOSCAS	5482049	3482
5650	YAGUARETE	YAGUARETE	5482049	\N
5651	SAN ANTONIO DE OBLIGADO	SAN ANTONIO DE OBLIGADO	5482049	3482
5652	TACUARENDI	TACUARENDI	5482049	3482
5654	KM 49 (VILLA GUILLERMINA-DPTO.	KM 49 (VILLA GUILLERMINA-DPTO. VERA)	5482133	\N
5656	OBRAJE INDIO MUERTO	OBRAJE INDIO MUERTO	5482049	\N
5657	OBRAJE SAN JUAN	OBRAJE SAN JUAN	5482049	\N
5658	POTRERO GUASUNCHO	POTRERO GUASUNCHO	5482049	\N
5659	VILLA GUILLERMINA	VILLA GUILLERMINA	5482049	3482
5660	CAMPO HARDY	CAMPO HARDY	5482049	3482
5661	EL RABON	EL RABON	5482049	\N
5662	PUERTO PIRACUACITO	PUERTO PIRACUACITO	5482049	\N
13467	BERNA	BERNA	5482049	3482
15274	SAN MARCELO	SAN MARCELO	5482042	\N
15275	TEODELINA	TEODELINA	5482042	3462
15313	DIEGO DE ALVEAR	DIEGO DE ALVEAR	5482042	3382
15315	CHRISTOPHERSEN	CHRISTOPHERSEN	5482042	\N
15359	LA INES	LA INES	5482042	\N
15360	RUFINO	RUFINO	5482042	3382
15361	VILLA ROSELLO	VILLA ROSELLO	5482042	3382
15366	AMENABAR	AMENABAR	5482042	\N
15367	EL REFUGIO	EL REFUGIO	5482042	\N
15368	LA ADELAIDA	LA ADELAIDA	5482042	\N
15370	LAZZARINO	LAZZARINO	5482042	3382
15371	TARRAGONA	TARRAGONA	5482042	\N
15374	AARON CASTELLANOS	AARON CASTELLANOS	5482042	3382
15375	CORONEL ROSETI	CORONEL ROSETI	5482042	\N
15376	EL ALBERDON	EL ALBERDON	5482042	\N
15378	LA ASTURIANA	LA ASTURIANA	5482042	\N
15379	LA CALMA	LA CALMA	5482042	\N
15380	LAS DOS ANGELITAS	LAS DOS ANGELITAS	5482042	\N
15381	MIRAMAR	MIRAMAR	5482042	\N
15382	SAN CARLOS	SAN CARLOS	5482070	\N
15383	SANTA PAULA	SANTA PAULA	5482042	\N
15384	SANTA TERESA	SANTA TERESA	5482042	\N
50341	VILLA LA RIBERA	VILLA LA RIBERA	5482056	3382
50427	LOS JACINTOS	LOS JACINTOS	5482098	3405
2525	SANTA ROSA DE CALCHINES	SANTA ROSA DE CALCHINES	5482035	342
1680	CASTELAR	CASTELAR	5482126	\N
2669	LA PENCA Y CARAGUATA	LA PENCA Y CARAGUATA	5482112	3498
1401	TENIENTE HIPOLITO BOUCHARD	TENIENTE HIPOLITO BOUCHARD	5482998	\N
1431	BARRIO BOUCHARD	BARRIO BOUCHARD	5482998	\N
2588	BARRIO IRIONDO	BARRIO IRIONDO	5482998	\N
1268	BARRIO GENERAL JOSE DE SAN MAR	BARRIO GENERAL JOSE DE SAN MARTIN	5482998	\N
1269	BARRIO MERCEDES DE SAN MARTIN	BARRIO MERCEDES DE SAN MARTIN	5482998	\N
1270	BARRIO REMEDIOS DE ESCALADA DE	BARRIO REMEDIOS DE ESCALADA DE SAN MARTI	5482998	\N
1271	BARRIO TABLADA	BARRIO TABLADA	5482998	\N
1325	TALLERES (PARADA FCGM)	TALLERES (PARADA FCGM)	5482998	\N
1327	VILLA LYLY TALLERES (GORTON)	VILLA LYLY TALLERES (GORTON)	5482998	\N
1335	BARRIO TALLERES	BARRIO TALLERES	5482998	\N
1350	POSTA DE SAN MARTIN	POSTA DE SAN MARTIN	5482998	\N
1351	AERO CLUB ROSARIO (APEADERO FC	AERO CLUB ROSARIO (APEADERO FCGM)	5482998	\N
1353	GRANADERO B. BARGAS (APEADERO 	GRANADERO B. BARGAS (APEADERO FCGM)	5482998	\N
1355	LINKS (PARADA)	LINKS (PARADA)	5482998	\N
1361	SEMINO (DESVIO PARTICULAR FCGM	SEMINO (DESVIO PARTICULAR FCGM)	5482998	\N
1363	FROILAN PALACIOS	FROILAN PALACIOS	5482998	\N
1371	VICENTE A. ECHEVARRIA	VICENTE A. ECHEVARRIA	5482998	\N
1365	KM 323	KM 323	5482998	\N
1386	BARRIO EL PARAISO	BARRIO EL PARAISO	5482998	\N
1387	BARRIO SAN FERNANDO	BARRIO SAN FERNANDO	5482998	\N
1388	ESTACION AERONAUTICA PAGANINI	ESTACION AERONAUTICA PAGANINI	5482998	\N
1391	BARRIO VILLA EL PRADO	BARRIO VILLA EL PRADO	5482998	\N
1394	KM 319 (APEADERO FCGM)	KM 319 (APEADERO FCGM)	5482998	\N
1400	GRANADEROS (PARADA FCGM)	GRANADEROS (PARADA FCGM)	5482998	\N
1404	BARRIO NUEVA ROMA	BARRIO NUEVA ROMA	5482998	\N
1405	BARRIO TRIPOLI	BARRIO TRIPOLI	5482998	\N
1424	COLONIA TOSCANA 1A.	COLONIA TOSCANA 1A.	5482998	\N
1425	COLONIA TOSCANA 2A.	COLONIA TOSCANA 2A.	5482998	\N
1432	BARRIO EL PINO	BARRIO EL PINO	5482998	\N
1438	BARRIO BELLA VISTA	BARRIO BELLA VISTA	5482998	\N
1440	CULLEN (APEADERO FCGM)	CULLEN (APEADERO FCGM)	5482998	\N
1441	EL TRANSITO (EMBARCADERO FCGM)	EL TRANSITO (EMBARCADERO FCGM)	5482998	\N
1489	OROÑO	OROÑO	5482998	\N
1496	GRANADERO BASILIO BUSTOS	GRANADERO BASILIO BUSTOS	5482998	\N
1498	CAMPO QUIÑONES	CAMPO QUIÑONES	5482998	\N
1499	SANTA CLARA	SANTA CLARA	5482998	\N
1501	BARRIO PUZZI	BARRIO PUZZI	5482998	\N
1502	BARRIO VILLA ROSA	BARRIO VILLA ROSA	5482998	\N
1519	ZANETTI (DESVIO)	ZANETTI (DESVIO)	5482998	\N
1521	ANGELICA VIEJA	ANGELICA VIEJA	5482998	\N
1522	KM 85	KM 85	5482998	\N
1524	NUEVA LEHMANN	NUEVA LEHMANN	5482998	\N
1526	CAMPO DARDATTI	CAMPO DARDATTI	5482998	\N
1530	NUEVA ROMA	NUEVA ROMA	5482998	\N
1533	ADOLFO ALSINA	ADOLFO ALSINA	5482998	\N
1541	CUATRO CASAS	CUATRO CASAS	5482998	\N
1545	SEIS CASAS	SEIS CASAS	5482998	\N
1547	WAVELBERG	WAVELBERG	5482998	\N
1559	CABAÑA EL CISNE	CABAÑA EL CISNE	5482998	\N
1585	CAMPO BOTTO	CAMPO BOTTO	5482998	\N
1675	BARRIO SAN LUIS	BARRIO SAN LUIS	5482998	\N
1685	CAMPO TORNQUISTON	CAMPO TORNQUISTON	5482998	\N
1697	KM 113 (FCGB)	KM 113 (FCGB)	5482998	\N
1698	LA FLORIDA	LA FLORIDA	5482998	\N
1700	KM 501	KM 501	5482998	\N
1811	BARRIO ORTIZ	BARRIO ORTIZ	5482998	\N
1831	KM 443 (EMBARCADERO FCGB)	KM 443 (EMBARCADERO FCGB)	5482998	\N
1833	KM 465	KM 465	5482998	\N
1834	KM 483	KM 483	5482998	\N
1848	KM 49 (APEADERO FCGM) (CORREA-	KM 49 (APEADERO FCGM) (CORREA-DPTO. IRIO	5482998	\N
1867	COLONIA LANDETA	COLONIA LANDETA	5482998	\N
1944	SAN FRANCISCO DE VENADO TUERTO	SAN FRANCISCO DE VENADO TUERTO	5482998	\N
1947	RASTREADOR FOURNIER (ESTACION 	RASTREADOR FOURNIER (ESTACION FCGM)	5482998	\N
1950	ENCADENADAS	ENCADENADAS	5482998	\N
1973	BARRIO CASADO	BARRIO CASADO	5482998	\N
1978	DURHAM (APEADERO FCGM)	DURHAM (APEADERO FCGM)	5482998	\N
1985	COLONIA LA CATALANA	COLONIA LA CATALANA	5482998	\N
1991	COLONIA LA PALENCIA	COLONIA LA PALENCIA	5482998	\N
1992	COLONIA LA PELLEGRINA	COLONIA LA PELLEGRINA	5482998	\N
1998	GOMEZ	GOMEZ	5482998	\N
2127	CAMINERA GRAL. LOPEZ	CAMINERA GRAL. LOPEZ	5482998	\N
2142	BALNEARIO MELINCUE	BALNEARIO MELINCUE	5482998	\N
2501	BARRIO CABAÑA LEIVA	BARRIO CABAÑA LEIVA	5482998	\N
2502	BARRIO CIUDADELA	BARRIO CIUDADELA	5482998	\N
2503	BARRIO LOS HORNOS	BARRIO LOS HORNOS	5482998	\N
2504	BARRIO NUEVE DE JULIO	BARRIO NUEVE DE JULIO	5482998	\N
2505	BARRIO PRESIDENTE ROQUE SAENZ 	BARRIO PRESIDENTE ROQUE SAENZ PEÑA	5482998	\N
2506	BARRIO PROGRESISTAS	BARRIO PROGRESISTAS	5482998	\N
2507	BARRIO SAN LORENZO	BARRIO SAN LORENZO	5482998	\N
2508	BARRIO SCARAFFIA	BARRIO SCARAFFIA	5482998	\N
2509	BARRIO SUD (SANTA FE-DPTO. LA 	BARRIO SUD (SANTA FE-DPTO. LA CAPITAL)	5482998	\N
2510	BARRIO TRANSPORTES	BARRIO TRANSPORTES	5482998	\N
2511	BARRIO VILLA DEL PARQUE	BARRIO VILLA DEL PARQUE	5482998	\N
2512	BARRIO VILLA MARIA SELVA	BARRIO VILLA MARIA SELVA	5482998	\N
2513	CARCEL PUBLICA	CARCEL PUBLICA	5482998	\N
2514	HOSPITAL PSIQUIATRICO SANTA FE	HOSPITAL PSIQUIATRICO SANTA FE	5482998	\N
2515	KM 9 (APEADERO FCGB)	KM 9 (APEADERO FCGB)	5482998	\N
2524	BARRIO LA GUARDIA	BARRIO LA GUARDIA	5482998	\N
2537	ISLA DEL PORTEÑO	ISLA DEL PORTEÑO	5482998	\N
2543	RUINAS-SANTA FE-LA VIEJA	RUINAS-SANTA FE-LA VIEJA	5482998	\N
2553	LOS CARDENALES (APEADERO FCGB)	LOS CARDENALES (APEADERO FCGB)	5482998	\N
2580	KM 28 C (APEADERO FCGB)	KM 28 C (APEADERO FCGB)	5482998	\N
2581	KM 35 (APEADERO FCGB)	KM 35 (APEADERO FCGB)	5482998	\N
2584	POMPEYA (APEADERO FCGB)	POMPEYA (APEADERO FCGB)	5482998	\N
2586	SETUBAL (APEADERO FCGB)	SETUBAL (APEADERO FCGB)	5482998	\N
2587	YAMANDU (APEADERO FCGB)	YAMANDU (APEADERO FCGB)	5482998	\N
2589	BARRIO SAN IGNACIO DE LOYOLA	BARRIO SAN IGNACIO DE LOYOLA	5482998	\N
2590	BARRIO VILLA LUJAN	BARRIO VILLA LUJAN	5482998	\N
2602	BARRIO AMPLIACION SUD	BARRIO AMPLIACION SUD	5482998	\N
2603	BARRIO VILLA TALLERES	BARRIO VILLA TALLERES	5482998	\N
2604	CAMPO SANTO DOMINGO (APEADERO 	CAMPO SANTO DOMINGO (APEADERO FCGM)	5482998	\N
2605	KM 41 (APEADERO FCGB) (LAGUNA 	KM 41 (APEADERO FCGB) (LAGUNA PAIVA-DPTO	5482998	\N
2613	SAN PEDRO	SAN PEDRO	5482998	\N
2618	KM 49 (MANUCHO)	KM 49 (MANUCHO)	5482998	\N
2621	RINCON DE AVILA	RINCON DE AVILA	5482998	\N
2623	TOMAS ALVA EDISON (APEADERO FC	TOMAS ALVA EDISON (APEADERO FCGB)	5482998	\N
2644	RIO SALADO (APEADERO FCGB)	RIO SALADO (APEADERO FCGB)	5482998	\N
2646	LAS SEMENTERAS	LAS SEMENTERAS	5482998	\N
2647	AVICHUCHO	AVICHUCHO	5482998	\N
2652	ÑANDUBAY	ÑANDUBAY	5482998	\N
2664	COLONIA CRESPO	COLONIA CRESPO	5482998	\N
2676	KM 95	KM 95	5482998	\N
2678	LAS CAÑAS	LAS CAÑAS	5482998	\N
2694	KM 213	KM 213	5482998	\N
2697	LUIS D'ABREU	LUIS D'ABREU	5482998	\N
2702	CAÑADITA	CAÑADITA	5482998	\N
2721	LA CIGUEÑA	LA CIGUEÑA	5482998	\N
2725	PAVENHAM	PAVENHAM	5482998	\N
2729	ESTANCIA LA CIGUEÑA	ESTANCIA LA CIGUEÑA	5482998	\N
2734	INDEPENDENCIA (EMBARCADERO FCG	INDEPENDENCIA (EMBARCADERO FCGB)	5482998	\N
2745	KM 389	KM 389	5482998	\N
2746	KM 421 (DPTO. 9 DE JULIO)	KM 421 (DPTO. 9 DE JULIO)	5482998	\N
2747	KM 468 (EMBARCADERO FCGB)	KM 468 (EMBARCADERO FCGB)	5482998	\N
2811	KM 293 (FCGB)	KM 293 (FCGB)	5482998	\N
2814	BARRIO PALERMO	BARRIO PALERMO	5482998	\N
2834	KM 235 (FCGB)	KM 235 (FCGB)	5482998	\N
5519	BARRIO SAN MARTIN	BARRIO SAN MARTIN	5482998	\N
5520	JOBSON	JOBSON	5482998	\N
5527	DESVIO KILOMETRO 366	DESVIO KILOMETRO 366	5482998	\N
5534	KM 302	KM 302	5482998	\N
5535	KM 320	KM 320	5482998	\N
5536	KM 392 (EMBARCADERO FCGB)	KM 392 (EMBARCADERO FCGB)	5482998	\N
5550	CAMPO DURAND	CAMPO DURAND	5482098	\N
5555	EL 17	EL 17	5482998	\N
5558	PARAJE 29	PARAJE 29	5482998	\N
5559	SAN ROQUE	SAN ROQUE	5482998	\N
5568	BARRIO MARIANO MORENO	BARRIO MARIANO MORENO	5482998	\N
5586	KM 17 (DESVIO FCGB)	KM 17 (DESVIO FCGB)	5482998	\N
5587	KM 30 (FCGB)	KM 30 (FCGB)	5482998	\N
5591	BARRIO AERONAUTICO RECONQUISTA	BARRIO AERONAUTICO RECONQUISTA	5482998	\N
5592	DESTACAMENTO AERONAUTICO MILIT	DESTACAMENTO AERONAUTICO MILITAR RECONQU	5482998	\N
5598	DESVIO DOCTOR BARROS PAZOS	DESVIO DOCTOR BARROS PAZOS	5482998	\N
5616	DISTRITO TRES ISLETAS	DISTRITO TRES ISLETAS	5482998	\N
5625	KM 408 (DESVIO PARTICULAR FCGB	KM 408 (DESVIO PARTICULAR FCGB)	5482998	\N
5633	KM 67	KM 67	5482998	\N
5642	KM 403	KM 403	5482998	\N
5643	KM 421 (DESVIO PART.FCGB)(EL S	KM 421 (DESVIO PART.FCGB)(EL SOMBRERITO-	5482049	\N
5647	INGENIO GARMENDIA	INGENIO GARMENDIA	5482998	\N
5648	INGENIO GERMANIA	INGENIO GERMANIA	5482998	\N
5653	KM 23	KM 23	5482998	\N
5655	KM 54	KM 54	5482998	\N
15314	LA PICASA (APEADERO FCGSM)	LA PICASA (APEADERO FCGSM)	5482998	\N
15369	LA CONSTANCIA	LA CONSTANCIA	5482998	\N
15377	KM 396 (FCGSM)	KM 396 (FCGSM)	5482998	\N
\.


--
-- Data for Name: niveles_instruccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY niveles_instruccion (id, nombre) FROM stdin;
1	Universitario
2	Tersiario
3	Secundario
4	Primaria
5	Analfabeto
\.


--
-- Data for Name: oficio_respuestas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY oficio_respuestas (id, id_oficio, respuesta) FROM stdin;
\.


--
-- Data for Name: oficios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY oficios (id, nro_emision, nro_recepcion, fecha_emision, fecha_recepcion, destino, persona, tiempo_respuesta, contestado, fecha_respuesta, habilitado, id_expediente) FROM stdin;
1	543	66666	2015-07-09	2015-07-24	Oficina principal de mesa de entrada	Josesito	15	f	\N	\N	30
2	1	100	2015-08-03	2015-08-04	niñez	alguien	15	t	2015-08-19	\N	55
3	5343	\N	\N	\N	\N	\N	\N	f	\N	\N	114
5	342	\N	\N	\N	\N	\N	\N	f	\N	\N	120
6	546	444	\N	2015-10-07	5454	\N	\N	f	\N	\N	31
8	15	123	2015-11-12	2015-11-15	destino	persona	15	t	2015-11-24	\N	133
\.


--
-- Name: oficios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('oficios_id_seq', 9, true);


--
-- Data for Name: oficios_notas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY oficios_notas (id, id_expediente, fecha_inicio, fecha_recepcion, id_tipo_oficio) FROM stdin;
\.


--
-- Data for Name: oficios_recibidos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY oficios_recibidos (id, id_expediente, fecha_ingreso, organismo, organismo_dep, nro_emision, solicitud) FROM stdin;
\.


--
-- Name: oficios_recibidos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('oficios_recibidos_id_seq', 1, false);


--
-- Data for Name: organismos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY organismos (nombre) FROM stdin;
Ministerio de Seguridad
Ministerio de Salud
Ministerio de Desarrollo Social
Ministerio de Educación
Municipalidad
Defensoría del Pueblo
Poder Judicial 
Ministerio de Justicia y Derechos Humanos
INADI
ONG
Otro
Obras Sociales
Municipios y/o Comunas
Organismos nacionales
\.


--
-- Data for Name: organismos_dep; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY organismos_dep (organismo, dependencia) FROM stdin;
Ministerio de Salud	Hospital
Ministerio de Salud	Centro de salud
Ministerio de Desarrollo Social	Subsecretaria de la Niñez
Ministerio de Desarrollo Social	Adolescencia y Familia
Ministerio de Desarrollo Social	Dirección de Políticas de Género
Ministerio de Desarrollo Social	Dirección de Adultos Mayores
Ministerio de Educación	Socioeducativo
Ministerio de Educación	Escuela Publica/Privada
Municipalidad	Salud
Municipalidad	Desarrollo Social
Municipalidad	Mujer y Diversidad Sexual
Municipalidad	Educación
Municipalidad	Distritos
Defensoría del Pueblo	Defensoría de Niños, Niñas y Adolescentes
Defensoría del Pueblo	Mediación
Defensoría del Pueblo	Dirección de Gestión e Instrucción
Defensoría del Pueblo	Defensa del Consumidor
Defensoría del Pueblo	Salud
Poder Judicial 	Ministerio Público de la Acusación
Municipalidad	ECINA
Municipalidad	Área Mujer
Municipalidad	Diversidad Sexual
Ministerio de Seguridad	Comisarias
Ministerio de Seguridad	Policía Comunitaria
Ministerio de Seguridad	Delitos Complejos
Ministerio de Seguridad	Sistema Penitenciario
Ministerio de Salud	SAMCO
Ministerio de Salud	Subsecretaría de Inclusión para personas con discapacidad
Ministerio de Salud	Dirección de Salud Mental
Ministerio de Salud	Centro de Orientación en Adicciones
Ministerio de Desarrollo Social	Centro de Acción Familiar
Ministerio de Desarrollo Social	Centro de Desarrollo Zonal
Ministerio de Desarrollo Social	Hogares
Ministerio de Desarrollo Social	Dirección de prevención de adicciones
Ministerio de Educación	Jardines de Infantes
Municipalidad	Equipos locales de Niñez
Municipalidad	Adultos Mayores
Defensoría del Pueblo	Delegaciones
Poder Judicial 	Ministerio Público de la Defensa
Poder Judicial 	Juzgado de Familia
Poder Judicial 	Juzgado de Instrucción
Poder Judicial 	Juzgado Correccional
Poder Judicial 	Juzgado de Sentencia
Poder Judicial 	Juzgado de Menores
Poder Judicial 	Ministerio Público Fiscal Unidad de Información y Atención de Víctimas y Denunciantes
Poder Judicial 	Defensoría Zonal
Poder Judicial 	Defensoría General
Poder Judicial 	Juzgado de ejecución Penal
Ministerio de Justicia y Derechos Humanos	Centro de Asistencia Judicial
Ministerio de Justicia y Derechos Humanos	Secretaria de Derechos Humanos
Ministerio de Justicia y Derechos Humanos	Dirección de Justicia Penal Juvenil
Organismos nacionales	Juzgado Federal
Organismos nacionales	Consejo Nacional de las Mujeres
Organismos nacionales	Secretaría Nacional de Niñez Adolescencia y Familia
Organismos nacionales	Gerencia de empleo
Organismos nacionales	ANSESS
Organismos nacionales	Centro de Acceso a la Justicia
Organismos nacionales	INADI
\.


--
-- Data for Name: origenes_presentaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY origenes_presentaciones (nombre) FROM stdin;
\.


--
-- Data for Name: paises; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY paises (id, nombre, id_continente, codigo_iso) FROM stdin;
9999	Africa SIN Definir	AF	  
9998	America SIN Definir	AM	  
9997	Asia SIN Definir	AS	  
9996	Europa SIN Definir	EU	  
9995	Oceania SIN Definir	OC	  
1	Estados Unidos	AM	us
2	Canadá	AM	el
3	Puerto Rico	AM	pr
4	República Dominicana	AM	rd
5	Jamaica	AM	jm
7	Rusia	EU	ru
20	Egipto	AF	eg
27	Sudáfrica	AF	sa
30	Grecia	EU	gr
31	Holanda	EU	nl
32	Bélgica	EU	be
33	Francia	EU	fr
34	España	EU	es
36	Hungría	EU	hu
39	Italia	EU	it
40	Rumania	EU	ro
41	Suiza	EU	ch
43	Austria	EU	at
44	Reino Unido	EU	gb
45	Dinarmarca	EU	dk
46	Suecia	EU	se
47	Noruega	EU	no
48	Polonia	EU	pl
49	Alemania	EU	dw
51	Perú	AM	pe
52	México	AM	mx
53	Cuba	AM	cu
54	Argentina	AM	ar
55	Brasil	AM	br
56	Chile	AM	cl
57	Colombia	AM	co
58	Venezuela	AM	ve
60	Malasia	OC	my
61	Australia	OC	au
62	Indonesia	OC	id
63	Filipinas	OC	ph
64	Nueva Zelanda	OC	nz
65	Singapur	OC	sg
66	Tailandia	OC	th
81	Japón	AS	jp
82	Corea del Sur	AS	kr
84	Vietnam	AS	vn
86	China	AS	cn
90	Turquía	AS	tr
91	India	AS	in
92	Pakistán	AS	pk
93	Afganistán	AS	af
94	Sri Lanka	AS	lk
95	Myanmar (ex Birmania)	AS	mm
98	Irán	AS	ir
212	Marruecos	AF	ma
213	Argelia	AF	dz
216	Túnez	AF	tn
218	Libia	AF	ly
220	Gambia	AF	gm
221	Senegal	AF	sn
222	Mauritania	AF	mr
223	Malí	AF	ml
224	Guinea	AF	gn
225	Costa de Marfil	AF	ci
226	Burkina Faso	AF	bf
227	Níger	AF	ne
229	Benin	AF	bj
230	Mauricio	AF	mu
231	Liberia	AF	lr
232	Sierra Leona	AF	sl
233	Ghana	AF	gh
234	Nigeria	AF	ng
235	Chad	AF	td
236	República Centroafricana	AF	cf
237	Camerún	AF	cm
238	Cabo Verde	AF	cv
239	Santo Tomé y Príncipe	AF	st
240	Guinea Ecuatorial	AF	gq
241	Gabón	AF	ga
242	Congo	AF	cg
243	República Democrática del Congo	AF	zr
244	Angola	AF	ao
245	Guinea-Bissau	AF	gw
249	Sudán	AF	sd
250	Ruanda	AF	rw
252	Somalia	AF	so
254	Kenia	AF	ke
255	Tanzania	AF	tz
256	Uganda	AF	ug
257	Burundi	AF	bi
258	Mozambique	AF	mz
260	Zambia	AF	zm
261	Madagascar	AF	md
262	Reunión	AF	re
263	Zimbabwe	AF	zw
264	Namibia	AF	na
265	Malawi	AF	mw
266	Lesotho	AF	ls
267	Botswana	AF	bw
268	Swazilandia	AF	sz
269	Comoras	AF	km
290	Santa Helena	AF	sh
291	Eritrea	AF	er
351	Portugal	EU	pt
352	Luxemburgo	EU	lu
353	Irlanda	EU	ie
354	Islandia	EU	is
355	Albania	EU	al
356	Malta	EU	mt
357	Chipre	EU	cy
358	Finlandia	EU	fi
359	Bulgaria	EU	bg
370	Lituania	EU	lt
371	Letonia	EU	lv
372	Estonia	EU	ee
373	Moldova	EU	md
374	Armenia	EU	am
375	Bielorrusia	EU	by
376	Andorra	EU	ad
377	Mónaco	EU	mc
378	San Marino	EU	sm
379	Ciudad del Vatanico	EU	va
380	Ucrania	EU	ua
381	Serbia	EU	rs
385	Croacia	EU	hr
386	Eslovenia	EU	si
387	Bosnia y Herzegovina	EU	ba
389	Macedonia	EU	mk
420	República Checa	EU	cz
421	Eslovaquia	EU	sk
423	Liechtenstein	EU	li
501	Belice	AM	bz
502	Guatemala	AM	gt
503	El Salvador	AM	sv
504	Honduras	AM	hn
505	Nicaragua	AM	ni
506	Costa Rica	AM	cr
507	Panamá	AM	pa
509	Haití	AM	ht
591	Bolivia	AM	bo
592	Guyana	AM	gy
593	Ecuador	AM	ec
594	Guayana Francesa	AM	gf
595	Paraguay	AM	py
596	Martinica	AM	mq
597	Surinam	AM	sr
598	Uruguay	AM	uy
599	Antillas Holandesas	AM	an
672	Isla Norfolk	AS	nf
673	Brunei	AS	bn
674	Nauru	OC	nr
675	Papua Nueva Guinea	OC	pg
676	Tonga	OC	to
677	Islas Salomón	OC	sb
678	Vanuatu	OC	vt
679	Fidji	OC	fj
680	Palau	OC	pw
685	Samoa Occidental	OC	ws
686	Kiribati	OC	ki
687	Nueva Caledonia	OC	nc
688	Tuvalu	OC	tv
689	Polinesia Francesa	OC	pf
690	Tokelau	OC	tk
691	Estados Federados de Micronesia	OC	fm
692	Islas Marshall	OC	mh
850	Corea del Norte	AS	kp
853	Macao	AS	mo
856	Laos	AS	la
880	Bangladesh	AS	bd
886	Taiwan	AS	tw
960	Maldivas	AS	mv
961	Líbano	AS	lb
962	Jordania	AS	jo
963	Siria	AS	sy
964	Irak	AS	iq
965	Kuwait	AS	kw
966	Arabia Saudita	AS	sa
967	Yemen R.A.	AS	ye
968	Omán	AS	om
971	Emiratos Arabes Unidos	AS	ae
972	Israel	AS	il
973	Bahrein	AS	bh
974	Qatar	AS	qa
975	Bhután	AS	bt
976	Mongolia	AS	mn
977	Nepal	AS	np
993	Turkmenistán	AS	tm
994	Azerbaiyán	AS	az
995	Georgia	AS	ge
998	Uzbekistán	AS	uz
868	Trinidad y Tobago	AM	tt
1268	Antigua y Barbuda	AM	ag
1242	Bahamas	AM	bs
1246	Barbados	AM	bb
1767	Dominica	AM	dm
1473	Granada	AM	gd
1869	San Cristóbal y Nevis	AM	kn
1784	San Vicente y Granadinas	AM	vc
1758	Santa Lucía	AM	lc
992	Tadjikistán	AS	tj
996	Kirguistán	AS	kg
77	Kazajstán	AS	kz
670	Timor Oriental	AS	tl
382	Montenegro	EU	me
253	Djibouti	AF	dj
251	Etiopía	AF	et
248	Seychelles	AF	sc
228	Togo	AF	tg
855	Camboya	AS	kh
283	Sudán del Sur	AF	ss
\.


--
-- Data for Name: personal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY personal (id, apellido, nombre, telefono, area, profesional) FROM stdin;
1	Freud	Sigmud	4646544	CAV-Psicología	t
3	Ekman	Paul	55565643	CAV-Psicología	t
6	Schmidt	Shirley	555687878	Abogacía	t
4	Crane	Denny	543543	Abogacía	t
5	Shore	Alan	423423	Abogacía	t
8	Colombo	Analía Isabel	000	Defensora De Niñas, Niños Y Adolescentes	f
7	Leiva	Luciano Agustin	000	Defensor Del Pueblo Adjunto. Zona Norte	f
9	Asensio	Carolina	1	Lic. en Psicología	t
10	Bassó	Octavio	1	Lic. en Psicología	t
11	Boeri	Marisa	1	Lic. en Psicología	t
12	Castro	Norma	1	Lic. en Trabajo Social	t
13	Maillot	Andrea	1	Lic. en Trabajo Social	t
14	Manzi	Laura	1	Lic. en Psicología	t
15	Minitti	Celeste	1	Abogada	t
16	Nadalich	Silvia	1	Lic. en Trabajo Social	t
17	Nallim	Carlos	1	Abogado	t
18	Noseda	Lucia	1	Lic. en Psicología	t
20	Romano	Adriana	1	Lic. en Trabajo Social	t
21	Vessoni	Paula	1	Lic. en Psicología	t
22	Berdat	Elizabeth	1	Mesa de Entrada	f
23	Gross	María Isabel	1	Mesa de Entrada	f
19	Pons	Mercedes Enriqueta	1	Abogada	t
\.


--
-- Data for Name: personas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY personas (id, id_genero, id_estado_civil, id_documento_tipo, id_pais_nacimiento, id_distrito, id_localidad, id_nivel_instruccion, id_barrio, documento_nro, apellido, nombre, fecha_nacimiento, lugar_nacimiento, nacionalidad, domicilio_real, propietario_inmueble, telefono, mail, ocupacion, necesidades_especiales, beneficios_sociales, redes_sociales_institucionales, titulo, antecedente_violencia, beneficio_auh, beneficio_tarjeta_ciudadana, beneficio_pension_no_contributiva, beneficio_jubilacion, beneficio_cuota_alimentaria, tipo_ocupacion) FROM stdin;
3	1	2	6	93	\N	15374	1	\N	123	Borges	Jorge Luis	\N	\N	\N	\N	f	\N	\N	\N	true	false	\N	\N	f	\N	\N	\N	\N	\N	\N
2	1	2	2	93	\N	15374	3	\N	7898	Cortázar	Julio	\N	\N	\N	\N	f	\N	\N	\N	false	false	\N	\N	f	\N	\N	\N	\N	\N	\N
5	1	2	6	54	\N	1273	\N	\N	987985423	Martin	George	1948-11-20	\N	\N	\N	f	\N	\N	\N	false	false	\N	\N	f	\N	\N	\N	\N	\N	\N
7	1	3	5	54	\N	1273	\N	\N	ff6846846846	Heinlein	Robert	1907-07-07	\N	\N	\N	f	dasda	\N	\N	false	false	\N	\N	f	\N	\N	\N	\N	\N	\N
6	1	2	4	54	\N	1273	\N	\N	4654654654	Pratchet	Terry	1948-04-28	\N	\N	\N	f	\N	\N	\N	false	false	\N	Sir	f	\N	\N	\N	\N	\N	\N
9	1	1	5	54	\N	1273	\N	\N	dsfsdfsd	Niven	Larry	1938-04-30	\N	\N	\N	f	\N	\N	\N	false	false	\N	\N	f	\N	\N	\N	\N	\N	\N
10	2	2	6	93	1	15374	5	106	gsdf	gdsf	gsdf	2015-07-15	\N	\N	\N	f	\N	\N	\N	false	false	\N	\N	f	\N	\N	\N	\N	\N	\N
11	2	2	6	93	1	15374	5	106	432424234	jacobson	pablo	\N	\N	\N	\N	f	\N	\N	\N	false	false	\N	\N	f	\N	\N	\N	\N	\N	\N
12	1	2	6	54	1	1273	3	106	464565465	Gaiman	Neil	\N	\N	\N	\N	f	\N	\N	\N	false	false	\N	\N	f	\N	\N	\N	\N	\N	\N
4	1	2	2	54	1	1273	\N	1	18113175	de la Peña	Marcelo	1966-07-06	\N	\N	\N	f	4586504	mail@pepe.com	\N	false	false	\N	Sr.	f	\N	\N	\N	\N	\N	\N
13	2	\N	2	54	\N	2518	\N	\N	56656565	Rodriguez	Juan	1990-08-05	\N	\N	\N	t	\N	\N	\N	false	false	\N	\N	f	\N	\N	\N	\N	\N	\N
14	2	2	2	54	2	2518	\N	\N	342	Gomez	Sara	2008-07-10	\N	\N	\N	f	4576789	\N	\N	false	false	\N	\N	f	\N	\N	\N	\N	\N	\N
15	2	\N	2	54	2	2518	\N	3	567	Ramirez	Susana	2004-07-05	\N	\N	\N	f	\N	\N	\N	false	false	\N	\N	f	\N	\N	\N	\N	\N	\N
16	1	1	2	54	2	2518	1	2	33069069	Gomez	Ignacio	1987-11-05	santa fe	Argentino	algo 123	t	4373737	igna@gmail.com	proyect manager	true	true	alguna	Ingeniero	f	\N	\N	\N	\N	\N	\N
17	\N	\N	2	54	\N	1273	\N	\N	trtrtrt	twer	trew	\N	\N	\N	\N	f	\N	\N	\N	false	false	\N	\N	f	\N	\N	\N	\N	\N	\N
18	1	\N	2	54	2	2518	\N	8	12.256.236	Fabían	Gomez	\N	\N	Argentino	San Martin 2323	f	4578969	\N	Profesor	true	true	\N	\N	t	\N	\N	\N	\N	\N	\N
19	\N	\N	1	\N	\N	\N	\N	\N	5654564	Roman	Jorge	\N	\N	\N	Aca	\N	4546	fdfd@ere.ca	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N
20	\N	\N	2	54	\N	1273	\N	\N	fsafd	mas	uno	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N
21	\N	\N	2	\N	\N	\N	\N	\N	25858752	Funes	Debora	\N	\N	\N	Las Flores I Mon. 16 Depto 14	\N	155236185	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N
22	\N	\N	2	54	1	1273	4	\N	34567890	Gomez	Carlos	\N	\N	\N	San lorenzo 3333	f	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	2
23	\N	\N	2	\N	\N	\N	\N	\N	17516284	Poldi	Silvina	\N	\N	\N	B° El Pozo	\N	4576897	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N
25	\N	\N	2	\N	\N	\N	\N	\N	89776	Gomez	Raul	\N	\N	\N	Las heras 3452	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N
24	2	\N	2	54	8	2518	1	7	123	Rojas	Claudia	1994-10-28	Chubut	Argentina	Eva Perón 2787	t	76985	\N	Empleada municipal	no	\N	Participa de la vecinal del b°	\N	t	f	f	f	t	f	1
26	\N	\N	2	\N	\N	\N	\N	\N	87654321	Hernandez	Maria Ines	\N	\N	\N	Tucumán 1332	\N	0341-154897652	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N
28	\N	\N	2	\N	\N	\N	\N	\N	20.567.342	Hernandez	Maria Ines	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N
29	\N	\N	2	\N	\N	\N	\N	\N	23.120.120	Vallejos	Oscar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N
1	2	1	2	54	\N	1273	1	\N	4546546	Sabato	Ernesto	1997-10-15	\N	Argentino - Colombiana	\N	f	\N	\N	\N	\N	\N	vecinal	Dr.	t	t	t	t	t	t	1
30	\N	\N	2	\N	\N	\N	\N	\N	45678987	Garcia	Silvina	\N	\N	\N	Eva Perón 2726	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N
31	2	\N	2	54	2	2518	1	2	34.546.879	Roche	Maria	1996-11-15	\N	\N	9 de Julio 2345	f	4356713	mariaroche@hotmail.com	\N	\N	\N	\N	\N	f	t	f	f	f	f	\N
32	\N	\N	2	\N	\N	\N	\N	\N	33333333	Manera	Federico Iván	\N	\N	\N	calle 123	\N	4444444	adfe@hotmail.com	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N
33	\N	\N	2	\N	\N	\N	\N	\N	2222222222222	DominguezRivero	asdasdsdasd	\N	\N	\N	as	\N	as	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N
34	\N	\N	2	\N	\N	\N	\N	\N	3434124312	Dominguez Rivero	asdwedwd	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N
8	2	4	5	54	\N	1273	\N	\N	dsdadasdasd	Rice	Anne	1941-01-04	\N	\N	\N	f	\N	\N	\N	\N	false	\N	\N	f	f	f	f	f	f	\N
\.


--
-- Data for Name: procedencias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY procedencias (id, nombre) FROM stdin;
3	De oficio
2	Oficio Judicial
4	Derivación
1	Espontánea
\.


--
-- Data for Name: profesionales_intervenciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY profesionales_intervenciones (id, intervencion_id, profesional_id, nada) FROM stdin;
1	1	1	 
2	1	6	 
3	2	1	 
4	2	6	 
5	2	3	 
6	8	6	 
\.


--
-- Name: profesionales_intervenciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('profesionales_intervenciones_id_seq', 6, true);


--
-- Data for Name: provincias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY provincias (id, id_pais, nombre) FROM stdin;
102	1	Alabama
104	1	Alaska
105	1	Arizona
107	1	Arkansas
108	1	California
110	1	Colorado
111	1	Connecticut
113	1	Delaware
114	1	Florida
116	1	Georgia
117	1	Hawaii
119	1	Idaho
120	1	Illinois
122	1	Indiana
123	1	Iowa
125	1	Kansas
126	1	Kentucky
128	1	Louisiana
129	1	Maine
131	1	Maryland
132	1	Massachusetts
134	1	Michigan
135	1	Minnesota
137	1	Mississippi
138	1	Missouri
140	1	Montana
141	1	Nebraska
143	1	Nevada
144	1	New Hampshire
146	1	New Jersey
147	1	New Mexico
149	1	New York
150	1	North Carolina
152	1	North Dakota
153	1	Ohio
155	1	Oklahoma
156	1	Oregon
158	1	Pennsylvania
159	1	Rhode Island
161	1	South Carolina
162	1	South Dakota
164	1	Tennessee
165	1	Texas
167	1	Utah
168	1	Vermont
170	1	Virginia
171	1	Washington
173	1	West Virginia
174	1	Wisconsin
176	1	Wyoming
180	1	Distrito de Columbia
202	2	Alberta
204	2	Columbia Británica
207	2	Isla del Principe Eduardo
208	2	Manitoba
210	2	Nuevo Brunswick
212	2	Nueva Escocia
214	2	Nunavut
216	2	Ontario
218	2	Quebec
220	2	Saskatchewan
222	2	Terranova y Labrador
224	2	Territorios del Noroeste
226	2	Yukon
4002	4	Azua
4004	4	Bahoruco
4006	4	Barahona
4008	4	Dajabón
4010	4	Duarte
4012	4	Elías Piña
4014	4	El Seibo
4016	4	Espaillat
4018	4	Hato Mayor
4020	4	Hermanas Mirabal
4022	4	Independencia
4024	4	La Altagracia
4026	4	La Romana
4028	4	La Vega
4030	4	María Trinidad Sánchez
4032	4	Monseñor Nouel
4034	4	Montecristi
4036	4	Monte Plata
4038	4	Pedernales
4040	4	Peravia
4042	4	Puerto Plata
4044	4	Samaná
4046	4	Sánchez Ramírez
4048	4	San Cristóbal
4050	4	San José de Ocoa
4054	4	San Juan
4056	4	San Pedro de Macorís
4058	4	Santiago
4060	4	Santiago Rodríguez
4062	4	Santo Domingo
4064	4	Valverde
4066	4	Distrito Nacional
701	7	Adiguesia
702	7	Altai - República
703	7	Bashkortostan
704	7	Buriatia
705	7	Carelia
706	7	Chechenia
707	7	Chuvasia
708	7	Daguestán
709	7	Ingusetia
710	7	Jakasia
711	7	Kabardino-Balkaria
712	7	Kalmukia
713	7	Karacháevo-Cherkesia
714	7	Komi
715	7	Mari El
716	7	Mordovia
717	7	Osetia del Norte - Alania
718	7	Saja
719	7	Tartaristán
720	7	Tuva
721	7	Udmurtia
722	7	Altai - Territorio
723	7	Jabarovsk
724	7	Kamchatka
725	7	Krasnodar
726	7	Krasnoyarsk
727	7	Perm
728	7	Primorie
729	7	Stavropol
730	7	Zabaikalski
731	7	Amur
732	7	Arkangelsk
733	7	Astrakan
734	7	Belgorod
735	7	Briansk
736	7	Cheliabinsk
737	7	Irkutsk
738	7	Ivanovo
739	7	Kaliningrado
740	7	Kaluga
741	7	Kemerovo
742	7	Kirov
743	7	Kostroma
744	7	Kurgan
745	7	Kursk
746	7	Leningrado
747	7	Lipetsk
748	7	Magadan
749	7	Moscú
750	7	Murmansk
751	7	Nizhni Novgorod
752	7	Novgorod
753	7	Novosibirsk
754	7	Omsk
755	7	Orel
756	7	Oremburgo
757	7	Penza
758	7	Pskov
759	7	Ryazan
760	7	Rostov
761	7	Sajalin
762	7	Samara
763	7	Saratov
764	7	Smolensk
765	7	Sverdlovsk
766	7	Tambov
767	7	Tiumen
768	7	Tomsk
769	7	Tula
770	7	Tver
771	7	Ulianovsk
772	7	Vladimir
773	7	Volgogrado
774	7	Vologda
775	7	Voronezh
776	7	Yaroslavl
778	7	Provincia Autónoma Hebrea
779	7	Chukotka
780	7	Janti-Mansi
781	7	Nenetsia
782	7	Yamalo-Nénets
783	7	San Petersburgo
784	7	Moscú - Ciudad Autónoma
3101	31	Holanda Meridional (Zuid-Holland)
3102	31	Holanda Septentrional (Noord-Holland)
3103	31	Drenthe
3104	31	Flevoland
3105	31	Frisia (Fryslân)
3106	31	Gelderland
3107	31	Groninga (Groningen)
3108	31	Limburg
3109	31	Brabante Septentrional (Noord-Brabant)
3110	31	Overijssel
3111	31	Utrecht
3112	31	Zelanda (Zeeland)
3201	32	Amberes
3204	32	Brabante Flamenco
3208	32	Brabante Valón
3212	32	Bruselas
3216	32	Flandes Oriental
3220	32	Flandes Occidental
3224	32	Hainaut
3228	32	Lieja
3232	32	Limburgo
3236	32	Luxemburgo
3240	32	Namur
3301	33	Alsacia
3305	33	Alta Normandía
3309	33	Aquitania
3313	33	Auvernia
3317	33	Borgoña
3321	33	Bretaña
3325	33	Centro
3329	33	Champaña-Ardenas
3333	33	Córcega
3337	33	Franco Condado
3341	33	Isla de Francia
3345	33	Limousin
3349	33	Languedoc-Rosellón
3353	33	Lorena
3357	33	Mediodía-Pirineos
3361	33	Norte-Paso de Calais
3367	33	Baja Normandía
3371	33	País del Loira
3373	33	Picardía
3375	33	Poitou-Charente
3379	33	Provenza-Alpes-Costa Azul
3383	33	Ródano-Alpes
3387	33	Guadalupe
3391	33	Martinica
3395	33	Guayana
3399	33	Reunión
3405	34	Andalucía
3410	34	Aragón
3415	34	Asturias
3420	34	Cantabria
3425	34	Castilla - La Mancha
3430	34	Castilla - León
3435	34	Catalunya
3440	34	Extremadura
3445	34	Galicia
3450	34	Islas Baleares
3455	34	Islas Canarias
3460	34	La Rioja
3465	34	Madrid
3470	34	Murcia
3475	34	Navarra
3480	34	País Vasco - Euskadi
3485	34	Valencia
3490	34	Ceuta
3495	34	Melilla
3904	39	Abruzos
3908	39	Apulia
3912	39	Basilicata
3916	39	Calabria
3920	39	Campania
3924	39	Cerdeña
3928	39	Emilia - Romaña
3932	39	Friul - Venecia Julia
3936	39	Las Marcas
3940	39	Lacio
3944	39	Liguria
3948	39	Lombardía
3952	39	Molise
3956	39	Piamonte
3960	39	Sicilia
3964	39	Toscana
3968	39	Trentino - Alto Adigio
3972	39	Umbría
3976	39	Valle de Aosta
3980	39	Véneto
4101	41	Sin Provincias
4401	44	Greater London
4402	44	East Midlands
4403	44	East of England
4404	44	North East England
4405	44	North West England
4406	44	South East England
4407	44	South West England
4408	44	West Midlands
4409	44	Yorkshire and the Humber
4430	44	Escocia (Scotland)
4450	44	Gales (Wales)
4470	44	Irlanda del Norte (Northern Ireland)
4906	49	Baden-Wurtemberg (Baden-Württemberg)
4912	49	Baja Sajonia (Niedersachsen)
4918	49	Baviera (Bayern)
4924	49	Berlín
4930	49	Brandeburgo (Brandenburg)
4936	49	Bremen
4942	49	Hamburgo (Hamburg)
4948	49	Hesse (Hessen)
4954	49	Mecklemburgo-Pomerania Occidental (Mecklenburg-Vorpommern)
4960	49	Renania del Norte-Westfalia (Nordrhein-Westfalen)
4966	49	Renania-Palatinado (Rheinland-Pfalz)
4972	49	Sajonia (Sachsen)
4975	49	Sajonia-Anhalt (Sachsen-Anhalt)
4978	49	Sarre (Saarland)
4984	49	Schleswig-Holstein
4990	49	Turingia (Thüringen)
5104	51	AMAZONAS
5108	51	ANCASH
5112	51	APURIMAC
5116	51	AREQUIPA
5120	51	AYACUCHO
5124	51	CAJAMARCA
5126	51	CALLAO
5128	51	CUZCO
5132	51	HUANUCO
5136	51	HUANCAVELICA
5140	51	ICA
5144	51	JUNIN
5148	51	LA LIBERTAD
5152	51	LAMBAYEQUE
5156	51	LIMA
5160	51	LORETO
5164	51	MADRE DE DIOS
5168	51	MOQUEGUA
5172	51	PASCO
5176	51	PIURA
5180	51	PUNO
5184	51	SAN MARTIN
5188	51	TACNA
5192	51	TUMBES
5196	51	UCAYALI
5203	52	Aguascalientes
5206	52	Baja California Norte
5209	52	Baja California Sur
5212	52	Campeche
5215	52	Chiapas
5218	52	Chihuahua
5221	52	Coahuila
5224	52	Colima
5227	52	Distrito Federal
5230	52	Durango
5233	52	Estado de Mexico
5236	52	Guanajuato
5239	52	Guerrero
5242	52	Hidalgo
5245	52	Jalisco
5248	52	Michoacán
5251	52	Morelos
5254	52	Nayarit
5257	52	Nuevo León
5260	52	Oaxaca
5263	52	Puebla
5266	52	Querétaro
5269	52	Quintana Roo
5272	52	San Luis Potosí
5275	52	Sinaloa
5278	52	Sonora
5281	52	Tabasco
5284	52	Tamaulipas
5287	52	Tlaxcala
5290	52	Veracruz
5293	52	Yucatán
5296	52	Zacatecas
53002	53	Artemisa 
53004	53	Camagüey 
53006	53	Ciego de Ávila 
53008	53	Cienfuegos 
53010	53	Granma 
53012	53	Guantánamo 
53014	53	Holguín 
53016	53	La Habana 
53018	53	Las Tunas 
53020	53	Matanzas 
53022	53	Mayabeque 
53024	53	Pinar del Río 
53026	53	Sancti Spíritus 
53028	53	Santiago de Cuba 
53030	53	Villa Clara 
53032	53	Isla de la Juventud 
5402	54	Ciudad Autónoma de Buenos Aires
5406	54	Buenos Aires
5410	54	Catamarca
5414	54	Córdoba
5418	54	Corrientes
5422	54	Chaco
5426	54	Chubut
5430	54	Entre Ríos
5434	54	Formosa
5438	54	Jujuy
5442	54	La Pampa
5446	54	La Rioja
5450	54	Mendoza
5454	54	Misiones
5458	54	Neuquén
5462	54	Río Negro
5466	54	Salta
5470	54	San Juan
5474	54	San Luis
5478	54	Santa Cruz
5482	54	Santa Fe
5486	54	Santiago del Estero
5490	54	Tucumán
5494	54	Tierra del Fuego, Antártida e Islas del Atlántico Sur
5503	55	Acre
5506	55	Alagoas
5509	55	Amapá
5512	55	Amazonas
5515	55	Bahia
5518	55	Ceará
5521	55	Distrito Federal
5524	55	Espírito Santo
5527	55	Goiás
5530	55	Maranhão
5533	55	Mato Grosso
5536	55	Mato Grosso do Sul
5539	55	Minas Gerais
5542	55	Pará
5545	55	Paraíba
5548	55	Paraná
5551	55	Pernambuco
5554	55	Piauí
5557	55	Rio de Janeiro
5560	55	Rio Grande do Norte
5563	55	Rio Grande do Sul
5566	55	Rondônia
5569	55	Roraima
5572	55	Santa Catarina
5575	55	São Paulo
5578	55	Sergipe
5581	55	Tocantins
5607	56	AISEN DEL GENERAL CARLOS IBAÑEZ DEL CAMPO
5614	56	ANTOFAGASTA
5621	56	ARAUCANIA
5625	56	ARICA Y PARINACOTA
5628	56	ATACAMA
5635	56	BIOBIO
5642	56	COQUIMBO
5649	56	LIBERTADOR GENERAL BERNARDO O´HIGGINS
5653	56	LOS RIOS
5656	56	LOS LAGOS
5663	56	MAGALLANES Y LA ANTARTICA CHILENA
5670	56	MAULE
5677	56	METROPOLITANA DE SANTIAGO
5684	56	TARAPACA
5691	56	VALPARAISO
5703	57	Amazonas
5706	57	Antioquia
5709	57	Arauca
5712	57	Atlántico
5716	57	Bogotá
5719	57	Bolívar
5722	57	Boyacá
5725	57	Caldas
5728	57	Caquetá
5732	57	Casanare
5735	57	Cauca
5738	57	César
5741	57	Chocó
5744	57	Córdoba
5748	57	Cundinamarca
5751	57	Guaviare
5752	57	Guainía
5754	57	Huila
5757	57	La Guajira
5760	57	Magdalena
5764	57	Meta
5767	57	Nariño
5770	57	Norte de Santander
5773	57	Putumayo
5776	57	Quindió
5780	57	Risaralda
5783	57	San Andrés y Providencia
5786	57	Santander
5789	57	Sucre
5792	57	Tolima
5796	57	Valle del Cauca
5797	57	Vaupés
5799	57	Vichada
5803	58	Amazonas
5806	58	Anzoátegui
5809	58	Apure
5812	58	Aragua
5815	58	Barinas
5818	58	Bolívar
5821	58	Carabobo
5824	58	Cojedes
5827	58	Delta Amacuro
5830	58	Dependencias Federales
5833	58	Distrito Capital
5836	58	Falcón
5839	58	Guárico
5842	58	Lara
5845	58	Mérida
5848	58	Miranda
5851	58	Monagas
5854	58	Nueva Esparta
5857	58	Portuguesa
5860	58	Sucre
5863	58	Táchira
5866	58	Trujillo
5869	58	Vargas
5872	58	Yaracuy
5875	58	Zulia
6405	64	Auckland
6410	64	Bahía de los Halcones
6415	64	Bahía de Plenty
6420	64	Canterbury
6425	64	Costa Oeste
6430	64	Gisborne
6435	64	Islas Chatham
6440	64	Manauatu-Uanganui
6445	64	Marlborough
6450	64	Nelson
6455	64	Otago
6460	64	Región del Norte
6465	64	Región del Sur
6470	64	Taranaki
6475	64	Tasmania
6480	64	Waikato
6485	64	Wellington
8102	81	Aichi
8104	81	Akita
8106	81	Aomori
8108	81	Chiba
8110	81	Ehime
8112	81	Fukui
8114	81	Fukuoka
8116	81	Fukushima
8118	81	Gifu
8120	81	Gunma
8122	81	Hiroshima
8124	81	Hokkaido
8126	81	Hyogo
8128	81	Ibaraki
8130	81	Ishikawa
8132	81	Iwate
8134	81	Kagawa
8136	81	Kagoshima
8138	81	Kanagawa
8140	81	Kochi
8142	81	Kumamoto
8144	81	Kyoto
8146	81	Mie
8148	81	Miyagi
8150	81	Miyazaki
8152	81	Nagano
8154	81	Nagasaki
8156	81	Nara
8158	81	Niigata
8160	81	Oita
8162	81	Okayama
8164	81	Okinawa
8166	81	Osaka
8168	81	Saga
8170	81	Saitama
8172	81	Shiga
8174	81	Shimane
8176	81	Shizuoka
8178	81	Tochigi
8180	81	Tokushima
8182	81	Tokio
8184	81	Tottori
8186	81	Toyama
8188	81	Wakayama
8190	81	Yamagata
8192	81	Yamaguchi
8194	81	Yamanashi
8209	82	Seúl (Ciudad Capital)
8218	82	Gyeonggi
8227	82	Gangwon
8236	82	Chungcheong del Norte
8245	82	Chungcheong del Sur
8254	82	Jeolla del Norte
8263	82	Jeolla del Sur
8272	82	Gyeongsang del Norte
8281	82	Gyeongsang del Sur
8290	82	Jeju
35303	353	Carlow
35306	353	Cavan
35309	353	Clare
35315	353	Donegal
35318	353	Dublin
35321	353	Galway
35324	353	Kerry
35327	353	Kildare
35330	353	Kilkenny
35333	353	Laois
35336	353	Leitrim
35339	353	Limerick
35342	353	Longford
35345	353	Louth
35348	353	Mayo
35351	353	Meath
35354	353	Monaghan
35357	353	Offaly
35360	353	Roscommon
35363	353	Sligo
35369	353	Waterford
35372	353	Westmeath
35375	353	Wexford
35378	353	Wicklow
35366	353	North Tipperary
35368	353	South Tipperary
35312	353	Cork
50401	504	Atlántida
50404	504	Colón
50407	504	Comayagua
50410	504	Copán
50413	504	Cortés
50416	504	Choluteca
50419	504	El Paraíso
50422	504	Francisco Morazán
50425	504	Gracias a Dios
50428	504	Intibucá
50431	504	Islas de la Bahía
50434	504	La Paz
50437	504	Lempira
50440	504	Ocotepeque
50443	504	Olancho
50446	504	Santa Bárbara
50449	504	Valle
50452	504	Yoro
50613	506	Alajuela
50626	506	Cartago
50639	506	Guanacaste
50652	506	Heredia
50665	506	Limón
50678	506	Puntarenas
50691	506	San José
59102	591	Beni 
59103	591	Chuquisaca
59104	591	Cochabamba
59105	591	La Paz 
59106	591	Oruro 
59107	591	Pando 
59108	591	Potosí 
59109	591	Santa Cruz 
59110	591	Tarija 
59304	593	AZUAY
59308	593	BOLIVAR
59312	593	CAÑAR
59316	593	CARCHI
59320	593	CHIMBORAZO
59324	593	COTOPAXI
59328	593	EL ORO
59332	593	ESMERALDAS
59336	593	GALAPAGOS
59340	593	GUAYAS
59344	593	IMBABURA
59348	593	LOJA
59352	593	LOS RIOS
59356	593	MANABI
59360	593	MORONA SANTIAGO
59364	593	NAPO
59368	593	ORELLANA
59372	593	PASTAZA
59376	593	PICHINCHA
59377	593	SANTA ELENA
59379	593	SANTO DOMINGO DE LOS TSACHILAS
59380	593	SUCUMBIOS
59384	593	TUNGURAHUA
59388	593	ZAMORA CHINCHIPE
59501	595	Sin Provincias
59801	598	Sin Provincias
96601	966	Riyadh
97201	972	Central
97204	972	Haifa
97207	972	Norte
97210	972	Jerusalén
97213	972	Meridional
97216	972	Tel Aviv
999998	9999	Indeterminada
999898	9998	Indeterminada
999798	9997	Indeterminada
999698	9996	Indeterminada
999598	9995	Indeterminada
198	1	Indeterminada
298	2	Indeterminada
398	3	Indeterminada
498	4	Indeterminada
598	5	Indeterminada
798	7	Indeterminada
2098	20	Indeterminada
2798	27	Indeterminada
3098	30	Indeterminada
3198	31	Indeterminada
3298	32	Indeterminada
3398	33	Indeterminada
3498	34	Indeterminada
3698	36	Indeterminada
3998	39	Indeterminada
4098	40	Indeterminada
4198	41	Indeterminada
4398	43	Indeterminada
4498	44	Indeterminada
4598	45	Indeterminada
4698	46	Indeterminada
4798	47	Indeterminada
4898	48	Indeterminada
4998	49	Indeterminada
5198	51	Indeterminada
5298	52	Indeterminada
5398	53	Indeterminada
5498	54	Indeterminada
5598	55	Indeterminada
5698	56	Indeterminada
5798	57	Indeterminada
5898	58	Indeterminada
6098	60	Indeterminada
6198	61	Indeterminada
6298	62	Indeterminada
6398	63	Indeterminada
6498	64	Indeterminada
6598	65	Indeterminada
6698	66	Indeterminada
8198	81	Indeterminada
8298	82	Indeterminada
8498	84	Indeterminada
8698	86	Indeterminada
9098	90	Indeterminada
9198	91	Indeterminada
9298	92	Indeterminada
9398	93	Indeterminada
9498	94	Indeterminada
9598	95	Indeterminada
9898	98	Indeterminada
21298	212	Indeterminada
21398	213	Indeterminada
21698	216	Indeterminada
21898	218	Indeterminada
22098	220	Indeterminada
22198	221	Indeterminada
22298	222	Indeterminada
22398	223	Indeterminada
22498	224	Indeterminada
22598	225	Indeterminada
22698	226	Indeterminada
22798	227	Indeterminada
22998	229	Indeterminada
23098	230	Indeterminada
23198	231	Indeterminada
23298	232	Indeterminada
23398	233	Indeterminada
23498	234	Indeterminada
23598	235	Indeterminada
23698	236	Indeterminada
23798	237	Indeterminada
23898	238	Indeterminada
23998	239	Indeterminada
24098	240	Indeterminada
24198	241	Indeterminada
24298	242	Indeterminada
24398	243	Indeterminada
24498	244	Indeterminada
24598	245	Indeterminada
24998	249	Indeterminada
25098	250	Indeterminada
25298	252	Indeterminada
25498	254	Indeterminada
25598	255	Indeterminada
25698	256	Indeterminada
25798	257	Indeterminada
25898	258	Indeterminada
26098	260	Indeterminada
26198	261	Indeterminada
26298	262	Indeterminada
26398	263	Indeterminada
26498	264	Indeterminada
26598	265	Indeterminada
26698	266	Indeterminada
26798	267	Indeterminada
26898	268	Indeterminada
26998	269	Indeterminada
29098	290	Indeterminada
29198	291	Indeterminada
35198	351	Indeterminada
35298	352	Indeterminada
35398	353	Indeterminada
35498	354	Indeterminada
35598	355	Indeterminada
35698	356	Indeterminada
35798	357	Indeterminada
35898	358	Indeterminada
35998	359	Indeterminada
37098	370	Indeterminada
37198	371	Indeterminada
37298	372	Indeterminada
37398	373	Indeterminada
37498	374	Indeterminada
37598	375	Indeterminada
37698	376	Indeterminada
37798	377	Indeterminada
37898	378	Indeterminada
37998	379	Indeterminada
38098	380	Indeterminada
38198	381	Indeterminada
38598	385	Indeterminada
38698	386	Indeterminada
38798	387	Indeterminada
38998	389	Indeterminada
42098	420	Indeterminada
42198	421	Indeterminada
42398	423	Indeterminada
50198	501	Indeterminada
50298	502	Indeterminada
50398	503	Indeterminada
50498	504	Indeterminada
50598	505	Indeterminada
50698	506	Indeterminada
50798	507	Indeterminada
50998	509	Indeterminada
59198	591	Indeterminada
59298	592	Indeterminada
59398	593	Indeterminada
59498	594	Indeterminada
59598	595	Indeterminada
59698	596	Indeterminada
59798	597	Indeterminada
59898	598	Indeterminada
59998	599	Indeterminada
67298	672	Indeterminada
67398	673	Indeterminada
67498	674	Indeterminada
67598	675	Indeterminada
67698	676	Indeterminada
67798	677	Indeterminada
67898	678	Indeterminada
67998	679	Indeterminada
68098	680	Indeterminada
68598	685	Indeterminada
68698	686	Indeterminada
68798	687	Indeterminada
68898	688	Indeterminada
68998	689	Indeterminada
69098	690	Indeterminada
69198	691	Indeterminada
69298	692	Indeterminada
85098	850	Indeterminada
85398	853	Indeterminada
85698	856	Indeterminada
88098	880	Indeterminada
88698	886	Indeterminada
96098	960	Indeterminada
96198	961	Indeterminada
96298	962	Indeterminada
96398	963	Indeterminada
96498	964	Indeterminada
96598	965	Indeterminada
96698	966	Indeterminada
96798	967	Indeterminada
96898	968	Indeterminada
97198	971	Indeterminada
97298	972	Indeterminada
97398	973	Indeterminada
97498	974	Indeterminada
97598	975	Indeterminada
97698	976	Indeterminada
97798	977	Indeterminada
99398	993	Indeterminada
99498	994	Indeterminada
99598	995	Indeterminada
99898	998	Indeterminada
86898	868	Indeterminada
126898	1268	Indeterminada
124298	1242	Indeterminada
124698	1246	Indeterminada
176798	1767	Indeterminada
147398	1473	Indeterminada
186998	1869	Indeterminada
178498	1784	Indeterminada
175898	1758	Indeterminada
99298	992	Indeterminada
99698	996	Indeterminada
7798	77	Indeterminada
67098	670	Indeterminada
38298	382	Indeterminada
25398	253	Indeterminada
25198	251	Indeterminada
24898	248	Indeterminada
22898	228	Indeterminada
85598	855	Indeterminada
28398	283	Indeterminada
\.


--
-- Data for Name: relatos_observaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY relatos_observaciones (id, relato, id_expediente) FROM stdin;
\.


--
-- Data for Name: resoluciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY resoluciones (id, id_expediente, fecha) FROM stdin;
\.


--
-- Data for Name: resoluciones_relatos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY resoluciones_relatos (id, id_resolucion, relato) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY roles (id, nombre) FROM stdin;
1	Victima
2	Victimario
3	Testigo
4	Parte en conflicto
5	Otro
\.


--
-- Data for Name: roles_vinculos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY roles_vinculos (id, id_expediente, id_persona, id_rol, id_vinculo, edad, cantidad_hijos, observacion, convive, antecedente_violencia, es_presentante, ocupacion, otro_dato) FROM stdin;
17	30	2	3	7	\N	\N	\N	f	f	t	\N	\N
21	33	3	3	6	\N	\N	\N	t	t	t	\N	\N
101	129	31	\N	\N	\N	\N	\N	f	f	t	\N	\N
102	133	32	1	8	28	0	\N	f	f	t	ing	otro dato
24	35	13	1	8	22	5	\N	t	t	t	\N	\N
25	37	13	1	8	\N	\N	\N	f	f	t	\N	\N
26	38	15	\N	\N	\N	\N	\N	f	f	t	\N	\N
27	37	3	3	5	\N	\N	\N	f	t	t	\N	\N
28	39	8	3	5	\N	\N	\N	f	f	t	\N	\N
29	41	3	\N	\N	\N	\N	\N	f	f	t	\N	\N
30	42	1	\N	\N	\N	\N	\N	f	f	t	\N	\N
31	46	8	\N	\N	\N	\N	\N	f	f	t	\N	\N
32	47	8	\N	\N	\N	\N	\N	f	f	t	\N	\N
33	48	2	\N	\N	\N	\N	\N	f	f	t	\N	\N
34	50	5	\N	\N	\N	\N	\N	f	f	t	\N	\N
35	52	10	\N	\N	\N	\N	\N	f	f	t	\N	\N
36	53	5	\N	\N	\N	\N	\N	f	f	t	\N	\N
37	54	8	\N	\N	\N	\N	\N	f	f	t	\N	\N
38	30	1	3	5	\N	\N	\N	f	f	f	\N	\N
40	55	1	1	6	10	0	\N	f	f	f	\N	\N
39	55	16	3	7	28	2	\N	t	t	t	\N	\N
41	56	10	\N	\N	\N	\N	\N	f	f	t	\N	\N
42	57	5	\N	\N	\N	\N	\N	f	f	t	\N	\N
43	58	5	\N	\N	\N	\N	\N	f	f	t	\N	\N
44	59	13	\N	\N	\N	\N	\N	f	f	t	\N	\N
45	60	3	\N	\N	\N	\N	\N	f	f	t	\N	\N
46	61	2	\N	\N	\N	\N	\N	f	f	t	\N	\N
103	133	10	2	11	29	0	\N	f	t	f	\N	\N
104	134	18	\N	\N	\N	\N	\N	f	f	t	\N	\N
20	32	2	1	8	\N	\N	\N	f	f	t	\N	\N
47	66	18	\N	\N	\N	\N	\N	f	f	t	\N	\N
48	68	5	\N	\N	\N	\N	\N	f	f	t	\N	\N
49	77	16	\N	\N	\N	\N	\N	f	f	t	\N	\N
50	79	18	\N	\N	\N	\N	\N	f	f	t	\N	\N
51	80	16	\N	\N	\N	\N	\N	f	f	t	\N	\N
52	81	10	\N	\N	\N	\N	\N	f	f	t	\N	\N
53	82	16	\N	\N	\N	\N	\N	f	f	t	\N	\N
54	83	5	\N	\N	\N	\N	\N	f	f	t	\N	\N
55	84	3	\N	\N	\N	\N	\N	f	f	t	\N	\N
56	85	16	\N	\N	\N	\N	\N	f	f	t	\N	\N
57	86	3	\N	\N	\N	\N	\N	f	f	t	\N	\N
58	87	16	\N	\N	\N	\N	\N	f	f	t	\N	\N
59	88	10	\N	\N	\N	\N	\N	f	f	t	\N	\N
60	89	13	\N	\N	\N	\N	\N	f	f	t	\N	\N
61	90	18	\N	\N	\N	\N	\N	f	f	t	\N	\N
62	91	10	\N	\N	\N	\N	\N	f	f	t	\N	\N
63	92	3	\N	\N	\N	\N	\N	f	f	t	\N	\N
64	93	10	\N	\N	\N	\N	\N	f	f	t	\N	\N
65	94	16	\N	\N	\N	\N	\N	f	f	t	\N	\N
66	94	13	\N	\N	\N	\N	\N	f	f	t	\N	\N
68	95	3	\N	\N	\N	\N	\N	f	f	t	\N	\N
69	96	19	\N	\N	\N	\N	\N	f	f	t	\N	\N
70	97	5	\N	\N	\N	\N	\N	f	f	t	\N	\N
71	98	3	\N	\N	\N	\N	\N	f	f	t	\N	\N
72	99	3	\N	\N	\N	\N	\N	f	f	t	\N	\N
73	100	19	\N	\N	\N	\N	\N	f	f	t	\N	\N
74	101	3	\N	\N	\N	\N	\N	f	f	t	\N	\N
75	102	19	\N	\N	\N	\N	\N	f	f	t	\N	\N
76	103	16	\N	\N	\N	\N	\N	f	f	t	\N	\N
77	104	19	\N	\N	\N	\N	\N	f	f	t	\N	\N
78	105	13	\N	\N	\N	\N	\N	f	f	t	\N	\N
79	106	16	\N	\N	\N	\N	\N	f	f	t	\N	\N
80	107	10	\N	\N	\N	\N	\N	f	f	t	\N	\N
81	108	16	\N	\N	\N	\N	\N	f	f	t	\N	\N
82	109	16	\N	\N	\N	\N	\N	f	f	t	\N	\N
83	110	16	\N	\N	\N	\N	\N	f	f	t	\N	\N
84	111	13	\N	\N	\N	\N	\N	f	f	t	\N	\N
85	112	19	\N	\N	\N	\N	\N	f	f	t	\N	\N
86	113	18	\N	\N	\N	\N	\N	f	f	t	\N	\N
88	114	22	2	9	\N	\N	\N	f	t	f	\N	\N
87	114	21	1	11	37	5	\N	f	t	t	\N	\N
89	115	18	\N	\N	\N	\N	\N	f	f	t	\N	\N
90	116	19	\N	\N	\N	\N	\N	f	f	t	\N	\N
91	118	10	\N	\N	\N	\N	\N	f	f	t	\N	\N
105	141	5	\N	\N	\N	\N	\N	f	f	t	\N	\N
93	119	22	2	3	\N	\N	\N	f	f	f	\N	\N
92	119	23	1	8	\N	\N	\N	f	f	t	\N	\N
95	120	25	2	9	36	2	\N	f	t	f	Abogado	\N
94	120	24	1	8	34	2	\N	f	t	t	Empleada de la Municipalidad	estudia en el EMPA N ° 42
97	125	29	2	6	23	3	\N	t	f	f	Defe. Pueblo	Tel. 34261718
96	125	1	1	8	23	1	\N	f	t	t	\N	\N
98	126	5	\N	\N	\N	\N	\N	f	f	t	\N	\N
99	127	30	\N	\N	\N	\N	\N	f	f	t	\N	\N
23	31	1	1	8	\N	\N	\N	t	t	t	ooooo	oo
19	31	5	1	8	\N	3	\N	t	t	f	\N	\N
22	31	9	3	11	\N	\N	\N	f	f	f	\N	\N
18	31	8	1	8	25	3	\N	t	t	t	\N	\N
100	33	24	1	8	\N	\N	\N	f	f	f	\N	\N
\.


--
-- Name: seq_ambitos; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_ambitos', 3, true);


--
-- Name: seq_barrios; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_barrios', 118, true);


--
-- Name: seq_clasificadores; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_clasificadores', 1, false);


--
-- Name: seq_distritos; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_distritos', 9, true);


--
-- Name: seq_documentos_tipos; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_documentos_tipos', 6, true);


--
-- Name: seq_dptos_partidos; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_dptos_partidos', 1, false);


--
-- Name: seq_estados_civiles; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_estados_civiles', 4, true);


--
-- Name: seq_estados_expedientes; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_estados_expedientes', 3, true);


--
-- Name: seq_estados_relatorias; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_estados_relatorias', 1, false);


--
-- Name: seq_expedientes; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_expedientes', 148, true);


--
-- Name: seq_generos; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_generos', 5, true);


--
-- Name: seq_grupos_trabajos; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_grupos_trabajos', 109, true);


--
-- Name: seq_intervenciones; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_intervenciones', 30, true);


--
-- Name: seq_localidades; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_localidades', 1, false);


--
-- Name: seq_niveles_instruccion; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_niveles_instruccion', 5, true);


--
-- Name: seq_numero_expediente; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_numero_expediente', 145, true);


--
-- Name: seq_oficio_respuestas; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_oficio_respuestas', 1, false);


--
-- Name: seq_oficios_notas; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_oficios_notas', 1, false);


--
-- Name: seq_paises; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_paises', 1, false);


--
-- Name: seq_personal; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_personal', 24, true);


--
-- Name: seq_personas; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_personas', 34, true);


--
-- Name: seq_procedencias; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_procedencias', 4, true);


--
-- Name: seq_provincias; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_provincias', 1, false);


--
-- Name: seq_relatos_observaciones; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_relatos_observaciones', 1, false);


--
-- Name: seq_resoluciones; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_resoluciones', 1, false);


--
-- Name: seq_resoluciones_relatos; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_resoluciones_relatos', 1, false);


--
-- Name: seq_roles; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_roles', 5, true);


--
-- Name: seq_roles_vinculos; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_roles_vinculos', 105, true);


--
-- Name: seq_tipos_casos; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_tipos_casos', 112, true);


--
-- Name: seq_tipos_documentos; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_tipos_documentos', 1, false);


--
-- Name: seq_tipos_gestiones; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_tipos_gestiones', 2, true);


--
-- Name: seq_tipos_intervenciones; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_tipos_intervenciones', 32, true);


--
-- Name: seq_tipos_oficios; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_tipos_oficios', 2, true);


--
-- Name: seq_tipos_violencias; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_tipos_violencias', 5, true);


--
-- Name: seq_vinculos; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_vinculos', 13, true);


--
-- Data for Name: tipos_casos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipos_casos (id, id_ambito, nombre) FROM stdin;
1	1	Abandono de Persona
7	2	Abandono de persona
9	2	Adopción
10	2	Amenazas
11	2	Asistencia al testigo
12	2	Búsqueda de Persona
13	2	Cuota Alimentaria
14	2	Curatela
15	2	Defraudación
16	2	Documentación
17	2	Guarda
18	2	Homicidio
19	2	Lesiones
21	2	Problemas habitacionales
22	2	Protección de persona
26	2	Separación
27	2	Supresión de Identidad
30	2	Femicidio
31	3	Abandono de persona
33	3	Acoso por redes sociales
34	3	Amenazas
35	3	Asistencia al testigo
36	3	Búsqueda de persona
37	3	Curatela
38	3	Defraudación
39	3	Discriminación
40	3	Documentación
41	3	Estafa
42	3	Femicidio
43	3	Homicidio
44	3	Lesiones
45	3	Mala Praxis
46	3	Problemas con vecinos
49	3	Situación de calle
50	3	Supresión de identidad
52	3	Usurpación
55	1	Acoso Sexual
56	1	Apremios Ilegales
57	1	Femicidio   
58	1	Homicidio    
59	1	Mala Praxis
60	1	Privación Ilegítima de la libertad
61	1	Probl. c/ Fuerzas Seguridad
62	1	Probl. c/ hogares Adultos Mayores
63	1	Probl. c/ Inst. Alojamiento  N.N.A.
64	1	Probl. c/ Inst. Educativas
65	1	Probl. C/ Instituc. Carcelarias
67	1	Problemas c/ Poder Judicial
68	1	Problemas Habitacionales
29	2	Trata de personas (Sexual)
69	2	Trata de personas (Laboral)
51	3	Trata de Personas (Sexual)
70	3	Trata de personas (Laboral)
104	1	Violencia c/ la mujer
105	1	Violencia c/ N. N. A.
106	1	Violencia c/ trans
107	1	Amenazas
20	2	Problemáticas de salud mental (adicción)
73	2	Problemáticas de salud mental (padecimiento mental)
74	3	Problemáticas de salud mental (padecimiento mental)
47	3	Problemáticas de salud mental (adicción)
66	1	Probl. c/ Instituciones de Salud (Salud Mental)
32	3	Abuso Sexual
5	2	Abuso Sexual
54	1	Abuso Sexual
108	1	Curatela
76	2	Promoción o Facilitamiento de la prostitución
77	3	Promoción o Facilitamiento de la prostitución
72	2	Robo/Hurto
71	3	Robo/Hurto
28	2	Cuidado Personal (Tenencia)
24	2	Plan de parentalidad (Régimen de visitas)
23	2	Reconocimiento
78	2	Filiación
79	2	Impugnación de paternidad
80	2	Reclamación de paternidad
81	2	Violencia c/ adultos mayores
82	2	Violencia c/ la mujer
83	2	Violencia c/ trans
84	3	Violencia/ N. N. A.
85	2	Violencia/ N. N. A.
86	3	Problemas habitacionales
87	3	Protección de persona
88	3	Violencia c/ adultos mayores
89	3	Violencia c/ la mujer
90	3	Violencia c/ trans
91	1	Búsqueda de persona
92	1	Discriminación
93	1	Documentación
94	1	Problemas con vecinos
95	1	Promoción o Facilitamiento de la prostitución
96	1	Protección de persona
97	1	Robo/hurto
98	1	Situación de calle
99	1	Supresión de Identidad
100	1	Trata de personas laboral
101	1	Trata de Personas sexual
102	1	Usurpación
103	1	Violencia c/ adultos mayores
109	1	Lesiones
110	1	Problemáticas de salud mental adicción
111	1	Problemáticas de salud mental padecimiento mental
112	1	Defraudación
\.


--
-- Data for Name: tipos_documentos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipos_documentos (id, nombre) FROM stdin;
\.


--
-- Data for Name: tipos_gestiones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipos_gestiones (id, nombre) FROM stdin;
1	Gestión 1
2	Gestión  2
\.


--
-- Data for Name: tipos_intervenciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipos_intervenciones (id, nombre) FROM stdin;
2	Intervención en crisis
3	Evaluación de riesgo
4	Derivación
5	Articulación
6	Diseño plan de seguridad y estrategia de afronte
7	Gestión Hogares y Geriátricos
8	Invitación/citación
9	Solicitud de medida de protección
10	Informe psicológico
11	Entrevista psicológica
12	Entrevista social
13	Informe social
14	Entrevista grupo familiar
15	Averiguación estado de la causa judicial
16	Escrito de denuncia judicial
17	Reunión
18	Entrevista domiciliaria
19	Acompañamiento psicológico
20	Gestión de acogida familiar
21	Gestión social
22	Ratificaciones de informe social
23	Ratificaciones de informe psicológico
24	Acuerdos extrajudiciales
25	Acompañamiento a institución (no policial ni judicial)
26	Asesoramiento legal
27	Evaluación en C. Gesell
28	Acompañamiento social
29	Tratamiento psicológico
30	Acompañamiento a sede judicial/policial
31	Gestión de ingreso a refugio
32	Seguimiento del caso (ej: comunicación telefónica)
1	Entrevista Inicial
\.


--
-- Data for Name: tipos_oficios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipos_oficios (id, nombre) FROM stdin;
1	Oficio 1
2	Oficio 2
\.


--
-- Data for Name: tipos_violencias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipos_violencias (id, nombre) FROM stdin;
2	Física
4	Sexual
1	Psicológica
3	Económica
5	Negligencia
\.


--
-- Data for Name: vinculos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY vinculos (id, nombre) FROM stdin;
1	Padre
2	Madre
4	Tio/a
5	Hermano/a
3	Hijo/a
8	Victima
7	Familia ampliada
6	Pareja
9	Ex-Pareja
10	Vecino/a
11	Otro
12	Padastro
13	Par
\.


--
-- Data for Name: vs_database_diagrams; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY vs_database_diagrams (name, diadata, comment, preview, lockinfo, locktime, version) FROM stdin;
\.


--
-- Name: ambitos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ambitos
    ADD CONSTRAINT ambitos_pkey PRIMARY KEY (id);


--
-- Name: barrios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY barrios
    ADD CONSTRAINT barrios_pkey PRIMARY KEY (id);


--
-- Name: clasificadores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY clasificadores
    ADD CONSTRAINT clasificadores_pkey PRIMARY KEY (id);


--
-- Name: continentes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY continentes
    ADD CONSTRAINT continentes_pkey PRIMARY KEY (id);


--
-- Name: distritos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY distritos
    ADD CONSTRAINT distritos_pkey PRIMARY KEY (id);


--
-- Name: documentos_tipos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY documentos_tipos
    ADD CONSTRAINT documentos_tipos_pkey PRIMARY KEY (id);


--
-- Name: dptos_partidos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dptos_partidos
    ADD CONSTRAINT dptos_partidos_pkey PRIMARY KEY (id);


--
-- Name: estados_civiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estados_civiles
    ADD CONSTRAINT estados_civiles_pkey PRIMARY KEY (id);


--
-- Name: estados_expedientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estados_expedientes
    ADD CONSTRAINT estados_expedientes_pkey PRIMARY KEY (id);


--
-- Name: estados_relatorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estados_relatorias
    ADD CONSTRAINT estados_relatorias_pkey PRIMARY KEY (id);


--
-- Name: eventos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY eventos
    ADD CONSTRAINT eventos_pkey PRIMARY KEY (id);


--
-- Name: expedientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT expedientes_pkey PRIMARY KEY (id);


--
-- Name: generos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY generos
    ADD CONSTRAINT generos_pkey PRIMARY KEY (id);


--
-- Name: grupos_trabajos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY grupos_trabajos
    ADD CONSTRAINT grupos_trabajos_pkey PRIMARY KEY (id);


--
-- Name: instituciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY instituciones
    ADD CONSTRAINT instituciones_pkey PRIMARY KEY (id);


--
-- Name: intervenciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY intervenciones
    ADD CONSTRAINT intervenciones_pkey PRIMARY KEY (id);


--
-- Name: intituciones_expediente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY intituciones_expediente
    ADD CONSTRAINT intituciones_expediente_pkey PRIMARY KEY (id);


--
-- Name: localidades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY localidades
    ADD CONSTRAINT localidades_pkey PRIMARY KEY (id);


--
-- Name: niveles_instruccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY niveles_instruccion
    ADD CONSTRAINT niveles_instruccion_pkey PRIMARY KEY (id);


--
-- Name: oficio_respuestas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY oficio_respuestas
    ADD CONSTRAINT oficio_respuestas_pkey PRIMARY KEY (id);


--
-- Name: oficios_notas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY oficios_notas
    ADD CONSTRAINT oficios_notas_pkey PRIMARY KEY (id);


--
-- Name: oficios_nro_emision_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY oficios
    ADD CONSTRAINT oficios_nro_emision_key UNIQUE (nro_emision);


--
-- Name: oficios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY oficios
    ADD CONSTRAINT oficios_pkey PRIMARY KEY (id);


--
-- Name: oficios_recibidos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY oficios_recibidos
    ADD CONSTRAINT oficios_recibidos_pkey PRIMARY KEY (id);


--
-- Name: organismos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY organismos
    ADD CONSTRAINT organismos_pkey PRIMARY KEY (nombre);


--
-- Name: paises_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY paises
    ADD CONSTRAINT paises_pkey PRIMARY KEY (id);


--
-- Name: personal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY personal
    ADD CONSTRAINT personal_pkey PRIMARY KEY (id);


--
-- Name: personas_id_documento_tipo_documento_nro_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT personas_id_documento_tipo_documento_nro_key UNIQUE (id_documento_tipo, documento_nro);


--
-- Name: personas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT personas_pkey PRIMARY KEY (id);


--
-- Name: procedencias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY procedencias
    ADD CONSTRAINT procedencias_pkey PRIMARY KEY (id);


--
-- Name: profesionales_intervenciones_intervencion_id_profesional_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY profesionales_intervenciones
    ADD CONSTRAINT profesionales_intervenciones_intervencion_id_profesional_id_key UNIQUE (intervencion_id, profesional_id);


--
-- Name: profesionales_intervenciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY profesionales_intervenciones
    ADD CONSTRAINT profesionales_intervenciones_pkey PRIMARY KEY (id);


--
-- Name: provincias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY provincias
    ADD CONSTRAINT provincias_pkey PRIMARY KEY (id);


--
-- Name: relatos_observaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY relatos_observaciones
    ADD CONSTRAINT relatos_observaciones_pkey PRIMARY KEY (id);


--
-- Name: resoluciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY resoluciones
    ADD CONSTRAINT resoluciones_pkey PRIMARY KEY (id);


--
-- Name: resoluciones_relatos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY resoluciones_relatos
    ADD CONSTRAINT resoluciones_relatos_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: roles_vinculos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY roles_vinculos
    ADD CONSTRAINT roles_vinculos_pkey PRIMARY KEY (id);


--
-- Name: tipos_casos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipos_casos
    ADD CONSTRAINT tipos_casos_pkey PRIMARY KEY (id);


--
-- Name: tipos_documentos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipos_documentos
    ADD CONSTRAINT tipos_documentos_pkey PRIMARY KEY (id);


--
-- Name: tipos_gestiones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipos_gestiones
    ADD CONSTRAINT tipos_gestiones_pkey PRIMARY KEY (id);


--
-- Name: tipos_intervenciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipos_intervenciones
    ADD CONSTRAINT tipos_intervenciones_pkey PRIMARY KEY (id);


--
-- Name: tipos_oficios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipos_oficios
    ADD CONSTRAINT tipos_oficios_pkey PRIMARY KEY (id);


--
-- Name: tipos_violencias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipos_violencias
    ADD CONSTRAINT tipos_violencias_pkey PRIMARY KEY (id);


--
-- Name: vinculos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY vinculos
    ADD CONSTRAINT vinculos_pkey PRIMARY KEY (id);


--
-- Name: barrios_id_localidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY barrios
    ADD CONSTRAINT barrios_id_localidad_fkey FOREIGN KEY (id_localidad) REFERENCES localidades(id);


--
-- Name: clasificadores_id_ambito_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clasificadores
    ADD CONSTRAINT clasificadores_id_ambito_fkey FOREIGN KEY (id_ambito) REFERENCES ambitos(id);


--
-- Name: clasificadores_id_tipo1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clasificadores
    ADD CONSTRAINT clasificadores_id_tipo1_fkey FOREIGN KEY (id_tipo1) REFERENCES tipos_casos(id);


--
-- Name: clasificadores_id_tipo2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clasificadores
    ADD CONSTRAINT clasificadores_id_tipo2_fkey FOREIGN KEY (id_tipo2) REFERENCES tipos_casos(id);


--
-- Name: clasificadores_id_tipo3_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clasificadores
    ADD CONSTRAINT clasificadores_id_tipo3_fkey FOREIGN KEY (id_tipo3) REFERENCES tipos_casos(id);


--
-- Name: clasificadores_id_tipov1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clasificadores
    ADD CONSTRAINT clasificadores_id_tipov1_fkey FOREIGN KEY (id_tipov1) REFERENCES tipos_violencias(id);


--
-- Name: clasificadores_id_tipov2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clasificadores
    ADD CONSTRAINT clasificadores_id_tipov2_fkey FOREIGN KEY (id_tipov2) REFERENCES tipos_violencias(id);


--
-- Name: clasificadores_id_tipov3_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clasificadores
    ADD CONSTRAINT clasificadores_id_tipov3_fkey FOREIGN KEY (id_tipov3) REFERENCES tipos_violencias(id);


--
-- Name: cod_postales_id_localidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cod_postales
    ADD CONSTRAINT cod_postales_id_localidad_fkey FOREIGN KEY (id_localidad) REFERENCES localidades(id);


--
-- Name: distritos_id_localidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY distritos
    ADD CONSTRAINT distritos_id_localidad_fkey FOREIGN KEY (id_localidad) REFERENCES localidades(id);


--
-- Name: dptos_partidos_id_provincia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dptos_partidos
    ADD CONSTRAINT dptos_partidos_id_provincia_fkey FOREIGN KEY (id_provincia) REFERENCES provincias(id);


--
-- Name: expedientes_id_clasificador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT expedientes_id_clasificador_fkey FOREIGN KEY (id_clasificador) REFERENCES clasificadores(id);


--
-- Name: expedientes_id_estado_expediente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT expedientes_id_estado_expediente_fkey FOREIGN KEY (id_estado_expediente) REFERENCES estados_expedientes(id);


--
-- Name: expedientes_id_estado_relatoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT expedientes_id_estado_relatoria_fkey FOREIGN KEY (id_estado_relatoria) REFERENCES estados_relatorias(id);


--
-- Name: expedientes_id_institucion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT expedientes_id_institucion_fkey FOREIGN KEY (id_institucion) REFERENCES instituciones(id);


--
-- Name: expedientes_id_institucion_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT expedientes_id_institucion_fkey1 FOREIGN KEY (id_institucion) REFERENCES instituciones(id);


--
-- Name: expedientes_id_nomeclador1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT expedientes_id_nomeclador1_fkey FOREIGN KEY (nomeclador_1) REFERENCES tipos_casos(id) MATCH FULL;


--
-- Name: expedientes_id_nomeclador2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT expedientes_id_nomeclador2_fkey FOREIGN KEY (nomeclador_2) REFERENCES tipos_casos(id) MATCH FULL;


--
-- Name: expedientes_id_nomeclador3_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT expedientes_id_nomeclador3_fkey FOREIGN KEY (nomeclador_3) REFERENCES tipos_casos(id) MATCH FULL;


--
-- Name: expedientes_id_procedencia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT expedientes_id_procedencia_fkey FOREIGN KEY (id_procedencia) REFERENCES procedencias(id);


--
-- Name: expedientes_id_responsable_ingreso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT expedientes_id_responsable_ingreso_fkey FOREIGN KEY (id_responsable_ingreso) REFERENCES personal(id);


--
-- Name: expedientes_id_tipogestion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT expedientes_id_tipogestion_fkey FOREIGN KEY (id_tipogestion) REFERENCES tipos_gestiones(id);


--
-- Name: expedientes_id_violencia1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT expedientes_id_violencia1_fkey FOREIGN KEY (violencia_1) REFERENCES tipos_violencias(id) MATCH FULL;


--
-- Name: expedientes_id_violencia2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT expedientes_id_violencia2_fkey FOREIGN KEY (violencia_2) REFERENCES tipos_violencias(id) MATCH FULL;


--
-- Name: expedientes_id_violencia3_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT expedientes_id_violencia3_fkey FOREIGN KEY (violencia_3) REFERENCES tipos_violencias(id) MATCH FULL;


--
-- Name: expedientes_organismo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expedientes
    ADD CONSTRAINT expedientes_organismo_fkey FOREIGN KEY (organismo) REFERENCES organismos(nombre);


--
-- Name: grupos_trabajos_id_expediente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grupos_trabajos
    ADD CONSTRAINT grupos_trabajos_id_expediente_fkey FOREIGN KEY (id_expediente) REFERENCES expedientes(id);


--
-- Name: grupos_trabajos_id_personal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grupos_trabajos
    ADD CONSTRAINT grupos_trabajos_id_personal_fkey FOREIGN KEY (id_personal) REFERENCES personal(id);


--
-- Name: intervenciones_id_expediente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY intervenciones
    ADD CONSTRAINT intervenciones_id_expediente_fkey FOREIGN KEY (id_expediente) REFERENCES expedientes(id);


--
-- Name: intervenciones_id_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY intervenciones
    ADD CONSTRAINT intervenciones_id_tipo_fkey FOREIGN KEY (id_tipo) REFERENCES tipos_intervenciones(id);


--
-- Name: intituciones_expediente_id_expediente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY intituciones_expediente
    ADD CONSTRAINT intituciones_expediente_id_expediente_fkey FOREIGN KEY (id_expediente) REFERENCES expedientes(id);


--
-- Name: intituciones_expediente_id_institucion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY intituciones_expediente
    ADD CONSTRAINT intituciones_expediente_id_institucion_fkey FOREIGN KEY (id_institucion) REFERENCES instituciones(id);


--
-- Name: localidades_id_dpto_partido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localidades
    ADD CONSTRAINT localidades_id_dpto_partido_fkey FOREIGN KEY (id_dpto_partido) REFERENCES dptos_partidos(id);


--
-- Name: oficio_respuestas_id_oficio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oficio_respuestas
    ADD CONSTRAINT oficio_respuestas_id_oficio_fkey FOREIGN KEY (id_oficio) REFERENCES oficios_notas(id);


--
-- Name: oficios_id_expediente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oficios
    ADD CONSTRAINT oficios_id_expediente_fkey FOREIGN KEY (id_expediente) REFERENCES expedientes(id);


--
-- Name: oficios_notas_id_expediente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oficios_notas
    ADD CONSTRAINT oficios_notas_id_expediente_fkey FOREIGN KEY (id_expediente) REFERENCES expedientes(id);


--
-- Name: oficios_notas_id_tipo_oficio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oficios_notas
    ADD CONSTRAINT oficios_notas_id_tipo_oficio_fkey FOREIGN KEY (id_tipo_oficio) REFERENCES tipos_oficios(id);


--
-- Name: oficios_recibidos_organismo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oficios_recibidos
    ADD CONSTRAINT oficios_recibidos_organismo_fkey FOREIGN KEY (organismo) REFERENCES organismos(nombre);


--
-- Name: organismos_dep_organismo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organismos_dep
    ADD CONSTRAINT organismos_dep_organismo_fkey FOREIGN KEY (organismo) REFERENCES organismos(nombre);


--
-- Name: paises_id_continente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY paises
    ADD CONSTRAINT paises_id_continente_fkey FOREIGN KEY (id_continente) REFERENCES continentes(id);


--
-- Name: personas_id_barrio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT personas_id_barrio_fkey FOREIGN KEY (id_barrio) REFERENCES barrios(id);


--
-- Name: personas_id_distrito_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT personas_id_distrito_fkey FOREIGN KEY (id_distrito) REFERENCES distritos(id);


--
-- Name: personas_id_documento_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT personas_id_documento_tipo_fkey FOREIGN KEY (id_documento_tipo) REFERENCES documentos_tipos(id);


--
-- Name: personas_id_estado_civil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT personas_id_estado_civil_fkey FOREIGN KEY (id_estado_civil) REFERENCES estados_civiles(id);


--
-- Name: personas_id_genero_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT personas_id_genero_fkey FOREIGN KEY (id_genero) REFERENCES generos(id);


--
-- Name: personas_id_localidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT personas_id_localidad_fkey FOREIGN KEY (id_localidad) REFERENCES localidades(id);


--
-- Name: personas_id_nivel_instruccion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT personas_id_nivel_instruccion_fkey FOREIGN KEY (id_nivel_instruccion) REFERENCES niveles_instruccion(id);


--
-- Name: personas_id_pais_nacimiento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY personas
    ADD CONSTRAINT personas_id_pais_nacimiento_fkey FOREIGN KEY (id_pais_nacimiento) REFERENCES paises(id);


--
-- Name: profesionales_intervenciones_intervencion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY profesionales_intervenciones
    ADD CONSTRAINT profesionales_intervenciones_intervencion_id_fkey FOREIGN KEY (intervencion_id) REFERENCES intervenciones(id);


--
-- Name: profesionales_intervenciones_profesional_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY profesionales_intervenciones
    ADD CONSTRAINT profesionales_intervenciones_profesional_id_fkey FOREIGN KEY (profesional_id) REFERENCES personal(id);


--
-- Name: provincias_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincias
    ADD CONSTRAINT provincias_id_pais_fkey FOREIGN KEY (id_pais) REFERENCES paises(id);


--
-- Name: relatos_observaciones_id_expediente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY relatos_observaciones
    ADD CONSTRAINT relatos_observaciones_id_expediente_fkey FOREIGN KEY (id_expediente) REFERENCES expedientes(id);


--
-- Name: resoluciones_id_expediente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resoluciones
    ADD CONSTRAINT resoluciones_id_expediente_fkey FOREIGN KEY (id_expediente) REFERENCES expedientes(id);


--
-- Name: resoluciones_relatos_id_resolucion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resoluciones_relatos
    ADD CONSTRAINT resoluciones_relatos_id_resolucion_fkey FOREIGN KEY (id_resolucion) REFERENCES resoluciones(id);


--
-- Name: roles_vinculos_id_expediente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY roles_vinculos
    ADD CONSTRAINT roles_vinculos_id_expediente_fkey FOREIGN KEY (id_expediente) REFERENCES expedientes(id);


--
-- Name: roles_vinculos_id_persona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY roles_vinculos
    ADD CONSTRAINT roles_vinculos_id_persona_fkey FOREIGN KEY (id_persona) REFERENCES personas(id);


--
-- Name: roles_vinculos_id_rol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY roles_vinculos
    ADD CONSTRAINT roles_vinculos_id_rol_fkey FOREIGN KEY (id_rol) REFERENCES roles(id);


--
-- Name: roles_vinculos_id_vinculo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY roles_vinculos
    ADD CONSTRAINT roles_vinculos_id_vinculo_fkey FOREIGN KEY (id_vinculo) REFERENCES vinculos(id);


--
-- Name: tipos_casos_id_ambito_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipos_casos
    ADD CONSTRAINT tipos_casos_id_ambito_fkey FOREIGN KEY (id_ambito) REFERENCES ambitos(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--
