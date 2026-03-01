--
-- PostgreSQL database dump
--

\restrict 3GSy5astwyqEguoeund2TrychbBICvcemH7BakSQjmSAMskIJgdkXYNS37fId8o

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-03-01 11:39:18

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 238 (class 1259 OID 16869)
-- Name: bitacora_op; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bitacora_op (
    id_bitacora integer CONSTRAINT bitacora_operaciones_id_bitacora_not_null NOT NULL,
    tipo_operacion character varying(100) CONSTRAINT bitacora_operaciones_tipo_operacion_not_null NOT NULL,
    fecha_hora_operacion timestamp without time zone CONSTRAINT bitacora_operaciones_fecha_hora_operacion_not_null NOT NULL,
    id_usuario integer CONSTRAINT bitacora_operaciones_id_usuario_not_null NOT NULL,
    rol_usuario character varying(50) CONSTRAINT bitacora_operaciones_rol_usuario_not_null NOT NULL,
    id_producto_afectado integer,
    datos_detalle text
);


ALTER TABLE public.bitacora_op OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16868)
-- Name: bitacora_operaciones_id_bitacora_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bitacora_operaciones_id_bitacora_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bitacora_operaciones_id_bitacora_seq OWNER TO postgres;

--
-- TOC entry 5126 (class 0 OID 0)
-- Dependencies: 237
-- Name: bitacora_operaciones_id_bitacora_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bitacora_operaciones_id_bitacora_seq OWNED BY public.bitacora_op.id_bitacora;


--
-- TOC entry 228 (class 1259 OID 16678)
-- Name: cliente_empresa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente_empresa (
    id_empresa integer NOT NULL,
    razon_social character varying(150) NOT NULL,
    nit character varying(20) NOT NULL,
    correo character varying(100) NOT NULL,
    telefono character varying(15) NOT NULL,
    direccion character varying(200) NOT NULL,
    id_representante integer NOT NULL,
    id_estado integer NOT NULL
);


ALTER TABLE public.cliente_empresa OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16677)
-- Name: cliente_empresa_id_empresa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cliente_empresa_id_empresa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cliente_empresa_id_empresa_seq OWNER TO postgres;

--
-- TOC entry 5127 (class 0 OID 0)
-- Dependencies: 227
-- Name: cliente_empresa_id_empresa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cliente_empresa_id_empresa_seq OWNED BY public.cliente_empresa.id_empresa;


--
-- TOC entry 226 (class 1259 OID 16658)
-- Name: cliente_person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente_person (
    id_persona integer CONSTRAINT cliente_persona_id_persona_not_null NOT NULL,
    nombre_completo character varying(150) CONSTRAINT cliente_persona_nombre_completo_not_null NOT NULL,
    numero_identificacion character varying(20) CONSTRAINT cliente_persona_numero_identificacion_not_null NOT NULL,
    correo character varying(100) CONSTRAINT cliente_persona_correo_not_null NOT NULL,
    telefono character varying(15) CONSTRAINT cliente_persona_telefono_not_null NOT NULL,
    fecha_nacimiento date CONSTRAINT cliente_persona_fecha_nacimiento_not_null NOT NULL,
    direccion character varying(200) CONSTRAINT cliente_persona_direccion_not_null NOT NULL,
    id_estado integer CONSTRAINT cliente_persona_id_estado_not_null NOT NULL
);


ALTER TABLE public.cliente_person OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16657)
-- Name: cliente_persona_id_persona_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cliente_persona_id_persona_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cliente_persona_id_persona_seq OWNER TO postgres;

--
-- TOC entry 5128 (class 0 OID 0)
-- Dependencies: 225
-- Name: cliente_persona_id_persona_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cliente_persona_id_persona_seq OWNED BY public.cliente_person.id_persona;


--
-- TOC entry 232 (class 1259 OID 16735)
-- Name: cuenta_bancaria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuenta_bancaria (
    id_cuenta integer NOT NULL,
    numero_cuenta character varying(20) NOT NULL,
    id_producto integer NOT NULL,
    saldo_actual numeric(12,2) NOT NULL,
    moneda character varying(10) NOT NULL,
    fecha_apertura date NOT NULL,
    id_persona integer,
    id_empresa integer,
    id_estado integer NOT NULL
);


ALTER TABLE public.cuenta_bancaria OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16734)
-- Name: cuenta_bancaria_id_cuenta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cuenta_bancaria_id_cuenta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cuenta_bancaria_id_cuenta_seq OWNER TO postgres;

--
-- TOC entry 5129 (class 0 OID 0)
-- Dependencies: 231
-- Name: cuenta_bancaria_id_cuenta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cuenta_bancaria_id_cuenta_seq OWNED BY public.cuenta_bancaria.id_cuenta;


--
-- TOC entry 222 (class 1259 OID 16638)
-- Name: estado_general; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estado_general (
    id_estado integer NOT NULL,
    nombre_estado character varying(50) NOT NULL,
    tipo_estado character varying(50)
);


ALTER TABLE public.estado_general OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16637)
-- Name: estado_general_id_estado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estado_general_id_estado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estado_general_id_estado_seq OWNER TO postgres;

--
-- TOC entry 5130 (class 0 OID 0)
-- Dependencies: 221
-- Name: estado_general_id_estado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estado_general_id_estado_seq OWNED BY public.estado_general.id_estado;


--
-- TOC entry 234 (class 1259 OID 16769)
-- Name: prestamo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prestamo (
    id_prestamo integer NOT NULL,
    id_producto integer NOT NULL,
    monto_solicitado numeric(12,2) NOT NULL,
    monto_aprobado numeric(12,2),
    tasa_interes numeric(5,2),
    plazo_meses integer NOT NULL,
    fecha_creacion date NOT NULL,
    fecha_aprobacion date,
    fecha_desembolso date,
    id_persona integer,
    id_empresa integer,
    id_cuenta_desembolso integer,
    id_analista integer,
    id_estado integer NOT NULL
);


ALTER TABLE public.prestamo OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16768)
-- Name: prestamo_id_prestamo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prestamo_id_prestamo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prestamo_id_prestamo_seq OWNER TO postgres;

--
-- TOC entry 5131 (class 0 OID 0)
-- Dependencies: 233
-- Name: prestamo_id_prestamo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prestamo_id_prestamo_seq OWNED BY public.prestamo.id_prestamo;


--
-- TOC entry 224 (class 1259 OID 16647)
-- Name: producto_bancario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.producto_bancario (
    id_producto integer NOT NULL,
    nombre_producto character varying(100) NOT NULL,
    categoria character varying(50) NOT NULL,
    requiere_aprobacion boolean NOT NULL
);


ALTER TABLE public.producto_bancario OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16646)
-- Name: producto_bancario_id_producto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.producto_bancario_id_producto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.producto_bancario_id_producto_seq OWNER TO postgres;

--
-- TOC entry 5132 (class 0 OID 0)
-- Dependencies: 223
-- Name: producto_bancario_id_producto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.producto_bancario_id_producto_seq OWNED BY public.producto_bancario.id_producto;


--
-- TOC entry 220 (class 1259 OID 16629)
-- Name: rol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rol (
    id_rol integer CONSTRAINT rol_sistema_id_rol_not_null NOT NULL,
    nombre_rol character varying(50) CONSTRAINT rol_sistema_nombre_rol_not_null NOT NULL
);


ALTER TABLE public.rol OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16628)
-- Name: rol_sistema_id_rol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rol_sistema_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rol_sistema_id_rol_seq OWNER TO postgres;

--
-- TOC entry 5133 (class 0 OID 0)
-- Dependencies: 219
-- Name: rol_sistema_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rol_sistema_id_rol_seq OWNED BY public.rol.id_rol;


--
-- TOC entry 236 (class 1259 OID 16812)
-- Name: transferencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transferencia (
    id_transferencia integer NOT NULL,
    id_cuenta_origen integer NOT NULL,
    id_cuenta_destino integer NOT NULL,
    monto numeric(12,2) NOT NULL,
    fecha_creacion timestamp without time zone NOT NULL,
    fecha_aprobacion timestamp without time zone,
    id_usuario_creador integer NOT NULL,
    id_usuario_aprobador integer,
    id_estado integer NOT NULL
);


ALTER TABLE public.transferencia OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16811)
-- Name: transferencia_id_transferencia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transferencia_id_transferencia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transferencia_id_transferencia_seq OWNER TO postgres;

--
-- TOC entry 5134 (class 0 OID 0)
-- Dependencies: 235
-- Name: transferencia_id_transferencia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transferencia_id_transferencia_seq OWNED BY public.transferencia.id_transferencia;


--
-- TOC entry 230 (class 1259 OID 16703)
-- Name: usuario_sistema; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_sistema (
    id_usuario integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(100) NOT NULL,
    id_rol integer NOT NULL,
    id_persona integer,
    id_empresa integer,
    id_estado integer NOT NULL
);


ALTER TABLE public.usuario_sistema OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16702)
-- Name: usuario_sistema_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_sistema_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_sistema_id_usuario_seq OWNER TO postgres;

--
-- TOC entry 5135 (class 0 OID 0)
-- Dependencies: 229
-- Name: usuario_sistema_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_sistema_id_usuario_seq OWNED BY public.usuario_sistema.id_usuario;


--
-- TOC entry 4910 (class 2604 OID 16872)
-- Name: bitacora_op id_bitacora; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitacora_op ALTER COLUMN id_bitacora SET DEFAULT nextval('public.bitacora_operaciones_id_bitacora_seq'::regclass);


--
-- TOC entry 4905 (class 2604 OID 16681)
-- Name: cliente_empresa id_empresa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente_empresa ALTER COLUMN id_empresa SET DEFAULT nextval('public.cliente_empresa_id_empresa_seq'::regclass);


--
-- TOC entry 4904 (class 2604 OID 16661)
-- Name: cliente_person id_persona; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente_person ALTER COLUMN id_persona SET DEFAULT nextval('public.cliente_persona_id_persona_seq'::regclass);


--
-- TOC entry 4907 (class 2604 OID 16738)
-- Name: cuenta_bancaria id_cuenta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_bancaria ALTER COLUMN id_cuenta SET DEFAULT nextval('public.cuenta_bancaria_id_cuenta_seq'::regclass);


--
-- TOC entry 4902 (class 2604 OID 16641)
-- Name: estado_general id_estado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_general ALTER COLUMN id_estado SET DEFAULT nextval('public.estado_general_id_estado_seq'::regclass);


--
-- TOC entry 4908 (class 2604 OID 16772)
-- Name: prestamo id_prestamo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestamo ALTER COLUMN id_prestamo SET DEFAULT nextval('public.prestamo_id_prestamo_seq'::regclass);


--
-- TOC entry 4903 (class 2604 OID 16650)
-- Name: producto_bancario id_producto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto_bancario ALTER COLUMN id_producto SET DEFAULT nextval('public.producto_bancario_id_producto_seq'::regclass);


--
-- TOC entry 4901 (class 2604 OID 16632)
-- Name: rol id_rol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rol ALTER COLUMN id_rol SET DEFAULT nextval('public.rol_sistema_id_rol_seq'::regclass);


--
-- TOC entry 4909 (class 2604 OID 16815)
-- Name: transferencia id_transferencia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transferencia ALTER COLUMN id_transferencia SET DEFAULT nextval('public.transferencia_id_transferencia_seq'::regclass);


--
-- TOC entry 4906 (class 2604 OID 16706)
-- Name: usuario_sistema id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_sistema ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_sistema_id_usuario_seq'::regclass);


--
-- TOC entry 5120 (class 0 OID 16869)
-- Dependencies: 238
-- Data for Name: bitacora_op; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bitacora_op (id_bitacora, tipo_operacion, fecha_hora_operacion, id_usuario, rol_usuario, id_producto_afectado, datos_detalle) FROM stdin;
1	PRESTAMO_APROBADO	2026-02-27 23:43:12.390192	273	ANALISTA_INTERNO	794	Monto aprobado: 30067788.35, Tasa: 12.5%
2	CUENTA_CREADA	2026-02-27 23:42:12.390192	874	EMPLEADO_VENTANILLA	281	Cuenta creada correctamente
3	TRANSFERENCIA_RECHAZADA	2026-02-27 23:41:12.390192	470	EMPLEADO_EMPRESA	11	Transferencia rechazada por fondos insuficientes
4	TRANSFERENCIA_EJECUTADA	2026-02-27 23:40:12.390192	608	SUPERVISOR_EMPRESA	220	Monto: 8520.31, Estado: Ejecutada
5	PRESTAMO_APROBADO	2026-02-27 23:39:12.390192	652	ANALISTA_INTERNO	95	Monto aprobado: 29388911.61, Tasa: 12.5%
6	CUENTA_CREADA	2026-02-27 23:38:12.390192	848	EMPLEADO_VENTANILLA	28	Cuenta creada correctamente
7	TRANSFERENCIA_RECHAZADA	2026-02-27 23:37:12.390192	686	EMPLEADO_EMPRESA	919	Transferencia rechazada por fondos insuficientes
8	TRANSFERENCIA_EJECUTADA	2026-02-27 23:36:12.390192	678	SUPERVISOR_EMPRESA	580	Monto: 27042.97, Estado: Ejecutada
9	PRESTAMO_APROBADO	2026-02-27 23:35:12.390192	279	ANALISTA_INTERNO	231	Monto aprobado: 38288886.86, Tasa: 12.5%
10	CUENTA_CREADA	2026-02-27 23:34:12.390192	265	EMPLEADO_VENTANILLA	184	Cuenta creada correctamente
11	TRANSFERENCIA_RECHAZADA	2026-02-27 23:33:12.390192	600	EMPLEADO_EMPRESA	602	Transferencia rechazada por fondos insuficientes
12	TRANSFERENCIA_EJECUTADA	2026-02-27 23:32:12.390192	273	SUPERVISOR_EMPRESA	367	Monto: 17383.49, Estado: Ejecutada
13	PRESTAMO_APROBADO	2026-02-27 23:31:12.390192	296	ANALISTA_INTERNO	751	Monto aprobado: 912482.48, Tasa: 12.5%
14	CUENTA_CREADA	2026-02-27 23:30:12.390192	705	EMPLEADO_VENTANILLA	100	Cuenta creada correctamente
15	TRANSFERENCIA_RECHAZADA	2026-02-27 23:29:12.390192	198	EMPLEADO_EMPRESA	553	Transferencia rechazada por fondos insuficientes
16	TRANSFERENCIA_EJECUTADA	2026-02-27 23:28:12.390192	338	SUPERVISOR_EMPRESA	320	Monto: 33179.41, Estado: Ejecutada
17	PRESTAMO_APROBADO	2026-02-27 23:27:12.390192	52	ANALISTA_INTERNO	419	Monto aprobado: 35325850.62, Tasa: 12.5%
18	CUENTA_CREADA	2026-02-27 23:26:12.390192	547	EMPLEADO_VENTANILLA	519	Cuenta creada correctamente
19	TRANSFERENCIA_RECHAZADA	2026-02-27 23:25:12.390192	771	EMPLEADO_EMPRESA	645	Transferencia rechazada por fondos insuficientes
20	TRANSFERENCIA_EJECUTADA	2026-02-27 23:24:12.390192	980	SUPERVISOR_EMPRESA	312	Monto: 40924.58, Estado: Ejecutada
21	PRESTAMO_APROBADO	2026-02-27 23:23:12.390192	38	ANALISTA_INTERNO	251	Monto aprobado: 13438734.97, Tasa: 12.5%
22	CUENTA_CREADA	2026-02-27 23:22:12.390192	276	EMPLEADO_VENTANILLA	675	Cuenta creada correctamente
23	TRANSFERENCIA_RECHAZADA	2026-02-27 23:21:12.390192	542	EMPLEADO_EMPRESA	926	Transferencia rechazada por fondos insuficientes
24	TRANSFERENCIA_EJECUTADA	2026-02-27 23:20:12.390192	3	SUPERVISOR_EMPRESA	618	Monto: 90056.48, Estado: Ejecutada
25	PRESTAMO_APROBADO	2026-02-27 23:19:12.390192	5	ANALISTA_INTERNO	943	Monto aprobado: 27364998.29, Tasa: 12.5%
26	CUENTA_CREADA	2026-02-27 23:18:12.390192	493	EMPLEADO_VENTANILLA	750	Cuenta creada correctamente
27	TRANSFERENCIA_RECHAZADA	2026-02-27 23:17:12.390192	317	EMPLEADO_EMPRESA	247	Transferencia rechazada por fondos insuficientes
28	TRANSFERENCIA_EJECUTADA	2026-02-27 23:16:12.390192	450	SUPERVISOR_EMPRESA	729	Monto: 61122.67, Estado: Ejecutada
29	PRESTAMO_APROBADO	2026-02-27 23:15:12.390192	839	ANALISTA_INTERNO	383	Monto aprobado: 35933861.58, Tasa: 12.5%
30	CUENTA_CREADA	2026-02-27 23:14:12.390192	60	EMPLEADO_VENTANILLA	916	Cuenta creada correctamente
31	TRANSFERENCIA_RECHAZADA	2026-02-27 23:13:12.390192	587	EMPLEADO_EMPRESA	369	Transferencia rechazada por fondos insuficientes
32	TRANSFERENCIA_EJECUTADA	2026-02-27 23:12:12.390192	968	SUPERVISOR_EMPRESA	689	Monto: 14541.43, Estado: Ejecutada
33	PRESTAMO_APROBADO	2026-02-27 23:11:12.390192	439	ANALISTA_INTERNO	335	Monto aprobado: 20475255.02, Tasa: 12.5%
34	CUENTA_CREADA	2026-02-27 23:10:12.390192	704	EMPLEADO_VENTANILLA	942	Cuenta creada correctamente
35	TRANSFERENCIA_RECHAZADA	2026-02-27 23:09:12.390192	169	EMPLEADO_EMPRESA	550	Transferencia rechazada por fondos insuficientes
36	TRANSFERENCIA_EJECUTADA	2026-02-27 23:08:12.390192	960	SUPERVISOR_EMPRESA	411	Monto: 69917.30, Estado: Ejecutada
37	PRESTAMO_APROBADO	2026-02-27 23:07:12.390192	291	ANALISTA_INTERNO	890	Monto aprobado: 36918054.78, Tasa: 12.5%
38	CUENTA_CREADA	2026-02-27 23:06:12.390192	622	EMPLEADO_VENTANILLA	898	Cuenta creada correctamente
39	TRANSFERENCIA_RECHAZADA	2026-02-27 23:05:12.390192	926	EMPLEADO_EMPRESA	895	Transferencia rechazada por fondos insuficientes
40	TRANSFERENCIA_EJECUTADA	2026-02-27 23:04:12.390192	197	SUPERVISOR_EMPRESA	444	Monto: 44145.83, Estado: Ejecutada
41	PRESTAMO_APROBADO	2026-02-27 23:03:12.390192	702	ANALISTA_INTERNO	892	Monto aprobado: 9707626.26, Tasa: 12.5%
42	CUENTA_CREADA	2026-02-27 23:02:12.390192	930	EMPLEADO_VENTANILLA	148	Cuenta creada correctamente
43	TRANSFERENCIA_RECHAZADA	2026-02-27 23:01:12.390192	752	EMPLEADO_EMPRESA	969	Transferencia rechazada por fondos insuficientes
44	TRANSFERENCIA_EJECUTADA	2026-02-27 23:00:12.390192	212	SUPERVISOR_EMPRESA	73	Monto: 604.23, Estado: Ejecutada
45	PRESTAMO_APROBADO	2026-02-27 22:59:12.390192	997	ANALISTA_INTERNO	247	Monto aprobado: 37569740.06, Tasa: 12.5%
46	CUENTA_CREADA	2026-02-27 22:58:12.390192	301	EMPLEADO_VENTANILLA	777	Cuenta creada correctamente
47	TRANSFERENCIA_RECHAZADA	2026-02-27 22:57:12.390192	229	EMPLEADO_EMPRESA	399	Transferencia rechazada por fondos insuficientes
48	TRANSFERENCIA_EJECUTADA	2026-02-27 22:56:12.390192	13	SUPERVISOR_EMPRESA	591	Monto: 12755.28, Estado: Ejecutada
49	PRESTAMO_APROBADO	2026-02-27 22:55:12.390192	214	ANALISTA_INTERNO	327	Monto aprobado: 7569170.04, Tasa: 12.5%
50	CUENTA_CREADA	2026-02-27 22:54:12.390192	521	EMPLEADO_VENTANILLA	993	Cuenta creada correctamente
51	TRANSFERENCIA_RECHAZADA	2026-02-27 22:53:12.390192	119	EMPLEADO_EMPRESA	669	Transferencia rechazada por fondos insuficientes
52	TRANSFERENCIA_EJECUTADA	2026-02-27 22:52:12.390192	837	SUPERVISOR_EMPRESA	101	Monto: 74265.59, Estado: Ejecutada
53	PRESTAMO_APROBADO	2026-02-27 22:51:12.390192	100	ANALISTA_INTERNO	601	Monto aprobado: 36520886.51, Tasa: 12.5%
54	CUENTA_CREADA	2026-02-27 22:50:12.390192	260	EMPLEADO_VENTANILLA	624	Cuenta creada correctamente
55	TRANSFERENCIA_RECHAZADA	2026-02-27 22:49:12.390192	964	EMPLEADO_EMPRESA	532	Transferencia rechazada por fondos insuficientes
56	TRANSFERENCIA_EJECUTADA	2026-02-27 22:48:12.390192	477	SUPERVISOR_EMPRESA	712	Monto: 68340.96, Estado: Ejecutada
57	PRESTAMO_APROBADO	2026-02-27 22:47:12.390192	949	ANALISTA_INTERNO	354	Monto aprobado: 19096217.57, Tasa: 12.5%
58	CUENTA_CREADA	2026-02-27 22:46:12.390192	125	EMPLEADO_VENTANILLA	554	Cuenta creada correctamente
59	TRANSFERENCIA_RECHAZADA	2026-02-27 22:45:12.390192	396	EMPLEADO_EMPRESA	560	Transferencia rechazada por fondos insuficientes
60	TRANSFERENCIA_EJECUTADA	2026-02-27 22:44:12.390192	563	SUPERVISOR_EMPRESA	356	Monto: 9100.09, Estado: Ejecutada
61	PRESTAMO_APROBADO	2026-02-27 22:43:12.390192	694	ANALISTA_INTERNO	713	Monto aprobado: 27766813.57, Tasa: 12.5%
62	CUENTA_CREADA	2026-02-27 22:42:12.390192	80	EMPLEADO_VENTANILLA	405	Cuenta creada correctamente
63	TRANSFERENCIA_RECHAZADA	2026-02-27 22:41:12.390192	155	EMPLEADO_EMPRESA	376	Transferencia rechazada por fondos insuficientes
64	TRANSFERENCIA_EJECUTADA	2026-02-27 22:40:12.390192	96	SUPERVISOR_EMPRESA	380	Monto: 74132.29, Estado: Ejecutada
65	PRESTAMO_APROBADO	2026-02-27 22:39:12.390192	743	ANALISTA_INTERNO	982	Monto aprobado: 4776030.89, Tasa: 12.5%
66	CUENTA_CREADA	2026-02-27 22:38:12.390192	906	EMPLEADO_VENTANILLA	964	Cuenta creada correctamente
67	TRANSFERENCIA_RECHAZADA	2026-02-27 22:37:12.390192	705	EMPLEADO_EMPRESA	628	Transferencia rechazada por fondos insuficientes
68	TRANSFERENCIA_EJECUTADA	2026-02-27 22:36:12.390192	988	SUPERVISOR_EMPRESA	132	Monto: 93407.17, Estado: Ejecutada
69	PRESTAMO_APROBADO	2026-02-27 22:35:12.390192	519	ANALISTA_INTERNO	689	Monto aprobado: 32088250.46, Tasa: 12.5%
70	CUENTA_CREADA	2026-02-27 22:34:12.390192	871	EMPLEADO_VENTANILLA	133	Cuenta creada correctamente
71	TRANSFERENCIA_RECHAZADA	2026-02-27 22:33:12.390192	824	EMPLEADO_EMPRESA	317	Transferencia rechazada por fondos insuficientes
72	TRANSFERENCIA_EJECUTADA	2026-02-27 22:32:12.390192	785	SUPERVISOR_EMPRESA	833	Monto: 7428.62, Estado: Ejecutada
73	PRESTAMO_APROBADO	2026-02-27 22:31:12.390192	383	ANALISTA_INTERNO	429	Monto aprobado: 4944324.11, Tasa: 12.5%
74	CUENTA_CREADA	2026-02-27 22:30:12.390192	395	EMPLEADO_VENTANILLA	434	Cuenta creada correctamente
75	TRANSFERENCIA_RECHAZADA	2026-02-27 22:29:12.390192	40	EMPLEADO_EMPRESA	287	Transferencia rechazada por fondos insuficientes
76	TRANSFERENCIA_EJECUTADA	2026-02-27 22:28:12.390192	706	SUPERVISOR_EMPRESA	104	Monto: 69830.02, Estado: Ejecutada
77	PRESTAMO_APROBADO	2026-02-27 22:27:12.390192	401	ANALISTA_INTERNO	86	Monto aprobado: 2423495.77, Tasa: 12.5%
78	CUENTA_CREADA	2026-02-27 22:26:12.390192	820	EMPLEADO_VENTANILLA	309	Cuenta creada correctamente
79	TRANSFERENCIA_RECHAZADA	2026-02-27 22:25:12.390192	812	EMPLEADO_EMPRESA	238	Transferencia rechazada por fondos insuficientes
80	TRANSFERENCIA_EJECUTADA	2026-02-27 22:24:12.390192	326	SUPERVISOR_EMPRESA	441	Monto: 25586.87, Estado: Ejecutada
81	PRESTAMO_APROBADO	2026-02-27 22:23:12.390192	200	ANALISTA_INTERNO	923	Monto aprobado: 4879252.70, Tasa: 12.5%
82	CUENTA_CREADA	2026-02-27 22:22:12.390192	195	EMPLEADO_VENTANILLA	117	Cuenta creada correctamente
83	TRANSFERENCIA_RECHAZADA	2026-02-27 22:21:12.390192	879	EMPLEADO_EMPRESA	613	Transferencia rechazada por fondos insuficientes
84	TRANSFERENCIA_EJECUTADA	2026-02-27 22:20:12.390192	775	SUPERVISOR_EMPRESA	832	Monto: 4024.71, Estado: Ejecutada
85	PRESTAMO_APROBADO	2026-02-27 22:19:12.390192	302	ANALISTA_INTERNO	192	Monto aprobado: 14783204.29, Tasa: 12.5%
86	CUENTA_CREADA	2026-02-27 22:18:12.390192	681	EMPLEADO_VENTANILLA	886	Cuenta creada correctamente
87	TRANSFERENCIA_RECHAZADA	2026-02-27 22:17:12.390192	695	EMPLEADO_EMPRESA	469	Transferencia rechazada por fondos insuficientes
88	TRANSFERENCIA_EJECUTADA	2026-02-27 22:16:12.390192	681	SUPERVISOR_EMPRESA	499	Monto: 29025.29, Estado: Ejecutada
89	PRESTAMO_APROBADO	2026-02-27 22:15:12.390192	887	ANALISTA_INTERNO	983	Monto aprobado: 32577651.94, Tasa: 12.5%
90	CUENTA_CREADA	2026-02-27 22:14:12.390192	664	EMPLEADO_VENTANILLA	151	Cuenta creada correctamente
91	TRANSFERENCIA_RECHAZADA	2026-02-27 22:13:12.390192	810	EMPLEADO_EMPRESA	425	Transferencia rechazada por fondos insuficientes
92	TRANSFERENCIA_EJECUTADA	2026-02-27 22:12:12.390192	274	SUPERVISOR_EMPRESA	993	Monto: 23268.16, Estado: Ejecutada
93	PRESTAMO_APROBADO	2026-02-27 22:11:12.390192	72	ANALISTA_INTERNO	649	Monto aprobado: 5966149.57, Tasa: 12.5%
94	CUENTA_CREADA	2026-02-27 22:10:12.390192	143	EMPLEADO_VENTANILLA	8	Cuenta creada correctamente
95	TRANSFERENCIA_RECHAZADA	2026-02-27 22:09:12.390192	264	EMPLEADO_EMPRESA	501	Transferencia rechazada por fondos insuficientes
96	TRANSFERENCIA_EJECUTADA	2026-02-27 22:08:12.390192	506	SUPERVISOR_EMPRESA	264	Monto: 97110.01, Estado: Ejecutada
97	PRESTAMO_APROBADO	2026-02-27 22:07:12.390192	570	ANALISTA_INTERNO	67	Monto aprobado: 4806024.56, Tasa: 12.5%
98	CUENTA_CREADA	2026-02-27 22:06:12.390192	149	EMPLEADO_VENTANILLA	330	Cuenta creada correctamente
99	TRANSFERENCIA_RECHAZADA	2026-02-27 22:05:12.390192	275	EMPLEADO_EMPRESA	998	Transferencia rechazada por fondos insuficientes
100	TRANSFERENCIA_EJECUTADA	2026-02-27 22:04:12.390192	487	SUPERVISOR_EMPRESA	120	Monto: 51075.28, Estado: Ejecutada
101	PRESTAMO_APROBADO	2026-02-27 22:03:12.390192	31	ANALISTA_INTERNO	581	Monto aprobado: 42521252.43, Tasa: 12.5%
102	CUENTA_CREADA	2026-02-27 22:02:12.390192	263	EMPLEADO_VENTANILLA	644	Cuenta creada correctamente
103	TRANSFERENCIA_RECHAZADA	2026-02-27 22:01:12.390192	207	EMPLEADO_EMPRESA	242	Transferencia rechazada por fondos insuficientes
104	TRANSFERENCIA_EJECUTADA	2026-02-27 22:00:12.390192	280	SUPERVISOR_EMPRESA	940	Monto: 4104.69, Estado: Ejecutada
105	PRESTAMO_APROBADO	2026-02-27 21:59:12.390192	670	ANALISTA_INTERNO	669	Monto aprobado: 33731521.37, Tasa: 12.5%
106	CUENTA_CREADA	2026-02-27 21:58:12.390192	940	EMPLEADO_VENTANILLA	157	Cuenta creada correctamente
107	TRANSFERENCIA_RECHAZADA	2026-02-27 21:57:12.390192	951	EMPLEADO_EMPRESA	156	Transferencia rechazada por fondos insuficientes
108	TRANSFERENCIA_EJECUTADA	2026-02-27 21:56:12.390192	271	SUPERVISOR_EMPRESA	528	Monto: 57072.36, Estado: Ejecutada
109	PRESTAMO_APROBADO	2026-02-27 21:55:12.390192	109	ANALISTA_INTERNO	880	Monto aprobado: 2226536.69, Tasa: 12.5%
110	CUENTA_CREADA	2026-02-27 21:54:12.390192	939	EMPLEADO_VENTANILLA	494	Cuenta creada correctamente
111	TRANSFERENCIA_RECHAZADA	2026-02-27 21:53:12.390192	199	EMPLEADO_EMPRESA	930	Transferencia rechazada por fondos insuficientes
112	TRANSFERENCIA_EJECUTADA	2026-02-27 21:52:12.390192	657	SUPERVISOR_EMPRESA	341	Monto: 77838.08, Estado: Ejecutada
113	PRESTAMO_APROBADO	2026-02-27 21:51:12.390192	518	ANALISTA_INTERNO	416	Monto aprobado: 5726055.68, Tasa: 12.5%
114	CUENTA_CREADA	2026-02-27 21:50:12.390192	627	EMPLEADO_VENTANILLA	232	Cuenta creada correctamente
115	TRANSFERENCIA_RECHAZADA	2026-02-27 21:49:12.390192	807	EMPLEADO_EMPRESA	546	Transferencia rechazada por fondos insuficientes
116	TRANSFERENCIA_EJECUTADA	2026-02-27 21:48:12.390192	843	SUPERVISOR_EMPRESA	915	Monto: 17082.77, Estado: Ejecutada
117	PRESTAMO_APROBADO	2026-02-27 21:47:12.390192	863	ANALISTA_INTERNO	461	Monto aprobado: 32078206.53, Tasa: 12.5%
118	CUENTA_CREADA	2026-02-27 21:46:12.390192	204	EMPLEADO_VENTANILLA	883	Cuenta creada correctamente
119	TRANSFERENCIA_RECHAZADA	2026-02-27 21:45:12.390192	194	EMPLEADO_EMPRESA	504	Transferencia rechazada por fondos insuficientes
120	TRANSFERENCIA_EJECUTADA	2026-02-27 21:44:12.390192	563	SUPERVISOR_EMPRESA	788	Monto: 23568.55, Estado: Ejecutada
121	PRESTAMO_APROBADO	2026-02-27 21:43:12.390192	662	ANALISTA_INTERNO	727	Monto aprobado: 46962225.76, Tasa: 12.5%
122	CUENTA_CREADA	2026-02-27 21:42:12.390192	376	EMPLEADO_VENTANILLA	4	Cuenta creada correctamente
123	TRANSFERENCIA_RECHAZADA	2026-02-27 21:41:12.390192	119	EMPLEADO_EMPRESA	802	Transferencia rechazada por fondos insuficientes
124	TRANSFERENCIA_EJECUTADA	2026-02-27 21:40:12.390192	99	SUPERVISOR_EMPRESA	619	Monto: 11828.61, Estado: Ejecutada
125	PRESTAMO_APROBADO	2026-02-27 21:39:12.390192	901	ANALISTA_INTERNO	297	Monto aprobado: 41519505.99, Tasa: 12.5%
126	CUENTA_CREADA	2026-02-27 21:38:12.390192	345	EMPLEADO_VENTANILLA	251	Cuenta creada correctamente
127	TRANSFERENCIA_RECHAZADA	2026-02-27 21:37:12.390192	582	EMPLEADO_EMPRESA	618	Transferencia rechazada por fondos insuficientes
128	TRANSFERENCIA_EJECUTADA	2026-02-27 21:36:12.390192	754	SUPERVISOR_EMPRESA	851	Monto: 38268.74, Estado: Ejecutada
129	PRESTAMO_APROBADO	2026-02-27 21:35:12.390192	754	ANALISTA_INTERNO	673	Monto aprobado: 45019719.33, Tasa: 12.5%
130	CUENTA_CREADA	2026-02-27 21:34:12.390192	715	EMPLEADO_VENTANILLA	157	Cuenta creada correctamente
131	TRANSFERENCIA_RECHAZADA	2026-02-27 21:33:12.390192	353	EMPLEADO_EMPRESA	715	Transferencia rechazada por fondos insuficientes
132	TRANSFERENCIA_EJECUTADA	2026-02-27 21:32:12.390192	2	SUPERVISOR_EMPRESA	200	Monto: 9252.45, Estado: Ejecutada
133	PRESTAMO_APROBADO	2026-02-27 21:31:12.390192	374	ANALISTA_INTERNO	590	Monto aprobado: 35122992.64, Tasa: 12.5%
134	CUENTA_CREADA	2026-02-27 21:30:12.390192	311	EMPLEADO_VENTANILLA	395	Cuenta creada correctamente
135	TRANSFERENCIA_RECHAZADA	2026-02-27 21:29:12.390192	456	EMPLEADO_EMPRESA	233	Transferencia rechazada por fondos insuficientes
136	TRANSFERENCIA_EJECUTADA	2026-02-27 21:28:12.390192	699	SUPERVISOR_EMPRESA	99	Monto: 95638.22, Estado: Ejecutada
137	PRESTAMO_APROBADO	2026-02-27 21:27:12.390192	352	ANALISTA_INTERNO	432	Monto aprobado: 9308838.04, Tasa: 12.5%
138	CUENTA_CREADA	2026-02-27 21:26:12.390192	596	EMPLEADO_VENTANILLA	69	Cuenta creada correctamente
139	TRANSFERENCIA_RECHAZADA	2026-02-27 21:25:12.390192	926	EMPLEADO_EMPRESA	363	Transferencia rechazada por fondos insuficientes
140	TRANSFERENCIA_EJECUTADA	2026-02-27 21:24:12.390192	283	SUPERVISOR_EMPRESA	7	Monto: 53487.04, Estado: Ejecutada
141	PRESTAMO_APROBADO	2026-02-27 21:23:12.390192	468	ANALISTA_INTERNO	552	Monto aprobado: 20563418.38, Tasa: 12.5%
142	CUENTA_CREADA	2026-02-27 21:22:12.390192	774	EMPLEADO_VENTANILLA	711	Cuenta creada correctamente
143	TRANSFERENCIA_RECHAZADA	2026-02-27 21:21:12.390192	765	EMPLEADO_EMPRESA	769	Transferencia rechazada por fondos insuficientes
144	TRANSFERENCIA_EJECUTADA	2026-02-27 21:20:12.390192	460	SUPERVISOR_EMPRESA	607	Monto: 35291.88, Estado: Ejecutada
145	PRESTAMO_APROBADO	2026-02-27 21:19:12.390192	273	ANALISTA_INTERNO	66	Monto aprobado: 48980157.34, Tasa: 12.5%
146	CUENTA_CREADA	2026-02-27 21:18:12.390192	29	EMPLEADO_VENTANILLA	309	Cuenta creada correctamente
147	TRANSFERENCIA_RECHAZADA	2026-02-27 21:17:12.390192	126	EMPLEADO_EMPRESA	108	Transferencia rechazada por fondos insuficientes
148	TRANSFERENCIA_EJECUTADA	2026-02-27 21:16:12.390192	923	SUPERVISOR_EMPRESA	871	Monto: 40358.16, Estado: Ejecutada
149	PRESTAMO_APROBADO	2026-02-27 21:15:12.390192	966	ANALISTA_INTERNO	48	Monto aprobado: 11161649.96, Tasa: 12.5%
150	CUENTA_CREADA	2026-02-27 21:14:12.390192	499	EMPLEADO_VENTANILLA	798	Cuenta creada correctamente
151	TRANSFERENCIA_RECHAZADA	2026-02-27 21:13:12.390192	637	EMPLEADO_EMPRESA	659	Transferencia rechazada por fondos insuficientes
152	TRANSFERENCIA_EJECUTADA	2026-02-27 21:12:12.390192	419	SUPERVISOR_EMPRESA	791	Monto: 42345.38, Estado: Ejecutada
153	PRESTAMO_APROBADO	2026-02-27 21:11:12.390192	799	ANALISTA_INTERNO	289	Monto aprobado: 11106111.68, Tasa: 12.5%
154	CUENTA_CREADA	2026-02-27 21:10:12.390192	318	EMPLEADO_VENTANILLA	77	Cuenta creada correctamente
155	TRANSFERENCIA_RECHAZADA	2026-02-27 21:09:12.390192	681	EMPLEADO_EMPRESA	230	Transferencia rechazada por fondos insuficientes
156	TRANSFERENCIA_EJECUTADA	2026-02-27 21:08:12.390192	805	SUPERVISOR_EMPRESA	347	Monto: 78891.88, Estado: Ejecutada
157	PRESTAMO_APROBADO	2026-02-27 21:07:12.390192	696	ANALISTA_INTERNO	773	Monto aprobado: 22420576.82, Tasa: 12.5%
158	CUENTA_CREADA	2026-02-27 21:06:12.390192	983	EMPLEADO_VENTANILLA	375	Cuenta creada correctamente
159	TRANSFERENCIA_RECHAZADA	2026-02-27 21:05:12.390192	633	EMPLEADO_EMPRESA	255	Transferencia rechazada por fondos insuficientes
160	TRANSFERENCIA_EJECUTADA	2026-02-27 21:04:12.390192	545	SUPERVISOR_EMPRESA	644	Monto: 303.82, Estado: Ejecutada
161	PRESTAMO_APROBADO	2026-02-27 21:03:12.390192	372	ANALISTA_INTERNO	946	Monto aprobado: 14029054.29, Tasa: 12.5%
162	CUENTA_CREADA	2026-02-27 21:02:12.390192	410	EMPLEADO_VENTANILLA	543	Cuenta creada correctamente
163	TRANSFERENCIA_RECHAZADA	2026-02-27 21:01:12.390192	51	EMPLEADO_EMPRESA	426	Transferencia rechazada por fondos insuficientes
164	TRANSFERENCIA_EJECUTADA	2026-02-27 21:00:12.390192	89	SUPERVISOR_EMPRESA	638	Monto: 27421.11, Estado: Ejecutada
165	PRESTAMO_APROBADO	2026-02-27 20:59:12.390192	937	ANALISTA_INTERNO	633	Monto aprobado: 860874.05, Tasa: 12.5%
166	CUENTA_CREADA	2026-02-27 20:58:12.390192	218	EMPLEADO_VENTANILLA	354	Cuenta creada correctamente
167	TRANSFERENCIA_RECHAZADA	2026-02-27 20:57:12.390192	704	EMPLEADO_EMPRESA	315	Transferencia rechazada por fondos insuficientes
168	TRANSFERENCIA_EJECUTADA	2026-02-27 20:56:12.390192	287	SUPERVISOR_EMPRESA	288	Monto: 40544.16, Estado: Ejecutada
169	PRESTAMO_APROBADO	2026-02-27 20:55:12.390192	629	ANALISTA_INTERNO	809	Monto aprobado: 43997566.34, Tasa: 12.5%
170	CUENTA_CREADA	2026-02-27 20:54:12.390192	800	EMPLEADO_VENTANILLA	200	Cuenta creada correctamente
171	TRANSFERENCIA_RECHAZADA	2026-02-27 20:53:12.390192	885	EMPLEADO_EMPRESA	79	Transferencia rechazada por fondos insuficientes
172	TRANSFERENCIA_EJECUTADA	2026-02-27 20:52:12.390192	927	SUPERVISOR_EMPRESA	357	Monto: 5435.93, Estado: Ejecutada
173	PRESTAMO_APROBADO	2026-02-27 20:51:12.390192	739	ANALISTA_INTERNO	343	Monto aprobado: 21751243.56, Tasa: 12.5%
174	CUENTA_CREADA	2026-02-27 20:50:12.390192	758	EMPLEADO_VENTANILLA	307	Cuenta creada correctamente
175	TRANSFERENCIA_RECHAZADA	2026-02-27 20:49:12.390192	526	EMPLEADO_EMPRESA	169	Transferencia rechazada por fondos insuficientes
176	TRANSFERENCIA_EJECUTADA	2026-02-27 20:48:12.390192	907	SUPERVISOR_EMPRESA	6	Monto: 84014.80, Estado: Ejecutada
177	PRESTAMO_APROBADO	2026-02-27 20:47:12.390192	248	ANALISTA_INTERNO	1000	Monto aprobado: 20226116.72, Tasa: 12.5%
178	CUENTA_CREADA	2026-02-27 20:46:12.390192	257	EMPLEADO_VENTANILLA	942	Cuenta creada correctamente
179	TRANSFERENCIA_RECHAZADA	2026-02-27 20:45:12.390192	357	EMPLEADO_EMPRESA	350	Transferencia rechazada por fondos insuficientes
180	TRANSFERENCIA_EJECUTADA	2026-02-27 20:44:12.390192	956	SUPERVISOR_EMPRESA	413	Monto: 88425.85, Estado: Ejecutada
181	PRESTAMO_APROBADO	2026-02-27 20:43:12.390192	637	ANALISTA_INTERNO	781	Monto aprobado: 33062032.98, Tasa: 12.5%
182	CUENTA_CREADA	2026-02-27 20:42:12.390192	274	EMPLEADO_VENTANILLA	28	Cuenta creada correctamente
183	TRANSFERENCIA_RECHAZADA	2026-02-27 20:41:12.390192	287	EMPLEADO_EMPRESA	527	Transferencia rechazada por fondos insuficientes
184	TRANSFERENCIA_EJECUTADA	2026-02-27 20:40:12.390192	174	SUPERVISOR_EMPRESA	354	Monto: 38896.15, Estado: Ejecutada
185	PRESTAMO_APROBADO	2026-02-27 20:39:12.390192	351	ANALISTA_INTERNO	511	Monto aprobado: 14585395.60, Tasa: 12.5%
186	CUENTA_CREADA	2026-02-27 20:38:12.390192	192	EMPLEADO_VENTANILLA	595	Cuenta creada correctamente
187	TRANSFERENCIA_RECHAZADA	2026-02-27 20:37:12.390192	566	EMPLEADO_EMPRESA	78	Transferencia rechazada por fondos insuficientes
188	TRANSFERENCIA_EJECUTADA	2026-02-27 20:36:12.390192	198	SUPERVISOR_EMPRESA	489	Monto: 97872.10, Estado: Ejecutada
189	PRESTAMO_APROBADO	2026-02-27 20:35:12.390192	7	ANALISTA_INTERNO	727	Monto aprobado: 48602944.49, Tasa: 12.5%
190	CUENTA_CREADA	2026-02-27 20:34:12.390192	435	EMPLEADO_VENTANILLA	728	Cuenta creada correctamente
191	TRANSFERENCIA_RECHAZADA	2026-02-27 20:33:12.390192	680	EMPLEADO_EMPRESA	929	Transferencia rechazada por fondos insuficientes
192	TRANSFERENCIA_EJECUTADA	2026-02-27 20:32:12.390192	470	SUPERVISOR_EMPRESA	780	Monto: 7371.02, Estado: Ejecutada
193	PRESTAMO_APROBADO	2026-02-27 20:31:12.390192	958	ANALISTA_INTERNO	771	Monto aprobado: 40816426.93, Tasa: 12.5%
194	CUENTA_CREADA	2026-02-27 20:30:12.390192	288	EMPLEADO_VENTANILLA	398	Cuenta creada correctamente
195	TRANSFERENCIA_RECHAZADA	2026-02-27 20:29:12.390192	8	EMPLEADO_EMPRESA	388	Transferencia rechazada por fondos insuficientes
196	TRANSFERENCIA_EJECUTADA	2026-02-27 20:28:12.390192	429	SUPERVISOR_EMPRESA	273	Monto: 10985.81, Estado: Ejecutada
197	PRESTAMO_APROBADO	2026-02-27 20:27:12.390192	468	ANALISTA_INTERNO	923	Monto aprobado: 11746400.78, Tasa: 12.5%
198	CUENTA_CREADA	2026-02-27 20:26:12.390192	131	EMPLEADO_VENTANILLA	185	Cuenta creada correctamente
199	TRANSFERENCIA_RECHAZADA	2026-02-27 20:25:12.390192	526	EMPLEADO_EMPRESA	480	Transferencia rechazada por fondos insuficientes
200	TRANSFERENCIA_EJECUTADA	2026-02-27 20:24:12.390192	327	SUPERVISOR_EMPRESA	136	Monto: 68625.99, Estado: Ejecutada
201	PRESTAMO_APROBADO	2026-02-27 20:23:12.390192	576	ANALISTA_INTERNO	292	Monto aprobado: 47205021.90, Tasa: 12.5%
202	CUENTA_CREADA	2026-02-27 20:22:12.390192	28	EMPLEADO_VENTANILLA	892	Cuenta creada correctamente
203	TRANSFERENCIA_RECHAZADA	2026-02-27 20:21:12.390192	266	EMPLEADO_EMPRESA	270	Transferencia rechazada por fondos insuficientes
204	TRANSFERENCIA_EJECUTADA	2026-02-27 20:20:12.390192	913	SUPERVISOR_EMPRESA	240	Monto: 24734.83, Estado: Ejecutada
205	PRESTAMO_APROBADO	2026-02-27 20:19:12.390192	318	ANALISTA_INTERNO	182	Monto aprobado: 45685293.01, Tasa: 12.5%
206	CUENTA_CREADA	2026-02-27 20:18:12.390192	468	EMPLEADO_VENTANILLA	787	Cuenta creada correctamente
207	TRANSFERENCIA_RECHAZADA	2026-02-27 20:17:12.390192	172	EMPLEADO_EMPRESA	510	Transferencia rechazada por fondos insuficientes
208	TRANSFERENCIA_EJECUTADA	2026-02-27 20:16:12.390192	445	SUPERVISOR_EMPRESA	540	Monto: 28809.32, Estado: Ejecutada
209	PRESTAMO_APROBADO	2026-02-27 20:15:12.390192	484	ANALISTA_INTERNO	734	Monto aprobado: 14740816.29, Tasa: 12.5%
210	CUENTA_CREADA	2026-02-27 20:14:12.390192	882	EMPLEADO_VENTANILLA	445	Cuenta creada correctamente
211	TRANSFERENCIA_RECHAZADA	2026-02-27 20:13:12.390192	866	EMPLEADO_EMPRESA	110	Transferencia rechazada por fondos insuficientes
212	TRANSFERENCIA_EJECUTADA	2026-02-27 20:12:12.390192	559	SUPERVISOR_EMPRESA	148	Monto: 45611.98, Estado: Ejecutada
213	PRESTAMO_APROBADO	2026-02-27 20:11:12.390192	125	ANALISTA_INTERNO	661	Monto aprobado: 48017093.23, Tasa: 12.5%
214	CUENTA_CREADA	2026-02-27 20:10:12.390192	653	EMPLEADO_VENTANILLA	657	Cuenta creada correctamente
215	TRANSFERENCIA_RECHAZADA	2026-02-27 20:09:12.390192	79	EMPLEADO_EMPRESA	923	Transferencia rechazada por fondos insuficientes
216	TRANSFERENCIA_EJECUTADA	2026-02-27 20:08:12.390192	25	SUPERVISOR_EMPRESA	113	Monto: 73801.58, Estado: Ejecutada
217	PRESTAMO_APROBADO	2026-02-27 20:07:12.390192	200	ANALISTA_INTERNO	581	Monto aprobado: 17127721.25, Tasa: 12.5%
218	CUENTA_CREADA	2026-02-27 20:06:12.390192	424	EMPLEADO_VENTANILLA	919	Cuenta creada correctamente
219	TRANSFERENCIA_RECHAZADA	2026-02-27 20:05:12.390192	157	EMPLEADO_EMPRESA	488	Transferencia rechazada por fondos insuficientes
220	TRANSFERENCIA_EJECUTADA	2026-02-27 20:04:12.390192	401	SUPERVISOR_EMPRESA	236	Monto: 86731.73, Estado: Ejecutada
221	PRESTAMO_APROBADO	2026-02-27 20:03:12.390192	859	ANALISTA_INTERNO	393	Monto aprobado: 23738603.29, Tasa: 12.5%
222	CUENTA_CREADA	2026-02-27 20:02:12.390192	951	EMPLEADO_VENTANILLA	343	Cuenta creada correctamente
223	TRANSFERENCIA_RECHAZADA	2026-02-27 20:01:12.390192	959	EMPLEADO_EMPRESA	831	Transferencia rechazada por fondos insuficientes
224	TRANSFERENCIA_EJECUTADA	2026-02-27 20:00:12.390192	892	SUPERVISOR_EMPRESA	339	Monto: 46034.58, Estado: Ejecutada
225	PRESTAMO_APROBADO	2026-02-27 19:59:12.390192	881	ANALISTA_INTERNO	715	Monto aprobado: 17652856.22, Tasa: 12.5%
226	CUENTA_CREADA	2026-02-27 19:58:12.390192	804	EMPLEADO_VENTANILLA	19	Cuenta creada correctamente
227	TRANSFERENCIA_RECHAZADA	2026-02-27 19:57:12.390192	485	EMPLEADO_EMPRESA	351	Transferencia rechazada por fondos insuficientes
228	TRANSFERENCIA_EJECUTADA	2026-02-27 19:56:12.390192	320	SUPERVISOR_EMPRESA	849	Monto: 21039.61, Estado: Ejecutada
229	PRESTAMO_APROBADO	2026-02-27 19:55:12.390192	772	ANALISTA_INTERNO	828	Monto aprobado: 9619014.56, Tasa: 12.5%
230	CUENTA_CREADA	2026-02-27 19:54:12.390192	187	EMPLEADO_VENTANILLA	757	Cuenta creada correctamente
231	TRANSFERENCIA_RECHAZADA	2026-02-27 19:53:12.390192	38	EMPLEADO_EMPRESA	791	Transferencia rechazada por fondos insuficientes
232	TRANSFERENCIA_EJECUTADA	2026-02-27 19:52:12.390192	371	SUPERVISOR_EMPRESA	584	Monto: 34501.82, Estado: Ejecutada
233	PRESTAMO_APROBADO	2026-02-27 19:51:12.390192	899	ANALISTA_INTERNO	47	Monto aprobado: 37992023.76, Tasa: 12.5%
234	CUENTA_CREADA	2026-02-27 19:50:12.390192	307	EMPLEADO_VENTANILLA	164	Cuenta creada correctamente
235	TRANSFERENCIA_RECHAZADA	2026-02-27 19:49:12.390192	416	EMPLEADO_EMPRESA	591	Transferencia rechazada por fondos insuficientes
236	TRANSFERENCIA_EJECUTADA	2026-02-27 19:48:12.390192	228	SUPERVISOR_EMPRESA	257	Monto: 85459.37, Estado: Ejecutada
237	PRESTAMO_APROBADO	2026-02-27 19:47:12.390192	631	ANALISTA_INTERNO	917	Monto aprobado: 36439002.50, Tasa: 12.5%
238	CUENTA_CREADA	2026-02-27 19:46:12.390192	619	EMPLEADO_VENTANILLA	223	Cuenta creada correctamente
239	TRANSFERENCIA_RECHAZADA	2026-02-27 19:45:12.390192	146	EMPLEADO_EMPRESA	742	Transferencia rechazada por fondos insuficientes
240	TRANSFERENCIA_EJECUTADA	2026-02-27 19:44:12.390192	957	SUPERVISOR_EMPRESA	74	Monto: 95521.23, Estado: Ejecutada
241	PRESTAMO_APROBADO	2026-02-27 19:43:12.390192	419	ANALISTA_INTERNO	411	Monto aprobado: 33499592.31, Tasa: 12.5%
242	CUENTA_CREADA	2026-02-27 19:42:12.390192	287	EMPLEADO_VENTANILLA	13	Cuenta creada correctamente
243	TRANSFERENCIA_RECHAZADA	2026-02-27 19:41:12.390192	942	EMPLEADO_EMPRESA	746	Transferencia rechazada por fondos insuficientes
244	TRANSFERENCIA_EJECUTADA	2026-02-27 19:40:12.390192	61	SUPERVISOR_EMPRESA	449	Monto: 87311.37, Estado: Ejecutada
245	PRESTAMO_APROBADO	2026-02-27 19:39:12.390192	845	ANALISTA_INTERNO	932	Monto aprobado: 47772566.13, Tasa: 12.5%
246	CUENTA_CREADA	2026-02-27 19:38:12.390192	433	EMPLEADO_VENTANILLA	421	Cuenta creada correctamente
247	TRANSFERENCIA_RECHAZADA	2026-02-27 19:37:12.390192	966	EMPLEADO_EMPRESA	32	Transferencia rechazada por fondos insuficientes
248	TRANSFERENCIA_EJECUTADA	2026-02-27 19:36:12.390192	876	SUPERVISOR_EMPRESA	86	Monto: 54195.88, Estado: Ejecutada
249	PRESTAMO_APROBADO	2026-02-27 19:35:12.390192	747	ANALISTA_INTERNO	548	Monto aprobado: 38404443.66, Tasa: 12.5%
250	CUENTA_CREADA	2026-02-27 19:34:12.390192	812	EMPLEADO_VENTANILLA	315	Cuenta creada correctamente
251	TRANSFERENCIA_RECHAZADA	2026-02-27 19:33:12.390192	931	EMPLEADO_EMPRESA	274	Transferencia rechazada por fondos insuficientes
252	TRANSFERENCIA_EJECUTADA	2026-02-27 19:32:12.390192	735	SUPERVISOR_EMPRESA	243	Monto: 80343.16, Estado: Ejecutada
253	PRESTAMO_APROBADO	2026-02-27 19:31:12.390192	23	ANALISTA_INTERNO	505	Monto aprobado: 14995450.85, Tasa: 12.5%
254	CUENTA_CREADA	2026-02-27 19:30:12.390192	37	EMPLEADO_VENTANILLA	507	Cuenta creada correctamente
255	TRANSFERENCIA_RECHAZADA	2026-02-27 19:29:12.390192	885	EMPLEADO_EMPRESA	595	Transferencia rechazada por fondos insuficientes
256	TRANSFERENCIA_EJECUTADA	2026-02-27 19:28:12.390192	803	SUPERVISOR_EMPRESA	702	Monto: 87492.34, Estado: Ejecutada
257	PRESTAMO_APROBADO	2026-02-27 19:27:12.390192	889	ANALISTA_INTERNO	264	Monto aprobado: 12514917.29, Tasa: 12.5%
258	CUENTA_CREADA	2026-02-27 19:26:12.390192	899	EMPLEADO_VENTANILLA	97	Cuenta creada correctamente
259	TRANSFERENCIA_RECHAZADA	2026-02-27 19:25:12.390192	282	EMPLEADO_EMPRESA	390	Transferencia rechazada por fondos insuficientes
260	TRANSFERENCIA_EJECUTADA	2026-02-27 19:24:12.390192	733	SUPERVISOR_EMPRESA	798	Monto: 76052.09, Estado: Ejecutada
261	PRESTAMO_APROBADO	2026-02-27 19:23:12.390192	351	ANALISTA_INTERNO	447	Monto aprobado: 29439529.68, Tasa: 12.5%
262	CUENTA_CREADA	2026-02-27 19:22:12.390192	809	EMPLEADO_VENTANILLA	718	Cuenta creada correctamente
263	TRANSFERENCIA_RECHAZADA	2026-02-27 19:21:12.390192	267	EMPLEADO_EMPRESA	161	Transferencia rechazada por fondos insuficientes
264	TRANSFERENCIA_EJECUTADA	2026-02-27 19:20:12.390192	695	SUPERVISOR_EMPRESA	433	Monto: 67054.14, Estado: Ejecutada
265	PRESTAMO_APROBADO	2026-02-27 19:19:12.390192	550	ANALISTA_INTERNO	645	Monto aprobado: 6436442.80, Tasa: 12.5%
266	CUENTA_CREADA	2026-02-27 19:18:12.390192	932	EMPLEADO_VENTANILLA	661	Cuenta creada correctamente
267	TRANSFERENCIA_RECHAZADA	2026-02-27 19:17:12.390192	828	EMPLEADO_EMPRESA	819	Transferencia rechazada por fondos insuficientes
268	TRANSFERENCIA_EJECUTADA	2026-02-27 19:16:12.390192	184	SUPERVISOR_EMPRESA	878	Monto: 4536.17, Estado: Ejecutada
269	PRESTAMO_APROBADO	2026-02-27 19:15:12.390192	28	ANALISTA_INTERNO	835	Monto aprobado: 6712588.81, Tasa: 12.5%
270	CUENTA_CREADA	2026-02-27 19:14:12.390192	969	EMPLEADO_VENTANILLA	923	Cuenta creada correctamente
271	TRANSFERENCIA_RECHAZADA	2026-02-27 19:13:12.390192	104	EMPLEADO_EMPRESA	340	Transferencia rechazada por fondos insuficientes
272	TRANSFERENCIA_EJECUTADA	2026-02-27 19:12:12.390192	611	SUPERVISOR_EMPRESA	342	Monto: 15871.79, Estado: Ejecutada
273	PRESTAMO_APROBADO	2026-02-27 19:11:12.390192	840	ANALISTA_INTERNO	720	Monto aprobado: 42036851.43, Tasa: 12.5%
274	CUENTA_CREADA	2026-02-27 19:10:12.390192	424	EMPLEADO_VENTANILLA	597	Cuenta creada correctamente
275	TRANSFERENCIA_RECHAZADA	2026-02-27 19:09:12.390192	625	EMPLEADO_EMPRESA	712	Transferencia rechazada por fondos insuficientes
276	TRANSFERENCIA_EJECUTADA	2026-02-27 19:08:12.390192	425	SUPERVISOR_EMPRESA	739	Monto: 44689.70, Estado: Ejecutada
277	PRESTAMO_APROBADO	2026-02-27 19:07:12.390192	86	ANALISTA_INTERNO	90	Monto aprobado: 41078509.89, Tasa: 12.5%
278	CUENTA_CREADA	2026-02-27 19:06:12.390192	521	EMPLEADO_VENTANILLA	462	Cuenta creada correctamente
279	TRANSFERENCIA_RECHAZADA	2026-02-27 19:05:12.390192	601	EMPLEADO_EMPRESA	170	Transferencia rechazada por fondos insuficientes
280	TRANSFERENCIA_EJECUTADA	2026-02-27 19:04:12.390192	330	SUPERVISOR_EMPRESA	856	Monto: 71113.30, Estado: Ejecutada
281	PRESTAMO_APROBADO	2026-02-27 19:03:12.390192	803	ANALISTA_INTERNO	386	Monto aprobado: 34003222.64, Tasa: 12.5%
282	CUENTA_CREADA	2026-02-27 19:02:12.390192	910	EMPLEADO_VENTANILLA	835	Cuenta creada correctamente
283	TRANSFERENCIA_RECHAZADA	2026-02-27 19:01:12.390192	45	EMPLEADO_EMPRESA	136	Transferencia rechazada por fondos insuficientes
284	TRANSFERENCIA_EJECUTADA	2026-02-27 19:00:12.390192	67	SUPERVISOR_EMPRESA	400	Monto: 67373.64, Estado: Ejecutada
285	PRESTAMO_APROBADO	2026-02-27 18:59:12.390192	152	ANALISTA_INTERNO	2	Monto aprobado: 37751559.01, Tasa: 12.5%
286	CUENTA_CREADA	2026-02-27 18:58:12.390192	99	EMPLEADO_VENTANILLA	317	Cuenta creada correctamente
287	TRANSFERENCIA_RECHAZADA	2026-02-27 18:57:12.390192	810	EMPLEADO_EMPRESA	448	Transferencia rechazada por fondos insuficientes
288	TRANSFERENCIA_EJECUTADA	2026-02-27 18:56:12.390192	652	SUPERVISOR_EMPRESA	239	Monto: 40043.73, Estado: Ejecutada
289	PRESTAMO_APROBADO	2026-02-27 18:55:12.390192	179	ANALISTA_INTERNO	371	Monto aprobado: 39957572.37, Tasa: 12.5%
290	CUENTA_CREADA	2026-02-27 18:54:12.390192	555	EMPLEADO_VENTANILLA	70	Cuenta creada correctamente
291	TRANSFERENCIA_RECHAZADA	2026-02-27 18:53:12.390192	512	EMPLEADO_EMPRESA	798	Transferencia rechazada por fondos insuficientes
292	TRANSFERENCIA_EJECUTADA	2026-02-27 18:52:12.390192	623	SUPERVISOR_EMPRESA	616	Monto: 5494.42, Estado: Ejecutada
293	PRESTAMO_APROBADO	2026-02-27 18:51:12.390192	587	ANALISTA_INTERNO	618	Monto aprobado: 31478970.53, Tasa: 12.5%
294	CUENTA_CREADA	2026-02-27 18:50:12.390192	905	EMPLEADO_VENTANILLA	901	Cuenta creada correctamente
295	TRANSFERENCIA_RECHAZADA	2026-02-27 18:49:12.390192	447	EMPLEADO_EMPRESA	175	Transferencia rechazada por fondos insuficientes
296	TRANSFERENCIA_EJECUTADA	2026-02-27 18:48:12.390192	360	SUPERVISOR_EMPRESA	277	Monto: 11486.23, Estado: Ejecutada
297	PRESTAMO_APROBADO	2026-02-27 18:47:12.390192	88	ANALISTA_INTERNO	59	Monto aprobado: 47716279.03, Tasa: 12.5%
298	CUENTA_CREADA	2026-02-27 18:46:12.390192	110	EMPLEADO_VENTANILLA	514	Cuenta creada correctamente
299	TRANSFERENCIA_RECHAZADA	2026-02-27 18:45:12.390192	141	EMPLEADO_EMPRESA	636	Transferencia rechazada por fondos insuficientes
300	TRANSFERENCIA_EJECUTADA	2026-02-27 18:44:12.390192	119	SUPERVISOR_EMPRESA	98	Monto: 6935.46, Estado: Ejecutada
301	PRESTAMO_APROBADO	2026-02-27 18:43:12.390192	930	ANALISTA_INTERNO	623	Monto aprobado: 18276356.68, Tasa: 12.5%
302	CUENTA_CREADA	2026-02-27 18:42:12.390192	909	EMPLEADO_VENTANILLA	55	Cuenta creada correctamente
303	TRANSFERENCIA_RECHAZADA	2026-02-27 18:41:12.390192	689	EMPLEADO_EMPRESA	246	Transferencia rechazada por fondos insuficientes
304	TRANSFERENCIA_EJECUTADA	2026-02-27 18:40:12.390192	194	SUPERVISOR_EMPRESA	15	Monto: 42459.87, Estado: Ejecutada
305	PRESTAMO_APROBADO	2026-02-27 18:39:12.390192	248	ANALISTA_INTERNO	715	Monto aprobado: 13577410.12, Tasa: 12.5%
306	CUENTA_CREADA	2026-02-27 18:38:12.390192	200	EMPLEADO_VENTANILLA	519	Cuenta creada correctamente
307	TRANSFERENCIA_RECHAZADA	2026-02-27 18:37:12.390192	691	EMPLEADO_EMPRESA	574	Transferencia rechazada por fondos insuficientes
308	TRANSFERENCIA_EJECUTADA	2026-02-27 18:36:12.390192	270	SUPERVISOR_EMPRESA	858	Monto: 39291.04, Estado: Ejecutada
309	PRESTAMO_APROBADO	2026-02-27 18:35:12.390192	805	ANALISTA_INTERNO	292	Monto aprobado: 48956903.38, Tasa: 12.5%
310	CUENTA_CREADA	2026-02-27 18:34:12.390192	622	EMPLEADO_VENTANILLA	223	Cuenta creada correctamente
311	TRANSFERENCIA_RECHAZADA	2026-02-27 18:33:12.390192	983	EMPLEADO_EMPRESA	60	Transferencia rechazada por fondos insuficientes
312	TRANSFERENCIA_EJECUTADA	2026-02-27 18:32:12.390192	786	SUPERVISOR_EMPRESA	129	Monto: 32573.13, Estado: Ejecutada
313	PRESTAMO_APROBADO	2026-02-27 18:31:12.390192	304	ANALISTA_INTERNO	431	Monto aprobado: 15028698.68, Tasa: 12.5%
314	CUENTA_CREADA	2026-02-27 18:30:12.390192	599	EMPLEADO_VENTANILLA	694	Cuenta creada correctamente
315	TRANSFERENCIA_RECHAZADA	2026-02-27 18:29:12.390192	615	EMPLEADO_EMPRESA	728	Transferencia rechazada por fondos insuficientes
316	TRANSFERENCIA_EJECUTADA	2026-02-27 18:28:12.390192	682	SUPERVISOR_EMPRESA	157	Monto: 92793.05, Estado: Ejecutada
317	PRESTAMO_APROBADO	2026-02-27 18:27:12.390192	236	ANALISTA_INTERNO	801	Monto aprobado: 2315512.47, Tasa: 12.5%
318	CUENTA_CREADA	2026-02-27 18:26:12.390192	370	EMPLEADO_VENTANILLA	121	Cuenta creada correctamente
319	TRANSFERENCIA_RECHAZADA	2026-02-27 18:25:12.390192	412	EMPLEADO_EMPRESA	668	Transferencia rechazada por fondos insuficientes
320	TRANSFERENCIA_EJECUTADA	2026-02-27 18:24:12.390192	924	SUPERVISOR_EMPRESA	783	Monto: 94020.01, Estado: Ejecutada
321	PRESTAMO_APROBADO	2026-02-27 18:23:12.390192	868	ANALISTA_INTERNO	120	Monto aprobado: 33596219.47, Tasa: 12.5%
322	CUENTA_CREADA	2026-02-27 18:22:12.390192	693	EMPLEADO_VENTANILLA	688	Cuenta creada correctamente
323	TRANSFERENCIA_RECHAZADA	2026-02-27 18:21:12.390192	680	EMPLEADO_EMPRESA	161	Transferencia rechazada por fondos insuficientes
324	TRANSFERENCIA_EJECUTADA	2026-02-27 18:20:12.390192	175	SUPERVISOR_EMPRESA	989	Monto: 90604.48, Estado: Ejecutada
325	PRESTAMO_APROBADO	2026-02-27 18:19:12.390192	416	ANALISTA_INTERNO	751	Monto aprobado: 41333010.21, Tasa: 12.5%
326	CUENTA_CREADA	2026-02-27 18:18:12.390192	466	EMPLEADO_VENTANILLA	608	Cuenta creada correctamente
327	TRANSFERENCIA_RECHAZADA	2026-02-27 18:17:12.390192	94	EMPLEADO_EMPRESA	363	Transferencia rechazada por fondos insuficientes
328	TRANSFERENCIA_EJECUTADA	2026-02-27 18:16:12.390192	374	SUPERVISOR_EMPRESA	42	Monto: 11404.94, Estado: Ejecutada
329	PRESTAMO_APROBADO	2026-02-27 18:15:12.390192	957	ANALISTA_INTERNO	856	Monto aprobado: 39925192.01, Tasa: 12.5%
330	CUENTA_CREADA	2026-02-27 18:14:12.390192	739	EMPLEADO_VENTANILLA	524	Cuenta creada correctamente
331	TRANSFERENCIA_RECHAZADA	2026-02-27 18:13:12.390192	601	EMPLEADO_EMPRESA	80	Transferencia rechazada por fondos insuficientes
332	TRANSFERENCIA_EJECUTADA	2026-02-27 18:12:12.390192	530	SUPERVISOR_EMPRESA	607	Monto: 26973.48, Estado: Ejecutada
333	PRESTAMO_APROBADO	2026-02-27 18:11:12.390192	254	ANALISTA_INTERNO	513	Monto aprobado: 16454651.83, Tasa: 12.5%
334	CUENTA_CREADA	2026-02-27 18:10:12.390192	981	EMPLEADO_VENTANILLA	71	Cuenta creada correctamente
335	TRANSFERENCIA_RECHAZADA	2026-02-27 18:09:12.390192	348	EMPLEADO_EMPRESA	231	Transferencia rechazada por fondos insuficientes
336	TRANSFERENCIA_EJECUTADA	2026-02-27 18:08:12.390192	904	SUPERVISOR_EMPRESA	520	Monto: 66795.48, Estado: Ejecutada
337	PRESTAMO_APROBADO	2026-02-27 18:07:12.390192	323	ANALISTA_INTERNO	862	Monto aprobado: 40876677.73, Tasa: 12.5%
338	CUENTA_CREADA	2026-02-27 18:06:12.390192	338	EMPLEADO_VENTANILLA	375	Cuenta creada correctamente
339	TRANSFERENCIA_RECHAZADA	2026-02-27 18:05:12.390192	963	EMPLEADO_EMPRESA	640	Transferencia rechazada por fondos insuficientes
340	TRANSFERENCIA_EJECUTADA	2026-02-27 18:04:12.390192	37	SUPERVISOR_EMPRESA	965	Monto: 68964.00, Estado: Ejecutada
341	PRESTAMO_APROBADO	2026-02-27 18:03:12.390192	310	ANALISTA_INTERNO	57	Monto aprobado: 6008695.12, Tasa: 12.5%
342	CUENTA_CREADA	2026-02-27 18:02:12.390192	638	EMPLEADO_VENTANILLA	260	Cuenta creada correctamente
343	TRANSFERENCIA_RECHAZADA	2026-02-27 18:01:12.390192	204	EMPLEADO_EMPRESA	751	Transferencia rechazada por fondos insuficientes
344	TRANSFERENCIA_EJECUTADA	2026-02-27 18:00:12.390192	476	SUPERVISOR_EMPRESA	854	Monto: 22365.15, Estado: Ejecutada
345	PRESTAMO_APROBADO	2026-02-27 17:59:12.390192	415	ANALISTA_INTERNO	50	Monto aprobado: 614372.59, Tasa: 12.5%
346	CUENTA_CREADA	2026-02-27 17:58:12.390192	293	EMPLEADO_VENTANILLA	234	Cuenta creada correctamente
347	TRANSFERENCIA_RECHAZADA	2026-02-27 17:57:12.390192	278	EMPLEADO_EMPRESA	513	Transferencia rechazada por fondos insuficientes
348	TRANSFERENCIA_EJECUTADA	2026-02-27 17:56:12.390192	648	SUPERVISOR_EMPRESA	961	Monto: 31273.50, Estado: Ejecutada
349	PRESTAMO_APROBADO	2026-02-27 17:55:12.390192	753	ANALISTA_INTERNO	464	Monto aprobado: 20585279.02, Tasa: 12.5%
350	CUENTA_CREADA	2026-02-27 17:54:12.390192	418	EMPLEADO_VENTANILLA	121	Cuenta creada correctamente
351	TRANSFERENCIA_RECHAZADA	2026-02-27 17:53:12.390192	192	EMPLEADO_EMPRESA	33	Transferencia rechazada por fondos insuficientes
352	TRANSFERENCIA_EJECUTADA	2026-02-27 17:52:12.390192	272	SUPERVISOR_EMPRESA	482	Monto: 1942.49, Estado: Ejecutada
353	PRESTAMO_APROBADO	2026-02-27 17:51:12.390192	364	ANALISTA_INTERNO	997	Monto aprobado: 38432087.68, Tasa: 12.5%
354	CUENTA_CREADA	2026-02-27 17:50:12.390192	638	EMPLEADO_VENTANILLA	981	Cuenta creada correctamente
355	TRANSFERENCIA_RECHAZADA	2026-02-27 17:49:12.390192	789	EMPLEADO_EMPRESA	124	Transferencia rechazada por fondos insuficientes
356	TRANSFERENCIA_EJECUTADA	2026-02-27 17:48:12.390192	553	SUPERVISOR_EMPRESA	328	Monto: 73082.95, Estado: Ejecutada
357	PRESTAMO_APROBADO	2026-02-27 17:47:12.390192	799	ANALISTA_INTERNO	20	Monto aprobado: 35046224.27, Tasa: 12.5%
358	CUENTA_CREADA	2026-02-27 17:46:12.390192	525	EMPLEADO_VENTANILLA	146	Cuenta creada correctamente
359	TRANSFERENCIA_RECHAZADA	2026-02-27 17:45:12.390192	912	EMPLEADO_EMPRESA	283	Transferencia rechazada por fondos insuficientes
360	TRANSFERENCIA_EJECUTADA	2026-02-27 17:44:12.390192	106	SUPERVISOR_EMPRESA	485	Monto: 90399.89, Estado: Ejecutada
361	PRESTAMO_APROBADO	2026-02-27 17:43:12.390192	498	ANALISTA_INTERNO	46	Monto aprobado: 44419479.18, Tasa: 12.5%
362	CUENTA_CREADA	2026-02-27 17:42:12.390192	842	EMPLEADO_VENTANILLA	879	Cuenta creada correctamente
363	TRANSFERENCIA_RECHAZADA	2026-02-27 17:41:12.390192	801	EMPLEADO_EMPRESA	417	Transferencia rechazada por fondos insuficientes
364	TRANSFERENCIA_EJECUTADA	2026-02-27 17:40:12.390192	740	SUPERVISOR_EMPRESA	609	Monto: 20099.63, Estado: Ejecutada
365	PRESTAMO_APROBADO	2026-02-27 17:39:12.390192	358	ANALISTA_INTERNO	587	Monto aprobado: 44233220.36, Tasa: 12.5%
366	CUENTA_CREADA	2026-02-27 17:38:12.390192	627	EMPLEADO_VENTANILLA	782	Cuenta creada correctamente
367	TRANSFERENCIA_RECHAZADA	2026-02-27 17:37:12.390192	769	EMPLEADO_EMPRESA	366	Transferencia rechazada por fondos insuficientes
368	TRANSFERENCIA_EJECUTADA	2026-02-27 17:36:12.390192	726	SUPERVISOR_EMPRESA	767	Monto: 88558.09, Estado: Ejecutada
369	PRESTAMO_APROBADO	2026-02-27 17:35:12.390192	133	ANALISTA_INTERNO	831	Monto aprobado: 33764173.09, Tasa: 12.5%
370	CUENTA_CREADA	2026-02-27 17:34:12.390192	915	EMPLEADO_VENTANILLA	254	Cuenta creada correctamente
371	TRANSFERENCIA_RECHAZADA	2026-02-27 17:33:12.390192	768	EMPLEADO_EMPRESA	961	Transferencia rechazada por fondos insuficientes
372	TRANSFERENCIA_EJECUTADA	2026-02-27 17:32:12.390192	254	SUPERVISOR_EMPRESA	694	Monto: 61062.31, Estado: Ejecutada
373	PRESTAMO_APROBADO	2026-02-27 17:31:12.390192	731	ANALISTA_INTERNO	892	Monto aprobado: 37007150.79, Tasa: 12.5%
374	CUENTA_CREADA	2026-02-27 17:30:12.390192	662	EMPLEADO_VENTANILLA	29	Cuenta creada correctamente
375	TRANSFERENCIA_RECHAZADA	2026-02-27 17:29:12.390192	755	EMPLEADO_EMPRESA	206	Transferencia rechazada por fondos insuficientes
376	TRANSFERENCIA_EJECUTADA	2026-02-27 17:28:12.390192	828	SUPERVISOR_EMPRESA	425	Monto: 52844.18, Estado: Ejecutada
377	PRESTAMO_APROBADO	2026-02-27 17:27:12.390192	746	ANALISTA_INTERNO	537	Monto aprobado: 25074489.02, Tasa: 12.5%
378	CUENTA_CREADA	2026-02-27 17:26:12.390192	117	EMPLEADO_VENTANILLA	47	Cuenta creada correctamente
379	TRANSFERENCIA_RECHAZADA	2026-02-27 17:25:12.390192	920	EMPLEADO_EMPRESA	345	Transferencia rechazada por fondos insuficientes
380	TRANSFERENCIA_EJECUTADA	2026-02-27 17:24:12.390192	217	SUPERVISOR_EMPRESA	164	Monto: 52077.62, Estado: Ejecutada
381	PRESTAMO_APROBADO	2026-02-27 17:23:12.390192	935	ANALISTA_INTERNO	1000	Monto aprobado: 26703651.93, Tasa: 12.5%
382	CUENTA_CREADA	2026-02-27 17:22:12.390192	85	EMPLEADO_VENTANILLA	227	Cuenta creada correctamente
383	TRANSFERENCIA_RECHAZADA	2026-02-27 17:21:12.390192	200	EMPLEADO_EMPRESA	94	Transferencia rechazada por fondos insuficientes
384	TRANSFERENCIA_EJECUTADA	2026-02-27 17:20:12.390192	380	SUPERVISOR_EMPRESA	141	Monto: 91754.13, Estado: Ejecutada
385	PRESTAMO_APROBADO	2026-02-27 17:19:12.390192	780	ANALISTA_INTERNO	475	Monto aprobado: 13532081.89, Tasa: 12.5%
386	CUENTA_CREADA	2026-02-27 17:18:12.390192	75	EMPLEADO_VENTANILLA	598	Cuenta creada correctamente
387	TRANSFERENCIA_RECHAZADA	2026-02-27 17:17:12.390192	555	EMPLEADO_EMPRESA	370	Transferencia rechazada por fondos insuficientes
388	TRANSFERENCIA_EJECUTADA	2026-02-27 17:16:12.390192	98	SUPERVISOR_EMPRESA	876	Monto: 3368.18, Estado: Ejecutada
389	PRESTAMO_APROBADO	2026-02-27 17:15:12.390192	318	ANALISTA_INTERNO	63	Monto aprobado: 49606360.65, Tasa: 12.5%
390	CUENTA_CREADA	2026-02-27 17:14:12.390192	806	EMPLEADO_VENTANILLA	571	Cuenta creada correctamente
391	TRANSFERENCIA_RECHAZADA	2026-02-27 17:13:12.390192	30	EMPLEADO_EMPRESA	490	Transferencia rechazada por fondos insuficientes
392	TRANSFERENCIA_EJECUTADA	2026-02-27 17:12:12.390192	182	SUPERVISOR_EMPRESA	332	Monto: 87711.67, Estado: Ejecutada
393	PRESTAMO_APROBADO	2026-02-27 17:11:12.390192	796	ANALISTA_INTERNO	851	Monto aprobado: 46800786.84, Tasa: 12.5%
394	CUENTA_CREADA	2026-02-27 17:10:12.390192	972	EMPLEADO_VENTANILLA	453	Cuenta creada correctamente
395	TRANSFERENCIA_RECHAZADA	2026-02-27 17:09:12.390192	598	EMPLEADO_EMPRESA	542	Transferencia rechazada por fondos insuficientes
396	TRANSFERENCIA_EJECUTADA	2026-02-27 17:08:12.390192	649	SUPERVISOR_EMPRESA	120	Monto: 40920.06, Estado: Ejecutada
397	PRESTAMO_APROBADO	2026-02-27 17:07:12.390192	675	ANALISTA_INTERNO	515	Monto aprobado: 49049224.47, Tasa: 12.5%
398	CUENTA_CREADA	2026-02-27 17:06:12.390192	837	EMPLEADO_VENTANILLA	741	Cuenta creada correctamente
399	TRANSFERENCIA_RECHAZADA	2026-02-27 17:05:12.390192	105	EMPLEADO_EMPRESA	987	Transferencia rechazada por fondos insuficientes
400	TRANSFERENCIA_EJECUTADA	2026-02-27 17:04:12.390192	543	SUPERVISOR_EMPRESA	151	Monto: 73706.44, Estado: Ejecutada
401	PRESTAMO_APROBADO	2026-02-27 17:03:12.390192	720	ANALISTA_INTERNO	794	Monto aprobado: 29868946.74, Tasa: 12.5%
402	CUENTA_CREADA	2026-02-27 17:02:12.390192	848	EMPLEADO_VENTANILLA	275	Cuenta creada correctamente
403	TRANSFERENCIA_RECHAZADA	2026-02-27 17:01:12.390192	804	EMPLEADO_EMPRESA	441	Transferencia rechazada por fondos insuficientes
404	TRANSFERENCIA_EJECUTADA	2026-02-27 17:00:12.390192	8	SUPERVISOR_EMPRESA	906	Monto: 2445.67, Estado: Ejecutada
405	PRESTAMO_APROBADO	2026-02-27 16:59:12.390192	469	ANALISTA_INTERNO	227	Monto aprobado: 43956553.49, Tasa: 12.5%
406	CUENTA_CREADA	2026-02-27 16:58:12.390192	178	EMPLEADO_VENTANILLA	366	Cuenta creada correctamente
407	TRANSFERENCIA_RECHAZADA	2026-02-27 16:57:12.390192	534	EMPLEADO_EMPRESA	263	Transferencia rechazada por fondos insuficientes
408	TRANSFERENCIA_EJECUTADA	2026-02-27 16:56:12.390192	723	SUPERVISOR_EMPRESA	740	Monto: 4179.63, Estado: Ejecutada
409	PRESTAMO_APROBADO	2026-02-27 16:55:12.390192	761	ANALISTA_INTERNO	640	Monto aprobado: 34206547.24, Tasa: 12.5%
410	CUENTA_CREADA	2026-02-27 16:54:12.390192	463	EMPLEADO_VENTANILLA	646	Cuenta creada correctamente
411	TRANSFERENCIA_RECHAZADA	2026-02-27 16:53:12.390192	172	EMPLEADO_EMPRESA	46	Transferencia rechazada por fondos insuficientes
412	TRANSFERENCIA_EJECUTADA	2026-02-27 16:52:12.390192	636	SUPERVISOR_EMPRESA	169	Monto: 77954.91, Estado: Ejecutada
413	PRESTAMO_APROBADO	2026-02-27 16:51:12.390192	410	ANALISTA_INTERNO	273	Monto aprobado: 48079234.04, Tasa: 12.5%
414	CUENTA_CREADA	2026-02-27 16:50:12.390192	493	EMPLEADO_VENTANILLA	380	Cuenta creada correctamente
415	TRANSFERENCIA_RECHAZADA	2026-02-27 16:49:12.390192	399	EMPLEADO_EMPRESA	913	Transferencia rechazada por fondos insuficientes
416	TRANSFERENCIA_EJECUTADA	2026-02-27 16:48:12.390192	616	SUPERVISOR_EMPRESA	734	Monto: 49477.21, Estado: Ejecutada
417	PRESTAMO_APROBADO	2026-02-27 16:47:12.390192	142	ANALISTA_INTERNO	510	Monto aprobado: 38372126.31, Tasa: 12.5%
418	CUENTA_CREADA	2026-02-27 16:46:12.390192	512	EMPLEADO_VENTANILLA	973	Cuenta creada correctamente
419	TRANSFERENCIA_RECHAZADA	2026-02-27 16:45:12.390192	297	EMPLEADO_EMPRESA	566	Transferencia rechazada por fondos insuficientes
420	TRANSFERENCIA_EJECUTADA	2026-02-27 16:44:12.390192	445	SUPERVISOR_EMPRESA	27	Monto: 40760.56, Estado: Ejecutada
421	PRESTAMO_APROBADO	2026-02-27 16:43:12.390192	159	ANALISTA_INTERNO	578	Monto aprobado: 34062293.57, Tasa: 12.5%
422	CUENTA_CREADA	2026-02-27 16:42:12.390192	122	EMPLEADO_VENTANILLA	726	Cuenta creada correctamente
423	TRANSFERENCIA_RECHAZADA	2026-02-27 16:41:12.390192	953	EMPLEADO_EMPRESA	622	Transferencia rechazada por fondos insuficientes
424	TRANSFERENCIA_EJECUTADA	2026-02-27 16:40:12.390192	344	SUPERVISOR_EMPRESA	603	Monto: 18411.59, Estado: Ejecutada
425	PRESTAMO_APROBADO	2026-02-27 16:39:12.390192	689	ANALISTA_INTERNO	532	Monto aprobado: 49681077.16, Tasa: 12.5%
426	CUENTA_CREADA	2026-02-27 16:38:12.390192	108	EMPLEADO_VENTANILLA	285	Cuenta creada correctamente
427	TRANSFERENCIA_RECHAZADA	2026-02-27 16:37:12.390192	192	EMPLEADO_EMPRESA	700	Transferencia rechazada por fondos insuficientes
428	TRANSFERENCIA_EJECUTADA	2026-02-27 16:36:12.390192	105	SUPERVISOR_EMPRESA	711	Monto: 2593.06, Estado: Ejecutada
429	PRESTAMO_APROBADO	2026-02-27 16:35:12.390192	360	ANALISTA_INTERNO	728	Monto aprobado: 23426011.21, Tasa: 12.5%
430	CUENTA_CREADA	2026-02-27 16:34:12.390192	648	EMPLEADO_VENTANILLA	503	Cuenta creada correctamente
431	TRANSFERENCIA_RECHAZADA	2026-02-27 16:33:12.390192	15	EMPLEADO_EMPRESA	569	Transferencia rechazada por fondos insuficientes
432	TRANSFERENCIA_EJECUTADA	2026-02-27 16:32:12.390192	119	SUPERVISOR_EMPRESA	206	Monto: 39539.92, Estado: Ejecutada
433	PRESTAMO_APROBADO	2026-02-27 16:31:12.390192	433	ANALISTA_INTERNO	759	Monto aprobado: 29871735.79, Tasa: 12.5%
434	CUENTA_CREADA	2026-02-27 16:30:12.390192	66	EMPLEADO_VENTANILLA	504	Cuenta creada correctamente
435	TRANSFERENCIA_RECHAZADA	2026-02-27 16:29:12.390192	995	EMPLEADO_EMPRESA	448	Transferencia rechazada por fondos insuficientes
436	TRANSFERENCIA_EJECUTADA	2026-02-27 16:28:12.390192	953	SUPERVISOR_EMPRESA	135	Monto: 66833.19, Estado: Ejecutada
437	PRESTAMO_APROBADO	2026-02-27 16:27:12.390192	754	ANALISTA_INTERNO	161	Monto aprobado: 20935906.74, Tasa: 12.5%
438	CUENTA_CREADA	2026-02-27 16:26:12.390192	72	EMPLEADO_VENTANILLA	62	Cuenta creada correctamente
439	TRANSFERENCIA_RECHAZADA	2026-02-27 16:25:12.390192	202	EMPLEADO_EMPRESA	632	Transferencia rechazada por fondos insuficientes
440	TRANSFERENCIA_EJECUTADA	2026-02-27 16:24:12.390192	972	SUPERVISOR_EMPRESA	99	Monto: 57349.89, Estado: Ejecutada
441	PRESTAMO_APROBADO	2026-02-27 16:23:12.390192	260	ANALISTA_INTERNO	152	Monto aprobado: 26625071.09, Tasa: 12.5%
442	CUENTA_CREADA	2026-02-27 16:22:12.390192	848	EMPLEADO_VENTANILLA	792	Cuenta creada correctamente
443	TRANSFERENCIA_RECHAZADA	2026-02-27 16:21:12.390192	365	EMPLEADO_EMPRESA	357	Transferencia rechazada por fondos insuficientes
444	TRANSFERENCIA_EJECUTADA	2026-02-27 16:20:12.390192	615	SUPERVISOR_EMPRESA	329	Monto: 43893.68, Estado: Ejecutada
445	PRESTAMO_APROBADO	2026-02-27 16:19:12.390192	628	ANALISTA_INTERNO	96	Monto aprobado: 44709480.19, Tasa: 12.5%
446	CUENTA_CREADA	2026-02-27 16:18:12.390192	625	EMPLEADO_VENTANILLA	705	Cuenta creada correctamente
447	TRANSFERENCIA_RECHAZADA	2026-02-27 16:17:12.390192	667	EMPLEADO_EMPRESA	481	Transferencia rechazada por fondos insuficientes
448	TRANSFERENCIA_EJECUTADA	2026-02-27 16:16:12.390192	50	SUPERVISOR_EMPRESA	826	Monto: 56801.65, Estado: Ejecutada
449	PRESTAMO_APROBADO	2026-02-27 16:15:12.390192	924	ANALISTA_INTERNO	353	Monto aprobado: 15644041.34, Tasa: 12.5%
450	CUENTA_CREADA	2026-02-27 16:14:12.390192	768	EMPLEADO_VENTANILLA	772	Cuenta creada correctamente
451	TRANSFERENCIA_RECHAZADA	2026-02-27 16:13:12.390192	902	EMPLEADO_EMPRESA	441	Transferencia rechazada por fondos insuficientes
452	TRANSFERENCIA_EJECUTADA	2026-02-27 16:12:12.390192	436	SUPERVISOR_EMPRESA	603	Monto: 95271.54, Estado: Ejecutada
453	PRESTAMO_APROBADO	2026-02-27 16:11:12.390192	460	ANALISTA_INTERNO	658	Monto aprobado: 36693639.57, Tasa: 12.5%
454	CUENTA_CREADA	2026-02-27 16:10:12.390192	120	EMPLEADO_VENTANILLA	383	Cuenta creada correctamente
455	TRANSFERENCIA_RECHAZADA	2026-02-27 16:09:12.390192	401	EMPLEADO_EMPRESA	377	Transferencia rechazada por fondos insuficientes
456	TRANSFERENCIA_EJECUTADA	2026-02-27 16:08:12.390192	661	SUPERVISOR_EMPRESA	521	Monto: 51164.48, Estado: Ejecutada
457	PRESTAMO_APROBADO	2026-02-27 16:07:12.390192	213	ANALISTA_INTERNO	335	Monto aprobado: 43403934.45, Tasa: 12.5%
458	CUENTA_CREADA	2026-02-27 16:06:12.390192	417	EMPLEADO_VENTANILLA	983	Cuenta creada correctamente
459	TRANSFERENCIA_RECHAZADA	2026-02-27 16:05:12.390192	763	EMPLEADO_EMPRESA	503	Transferencia rechazada por fondos insuficientes
460	TRANSFERENCIA_EJECUTADA	2026-02-27 16:04:12.390192	11	SUPERVISOR_EMPRESA	667	Monto: 15891.02, Estado: Ejecutada
461	PRESTAMO_APROBADO	2026-02-27 16:03:12.390192	197	ANALISTA_INTERNO	217	Monto aprobado: 20728028.39, Tasa: 12.5%
462	CUENTA_CREADA	2026-02-27 16:02:12.390192	142	EMPLEADO_VENTANILLA	173	Cuenta creada correctamente
463	TRANSFERENCIA_RECHAZADA	2026-02-27 16:01:12.390192	19	EMPLEADO_EMPRESA	560	Transferencia rechazada por fondos insuficientes
464	TRANSFERENCIA_EJECUTADA	2026-02-27 16:00:12.390192	925	SUPERVISOR_EMPRESA	529	Monto: 17403.45, Estado: Ejecutada
465	PRESTAMO_APROBADO	2026-02-27 15:59:12.390192	142	ANALISTA_INTERNO	627	Monto aprobado: 33745731.84, Tasa: 12.5%
466	CUENTA_CREADA	2026-02-27 15:58:12.390192	465	EMPLEADO_VENTANILLA	319	Cuenta creada correctamente
467	TRANSFERENCIA_RECHAZADA	2026-02-27 15:57:12.390192	289	EMPLEADO_EMPRESA	368	Transferencia rechazada por fondos insuficientes
468	TRANSFERENCIA_EJECUTADA	2026-02-27 15:56:12.390192	388	SUPERVISOR_EMPRESA	853	Monto: 39306.49, Estado: Ejecutada
469	PRESTAMO_APROBADO	2026-02-27 15:55:12.390192	704	ANALISTA_INTERNO	630	Monto aprobado: 18807528.60, Tasa: 12.5%
470	CUENTA_CREADA	2026-02-27 15:54:12.390192	652	EMPLEADO_VENTANILLA	148	Cuenta creada correctamente
471	TRANSFERENCIA_RECHAZADA	2026-02-27 15:53:12.390192	253	EMPLEADO_EMPRESA	542	Transferencia rechazada por fondos insuficientes
472	TRANSFERENCIA_EJECUTADA	2026-02-27 15:52:12.390192	965	SUPERVISOR_EMPRESA	715	Monto: 35731.55, Estado: Ejecutada
473	PRESTAMO_APROBADO	2026-02-27 15:51:12.390192	638	ANALISTA_INTERNO	178	Monto aprobado: 29831219.78, Tasa: 12.5%
474	CUENTA_CREADA	2026-02-27 15:50:12.390192	88	EMPLEADO_VENTANILLA	348	Cuenta creada correctamente
475	TRANSFERENCIA_RECHAZADA	2026-02-27 15:49:12.390192	558	EMPLEADO_EMPRESA	268	Transferencia rechazada por fondos insuficientes
476	TRANSFERENCIA_EJECUTADA	2026-02-27 15:48:12.390192	613	SUPERVISOR_EMPRESA	898	Monto: 20181.28, Estado: Ejecutada
477	PRESTAMO_APROBADO	2026-02-27 15:47:12.390192	677	ANALISTA_INTERNO	836	Monto aprobado: 23611637.83, Tasa: 12.5%
478	CUENTA_CREADA	2026-02-27 15:46:12.390192	124	EMPLEADO_VENTANILLA	96	Cuenta creada correctamente
479	TRANSFERENCIA_RECHAZADA	2026-02-27 15:45:12.390192	885	EMPLEADO_EMPRESA	78	Transferencia rechazada por fondos insuficientes
480	TRANSFERENCIA_EJECUTADA	2026-02-27 15:44:12.390192	633	SUPERVISOR_EMPRESA	833	Monto: 32677.63, Estado: Ejecutada
481	PRESTAMO_APROBADO	2026-02-27 15:43:12.390192	387	ANALISTA_INTERNO	468	Monto aprobado: 22017790.86, Tasa: 12.5%
482	CUENTA_CREADA	2026-02-27 15:42:12.390192	157	EMPLEADO_VENTANILLA	651	Cuenta creada correctamente
483	TRANSFERENCIA_RECHAZADA	2026-02-27 15:41:12.390192	580	EMPLEADO_EMPRESA	121	Transferencia rechazada por fondos insuficientes
484	TRANSFERENCIA_EJECUTADA	2026-02-27 15:40:12.390192	84	SUPERVISOR_EMPRESA	831	Monto: 24412.31, Estado: Ejecutada
485	PRESTAMO_APROBADO	2026-02-27 15:39:12.390192	359	ANALISTA_INTERNO	348	Monto aprobado: 42749642.01, Tasa: 12.5%
486	CUENTA_CREADA	2026-02-27 15:38:12.390192	214	EMPLEADO_VENTANILLA	621	Cuenta creada correctamente
487	TRANSFERENCIA_RECHAZADA	2026-02-27 15:37:12.390192	127	EMPLEADO_EMPRESA	290	Transferencia rechazada por fondos insuficientes
488	TRANSFERENCIA_EJECUTADA	2026-02-27 15:36:12.390192	320	SUPERVISOR_EMPRESA	542	Monto: 41634.90, Estado: Ejecutada
489	PRESTAMO_APROBADO	2026-02-27 15:35:12.390192	816	ANALISTA_INTERNO	960	Monto aprobado: 29863634.36, Tasa: 12.5%
490	CUENTA_CREADA	2026-02-27 15:34:12.390192	545	EMPLEADO_VENTANILLA	21	Cuenta creada correctamente
491	TRANSFERENCIA_RECHAZADA	2026-02-27 15:33:12.390192	456	EMPLEADO_EMPRESA	387	Transferencia rechazada por fondos insuficientes
492	TRANSFERENCIA_EJECUTADA	2026-02-27 15:32:12.390192	426	SUPERVISOR_EMPRESA	167	Monto: 51795.08, Estado: Ejecutada
493	PRESTAMO_APROBADO	2026-02-27 15:31:12.390192	802	ANALISTA_INTERNO	718	Monto aprobado: 2811945.79, Tasa: 12.5%
494	CUENTA_CREADA	2026-02-27 15:30:12.390192	479	EMPLEADO_VENTANILLA	569	Cuenta creada correctamente
495	TRANSFERENCIA_RECHAZADA	2026-02-27 15:29:12.390192	343	EMPLEADO_EMPRESA	517	Transferencia rechazada por fondos insuficientes
496	TRANSFERENCIA_EJECUTADA	2026-02-27 15:28:12.390192	589	SUPERVISOR_EMPRESA	167	Monto: 59670.83, Estado: Ejecutada
497	PRESTAMO_APROBADO	2026-02-27 15:27:12.390192	139	ANALISTA_INTERNO	468	Monto aprobado: 25100352.22, Tasa: 12.5%
498	CUENTA_CREADA	2026-02-27 15:26:12.390192	998	EMPLEADO_VENTANILLA	366	Cuenta creada correctamente
499	TRANSFERENCIA_RECHAZADA	2026-02-27 15:25:12.390192	881	EMPLEADO_EMPRESA	110	Transferencia rechazada por fondos insuficientes
500	TRANSFERENCIA_EJECUTADA	2026-02-27 15:24:12.390192	795	SUPERVISOR_EMPRESA	706	Monto: 42136.54, Estado: Ejecutada
501	PRESTAMO_APROBADO	2026-02-27 15:23:12.390192	627	ANALISTA_INTERNO	871	Monto aprobado: 47224883.19, Tasa: 12.5%
502	CUENTA_CREADA	2026-02-27 15:22:12.390192	79	EMPLEADO_VENTANILLA	783	Cuenta creada correctamente
503	TRANSFERENCIA_RECHAZADA	2026-02-27 15:21:12.390192	916	EMPLEADO_EMPRESA	386	Transferencia rechazada por fondos insuficientes
504	TRANSFERENCIA_EJECUTADA	2026-02-27 15:20:12.390192	99	SUPERVISOR_EMPRESA	151	Monto: 64289.13, Estado: Ejecutada
505	PRESTAMO_APROBADO	2026-02-27 15:19:12.390192	532	ANALISTA_INTERNO	349	Monto aprobado: 22094243.19, Tasa: 12.5%
506	CUENTA_CREADA	2026-02-27 15:18:12.390192	896	EMPLEADO_VENTANILLA	143	Cuenta creada correctamente
507	TRANSFERENCIA_RECHAZADA	2026-02-27 15:17:12.390192	97	EMPLEADO_EMPRESA	276	Transferencia rechazada por fondos insuficientes
508	TRANSFERENCIA_EJECUTADA	2026-02-27 15:16:12.390192	320	SUPERVISOR_EMPRESA	461	Monto: 64114.49, Estado: Ejecutada
509	PRESTAMO_APROBADO	2026-02-27 15:15:12.390192	591	ANALISTA_INTERNO	637	Monto aprobado: 41277426.14, Tasa: 12.5%
510	CUENTA_CREADA	2026-02-27 15:14:12.390192	267	EMPLEADO_VENTANILLA	707	Cuenta creada correctamente
511	TRANSFERENCIA_RECHAZADA	2026-02-27 15:13:12.390192	841	EMPLEADO_EMPRESA	652	Transferencia rechazada por fondos insuficientes
512	TRANSFERENCIA_EJECUTADA	2026-02-27 15:12:12.390192	131	SUPERVISOR_EMPRESA	125	Monto: 22925.88, Estado: Ejecutada
513	PRESTAMO_APROBADO	2026-02-27 15:11:12.390192	853	ANALISTA_INTERNO	786	Monto aprobado: 38165361.24, Tasa: 12.5%
514	CUENTA_CREADA	2026-02-27 15:10:12.390192	409	EMPLEADO_VENTANILLA	228	Cuenta creada correctamente
515	TRANSFERENCIA_RECHAZADA	2026-02-27 15:09:12.390192	87	EMPLEADO_EMPRESA	715	Transferencia rechazada por fondos insuficientes
516	TRANSFERENCIA_EJECUTADA	2026-02-27 15:08:12.390192	831	SUPERVISOR_EMPRESA	516	Monto: 32497.88, Estado: Ejecutada
517	PRESTAMO_APROBADO	2026-02-27 15:07:12.390192	143	ANALISTA_INTERNO	697	Monto aprobado: 35342737.63, Tasa: 12.5%
518	CUENTA_CREADA	2026-02-27 15:06:12.390192	623	EMPLEADO_VENTANILLA	828	Cuenta creada correctamente
519	TRANSFERENCIA_RECHAZADA	2026-02-27 15:05:12.390192	464	EMPLEADO_EMPRESA	757	Transferencia rechazada por fondos insuficientes
520	TRANSFERENCIA_EJECUTADA	2026-02-27 15:04:12.390192	79	SUPERVISOR_EMPRESA	684	Monto: 98846.27, Estado: Ejecutada
521	PRESTAMO_APROBADO	2026-02-27 15:03:12.390192	676	ANALISTA_INTERNO	116	Monto aprobado: 38005188.37, Tasa: 12.5%
522	CUENTA_CREADA	2026-02-27 15:02:12.390192	625	EMPLEADO_VENTANILLA	141	Cuenta creada correctamente
523	TRANSFERENCIA_RECHAZADA	2026-02-27 15:01:12.390192	425	EMPLEADO_EMPRESA	194	Transferencia rechazada por fondos insuficientes
524	TRANSFERENCIA_EJECUTADA	2026-02-27 15:00:12.390192	723	SUPERVISOR_EMPRESA	450	Monto: 76156.94, Estado: Ejecutada
525	PRESTAMO_APROBADO	2026-02-27 14:59:12.390192	323	ANALISTA_INTERNO	364	Monto aprobado: 5741357.63, Tasa: 12.5%
526	CUENTA_CREADA	2026-02-27 14:58:12.390192	212	EMPLEADO_VENTANILLA	362	Cuenta creada correctamente
527	TRANSFERENCIA_RECHAZADA	2026-02-27 14:57:12.390192	372	EMPLEADO_EMPRESA	485	Transferencia rechazada por fondos insuficientes
528	TRANSFERENCIA_EJECUTADA	2026-02-27 14:56:12.390192	637	SUPERVISOR_EMPRESA	769	Monto: 95096.29, Estado: Ejecutada
529	PRESTAMO_APROBADO	2026-02-27 14:55:12.390192	88	ANALISTA_INTERNO	738	Monto aprobado: 14053937.78, Tasa: 12.5%
530	CUENTA_CREADA	2026-02-27 14:54:12.390192	836	EMPLEADO_VENTANILLA	624	Cuenta creada correctamente
531	TRANSFERENCIA_RECHAZADA	2026-02-27 14:53:12.390192	534	EMPLEADO_EMPRESA	506	Transferencia rechazada por fondos insuficientes
532	TRANSFERENCIA_EJECUTADA	2026-02-27 14:52:12.390192	164	SUPERVISOR_EMPRESA	521	Monto: 25139.69, Estado: Ejecutada
533	PRESTAMO_APROBADO	2026-02-27 14:51:12.390192	430	ANALISTA_INTERNO	278	Monto aprobado: 8358999.32, Tasa: 12.5%
534	CUENTA_CREADA	2026-02-27 14:50:12.390192	362	EMPLEADO_VENTANILLA	287	Cuenta creada correctamente
535	TRANSFERENCIA_RECHAZADA	2026-02-27 14:49:12.390192	3	EMPLEADO_EMPRESA	170	Transferencia rechazada por fondos insuficientes
536	TRANSFERENCIA_EJECUTADA	2026-02-27 14:48:12.390192	267	SUPERVISOR_EMPRESA	400	Monto: 89434.74, Estado: Ejecutada
537	PRESTAMO_APROBADO	2026-02-27 14:47:12.390192	515	ANALISTA_INTERNO	670	Monto aprobado: 12573652.24, Tasa: 12.5%
538	CUENTA_CREADA	2026-02-27 14:46:12.390192	253	EMPLEADO_VENTANILLA	60	Cuenta creada correctamente
539	TRANSFERENCIA_RECHAZADA	2026-02-27 14:45:12.390192	587	EMPLEADO_EMPRESA	664	Transferencia rechazada por fondos insuficientes
540	TRANSFERENCIA_EJECUTADA	2026-02-27 14:44:12.390192	203	SUPERVISOR_EMPRESA	421	Monto: 34250.84, Estado: Ejecutada
541	PRESTAMO_APROBADO	2026-02-27 14:43:12.390192	178	ANALISTA_INTERNO	931	Monto aprobado: 5733701.61, Tasa: 12.5%
542	CUENTA_CREADA	2026-02-27 14:42:12.390192	968	EMPLEADO_VENTANILLA	481	Cuenta creada correctamente
543	TRANSFERENCIA_RECHAZADA	2026-02-27 14:41:12.390192	561	EMPLEADO_EMPRESA	373	Transferencia rechazada por fondos insuficientes
544	TRANSFERENCIA_EJECUTADA	2026-02-27 14:40:12.390192	102	SUPERVISOR_EMPRESA	459	Monto: 58077.15, Estado: Ejecutada
545	PRESTAMO_APROBADO	2026-02-27 14:39:12.390192	268	ANALISTA_INTERNO	536	Monto aprobado: 39312653.42, Tasa: 12.5%
546	CUENTA_CREADA	2026-02-27 14:38:12.390192	515	EMPLEADO_VENTANILLA	571	Cuenta creada correctamente
547	TRANSFERENCIA_RECHAZADA	2026-02-27 14:37:12.390192	416	EMPLEADO_EMPRESA	576	Transferencia rechazada por fondos insuficientes
548	TRANSFERENCIA_EJECUTADA	2026-02-27 14:36:12.390192	445	SUPERVISOR_EMPRESA	294	Monto: 33350.88, Estado: Ejecutada
549	PRESTAMO_APROBADO	2026-02-27 14:35:12.390192	934	ANALISTA_INTERNO	629	Monto aprobado: 37900909.37, Tasa: 12.5%
550	CUENTA_CREADA	2026-02-27 14:34:12.390192	441	EMPLEADO_VENTANILLA	418	Cuenta creada correctamente
551	TRANSFERENCIA_RECHAZADA	2026-02-27 14:33:12.390192	237	EMPLEADO_EMPRESA	962	Transferencia rechazada por fondos insuficientes
552	TRANSFERENCIA_EJECUTADA	2026-02-27 14:32:12.390192	557	SUPERVISOR_EMPRESA	629	Monto: 61067.17, Estado: Ejecutada
553	PRESTAMO_APROBADO	2026-02-27 14:31:12.390192	444	ANALISTA_INTERNO	549	Monto aprobado: 22417719.90, Tasa: 12.5%
554	CUENTA_CREADA	2026-02-27 14:30:12.390192	931	EMPLEADO_VENTANILLA	458	Cuenta creada correctamente
555	TRANSFERENCIA_RECHAZADA	2026-02-27 14:29:12.390192	756	EMPLEADO_EMPRESA	598	Transferencia rechazada por fondos insuficientes
556	TRANSFERENCIA_EJECUTADA	2026-02-27 14:28:12.390192	622	SUPERVISOR_EMPRESA	11	Monto: 13373.30, Estado: Ejecutada
557	PRESTAMO_APROBADO	2026-02-27 14:27:12.390192	580	ANALISTA_INTERNO	396	Monto aprobado: 7810738.40, Tasa: 12.5%
558	CUENTA_CREADA	2026-02-27 14:26:12.390192	649	EMPLEADO_VENTANILLA	820	Cuenta creada correctamente
559	TRANSFERENCIA_RECHAZADA	2026-02-27 14:25:12.390192	982	EMPLEADO_EMPRESA	17	Transferencia rechazada por fondos insuficientes
560	TRANSFERENCIA_EJECUTADA	2026-02-27 14:24:12.390192	907	SUPERVISOR_EMPRESA	850	Monto: 14103.99, Estado: Ejecutada
561	PRESTAMO_APROBADO	2026-02-27 14:23:12.390192	82	ANALISTA_INTERNO	300	Monto aprobado: 11557970.43, Tasa: 12.5%
562	CUENTA_CREADA	2026-02-27 14:22:12.390192	500	EMPLEADO_VENTANILLA	492	Cuenta creada correctamente
563	TRANSFERENCIA_RECHAZADA	2026-02-27 14:21:12.390192	420	EMPLEADO_EMPRESA	818	Transferencia rechazada por fondos insuficientes
564	TRANSFERENCIA_EJECUTADA	2026-02-27 14:20:12.390192	13	SUPERVISOR_EMPRESA	602	Monto: 14877.38, Estado: Ejecutada
565	PRESTAMO_APROBADO	2026-02-27 14:19:12.390192	278	ANALISTA_INTERNO	166	Monto aprobado: 48807766.35, Tasa: 12.5%
566	CUENTA_CREADA	2026-02-27 14:18:12.390192	679	EMPLEADO_VENTANILLA	485	Cuenta creada correctamente
567	TRANSFERENCIA_RECHAZADA	2026-02-27 14:17:12.390192	993	EMPLEADO_EMPRESA	285	Transferencia rechazada por fondos insuficientes
568	TRANSFERENCIA_EJECUTADA	2026-02-27 14:16:12.390192	925	SUPERVISOR_EMPRESA	460	Monto: 19121.93, Estado: Ejecutada
569	PRESTAMO_APROBADO	2026-02-27 14:15:12.390192	621	ANALISTA_INTERNO	960	Monto aprobado: 22191867.32, Tasa: 12.5%
570	CUENTA_CREADA	2026-02-27 14:14:12.390192	7	EMPLEADO_VENTANILLA	795	Cuenta creada correctamente
571	TRANSFERENCIA_RECHAZADA	2026-02-27 14:13:12.390192	693	EMPLEADO_EMPRESA	983	Transferencia rechazada por fondos insuficientes
572	TRANSFERENCIA_EJECUTADA	2026-02-27 14:12:12.390192	566	SUPERVISOR_EMPRESA	692	Monto: 51038.41, Estado: Ejecutada
573	PRESTAMO_APROBADO	2026-02-27 14:11:12.390192	362	ANALISTA_INTERNO	142	Monto aprobado: 12386974.41, Tasa: 12.5%
574	CUENTA_CREADA	2026-02-27 14:10:12.390192	968	EMPLEADO_VENTANILLA	105	Cuenta creada correctamente
575	TRANSFERENCIA_RECHAZADA	2026-02-27 14:09:12.390192	946	EMPLEADO_EMPRESA	676	Transferencia rechazada por fondos insuficientes
576	TRANSFERENCIA_EJECUTADA	2026-02-27 14:08:12.390192	477	SUPERVISOR_EMPRESA	909	Monto: 7853.52, Estado: Ejecutada
577	PRESTAMO_APROBADO	2026-02-27 14:07:12.390192	998	ANALISTA_INTERNO	580	Monto aprobado: 32672232.87, Tasa: 12.5%
578	CUENTA_CREADA	2026-02-27 14:06:12.390192	339	EMPLEADO_VENTANILLA	525	Cuenta creada correctamente
579	TRANSFERENCIA_RECHAZADA	2026-02-27 14:05:12.390192	569	EMPLEADO_EMPRESA	755	Transferencia rechazada por fondos insuficientes
580	TRANSFERENCIA_EJECUTADA	2026-02-27 14:04:12.390192	42	SUPERVISOR_EMPRESA	507	Monto: 62291.74, Estado: Ejecutada
581	PRESTAMO_APROBADO	2026-02-27 14:03:12.390192	350	ANALISTA_INTERNO	509	Monto aprobado: 35003832.11, Tasa: 12.5%
582	CUENTA_CREADA	2026-02-27 14:02:12.390192	613	EMPLEADO_VENTANILLA	38	Cuenta creada correctamente
583	TRANSFERENCIA_RECHAZADA	2026-02-27 14:01:12.390192	663	EMPLEADO_EMPRESA	730	Transferencia rechazada por fondos insuficientes
584	TRANSFERENCIA_EJECUTADA	2026-02-27 14:00:12.390192	283	SUPERVISOR_EMPRESA	206	Monto: 70973.99, Estado: Ejecutada
585	PRESTAMO_APROBADO	2026-02-27 13:59:12.390192	824	ANALISTA_INTERNO	90	Monto aprobado: 43904662.26, Tasa: 12.5%
586	CUENTA_CREADA	2026-02-27 13:58:12.390192	141	EMPLEADO_VENTANILLA	260	Cuenta creada correctamente
587	TRANSFERENCIA_RECHAZADA	2026-02-27 13:57:12.390192	331	EMPLEADO_EMPRESA	759	Transferencia rechazada por fondos insuficientes
588	TRANSFERENCIA_EJECUTADA	2026-02-27 13:56:12.390192	268	SUPERVISOR_EMPRESA	92	Monto: 95554.63, Estado: Ejecutada
589	PRESTAMO_APROBADO	2026-02-27 13:55:12.390192	244	ANALISTA_INTERNO	319	Monto aprobado: 914572.26, Tasa: 12.5%
590	CUENTA_CREADA	2026-02-27 13:54:12.390192	615	EMPLEADO_VENTANILLA	301	Cuenta creada correctamente
591	TRANSFERENCIA_RECHAZADA	2026-02-27 13:53:12.390192	292	EMPLEADO_EMPRESA	89	Transferencia rechazada por fondos insuficientes
592	TRANSFERENCIA_EJECUTADA	2026-02-27 13:52:12.390192	163	SUPERVISOR_EMPRESA	234	Monto: 13516.51, Estado: Ejecutada
593	PRESTAMO_APROBADO	2026-02-27 13:51:12.390192	74	ANALISTA_INTERNO	358	Monto aprobado: 30423614.74, Tasa: 12.5%
594	CUENTA_CREADA	2026-02-27 13:50:12.390192	223	EMPLEADO_VENTANILLA	879	Cuenta creada correctamente
595	TRANSFERENCIA_RECHAZADA	2026-02-27 13:49:12.390192	425	EMPLEADO_EMPRESA	633	Transferencia rechazada por fondos insuficientes
596	TRANSFERENCIA_EJECUTADA	2026-02-27 13:48:12.390192	990	SUPERVISOR_EMPRESA	191	Monto: 72082.15, Estado: Ejecutada
597	PRESTAMO_APROBADO	2026-02-27 13:47:12.390192	796	ANALISTA_INTERNO	393	Monto aprobado: 36716368.79, Tasa: 12.5%
598	CUENTA_CREADA	2026-02-27 13:46:12.390192	759	EMPLEADO_VENTANILLA	118	Cuenta creada correctamente
599	TRANSFERENCIA_RECHAZADA	2026-02-27 13:45:12.390192	116	EMPLEADO_EMPRESA	934	Transferencia rechazada por fondos insuficientes
600	TRANSFERENCIA_EJECUTADA	2026-02-27 13:44:12.390192	664	SUPERVISOR_EMPRESA	904	Monto: 80292.04, Estado: Ejecutada
601	PRESTAMO_APROBADO	2026-02-27 13:43:12.390192	500	ANALISTA_INTERNO	668	Monto aprobado: 37746560.14, Tasa: 12.5%
602	CUENTA_CREADA	2026-02-27 13:42:12.390192	875	EMPLEADO_VENTANILLA	837	Cuenta creada correctamente
603	TRANSFERENCIA_RECHAZADA	2026-02-27 13:41:12.390192	22	EMPLEADO_EMPRESA	688	Transferencia rechazada por fondos insuficientes
604	TRANSFERENCIA_EJECUTADA	2026-02-27 13:40:12.390192	65	SUPERVISOR_EMPRESA	134	Monto: 48016.82, Estado: Ejecutada
605	PRESTAMO_APROBADO	2026-02-27 13:39:12.390192	289	ANALISTA_INTERNO	279	Monto aprobado: 16647990.81, Tasa: 12.5%
606	CUENTA_CREADA	2026-02-27 13:38:12.390192	489	EMPLEADO_VENTANILLA	593	Cuenta creada correctamente
607	TRANSFERENCIA_RECHAZADA	2026-02-27 13:37:12.390192	58	EMPLEADO_EMPRESA	614	Transferencia rechazada por fondos insuficientes
608	TRANSFERENCIA_EJECUTADA	2026-02-27 13:36:12.390192	627	SUPERVISOR_EMPRESA	821	Monto: 5149.77, Estado: Ejecutada
609	PRESTAMO_APROBADO	2026-02-27 13:35:12.390192	113	ANALISTA_INTERNO	327	Monto aprobado: 36565718.37, Tasa: 12.5%
610	CUENTA_CREADA	2026-02-27 13:34:12.390192	991	EMPLEADO_VENTANILLA	698	Cuenta creada correctamente
611	TRANSFERENCIA_RECHAZADA	2026-02-27 13:33:12.390192	143	EMPLEADO_EMPRESA	916	Transferencia rechazada por fondos insuficientes
612	TRANSFERENCIA_EJECUTADA	2026-02-27 13:32:12.390192	539	SUPERVISOR_EMPRESA	192	Monto: 22330.58, Estado: Ejecutada
613	PRESTAMO_APROBADO	2026-02-27 13:31:12.390192	588	ANALISTA_INTERNO	810	Monto aprobado: 16176300.83, Tasa: 12.5%
614	CUENTA_CREADA	2026-02-27 13:30:12.390192	416	EMPLEADO_VENTANILLA	626	Cuenta creada correctamente
615	TRANSFERENCIA_RECHAZADA	2026-02-27 13:29:12.390192	59	EMPLEADO_EMPRESA	654	Transferencia rechazada por fondos insuficientes
616	TRANSFERENCIA_EJECUTADA	2026-02-27 13:28:12.390192	489	SUPERVISOR_EMPRESA	133	Monto: 76172.52, Estado: Ejecutada
617	PRESTAMO_APROBADO	2026-02-27 13:27:12.390192	804	ANALISTA_INTERNO	727	Monto aprobado: 34960228.58, Tasa: 12.5%
618	CUENTA_CREADA	2026-02-27 13:26:12.390192	850	EMPLEADO_VENTANILLA	771	Cuenta creada correctamente
619	TRANSFERENCIA_RECHAZADA	2026-02-27 13:25:12.390192	24	EMPLEADO_EMPRESA	969	Transferencia rechazada por fondos insuficientes
620	TRANSFERENCIA_EJECUTADA	2026-02-27 13:24:12.390192	746	SUPERVISOR_EMPRESA	929	Monto: 26855.92, Estado: Ejecutada
621	PRESTAMO_APROBADO	2026-02-27 13:23:12.390192	390	ANALISTA_INTERNO	797	Monto aprobado: 5789115.21, Tasa: 12.5%
622	CUENTA_CREADA	2026-02-27 13:22:12.390192	590	EMPLEADO_VENTANILLA	927	Cuenta creada correctamente
623	TRANSFERENCIA_RECHAZADA	2026-02-27 13:21:12.390192	172	EMPLEADO_EMPRESA	500	Transferencia rechazada por fondos insuficientes
624	TRANSFERENCIA_EJECUTADA	2026-02-27 13:20:12.390192	501	SUPERVISOR_EMPRESA	995	Monto: 93296.87, Estado: Ejecutada
625	PRESTAMO_APROBADO	2026-02-27 13:19:12.390192	493	ANALISTA_INTERNO	118	Monto aprobado: 39167263.83, Tasa: 12.5%
626	CUENTA_CREADA	2026-02-27 13:18:12.390192	253	EMPLEADO_VENTANILLA	991	Cuenta creada correctamente
627	TRANSFERENCIA_RECHAZADA	2026-02-27 13:17:12.390192	320	EMPLEADO_EMPRESA	644	Transferencia rechazada por fondos insuficientes
628	TRANSFERENCIA_EJECUTADA	2026-02-27 13:16:12.390192	617	SUPERVISOR_EMPRESA	678	Monto: 13182.32, Estado: Ejecutada
629	PRESTAMO_APROBADO	2026-02-27 13:15:12.390192	84	ANALISTA_INTERNO	314	Monto aprobado: 23786722.33, Tasa: 12.5%
630	CUENTA_CREADA	2026-02-27 13:14:12.390192	215	EMPLEADO_VENTANILLA	935	Cuenta creada correctamente
631	TRANSFERENCIA_RECHAZADA	2026-02-27 13:13:12.390192	292	EMPLEADO_EMPRESA	824	Transferencia rechazada por fondos insuficientes
632	TRANSFERENCIA_EJECUTADA	2026-02-27 13:12:12.390192	803	SUPERVISOR_EMPRESA	247	Monto: 41360.24, Estado: Ejecutada
633	PRESTAMO_APROBADO	2026-02-27 13:11:12.390192	347	ANALISTA_INTERNO	623	Monto aprobado: 46431386.32, Tasa: 12.5%
634	CUENTA_CREADA	2026-02-27 13:10:12.390192	810	EMPLEADO_VENTANILLA	117	Cuenta creada correctamente
635	TRANSFERENCIA_RECHAZADA	2026-02-27 13:09:12.390192	696	EMPLEADO_EMPRESA	538	Transferencia rechazada por fondos insuficientes
636	TRANSFERENCIA_EJECUTADA	2026-02-27 13:08:12.390192	93	SUPERVISOR_EMPRESA	293	Monto: 81913.13, Estado: Ejecutada
637	PRESTAMO_APROBADO	2026-02-27 13:07:12.390192	511	ANALISTA_INTERNO	345	Monto aprobado: 32179902.73, Tasa: 12.5%
638	CUENTA_CREADA	2026-02-27 13:06:12.390192	136	EMPLEADO_VENTANILLA	160	Cuenta creada correctamente
639	TRANSFERENCIA_RECHAZADA	2026-02-27 13:05:12.390192	156	EMPLEADO_EMPRESA	401	Transferencia rechazada por fondos insuficientes
640	TRANSFERENCIA_EJECUTADA	2026-02-27 13:04:12.390192	524	SUPERVISOR_EMPRESA	65	Monto: 45779.92, Estado: Ejecutada
641	PRESTAMO_APROBADO	2026-02-27 13:03:12.390192	283	ANALISTA_INTERNO	713	Monto aprobado: 10341628.17, Tasa: 12.5%
642	CUENTA_CREADA	2026-02-27 13:02:12.390192	1	EMPLEADO_VENTANILLA	630	Cuenta creada correctamente
643	TRANSFERENCIA_RECHAZADA	2026-02-27 13:01:12.390192	461	EMPLEADO_EMPRESA	59	Transferencia rechazada por fondos insuficientes
644	TRANSFERENCIA_EJECUTADA	2026-02-27 13:00:12.390192	829	SUPERVISOR_EMPRESA	980	Monto: 55601.18, Estado: Ejecutada
645	PRESTAMO_APROBADO	2026-02-27 12:59:12.390192	606	ANALISTA_INTERNO	439	Monto aprobado: 13153346.05, Tasa: 12.5%
646	CUENTA_CREADA	2026-02-27 12:58:12.390192	55	EMPLEADO_VENTANILLA	458	Cuenta creada correctamente
647	TRANSFERENCIA_RECHAZADA	2026-02-27 12:57:12.390192	392	EMPLEADO_EMPRESA	956	Transferencia rechazada por fondos insuficientes
648	TRANSFERENCIA_EJECUTADA	2026-02-27 12:56:12.390192	764	SUPERVISOR_EMPRESA	5	Monto: 37456.91, Estado: Ejecutada
649	PRESTAMO_APROBADO	2026-02-27 12:55:12.390192	722	ANALISTA_INTERNO	510	Monto aprobado: 4296471.57, Tasa: 12.5%
650	CUENTA_CREADA	2026-02-27 12:54:12.390192	697	EMPLEADO_VENTANILLA	609	Cuenta creada correctamente
651	TRANSFERENCIA_RECHAZADA	2026-02-27 12:53:12.390192	53	EMPLEADO_EMPRESA	795	Transferencia rechazada por fondos insuficientes
652	TRANSFERENCIA_EJECUTADA	2026-02-27 12:52:12.390192	59	SUPERVISOR_EMPRESA	944	Monto: 64259.18, Estado: Ejecutada
653	PRESTAMO_APROBADO	2026-02-27 12:51:12.390192	813	ANALISTA_INTERNO	948	Monto aprobado: 37784816.88, Tasa: 12.5%
654	CUENTA_CREADA	2026-02-27 12:50:12.390192	618	EMPLEADO_VENTANILLA	601	Cuenta creada correctamente
655	TRANSFERENCIA_RECHAZADA	2026-02-27 12:49:12.390192	603	EMPLEADO_EMPRESA	348	Transferencia rechazada por fondos insuficientes
656	TRANSFERENCIA_EJECUTADA	2026-02-27 12:48:12.390192	376	SUPERVISOR_EMPRESA	831	Monto: 16250.77, Estado: Ejecutada
657	PRESTAMO_APROBADO	2026-02-27 12:47:12.390192	613	ANALISTA_INTERNO	381	Monto aprobado: 19118277.31, Tasa: 12.5%
658	CUENTA_CREADA	2026-02-27 12:46:12.390192	487	EMPLEADO_VENTANILLA	182	Cuenta creada correctamente
659	TRANSFERENCIA_RECHAZADA	2026-02-27 12:45:12.390192	122	EMPLEADO_EMPRESA	613	Transferencia rechazada por fondos insuficientes
660	TRANSFERENCIA_EJECUTADA	2026-02-27 12:44:12.390192	355	SUPERVISOR_EMPRESA	247	Monto: 60724.93, Estado: Ejecutada
661	PRESTAMO_APROBADO	2026-02-27 12:43:12.390192	969	ANALISTA_INTERNO	630	Monto aprobado: 47031665.03, Tasa: 12.5%
662	CUENTA_CREADA	2026-02-27 12:42:12.390192	202	EMPLEADO_VENTANILLA	361	Cuenta creada correctamente
663	TRANSFERENCIA_RECHAZADA	2026-02-27 12:41:12.390192	200	EMPLEADO_EMPRESA	369	Transferencia rechazada por fondos insuficientes
664	TRANSFERENCIA_EJECUTADA	2026-02-27 12:40:12.390192	559	SUPERVISOR_EMPRESA	613	Monto: 68131.90, Estado: Ejecutada
665	PRESTAMO_APROBADO	2026-02-27 12:39:12.390192	244	ANALISTA_INTERNO	193	Monto aprobado: 1459937.38, Tasa: 12.5%
666	CUENTA_CREADA	2026-02-27 12:38:12.390192	426	EMPLEADO_VENTANILLA	134	Cuenta creada correctamente
667	TRANSFERENCIA_RECHAZADA	2026-02-27 12:37:12.390192	989	EMPLEADO_EMPRESA	558	Transferencia rechazada por fondos insuficientes
668	TRANSFERENCIA_EJECUTADA	2026-02-27 12:36:12.390192	534	SUPERVISOR_EMPRESA	979	Monto: 11798.59, Estado: Ejecutada
669	PRESTAMO_APROBADO	2026-02-27 12:35:12.390192	59	ANALISTA_INTERNO	768	Monto aprobado: 44486189.09, Tasa: 12.5%
670	CUENTA_CREADA	2026-02-27 12:34:12.390192	751	EMPLEADO_VENTANILLA	981	Cuenta creada correctamente
671	TRANSFERENCIA_RECHAZADA	2026-02-27 12:33:12.390192	965	EMPLEADO_EMPRESA	491	Transferencia rechazada por fondos insuficientes
672	TRANSFERENCIA_EJECUTADA	2026-02-27 12:32:12.390192	607	SUPERVISOR_EMPRESA	136	Monto: 39930.23, Estado: Ejecutada
673	PRESTAMO_APROBADO	2026-02-27 12:31:12.390192	355	ANALISTA_INTERNO	492	Monto aprobado: 28950617.45, Tasa: 12.5%
674	CUENTA_CREADA	2026-02-27 12:30:12.390192	982	EMPLEADO_VENTANILLA	67	Cuenta creada correctamente
675	TRANSFERENCIA_RECHAZADA	2026-02-27 12:29:12.390192	445	EMPLEADO_EMPRESA	325	Transferencia rechazada por fondos insuficientes
676	TRANSFERENCIA_EJECUTADA	2026-02-27 12:28:12.390192	630	SUPERVISOR_EMPRESA	368	Monto: 36405.81, Estado: Ejecutada
677	PRESTAMO_APROBADO	2026-02-27 12:27:12.390192	457	ANALISTA_INTERNO	432	Monto aprobado: 7097248.09, Tasa: 12.5%
678	CUENTA_CREADA	2026-02-27 12:26:12.390192	90	EMPLEADO_VENTANILLA	385	Cuenta creada correctamente
679	TRANSFERENCIA_RECHAZADA	2026-02-27 12:25:12.390192	263	EMPLEADO_EMPRESA	267	Transferencia rechazada por fondos insuficientes
680	TRANSFERENCIA_EJECUTADA	2026-02-27 12:24:12.390192	622	SUPERVISOR_EMPRESA	725	Monto: 33560.14, Estado: Ejecutada
681	PRESTAMO_APROBADO	2026-02-27 12:23:12.390192	419	ANALISTA_INTERNO	863	Monto aprobado: 22473110.45, Tasa: 12.5%
682	CUENTA_CREADA	2026-02-27 12:22:12.390192	264	EMPLEADO_VENTANILLA	594	Cuenta creada correctamente
683	TRANSFERENCIA_RECHAZADA	2026-02-27 12:21:12.390192	801	EMPLEADO_EMPRESA	500	Transferencia rechazada por fondos insuficientes
684	TRANSFERENCIA_EJECUTADA	2026-02-27 12:20:12.390192	264	SUPERVISOR_EMPRESA	312	Monto: 39608.55, Estado: Ejecutada
685	PRESTAMO_APROBADO	2026-02-27 12:19:12.390192	948	ANALISTA_INTERNO	846	Monto aprobado: 11542298.46, Tasa: 12.5%
686	CUENTA_CREADA	2026-02-27 12:18:12.390192	231	EMPLEADO_VENTANILLA	718	Cuenta creada correctamente
687	TRANSFERENCIA_RECHAZADA	2026-02-27 12:17:12.390192	113	EMPLEADO_EMPRESA	324	Transferencia rechazada por fondos insuficientes
688	TRANSFERENCIA_EJECUTADA	2026-02-27 12:16:12.390192	270	SUPERVISOR_EMPRESA	712	Monto: 61529.93, Estado: Ejecutada
689	PRESTAMO_APROBADO	2026-02-27 12:15:12.390192	61	ANALISTA_INTERNO	324	Monto aprobado: 41164245.28, Tasa: 12.5%
690	CUENTA_CREADA	2026-02-27 12:14:12.390192	725	EMPLEADO_VENTANILLA	542	Cuenta creada correctamente
691	TRANSFERENCIA_RECHAZADA	2026-02-27 12:13:12.390192	990	EMPLEADO_EMPRESA	413	Transferencia rechazada por fondos insuficientes
692	TRANSFERENCIA_EJECUTADA	2026-02-27 12:12:12.390192	747	SUPERVISOR_EMPRESA	499	Monto: 36834.25, Estado: Ejecutada
693	PRESTAMO_APROBADO	2026-02-27 12:11:12.390192	152	ANALISTA_INTERNO	233	Monto aprobado: 43628362.51, Tasa: 12.5%
694	CUENTA_CREADA	2026-02-27 12:10:12.390192	371	EMPLEADO_VENTANILLA	651	Cuenta creada correctamente
695	TRANSFERENCIA_RECHAZADA	2026-02-27 12:09:12.390192	610	EMPLEADO_EMPRESA	801	Transferencia rechazada por fondos insuficientes
696	TRANSFERENCIA_EJECUTADA	2026-02-27 12:08:12.390192	583	SUPERVISOR_EMPRESA	31	Monto: 83512.67, Estado: Ejecutada
697	PRESTAMO_APROBADO	2026-02-27 12:07:12.390192	669	ANALISTA_INTERNO	670	Monto aprobado: 25703573.53, Tasa: 12.5%
698	CUENTA_CREADA	2026-02-27 12:06:12.390192	297	EMPLEADO_VENTANILLA	238	Cuenta creada correctamente
699	TRANSFERENCIA_RECHAZADA	2026-02-27 12:05:12.390192	779	EMPLEADO_EMPRESA	906	Transferencia rechazada por fondos insuficientes
700	TRANSFERENCIA_EJECUTADA	2026-02-27 12:04:12.390192	563	SUPERVISOR_EMPRESA	426	Monto: 55481.64, Estado: Ejecutada
701	PRESTAMO_APROBADO	2026-02-27 12:03:12.390192	153	ANALISTA_INTERNO	576	Monto aprobado: 45597119.83, Tasa: 12.5%
702	CUENTA_CREADA	2026-02-27 12:02:12.390192	262	EMPLEADO_VENTANILLA	488	Cuenta creada correctamente
703	TRANSFERENCIA_RECHAZADA	2026-02-27 12:01:12.390192	672	EMPLEADO_EMPRESA	929	Transferencia rechazada por fondos insuficientes
704	TRANSFERENCIA_EJECUTADA	2026-02-27 12:00:12.390192	356	SUPERVISOR_EMPRESA	615	Monto: 9536.55, Estado: Ejecutada
705	PRESTAMO_APROBADO	2026-02-27 11:59:12.390192	689	ANALISTA_INTERNO	856	Monto aprobado: 39201778.21, Tasa: 12.5%
706	CUENTA_CREADA	2026-02-27 11:58:12.390192	491	EMPLEADO_VENTANILLA	959	Cuenta creada correctamente
707	TRANSFERENCIA_RECHAZADA	2026-02-27 11:57:12.390192	114	EMPLEADO_EMPRESA	102	Transferencia rechazada por fondos insuficientes
708	TRANSFERENCIA_EJECUTADA	2026-02-27 11:56:12.390192	694	SUPERVISOR_EMPRESA	796	Monto: 52349.06, Estado: Ejecutada
709	PRESTAMO_APROBADO	2026-02-27 11:55:12.390192	565	ANALISTA_INTERNO	278	Monto aprobado: 13227536.32, Tasa: 12.5%
710	CUENTA_CREADA	2026-02-27 11:54:12.390192	945	EMPLEADO_VENTANILLA	749	Cuenta creada correctamente
711	TRANSFERENCIA_RECHAZADA	2026-02-27 11:53:12.390192	948	EMPLEADO_EMPRESA	228	Transferencia rechazada por fondos insuficientes
712	TRANSFERENCIA_EJECUTADA	2026-02-27 11:52:12.390192	137	SUPERVISOR_EMPRESA	18	Monto: 56769.58, Estado: Ejecutada
713	PRESTAMO_APROBADO	2026-02-27 11:51:12.390192	260	ANALISTA_INTERNO	495	Monto aprobado: 42611412.19, Tasa: 12.5%
714	CUENTA_CREADA	2026-02-27 11:50:12.390192	942	EMPLEADO_VENTANILLA	207	Cuenta creada correctamente
715	TRANSFERENCIA_RECHAZADA	2026-02-27 11:49:12.390192	240	EMPLEADO_EMPRESA	152	Transferencia rechazada por fondos insuficientes
716	TRANSFERENCIA_EJECUTADA	2026-02-27 11:48:12.390192	739	SUPERVISOR_EMPRESA	158	Monto: 94469.80, Estado: Ejecutada
717	PRESTAMO_APROBADO	2026-02-27 11:47:12.390192	427	ANALISTA_INTERNO	353	Monto aprobado: 7984922.11, Tasa: 12.5%
718	CUENTA_CREADA	2026-02-27 11:46:12.390192	724	EMPLEADO_VENTANILLA	348	Cuenta creada correctamente
719	TRANSFERENCIA_RECHAZADA	2026-02-27 11:45:12.390192	39	EMPLEADO_EMPRESA	265	Transferencia rechazada por fondos insuficientes
720	TRANSFERENCIA_EJECUTADA	2026-02-27 11:44:12.390192	406	SUPERVISOR_EMPRESA	441	Monto: 99297.11, Estado: Ejecutada
721	PRESTAMO_APROBADO	2026-02-27 11:43:12.390192	446	ANALISTA_INTERNO	237	Monto aprobado: 36854455.56, Tasa: 12.5%
722	CUENTA_CREADA	2026-02-27 11:42:12.390192	896	EMPLEADO_VENTANILLA	75	Cuenta creada correctamente
723	TRANSFERENCIA_RECHAZADA	2026-02-27 11:41:12.390192	804	EMPLEADO_EMPRESA	960	Transferencia rechazada por fondos insuficientes
724	TRANSFERENCIA_EJECUTADA	2026-02-27 11:40:12.390192	815	SUPERVISOR_EMPRESA	467	Monto: 55553.54, Estado: Ejecutada
725	PRESTAMO_APROBADO	2026-02-27 11:39:12.390192	100	ANALISTA_INTERNO	711	Monto aprobado: 32348417.96, Tasa: 12.5%
726	CUENTA_CREADA	2026-02-27 11:38:12.390192	136	EMPLEADO_VENTANILLA	392	Cuenta creada correctamente
727	TRANSFERENCIA_RECHAZADA	2026-02-27 11:37:12.390192	661	EMPLEADO_EMPRESA	130	Transferencia rechazada por fondos insuficientes
728	TRANSFERENCIA_EJECUTADA	2026-02-27 11:36:12.390192	545	SUPERVISOR_EMPRESA	326	Monto: 2532.36, Estado: Ejecutada
729	PRESTAMO_APROBADO	2026-02-27 11:35:12.390192	112	ANALISTA_INTERNO	791	Monto aprobado: 29815300.04, Tasa: 12.5%
730	CUENTA_CREADA	2026-02-27 11:34:12.390192	830	EMPLEADO_VENTANILLA	636	Cuenta creada correctamente
731	TRANSFERENCIA_RECHAZADA	2026-02-27 11:33:12.390192	862	EMPLEADO_EMPRESA	334	Transferencia rechazada por fondos insuficientes
732	TRANSFERENCIA_EJECUTADA	2026-02-27 11:32:12.390192	222	SUPERVISOR_EMPRESA	308	Monto: 12448.22, Estado: Ejecutada
733	PRESTAMO_APROBADO	2026-02-27 11:31:12.390192	297	ANALISTA_INTERNO	280	Monto aprobado: 38494061.52, Tasa: 12.5%
734	CUENTA_CREADA	2026-02-27 11:30:12.390192	807	EMPLEADO_VENTANILLA	595	Cuenta creada correctamente
735	TRANSFERENCIA_RECHAZADA	2026-02-27 11:29:12.390192	13	EMPLEADO_EMPRESA	747	Transferencia rechazada por fondos insuficientes
736	TRANSFERENCIA_EJECUTADA	2026-02-27 11:28:12.390192	610	SUPERVISOR_EMPRESA	572	Monto: 54035.85, Estado: Ejecutada
737	PRESTAMO_APROBADO	2026-02-27 11:27:12.390192	203	ANALISTA_INTERNO	775	Monto aprobado: 46657855.59, Tasa: 12.5%
738	CUENTA_CREADA	2026-02-27 11:26:12.390192	449	EMPLEADO_VENTANILLA	985	Cuenta creada correctamente
739	TRANSFERENCIA_RECHAZADA	2026-02-27 11:25:12.390192	572	EMPLEADO_EMPRESA	273	Transferencia rechazada por fondos insuficientes
740	TRANSFERENCIA_EJECUTADA	2026-02-27 11:24:12.390192	678	SUPERVISOR_EMPRESA	76	Monto: 13341.61, Estado: Ejecutada
741	PRESTAMO_APROBADO	2026-02-27 11:23:12.390192	880	ANALISTA_INTERNO	653	Monto aprobado: 20964880.10, Tasa: 12.5%
742	CUENTA_CREADA	2026-02-27 11:22:12.390192	45	EMPLEADO_VENTANILLA	987	Cuenta creada correctamente
743	TRANSFERENCIA_RECHAZADA	2026-02-27 11:21:12.390192	386	EMPLEADO_EMPRESA	160	Transferencia rechazada por fondos insuficientes
744	TRANSFERENCIA_EJECUTADA	2026-02-27 11:20:12.390192	92	SUPERVISOR_EMPRESA	136	Monto: 2128.00, Estado: Ejecutada
745	PRESTAMO_APROBADO	2026-02-27 11:19:12.390192	210	ANALISTA_INTERNO	526	Monto aprobado: 13403043.67, Tasa: 12.5%
746	CUENTA_CREADA	2026-02-27 11:18:12.390192	412	EMPLEADO_VENTANILLA	923	Cuenta creada correctamente
747	TRANSFERENCIA_RECHAZADA	2026-02-27 11:17:12.390192	755	EMPLEADO_EMPRESA	184	Transferencia rechazada por fondos insuficientes
748	TRANSFERENCIA_EJECUTADA	2026-02-27 11:16:12.390192	716	SUPERVISOR_EMPRESA	86	Monto: 82386.21, Estado: Ejecutada
749	PRESTAMO_APROBADO	2026-02-27 11:15:12.390192	203	ANALISTA_INTERNO	679	Monto aprobado: 12527410.22, Tasa: 12.5%
750	CUENTA_CREADA	2026-02-27 11:14:12.390192	48	EMPLEADO_VENTANILLA	374	Cuenta creada correctamente
751	TRANSFERENCIA_RECHAZADA	2026-02-27 11:13:12.390192	437	EMPLEADO_EMPRESA	739	Transferencia rechazada por fondos insuficientes
752	TRANSFERENCIA_EJECUTADA	2026-02-27 11:12:12.390192	551	SUPERVISOR_EMPRESA	373	Monto: 65937.40, Estado: Ejecutada
753	PRESTAMO_APROBADO	2026-02-27 11:11:12.390192	519	ANALISTA_INTERNO	565	Monto aprobado: 16456042.90, Tasa: 12.5%
754	CUENTA_CREADA	2026-02-27 11:10:12.390192	629	EMPLEADO_VENTANILLA	146	Cuenta creada correctamente
755	TRANSFERENCIA_RECHAZADA	2026-02-27 11:09:12.390192	617	EMPLEADO_EMPRESA	502	Transferencia rechazada por fondos insuficientes
756	TRANSFERENCIA_EJECUTADA	2026-02-27 11:08:12.390192	208	SUPERVISOR_EMPRESA	498	Monto: 33639.33, Estado: Ejecutada
757	PRESTAMO_APROBADO	2026-02-27 11:07:12.390192	388	ANALISTA_INTERNO	320	Monto aprobado: 22314522.23, Tasa: 12.5%
758	CUENTA_CREADA	2026-02-27 11:06:12.390192	224	EMPLEADO_VENTANILLA	636	Cuenta creada correctamente
759	TRANSFERENCIA_RECHAZADA	2026-02-27 11:05:12.390192	926	EMPLEADO_EMPRESA	628	Transferencia rechazada por fondos insuficientes
760	TRANSFERENCIA_EJECUTADA	2026-02-27 11:04:12.390192	701	SUPERVISOR_EMPRESA	722	Monto: 21892.90, Estado: Ejecutada
761	PRESTAMO_APROBADO	2026-02-27 11:03:12.390192	607	ANALISTA_INTERNO	264	Monto aprobado: 43170798.11, Tasa: 12.5%
762	CUENTA_CREADA	2026-02-27 11:02:12.390192	870	EMPLEADO_VENTANILLA	416	Cuenta creada correctamente
763	TRANSFERENCIA_RECHAZADA	2026-02-27 11:01:12.390192	913	EMPLEADO_EMPRESA	827	Transferencia rechazada por fondos insuficientes
764	TRANSFERENCIA_EJECUTADA	2026-02-27 11:00:12.390192	677	SUPERVISOR_EMPRESA	486	Monto: 95000.37, Estado: Ejecutada
765	PRESTAMO_APROBADO	2026-02-27 10:59:12.390192	836	ANALISTA_INTERNO	79	Monto aprobado: 41589555.85, Tasa: 12.5%
766	CUENTA_CREADA	2026-02-27 10:58:12.390192	197	EMPLEADO_VENTANILLA	156	Cuenta creada correctamente
767	TRANSFERENCIA_RECHAZADA	2026-02-27 10:57:12.390192	888	EMPLEADO_EMPRESA	143	Transferencia rechazada por fondos insuficientes
768	TRANSFERENCIA_EJECUTADA	2026-02-27 10:56:12.390192	855	SUPERVISOR_EMPRESA	556	Monto: 78613.51, Estado: Ejecutada
769	PRESTAMO_APROBADO	2026-02-27 10:55:12.390192	62	ANALISTA_INTERNO	231	Monto aprobado: 1429975.32, Tasa: 12.5%
770	CUENTA_CREADA	2026-02-27 10:54:12.390192	381	EMPLEADO_VENTANILLA	397	Cuenta creada correctamente
771	TRANSFERENCIA_RECHAZADA	2026-02-27 10:53:12.390192	287	EMPLEADO_EMPRESA	60	Transferencia rechazada por fondos insuficientes
772	TRANSFERENCIA_EJECUTADA	2026-02-27 10:52:12.390192	572	SUPERVISOR_EMPRESA	484	Monto: 3845.70, Estado: Ejecutada
773	PRESTAMO_APROBADO	2026-02-27 10:51:12.390192	800	ANALISTA_INTERNO	325	Monto aprobado: 10308373.45, Tasa: 12.5%
774	CUENTA_CREADA	2026-02-27 10:50:12.390192	719	EMPLEADO_VENTANILLA	630	Cuenta creada correctamente
775	TRANSFERENCIA_RECHAZADA	2026-02-27 10:49:12.390192	227	EMPLEADO_EMPRESA	71	Transferencia rechazada por fondos insuficientes
776	TRANSFERENCIA_EJECUTADA	2026-02-27 10:48:12.390192	364	SUPERVISOR_EMPRESA	298	Monto: 97633.14, Estado: Ejecutada
777	PRESTAMO_APROBADO	2026-02-27 10:47:12.390192	631	ANALISTA_INTERNO	717	Monto aprobado: 24053633.16, Tasa: 12.5%
778	CUENTA_CREADA	2026-02-27 10:46:12.390192	908	EMPLEADO_VENTANILLA	570	Cuenta creada correctamente
779	TRANSFERENCIA_RECHAZADA	2026-02-27 10:45:12.390192	289	EMPLEADO_EMPRESA	818	Transferencia rechazada por fondos insuficientes
780	TRANSFERENCIA_EJECUTADA	2026-02-27 10:44:12.390192	496	SUPERVISOR_EMPRESA	600	Monto: 75455.05, Estado: Ejecutada
781	PRESTAMO_APROBADO	2026-02-27 10:43:12.390192	573	ANALISTA_INTERNO	526	Monto aprobado: 48074257.47, Tasa: 12.5%
782	CUENTA_CREADA	2026-02-27 10:42:12.390192	337	EMPLEADO_VENTANILLA	229	Cuenta creada correctamente
783	TRANSFERENCIA_RECHAZADA	2026-02-27 10:41:12.390192	611	EMPLEADO_EMPRESA	345	Transferencia rechazada por fondos insuficientes
784	TRANSFERENCIA_EJECUTADA	2026-02-27 10:40:12.390192	958	SUPERVISOR_EMPRESA	215	Monto: 59882.13, Estado: Ejecutada
785	PRESTAMO_APROBADO	2026-02-27 10:39:12.390192	245	ANALISTA_INTERNO	60	Monto aprobado: 24447693.29, Tasa: 12.5%
786	CUENTA_CREADA	2026-02-27 10:38:12.390192	659	EMPLEADO_VENTANILLA	785	Cuenta creada correctamente
787	TRANSFERENCIA_RECHAZADA	2026-02-27 10:37:12.390192	809	EMPLEADO_EMPRESA	623	Transferencia rechazada por fondos insuficientes
788	TRANSFERENCIA_EJECUTADA	2026-02-27 10:36:12.390192	160	SUPERVISOR_EMPRESA	261	Monto: 91463.36, Estado: Ejecutada
789	PRESTAMO_APROBADO	2026-02-27 10:35:12.390192	137	ANALISTA_INTERNO	52	Monto aprobado: 48296182.04, Tasa: 12.5%
790	CUENTA_CREADA	2026-02-27 10:34:12.390192	865	EMPLEADO_VENTANILLA	786	Cuenta creada correctamente
791	TRANSFERENCIA_RECHAZADA	2026-02-27 10:33:12.390192	448	EMPLEADO_EMPRESA	1	Transferencia rechazada por fondos insuficientes
792	TRANSFERENCIA_EJECUTADA	2026-02-27 10:32:12.390192	314	SUPERVISOR_EMPRESA	193	Monto: 5001.45, Estado: Ejecutada
793	PRESTAMO_APROBADO	2026-02-27 10:31:12.390192	522	ANALISTA_INTERNO	398	Monto aprobado: 17632320.75, Tasa: 12.5%
794	CUENTA_CREADA	2026-02-27 10:30:12.390192	910	EMPLEADO_VENTANILLA	986	Cuenta creada correctamente
795	TRANSFERENCIA_RECHAZADA	2026-02-27 10:29:12.390192	461	EMPLEADO_EMPRESA	591	Transferencia rechazada por fondos insuficientes
796	TRANSFERENCIA_EJECUTADA	2026-02-27 10:28:12.390192	628	SUPERVISOR_EMPRESA	162	Monto: 95758.17, Estado: Ejecutada
797	PRESTAMO_APROBADO	2026-02-27 10:27:12.390192	83	ANALISTA_INTERNO	829	Monto aprobado: 33933644.35, Tasa: 12.5%
798	CUENTA_CREADA	2026-02-27 10:26:12.390192	998	EMPLEADO_VENTANILLA	569	Cuenta creada correctamente
799	TRANSFERENCIA_RECHAZADA	2026-02-27 10:25:12.390192	603	EMPLEADO_EMPRESA	409	Transferencia rechazada por fondos insuficientes
800	TRANSFERENCIA_EJECUTADA	2026-02-27 10:24:12.390192	2	SUPERVISOR_EMPRESA	952	Monto: 46714.75, Estado: Ejecutada
801	PRESTAMO_APROBADO	2026-02-27 10:23:12.390192	563	ANALISTA_INTERNO	297	Monto aprobado: 3150869.94, Tasa: 12.5%
802	CUENTA_CREADA	2026-02-27 10:22:12.390192	168	EMPLEADO_VENTANILLA	366	Cuenta creada correctamente
803	TRANSFERENCIA_RECHAZADA	2026-02-27 10:21:12.390192	46	EMPLEADO_EMPRESA	602	Transferencia rechazada por fondos insuficientes
804	TRANSFERENCIA_EJECUTADA	2026-02-27 10:20:12.390192	847	SUPERVISOR_EMPRESA	174	Monto: 98574.68, Estado: Ejecutada
805	PRESTAMO_APROBADO	2026-02-27 10:19:12.390192	181	ANALISTA_INTERNO	377	Monto aprobado: 45683798.94, Tasa: 12.5%
806	CUENTA_CREADA	2026-02-27 10:18:12.390192	416	EMPLEADO_VENTANILLA	771	Cuenta creada correctamente
807	TRANSFERENCIA_RECHAZADA	2026-02-27 10:17:12.390192	474	EMPLEADO_EMPRESA	289	Transferencia rechazada por fondos insuficientes
808	TRANSFERENCIA_EJECUTADA	2026-02-27 10:16:12.390192	653	SUPERVISOR_EMPRESA	524	Monto: 95653.57, Estado: Ejecutada
809	PRESTAMO_APROBADO	2026-02-27 10:15:12.390192	200	ANALISTA_INTERNO	751	Monto aprobado: 45591290.29, Tasa: 12.5%
810	CUENTA_CREADA	2026-02-27 10:14:12.390192	940	EMPLEADO_VENTANILLA	764	Cuenta creada correctamente
811	TRANSFERENCIA_RECHAZADA	2026-02-27 10:13:12.390192	247	EMPLEADO_EMPRESA	617	Transferencia rechazada por fondos insuficientes
812	TRANSFERENCIA_EJECUTADA	2026-02-27 10:12:12.390192	582	SUPERVISOR_EMPRESA	641	Monto: 86475.48, Estado: Ejecutada
813	PRESTAMO_APROBADO	2026-02-27 10:11:12.390192	58	ANALISTA_INTERNO	643	Monto aprobado: 22314013.06, Tasa: 12.5%
814	CUENTA_CREADA	2026-02-27 10:10:12.390192	694	EMPLEADO_VENTANILLA	845	Cuenta creada correctamente
815	TRANSFERENCIA_RECHAZADA	2026-02-27 10:09:12.390192	436	EMPLEADO_EMPRESA	629	Transferencia rechazada por fondos insuficientes
816	TRANSFERENCIA_EJECUTADA	2026-02-27 10:08:12.390192	310	SUPERVISOR_EMPRESA	542	Monto: 39442.32, Estado: Ejecutada
817	PRESTAMO_APROBADO	2026-02-27 10:07:12.390192	165	ANALISTA_INTERNO	854	Monto aprobado: 46008955.44, Tasa: 12.5%
818	CUENTA_CREADA	2026-02-27 10:06:12.390192	834	EMPLEADO_VENTANILLA	535	Cuenta creada correctamente
819	TRANSFERENCIA_RECHAZADA	2026-02-27 10:05:12.390192	269	EMPLEADO_EMPRESA	707	Transferencia rechazada por fondos insuficientes
820	TRANSFERENCIA_EJECUTADA	2026-02-27 10:04:12.390192	811	SUPERVISOR_EMPRESA	143	Monto: 97987.26, Estado: Ejecutada
821	PRESTAMO_APROBADO	2026-02-27 10:03:12.390192	894	ANALISTA_INTERNO	288	Monto aprobado: 36639592.39, Tasa: 12.5%
822	CUENTA_CREADA	2026-02-27 10:02:12.390192	95	EMPLEADO_VENTANILLA	169	Cuenta creada correctamente
823	TRANSFERENCIA_RECHAZADA	2026-02-27 10:01:12.390192	175	EMPLEADO_EMPRESA	202	Transferencia rechazada por fondos insuficientes
824	TRANSFERENCIA_EJECUTADA	2026-02-27 10:00:12.390192	305	SUPERVISOR_EMPRESA	245	Monto: 76912.33, Estado: Ejecutada
825	PRESTAMO_APROBADO	2026-02-27 09:59:12.390192	991	ANALISTA_INTERNO	374	Monto aprobado: 30854049.27, Tasa: 12.5%
826	CUENTA_CREADA	2026-02-27 09:58:12.390192	638	EMPLEADO_VENTANILLA	194	Cuenta creada correctamente
827	TRANSFERENCIA_RECHAZADA	2026-02-27 09:57:12.390192	223	EMPLEADO_EMPRESA	362	Transferencia rechazada por fondos insuficientes
828	TRANSFERENCIA_EJECUTADA	2026-02-27 09:56:12.390192	550	SUPERVISOR_EMPRESA	146	Monto: 17752.67, Estado: Ejecutada
829	PRESTAMO_APROBADO	2026-02-27 09:55:12.390192	487	ANALISTA_INTERNO	452	Monto aprobado: 28420425.21, Tasa: 12.5%
830	CUENTA_CREADA	2026-02-27 09:54:12.390192	60	EMPLEADO_VENTANILLA	431	Cuenta creada correctamente
831	TRANSFERENCIA_RECHAZADA	2026-02-27 09:53:12.390192	70	EMPLEADO_EMPRESA	198	Transferencia rechazada por fondos insuficientes
832	TRANSFERENCIA_EJECUTADA	2026-02-27 09:52:12.390192	381	SUPERVISOR_EMPRESA	677	Monto: 55990.28, Estado: Ejecutada
833	PRESTAMO_APROBADO	2026-02-27 09:51:12.390192	372	ANALISTA_INTERNO	849	Monto aprobado: 8932957.39, Tasa: 12.5%
834	CUENTA_CREADA	2026-02-27 09:50:12.390192	149	EMPLEADO_VENTANILLA	458	Cuenta creada correctamente
835	TRANSFERENCIA_RECHAZADA	2026-02-27 09:49:12.390192	199	EMPLEADO_EMPRESA	794	Transferencia rechazada por fondos insuficientes
836	TRANSFERENCIA_EJECUTADA	2026-02-27 09:48:12.390192	542	SUPERVISOR_EMPRESA	895	Monto: 43062.91, Estado: Ejecutada
837	PRESTAMO_APROBADO	2026-02-27 09:47:12.390192	713	ANALISTA_INTERNO	13	Monto aprobado: 46738240.23, Tasa: 12.5%
838	CUENTA_CREADA	2026-02-27 09:46:12.390192	983	EMPLEADO_VENTANILLA	899	Cuenta creada correctamente
839	TRANSFERENCIA_RECHAZADA	2026-02-27 09:45:12.390192	787	EMPLEADO_EMPRESA	158	Transferencia rechazada por fondos insuficientes
840	TRANSFERENCIA_EJECUTADA	2026-02-27 09:44:12.390192	901	SUPERVISOR_EMPRESA	873	Monto: 47769.35, Estado: Ejecutada
841	PRESTAMO_APROBADO	2026-02-27 09:43:12.390192	515	ANALISTA_INTERNO	358	Monto aprobado: 12113048.85, Tasa: 12.5%
842	CUENTA_CREADA	2026-02-27 09:42:12.390192	293	EMPLEADO_VENTANILLA	271	Cuenta creada correctamente
843	TRANSFERENCIA_RECHAZADA	2026-02-27 09:41:12.390192	520	EMPLEADO_EMPRESA	371	Transferencia rechazada por fondos insuficientes
844	TRANSFERENCIA_EJECUTADA	2026-02-27 09:40:12.390192	622	SUPERVISOR_EMPRESA	82	Monto: 40467.05, Estado: Ejecutada
845	PRESTAMO_APROBADO	2026-02-27 09:39:12.390192	668	ANALISTA_INTERNO	615	Monto aprobado: 41243350.99, Tasa: 12.5%
846	CUENTA_CREADA	2026-02-27 09:38:12.390192	274	EMPLEADO_VENTANILLA	320	Cuenta creada correctamente
847	TRANSFERENCIA_RECHAZADA	2026-02-27 09:37:12.390192	832	EMPLEADO_EMPRESA	482	Transferencia rechazada por fondos insuficientes
848	TRANSFERENCIA_EJECUTADA	2026-02-27 09:36:12.390192	289	SUPERVISOR_EMPRESA	420	Monto: 99399.11, Estado: Ejecutada
849	PRESTAMO_APROBADO	2026-02-27 09:35:12.390192	959	ANALISTA_INTERNO	168	Monto aprobado: 13233310.59, Tasa: 12.5%
850	CUENTA_CREADA	2026-02-27 09:34:12.390192	921	EMPLEADO_VENTANILLA	772	Cuenta creada correctamente
851	TRANSFERENCIA_RECHAZADA	2026-02-27 09:33:12.390192	133	EMPLEADO_EMPRESA	639	Transferencia rechazada por fondos insuficientes
852	TRANSFERENCIA_EJECUTADA	2026-02-27 09:32:12.390192	652	SUPERVISOR_EMPRESA	457	Monto: 69792.82, Estado: Ejecutada
853	PRESTAMO_APROBADO	2026-02-27 09:31:12.390192	93	ANALISTA_INTERNO	256	Monto aprobado: 10537149.46, Tasa: 12.5%
854	CUENTA_CREADA	2026-02-27 09:30:12.390192	143	EMPLEADO_VENTANILLA	328	Cuenta creada correctamente
855	TRANSFERENCIA_RECHAZADA	2026-02-27 09:29:12.390192	935	EMPLEADO_EMPRESA	48	Transferencia rechazada por fondos insuficientes
856	TRANSFERENCIA_EJECUTADA	2026-02-27 09:28:12.390192	528	SUPERVISOR_EMPRESA	194	Monto: 86919.68, Estado: Ejecutada
857	PRESTAMO_APROBADO	2026-02-27 09:27:12.390192	384	ANALISTA_INTERNO	184	Monto aprobado: 48530438.31, Tasa: 12.5%
858	CUENTA_CREADA	2026-02-27 09:26:12.390192	463	EMPLEADO_VENTANILLA	854	Cuenta creada correctamente
859	TRANSFERENCIA_RECHAZADA	2026-02-27 09:25:12.390192	209	EMPLEADO_EMPRESA	784	Transferencia rechazada por fondos insuficientes
860	TRANSFERENCIA_EJECUTADA	2026-02-27 09:24:12.390192	910	SUPERVISOR_EMPRESA	11	Monto: 49684.55, Estado: Ejecutada
861	PRESTAMO_APROBADO	2026-02-27 09:23:12.390192	378	ANALISTA_INTERNO	935	Monto aprobado: 30053883.02, Tasa: 12.5%
862	CUENTA_CREADA	2026-02-27 09:22:12.390192	694	EMPLEADO_VENTANILLA	276	Cuenta creada correctamente
863	TRANSFERENCIA_RECHAZADA	2026-02-27 09:21:12.390192	335	EMPLEADO_EMPRESA	7	Transferencia rechazada por fondos insuficientes
864	TRANSFERENCIA_EJECUTADA	2026-02-27 09:20:12.390192	642	SUPERVISOR_EMPRESA	551	Monto: 89077.11, Estado: Ejecutada
865	PRESTAMO_APROBADO	2026-02-27 09:19:12.390192	375	ANALISTA_INTERNO	455	Monto aprobado: 11840496.58, Tasa: 12.5%
866	CUENTA_CREADA	2026-02-27 09:18:12.390192	249	EMPLEADO_VENTANILLA	637	Cuenta creada correctamente
867	TRANSFERENCIA_RECHAZADA	2026-02-27 09:17:12.390192	919	EMPLEADO_EMPRESA	751	Transferencia rechazada por fondos insuficientes
868	TRANSFERENCIA_EJECUTADA	2026-02-27 09:16:12.390192	757	SUPERVISOR_EMPRESA	705	Monto: 12332.11, Estado: Ejecutada
869	PRESTAMO_APROBADO	2026-02-27 09:15:12.390192	804	ANALISTA_INTERNO	333	Monto aprobado: 4331958.05, Tasa: 12.5%
870	CUENTA_CREADA	2026-02-27 09:14:12.390192	412	EMPLEADO_VENTANILLA	528	Cuenta creada correctamente
871	TRANSFERENCIA_RECHAZADA	2026-02-27 09:13:12.390192	88	EMPLEADO_EMPRESA	607	Transferencia rechazada por fondos insuficientes
872	TRANSFERENCIA_EJECUTADA	2026-02-27 09:12:12.390192	586	SUPERVISOR_EMPRESA	707	Monto: 27905.99, Estado: Ejecutada
873	PRESTAMO_APROBADO	2026-02-27 09:11:12.390192	317	ANALISTA_INTERNO	220	Monto aprobado: 26464581.63, Tasa: 12.5%
874	CUENTA_CREADA	2026-02-27 09:10:12.390192	226	EMPLEADO_VENTANILLA	699	Cuenta creada correctamente
875	TRANSFERENCIA_RECHAZADA	2026-02-27 09:09:12.390192	418	EMPLEADO_EMPRESA	919	Transferencia rechazada por fondos insuficientes
876	TRANSFERENCIA_EJECUTADA	2026-02-27 09:08:12.390192	326	SUPERVISOR_EMPRESA	620	Monto: 18995.37, Estado: Ejecutada
877	PRESTAMO_APROBADO	2026-02-27 09:07:12.390192	753	ANALISTA_INTERNO	290	Monto aprobado: 46613246.35, Tasa: 12.5%
878	CUENTA_CREADA	2026-02-27 09:06:12.390192	775	EMPLEADO_VENTANILLA	348	Cuenta creada correctamente
879	TRANSFERENCIA_RECHAZADA	2026-02-27 09:05:12.390192	893	EMPLEADO_EMPRESA	391	Transferencia rechazada por fondos insuficientes
880	TRANSFERENCIA_EJECUTADA	2026-02-27 09:04:12.390192	817	SUPERVISOR_EMPRESA	507	Monto: 69350.92, Estado: Ejecutada
881	PRESTAMO_APROBADO	2026-02-27 09:03:12.390192	102	ANALISTA_INTERNO	330	Monto aprobado: 28390152.10, Tasa: 12.5%
882	CUENTA_CREADA	2026-02-27 09:02:12.390192	753	EMPLEADO_VENTANILLA	81	Cuenta creada correctamente
883	TRANSFERENCIA_RECHAZADA	2026-02-27 09:01:12.390192	335	EMPLEADO_EMPRESA	260	Transferencia rechazada por fondos insuficientes
884	TRANSFERENCIA_EJECUTADA	2026-02-27 09:00:12.390192	942	SUPERVISOR_EMPRESA	358	Monto: 99666.45, Estado: Ejecutada
885	PRESTAMO_APROBADO	2026-02-27 08:59:12.390192	434	ANALISTA_INTERNO	710	Monto aprobado: 34464627.46, Tasa: 12.5%
886	CUENTA_CREADA	2026-02-27 08:58:12.390192	725	EMPLEADO_VENTANILLA	585	Cuenta creada correctamente
887	TRANSFERENCIA_RECHAZADA	2026-02-27 08:57:12.390192	812	EMPLEADO_EMPRESA	239	Transferencia rechazada por fondos insuficientes
888	TRANSFERENCIA_EJECUTADA	2026-02-27 08:56:12.390192	637	SUPERVISOR_EMPRESA	55	Monto: 48870.50, Estado: Ejecutada
889	PRESTAMO_APROBADO	2026-02-27 08:55:12.390192	641	ANALISTA_INTERNO	864	Monto aprobado: 37220510.89, Tasa: 12.5%
890	CUENTA_CREADA	2026-02-27 08:54:12.390192	635	EMPLEADO_VENTANILLA	538	Cuenta creada correctamente
891	TRANSFERENCIA_RECHAZADA	2026-02-27 08:53:12.390192	783	EMPLEADO_EMPRESA	552	Transferencia rechazada por fondos insuficientes
892	TRANSFERENCIA_EJECUTADA	2026-02-27 08:52:12.390192	338	SUPERVISOR_EMPRESA	134	Monto: 32437.86, Estado: Ejecutada
893	PRESTAMO_APROBADO	2026-02-27 08:51:12.390192	522	ANALISTA_INTERNO	282	Monto aprobado: 41642324.02, Tasa: 12.5%
894	CUENTA_CREADA	2026-02-27 08:50:12.390192	843	EMPLEADO_VENTANILLA	615	Cuenta creada correctamente
895	TRANSFERENCIA_RECHAZADA	2026-02-27 08:49:12.390192	441	EMPLEADO_EMPRESA	657	Transferencia rechazada por fondos insuficientes
896	TRANSFERENCIA_EJECUTADA	2026-02-27 08:48:12.390192	573	SUPERVISOR_EMPRESA	860	Monto: 78921.36, Estado: Ejecutada
897	PRESTAMO_APROBADO	2026-02-27 08:47:12.390192	811	ANALISTA_INTERNO	896	Monto aprobado: 32688167.24, Tasa: 12.5%
898	CUENTA_CREADA	2026-02-27 08:46:12.390192	195	EMPLEADO_VENTANILLA	34	Cuenta creada correctamente
899	TRANSFERENCIA_RECHAZADA	2026-02-27 08:45:12.390192	674	EMPLEADO_EMPRESA	32	Transferencia rechazada por fondos insuficientes
900	TRANSFERENCIA_EJECUTADA	2026-02-27 08:44:12.390192	938	SUPERVISOR_EMPRESA	718	Monto: 32988.30, Estado: Ejecutada
901	PRESTAMO_APROBADO	2026-02-27 08:43:12.390192	115	ANALISTA_INTERNO	387	Monto aprobado: 18876580.43, Tasa: 12.5%
902	CUENTA_CREADA	2026-02-27 08:42:12.390192	16	EMPLEADO_VENTANILLA	89	Cuenta creada correctamente
903	TRANSFERENCIA_RECHAZADA	2026-02-27 08:41:12.390192	544	EMPLEADO_EMPRESA	176	Transferencia rechazada por fondos insuficientes
904	TRANSFERENCIA_EJECUTADA	2026-02-27 08:40:12.390192	697	SUPERVISOR_EMPRESA	823	Monto: 95471.09, Estado: Ejecutada
905	PRESTAMO_APROBADO	2026-02-27 08:39:12.390192	573	ANALISTA_INTERNO	729	Monto aprobado: 5273229.41, Tasa: 12.5%
906	CUENTA_CREADA	2026-02-27 08:38:12.390192	800	EMPLEADO_VENTANILLA	984	Cuenta creada correctamente
907	TRANSFERENCIA_RECHAZADA	2026-02-27 08:37:12.390192	942	EMPLEADO_EMPRESA	441	Transferencia rechazada por fondos insuficientes
908	TRANSFERENCIA_EJECUTADA	2026-02-27 08:36:12.390192	611	SUPERVISOR_EMPRESA	202	Monto: 23592.81, Estado: Ejecutada
909	PRESTAMO_APROBADO	2026-02-27 08:35:12.390192	189	ANALISTA_INTERNO	638	Monto aprobado: 21504487.09, Tasa: 12.5%
910	CUENTA_CREADA	2026-02-27 08:34:12.390192	398	EMPLEADO_VENTANILLA	98	Cuenta creada correctamente
911	TRANSFERENCIA_RECHAZADA	2026-02-27 08:33:12.390192	73	EMPLEADO_EMPRESA	299	Transferencia rechazada por fondos insuficientes
912	TRANSFERENCIA_EJECUTADA	2026-02-27 08:32:12.390192	42	SUPERVISOR_EMPRESA	353	Monto: 32593.95, Estado: Ejecutada
913	PRESTAMO_APROBADO	2026-02-27 08:31:12.390192	705	ANALISTA_INTERNO	211	Monto aprobado: 45359042.03, Tasa: 12.5%
914	CUENTA_CREADA	2026-02-27 08:30:12.390192	151	EMPLEADO_VENTANILLA	430	Cuenta creada correctamente
915	TRANSFERENCIA_RECHAZADA	2026-02-27 08:29:12.390192	306	EMPLEADO_EMPRESA	114	Transferencia rechazada por fondos insuficientes
916	TRANSFERENCIA_EJECUTADA	2026-02-27 08:28:12.390192	259	SUPERVISOR_EMPRESA	175	Monto: 65147.83, Estado: Ejecutada
917	PRESTAMO_APROBADO	2026-02-27 08:27:12.390192	807	ANALISTA_INTERNO	655	Monto aprobado: 3364414.06, Tasa: 12.5%
918	CUENTA_CREADA	2026-02-27 08:26:12.390192	108	EMPLEADO_VENTANILLA	767	Cuenta creada correctamente
919	TRANSFERENCIA_RECHAZADA	2026-02-27 08:25:12.390192	811	EMPLEADO_EMPRESA	809	Transferencia rechazada por fondos insuficientes
920	TRANSFERENCIA_EJECUTADA	2026-02-27 08:24:12.390192	672	SUPERVISOR_EMPRESA	764	Monto: 24027.65, Estado: Ejecutada
921	PRESTAMO_APROBADO	2026-02-27 08:23:12.390192	840	ANALISTA_INTERNO	498	Monto aprobado: 4738718.10, Tasa: 12.5%
922	CUENTA_CREADA	2026-02-27 08:22:12.390192	163	EMPLEADO_VENTANILLA	679	Cuenta creada correctamente
923	TRANSFERENCIA_RECHAZADA	2026-02-27 08:21:12.390192	293	EMPLEADO_EMPRESA	87	Transferencia rechazada por fondos insuficientes
924	TRANSFERENCIA_EJECUTADA	2026-02-27 08:20:12.390192	638	SUPERVISOR_EMPRESA	898	Monto: 56024.92, Estado: Ejecutada
925	PRESTAMO_APROBADO	2026-02-27 08:19:12.390192	410	ANALISTA_INTERNO	723	Monto aprobado: 45091474.17, Tasa: 12.5%
926	CUENTA_CREADA	2026-02-27 08:18:12.390192	350	EMPLEADO_VENTANILLA	122	Cuenta creada correctamente
927	TRANSFERENCIA_RECHAZADA	2026-02-27 08:17:12.390192	746	EMPLEADO_EMPRESA	591	Transferencia rechazada por fondos insuficientes
928	TRANSFERENCIA_EJECUTADA	2026-02-27 08:16:12.390192	273	SUPERVISOR_EMPRESA	989	Monto: 96921.66, Estado: Ejecutada
929	PRESTAMO_APROBADO	2026-02-27 08:15:12.390192	718	ANALISTA_INTERNO	394	Monto aprobado: 9380612.15, Tasa: 12.5%
930	CUENTA_CREADA	2026-02-27 08:14:12.390192	924	EMPLEADO_VENTANILLA	132	Cuenta creada correctamente
931	TRANSFERENCIA_RECHAZADA	2026-02-27 08:13:12.390192	801	EMPLEADO_EMPRESA	358	Transferencia rechazada por fondos insuficientes
932	TRANSFERENCIA_EJECUTADA	2026-02-27 08:12:12.390192	247	SUPERVISOR_EMPRESA	20	Monto: 81585.13, Estado: Ejecutada
933	PRESTAMO_APROBADO	2026-02-27 08:11:12.390192	172	ANALISTA_INTERNO	51	Monto aprobado: 43526440.03, Tasa: 12.5%
934	CUENTA_CREADA	2026-02-27 08:10:12.390192	735	EMPLEADO_VENTANILLA	213	Cuenta creada correctamente
935	TRANSFERENCIA_RECHAZADA	2026-02-27 08:09:12.390192	237	EMPLEADO_EMPRESA	96	Transferencia rechazada por fondos insuficientes
936	TRANSFERENCIA_EJECUTADA	2026-02-27 08:08:12.390192	349	SUPERVISOR_EMPRESA	145	Monto: 3298.92, Estado: Ejecutada
937	PRESTAMO_APROBADO	2026-02-27 08:07:12.390192	734	ANALISTA_INTERNO	681	Monto aprobado: 25820816.52, Tasa: 12.5%
938	CUENTA_CREADA	2026-02-27 08:06:12.390192	654	EMPLEADO_VENTANILLA	491	Cuenta creada correctamente
939	TRANSFERENCIA_RECHAZADA	2026-02-27 08:05:12.390192	586	EMPLEADO_EMPRESA	303	Transferencia rechazada por fondos insuficientes
940	TRANSFERENCIA_EJECUTADA	2026-02-27 08:04:12.390192	961	SUPERVISOR_EMPRESA	203	Monto: 17768.87, Estado: Ejecutada
941	PRESTAMO_APROBADO	2026-02-27 08:03:12.390192	894	ANALISTA_INTERNO	502	Monto aprobado: 20748273.27, Tasa: 12.5%
942	CUENTA_CREADA	2026-02-27 08:02:12.390192	716	EMPLEADO_VENTANILLA	483	Cuenta creada correctamente
943	TRANSFERENCIA_RECHAZADA	2026-02-27 08:01:12.390192	21	EMPLEADO_EMPRESA	83	Transferencia rechazada por fondos insuficientes
944	TRANSFERENCIA_EJECUTADA	2026-02-27 08:00:12.390192	171	SUPERVISOR_EMPRESA	327	Monto: 64607.65, Estado: Ejecutada
945	PRESTAMO_APROBADO	2026-02-27 07:59:12.390192	198	ANALISTA_INTERNO	902	Monto aprobado: 27260911.91, Tasa: 12.5%
946	CUENTA_CREADA	2026-02-27 07:58:12.390192	328	EMPLEADO_VENTANILLA	755	Cuenta creada correctamente
947	TRANSFERENCIA_RECHAZADA	2026-02-27 07:57:12.390192	376	EMPLEADO_EMPRESA	327	Transferencia rechazada por fondos insuficientes
948	TRANSFERENCIA_EJECUTADA	2026-02-27 07:56:12.390192	656	SUPERVISOR_EMPRESA	945	Monto: 13220.05, Estado: Ejecutada
949	PRESTAMO_APROBADO	2026-02-27 07:55:12.390192	795	ANALISTA_INTERNO	578	Monto aprobado: 2743154.03, Tasa: 12.5%
950	CUENTA_CREADA	2026-02-27 07:54:12.390192	939	EMPLEADO_VENTANILLA	137	Cuenta creada correctamente
951	TRANSFERENCIA_RECHAZADA	2026-02-27 07:53:12.390192	264	EMPLEADO_EMPRESA	49	Transferencia rechazada por fondos insuficientes
952	TRANSFERENCIA_EJECUTADA	2026-02-27 07:52:12.390192	630	SUPERVISOR_EMPRESA	444	Monto: 28188.53, Estado: Ejecutada
953	PRESTAMO_APROBADO	2026-02-27 07:51:12.390192	471	ANALISTA_INTERNO	727	Monto aprobado: 23498311.51, Tasa: 12.5%
954	CUENTA_CREADA	2026-02-27 07:50:12.390192	876	EMPLEADO_VENTANILLA	62	Cuenta creada correctamente
955	TRANSFERENCIA_RECHAZADA	2026-02-27 07:49:12.390192	871	EMPLEADO_EMPRESA	619	Transferencia rechazada por fondos insuficientes
956	TRANSFERENCIA_EJECUTADA	2026-02-27 07:48:12.390192	913	SUPERVISOR_EMPRESA	237	Monto: 76164.90, Estado: Ejecutada
957	PRESTAMO_APROBADO	2026-02-27 07:47:12.390192	106	ANALISTA_INTERNO	86	Monto aprobado: 13440960.76, Tasa: 12.5%
958	CUENTA_CREADA	2026-02-27 07:46:12.390192	509	EMPLEADO_VENTANILLA	929	Cuenta creada correctamente
959	TRANSFERENCIA_RECHAZADA	2026-02-27 07:45:12.390192	838	EMPLEADO_EMPRESA	181	Transferencia rechazada por fondos insuficientes
960	TRANSFERENCIA_EJECUTADA	2026-02-27 07:44:12.390192	798	SUPERVISOR_EMPRESA	845	Monto: 18156.83, Estado: Ejecutada
961	PRESTAMO_APROBADO	2026-02-27 07:43:12.390192	812	ANALISTA_INTERNO	348	Monto aprobado: 31915377.90, Tasa: 12.5%
962	CUENTA_CREADA	2026-02-27 07:42:12.390192	674	EMPLEADO_VENTANILLA	710	Cuenta creada correctamente
963	TRANSFERENCIA_RECHAZADA	2026-02-27 07:41:12.390192	468	EMPLEADO_EMPRESA	97	Transferencia rechazada por fondos insuficientes
964	TRANSFERENCIA_EJECUTADA	2026-02-27 07:40:12.390192	934	SUPERVISOR_EMPRESA	285	Monto: 16411.37, Estado: Ejecutada
965	PRESTAMO_APROBADO	2026-02-27 07:39:12.390192	971	ANALISTA_INTERNO	533	Monto aprobado: 43107500.53, Tasa: 12.5%
966	CUENTA_CREADA	2026-02-27 07:38:12.390192	534	EMPLEADO_VENTANILLA	134	Cuenta creada correctamente
967	TRANSFERENCIA_RECHAZADA	2026-02-27 07:37:12.390192	499	EMPLEADO_EMPRESA	897	Transferencia rechazada por fondos insuficientes
968	TRANSFERENCIA_EJECUTADA	2026-02-27 07:36:12.390192	432	SUPERVISOR_EMPRESA	699	Monto: 2031.28, Estado: Ejecutada
969	PRESTAMO_APROBADO	2026-02-27 07:35:12.390192	371	ANALISTA_INTERNO	343	Monto aprobado: 25967597.57, Tasa: 12.5%
970	CUENTA_CREADA	2026-02-27 07:34:12.390192	509	EMPLEADO_VENTANILLA	680	Cuenta creada correctamente
971	TRANSFERENCIA_RECHAZADA	2026-02-27 07:33:12.390192	831	EMPLEADO_EMPRESA	623	Transferencia rechazada por fondos insuficientes
972	TRANSFERENCIA_EJECUTADA	2026-02-27 07:32:12.390192	404	SUPERVISOR_EMPRESA	861	Monto: 37503.63, Estado: Ejecutada
973	PRESTAMO_APROBADO	2026-02-27 07:31:12.390192	482	ANALISTA_INTERNO	215	Monto aprobado: 38787495.39, Tasa: 12.5%
974	CUENTA_CREADA	2026-02-27 07:30:12.390192	157	EMPLEADO_VENTANILLA	217	Cuenta creada correctamente
975	TRANSFERENCIA_RECHAZADA	2026-02-27 07:29:12.390192	627	EMPLEADO_EMPRESA	659	Transferencia rechazada por fondos insuficientes
976	TRANSFERENCIA_EJECUTADA	2026-02-27 07:28:12.390192	91	SUPERVISOR_EMPRESA	202	Monto: 13741.10, Estado: Ejecutada
977	PRESTAMO_APROBADO	2026-02-27 07:27:12.390192	100	ANALISTA_INTERNO	105	Monto aprobado: 18736468.79, Tasa: 12.5%
978	CUENTA_CREADA	2026-02-27 07:26:12.390192	54	EMPLEADO_VENTANILLA	738	Cuenta creada correctamente
979	TRANSFERENCIA_RECHAZADA	2026-02-27 07:25:12.390192	652	EMPLEADO_EMPRESA	268	Transferencia rechazada por fondos insuficientes
980	TRANSFERENCIA_EJECUTADA	2026-02-27 07:24:12.390192	123	SUPERVISOR_EMPRESA	452	Monto: 59172.08, Estado: Ejecutada
981	PRESTAMO_APROBADO	2026-02-27 07:23:12.390192	64	ANALISTA_INTERNO	538	Monto aprobado: 17638666.06, Tasa: 12.5%
982	CUENTA_CREADA	2026-02-27 07:22:12.390192	14	EMPLEADO_VENTANILLA	141	Cuenta creada correctamente
983	TRANSFERENCIA_RECHAZADA	2026-02-27 07:21:12.390192	785	EMPLEADO_EMPRESA	475	Transferencia rechazada por fondos insuficientes
984	TRANSFERENCIA_EJECUTADA	2026-02-27 07:20:12.390192	858	SUPERVISOR_EMPRESA	48	Monto: 10716.04, Estado: Ejecutada
985	PRESTAMO_APROBADO	2026-02-27 07:19:12.390192	986	ANALISTA_INTERNO	933	Monto aprobado: 24993591.58, Tasa: 12.5%
986	CUENTA_CREADA	2026-02-27 07:18:12.390192	906	EMPLEADO_VENTANILLA	766	Cuenta creada correctamente
987	TRANSFERENCIA_RECHAZADA	2026-02-27 07:17:12.390192	725	EMPLEADO_EMPRESA	635	Transferencia rechazada por fondos insuficientes
988	TRANSFERENCIA_EJECUTADA	2026-02-27 07:16:12.390192	328	SUPERVISOR_EMPRESA	946	Monto: 61186.71, Estado: Ejecutada
989	PRESTAMO_APROBADO	2026-02-27 07:15:12.390192	992	ANALISTA_INTERNO	357	Monto aprobado: 40456828.59, Tasa: 12.5%
990	CUENTA_CREADA	2026-02-27 07:14:12.390192	573	EMPLEADO_VENTANILLA	11	Cuenta creada correctamente
991	TRANSFERENCIA_RECHAZADA	2026-02-27 07:13:12.390192	313	EMPLEADO_EMPRESA	602	Transferencia rechazada por fondos insuficientes
992	TRANSFERENCIA_EJECUTADA	2026-02-27 07:12:12.390192	93	SUPERVISOR_EMPRESA	637	Monto: 50191.19, Estado: Ejecutada
993	PRESTAMO_APROBADO	2026-02-27 07:11:12.390192	15	ANALISTA_INTERNO	186	Monto aprobado: 35965873.34, Tasa: 12.5%
994	CUENTA_CREADA	2026-02-27 07:10:12.390192	315	EMPLEADO_VENTANILLA	430	Cuenta creada correctamente
995	TRANSFERENCIA_RECHAZADA	2026-02-27 07:09:12.390192	573	EMPLEADO_EMPRESA	954	Transferencia rechazada por fondos insuficientes
996	TRANSFERENCIA_EJECUTADA	2026-02-27 07:08:12.390192	986	SUPERVISOR_EMPRESA	361	Monto: 46748.65, Estado: Ejecutada
997	PRESTAMO_APROBADO	2026-02-27 07:07:12.390192	745	ANALISTA_INTERNO	744	Monto aprobado: 49556152.66, Tasa: 12.5%
998	CUENTA_CREADA	2026-02-27 07:06:12.390192	520	EMPLEADO_VENTANILLA	780	Cuenta creada correctamente
999	TRANSFERENCIA_RECHAZADA	2026-02-27 07:05:12.390192	112	EMPLEADO_EMPRESA	595	Transferencia rechazada por fondos insuficientes
1000	TRANSFERENCIA_EJECUTADA	2026-02-27 07:04:12.390192	791	SUPERVISOR_EMPRESA	776	Monto: 41795.44, Estado: Ejecutada
\.


--
-- TOC entry 5110 (class 0 OID 16678)
-- Dependencies: 228
-- Data for Name: cliente_empresa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente_empresa (id_empresa, razon_social, nit, correo, telefono, direccion, id_representante, id_estado) FROM stdin;
1	Empresa 1	NIT1	empresa1@mail.com	3100001	Direccion Empresa 1	2	1
2	Empresa 2	NIT2	empresa2@mail.com	3100002	Direccion Empresa 2	3	1
3	Empresa 3	NIT3	empresa3@mail.com	3100003	Direccion Empresa 3	4	1
4	Empresa 4	NIT4	empresa4@mail.com	3100004	Direccion Empresa 4	5	1
5	Empresa 5	NIT5	empresa5@mail.com	3100005	Direccion Empresa 5	6	1
6	Empresa 6	NIT6	empresa6@mail.com	3100006	Direccion Empresa 6	7	1
7	Empresa 7	NIT7	empresa7@mail.com	3100007	Direccion Empresa 7	8	1
8	Empresa 8	NIT8	empresa8@mail.com	3100008	Direccion Empresa 8	9	1
9	Empresa 9	NIT9	empresa9@mail.com	3100009	Direccion Empresa 9	10	1
10	Empresa 10	NIT10	empresa10@mail.com	31000010	Direccion Empresa 10	11	1
11	Empresa 11	NIT11	empresa11@mail.com	31000011	Direccion Empresa 11	12	1
12	Empresa 12	NIT12	empresa12@mail.com	31000012	Direccion Empresa 12	13	1
13	Empresa 13	NIT13	empresa13@mail.com	31000013	Direccion Empresa 13	14	1
14	Empresa 14	NIT14	empresa14@mail.com	31000014	Direccion Empresa 14	15	1
15	Empresa 15	NIT15	empresa15@mail.com	31000015	Direccion Empresa 15	16	1
16	Empresa 16	NIT16	empresa16@mail.com	31000016	Direccion Empresa 16	17	1
17	Empresa 17	NIT17	empresa17@mail.com	31000017	Direccion Empresa 17	18	1
18	Empresa 18	NIT18	empresa18@mail.com	31000018	Direccion Empresa 18	19	1
19	Empresa 19	NIT19	empresa19@mail.com	31000019	Direccion Empresa 19	20	1
20	Empresa 20	NIT20	empresa20@mail.com	31000020	Direccion Empresa 20	21	1
21	Empresa 21	NIT21	empresa21@mail.com	31000021	Direccion Empresa 21	22	1
22	Empresa 22	NIT22	empresa22@mail.com	31000022	Direccion Empresa 22	23	1
23	Empresa 23	NIT23	empresa23@mail.com	31000023	Direccion Empresa 23	24	1
24	Empresa 24	NIT24	empresa24@mail.com	31000024	Direccion Empresa 24	25	1
25	Empresa 25	NIT25	empresa25@mail.com	31000025	Direccion Empresa 25	26	1
26	Empresa 26	NIT26	empresa26@mail.com	31000026	Direccion Empresa 26	27	1
27	Empresa 27	NIT27	empresa27@mail.com	31000027	Direccion Empresa 27	28	1
28	Empresa 28	NIT28	empresa28@mail.com	31000028	Direccion Empresa 28	29	1
29	Empresa 29	NIT29	empresa29@mail.com	31000029	Direccion Empresa 29	30	1
30	Empresa 30	NIT30	empresa30@mail.com	31000030	Direccion Empresa 30	31	1
31	Empresa 31	NIT31	empresa31@mail.com	31000031	Direccion Empresa 31	32	1
32	Empresa 32	NIT32	empresa32@mail.com	31000032	Direccion Empresa 32	33	1
33	Empresa 33	NIT33	empresa33@mail.com	31000033	Direccion Empresa 33	34	1
34	Empresa 34	NIT34	empresa34@mail.com	31000034	Direccion Empresa 34	35	1
35	Empresa 35	NIT35	empresa35@mail.com	31000035	Direccion Empresa 35	36	1
36	Empresa 36	NIT36	empresa36@mail.com	31000036	Direccion Empresa 36	37	1
37	Empresa 37	NIT37	empresa37@mail.com	31000037	Direccion Empresa 37	38	1
38	Empresa 38	NIT38	empresa38@mail.com	31000038	Direccion Empresa 38	39	1
39	Empresa 39	NIT39	empresa39@mail.com	31000039	Direccion Empresa 39	40	1
40	Empresa 40	NIT40	empresa40@mail.com	31000040	Direccion Empresa 40	41	1
41	Empresa 41	NIT41	empresa41@mail.com	31000041	Direccion Empresa 41	42	1
42	Empresa 42	NIT42	empresa42@mail.com	31000042	Direccion Empresa 42	43	1
43	Empresa 43	NIT43	empresa43@mail.com	31000043	Direccion Empresa 43	44	1
44	Empresa 44	NIT44	empresa44@mail.com	31000044	Direccion Empresa 44	45	1
45	Empresa 45	NIT45	empresa45@mail.com	31000045	Direccion Empresa 45	46	1
46	Empresa 46	NIT46	empresa46@mail.com	31000046	Direccion Empresa 46	47	1
47	Empresa 47	NIT47	empresa47@mail.com	31000047	Direccion Empresa 47	48	1
48	Empresa 48	NIT48	empresa48@mail.com	31000048	Direccion Empresa 48	49	1
49	Empresa 49	NIT49	empresa49@mail.com	31000049	Direccion Empresa 49	50	1
50	Empresa 50	NIT50	empresa50@mail.com	31000050	Direccion Empresa 50	51	1
51	Empresa 51	NIT51	empresa51@mail.com	31000051	Direccion Empresa 51	52	1
52	Empresa 52	NIT52	empresa52@mail.com	31000052	Direccion Empresa 52	53	1
53	Empresa 53	NIT53	empresa53@mail.com	31000053	Direccion Empresa 53	54	1
54	Empresa 54	NIT54	empresa54@mail.com	31000054	Direccion Empresa 54	55	1
55	Empresa 55	NIT55	empresa55@mail.com	31000055	Direccion Empresa 55	56	1
56	Empresa 56	NIT56	empresa56@mail.com	31000056	Direccion Empresa 56	57	1
57	Empresa 57	NIT57	empresa57@mail.com	31000057	Direccion Empresa 57	58	1
58	Empresa 58	NIT58	empresa58@mail.com	31000058	Direccion Empresa 58	59	1
59	Empresa 59	NIT59	empresa59@mail.com	31000059	Direccion Empresa 59	60	1
60	Empresa 60	NIT60	empresa60@mail.com	31000060	Direccion Empresa 60	61	1
61	Empresa 61	NIT61	empresa61@mail.com	31000061	Direccion Empresa 61	62	1
62	Empresa 62	NIT62	empresa62@mail.com	31000062	Direccion Empresa 62	63	1
63	Empresa 63	NIT63	empresa63@mail.com	31000063	Direccion Empresa 63	64	1
64	Empresa 64	NIT64	empresa64@mail.com	31000064	Direccion Empresa 64	65	1
65	Empresa 65	NIT65	empresa65@mail.com	31000065	Direccion Empresa 65	66	1
66	Empresa 66	NIT66	empresa66@mail.com	31000066	Direccion Empresa 66	67	1
67	Empresa 67	NIT67	empresa67@mail.com	31000067	Direccion Empresa 67	68	1
68	Empresa 68	NIT68	empresa68@mail.com	31000068	Direccion Empresa 68	69	1
69	Empresa 69	NIT69	empresa69@mail.com	31000069	Direccion Empresa 69	70	1
70	Empresa 70	NIT70	empresa70@mail.com	31000070	Direccion Empresa 70	71	1
71	Empresa 71	NIT71	empresa71@mail.com	31000071	Direccion Empresa 71	72	1
72	Empresa 72	NIT72	empresa72@mail.com	31000072	Direccion Empresa 72	73	1
73	Empresa 73	NIT73	empresa73@mail.com	31000073	Direccion Empresa 73	74	1
74	Empresa 74	NIT74	empresa74@mail.com	31000074	Direccion Empresa 74	75	1
75	Empresa 75	NIT75	empresa75@mail.com	31000075	Direccion Empresa 75	76	1
76	Empresa 76	NIT76	empresa76@mail.com	31000076	Direccion Empresa 76	77	1
77	Empresa 77	NIT77	empresa77@mail.com	31000077	Direccion Empresa 77	78	1
78	Empresa 78	NIT78	empresa78@mail.com	31000078	Direccion Empresa 78	79	1
79	Empresa 79	NIT79	empresa79@mail.com	31000079	Direccion Empresa 79	80	1
80	Empresa 80	NIT80	empresa80@mail.com	31000080	Direccion Empresa 80	81	1
81	Empresa 81	NIT81	empresa81@mail.com	31000081	Direccion Empresa 81	82	1
82	Empresa 82	NIT82	empresa82@mail.com	31000082	Direccion Empresa 82	83	1
83	Empresa 83	NIT83	empresa83@mail.com	31000083	Direccion Empresa 83	84	1
84	Empresa 84	NIT84	empresa84@mail.com	31000084	Direccion Empresa 84	85	1
85	Empresa 85	NIT85	empresa85@mail.com	31000085	Direccion Empresa 85	86	1
86	Empresa 86	NIT86	empresa86@mail.com	31000086	Direccion Empresa 86	87	1
87	Empresa 87	NIT87	empresa87@mail.com	31000087	Direccion Empresa 87	88	1
88	Empresa 88	NIT88	empresa88@mail.com	31000088	Direccion Empresa 88	89	1
89	Empresa 89	NIT89	empresa89@mail.com	31000089	Direccion Empresa 89	90	1
90	Empresa 90	NIT90	empresa90@mail.com	31000090	Direccion Empresa 90	91	1
91	Empresa 91	NIT91	empresa91@mail.com	31000091	Direccion Empresa 91	92	1
92	Empresa 92	NIT92	empresa92@mail.com	31000092	Direccion Empresa 92	93	1
93	Empresa 93	NIT93	empresa93@mail.com	31000093	Direccion Empresa 93	94	1
94	Empresa 94	NIT94	empresa94@mail.com	31000094	Direccion Empresa 94	95	1
95	Empresa 95	NIT95	empresa95@mail.com	31000095	Direccion Empresa 95	96	1
96	Empresa 96	NIT96	empresa96@mail.com	31000096	Direccion Empresa 96	97	1
97	Empresa 97	NIT97	empresa97@mail.com	31000097	Direccion Empresa 97	98	1
98	Empresa 98	NIT98	empresa98@mail.com	31000098	Direccion Empresa 98	99	1
99	Empresa 99	NIT99	empresa99@mail.com	31000099	Direccion Empresa 99	100	1
100	Empresa 100	NIT100	empresa100@mail.com	310000100	Direccion Empresa 100	101	1
101	Empresa 101	NIT101	empresa101@mail.com	310000101	Direccion Empresa 101	102	1
102	Empresa 102	NIT102	empresa102@mail.com	310000102	Direccion Empresa 102	103	1
103	Empresa 103	NIT103	empresa103@mail.com	310000103	Direccion Empresa 103	104	1
104	Empresa 104	NIT104	empresa104@mail.com	310000104	Direccion Empresa 104	105	1
105	Empresa 105	NIT105	empresa105@mail.com	310000105	Direccion Empresa 105	106	1
106	Empresa 106	NIT106	empresa106@mail.com	310000106	Direccion Empresa 106	107	1
107	Empresa 107	NIT107	empresa107@mail.com	310000107	Direccion Empresa 107	108	1
108	Empresa 108	NIT108	empresa108@mail.com	310000108	Direccion Empresa 108	109	1
109	Empresa 109	NIT109	empresa109@mail.com	310000109	Direccion Empresa 109	110	1
110	Empresa 110	NIT110	empresa110@mail.com	310000110	Direccion Empresa 110	111	1
111	Empresa 111	NIT111	empresa111@mail.com	310000111	Direccion Empresa 111	112	1
112	Empresa 112	NIT112	empresa112@mail.com	310000112	Direccion Empresa 112	113	1
113	Empresa 113	NIT113	empresa113@mail.com	310000113	Direccion Empresa 113	114	1
114	Empresa 114	NIT114	empresa114@mail.com	310000114	Direccion Empresa 114	115	1
115	Empresa 115	NIT115	empresa115@mail.com	310000115	Direccion Empresa 115	116	1
116	Empresa 116	NIT116	empresa116@mail.com	310000116	Direccion Empresa 116	117	1
117	Empresa 117	NIT117	empresa117@mail.com	310000117	Direccion Empresa 117	118	1
118	Empresa 118	NIT118	empresa118@mail.com	310000118	Direccion Empresa 118	119	1
119	Empresa 119	NIT119	empresa119@mail.com	310000119	Direccion Empresa 119	120	1
120	Empresa 120	NIT120	empresa120@mail.com	310000120	Direccion Empresa 120	121	1
121	Empresa 121	NIT121	empresa121@mail.com	310000121	Direccion Empresa 121	122	1
122	Empresa 122	NIT122	empresa122@mail.com	310000122	Direccion Empresa 122	123	1
123	Empresa 123	NIT123	empresa123@mail.com	310000123	Direccion Empresa 123	124	1
124	Empresa 124	NIT124	empresa124@mail.com	310000124	Direccion Empresa 124	125	1
125	Empresa 125	NIT125	empresa125@mail.com	310000125	Direccion Empresa 125	126	1
126	Empresa 126	NIT126	empresa126@mail.com	310000126	Direccion Empresa 126	127	1
127	Empresa 127	NIT127	empresa127@mail.com	310000127	Direccion Empresa 127	128	1
128	Empresa 128	NIT128	empresa128@mail.com	310000128	Direccion Empresa 128	129	1
129	Empresa 129	NIT129	empresa129@mail.com	310000129	Direccion Empresa 129	130	1
130	Empresa 130	NIT130	empresa130@mail.com	310000130	Direccion Empresa 130	131	1
131	Empresa 131	NIT131	empresa131@mail.com	310000131	Direccion Empresa 131	132	1
132	Empresa 132	NIT132	empresa132@mail.com	310000132	Direccion Empresa 132	133	1
133	Empresa 133	NIT133	empresa133@mail.com	310000133	Direccion Empresa 133	134	1
134	Empresa 134	NIT134	empresa134@mail.com	310000134	Direccion Empresa 134	135	1
135	Empresa 135	NIT135	empresa135@mail.com	310000135	Direccion Empresa 135	136	1
136	Empresa 136	NIT136	empresa136@mail.com	310000136	Direccion Empresa 136	137	1
137	Empresa 137	NIT137	empresa137@mail.com	310000137	Direccion Empresa 137	138	1
138	Empresa 138	NIT138	empresa138@mail.com	310000138	Direccion Empresa 138	139	1
139	Empresa 139	NIT139	empresa139@mail.com	310000139	Direccion Empresa 139	140	1
140	Empresa 140	NIT140	empresa140@mail.com	310000140	Direccion Empresa 140	141	1
141	Empresa 141	NIT141	empresa141@mail.com	310000141	Direccion Empresa 141	142	1
142	Empresa 142	NIT142	empresa142@mail.com	310000142	Direccion Empresa 142	143	1
143	Empresa 143	NIT143	empresa143@mail.com	310000143	Direccion Empresa 143	144	1
144	Empresa 144	NIT144	empresa144@mail.com	310000144	Direccion Empresa 144	145	1
145	Empresa 145	NIT145	empresa145@mail.com	310000145	Direccion Empresa 145	146	1
146	Empresa 146	NIT146	empresa146@mail.com	310000146	Direccion Empresa 146	147	1
147	Empresa 147	NIT147	empresa147@mail.com	310000147	Direccion Empresa 147	148	1
148	Empresa 148	NIT148	empresa148@mail.com	310000148	Direccion Empresa 148	149	1
149	Empresa 149	NIT149	empresa149@mail.com	310000149	Direccion Empresa 149	150	1
150	Empresa 150	NIT150	empresa150@mail.com	310000150	Direccion Empresa 150	151	1
151	Empresa 151	NIT151	empresa151@mail.com	310000151	Direccion Empresa 151	152	1
152	Empresa 152	NIT152	empresa152@mail.com	310000152	Direccion Empresa 152	153	1
153	Empresa 153	NIT153	empresa153@mail.com	310000153	Direccion Empresa 153	154	1
154	Empresa 154	NIT154	empresa154@mail.com	310000154	Direccion Empresa 154	155	1
155	Empresa 155	NIT155	empresa155@mail.com	310000155	Direccion Empresa 155	156	1
156	Empresa 156	NIT156	empresa156@mail.com	310000156	Direccion Empresa 156	157	1
157	Empresa 157	NIT157	empresa157@mail.com	310000157	Direccion Empresa 157	158	1
158	Empresa 158	NIT158	empresa158@mail.com	310000158	Direccion Empresa 158	159	1
159	Empresa 159	NIT159	empresa159@mail.com	310000159	Direccion Empresa 159	160	1
160	Empresa 160	NIT160	empresa160@mail.com	310000160	Direccion Empresa 160	161	1
161	Empresa 161	NIT161	empresa161@mail.com	310000161	Direccion Empresa 161	162	1
162	Empresa 162	NIT162	empresa162@mail.com	310000162	Direccion Empresa 162	163	1
163	Empresa 163	NIT163	empresa163@mail.com	310000163	Direccion Empresa 163	164	1
164	Empresa 164	NIT164	empresa164@mail.com	310000164	Direccion Empresa 164	165	1
165	Empresa 165	NIT165	empresa165@mail.com	310000165	Direccion Empresa 165	166	1
166	Empresa 166	NIT166	empresa166@mail.com	310000166	Direccion Empresa 166	167	1
167	Empresa 167	NIT167	empresa167@mail.com	310000167	Direccion Empresa 167	168	1
168	Empresa 168	NIT168	empresa168@mail.com	310000168	Direccion Empresa 168	169	1
169	Empresa 169	NIT169	empresa169@mail.com	310000169	Direccion Empresa 169	170	1
170	Empresa 170	NIT170	empresa170@mail.com	310000170	Direccion Empresa 170	171	1
171	Empresa 171	NIT171	empresa171@mail.com	310000171	Direccion Empresa 171	172	1
172	Empresa 172	NIT172	empresa172@mail.com	310000172	Direccion Empresa 172	173	1
173	Empresa 173	NIT173	empresa173@mail.com	310000173	Direccion Empresa 173	174	1
174	Empresa 174	NIT174	empresa174@mail.com	310000174	Direccion Empresa 174	175	1
175	Empresa 175	NIT175	empresa175@mail.com	310000175	Direccion Empresa 175	176	1
176	Empresa 176	NIT176	empresa176@mail.com	310000176	Direccion Empresa 176	177	1
177	Empresa 177	NIT177	empresa177@mail.com	310000177	Direccion Empresa 177	178	1
178	Empresa 178	NIT178	empresa178@mail.com	310000178	Direccion Empresa 178	179	1
179	Empresa 179	NIT179	empresa179@mail.com	310000179	Direccion Empresa 179	180	1
180	Empresa 180	NIT180	empresa180@mail.com	310000180	Direccion Empresa 180	181	1
181	Empresa 181	NIT181	empresa181@mail.com	310000181	Direccion Empresa 181	182	1
182	Empresa 182	NIT182	empresa182@mail.com	310000182	Direccion Empresa 182	183	1
183	Empresa 183	NIT183	empresa183@mail.com	310000183	Direccion Empresa 183	184	1
184	Empresa 184	NIT184	empresa184@mail.com	310000184	Direccion Empresa 184	185	1
185	Empresa 185	NIT185	empresa185@mail.com	310000185	Direccion Empresa 185	186	1
186	Empresa 186	NIT186	empresa186@mail.com	310000186	Direccion Empresa 186	187	1
187	Empresa 187	NIT187	empresa187@mail.com	310000187	Direccion Empresa 187	188	1
188	Empresa 188	NIT188	empresa188@mail.com	310000188	Direccion Empresa 188	189	1
189	Empresa 189	NIT189	empresa189@mail.com	310000189	Direccion Empresa 189	190	1
190	Empresa 190	NIT190	empresa190@mail.com	310000190	Direccion Empresa 190	191	1
191	Empresa 191	NIT191	empresa191@mail.com	310000191	Direccion Empresa 191	192	1
192	Empresa 192	NIT192	empresa192@mail.com	310000192	Direccion Empresa 192	193	1
193	Empresa 193	NIT193	empresa193@mail.com	310000193	Direccion Empresa 193	194	1
194	Empresa 194	NIT194	empresa194@mail.com	310000194	Direccion Empresa 194	195	1
195	Empresa 195	NIT195	empresa195@mail.com	310000195	Direccion Empresa 195	196	1
196	Empresa 196	NIT196	empresa196@mail.com	310000196	Direccion Empresa 196	197	1
197	Empresa 197	NIT197	empresa197@mail.com	310000197	Direccion Empresa 197	198	1
198	Empresa 198	NIT198	empresa198@mail.com	310000198	Direccion Empresa 198	199	1
199	Empresa 199	NIT199	empresa199@mail.com	310000199	Direccion Empresa 199	200	1
200	Empresa 200	NIT200	empresa200@mail.com	310000200	Direccion Empresa 200	201	1
\.


--
-- TOC entry 5108 (class 0 OID 16658)
-- Dependencies: 226
-- Data for Name: cliente_person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente_person (id_persona, nombre_completo, numero_identificacion, correo, telefono, fecha_nacimiento, direccion, id_estado) FROM stdin;
1	Persona 1	CC1	persona1@mail.com	3000001	1980-01-02	Direccion 1	1
2	Persona 2	CC2	persona2@mail.com	3000002	1980-01-03	Direccion 2	1
3	Persona 3	CC3	persona3@mail.com	3000003	1980-01-04	Direccion 3	1
4	Persona 4	CC4	persona4@mail.com	3000004	1980-01-05	Direccion 4	1
5	Persona 5	CC5	persona5@mail.com	3000005	1980-01-06	Direccion 5	1
6	Persona 6	CC6	persona6@mail.com	3000006	1980-01-07	Direccion 6	1
7	Persona 7	CC7	persona7@mail.com	3000007	1980-01-08	Direccion 7	1
8	Persona 8	CC8	persona8@mail.com	3000008	1980-01-09	Direccion 8	1
9	Persona 9	CC9	persona9@mail.com	3000009	1980-01-10	Direccion 9	1
10	Persona 10	CC10	persona10@mail.com	30000010	1980-01-11	Direccion 10	1
11	Persona 11	CC11	persona11@mail.com	30000011	1980-01-12	Direccion 11	1
12	Persona 12	CC12	persona12@mail.com	30000012	1980-01-13	Direccion 12	1
13	Persona 13	CC13	persona13@mail.com	30000013	1980-01-14	Direccion 13	1
14	Persona 14	CC14	persona14@mail.com	30000014	1980-01-15	Direccion 14	1
15	Persona 15	CC15	persona15@mail.com	30000015	1980-01-16	Direccion 15	1
16	Persona 16	CC16	persona16@mail.com	30000016	1980-01-17	Direccion 16	1
17	Persona 17	CC17	persona17@mail.com	30000017	1980-01-18	Direccion 17	1
18	Persona 18	CC18	persona18@mail.com	30000018	1980-01-19	Direccion 18	1
19	Persona 19	CC19	persona19@mail.com	30000019	1980-01-20	Direccion 19	1
20	Persona 20	CC20	persona20@mail.com	30000020	1980-01-21	Direccion 20	1
21	Persona 21	CC21	persona21@mail.com	30000021	1980-01-22	Direccion 21	1
22	Persona 22	CC22	persona22@mail.com	30000022	1980-01-23	Direccion 22	1
23	Persona 23	CC23	persona23@mail.com	30000023	1980-01-24	Direccion 23	1
24	Persona 24	CC24	persona24@mail.com	30000024	1980-01-25	Direccion 24	1
25	Persona 25	CC25	persona25@mail.com	30000025	1980-01-26	Direccion 25	1
26	Persona 26	CC26	persona26@mail.com	30000026	1980-01-27	Direccion 26	1
27	Persona 27	CC27	persona27@mail.com	30000027	1980-01-28	Direccion 27	1
28	Persona 28	CC28	persona28@mail.com	30000028	1980-01-29	Direccion 28	1
29	Persona 29	CC29	persona29@mail.com	30000029	1980-01-30	Direccion 29	1
30	Persona 30	CC30	persona30@mail.com	30000030	1980-01-31	Direccion 30	1
31	Persona 31	CC31	persona31@mail.com	30000031	1980-02-01	Direccion 31	1
32	Persona 32	CC32	persona32@mail.com	30000032	1980-02-02	Direccion 32	1
33	Persona 33	CC33	persona33@mail.com	30000033	1980-02-03	Direccion 33	1
34	Persona 34	CC34	persona34@mail.com	30000034	1980-02-04	Direccion 34	1
35	Persona 35	CC35	persona35@mail.com	30000035	1980-02-05	Direccion 35	1
36	Persona 36	CC36	persona36@mail.com	30000036	1980-02-06	Direccion 36	1
37	Persona 37	CC37	persona37@mail.com	30000037	1980-02-07	Direccion 37	1
38	Persona 38	CC38	persona38@mail.com	30000038	1980-02-08	Direccion 38	1
39	Persona 39	CC39	persona39@mail.com	30000039	1980-02-09	Direccion 39	1
40	Persona 40	CC40	persona40@mail.com	30000040	1980-02-10	Direccion 40	1
41	Persona 41	CC41	persona41@mail.com	30000041	1980-02-11	Direccion 41	1
42	Persona 42	CC42	persona42@mail.com	30000042	1980-02-12	Direccion 42	1
43	Persona 43	CC43	persona43@mail.com	30000043	1980-02-13	Direccion 43	1
44	Persona 44	CC44	persona44@mail.com	30000044	1980-02-14	Direccion 44	1
45	Persona 45	CC45	persona45@mail.com	30000045	1980-02-15	Direccion 45	1
46	Persona 46	CC46	persona46@mail.com	30000046	1980-02-16	Direccion 46	1
47	Persona 47	CC47	persona47@mail.com	30000047	1980-02-17	Direccion 47	1
48	Persona 48	CC48	persona48@mail.com	30000048	1980-02-18	Direccion 48	1
49	Persona 49	CC49	persona49@mail.com	30000049	1980-02-19	Direccion 49	1
50	Persona 50	CC50	persona50@mail.com	30000050	1980-02-20	Direccion 50	1
51	Persona 51	CC51	persona51@mail.com	30000051	1980-02-21	Direccion 51	1
52	Persona 52	CC52	persona52@mail.com	30000052	1980-02-22	Direccion 52	1
53	Persona 53	CC53	persona53@mail.com	30000053	1980-02-23	Direccion 53	1
54	Persona 54	CC54	persona54@mail.com	30000054	1980-02-24	Direccion 54	1
55	Persona 55	CC55	persona55@mail.com	30000055	1980-02-25	Direccion 55	1
56	Persona 56	CC56	persona56@mail.com	30000056	1980-02-26	Direccion 56	1
57	Persona 57	CC57	persona57@mail.com	30000057	1980-02-27	Direccion 57	1
58	Persona 58	CC58	persona58@mail.com	30000058	1980-02-28	Direccion 58	1
59	Persona 59	CC59	persona59@mail.com	30000059	1980-02-29	Direccion 59	1
60	Persona 60	CC60	persona60@mail.com	30000060	1980-03-01	Direccion 60	1
61	Persona 61	CC61	persona61@mail.com	30000061	1980-03-02	Direccion 61	1
62	Persona 62	CC62	persona62@mail.com	30000062	1980-03-03	Direccion 62	1
63	Persona 63	CC63	persona63@mail.com	30000063	1980-03-04	Direccion 63	1
64	Persona 64	CC64	persona64@mail.com	30000064	1980-03-05	Direccion 64	1
65	Persona 65	CC65	persona65@mail.com	30000065	1980-03-06	Direccion 65	1
66	Persona 66	CC66	persona66@mail.com	30000066	1980-03-07	Direccion 66	1
67	Persona 67	CC67	persona67@mail.com	30000067	1980-03-08	Direccion 67	1
68	Persona 68	CC68	persona68@mail.com	30000068	1980-03-09	Direccion 68	1
69	Persona 69	CC69	persona69@mail.com	30000069	1980-03-10	Direccion 69	1
70	Persona 70	CC70	persona70@mail.com	30000070	1980-03-11	Direccion 70	1
71	Persona 71	CC71	persona71@mail.com	30000071	1980-03-12	Direccion 71	1
72	Persona 72	CC72	persona72@mail.com	30000072	1980-03-13	Direccion 72	1
73	Persona 73	CC73	persona73@mail.com	30000073	1980-03-14	Direccion 73	1
74	Persona 74	CC74	persona74@mail.com	30000074	1980-03-15	Direccion 74	1
75	Persona 75	CC75	persona75@mail.com	30000075	1980-03-16	Direccion 75	1
76	Persona 76	CC76	persona76@mail.com	30000076	1980-03-17	Direccion 76	1
77	Persona 77	CC77	persona77@mail.com	30000077	1980-03-18	Direccion 77	1
78	Persona 78	CC78	persona78@mail.com	30000078	1980-03-19	Direccion 78	1
79	Persona 79	CC79	persona79@mail.com	30000079	1980-03-20	Direccion 79	1
80	Persona 80	CC80	persona80@mail.com	30000080	1980-03-21	Direccion 80	1
81	Persona 81	CC81	persona81@mail.com	30000081	1980-03-22	Direccion 81	1
82	Persona 82	CC82	persona82@mail.com	30000082	1980-03-23	Direccion 82	1
83	Persona 83	CC83	persona83@mail.com	30000083	1980-03-24	Direccion 83	1
84	Persona 84	CC84	persona84@mail.com	30000084	1980-03-25	Direccion 84	1
85	Persona 85	CC85	persona85@mail.com	30000085	1980-03-26	Direccion 85	1
86	Persona 86	CC86	persona86@mail.com	30000086	1980-03-27	Direccion 86	1
87	Persona 87	CC87	persona87@mail.com	30000087	1980-03-28	Direccion 87	1
88	Persona 88	CC88	persona88@mail.com	30000088	1980-03-29	Direccion 88	1
89	Persona 89	CC89	persona89@mail.com	30000089	1980-03-30	Direccion 89	1
90	Persona 90	CC90	persona90@mail.com	30000090	1980-03-31	Direccion 90	1
91	Persona 91	CC91	persona91@mail.com	30000091	1980-04-01	Direccion 91	1
92	Persona 92	CC92	persona92@mail.com	30000092	1980-04-02	Direccion 92	1
93	Persona 93	CC93	persona93@mail.com	30000093	1980-04-03	Direccion 93	1
94	Persona 94	CC94	persona94@mail.com	30000094	1980-04-04	Direccion 94	1
95	Persona 95	CC95	persona95@mail.com	30000095	1980-04-05	Direccion 95	1
96	Persona 96	CC96	persona96@mail.com	30000096	1980-04-06	Direccion 96	1
97	Persona 97	CC97	persona97@mail.com	30000097	1980-04-07	Direccion 97	1
98	Persona 98	CC98	persona98@mail.com	30000098	1980-04-08	Direccion 98	1
99	Persona 99	CC99	persona99@mail.com	30000099	1980-04-09	Direccion 99	1
100	Persona 100	CC100	persona100@mail.com	300000100	1980-04-10	Direccion 100	1
101	Persona 101	CC101	persona101@mail.com	300000101	1980-04-11	Direccion 101	1
102	Persona 102	CC102	persona102@mail.com	300000102	1980-04-12	Direccion 102	1
103	Persona 103	CC103	persona103@mail.com	300000103	1980-04-13	Direccion 103	1
104	Persona 104	CC104	persona104@mail.com	300000104	1980-04-14	Direccion 104	1
105	Persona 105	CC105	persona105@mail.com	300000105	1980-04-15	Direccion 105	1
106	Persona 106	CC106	persona106@mail.com	300000106	1980-04-16	Direccion 106	1
107	Persona 107	CC107	persona107@mail.com	300000107	1980-04-17	Direccion 107	1
108	Persona 108	CC108	persona108@mail.com	300000108	1980-04-18	Direccion 108	1
109	Persona 109	CC109	persona109@mail.com	300000109	1980-04-19	Direccion 109	1
110	Persona 110	CC110	persona110@mail.com	300000110	1980-04-20	Direccion 110	1
111	Persona 111	CC111	persona111@mail.com	300000111	1980-04-21	Direccion 111	1
112	Persona 112	CC112	persona112@mail.com	300000112	1980-04-22	Direccion 112	1
113	Persona 113	CC113	persona113@mail.com	300000113	1980-04-23	Direccion 113	1
114	Persona 114	CC114	persona114@mail.com	300000114	1980-04-24	Direccion 114	1
115	Persona 115	CC115	persona115@mail.com	300000115	1980-04-25	Direccion 115	1
116	Persona 116	CC116	persona116@mail.com	300000116	1980-04-26	Direccion 116	1
117	Persona 117	CC117	persona117@mail.com	300000117	1980-04-27	Direccion 117	1
118	Persona 118	CC118	persona118@mail.com	300000118	1980-04-28	Direccion 118	1
119	Persona 119	CC119	persona119@mail.com	300000119	1980-04-29	Direccion 119	1
120	Persona 120	CC120	persona120@mail.com	300000120	1980-04-30	Direccion 120	1
121	Persona 121	CC121	persona121@mail.com	300000121	1980-05-01	Direccion 121	1
122	Persona 122	CC122	persona122@mail.com	300000122	1980-05-02	Direccion 122	1
123	Persona 123	CC123	persona123@mail.com	300000123	1980-05-03	Direccion 123	1
124	Persona 124	CC124	persona124@mail.com	300000124	1980-05-04	Direccion 124	1
125	Persona 125	CC125	persona125@mail.com	300000125	1980-05-05	Direccion 125	1
126	Persona 126	CC126	persona126@mail.com	300000126	1980-05-06	Direccion 126	1
127	Persona 127	CC127	persona127@mail.com	300000127	1980-05-07	Direccion 127	1
128	Persona 128	CC128	persona128@mail.com	300000128	1980-05-08	Direccion 128	1
129	Persona 129	CC129	persona129@mail.com	300000129	1980-05-09	Direccion 129	1
130	Persona 130	CC130	persona130@mail.com	300000130	1980-05-10	Direccion 130	1
131	Persona 131	CC131	persona131@mail.com	300000131	1980-05-11	Direccion 131	1
132	Persona 132	CC132	persona132@mail.com	300000132	1980-05-12	Direccion 132	1
133	Persona 133	CC133	persona133@mail.com	300000133	1980-05-13	Direccion 133	1
134	Persona 134	CC134	persona134@mail.com	300000134	1980-05-14	Direccion 134	1
135	Persona 135	CC135	persona135@mail.com	300000135	1980-05-15	Direccion 135	1
136	Persona 136	CC136	persona136@mail.com	300000136	1980-05-16	Direccion 136	1
137	Persona 137	CC137	persona137@mail.com	300000137	1980-05-17	Direccion 137	1
138	Persona 138	CC138	persona138@mail.com	300000138	1980-05-18	Direccion 138	1
139	Persona 139	CC139	persona139@mail.com	300000139	1980-05-19	Direccion 139	1
140	Persona 140	CC140	persona140@mail.com	300000140	1980-05-20	Direccion 140	1
141	Persona 141	CC141	persona141@mail.com	300000141	1980-05-21	Direccion 141	1
142	Persona 142	CC142	persona142@mail.com	300000142	1980-05-22	Direccion 142	1
143	Persona 143	CC143	persona143@mail.com	300000143	1980-05-23	Direccion 143	1
144	Persona 144	CC144	persona144@mail.com	300000144	1980-05-24	Direccion 144	1
145	Persona 145	CC145	persona145@mail.com	300000145	1980-05-25	Direccion 145	1
146	Persona 146	CC146	persona146@mail.com	300000146	1980-05-26	Direccion 146	1
147	Persona 147	CC147	persona147@mail.com	300000147	1980-05-27	Direccion 147	1
148	Persona 148	CC148	persona148@mail.com	300000148	1980-05-28	Direccion 148	1
149	Persona 149	CC149	persona149@mail.com	300000149	1980-05-29	Direccion 149	1
150	Persona 150	CC150	persona150@mail.com	300000150	1980-05-30	Direccion 150	1
151	Persona 151	CC151	persona151@mail.com	300000151	1980-05-31	Direccion 151	1
152	Persona 152	CC152	persona152@mail.com	300000152	1980-06-01	Direccion 152	1
153	Persona 153	CC153	persona153@mail.com	300000153	1980-06-02	Direccion 153	1
154	Persona 154	CC154	persona154@mail.com	300000154	1980-06-03	Direccion 154	1
155	Persona 155	CC155	persona155@mail.com	300000155	1980-06-04	Direccion 155	1
156	Persona 156	CC156	persona156@mail.com	300000156	1980-06-05	Direccion 156	1
157	Persona 157	CC157	persona157@mail.com	300000157	1980-06-06	Direccion 157	1
158	Persona 158	CC158	persona158@mail.com	300000158	1980-06-07	Direccion 158	1
159	Persona 159	CC159	persona159@mail.com	300000159	1980-06-08	Direccion 159	1
160	Persona 160	CC160	persona160@mail.com	300000160	1980-06-09	Direccion 160	1
161	Persona 161	CC161	persona161@mail.com	300000161	1980-06-10	Direccion 161	1
162	Persona 162	CC162	persona162@mail.com	300000162	1980-06-11	Direccion 162	1
163	Persona 163	CC163	persona163@mail.com	300000163	1980-06-12	Direccion 163	1
164	Persona 164	CC164	persona164@mail.com	300000164	1980-06-13	Direccion 164	1
165	Persona 165	CC165	persona165@mail.com	300000165	1980-06-14	Direccion 165	1
166	Persona 166	CC166	persona166@mail.com	300000166	1980-06-15	Direccion 166	1
167	Persona 167	CC167	persona167@mail.com	300000167	1980-06-16	Direccion 167	1
168	Persona 168	CC168	persona168@mail.com	300000168	1980-06-17	Direccion 168	1
169	Persona 169	CC169	persona169@mail.com	300000169	1980-06-18	Direccion 169	1
170	Persona 170	CC170	persona170@mail.com	300000170	1980-06-19	Direccion 170	1
171	Persona 171	CC171	persona171@mail.com	300000171	1980-06-20	Direccion 171	1
172	Persona 172	CC172	persona172@mail.com	300000172	1980-06-21	Direccion 172	1
173	Persona 173	CC173	persona173@mail.com	300000173	1980-06-22	Direccion 173	1
174	Persona 174	CC174	persona174@mail.com	300000174	1980-06-23	Direccion 174	1
175	Persona 175	CC175	persona175@mail.com	300000175	1980-06-24	Direccion 175	1
176	Persona 176	CC176	persona176@mail.com	300000176	1980-06-25	Direccion 176	1
177	Persona 177	CC177	persona177@mail.com	300000177	1980-06-26	Direccion 177	1
178	Persona 178	CC178	persona178@mail.com	300000178	1980-06-27	Direccion 178	1
179	Persona 179	CC179	persona179@mail.com	300000179	1980-06-28	Direccion 179	1
180	Persona 180	CC180	persona180@mail.com	300000180	1980-06-29	Direccion 180	1
181	Persona 181	CC181	persona181@mail.com	300000181	1980-06-30	Direccion 181	1
182	Persona 182	CC182	persona182@mail.com	300000182	1980-07-01	Direccion 182	1
183	Persona 183	CC183	persona183@mail.com	300000183	1980-07-02	Direccion 183	1
184	Persona 184	CC184	persona184@mail.com	300000184	1980-07-03	Direccion 184	1
185	Persona 185	CC185	persona185@mail.com	300000185	1980-07-04	Direccion 185	1
186	Persona 186	CC186	persona186@mail.com	300000186	1980-07-05	Direccion 186	1
187	Persona 187	CC187	persona187@mail.com	300000187	1980-07-06	Direccion 187	1
188	Persona 188	CC188	persona188@mail.com	300000188	1980-07-07	Direccion 188	1
189	Persona 189	CC189	persona189@mail.com	300000189	1980-07-08	Direccion 189	1
190	Persona 190	CC190	persona190@mail.com	300000190	1980-07-09	Direccion 190	1
191	Persona 191	CC191	persona191@mail.com	300000191	1980-07-10	Direccion 191	1
192	Persona 192	CC192	persona192@mail.com	300000192	1980-07-11	Direccion 192	1
193	Persona 193	CC193	persona193@mail.com	300000193	1980-07-12	Direccion 193	1
194	Persona 194	CC194	persona194@mail.com	300000194	1980-07-13	Direccion 194	1
195	Persona 195	CC195	persona195@mail.com	300000195	1980-07-14	Direccion 195	1
196	Persona 196	CC196	persona196@mail.com	300000196	1980-07-15	Direccion 196	1
197	Persona 197	CC197	persona197@mail.com	300000197	1980-07-16	Direccion 197	1
198	Persona 198	CC198	persona198@mail.com	300000198	1980-07-17	Direccion 198	1
199	Persona 199	CC199	persona199@mail.com	300000199	1980-07-18	Direccion 199	1
200	Persona 200	CC200	persona200@mail.com	300000200	1980-07-19	Direccion 200	1
201	Persona 201	CC201	persona201@mail.com	300000201	1980-07-20	Direccion 201	1
202	Persona 202	CC202	persona202@mail.com	300000202	1980-07-21	Direccion 202	1
203	Persona 203	CC203	persona203@mail.com	300000203	1980-07-22	Direccion 203	1
204	Persona 204	CC204	persona204@mail.com	300000204	1980-07-23	Direccion 204	1
205	Persona 205	CC205	persona205@mail.com	300000205	1980-07-24	Direccion 205	1
206	Persona 206	CC206	persona206@mail.com	300000206	1980-07-25	Direccion 206	1
207	Persona 207	CC207	persona207@mail.com	300000207	1980-07-26	Direccion 207	1
208	Persona 208	CC208	persona208@mail.com	300000208	1980-07-27	Direccion 208	1
209	Persona 209	CC209	persona209@mail.com	300000209	1980-07-28	Direccion 209	1
210	Persona 210	CC210	persona210@mail.com	300000210	1980-07-29	Direccion 210	1
211	Persona 211	CC211	persona211@mail.com	300000211	1980-07-30	Direccion 211	1
212	Persona 212	CC212	persona212@mail.com	300000212	1980-07-31	Direccion 212	1
213	Persona 213	CC213	persona213@mail.com	300000213	1980-08-01	Direccion 213	1
214	Persona 214	CC214	persona214@mail.com	300000214	1980-08-02	Direccion 214	1
215	Persona 215	CC215	persona215@mail.com	300000215	1980-08-03	Direccion 215	1
216	Persona 216	CC216	persona216@mail.com	300000216	1980-08-04	Direccion 216	1
217	Persona 217	CC217	persona217@mail.com	300000217	1980-08-05	Direccion 217	1
218	Persona 218	CC218	persona218@mail.com	300000218	1980-08-06	Direccion 218	1
219	Persona 219	CC219	persona219@mail.com	300000219	1980-08-07	Direccion 219	1
220	Persona 220	CC220	persona220@mail.com	300000220	1980-08-08	Direccion 220	1
221	Persona 221	CC221	persona221@mail.com	300000221	1980-08-09	Direccion 221	1
222	Persona 222	CC222	persona222@mail.com	300000222	1980-08-10	Direccion 222	1
223	Persona 223	CC223	persona223@mail.com	300000223	1980-08-11	Direccion 223	1
224	Persona 224	CC224	persona224@mail.com	300000224	1980-08-12	Direccion 224	1
225	Persona 225	CC225	persona225@mail.com	300000225	1980-08-13	Direccion 225	1
226	Persona 226	CC226	persona226@mail.com	300000226	1980-08-14	Direccion 226	1
227	Persona 227	CC227	persona227@mail.com	300000227	1980-08-15	Direccion 227	1
228	Persona 228	CC228	persona228@mail.com	300000228	1980-08-16	Direccion 228	1
229	Persona 229	CC229	persona229@mail.com	300000229	1980-08-17	Direccion 229	1
230	Persona 230	CC230	persona230@mail.com	300000230	1980-08-18	Direccion 230	1
231	Persona 231	CC231	persona231@mail.com	300000231	1980-08-19	Direccion 231	1
232	Persona 232	CC232	persona232@mail.com	300000232	1980-08-20	Direccion 232	1
233	Persona 233	CC233	persona233@mail.com	300000233	1980-08-21	Direccion 233	1
234	Persona 234	CC234	persona234@mail.com	300000234	1980-08-22	Direccion 234	1
235	Persona 235	CC235	persona235@mail.com	300000235	1980-08-23	Direccion 235	1
236	Persona 236	CC236	persona236@mail.com	300000236	1980-08-24	Direccion 236	1
237	Persona 237	CC237	persona237@mail.com	300000237	1980-08-25	Direccion 237	1
238	Persona 238	CC238	persona238@mail.com	300000238	1980-08-26	Direccion 238	1
239	Persona 239	CC239	persona239@mail.com	300000239	1980-08-27	Direccion 239	1
240	Persona 240	CC240	persona240@mail.com	300000240	1980-08-28	Direccion 240	1
241	Persona 241	CC241	persona241@mail.com	300000241	1980-08-29	Direccion 241	1
242	Persona 242	CC242	persona242@mail.com	300000242	1980-08-30	Direccion 242	1
243	Persona 243	CC243	persona243@mail.com	300000243	1980-08-31	Direccion 243	1
244	Persona 244	CC244	persona244@mail.com	300000244	1980-09-01	Direccion 244	1
245	Persona 245	CC245	persona245@mail.com	300000245	1980-09-02	Direccion 245	1
246	Persona 246	CC246	persona246@mail.com	300000246	1980-09-03	Direccion 246	1
247	Persona 247	CC247	persona247@mail.com	300000247	1980-09-04	Direccion 247	1
248	Persona 248	CC248	persona248@mail.com	300000248	1980-09-05	Direccion 248	1
249	Persona 249	CC249	persona249@mail.com	300000249	1980-09-06	Direccion 249	1
250	Persona 250	CC250	persona250@mail.com	300000250	1980-09-07	Direccion 250	1
251	Persona 251	CC251	persona251@mail.com	300000251	1980-09-08	Direccion 251	1
252	Persona 252	CC252	persona252@mail.com	300000252	1980-09-09	Direccion 252	1
253	Persona 253	CC253	persona253@mail.com	300000253	1980-09-10	Direccion 253	1
254	Persona 254	CC254	persona254@mail.com	300000254	1980-09-11	Direccion 254	1
255	Persona 255	CC255	persona255@mail.com	300000255	1980-09-12	Direccion 255	1
256	Persona 256	CC256	persona256@mail.com	300000256	1980-09-13	Direccion 256	1
257	Persona 257	CC257	persona257@mail.com	300000257	1980-09-14	Direccion 257	1
258	Persona 258	CC258	persona258@mail.com	300000258	1980-09-15	Direccion 258	1
259	Persona 259	CC259	persona259@mail.com	300000259	1980-09-16	Direccion 259	1
260	Persona 260	CC260	persona260@mail.com	300000260	1980-09-17	Direccion 260	1
261	Persona 261	CC261	persona261@mail.com	300000261	1980-09-18	Direccion 261	1
262	Persona 262	CC262	persona262@mail.com	300000262	1980-09-19	Direccion 262	1
263	Persona 263	CC263	persona263@mail.com	300000263	1980-09-20	Direccion 263	1
264	Persona 264	CC264	persona264@mail.com	300000264	1980-09-21	Direccion 264	1
265	Persona 265	CC265	persona265@mail.com	300000265	1980-09-22	Direccion 265	1
266	Persona 266	CC266	persona266@mail.com	300000266	1980-09-23	Direccion 266	1
267	Persona 267	CC267	persona267@mail.com	300000267	1980-09-24	Direccion 267	1
268	Persona 268	CC268	persona268@mail.com	300000268	1980-09-25	Direccion 268	1
269	Persona 269	CC269	persona269@mail.com	300000269	1980-09-26	Direccion 269	1
270	Persona 270	CC270	persona270@mail.com	300000270	1980-09-27	Direccion 270	1
271	Persona 271	CC271	persona271@mail.com	300000271	1980-09-28	Direccion 271	1
272	Persona 272	CC272	persona272@mail.com	300000272	1980-09-29	Direccion 272	1
273	Persona 273	CC273	persona273@mail.com	300000273	1980-09-30	Direccion 273	1
274	Persona 274	CC274	persona274@mail.com	300000274	1980-10-01	Direccion 274	1
275	Persona 275	CC275	persona275@mail.com	300000275	1980-10-02	Direccion 275	1
276	Persona 276	CC276	persona276@mail.com	300000276	1980-10-03	Direccion 276	1
277	Persona 277	CC277	persona277@mail.com	300000277	1980-10-04	Direccion 277	1
278	Persona 278	CC278	persona278@mail.com	300000278	1980-10-05	Direccion 278	1
279	Persona 279	CC279	persona279@mail.com	300000279	1980-10-06	Direccion 279	1
280	Persona 280	CC280	persona280@mail.com	300000280	1980-10-07	Direccion 280	1
281	Persona 281	CC281	persona281@mail.com	300000281	1980-10-08	Direccion 281	1
282	Persona 282	CC282	persona282@mail.com	300000282	1980-10-09	Direccion 282	1
283	Persona 283	CC283	persona283@mail.com	300000283	1980-10-10	Direccion 283	1
284	Persona 284	CC284	persona284@mail.com	300000284	1980-10-11	Direccion 284	1
285	Persona 285	CC285	persona285@mail.com	300000285	1980-10-12	Direccion 285	1
286	Persona 286	CC286	persona286@mail.com	300000286	1980-10-13	Direccion 286	1
287	Persona 287	CC287	persona287@mail.com	300000287	1980-10-14	Direccion 287	1
288	Persona 288	CC288	persona288@mail.com	300000288	1980-10-15	Direccion 288	1
289	Persona 289	CC289	persona289@mail.com	300000289	1980-10-16	Direccion 289	1
290	Persona 290	CC290	persona290@mail.com	300000290	1980-10-17	Direccion 290	1
291	Persona 291	CC291	persona291@mail.com	300000291	1980-10-18	Direccion 291	1
292	Persona 292	CC292	persona292@mail.com	300000292	1980-10-19	Direccion 292	1
293	Persona 293	CC293	persona293@mail.com	300000293	1980-10-20	Direccion 293	1
294	Persona 294	CC294	persona294@mail.com	300000294	1980-10-21	Direccion 294	1
295	Persona 295	CC295	persona295@mail.com	300000295	1980-10-22	Direccion 295	1
296	Persona 296	CC296	persona296@mail.com	300000296	1980-10-23	Direccion 296	1
297	Persona 297	CC297	persona297@mail.com	300000297	1980-10-24	Direccion 297	1
298	Persona 298	CC298	persona298@mail.com	300000298	1980-10-25	Direccion 298	1
299	Persona 299	CC299	persona299@mail.com	300000299	1980-10-26	Direccion 299	1
300	Persona 300	CC300	persona300@mail.com	300000300	1980-10-27	Direccion 300	1
301	Persona 301	CC301	persona301@mail.com	300000301	1980-10-28	Direccion 301	1
302	Persona 302	CC302	persona302@mail.com	300000302	1980-10-29	Direccion 302	1
303	Persona 303	CC303	persona303@mail.com	300000303	1980-10-30	Direccion 303	1
304	Persona 304	CC304	persona304@mail.com	300000304	1980-10-31	Direccion 304	1
305	Persona 305	CC305	persona305@mail.com	300000305	1980-11-01	Direccion 305	1
306	Persona 306	CC306	persona306@mail.com	300000306	1980-11-02	Direccion 306	1
307	Persona 307	CC307	persona307@mail.com	300000307	1980-11-03	Direccion 307	1
308	Persona 308	CC308	persona308@mail.com	300000308	1980-11-04	Direccion 308	1
309	Persona 309	CC309	persona309@mail.com	300000309	1980-11-05	Direccion 309	1
310	Persona 310	CC310	persona310@mail.com	300000310	1980-11-06	Direccion 310	1
311	Persona 311	CC311	persona311@mail.com	300000311	1980-11-07	Direccion 311	1
312	Persona 312	CC312	persona312@mail.com	300000312	1980-11-08	Direccion 312	1
313	Persona 313	CC313	persona313@mail.com	300000313	1980-11-09	Direccion 313	1
314	Persona 314	CC314	persona314@mail.com	300000314	1980-11-10	Direccion 314	1
315	Persona 315	CC315	persona315@mail.com	300000315	1980-11-11	Direccion 315	1
316	Persona 316	CC316	persona316@mail.com	300000316	1980-11-12	Direccion 316	1
317	Persona 317	CC317	persona317@mail.com	300000317	1980-11-13	Direccion 317	1
318	Persona 318	CC318	persona318@mail.com	300000318	1980-11-14	Direccion 318	1
319	Persona 319	CC319	persona319@mail.com	300000319	1980-11-15	Direccion 319	1
320	Persona 320	CC320	persona320@mail.com	300000320	1980-11-16	Direccion 320	1
321	Persona 321	CC321	persona321@mail.com	300000321	1980-11-17	Direccion 321	1
322	Persona 322	CC322	persona322@mail.com	300000322	1980-11-18	Direccion 322	1
323	Persona 323	CC323	persona323@mail.com	300000323	1980-11-19	Direccion 323	1
324	Persona 324	CC324	persona324@mail.com	300000324	1980-11-20	Direccion 324	1
325	Persona 325	CC325	persona325@mail.com	300000325	1980-11-21	Direccion 325	1
326	Persona 326	CC326	persona326@mail.com	300000326	1980-11-22	Direccion 326	1
327	Persona 327	CC327	persona327@mail.com	300000327	1980-11-23	Direccion 327	1
328	Persona 328	CC328	persona328@mail.com	300000328	1980-11-24	Direccion 328	1
329	Persona 329	CC329	persona329@mail.com	300000329	1980-11-25	Direccion 329	1
330	Persona 330	CC330	persona330@mail.com	300000330	1980-11-26	Direccion 330	1
331	Persona 331	CC331	persona331@mail.com	300000331	1980-11-27	Direccion 331	1
332	Persona 332	CC332	persona332@mail.com	300000332	1980-11-28	Direccion 332	1
333	Persona 333	CC333	persona333@mail.com	300000333	1980-11-29	Direccion 333	1
334	Persona 334	CC334	persona334@mail.com	300000334	1980-11-30	Direccion 334	1
335	Persona 335	CC335	persona335@mail.com	300000335	1980-12-01	Direccion 335	1
336	Persona 336	CC336	persona336@mail.com	300000336	1980-12-02	Direccion 336	1
337	Persona 337	CC337	persona337@mail.com	300000337	1980-12-03	Direccion 337	1
338	Persona 338	CC338	persona338@mail.com	300000338	1980-12-04	Direccion 338	1
339	Persona 339	CC339	persona339@mail.com	300000339	1980-12-05	Direccion 339	1
340	Persona 340	CC340	persona340@mail.com	300000340	1980-12-06	Direccion 340	1
341	Persona 341	CC341	persona341@mail.com	300000341	1980-12-07	Direccion 341	1
342	Persona 342	CC342	persona342@mail.com	300000342	1980-12-08	Direccion 342	1
343	Persona 343	CC343	persona343@mail.com	300000343	1980-12-09	Direccion 343	1
344	Persona 344	CC344	persona344@mail.com	300000344	1980-12-10	Direccion 344	1
345	Persona 345	CC345	persona345@mail.com	300000345	1980-12-11	Direccion 345	1
346	Persona 346	CC346	persona346@mail.com	300000346	1980-12-12	Direccion 346	1
347	Persona 347	CC347	persona347@mail.com	300000347	1980-12-13	Direccion 347	1
348	Persona 348	CC348	persona348@mail.com	300000348	1980-12-14	Direccion 348	1
349	Persona 349	CC349	persona349@mail.com	300000349	1980-12-15	Direccion 349	1
350	Persona 350	CC350	persona350@mail.com	300000350	1980-12-16	Direccion 350	1
351	Persona 351	CC351	persona351@mail.com	300000351	1980-12-17	Direccion 351	1
352	Persona 352	CC352	persona352@mail.com	300000352	1980-12-18	Direccion 352	1
353	Persona 353	CC353	persona353@mail.com	300000353	1980-12-19	Direccion 353	1
354	Persona 354	CC354	persona354@mail.com	300000354	1980-12-20	Direccion 354	1
355	Persona 355	CC355	persona355@mail.com	300000355	1980-12-21	Direccion 355	1
356	Persona 356	CC356	persona356@mail.com	300000356	1980-12-22	Direccion 356	1
357	Persona 357	CC357	persona357@mail.com	300000357	1980-12-23	Direccion 357	1
358	Persona 358	CC358	persona358@mail.com	300000358	1980-12-24	Direccion 358	1
359	Persona 359	CC359	persona359@mail.com	300000359	1980-12-25	Direccion 359	1
360	Persona 360	CC360	persona360@mail.com	300000360	1980-12-26	Direccion 360	1
361	Persona 361	CC361	persona361@mail.com	300000361	1980-12-27	Direccion 361	1
362	Persona 362	CC362	persona362@mail.com	300000362	1980-12-28	Direccion 362	1
363	Persona 363	CC363	persona363@mail.com	300000363	1980-12-29	Direccion 363	1
364	Persona 364	CC364	persona364@mail.com	300000364	1980-12-30	Direccion 364	1
365	Persona 365	CC365	persona365@mail.com	300000365	1980-12-31	Direccion 365	1
366	Persona 366	CC366	persona366@mail.com	300000366	1981-01-01	Direccion 366	1
367	Persona 367	CC367	persona367@mail.com	300000367	1981-01-02	Direccion 367	1
368	Persona 368	CC368	persona368@mail.com	300000368	1981-01-03	Direccion 368	1
369	Persona 369	CC369	persona369@mail.com	300000369	1981-01-04	Direccion 369	1
370	Persona 370	CC370	persona370@mail.com	300000370	1981-01-05	Direccion 370	1
371	Persona 371	CC371	persona371@mail.com	300000371	1981-01-06	Direccion 371	1
372	Persona 372	CC372	persona372@mail.com	300000372	1981-01-07	Direccion 372	1
373	Persona 373	CC373	persona373@mail.com	300000373	1981-01-08	Direccion 373	1
374	Persona 374	CC374	persona374@mail.com	300000374	1981-01-09	Direccion 374	1
375	Persona 375	CC375	persona375@mail.com	300000375	1981-01-10	Direccion 375	1
376	Persona 376	CC376	persona376@mail.com	300000376	1981-01-11	Direccion 376	1
377	Persona 377	CC377	persona377@mail.com	300000377	1981-01-12	Direccion 377	1
378	Persona 378	CC378	persona378@mail.com	300000378	1981-01-13	Direccion 378	1
379	Persona 379	CC379	persona379@mail.com	300000379	1981-01-14	Direccion 379	1
380	Persona 380	CC380	persona380@mail.com	300000380	1981-01-15	Direccion 380	1
381	Persona 381	CC381	persona381@mail.com	300000381	1981-01-16	Direccion 381	1
382	Persona 382	CC382	persona382@mail.com	300000382	1981-01-17	Direccion 382	1
383	Persona 383	CC383	persona383@mail.com	300000383	1981-01-18	Direccion 383	1
384	Persona 384	CC384	persona384@mail.com	300000384	1981-01-19	Direccion 384	1
385	Persona 385	CC385	persona385@mail.com	300000385	1981-01-20	Direccion 385	1
386	Persona 386	CC386	persona386@mail.com	300000386	1981-01-21	Direccion 386	1
387	Persona 387	CC387	persona387@mail.com	300000387	1981-01-22	Direccion 387	1
388	Persona 388	CC388	persona388@mail.com	300000388	1981-01-23	Direccion 388	1
389	Persona 389	CC389	persona389@mail.com	300000389	1981-01-24	Direccion 389	1
390	Persona 390	CC390	persona390@mail.com	300000390	1981-01-25	Direccion 390	1
391	Persona 391	CC391	persona391@mail.com	300000391	1981-01-26	Direccion 391	1
392	Persona 392	CC392	persona392@mail.com	300000392	1981-01-27	Direccion 392	1
393	Persona 393	CC393	persona393@mail.com	300000393	1981-01-28	Direccion 393	1
394	Persona 394	CC394	persona394@mail.com	300000394	1981-01-29	Direccion 394	1
395	Persona 395	CC395	persona395@mail.com	300000395	1981-01-30	Direccion 395	1
396	Persona 396	CC396	persona396@mail.com	300000396	1981-01-31	Direccion 396	1
397	Persona 397	CC397	persona397@mail.com	300000397	1981-02-01	Direccion 397	1
398	Persona 398	CC398	persona398@mail.com	300000398	1981-02-02	Direccion 398	1
399	Persona 399	CC399	persona399@mail.com	300000399	1981-02-03	Direccion 399	1
400	Persona 400	CC400	persona400@mail.com	300000400	1981-02-04	Direccion 400	1
401	Persona 401	CC401	persona401@mail.com	300000401	1981-02-05	Direccion 401	1
402	Persona 402	CC402	persona402@mail.com	300000402	1981-02-06	Direccion 402	1
403	Persona 403	CC403	persona403@mail.com	300000403	1981-02-07	Direccion 403	1
404	Persona 404	CC404	persona404@mail.com	300000404	1981-02-08	Direccion 404	1
405	Persona 405	CC405	persona405@mail.com	300000405	1981-02-09	Direccion 405	1
406	Persona 406	CC406	persona406@mail.com	300000406	1981-02-10	Direccion 406	1
407	Persona 407	CC407	persona407@mail.com	300000407	1981-02-11	Direccion 407	1
408	Persona 408	CC408	persona408@mail.com	300000408	1981-02-12	Direccion 408	1
409	Persona 409	CC409	persona409@mail.com	300000409	1981-02-13	Direccion 409	1
410	Persona 410	CC410	persona410@mail.com	300000410	1981-02-14	Direccion 410	1
411	Persona 411	CC411	persona411@mail.com	300000411	1981-02-15	Direccion 411	1
412	Persona 412	CC412	persona412@mail.com	300000412	1981-02-16	Direccion 412	1
413	Persona 413	CC413	persona413@mail.com	300000413	1981-02-17	Direccion 413	1
414	Persona 414	CC414	persona414@mail.com	300000414	1981-02-18	Direccion 414	1
415	Persona 415	CC415	persona415@mail.com	300000415	1981-02-19	Direccion 415	1
416	Persona 416	CC416	persona416@mail.com	300000416	1981-02-20	Direccion 416	1
417	Persona 417	CC417	persona417@mail.com	300000417	1981-02-21	Direccion 417	1
418	Persona 418	CC418	persona418@mail.com	300000418	1981-02-22	Direccion 418	1
419	Persona 419	CC419	persona419@mail.com	300000419	1981-02-23	Direccion 419	1
420	Persona 420	CC420	persona420@mail.com	300000420	1981-02-24	Direccion 420	1
421	Persona 421	CC421	persona421@mail.com	300000421	1981-02-25	Direccion 421	1
422	Persona 422	CC422	persona422@mail.com	300000422	1981-02-26	Direccion 422	1
423	Persona 423	CC423	persona423@mail.com	300000423	1981-02-27	Direccion 423	1
424	Persona 424	CC424	persona424@mail.com	300000424	1981-02-28	Direccion 424	1
425	Persona 425	CC425	persona425@mail.com	300000425	1981-03-01	Direccion 425	1
426	Persona 426	CC426	persona426@mail.com	300000426	1981-03-02	Direccion 426	1
427	Persona 427	CC427	persona427@mail.com	300000427	1981-03-03	Direccion 427	1
428	Persona 428	CC428	persona428@mail.com	300000428	1981-03-04	Direccion 428	1
429	Persona 429	CC429	persona429@mail.com	300000429	1981-03-05	Direccion 429	1
430	Persona 430	CC430	persona430@mail.com	300000430	1981-03-06	Direccion 430	1
431	Persona 431	CC431	persona431@mail.com	300000431	1981-03-07	Direccion 431	1
432	Persona 432	CC432	persona432@mail.com	300000432	1981-03-08	Direccion 432	1
433	Persona 433	CC433	persona433@mail.com	300000433	1981-03-09	Direccion 433	1
434	Persona 434	CC434	persona434@mail.com	300000434	1981-03-10	Direccion 434	1
435	Persona 435	CC435	persona435@mail.com	300000435	1981-03-11	Direccion 435	1
436	Persona 436	CC436	persona436@mail.com	300000436	1981-03-12	Direccion 436	1
437	Persona 437	CC437	persona437@mail.com	300000437	1981-03-13	Direccion 437	1
438	Persona 438	CC438	persona438@mail.com	300000438	1981-03-14	Direccion 438	1
439	Persona 439	CC439	persona439@mail.com	300000439	1981-03-15	Direccion 439	1
440	Persona 440	CC440	persona440@mail.com	300000440	1981-03-16	Direccion 440	1
441	Persona 441	CC441	persona441@mail.com	300000441	1981-03-17	Direccion 441	1
442	Persona 442	CC442	persona442@mail.com	300000442	1981-03-18	Direccion 442	1
443	Persona 443	CC443	persona443@mail.com	300000443	1981-03-19	Direccion 443	1
444	Persona 444	CC444	persona444@mail.com	300000444	1981-03-20	Direccion 444	1
445	Persona 445	CC445	persona445@mail.com	300000445	1981-03-21	Direccion 445	1
446	Persona 446	CC446	persona446@mail.com	300000446	1981-03-22	Direccion 446	1
447	Persona 447	CC447	persona447@mail.com	300000447	1981-03-23	Direccion 447	1
448	Persona 448	CC448	persona448@mail.com	300000448	1981-03-24	Direccion 448	1
449	Persona 449	CC449	persona449@mail.com	300000449	1981-03-25	Direccion 449	1
450	Persona 450	CC450	persona450@mail.com	300000450	1981-03-26	Direccion 450	1
451	Persona 451	CC451	persona451@mail.com	300000451	1981-03-27	Direccion 451	1
452	Persona 452	CC452	persona452@mail.com	300000452	1981-03-28	Direccion 452	1
453	Persona 453	CC453	persona453@mail.com	300000453	1981-03-29	Direccion 453	1
454	Persona 454	CC454	persona454@mail.com	300000454	1981-03-30	Direccion 454	1
455	Persona 455	CC455	persona455@mail.com	300000455	1981-03-31	Direccion 455	1
456	Persona 456	CC456	persona456@mail.com	300000456	1981-04-01	Direccion 456	1
457	Persona 457	CC457	persona457@mail.com	300000457	1981-04-02	Direccion 457	1
458	Persona 458	CC458	persona458@mail.com	300000458	1981-04-03	Direccion 458	1
459	Persona 459	CC459	persona459@mail.com	300000459	1981-04-04	Direccion 459	1
460	Persona 460	CC460	persona460@mail.com	300000460	1981-04-05	Direccion 460	1
461	Persona 461	CC461	persona461@mail.com	300000461	1981-04-06	Direccion 461	1
462	Persona 462	CC462	persona462@mail.com	300000462	1981-04-07	Direccion 462	1
463	Persona 463	CC463	persona463@mail.com	300000463	1981-04-08	Direccion 463	1
464	Persona 464	CC464	persona464@mail.com	300000464	1981-04-09	Direccion 464	1
465	Persona 465	CC465	persona465@mail.com	300000465	1981-04-10	Direccion 465	1
466	Persona 466	CC466	persona466@mail.com	300000466	1981-04-11	Direccion 466	1
467	Persona 467	CC467	persona467@mail.com	300000467	1981-04-12	Direccion 467	1
468	Persona 468	CC468	persona468@mail.com	300000468	1981-04-13	Direccion 468	1
469	Persona 469	CC469	persona469@mail.com	300000469	1981-04-14	Direccion 469	1
470	Persona 470	CC470	persona470@mail.com	300000470	1981-04-15	Direccion 470	1
471	Persona 471	CC471	persona471@mail.com	300000471	1981-04-16	Direccion 471	1
472	Persona 472	CC472	persona472@mail.com	300000472	1981-04-17	Direccion 472	1
473	Persona 473	CC473	persona473@mail.com	300000473	1981-04-18	Direccion 473	1
474	Persona 474	CC474	persona474@mail.com	300000474	1981-04-19	Direccion 474	1
475	Persona 475	CC475	persona475@mail.com	300000475	1981-04-20	Direccion 475	1
476	Persona 476	CC476	persona476@mail.com	300000476	1981-04-21	Direccion 476	1
477	Persona 477	CC477	persona477@mail.com	300000477	1981-04-22	Direccion 477	1
478	Persona 478	CC478	persona478@mail.com	300000478	1981-04-23	Direccion 478	1
479	Persona 479	CC479	persona479@mail.com	300000479	1981-04-24	Direccion 479	1
480	Persona 480	CC480	persona480@mail.com	300000480	1981-04-25	Direccion 480	1
481	Persona 481	CC481	persona481@mail.com	300000481	1981-04-26	Direccion 481	1
482	Persona 482	CC482	persona482@mail.com	300000482	1981-04-27	Direccion 482	1
483	Persona 483	CC483	persona483@mail.com	300000483	1981-04-28	Direccion 483	1
484	Persona 484	CC484	persona484@mail.com	300000484	1981-04-29	Direccion 484	1
485	Persona 485	CC485	persona485@mail.com	300000485	1981-04-30	Direccion 485	1
486	Persona 486	CC486	persona486@mail.com	300000486	1981-05-01	Direccion 486	1
487	Persona 487	CC487	persona487@mail.com	300000487	1981-05-02	Direccion 487	1
488	Persona 488	CC488	persona488@mail.com	300000488	1981-05-03	Direccion 488	1
489	Persona 489	CC489	persona489@mail.com	300000489	1981-05-04	Direccion 489	1
490	Persona 490	CC490	persona490@mail.com	300000490	1981-05-05	Direccion 490	1
491	Persona 491	CC491	persona491@mail.com	300000491	1981-05-06	Direccion 491	1
492	Persona 492	CC492	persona492@mail.com	300000492	1981-05-07	Direccion 492	1
493	Persona 493	CC493	persona493@mail.com	300000493	1981-05-08	Direccion 493	1
494	Persona 494	CC494	persona494@mail.com	300000494	1981-05-09	Direccion 494	1
495	Persona 495	CC495	persona495@mail.com	300000495	1981-05-10	Direccion 495	1
496	Persona 496	CC496	persona496@mail.com	300000496	1981-05-11	Direccion 496	1
497	Persona 497	CC497	persona497@mail.com	300000497	1981-05-12	Direccion 497	1
498	Persona 498	CC498	persona498@mail.com	300000498	1981-05-13	Direccion 498	1
499	Persona 499	CC499	persona499@mail.com	300000499	1981-05-14	Direccion 499	1
500	Persona 500	CC500	persona500@mail.com	300000500	1981-05-15	Direccion 500	1
501	Persona 501	CC501	persona501@mail.com	300000501	1981-05-16	Direccion 501	1
502	Persona 502	CC502	persona502@mail.com	300000502	1981-05-17	Direccion 502	1
503	Persona 503	CC503	persona503@mail.com	300000503	1981-05-18	Direccion 503	1
504	Persona 504	CC504	persona504@mail.com	300000504	1981-05-19	Direccion 504	1
505	Persona 505	CC505	persona505@mail.com	300000505	1981-05-20	Direccion 505	1
506	Persona 506	CC506	persona506@mail.com	300000506	1981-05-21	Direccion 506	1
507	Persona 507	CC507	persona507@mail.com	300000507	1981-05-22	Direccion 507	1
508	Persona 508	CC508	persona508@mail.com	300000508	1981-05-23	Direccion 508	1
509	Persona 509	CC509	persona509@mail.com	300000509	1981-05-24	Direccion 509	1
510	Persona 510	CC510	persona510@mail.com	300000510	1981-05-25	Direccion 510	1
511	Persona 511	CC511	persona511@mail.com	300000511	1981-05-26	Direccion 511	1
512	Persona 512	CC512	persona512@mail.com	300000512	1981-05-27	Direccion 512	1
513	Persona 513	CC513	persona513@mail.com	300000513	1981-05-28	Direccion 513	1
514	Persona 514	CC514	persona514@mail.com	300000514	1981-05-29	Direccion 514	1
515	Persona 515	CC515	persona515@mail.com	300000515	1981-05-30	Direccion 515	1
516	Persona 516	CC516	persona516@mail.com	300000516	1981-05-31	Direccion 516	1
517	Persona 517	CC517	persona517@mail.com	300000517	1981-06-01	Direccion 517	1
518	Persona 518	CC518	persona518@mail.com	300000518	1981-06-02	Direccion 518	1
519	Persona 519	CC519	persona519@mail.com	300000519	1981-06-03	Direccion 519	1
520	Persona 520	CC520	persona520@mail.com	300000520	1981-06-04	Direccion 520	1
521	Persona 521	CC521	persona521@mail.com	300000521	1981-06-05	Direccion 521	1
522	Persona 522	CC522	persona522@mail.com	300000522	1981-06-06	Direccion 522	1
523	Persona 523	CC523	persona523@mail.com	300000523	1981-06-07	Direccion 523	1
524	Persona 524	CC524	persona524@mail.com	300000524	1981-06-08	Direccion 524	1
525	Persona 525	CC525	persona525@mail.com	300000525	1981-06-09	Direccion 525	1
526	Persona 526	CC526	persona526@mail.com	300000526	1981-06-10	Direccion 526	1
527	Persona 527	CC527	persona527@mail.com	300000527	1981-06-11	Direccion 527	1
528	Persona 528	CC528	persona528@mail.com	300000528	1981-06-12	Direccion 528	1
529	Persona 529	CC529	persona529@mail.com	300000529	1981-06-13	Direccion 529	1
530	Persona 530	CC530	persona530@mail.com	300000530	1981-06-14	Direccion 530	1
531	Persona 531	CC531	persona531@mail.com	300000531	1981-06-15	Direccion 531	1
532	Persona 532	CC532	persona532@mail.com	300000532	1981-06-16	Direccion 532	1
533	Persona 533	CC533	persona533@mail.com	300000533	1981-06-17	Direccion 533	1
534	Persona 534	CC534	persona534@mail.com	300000534	1981-06-18	Direccion 534	1
535	Persona 535	CC535	persona535@mail.com	300000535	1981-06-19	Direccion 535	1
536	Persona 536	CC536	persona536@mail.com	300000536	1981-06-20	Direccion 536	1
537	Persona 537	CC537	persona537@mail.com	300000537	1981-06-21	Direccion 537	1
538	Persona 538	CC538	persona538@mail.com	300000538	1981-06-22	Direccion 538	1
539	Persona 539	CC539	persona539@mail.com	300000539	1981-06-23	Direccion 539	1
540	Persona 540	CC540	persona540@mail.com	300000540	1981-06-24	Direccion 540	1
541	Persona 541	CC541	persona541@mail.com	300000541	1981-06-25	Direccion 541	1
542	Persona 542	CC542	persona542@mail.com	300000542	1981-06-26	Direccion 542	1
543	Persona 543	CC543	persona543@mail.com	300000543	1981-06-27	Direccion 543	1
544	Persona 544	CC544	persona544@mail.com	300000544	1981-06-28	Direccion 544	1
545	Persona 545	CC545	persona545@mail.com	300000545	1981-06-29	Direccion 545	1
546	Persona 546	CC546	persona546@mail.com	300000546	1981-06-30	Direccion 546	1
547	Persona 547	CC547	persona547@mail.com	300000547	1981-07-01	Direccion 547	1
548	Persona 548	CC548	persona548@mail.com	300000548	1981-07-02	Direccion 548	1
549	Persona 549	CC549	persona549@mail.com	300000549	1981-07-03	Direccion 549	1
550	Persona 550	CC550	persona550@mail.com	300000550	1981-07-04	Direccion 550	1
551	Persona 551	CC551	persona551@mail.com	300000551	1981-07-05	Direccion 551	1
552	Persona 552	CC552	persona552@mail.com	300000552	1981-07-06	Direccion 552	1
553	Persona 553	CC553	persona553@mail.com	300000553	1981-07-07	Direccion 553	1
554	Persona 554	CC554	persona554@mail.com	300000554	1981-07-08	Direccion 554	1
555	Persona 555	CC555	persona555@mail.com	300000555	1981-07-09	Direccion 555	1
556	Persona 556	CC556	persona556@mail.com	300000556	1981-07-10	Direccion 556	1
557	Persona 557	CC557	persona557@mail.com	300000557	1981-07-11	Direccion 557	1
558	Persona 558	CC558	persona558@mail.com	300000558	1981-07-12	Direccion 558	1
559	Persona 559	CC559	persona559@mail.com	300000559	1981-07-13	Direccion 559	1
560	Persona 560	CC560	persona560@mail.com	300000560	1981-07-14	Direccion 560	1
561	Persona 561	CC561	persona561@mail.com	300000561	1981-07-15	Direccion 561	1
562	Persona 562	CC562	persona562@mail.com	300000562	1981-07-16	Direccion 562	1
563	Persona 563	CC563	persona563@mail.com	300000563	1981-07-17	Direccion 563	1
564	Persona 564	CC564	persona564@mail.com	300000564	1981-07-18	Direccion 564	1
565	Persona 565	CC565	persona565@mail.com	300000565	1981-07-19	Direccion 565	1
566	Persona 566	CC566	persona566@mail.com	300000566	1981-07-20	Direccion 566	1
567	Persona 567	CC567	persona567@mail.com	300000567	1981-07-21	Direccion 567	1
568	Persona 568	CC568	persona568@mail.com	300000568	1981-07-22	Direccion 568	1
569	Persona 569	CC569	persona569@mail.com	300000569	1981-07-23	Direccion 569	1
570	Persona 570	CC570	persona570@mail.com	300000570	1981-07-24	Direccion 570	1
571	Persona 571	CC571	persona571@mail.com	300000571	1981-07-25	Direccion 571	1
572	Persona 572	CC572	persona572@mail.com	300000572	1981-07-26	Direccion 572	1
573	Persona 573	CC573	persona573@mail.com	300000573	1981-07-27	Direccion 573	1
574	Persona 574	CC574	persona574@mail.com	300000574	1981-07-28	Direccion 574	1
575	Persona 575	CC575	persona575@mail.com	300000575	1981-07-29	Direccion 575	1
576	Persona 576	CC576	persona576@mail.com	300000576	1981-07-30	Direccion 576	1
577	Persona 577	CC577	persona577@mail.com	300000577	1981-07-31	Direccion 577	1
578	Persona 578	CC578	persona578@mail.com	300000578	1981-08-01	Direccion 578	1
579	Persona 579	CC579	persona579@mail.com	300000579	1981-08-02	Direccion 579	1
580	Persona 580	CC580	persona580@mail.com	300000580	1981-08-03	Direccion 580	1
581	Persona 581	CC581	persona581@mail.com	300000581	1981-08-04	Direccion 581	1
582	Persona 582	CC582	persona582@mail.com	300000582	1981-08-05	Direccion 582	1
583	Persona 583	CC583	persona583@mail.com	300000583	1981-08-06	Direccion 583	1
584	Persona 584	CC584	persona584@mail.com	300000584	1981-08-07	Direccion 584	1
585	Persona 585	CC585	persona585@mail.com	300000585	1981-08-08	Direccion 585	1
586	Persona 586	CC586	persona586@mail.com	300000586	1981-08-09	Direccion 586	1
587	Persona 587	CC587	persona587@mail.com	300000587	1981-08-10	Direccion 587	1
588	Persona 588	CC588	persona588@mail.com	300000588	1981-08-11	Direccion 588	1
589	Persona 589	CC589	persona589@mail.com	300000589	1981-08-12	Direccion 589	1
590	Persona 590	CC590	persona590@mail.com	300000590	1981-08-13	Direccion 590	1
591	Persona 591	CC591	persona591@mail.com	300000591	1981-08-14	Direccion 591	1
592	Persona 592	CC592	persona592@mail.com	300000592	1981-08-15	Direccion 592	1
593	Persona 593	CC593	persona593@mail.com	300000593	1981-08-16	Direccion 593	1
594	Persona 594	CC594	persona594@mail.com	300000594	1981-08-17	Direccion 594	1
595	Persona 595	CC595	persona595@mail.com	300000595	1981-08-18	Direccion 595	1
596	Persona 596	CC596	persona596@mail.com	300000596	1981-08-19	Direccion 596	1
597	Persona 597	CC597	persona597@mail.com	300000597	1981-08-20	Direccion 597	1
598	Persona 598	CC598	persona598@mail.com	300000598	1981-08-21	Direccion 598	1
599	Persona 599	CC599	persona599@mail.com	300000599	1981-08-22	Direccion 599	1
600	Persona 600	CC600	persona600@mail.com	300000600	1981-08-23	Direccion 600	1
601	Persona 601	CC601	persona601@mail.com	300000601	1981-08-24	Direccion 601	1
602	Persona 602	CC602	persona602@mail.com	300000602	1981-08-25	Direccion 602	1
603	Persona 603	CC603	persona603@mail.com	300000603	1981-08-26	Direccion 603	1
604	Persona 604	CC604	persona604@mail.com	300000604	1981-08-27	Direccion 604	1
605	Persona 605	CC605	persona605@mail.com	300000605	1981-08-28	Direccion 605	1
606	Persona 606	CC606	persona606@mail.com	300000606	1981-08-29	Direccion 606	1
607	Persona 607	CC607	persona607@mail.com	300000607	1981-08-30	Direccion 607	1
608	Persona 608	CC608	persona608@mail.com	300000608	1981-08-31	Direccion 608	1
609	Persona 609	CC609	persona609@mail.com	300000609	1981-09-01	Direccion 609	1
610	Persona 610	CC610	persona610@mail.com	300000610	1981-09-02	Direccion 610	1
611	Persona 611	CC611	persona611@mail.com	300000611	1981-09-03	Direccion 611	1
612	Persona 612	CC612	persona612@mail.com	300000612	1981-09-04	Direccion 612	1
613	Persona 613	CC613	persona613@mail.com	300000613	1981-09-05	Direccion 613	1
614	Persona 614	CC614	persona614@mail.com	300000614	1981-09-06	Direccion 614	1
615	Persona 615	CC615	persona615@mail.com	300000615	1981-09-07	Direccion 615	1
616	Persona 616	CC616	persona616@mail.com	300000616	1981-09-08	Direccion 616	1
617	Persona 617	CC617	persona617@mail.com	300000617	1981-09-09	Direccion 617	1
618	Persona 618	CC618	persona618@mail.com	300000618	1981-09-10	Direccion 618	1
619	Persona 619	CC619	persona619@mail.com	300000619	1981-09-11	Direccion 619	1
620	Persona 620	CC620	persona620@mail.com	300000620	1981-09-12	Direccion 620	1
621	Persona 621	CC621	persona621@mail.com	300000621	1981-09-13	Direccion 621	1
622	Persona 622	CC622	persona622@mail.com	300000622	1981-09-14	Direccion 622	1
623	Persona 623	CC623	persona623@mail.com	300000623	1981-09-15	Direccion 623	1
624	Persona 624	CC624	persona624@mail.com	300000624	1981-09-16	Direccion 624	1
625	Persona 625	CC625	persona625@mail.com	300000625	1981-09-17	Direccion 625	1
626	Persona 626	CC626	persona626@mail.com	300000626	1981-09-18	Direccion 626	1
627	Persona 627	CC627	persona627@mail.com	300000627	1981-09-19	Direccion 627	1
628	Persona 628	CC628	persona628@mail.com	300000628	1981-09-20	Direccion 628	1
629	Persona 629	CC629	persona629@mail.com	300000629	1981-09-21	Direccion 629	1
630	Persona 630	CC630	persona630@mail.com	300000630	1981-09-22	Direccion 630	1
631	Persona 631	CC631	persona631@mail.com	300000631	1981-09-23	Direccion 631	1
632	Persona 632	CC632	persona632@mail.com	300000632	1981-09-24	Direccion 632	1
633	Persona 633	CC633	persona633@mail.com	300000633	1981-09-25	Direccion 633	1
634	Persona 634	CC634	persona634@mail.com	300000634	1981-09-26	Direccion 634	1
635	Persona 635	CC635	persona635@mail.com	300000635	1981-09-27	Direccion 635	1
636	Persona 636	CC636	persona636@mail.com	300000636	1981-09-28	Direccion 636	1
637	Persona 637	CC637	persona637@mail.com	300000637	1981-09-29	Direccion 637	1
638	Persona 638	CC638	persona638@mail.com	300000638	1981-09-30	Direccion 638	1
639	Persona 639	CC639	persona639@mail.com	300000639	1981-10-01	Direccion 639	1
640	Persona 640	CC640	persona640@mail.com	300000640	1981-10-02	Direccion 640	1
641	Persona 641	CC641	persona641@mail.com	300000641	1981-10-03	Direccion 641	1
642	Persona 642	CC642	persona642@mail.com	300000642	1981-10-04	Direccion 642	1
643	Persona 643	CC643	persona643@mail.com	300000643	1981-10-05	Direccion 643	1
644	Persona 644	CC644	persona644@mail.com	300000644	1981-10-06	Direccion 644	1
645	Persona 645	CC645	persona645@mail.com	300000645	1981-10-07	Direccion 645	1
646	Persona 646	CC646	persona646@mail.com	300000646	1981-10-08	Direccion 646	1
647	Persona 647	CC647	persona647@mail.com	300000647	1981-10-09	Direccion 647	1
648	Persona 648	CC648	persona648@mail.com	300000648	1981-10-10	Direccion 648	1
649	Persona 649	CC649	persona649@mail.com	300000649	1981-10-11	Direccion 649	1
650	Persona 650	CC650	persona650@mail.com	300000650	1981-10-12	Direccion 650	1
651	Persona 651	CC651	persona651@mail.com	300000651	1981-10-13	Direccion 651	1
652	Persona 652	CC652	persona652@mail.com	300000652	1981-10-14	Direccion 652	1
653	Persona 653	CC653	persona653@mail.com	300000653	1981-10-15	Direccion 653	1
654	Persona 654	CC654	persona654@mail.com	300000654	1981-10-16	Direccion 654	1
655	Persona 655	CC655	persona655@mail.com	300000655	1981-10-17	Direccion 655	1
656	Persona 656	CC656	persona656@mail.com	300000656	1981-10-18	Direccion 656	1
657	Persona 657	CC657	persona657@mail.com	300000657	1981-10-19	Direccion 657	1
658	Persona 658	CC658	persona658@mail.com	300000658	1981-10-20	Direccion 658	1
659	Persona 659	CC659	persona659@mail.com	300000659	1981-10-21	Direccion 659	1
660	Persona 660	CC660	persona660@mail.com	300000660	1981-10-22	Direccion 660	1
661	Persona 661	CC661	persona661@mail.com	300000661	1981-10-23	Direccion 661	1
662	Persona 662	CC662	persona662@mail.com	300000662	1981-10-24	Direccion 662	1
663	Persona 663	CC663	persona663@mail.com	300000663	1981-10-25	Direccion 663	1
664	Persona 664	CC664	persona664@mail.com	300000664	1981-10-26	Direccion 664	1
665	Persona 665	CC665	persona665@mail.com	300000665	1981-10-27	Direccion 665	1
666	Persona 666	CC666	persona666@mail.com	300000666	1981-10-28	Direccion 666	1
667	Persona 667	CC667	persona667@mail.com	300000667	1981-10-29	Direccion 667	1
668	Persona 668	CC668	persona668@mail.com	300000668	1981-10-30	Direccion 668	1
669	Persona 669	CC669	persona669@mail.com	300000669	1981-10-31	Direccion 669	1
670	Persona 670	CC670	persona670@mail.com	300000670	1981-11-01	Direccion 670	1
671	Persona 671	CC671	persona671@mail.com	300000671	1981-11-02	Direccion 671	1
672	Persona 672	CC672	persona672@mail.com	300000672	1981-11-03	Direccion 672	1
673	Persona 673	CC673	persona673@mail.com	300000673	1981-11-04	Direccion 673	1
674	Persona 674	CC674	persona674@mail.com	300000674	1981-11-05	Direccion 674	1
675	Persona 675	CC675	persona675@mail.com	300000675	1981-11-06	Direccion 675	1
676	Persona 676	CC676	persona676@mail.com	300000676	1981-11-07	Direccion 676	1
677	Persona 677	CC677	persona677@mail.com	300000677	1981-11-08	Direccion 677	1
678	Persona 678	CC678	persona678@mail.com	300000678	1981-11-09	Direccion 678	1
679	Persona 679	CC679	persona679@mail.com	300000679	1981-11-10	Direccion 679	1
680	Persona 680	CC680	persona680@mail.com	300000680	1981-11-11	Direccion 680	1
681	Persona 681	CC681	persona681@mail.com	300000681	1981-11-12	Direccion 681	1
682	Persona 682	CC682	persona682@mail.com	300000682	1981-11-13	Direccion 682	1
683	Persona 683	CC683	persona683@mail.com	300000683	1981-11-14	Direccion 683	1
684	Persona 684	CC684	persona684@mail.com	300000684	1981-11-15	Direccion 684	1
685	Persona 685	CC685	persona685@mail.com	300000685	1981-11-16	Direccion 685	1
686	Persona 686	CC686	persona686@mail.com	300000686	1981-11-17	Direccion 686	1
687	Persona 687	CC687	persona687@mail.com	300000687	1981-11-18	Direccion 687	1
688	Persona 688	CC688	persona688@mail.com	300000688	1981-11-19	Direccion 688	1
689	Persona 689	CC689	persona689@mail.com	300000689	1981-11-20	Direccion 689	1
690	Persona 690	CC690	persona690@mail.com	300000690	1981-11-21	Direccion 690	1
691	Persona 691	CC691	persona691@mail.com	300000691	1981-11-22	Direccion 691	1
692	Persona 692	CC692	persona692@mail.com	300000692	1981-11-23	Direccion 692	1
693	Persona 693	CC693	persona693@mail.com	300000693	1981-11-24	Direccion 693	1
694	Persona 694	CC694	persona694@mail.com	300000694	1981-11-25	Direccion 694	1
695	Persona 695	CC695	persona695@mail.com	300000695	1981-11-26	Direccion 695	1
696	Persona 696	CC696	persona696@mail.com	300000696	1981-11-27	Direccion 696	1
697	Persona 697	CC697	persona697@mail.com	300000697	1981-11-28	Direccion 697	1
698	Persona 698	CC698	persona698@mail.com	300000698	1981-11-29	Direccion 698	1
699	Persona 699	CC699	persona699@mail.com	300000699	1981-11-30	Direccion 699	1
700	Persona 700	CC700	persona700@mail.com	300000700	1981-12-01	Direccion 700	1
701	Persona 701	CC701	persona701@mail.com	300000701	1981-12-02	Direccion 701	1
702	Persona 702	CC702	persona702@mail.com	300000702	1981-12-03	Direccion 702	1
703	Persona 703	CC703	persona703@mail.com	300000703	1981-12-04	Direccion 703	1
704	Persona 704	CC704	persona704@mail.com	300000704	1981-12-05	Direccion 704	1
705	Persona 705	CC705	persona705@mail.com	300000705	1981-12-06	Direccion 705	1
706	Persona 706	CC706	persona706@mail.com	300000706	1981-12-07	Direccion 706	1
707	Persona 707	CC707	persona707@mail.com	300000707	1981-12-08	Direccion 707	1
708	Persona 708	CC708	persona708@mail.com	300000708	1981-12-09	Direccion 708	1
709	Persona 709	CC709	persona709@mail.com	300000709	1981-12-10	Direccion 709	1
710	Persona 710	CC710	persona710@mail.com	300000710	1981-12-11	Direccion 710	1
711	Persona 711	CC711	persona711@mail.com	300000711	1981-12-12	Direccion 711	1
712	Persona 712	CC712	persona712@mail.com	300000712	1981-12-13	Direccion 712	1
713	Persona 713	CC713	persona713@mail.com	300000713	1981-12-14	Direccion 713	1
714	Persona 714	CC714	persona714@mail.com	300000714	1981-12-15	Direccion 714	1
715	Persona 715	CC715	persona715@mail.com	300000715	1981-12-16	Direccion 715	1
716	Persona 716	CC716	persona716@mail.com	300000716	1981-12-17	Direccion 716	1
717	Persona 717	CC717	persona717@mail.com	300000717	1981-12-18	Direccion 717	1
718	Persona 718	CC718	persona718@mail.com	300000718	1981-12-19	Direccion 718	1
719	Persona 719	CC719	persona719@mail.com	300000719	1981-12-20	Direccion 719	1
720	Persona 720	CC720	persona720@mail.com	300000720	1981-12-21	Direccion 720	1
721	Persona 721	CC721	persona721@mail.com	300000721	1981-12-22	Direccion 721	1
722	Persona 722	CC722	persona722@mail.com	300000722	1981-12-23	Direccion 722	1
723	Persona 723	CC723	persona723@mail.com	300000723	1981-12-24	Direccion 723	1
724	Persona 724	CC724	persona724@mail.com	300000724	1981-12-25	Direccion 724	1
725	Persona 725	CC725	persona725@mail.com	300000725	1981-12-26	Direccion 725	1
726	Persona 726	CC726	persona726@mail.com	300000726	1981-12-27	Direccion 726	1
727	Persona 727	CC727	persona727@mail.com	300000727	1981-12-28	Direccion 727	1
728	Persona 728	CC728	persona728@mail.com	300000728	1981-12-29	Direccion 728	1
729	Persona 729	CC729	persona729@mail.com	300000729	1981-12-30	Direccion 729	1
730	Persona 730	CC730	persona730@mail.com	300000730	1981-12-31	Direccion 730	1
731	Persona 731	CC731	persona731@mail.com	300000731	1982-01-01	Direccion 731	1
732	Persona 732	CC732	persona732@mail.com	300000732	1982-01-02	Direccion 732	1
733	Persona 733	CC733	persona733@mail.com	300000733	1982-01-03	Direccion 733	1
734	Persona 734	CC734	persona734@mail.com	300000734	1982-01-04	Direccion 734	1
735	Persona 735	CC735	persona735@mail.com	300000735	1982-01-05	Direccion 735	1
736	Persona 736	CC736	persona736@mail.com	300000736	1982-01-06	Direccion 736	1
737	Persona 737	CC737	persona737@mail.com	300000737	1982-01-07	Direccion 737	1
738	Persona 738	CC738	persona738@mail.com	300000738	1982-01-08	Direccion 738	1
739	Persona 739	CC739	persona739@mail.com	300000739	1982-01-09	Direccion 739	1
740	Persona 740	CC740	persona740@mail.com	300000740	1982-01-10	Direccion 740	1
741	Persona 741	CC741	persona741@mail.com	300000741	1982-01-11	Direccion 741	1
742	Persona 742	CC742	persona742@mail.com	300000742	1982-01-12	Direccion 742	1
743	Persona 743	CC743	persona743@mail.com	300000743	1982-01-13	Direccion 743	1
744	Persona 744	CC744	persona744@mail.com	300000744	1982-01-14	Direccion 744	1
745	Persona 745	CC745	persona745@mail.com	300000745	1982-01-15	Direccion 745	1
746	Persona 746	CC746	persona746@mail.com	300000746	1982-01-16	Direccion 746	1
747	Persona 747	CC747	persona747@mail.com	300000747	1982-01-17	Direccion 747	1
748	Persona 748	CC748	persona748@mail.com	300000748	1982-01-18	Direccion 748	1
749	Persona 749	CC749	persona749@mail.com	300000749	1982-01-19	Direccion 749	1
750	Persona 750	CC750	persona750@mail.com	300000750	1982-01-20	Direccion 750	1
751	Persona 751	CC751	persona751@mail.com	300000751	1982-01-21	Direccion 751	1
752	Persona 752	CC752	persona752@mail.com	300000752	1982-01-22	Direccion 752	1
753	Persona 753	CC753	persona753@mail.com	300000753	1982-01-23	Direccion 753	1
754	Persona 754	CC754	persona754@mail.com	300000754	1982-01-24	Direccion 754	1
755	Persona 755	CC755	persona755@mail.com	300000755	1982-01-25	Direccion 755	1
756	Persona 756	CC756	persona756@mail.com	300000756	1982-01-26	Direccion 756	1
757	Persona 757	CC757	persona757@mail.com	300000757	1982-01-27	Direccion 757	1
758	Persona 758	CC758	persona758@mail.com	300000758	1982-01-28	Direccion 758	1
759	Persona 759	CC759	persona759@mail.com	300000759	1982-01-29	Direccion 759	1
760	Persona 760	CC760	persona760@mail.com	300000760	1982-01-30	Direccion 760	1
761	Persona 761	CC761	persona761@mail.com	300000761	1982-01-31	Direccion 761	1
762	Persona 762	CC762	persona762@mail.com	300000762	1982-02-01	Direccion 762	1
763	Persona 763	CC763	persona763@mail.com	300000763	1982-02-02	Direccion 763	1
764	Persona 764	CC764	persona764@mail.com	300000764	1982-02-03	Direccion 764	1
765	Persona 765	CC765	persona765@mail.com	300000765	1982-02-04	Direccion 765	1
766	Persona 766	CC766	persona766@mail.com	300000766	1982-02-05	Direccion 766	1
767	Persona 767	CC767	persona767@mail.com	300000767	1982-02-06	Direccion 767	1
768	Persona 768	CC768	persona768@mail.com	300000768	1982-02-07	Direccion 768	1
769	Persona 769	CC769	persona769@mail.com	300000769	1982-02-08	Direccion 769	1
770	Persona 770	CC770	persona770@mail.com	300000770	1982-02-09	Direccion 770	1
771	Persona 771	CC771	persona771@mail.com	300000771	1982-02-10	Direccion 771	1
772	Persona 772	CC772	persona772@mail.com	300000772	1982-02-11	Direccion 772	1
773	Persona 773	CC773	persona773@mail.com	300000773	1982-02-12	Direccion 773	1
774	Persona 774	CC774	persona774@mail.com	300000774	1982-02-13	Direccion 774	1
775	Persona 775	CC775	persona775@mail.com	300000775	1982-02-14	Direccion 775	1
776	Persona 776	CC776	persona776@mail.com	300000776	1982-02-15	Direccion 776	1
777	Persona 777	CC777	persona777@mail.com	300000777	1982-02-16	Direccion 777	1
778	Persona 778	CC778	persona778@mail.com	300000778	1982-02-17	Direccion 778	1
779	Persona 779	CC779	persona779@mail.com	300000779	1982-02-18	Direccion 779	1
780	Persona 780	CC780	persona780@mail.com	300000780	1982-02-19	Direccion 780	1
781	Persona 781	CC781	persona781@mail.com	300000781	1982-02-20	Direccion 781	1
782	Persona 782	CC782	persona782@mail.com	300000782	1982-02-21	Direccion 782	1
783	Persona 783	CC783	persona783@mail.com	300000783	1982-02-22	Direccion 783	1
784	Persona 784	CC784	persona784@mail.com	300000784	1982-02-23	Direccion 784	1
785	Persona 785	CC785	persona785@mail.com	300000785	1982-02-24	Direccion 785	1
786	Persona 786	CC786	persona786@mail.com	300000786	1982-02-25	Direccion 786	1
787	Persona 787	CC787	persona787@mail.com	300000787	1982-02-26	Direccion 787	1
788	Persona 788	CC788	persona788@mail.com	300000788	1982-02-27	Direccion 788	1
789	Persona 789	CC789	persona789@mail.com	300000789	1982-02-28	Direccion 789	1
790	Persona 790	CC790	persona790@mail.com	300000790	1982-03-01	Direccion 790	1
791	Persona 791	CC791	persona791@mail.com	300000791	1982-03-02	Direccion 791	1
792	Persona 792	CC792	persona792@mail.com	300000792	1982-03-03	Direccion 792	1
793	Persona 793	CC793	persona793@mail.com	300000793	1982-03-04	Direccion 793	1
794	Persona 794	CC794	persona794@mail.com	300000794	1982-03-05	Direccion 794	1
795	Persona 795	CC795	persona795@mail.com	300000795	1982-03-06	Direccion 795	1
796	Persona 796	CC796	persona796@mail.com	300000796	1982-03-07	Direccion 796	1
797	Persona 797	CC797	persona797@mail.com	300000797	1982-03-08	Direccion 797	1
798	Persona 798	CC798	persona798@mail.com	300000798	1982-03-09	Direccion 798	1
799	Persona 799	CC799	persona799@mail.com	300000799	1982-03-10	Direccion 799	1
800	Persona 800	CC800	persona800@mail.com	300000800	1982-03-11	Direccion 800	1
801	Persona 801	CC801	persona801@mail.com	300000801	1982-03-12	Direccion 801	1
802	Persona 802	CC802	persona802@mail.com	300000802	1982-03-13	Direccion 802	1
803	Persona 803	CC803	persona803@mail.com	300000803	1982-03-14	Direccion 803	1
804	Persona 804	CC804	persona804@mail.com	300000804	1982-03-15	Direccion 804	1
805	Persona 805	CC805	persona805@mail.com	300000805	1982-03-16	Direccion 805	1
806	Persona 806	CC806	persona806@mail.com	300000806	1982-03-17	Direccion 806	1
807	Persona 807	CC807	persona807@mail.com	300000807	1982-03-18	Direccion 807	1
808	Persona 808	CC808	persona808@mail.com	300000808	1982-03-19	Direccion 808	1
809	Persona 809	CC809	persona809@mail.com	300000809	1982-03-20	Direccion 809	1
810	Persona 810	CC810	persona810@mail.com	300000810	1982-03-21	Direccion 810	1
811	Persona 811	CC811	persona811@mail.com	300000811	1982-03-22	Direccion 811	1
812	Persona 812	CC812	persona812@mail.com	300000812	1982-03-23	Direccion 812	1
813	Persona 813	CC813	persona813@mail.com	300000813	1982-03-24	Direccion 813	1
814	Persona 814	CC814	persona814@mail.com	300000814	1982-03-25	Direccion 814	1
815	Persona 815	CC815	persona815@mail.com	300000815	1982-03-26	Direccion 815	1
816	Persona 816	CC816	persona816@mail.com	300000816	1982-03-27	Direccion 816	1
817	Persona 817	CC817	persona817@mail.com	300000817	1982-03-28	Direccion 817	1
818	Persona 818	CC818	persona818@mail.com	300000818	1982-03-29	Direccion 818	1
819	Persona 819	CC819	persona819@mail.com	300000819	1982-03-30	Direccion 819	1
820	Persona 820	CC820	persona820@mail.com	300000820	1982-03-31	Direccion 820	1
821	Persona 821	CC821	persona821@mail.com	300000821	1982-04-01	Direccion 821	1
822	Persona 822	CC822	persona822@mail.com	300000822	1982-04-02	Direccion 822	1
823	Persona 823	CC823	persona823@mail.com	300000823	1982-04-03	Direccion 823	1
824	Persona 824	CC824	persona824@mail.com	300000824	1982-04-04	Direccion 824	1
825	Persona 825	CC825	persona825@mail.com	300000825	1982-04-05	Direccion 825	1
826	Persona 826	CC826	persona826@mail.com	300000826	1982-04-06	Direccion 826	1
827	Persona 827	CC827	persona827@mail.com	300000827	1982-04-07	Direccion 827	1
828	Persona 828	CC828	persona828@mail.com	300000828	1982-04-08	Direccion 828	1
829	Persona 829	CC829	persona829@mail.com	300000829	1982-04-09	Direccion 829	1
830	Persona 830	CC830	persona830@mail.com	300000830	1982-04-10	Direccion 830	1
831	Persona 831	CC831	persona831@mail.com	300000831	1982-04-11	Direccion 831	1
832	Persona 832	CC832	persona832@mail.com	300000832	1982-04-12	Direccion 832	1
833	Persona 833	CC833	persona833@mail.com	300000833	1982-04-13	Direccion 833	1
834	Persona 834	CC834	persona834@mail.com	300000834	1982-04-14	Direccion 834	1
835	Persona 835	CC835	persona835@mail.com	300000835	1982-04-15	Direccion 835	1
836	Persona 836	CC836	persona836@mail.com	300000836	1982-04-16	Direccion 836	1
837	Persona 837	CC837	persona837@mail.com	300000837	1982-04-17	Direccion 837	1
838	Persona 838	CC838	persona838@mail.com	300000838	1982-04-18	Direccion 838	1
839	Persona 839	CC839	persona839@mail.com	300000839	1982-04-19	Direccion 839	1
840	Persona 840	CC840	persona840@mail.com	300000840	1982-04-20	Direccion 840	1
841	Persona 841	CC841	persona841@mail.com	300000841	1982-04-21	Direccion 841	1
842	Persona 842	CC842	persona842@mail.com	300000842	1982-04-22	Direccion 842	1
843	Persona 843	CC843	persona843@mail.com	300000843	1982-04-23	Direccion 843	1
844	Persona 844	CC844	persona844@mail.com	300000844	1982-04-24	Direccion 844	1
845	Persona 845	CC845	persona845@mail.com	300000845	1982-04-25	Direccion 845	1
846	Persona 846	CC846	persona846@mail.com	300000846	1982-04-26	Direccion 846	1
847	Persona 847	CC847	persona847@mail.com	300000847	1982-04-27	Direccion 847	1
848	Persona 848	CC848	persona848@mail.com	300000848	1982-04-28	Direccion 848	1
849	Persona 849	CC849	persona849@mail.com	300000849	1982-04-29	Direccion 849	1
850	Persona 850	CC850	persona850@mail.com	300000850	1982-04-30	Direccion 850	1
851	Persona 851	CC851	persona851@mail.com	300000851	1982-05-01	Direccion 851	1
852	Persona 852	CC852	persona852@mail.com	300000852	1982-05-02	Direccion 852	1
853	Persona 853	CC853	persona853@mail.com	300000853	1982-05-03	Direccion 853	1
854	Persona 854	CC854	persona854@mail.com	300000854	1982-05-04	Direccion 854	1
855	Persona 855	CC855	persona855@mail.com	300000855	1982-05-05	Direccion 855	1
856	Persona 856	CC856	persona856@mail.com	300000856	1982-05-06	Direccion 856	1
857	Persona 857	CC857	persona857@mail.com	300000857	1982-05-07	Direccion 857	1
858	Persona 858	CC858	persona858@mail.com	300000858	1982-05-08	Direccion 858	1
859	Persona 859	CC859	persona859@mail.com	300000859	1982-05-09	Direccion 859	1
860	Persona 860	CC860	persona860@mail.com	300000860	1982-05-10	Direccion 860	1
861	Persona 861	CC861	persona861@mail.com	300000861	1982-05-11	Direccion 861	1
862	Persona 862	CC862	persona862@mail.com	300000862	1982-05-12	Direccion 862	1
863	Persona 863	CC863	persona863@mail.com	300000863	1982-05-13	Direccion 863	1
864	Persona 864	CC864	persona864@mail.com	300000864	1982-05-14	Direccion 864	1
865	Persona 865	CC865	persona865@mail.com	300000865	1982-05-15	Direccion 865	1
866	Persona 866	CC866	persona866@mail.com	300000866	1982-05-16	Direccion 866	1
867	Persona 867	CC867	persona867@mail.com	300000867	1982-05-17	Direccion 867	1
868	Persona 868	CC868	persona868@mail.com	300000868	1982-05-18	Direccion 868	1
869	Persona 869	CC869	persona869@mail.com	300000869	1982-05-19	Direccion 869	1
870	Persona 870	CC870	persona870@mail.com	300000870	1982-05-20	Direccion 870	1
871	Persona 871	CC871	persona871@mail.com	300000871	1982-05-21	Direccion 871	1
872	Persona 872	CC872	persona872@mail.com	300000872	1982-05-22	Direccion 872	1
873	Persona 873	CC873	persona873@mail.com	300000873	1982-05-23	Direccion 873	1
874	Persona 874	CC874	persona874@mail.com	300000874	1982-05-24	Direccion 874	1
875	Persona 875	CC875	persona875@mail.com	300000875	1982-05-25	Direccion 875	1
876	Persona 876	CC876	persona876@mail.com	300000876	1982-05-26	Direccion 876	1
877	Persona 877	CC877	persona877@mail.com	300000877	1982-05-27	Direccion 877	1
878	Persona 878	CC878	persona878@mail.com	300000878	1982-05-28	Direccion 878	1
879	Persona 879	CC879	persona879@mail.com	300000879	1982-05-29	Direccion 879	1
880	Persona 880	CC880	persona880@mail.com	300000880	1982-05-30	Direccion 880	1
881	Persona 881	CC881	persona881@mail.com	300000881	1982-05-31	Direccion 881	1
882	Persona 882	CC882	persona882@mail.com	300000882	1982-06-01	Direccion 882	1
883	Persona 883	CC883	persona883@mail.com	300000883	1982-06-02	Direccion 883	1
884	Persona 884	CC884	persona884@mail.com	300000884	1982-06-03	Direccion 884	1
885	Persona 885	CC885	persona885@mail.com	300000885	1982-06-04	Direccion 885	1
886	Persona 886	CC886	persona886@mail.com	300000886	1982-06-05	Direccion 886	1
887	Persona 887	CC887	persona887@mail.com	300000887	1982-06-06	Direccion 887	1
888	Persona 888	CC888	persona888@mail.com	300000888	1982-06-07	Direccion 888	1
889	Persona 889	CC889	persona889@mail.com	300000889	1982-06-08	Direccion 889	1
890	Persona 890	CC890	persona890@mail.com	300000890	1982-06-09	Direccion 890	1
891	Persona 891	CC891	persona891@mail.com	300000891	1982-06-10	Direccion 891	1
892	Persona 892	CC892	persona892@mail.com	300000892	1982-06-11	Direccion 892	1
893	Persona 893	CC893	persona893@mail.com	300000893	1982-06-12	Direccion 893	1
894	Persona 894	CC894	persona894@mail.com	300000894	1982-06-13	Direccion 894	1
895	Persona 895	CC895	persona895@mail.com	300000895	1982-06-14	Direccion 895	1
896	Persona 896	CC896	persona896@mail.com	300000896	1982-06-15	Direccion 896	1
897	Persona 897	CC897	persona897@mail.com	300000897	1982-06-16	Direccion 897	1
898	Persona 898	CC898	persona898@mail.com	300000898	1982-06-17	Direccion 898	1
899	Persona 899	CC899	persona899@mail.com	300000899	1982-06-18	Direccion 899	1
900	Persona 900	CC900	persona900@mail.com	300000900	1982-06-19	Direccion 900	1
901	Persona 901	CC901	persona901@mail.com	300000901	1982-06-20	Direccion 901	1
902	Persona 902	CC902	persona902@mail.com	300000902	1982-06-21	Direccion 902	1
903	Persona 903	CC903	persona903@mail.com	300000903	1982-06-22	Direccion 903	1
904	Persona 904	CC904	persona904@mail.com	300000904	1982-06-23	Direccion 904	1
905	Persona 905	CC905	persona905@mail.com	300000905	1982-06-24	Direccion 905	1
906	Persona 906	CC906	persona906@mail.com	300000906	1982-06-25	Direccion 906	1
907	Persona 907	CC907	persona907@mail.com	300000907	1982-06-26	Direccion 907	1
908	Persona 908	CC908	persona908@mail.com	300000908	1982-06-27	Direccion 908	1
909	Persona 909	CC909	persona909@mail.com	300000909	1982-06-28	Direccion 909	1
910	Persona 910	CC910	persona910@mail.com	300000910	1982-06-29	Direccion 910	1
911	Persona 911	CC911	persona911@mail.com	300000911	1982-06-30	Direccion 911	1
912	Persona 912	CC912	persona912@mail.com	300000912	1982-07-01	Direccion 912	1
913	Persona 913	CC913	persona913@mail.com	300000913	1982-07-02	Direccion 913	1
914	Persona 914	CC914	persona914@mail.com	300000914	1982-07-03	Direccion 914	1
915	Persona 915	CC915	persona915@mail.com	300000915	1982-07-04	Direccion 915	1
916	Persona 916	CC916	persona916@mail.com	300000916	1982-07-05	Direccion 916	1
917	Persona 917	CC917	persona917@mail.com	300000917	1982-07-06	Direccion 917	1
918	Persona 918	CC918	persona918@mail.com	300000918	1982-07-07	Direccion 918	1
919	Persona 919	CC919	persona919@mail.com	300000919	1982-07-08	Direccion 919	1
920	Persona 920	CC920	persona920@mail.com	300000920	1982-07-09	Direccion 920	1
921	Persona 921	CC921	persona921@mail.com	300000921	1982-07-10	Direccion 921	1
922	Persona 922	CC922	persona922@mail.com	300000922	1982-07-11	Direccion 922	1
923	Persona 923	CC923	persona923@mail.com	300000923	1982-07-12	Direccion 923	1
924	Persona 924	CC924	persona924@mail.com	300000924	1982-07-13	Direccion 924	1
925	Persona 925	CC925	persona925@mail.com	300000925	1982-07-14	Direccion 925	1
926	Persona 926	CC926	persona926@mail.com	300000926	1982-07-15	Direccion 926	1
927	Persona 927	CC927	persona927@mail.com	300000927	1982-07-16	Direccion 927	1
928	Persona 928	CC928	persona928@mail.com	300000928	1982-07-17	Direccion 928	1
929	Persona 929	CC929	persona929@mail.com	300000929	1982-07-18	Direccion 929	1
930	Persona 930	CC930	persona930@mail.com	300000930	1982-07-19	Direccion 930	1
931	Persona 931	CC931	persona931@mail.com	300000931	1982-07-20	Direccion 931	1
932	Persona 932	CC932	persona932@mail.com	300000932	1982-07-21	Direccion 932	1
933	Persona 933	CC933	persona933@mail.com	300000933	1982-07-22	Direccion 933	1
934	Persona 934	CC934	persona934@mail.com	300000934	1982-07-23	Direccion 934	1
935	Persona 935	CC935	persona935@mail.com	300000935	1982-07-24	Direccion 935	1
936	Persona 936	CC936	persona936@mail.com	300000936	1982-07-25	Direccion 936	1
937	Persona 937	CC937	persona937@mail.com	300000937	1982-07-26	Direccion 937	1
938	Persona 938	CC938	persona938@mail.com	300000938	1982-07-27	Direccion 938	1
939	Persona 939	CC939	persona939@mail.com	300000939	1982-07-28	Direccion 939	1
940	Persona 940	CC940	persona940@mail.com	300000940	1982-07-29	Direccion 940	1
941	Persona 941	CC941	persona941@mail.com	300000941	1982-07-30	Direccion 941	1
942	Persona 942	CC942	persona942@mail.com	300000942	1982-07-31	Direccion 942	1
943	Persona 943	CC943	persona943@mail.com	300000943	1982-08-01	Direccion 943	1
944	Persona 944	CC944	persona944@mail.com	300000944	1982-08-02	Direccion 944	1
945	Persona 945	CC945	persona945@mail.com	300000945	1982-08-03	Direccion 945	1
946	Persona 946	CC946	persona946@mail.com	300000946	1982-08-04	Direccion 946	1
947	Persona 947	CC947	persona947@mail.com	300000947	1982-08-05	Direccion 947	1
948	Persona 948	CC948	persona948@mail.com	300000948	1982-08-06	Direccion 948	1
949	Persona 949	CC949	persona949@mail.com	300000949	1982-08-07	Direccion 949	1
950	Persona 950	CC950	persona950@mail.com	300000950	1982-08-08	Direccion 950	1
951	Persona 951	CC951	persona951@mail.com	300000951	1982-08-09	Direccion 951	1
952	Persona 952	CC952	persona952@mail.com	300000952	1982-08-10	Direccion 952	1
953	Persona 953	CC953	persona953@mail.com	300000953	1982-08-11	Direccion 953	1
954	Persona 954	CC954	persona954@mail.com	300000954	1982-08-12	Direccion 954	1
955	Persona 955	CC955	persona955@mail.com	300000955	1982-08-13	Direccion 955	1
956	Persona 956	CC956	persona956@mail.com	300000956	1982-08-14	Direccion 956	1
957	Persona 957	CC957	persona957@mail.com	300000957	1982-08-15	Direccion 957	1
958	Persona 958	CC958	persona958@mail.com	300000958	1982-08-16	Direccion 958	1
959	Persona 959	CC959	persona959@mail.com	300000959	1982-08-17	Direccion 959	1
960	Persona 960	CC960	persona960@mail.com	300000960	1982-08-18	Direccion 960	1
961	Persona 961	CC961	persona961@mail.com	300000961	1982-08-19	Direccion 961	1
962	Persona 962	CC962	persona962@mail.com	300000962	1982-08-20	Direccion 962	1
963	Persona 963	CC963	persona963@mail.com	300000963	1982-08-21	Direccion 963	1
964	Persona 964	CC964	persona964@mail.com	300000964	1982-08-22	Direccion 964	1
965	Persona 965	CC965	persona965@mail.com	300000965	1982-08-23	Direccion 965	1
966	Persona 966	CC966	persona966@mail.com	300000966	1982-08-24	Direccion 966	1
967	Persona 967	CC967	persona967@mail.com	300000967	1982-08-25	Direccion 967	1
968	Persona 968	CC968	persona968@mail.com	300000968	1982-08-26	Direccion 968	1
969	Persona 969	CC969	persona969@mail.com	300000969	1982-08-27	Direccion 969	1
970	Persona 970	CC970	persona970@mail.com	300000970	1982-08-28	Direccion 970	1
971	Persona 971	CC971	persona971@mail.com	300000971	1982-08-29	Direccion 971	1
972	Persona 972	CC972	persona972@mail.com	300000972	1982-08-30	Direccion 972	1
973	Persona 973	CC973	persona973@mail.com	300000973	1982-08-31	Direccion 973	1
974	Persona 974	CC974	persona974@mail.com	300000974	1982-09-01	Direccion 974	1
975	Persona 975	CC975	persona975@mail.com	300000975	1982-09-02	Direccion 975	1
976	Persona 976	CC976	persona976@mail.com	300000976	1982-09-03	Direccion 976	1
977	Persona 977	CC977	persona977@mail.com	300000977	1982-09-04	Direccion 977	1
978	Persona 978	CC978	persona978@mail.com	300000978	1982-09-05	Direccion 978	1
979	Persona 979	CC979	persona979@mail.com	300000979	1982-09-06	Direccion 979	1
980	Persona 980	CC980	persona980@mail.com	300000980	1982-09-07	Direccion 980	1
981	Persona 981	CC981	persona981@mail.com	300000981	1982-09-08	Direccion 981	1
982	Persona 982	CC982	persona982@mail.com	300000982	1982-09-09	Direccion 982	1
983	Persona 983	CC983	persona983@mail.com	300000983	1982-09-10	Direccion 983	1
984	Persona 984	CC984	persona984@mail.com	300000984	1982-09-11	Direccion 984	1
985	Persona 985	CC985	persona985@mail.com	300000985	1982-09-12	Direccion 985	1
986	Persona 986	CC986	persona986@mail.com	300000986	1982-09-13	Direccion 986	1
987	Persona 987	CC987	persona987@mail.com	300000987	1982-09-14	Direccion 987	1
988	Persona 988	CC988	persona988@mail.com	300000988	1982-09-15	Direccion 988	1
989	Persona 989	CC989	persona989@mail.com	300000989	1982-09-16	Direccion 989	1
990	Persona 990	CC990	persona990@mail.com	300000990	1982-09-17	Direccion 990	1
991	Persona 991	CC991	persona991@mail.com	300000991	1982-09-18	Direccion 991	1
992	Persona 992	CC992	persona992@mail.com	300000992	1982-09-19	Direccion 992	1
993	Persona 993	CC993	persona993@mail.com	300000993	1982-09-20	Direccion 993	1
994	Persona 994	CC994	persona994@mail.com	300000994	1982-09-21	Direccion 994	1
995	Persona 995	CC995	persona995@mail.com	300000995	1982-09-22	Direccion 995	1
996	Persona 996	CC996	persona996@mail.com	300000996	1982-09-23	Direccion 996	1
997	Persona 997	CC997	persona997@mail.com	300000997	1982-09-24	Direccion 997	1
998	Persona 998	CC998	persona998@mail.com	300000998	1982-09-25	Direccion 998	1
999	Persona 999	CC999	persona999@mail.com	300000999	1982-09-26	Direccion 999	1
1000	Persona 1000	CC1000	persona1000@mail.com	3000001000	1980-01-01	Direccion 1000	1
\.


--
-- TOC entry 5114 (class 0 OID 16735)
-- Dependencies: 232
-- Data for Name: cuenta_bancaria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuenta_bancaria (id_cuenta, numero_cuenta, id_producto, saldo_actual, moneda, fecha_apertura, id_persona, id_empresa, id_estado) FROM stdin;
1	CTA1	1	632031.73	COP	2026-02-27	1	\N	1
2	CTA2	1	679937.42	COP	2026-02-27	2	\N	1
3	CTA3	1	85646.75	COP	2026-02-27	3	\N	1
4	CTA4	1	852642.16	COP	2026-02-27	4	\N	1
5	CTA5	1	931439.65	COP	2026-02-27	5	\N	1
6	CTA6	1	999012.21	COP	2026-02-27	6	\N	1
7	CTA7	1	84043.62	COP	2026-02-27	7	\N	1
8	CTA8	1	855862.60	COP	2026-02-27	8	\N	1
9	CTA9	1	620587.84	COP	2026-02-27	9	\N	1
10	CTA10	1	787468.66	COP	2026-02-27	10	\N	1
11	CTA11	1	556697.27	COP	2026-02-27	11	\N	1
12	CTA12	1	297966.75	COP	2026-02-27	12	\N	1
13	CTA13	1	986052.66	COP	2026-02-27	13	\N	1
14	CTA14	1	661480.58	COP	2026-02-27	14	\N	1
15	CTA15	1	586596.62	COP	2026-02-27	15	\N	1
16	CTA16	1	767065.25	COP	2026-02-27	16	\N	1
17	CTA17	1	345362.30	COP	2026-02-27	17	\N	1
18	CTA18	1	506223.86	COP	2026-02-27	18	\N	1
19	CTA19	1	966789.61	COP	2026-02-27	19	\N	1
20	CTA20	1	462182.22	COP	2026-02-27	20	\N	1
21	CTA21	1	438230.23	COP	2026-02-27	21	\N	1
22	CTA22	1	538597.28	COP	2026-02-27	22	\N	1
23	CTA23	1	579661.71	COP	2026-02-27	23	\N	1
24	CTA24	1	494352.08	COP	2026-02-27	24	\N	1
25	CTA25	1	946269.85	COP	2026-02-27	25	\N	1
26	CTA26	1	579353.27	COP	2026-02-27	26	\N	1
27	CTA27	1	670410.31	COP	2026-02-27	27	\N	1
28	CTA28	1	395629.82	COP	2026-02-27	28	\N	1
29	CTA29	1	519960.23	COP	2026-02-27	29	\N	1
30	CTA30	1	450271.17	COP	2026-02-27	30	\N	1
31	CTA31	1	673010.56	COP	2026-02-27	31	\N	1
32	CTA32	1	137100.98	COP	2026-02-27	32	\N	1
33	CTA33	1	592936.53	COP	2026-02-27	33	\N	1
34	CTA34	1	804851.23	COP	2026-02-27	34	\N	1
35	CTA35	1	334384.27	COP	2026-02-27	35	\N	1
36	CTA36	1	456261.84	COP	2026-02-27	36	\N	1
37	CTA37	1	933540.90	COP	2026-02-27	37	\N	1
38	CTA38	1	381903.19	COP	2026-02-27	38	\N	1
39	CTA39	1	109985.21	COP	2026-02-27	39	\N	1
40	CTA40	1	640358.76	COP	2026-02-27	40	\N	1
41	CTA41	1	391603.50	COP	2026-02-27	41	\N	1
42	CTA42	1	612011.48	COP	2026-02-27	42	\N	1
43	CTA43	1	302486.91	COP	2026-02-27	43	\N	1
44	CTA44	1	25178.34	COP	2026-02-27	44	\N	1
45	CTA45	1	550346.73	COP	2026-02-27	45	\N	1
46	CTA46	1	472464.27	COP	2026-02-27	46	\N	1
47	CTA47	1	582133.45	COP	2026-02-27	47	\N	1
48	CTA48	1	920644.28	COP	2026-02-27	48	\N	1
49	CTA49	1	2945.79	COP	2026-02-27	49	\N	1
50	CTA50	1	188513.76	COP	2026-02-27	50	\N	1
51	CTA51	1	873758.51	COP	2026-02-27	51	\N	1
52	CTA52	1	530103.60	COP	2026-02-27	52	\N	1
53	CTA53	1	743203.38	COP	2026-02-27	53	\N	1
54	CTA54	1	559335.69	COP	2026-02-27	54	\N	1
55	CTA55	1	178782.47	COP	2026-02-27	55	\N	1
56	CTA56	1	588098.82	COP	2026-02-27	56	\N	1
57	CTA57	1	39008.80	COP	2026-02-27	57	\N	1
58	CTA58	1	441746.84	COP	2026-02-27	58	\N	1
59	CTA59	1	49731.19	COP	2026-02-27	59	\N	1
60	CTA60	1	322867.23	COP	2026-02-27	60	\N	1
61	CTA61	1	37916.17	COP	2026-02-27	61	\N	1
62	CTA62	1	222242.97	COP	2026-02-27	62	\N	1
63	CTA63	1	323110.77	COP	2026-02-27	63	\N	1
64	CTA64	1	940019.52	COP	2026-02-27	64	\N	1
65	CTA65	1	497872.23	COP	2026-02-27	65	\N	1
66	CTA66	1	562792.56	COP	2026-02-27	66	\N	1
67	CTA67	1	886583.61	COP	2026-02-27	67	\N	1
68	CTA68	1	895459.99	COP	2026-02-27	68	\N	1
69	CTA69	1	149976.26	COP	2026-02-27	69	\N	1
70	CTA70	1	453360.64	COP	2026-02-27	70	\N	1
71	CTA71	1	595212.93	COP	2026-02-27	71	\N	1
72	CTA72	1	214298.44	COP	2026-02-27	72	\N	1
73	CTA73	1	635389.12	COP	2026-02-27	73	\N	1
74	CTA74	1	817294.94	COP	2026-02-27	74	\N	1
75	CTA75	1	616877.08	COP	2026-02-27	75	\N	1
76	CTA76	1	525473.96	COP	2026-02-27	76	\N	1
77	CTA77	1	956746.90	COP	2026-02-27	77	\N	1
78	CTA78	1	806582.07	COP	2026-02-27	78	\N	1
79	CTA79	1	478204.53	COP	2026-02-27	79	\N	1
80	CTA80	1	35879.54	COP	2026-02-27	80	\N	1
81	CTA81	1	175850.73	COP	2026-02-27	81	\N	1
82	CTA82	1	892503.22	COP	2026-02-27	82	\N	1
83	CTA83	1	518809.36	COP	2026-02-27	83	\N	1
84	CTA84	1	136973.22	COP	2026-02-27	84	\N	1
85	CTA85	1	705748.03	COP	2026-02-27	85	\N	1
86	CTA86	1	260934.95	COP	2026-02-27	86	\N	1
87	CTA87	1	959819.22	COP	2026-02-27	87	\N	1
88	CTA88	1	348434.77	COP	2026-02-27	88	\N	1
89	CTA89	1	699124.96	COP	2026-02-27	89	\N	1
90	CTA90	1	136145.91	COP	2026-02-27	90	\N	1
91	CTA91	1	234053.76	COP	2026-02-27	91	\N	1
92	CTA92	1	304817.45	COP	2026-02-27	92	\N	1
93	CTA93	1	950582.45	COP	2026-02-27	93	\N	1
94	CTA94	1	849109.15	COP	2026-02-27	94	\N	1
95	CTA95	1	275974.29	COP	2026-02-27	95	\N	1
96	CTA96	1	328159.47	COP	2026-02-27	96	\N	1
97	CTA97	1	367228.26	COP	2026-02-27	97	\N	1
98	CTA98	1	24139.02	COP	2026-02-27	98	\N	1
99	CTA99	1	117984.02	COP	2026-02-27	99	\N	1
100	CTA100	1	120922.08	COP	2026-02-27	100	\N	1
101	CTA101	1	692433.31	COP	2026-02-27	101	\N	1
102	CTA102	1	98220.84	COP	2026-02-27	102	\N	1
103	CTA103	1	504313.13	COP	2026-02-27	103	\N	1
104	CTA104	1	546326.10	COP	2026-02-27	104	\N	1
105	CTA105	1	709272.09	COP	2026-02-27	105	\N	1
106	CTA106	1	218676.96	COP	2026-02-27	106	\N	1
107	CTA107	1	875181.88	COP	2026-02-27	107	\N	1
108	CTA108	1	950946.88	COP	2026-02-27	108	\N	1
109	CTA109	1	604937.82	COP	2026-02-27	109	\N	1
110	CTA110	1	260296.99	COP	2026-02-27	110	\N	1
111	CTA111	1	647461.87	COP	2026-02-27	111	\N	1
112	CTA112	1	859116.23	COP	2026-02-27	112	\N	1
113	CTA113	1	167997.19	COP	2026-02-27	113	\N	1
114	CTA114	1	377214.76	COP	2026-02-27	114	\N	1
115	CTA115	1	636590.64	COP	2026-02-27	115	\N	1
116	CTA116	1	107947.18	COP	2026-02-27	116	\N	1
117	CTA117	1	278018.18	COP	2026-02-27	117	\N	1
118	CTA118	1	606600.24	COP	2026-02-27	118	\N	1
119	CTA119	1	13000.05	COP	2026-02-27	119	\N	1
120	CTA120	1	617714.33	COP	2026-02-27	120	\N	1
121	CTA121	1	303162.88	COP	2026-02-27	121	\N	1
122	CTA122	1	683394.87	COP	2026-02-27	122	\N	1
123	CTA123	1	173170.43	COP	2026-02-27	123	\N	1
124	CTA124	1	12759.87	COP	2026-02-27	124	\N	1
125	CTA125	1	765808.88	COP	2026-02-27	125	\N	1
126	CTA126	1	499910.87	COP	2026-02-27	126	\N	1
127	CTA127	1	998403.54	COP	2026-02-27	127	\N	1
128	CTA128	1	883415.87	COP	2026-02-27	128	\N	1
129	CTA129	1	717577.51	COP	2026-02-27	129	\N	1
130	CTA130	1	521034.13	COP	2026-02-27	130	\N	1
131	CTA131	1	31571.55	COP	2026-02-27	131	\N	1
132	CTA132	1	748262.10	COP	2026-02-27	132	\N	1
133	CTA133	1	733886.16	COP	2026-02-27	133	\N	1
134	CTA134	1	637458.58	COP	2026-02-27	134	\N	1
135	CTA135	1	79870.67	COP	2026-02-27	135	\N	1
136	CTA136	1	626637.14	COP	2026-02-27	136	\N	1
137	CTA137	1	971722.39	COP	2026-02-27	137	\N	1
138	CTA138	1	885351.36	COP	2026-02-27	138	\N	1
139	CTA139	1	960572.52	COP	2026-02-27	139	\N	1
140	CTA140	1	738787.86	COP	2026-02-27	140	\N	1
141	CTA141	1	967722.80	COP	2026-02-27	141	\N	1
142	CTA142	1	249502.28	COP	2026-02-27	142	\N	1
143	CTA143	1	930363.55	COP	2026-02-27	143	\N	1
144	CTA144	1	9000.82	COP	2026-02-27	144	\N	1
145	CTA145	1	626107.65	COP	2026-02-27	145	\N	1
146	CTA146	1	612472.06	COP	2026-02-27	146	\N	1
147	CTA147	1	922614.07	COP	2026-02-27	147	\N	1
148	CTA148	1	657108.29	COP	2026-02-27	148	\N	1
149	CTA149	1	747448.09	COP	2026-02-27	149	\N	1
150	CTA150	1	379064.77	COP	2026-02-27	150	\N	1
151	CTA151	1	346620.70	COP	2026-02-27	151	\N	1
152	CTA152	1	849697.85	COP	2026-02-27	152	\N	1
153	CTA153	1	600252.34	COP	2026-02-27	153	\N	1
154	CTA154	1	399608.57	COP	2026-02-27	154	\N	1
155	CTA155	1	764833.82	COP	2026-02-27	155	\N	1
156	CTA156	1	356427.50	COP	2026-02-27	156	\N	1
157	CTA157	1	710663.38	COP	2026-02-27	157	\N	1
158	CTA158	1	748535.50	COP	2026-02-27	158	\N	1
159	CTA159	1	842709.74	COP	2026-02-27	159	\N	1
160	CTA160	1	841485.19	COP	2026-02-27	160	\N	1
161	CTA161	1	686226.82	COP	2026-02-27	161	\N	1
162	CTA162	1	53560.31	COP	2026-02-27	162	\N	1
163	CTA163	1	208741.87	COP	2026-02-27	163	\N	1
164	CTA164	1	205618.14	COP	2026-02-27	164	\N	1
165	CTA165	1	67703.48	COP	2026-02-27	165	\N	1
166	CTA166	1	437388.07	COP	2026-02-27	166	\N	1
167	CTA167	1	91115.92	COP	2026-02-27	167	\N	1
168	CTA168	1	100011.17	COP	2026-02-27	168	\N	1
169	CTA169	1	425042.40	COP	2026-02-27	169	\N	1
170	CTA170	1	323956.75	COP	2026-02-27	170	\N	1
171	CTA171	1	924034.83	COP	2026-02-27	171	\N	1
172	CTA172	1	495854.86	COP	2026-02-27	172	\N	1
173	CTA173	1	986344.09	COP	2026-02-27	173	\N	1
174	CTA174	1	366029.79	COP	2026-02-27	174	\N	1
175	CTA175	1	224918.01	COP	2026-02-27	175	\N	1
176	CTA176	1	861195.04	COP	2026-02-27	176	\N	1
177	CTA177	1	361611.13	COP	2026-02-27	177	\N	1
178	CTA178	1	314391.44	COP	2026-02-27	178	\N	1
179	CTA179	1	181713.83	COP	2026-02-27	179	\N	1
180	CTA180	1	654889.00	COP	2026-02-27	180	\N	1
181	CTA181	1	215629.61	COP	2026-02-27	181	\N	1
182	CTA182	1	94228.65	COP	2026-02-27	182	\N	1
183	CTA183	1	221737.31	COP	2026-02-27	183	\N	1
184	CTA184	1	358945.74	COP	2026-02-27	184	\N	1
185	CTA185	1	246182.86	COP	2026-02-27	185	\N	1
186	CTA186	1	932466.90	COP	2026-02-27	186	\N	1
187	CTA187	1	718197.63	COP	2026-02-27	187	\N	1
188	CTA188	1	189465.93	COP	2026-02-27	188	\N	1
189	CTA189	1	52313.24	COP	2026-02-27	189	\N	1
190	CTA190	1	436736.12	COP	2026-02-27	190	\N	1
191	CTA191	1	608923.78	COP	2026-02-27	191	\N	1
192	CTA192	1	976868.70	COP	2026-02-27	192	\N	1
193	CTA193	1	245044.74	COP	2026-02-27	193	\N	1
194	CTA194	1	89246.29	COP	2026-02-27	194	\N	1
195	CTA195	1	979309.19	COP	2026-02-27	195	\N	1
196	CTA196	1	125340.57	COP	2026-02-27	196	\N	1
197	CTA197	1	934480.35	COP	2026-02-27	197	\N	1
198	CTA198	1	67150.19	COP	2026-02-27	198	\N	1
199	CTA199	1	494527.43	COP	2026-02-27	199	\N	1
200	CTA200	1	427745.39	COP	2026-02-27	200	\N	1
201	CTA201	1	593361.59	COP	2026-02-27	201	\N	1
202	CTA202	1	429026.85	COP	2026-02-27	202	\N	1
203	CTA203	1	767935.97	COP	2026-02-27	203	\N	1
204	CTA204	1	823104.48	COP	2026-02-27	204	\N	1
205	CTA205	1	972164.31	COP	2026-02-27	205	\N	1
206	CTA206	1	279914.91	COP	2026-02-27	206	\N	1
207	CTA207	1	127491.35	COP	2026-02-27	207	\N	1
208	CTA208	1	167779.59	COP	2026-02-27	208	\N	1
209	CTA209	1	376488.69	COP	2026-02-27	209	\N	1
210	CTA210	1	889152.37	COP	2026-02-27	210	\N	1
211	CTA211	1	195979.84	COP	2026-02-27	211	\N	1
212	CTA212	1	39714.58	COP	2026-02-27	212	\N	1
213	CTA213	1	419360.65	COP	2026-02-27	213	\N	1
214	CTA214	1	196278.58	COP	2026-02-27	214	\N	1
215	CTA215	1	178071.66	COP	2026-02-27	215	\N	1
216	CTA216	1	773452.34	COP	2026-02-27	216	\N	1
217	CTA217	1	851160.11	COP	2026-02-27	217	\N	1
218	CTA218	1	914906.73	COP	2026-02-27	218	\N	1
219	CTA219	1	578433.20	COP	2026-02-27	219	\N	1
220	CTA220	1	295678.86	COP	2026-02-27	220	\N	1
221	CTA221	1	465596.23	COP	2026-02-27	221	\N	1
222	CTA222	1	804557.79	COP	2026-02-27	222	\N	1
223	CTA223	1	657833.70	COP	2026-02-27	223	\N	1
224	CTA224	1	897027.28	COP	2026-02-27	224	\N	1
225	CTA225	1	348468.23	COP	2026-02-27	225	\N	1
226	CTA226	1	173810.73	COP	2026-02-27	226	\N	1
227	CTA227	1	794092.81	COP	2026-02-27	227	\N	1
228	CTA228	1	504646.73	COP	2026-02-27	228	\N	1
229	CTA229	1	647837.83	COP	2026-02-27	229	\N	1
230	CTA230	1	685655.09	COP	2026-02-27	230	\N	1
231	CTA231	1	445978.72	COP	2026-02-27	231	\N	1
232	CTA232	1	935971.48	COP	2026-02-27	232	\N	1
233	CTA233	1	21784.84	COP	2026-02-27	233	\N	1
234	CTA234	1	546659.14	COP	2026-02-27	234	\N	1
235	CTA235	1	723385.83	COP	2026-02-27	235	\N	1
236	CTA236	1	585202.23	COP	2026-02-27	236	\N	1
237	CTA237	1	256832.99	COP	2026-02-27	237	\N	1
238	CTA238	1	472861.47	COP	2026-02-27	238	\N	1
239	CTA239	1	705339.53	COP	2026-02-27	239	\N	1
240	CTA240	1	353460.13	COP	2026-02-27	240	\N	1
241	CTA241	1	302327.86	COP	2026-02-27	241	\N	1
242	CTA242	1	614711.25	COP	2026-02-27	242	\N	1
243	CTA243	1	423308.51	COP	2026-02-27	243	\N	1
244	CTA244	1	986775.86	COP	2026-02-27	244	\N	1
245	CTA245	1	882899.61	COP	2026-02-27	245	\N	1
246	CTA246	1	927093.38	COP	2026-02-27	246	\N	1
247	CTA247	1	804515.80	COP	2026-02-27	247	\N	1
248	CTA248	1	316466.40	COP	2026-02-27	248	\N	1
249	CTA249	1	400527.00	COP	2026-02-27	249	\N	1
250	CTA250	1	412243.82	COP	2026-02-27	250	\N	1
251	CTA251	1	494974.18	COP	2026-02-27	251	\N	1
252	CTA252	1	546122.82	COP	2026-02-27	252	\N	1
253	CTA253	1	192817.15	COP	2026-02-27	253	\N	1
254	CTA254	1	415264.02	COP	2026-02-27	254	\N	1
255	CTA255	1	500952.03	COP	2026-02-27	255	\N	1
256	CTA256	1	656359.75	COP	2026-02-27	256	\N	1
257	CTA257	1	165502.57	COP	2026-02-27	257	\N	1
258	CTA258	1	647252.33	COP	2026-02-27	258	\N	1
259	CTA259	1	354895.12	COP	2026-02-27	259	\N	1
260	CTA260	1	100829.39	COP	2026-02-27	260	\N	1
261	CTA261	1	470536.52	COP	2026-02-27	261	\N	1
262	CTA262	1	892220.47	COP	2026-02-27	262	\N	1
263	CTA263	1	139187.22	COP	2026-02-27	263	\N	1
264	CTA264	1	116143.51	COP	2026-02-27	264	\N	1
265	CTA265	1	909696.10	COP	2026-02-27	265	\N	1
266	CTA266	1	523736.68	COP	2026-02-27	266	\N	1
267	CTA267	1	473152.94	COP	2026-02-27	267	\N	1
268	CTA268	1	33590.19	COP	2026-02-27	268	\N	1
269	CTA269	1	101875.05	COP	2026-02-27	269	\N	1
270	CTA270	1	495530.63	COP	2026-02-27	270	\N	1
271	CTA271	1	717736.43	COP	2026-02-27	271	\N	1
272	CTA272	1	105030.72	COP	2026-02-27	272	\N	1
273	CTA273	1	805099.56	COP	2026-02-27	273	\N	1
274	CTA274	1	617007.97	COP	2026-02-27	274	\N	1
275	CTA275	1	320676.10	COP	2026-02-27	275	\N	1
276	CTA276	1	441035.29	COP	2026-02-27	276	\N	1
277	CTA277	1	510754.09	COP	2026-02-27	277	\N	1
278	CTA278	1	990000.20	COP	2026-02-27	278	\N	1
279	CTA279	1	44546.58	COP	2026-02-27	279	\N	1
280	CTA280	1	829002.27	COP	2026-02-27	280	\N	1
281	CTA281	1	85089.78	COP	2026-02-27	281	\N	1
282	CTA282	1	592637.55	COP	2026-02-27	282	\N	1
283	CTA283	1	875875.45	COP	2026-02-27	283	\N	1
284	CTA284	1	257970.73	COP	2026-02-27	284	\N	1
285	CTA285	1	522821.96	COP	2026-02-27	285	\N	1
286	CTA286	1	620589.33	COP	2026-02-27	286	\N	1
287	CTA287	1	926092.06	COP	2026-02-27	287	\N	1
288	CTA288	1	153771.68	COP	2026-02-27	288	\N	1
289	CTA289	1	563894.08	COP	2026-02-27	289	\N	1
290	CTA290	1	198109.25	COP	2026-02-27	290	\N	1
291	CTA291	1	448807.94	COP	2026-02-27	291	\N	1
292	CTA292	1	579738.57	COP	2026-02-27	292	\N	1
293	CTA293	1	797405.90	COP	2026-02-27	293	\N	1
294	CTA294	1	864743.51	COP	2026-02-27	294	\N	1
295	CTA295	1	378209.19	COP	2026-02-27	295	\N	1
296	CTA296	1	391366.80	COP	2026-02-27	296	\N	1
297	CTA297	1	735287.56	COP	2026-02-27	297	\N	1
298	CTA298	1	484644.81	COP	2026-02-27	298	\N	1
299	CTA299	1	126115.99	COP	2026-02-27	299	\N	1
300	CTA300	1	159366.23	COP	2026-02-27	300	\N	1
301	CTA301	1	730004.55	COP	2026-02-27	301	\N	1
302	CTA302	1	246714.53	COP	2026-02-27	302	\N	1
303	CTA303	1	221232.10	COP	2026-02-27	303	\N	1
304	CTA304	1	806262.51	COP	2026-02-27	304	\N	1
305	CTA305	1	816530.42	COP	2026-02-27	305	\N	1
306	CTA306	1	470199.40	COP	2026-02-27	306	\N	1
307	CTA307	1	548069.78	COP	2026-02-27	307	\N	1
308	CTA308	1	68237.09	COP	2026-02-27	308	\N	1
309	CTA309	1	341403.54	COP	2026-02-27	309	\N	1
310	CTA310	1	532377.22	COP	2026-02-27	310	\N	1
311	CTA311	1	743327.54	COP	2026-02-27	311	\N	1
312	CTA312	1	307900.30	COP	2026-02-27	312	\N	1
313	CTA313	1	739995.85	COP	2026-02-27	313	\N	1
314	CTA314	1	66467.96	COP	2026-02-27	314	\N	1
315	CTA315	1	546521.23	COP	2026-02-27	315	\N	1
316	CTA316	1	779685.11	COP	2026-02-27	316	\N	1
317	CTA317	1	704911.78	COP	2026-02-27	317	\N	1
318	CTA318	1	166228.79	COP	2026-02-27	318	\N	1
319	CTA319	1	215798.51	COP	2026-02-27	319	\N	1
320	CTA320	1	375082.73	COP	2026-02-27	320	\N	1
321	CTA321	1	365956.54	COP	2026-02-27	321	\N	1
322	CTA322	1	94489.68	COP	2026-02-27	322	\N	1
323	CTA323	1	849251.54	COP	2026-02-27	323	\N	1
324	CTA324	1	715944.39	COP	2026-02-27	324	\N	1
325	CTA325	1	1897.02	COP	2026-02-27	325	\N	1
326	CTA326	1	598583.04	COP	2026-02-27	326	\N	1
327	CTA327	1	464062.96	COP	2026-02-27	327	\N	1
328	CTA328	1	276722.46	COP	2026-02-27	328	\N	1
329	CTA329	1	140998.91	COP	2026-02-27	329	\N	1
330	CTA330	1	139719.73	COP	2026-02-27	330	\N	1
331	CTA331	1	504277.44	COP	2026-02-27	331	\N	1
332	CTA332	1	85094.72	COP	2026-02-27	332	\N	1
333	CTA333	1	364278.25	COP	2026-02-27	333	\N	1
334	CTA334	1	235129.09	COP	2026-02-27	334	\N	1
335	CTA335	1	502297.60	COP	2026-02-27	335	\N	1
336	CTA336	1	503615.46	COP	2026-02-27	336	\N	1
337	CTA337	1	475520.70	COP	2026-02-27	337	\N	1
338	CTA338	1	714789.52	COP	2026-02-27	338	\N	1
339	CTA339	1	125919.03	COP	2026-02-27	339	\N	1
340	CTA340	1	965633.60	COP	2026-02-27	340	\N	1
341	CTA341	1	549221.55	COP	2026-02-27	341	\N	1
342	CTA342	1	667726.07	COP	2026-02-27	342	\N	1
343	CTA343	1	334915.92	COP	2026-02-27	343	\N	1
344	CTA344	1	672775.33	COP	2026-02-27	344	\N	1
345	CTA345	1	675348.91	COP	2026-02-27	345	\N	1
346	CTA346	1	782582.63	COP	2026-02-27	346	\N	1
347	CTA347	1	420962.74	COP	2026-02-27	347	\N	1
348	CTA348	1	335941.96	COP	2026-02-27	348	\N	1
349	CTA349	1	96955.85	COP	2026-02-27	349	\N	1
350	CTA350	1	505686.52	COP	2026-02-27	350	\N	1
351	CTA351	1	216012.90	COP	2026-02-27	351	\N	1
352	CTA352	1	648050.30	COP	2026-02-27	352	\N	1
353	CTA353	1	857378.56	COP	2026-02-27	353	\N	1
354	CTA354	1	637795.44	COP	2026-02-27	354	\N	1
355	CTA355	1	900758.88	COP	2026-02-27	355	\N	1
356	CTA356	1	912866.22	COP	2026-02-27	356	\N	1
357	CTA357	1	866950.25	COP	2026-02-27	357	\N	1
358	CTA358	1	795782.06	COP	2026-02-27	358	\N	1
359	CTA359	1	994753.86	COP	2026-02-27	359	\N	1
360	CTA360	1	91971.10	COP	2026-02-27	360	\N	1
361	CTA361	1	79084.16	COP	2026-02-27	361	\N	1
362	CTA362	1	159920.01	COP	2026-02-27	362	\N	1
363	CTA363	1	898254.79	COP	2026-02-27	363	\N	1
364	CTA364	1	259935.59	COP	2026-02-27	364	\N	1
365	CTA365	1	38275.49	COP	2026-02-27	365	\N	1
366	CTA366	1	672732.58	COP	2026-02-27	366	\N	1
367	CTA367	1	942227.73	COP	2026-02-27	367	\N	1
368	CTA368	1	489163.72	COP	2026-02-27	368	\N	1
369	CTA369	1	119619.74	COP	2026-02-27	369	\N	1
370	CTA370	1	970137.61	COP	2026-02-27	370	\N	1
371	CTA371	1	445739.41	COP	2026-02-27	371	\N	1
372	CTA372	1	468965.74	COP	2026-02-27	372	\N	1
373	CTA373	1	496468.60	COP	2026-02-27	373	\N	1
374	CTA374	1	669972.14	COP	2026-02-27	374	\N	1
375	CTA375	1	85402.97	COP	2026-02-27	375	\N	1
376	CTA376	1	728983.60	COP	2026-02-27	376	\N	1
377	CTA377	1	8683.37	COP	2026-02-27	377	\N	1
378	CTA378	1	361551.44	COP	2026-02-27	378	\N	1
379	CTA379	1	902749.66	COP	2026-02-27	379	\N	1
380	CTA380	1	158341.53	COP	2026-02-27	380	\N	1
381	CTA381	1	467606.18	COP	2026-02-27	381	\N	1
382	CTA382	1	159740.67	COP	2026-02-27	382	\N	1
383	CTA383	1	966244.02	COP	2026-02-27	383	\N	1
384	CTA384	1	628848.30	COP	2026-02-27	384	\N	1
385	CTA385	1	627883.90	COP	2026-02-27	385	\N	1
386	CTA386	1	515777.37	COP	2026-02-27	386	\N	1
387	CTA387	1	631656.52	COP	2026-02-27	387	\N	1
388	CTA388	1	673522.29	COP	2026-02-27	388	\N	1
389	CTA389	1	65505.76	COP	2026-02-27	389	\N	1
390	CTA390	1	860777.03	COP	2026-02-27	390	\N	1
391	CTA391	1	576795.57	COP	2026-02-27	391	\N	1
392	CTA392	1	316058.87	COP	2026-02-27	392	\N	1
393	CTA393	1	799490.32	COP	2026-02-27	393	\N	1
394	CTA394	1	497314.54	COP	2026-02-27	394	\N	1
395	CTA395	1	628554.27	COP	2026-02-27	395	\N	1
396	CTA396	1	925378.63	COP	2026-02-27	396	\N	1
397	CTA397	1	328459.19	COP	2026-02-27	397	\N	1
398	CTA398	1	188518.68	COP	2026-02-27	398	\N	1
399	CTA399	1	409312.73	COP	2026-02-27	399	\N	1
400	CTA400	1	907359.10	COP	2026-02-27	400	\N	1
401	CTA401	1	649868.55	COP	2026-02-27	401	\N	1
402	CTA402	1	487997.42	COP	2026-02-27	402	\N	1
403	CTA403	1	9952.30	COP	2026-02-27	403	\N	1
404	CTA404	1	671325.88	COP	2026-02-27	404	\N	1
405	CTA405	1	341172.11	COP	2026-02-27	405	\N	1
406	CTA406	1	130037.61	COP	2026-02-27	406	\N	1
407	CTA407	1	162260.10	COP	2026-02-27	407	\N	1
408	CTA408	1	130540.75	COP	2026-02-27	408	\N	1
409	CTA409	1	604374.15	COP	2026-02-27	409	\N	1
410	CTA410	1	625624.47	COP	2026-02-27	410	\N	1
411	CTA411	1	304456.95	COP	2026-02-27	411	\N	1
412	CTA412	1	143160.42	COP	2026-02-27	412	\N	1
413	CTA413	1	175302.22	COP	2026-02-27	413	\N	1
414	CTA414	1	255227.95	COP	2026-02-27	414	\N	1
415	CTA415	1	406418.77	COP	2026-02-27	415	\N	1
416	CTA416	1	177484.32	COP	2026-02-27	416	\N	1
417	CTA417	1	355780.23	COP	2026-02-27	417	\N	1
418	CTA418	1	624649.46	COP	2026-02-27	418	\N	1
419	CTA419	1	966531.20	COP	2026-02-27	419	\N	1
420	CTA420	1	451086.87	COP	2026-02-27	420	\N	1
421	CTA421	1	90059.11	COP	2026-02-27	421	\N	1
422	CTA422	1	241950.84	COP	2026-02-27	422	\N	1
423	CTA423	1	96711.76	COP	2026-02-27	423	\N	1
424	CTA424	1	664322.31	COP	2026-02-27	424	\N	1
425	CTA425	1	955024.90	COP	2026-02-27	425	\N	1
426	CTA426	1	637787.52	COP	2026-02-27	426	\N	1
427	CTA427	1	728922.17	COP	2026-02-27	427	\N	1
428	CTA428	1	37863.01	COP	2026-02-27	428	\N	1
429	CTA429	1	989956.64	COP	2026-02-27	429	\N	1
430	CTA430	1	141642.26	COP	2026-02-27	430	\N	1
431	CTA431	1	313436.34	COP	2026-02-27	431	\N	1
432	CTA432	1	372819.64	COP	2026-02-27	432	\N	1
433	CTA433	1	54196.64	COP	2026-02-27	433	\N	1
434	CTA434	1	187371.18	COP	2026-02-27	434	\N	1
435	CTA435	1	323924.00	COP	2026-02-27	435	\N	1
436	CTA436	1	669911.47	COP	2026-02-27	436	\N	1
437	CTA437	1	937300.58	COP	2026-02-27	437	\N	1
438	CTA438	1	566525.41	COP	2026-02-27	438	\N	1
439	CTA439	1	42908.53	COP	2026-02-27	439	\N	1
440	CTA440	1	854432.12	COP	2026-02-27	440	\N	1
441	CTA441	1	462219.04	COP	2026-02-27	441	\N	1
442	CTA442	1	986062.35	COP	2026-02-27	442	\N	1
443	CTA443	1	277530.42	COP	2026-02-27	443	\N	1
444	CTA444	1	532620.67	COP	2026-02-27	444	\N	1
445	CTA445	1	565834.58	COP	2026-02-27	445	\N	1
446	CTA446	1	432155.48	COP	2026-02-27	446	\N	1
447	CTA447	1	442384.80	COP	2026-02-27	447	\N	1
448	CTA448	1	958983.91	COP	2026-02-27	448	\N	1
449	CTA449	1	928660.71	COP	2026-02-27	449	\N	1
450	CTA450	1	494852.08	COP	2026-02-27	450	\N	1
451	CTA451	1	14824.62	COP	2026-02-27	451	\N	1
452	CTA452	1	915069.59	COP	2026-02-27	452	\N	1
453	CTA453	1	941024.55	COP	2026-02-27	453	\N	1
454	CTA454	1	697504.73	COP	2026-02-27	454	\N	1
455	CTA455	1	927275.42	COP	2026-02-27	455	\N	1
456	CTA456	1	285073.47	COP	2026-02-27	456	\N	1
457	CTA457	1	762386.16	COP	2026-02-27	457	\N	1
458	CTA458	1	534972.83	COP	2026-02-27	458	\N	1
459	CTA459	1	901360.78	COP	2026-02-27	459	\N	1
460	CTA460	1	564151.95	COP	2026-02-27	460	\N	1
461	CTA461	1	778208.30	COP	2026-02-27	461	\N	1
462	CTA462	1	835470.97	COP	2026-02-27	462	\N	1
463	CTA463	1	810028.20	COP	2026-02-27	463	\N	1
464	CTA464	1	162460.69	COP	2026-02-27	464	\N	1
465	CTA465	1	766011.39	COP	2026-02-27	465	\N	1
466	CTA466	1	640778.60	COP	2026-02-27	466	\N	1
467	CTA467	1	803101.31	COP	2026-02-27	467	\N	1
468	CTA468	1	643967.51	COP	2026-02-27	468	\N	1
469	CTA469	1	542267.20	COP	2026-02-27	469	\N	1
470	CTA470	1	35763.17	COP	2026-02-27	470	\N	1
471	CTA471	1	558419.42	COP	2026-02-27	471	\N	1
472	CTA472	1	200141.80	COP	2026-02-27	472	\N	1
473	CTA473	1	586952.00	COP	2026-02-27	473	\N	1
474	CTA474	1	560779.16	COP	2026-02-27	474	\N	1
475	CTA475	1	735779.95	COP	2026-02-27	475	\N	1
476	CTA476	1	757955.87	COP	2026-02-27	476	\N	1
477	CTA477	1	942159.07	COP	2026-02-27	477	\N	1
478	CTA478	1	550423.07	COP	2026-02-27	478	\N	1
479	CTA479	1	405178.28	COP	2026-02-27	479	\N	1
480	CTA480	1	107703.53	COP	2026-02-27	480	\N	1
481	CTA481	1	224684.49	COP	2026-02-27	481	\N	1
482	CTA482	1	203885.86	COP	2026-02-27	482	\N	1
483	CTA483	1	85763.33	COP	2026-02-27	483	\N	1
484	CTA484	1	561862.37	COP	2026-02-27	484	\N	1
485	CTA485	1	417945.56	COP	2026-02-27	485	\N	1
486	CTA486	1	336754.99	COP	2026-02-27	486	\N	1
487	CTA487	1	861104.14	COP	2026-02-27	487	\N	1
488	CTA488	1	311519.35	COP	2026-02-27	488	\N	1
489	CTA489	1	350222.91	COP	2026-02-27	489	\N	1
490	CTA490	1	251748.64	COP	2026-02-27	490	\N	1
491	CTA491	1	322180.07	COP	2026-02-27	491	\N	1
492	CTA492	1	996883.09	COP	2026-02-27	492	\N	1
493	CTA493	1	56024.85	COP	2026-02-27	493	\N	1
494	CTA494	1	634562.74	COP	2026-02-27	494	\N	1
495	CTA495	1	576198.06	COP	2026-02-27	495	\N	1
496	CTA496	1	884190.72	COP	2026-02-27	496	\N	1
497	CTA497	1	112204.87	COP	2026-02-27	497	\N	1
498	CTA498	1	643846.31	COP	2026-02-27	498	\N	1
499	CTA499	1	690108.18	COP	2026-02-27	499	\N	1
500	CTA500	1	100643.02	COP	2026-02-27	500	\N	1
501	CTA501	1	557417.62	COP	2026-02-27	501	\N	1
502	CTA502	1	874429.80	COP	2026-02-27	502	\N	1
503	CTA503	1	114493.43	COP	2026-02-27	503	\N	1
504	CTA504	1	741963.57	COP	2026-02-27	504	\N	1
505	CTA505	1	876414.08	COP	2026-02-27	505	\N	1
506	CTA506	1	506713.31	COP	2026-02-27	506	\N	1
507	CTA507	1	594168.48	COP	2026-02-27	507	\N	1
508	CTA508	1	175964.16	COP	2026-02-27	508	\N	1
509	CTA509	1	596669.34	COP	2026-02-27	509	\N	1
510	CTA510	1	636158.85	COP	2026-02-27	510	\N	1
511	CTA511	1	688031.24	COP	2026-02-27	511	\N	1
512	CTA512	1	255165.95	COP	2026-02-27	512	\N	1
513	CTA513	1	314246.11	COP	2026-02-27	513	\N	1
514	CTA514	1	287458.16	COP	2026-02-27	514	\N	1
515	CTA515	1	898850.55	COP	2026-02-27	515	\N	1
516	CTA516	1	984851.17	COP	2026-02-27	516	\N	1
517	CTA517	1	63928.72	COP	2026-02-27	517	\N	1
518	CTA518	1	750.69	COP	2026-02-27	518	\N	1
519	CTA519	1	661601.60	COP	2026-02-27	519	\N	1
520	CTA520	1	286088.47	COP	2026-02-27	520	\N	1
521	CTA521	1	612106.06	COP	2026-02-27	521	\N	1
522	CTA522	1	824505.96	COP	2026-02-27	522	\N	1
523	CTA523	1	513859.59	COP	2026-02-27	523	\N	1
524	CTA524	1	6112.42	COP	2026-02-27	524	\N	1
525	CTA525	1	881404.48	COP	2026-02-27	525	\N	1
526	CTA526	1	597447.99	COP	2026-02-27	526	\N	1
527	CTA527	1	510941.34	COP	2026-02-27	527	\N	1
528	CTA528	1	233114.90	COP	2026-02-27	528	\N	1
529	CTA529	1	685968.12	COP	2026-02-27	529	\N	1
530	CTA530	1	213890.06	COP	2026-02-27	530	\N	1
531	CTA531	1	95534.11	COP	2026-02-27	531	\N	1
532	CTA532	1	805960.77	COP	2026-02-27	532	\N	1
533	CTA533	1	477105.33	COP	2026-02-27	533	\N	1
534	CTA534	1	989570.68	COP	2026-02-27	534	\N	1
535	CTA535	1	834716.26	COP	2026-02-27	535	\N	1
536	CTA536	1	598524.89	COP	2026-02-27	536	\N	1
537	CTA537	1	340402.07	COP	2026-02-27	537	\N	1
538	CTA538	1	832059.80	COP	2026-02-27	538	\N	1
539	CTA539	1	833754.97	COP	2026-02-27	539	\N	1
540	CTA540	1	223536.36	COP	2026-02-27	540	\N	1
541	CTA541	1	236943.44	COP	2026-02-27	541	\N	1
542	CTA542	1	342908.38	COP	2026-02-27	542	\N	1
543	CTA543	1	430481.51	COP	2026-02-27	543	\N	1
544	CTA544	1	986481.77	COP	2026-02-27	544	\N	1
545	CTA545	1	941900.53	COP	2026-02-27	545	\N	1
546	CTA546	1	271162.40	COP	2026-02-27	546	\N	1
547	CTA547	1	177937.74	COP	2026-02-27	547	\N	1
548	CTA548	1	880682.91	COP	2026-02-27	548	\N	1
549	CTA549	1	222215.43	COP	2026-02-27	549	\N	1
550	CTA550	1	483366.83	COP	2026-02-27	550	\N	1
551	CTA551	1	981007.41	COP	2026-02-27	551	\N	1
552	CTA552	1	564549.10	COP	2026-02-27	552	\N	1
553	CTA553	1	777253.79	COP	2026-02-27	553	\N	1
554	CTA554	1	40870.84	COP	2026-02-27	554	\N	1
555	CTA555	1	907085.38	COP	2026-02-27	555	\N	1
556	CTA556	1	8256.05	COP	2026-02-27	556	\N	1
557	CTA557	1	218020.84	COP	2026-02-27	557	\N	1
558	CTA558	1	68187.85	COP	2026-02-27	558	\N	1
559	CTA559	1	14260.89	COP	2026-02-27	559	\N	1
560	CTA560	1	708476.66	COP	2026-02-27	560	\N	1
561	CTA561	1	4276.76	COP	2026-02-27	561	\N	1
562	CTA562	1	174008.19	COP	2026-02-27	562	\N	1
563	CTA563	1	387210.83	COP	2026-02-27	563	\N	1
564	CTA564	1	624109.09	COP	2026-02-27	564	\N	1
565	CTA565	1	763089.45	COP	2026-02-27	565	\N	1
566	CTA566	1	907444.78	COP	2026-02-27	566	\N	1
567	CTA567	1	252515.29	COP	2026-02-27	567	\N	1
568	CTA568	1	234693.84	COP	2026-02-27	568	\N	1
569	CTA569	1	558263.53	COP	2026-02-27	569	\N	1
570	CTA570	1	84107.98	COP	2026-02-27	570	\N	1
571	CTA571	1	265501.82	COP	2026-02-27	571	\N	1
572	CTA572	1	550562.91	COP	2026-02-27	572	\N	1
573	CTA573	1	841368.59	COP	2026-02-27	573	\N	1
574	CTA574	1	235178.35	COP	2026-02-27	574	\N	1
575	CTA575	1	490714.66	COP	2026-02-27	575	\N	1
576	CTA576	1	658339.70	COP	2026-02-27	576	\N	1
577	CTA577	1	189981.23	COP	2026-02-27	577	\N	1
578	CTA578	1	239933.28	COP	2026-02-27	578	\N	1
579	CTA579	1	887027.49	COP	2026-02-27	579	\N	1
580	CTA580	1	833048.27	COP	2026-02-27	580	\N	1
581	CTA581	1	820860.12	COP	2026-02-27	581	\N	1
582	CTA582	1	739977.34	COP	2026-02-27	582	\N	1
583	CTA583	1	609564.08	COP	2026-02-27	583	\N	1
584	CTA584	1	435723.88	COP	2026-02-27	584	\N	1
585	CTA585	1	933629.67	COP	2026-02-27	585	\N	1
586	CTA586	1	379943.61	COP	2026-02-27	586	\N	1
587	CTA587	1	607844.14	COP	2026-02-27	587	\N	1
588	CTA588	1	827740.18	COP	2026-02-27	588	\N	1
589	CTA589	1	399412.05	COP	2026-02-27	589	\N	1
590	CTA590	1	301480.58	COP	2026-02-27	590	\N	1
591	CTA591	1	725565.40	COP	2026-02-27	591	\N	1
592	CTA592	1	623993.10	COP	2026-02-27	592	\N	1
593	CTA593	1	283264.39	COP	2026-02-27	593	\N	1
594	CTA594	1	65448.70	COP	2026-02-27	594	\N	1
595	CTA595	1	578357.90	COP	2026-02-27	595	\N	1
596	CTA596	1	729230.77	COP	2026-02-27	596	\N	1
597	CTA597	1	145394.80	COP	2026-02-27	597	\N	1
598	CTA598	1	512351.07	COP	2026-02-27	598	\N	1
599	CTA599	1	919503.80	COP	2026-02-27	599	\N	1
600	CTA600	1	840418.94	COP	2026-02-27	600	\N	1
601	CTA601	1	314077.03	COP	2026-02-27	601	\N	1
602	CTA602	1	476349.85	COP	2026-02-27	602	\N	1
603	CTA603	1	634242.96	COP	2026-02-27	603	\N	1
604	CTA604	1	575856.73	COP	2026-02-27	604	\N	1
605	CTA605	1	213307.34	COP	2026-02-27	605	\N	1
606	CTA606	1	864639.68	COP	2026-02-27	606	\N	1
607	CTA607	1	526858.04	COP	2026-02-27	607	\N	1
608	CTA608	1	214977.81	COP	2026-02-27	608	\N	1
609	CTA609	1	987116.31	COP	2026-02-27	609	\N	1
610	CTA610	1	935818.25	COP	2026-02-27	610	\N	1
611	CTA611	1	227524.27	COP	2026-02-27	611	\N	1
612	CTA612	1	445212.40	COP	2026-02-27	612	\N	1
613	CTA613	1	450939.22	COP	2026-02-27	613	\N	1
614	CTA614	1	828364.50	COP	2026-02-27	614	\N	1
615	CTA615	1	723408.21	COP	2026-02-27	615	\N	1
616	CTA616	1	209913.28	COP	2026-02-27	616	\N	1
617	CTA617	1	970345.57	COP	2026-02-27	617	\N	1
618	CTA618	1	898248.19	COP	2026-02-27	618	\N	1
619	CTA619	1	388605.81	COP	2026-02-27	619	\N	1
620	CTA620	1	462395.47	COP	2026-02-27	620	\N	1
621	CTA621	1	699736.52	COP	2026-02-27	621	\N	1
622	CTA622	1	392868.62	COP	2026-02-27	622	\N	1
623	CTA623	1	908027.60	COP	2026-02-27	623	\N	1
624	CTA624	1	579562.30	COP	2026-02-27	624	\N	1
625	CTA625	1	15490.30	COP	2026-02-27	625	\N	1
626	CTA626	1	92161.62	COP	2026-02-27	626	\N	1
627	CTA627	1	189617.03	COP	2026-02-27	627	\N	1
628	CTA628	1	960663.77	COP	2026-02-27	628	\N	1
629	CTA629	1	942302.34	COP	2026-02-27	629	\N	1
630	CTA630	1	360569.01	COP	2026-02-27	630	\N	1
631	CTA631	1	135141.41	COP	2026-02-27	631	\N	1
632	CTA632	1	589346.10	COP	2026-02-27	632	\N	1
633	CTA633	1	153199.06	COP	2026-02-27	633	\N	1
634	CTA634	1	359845.31	COP	2026-02-27	634	\N	1
635	CTA635	1	659262.58	COP	2026-02-27	635	\N	1
636	CTA636	1	770713.34	COP	2026-02-27	636	\N	1
637	CTA637	1	206490.43	COP	2026-02-27	637	\N	1
638	CTA638	1	902571.38	COP	2026-02-27	638	\N	1
639	CTA639	1	572761.37	COP	2026-02-27	639	\N	1
640	CTA640	1	785305.35	COP	2026-02-27	640	\N	1
641	CTA641	1	855322.01	COP	2026-02-27	641	\N	1
642	CTA642	1	235308.36	COP	2026-02-27	642	\N	1
643	CTA643	1	903842.73	COP	2026-02-27	643	\N	1
644	CTA644	1	736964.40	COP	2026-02-27	644	\N	1
645	CTA645	1	222654.00	COP	2026-02-27	645	\N	1
646	CTA646	1	975753.60	COP	2026-02-27	646	\N	1
647	CTA647	1	883163.71	COP	2026-02-27	647	\N	1
648	CTA648	1	726151.44	COP	2026-02-27	648	\N	1
649	CTA649	1	789418.65	COP	2026-02-27	649	\N	1
650	CTA650	1	755107.16	COP	2026-02-27	650	\N	1
651	CTA651	1	462179.88	COP	2026-02-27	651	\N	1
652	CTA652	1	376299.11	COP	2026-02-27	652	\N	1
653	CTA653	1	231201.29	COP	2026-02-27	653	\N	1
654	CTA654	1	198923.28	COP	2026-02-27	654	\N	1
655	CTA655	1	277339.64	COP	2026-02-27	655	\N	1
656	CTA656	1	357808.64	COP	2026-02-27	656	\N	1
657	CTA657	1	608422.52	COP	2026-02-27	657	\N	1
658	CTA658	1	183504.78	COP	2026-02-27	658	\N	1
659	CTA659	1	115457.87	COP	2026-02-27	659	\N	1
660	CTA660	1	606152.71	COP	2026-02-27	660	\N	1
661	CTA661	1	161971.52	COP	2026-02-27	661	\N	1
662	CTA662	1	69345.93	COP	2026-02-27	662	\N	1
663	CTA663	1	245944.63	COP	2026-02-27	663	\N	1
664	CTA664	1	398370.43	COP	2026-02-27	664	\N	1
665	CTA665	1	161979.06	COP	2026-02-27	665	\N	1
666	CTA666	1	847020.16	COP	2026-02-27	666	\N	1
667	CTA667	1	580704.63	COP	2026-02-27	667	\N	1
668	CTA668	1	186692.10	COP	2026-02-27	668	\N	1
669	CTA669	1	891345.68	COP	2026-02-27	669	\N	1
670	CTA670	1	633322.29	COP	2026-02-27	670	\N	1
671	CTA671	1	890404.90	COP	2026-02-27	671	\N	1
672	CTA672	1	22546.11	COP	2026-02-27	672	\N	1
673	CTA673	1	626737.32	COP	2026-02-27	673	\N	1
674	CTA674	1	764831.28	COP	2026-02-27	674	\N	1
675	CTA675	1	998235.52	COP	2026-02-27	675	\N	1
676	CTA676	1	649524.55	COP	2026-02-27	676	\N	1
677	CTA677	1	459482.37	COP	2026-02-27	677	\N	1
678	CTA678	1	200135.27	COP	2026-02-27	678	\N	1
679	CTA679	1	241744.24	COP	2026-02-27	679	\N	1
680	CTA680	1	671699.25	COP	2026-02-27	680	\N	1
681	CTA681	1	145516.41	COP	2026-02-27	681	\N	1
682	CTA682	1	93493.77	COP	2026-02-27	682	\N	1
683	CTA683	1	973090.06	COP	2026-02-27	683	\N	1
684	CTA684	1	653098.06	COP	2026-02-27	684	\N	1
685	CTA685	1	746319.62	COP	2026-02-27	685	\N	1
686	CTA686	1	184298.94	COP	2026-02-27	686	\N	1
687	CTA687	1	174467.76	COP	2026-02-27	687	\N	1
688	CTA688	1	866757.43	COP	2026-02-27	688	\N	1
689	CTA689	1	863025.07	COP	2026-02-27	689	\N	1
690	CTA690	1	947890.89	COP	2026-02-27	690	\N	1
691	CTA691	1	725610.29	COP	2026-02-27	691	\N	1
692	CTA692	1	424567.84	COP	2026-02-27	692	\N	1
693	CTA693	1	859529.29	COP	2026-02-27	693	\N	1
694	CTA694	1	738608.39	COP	2026-02-27	694	\N	1
695	CTA695	1	692554.76	COP	2026-02-27	695	\N	1
696	CTA696	1	715508.37	COP	2026-02-27	696	\N	1
697	CTA697	1	820090.80	COP	2026-02-27	697	\N	1
698	CTA698	1	440091.74	COP	2026-02-27	698	\N	1
699	CTA699	1	909537.13	COP	2026-02-27	699	\N	1
700	CTA700	1	70214.49	COP	2026-02-27	700	\N	1
701	CTA701	1	423586.58	COP	2026-02-27	701	\N	1
702	CTA702	1	37501.41	COP	2026-02-27	702	\N	1
703	CTA703	1	759771.00	COP	2026-02-27	703	\N	1
704	CTA704	1	73472.16	COP	2026-02-27	704	\N	1
705	CTA705	1	100394.82	COP	2026-02-27	705	\N	1
706	CTA706	1	297411.40	COP	2026-02-27	706	\N	1
707	CTA707	1	678289.42	COP	2026-02-27	707	\N	1
708	CTA708	1	447329.07	COP	2026-02-27	708	\N	1
709	CTA709	1	236439.99	COP	2026-02-27	709	\N	1
710	CTA710	1	21183.07	COP	2026-02-27	710	\N	1
711	CTA711	1	877232.27	COP	2026-02-27	711	\N	1
712	CTA712	1	730632.38	COP	2026-02-27	712	\N	1
713	CTA713	1	115513.88	COP	2026-02-27	713	\N	1
714	CTA714	1	339212.15	COP	2026-02-27	714	\N	1
715	CTA715	1	668205.43	COP	2026-02-27	715	\N	1
716	CTA716	1	342499.51	COP	2026-02-27	716	\N	1
717	CTA717	1	730782.52	COP	2026-02-27	717	\N	1
718	CTA718	1	81442.18	COP	2026-02-27	718	\N	1
719	CTA719	1	616357.58	COP	2026-02-27	719	\N	1
720	CTA720	1	61102.64	COP	2026-02-27	720	\N	1
721	CTA721	1	673266.66	COP	2026-02-27	721	\N	1
722	CTA722	1	511383.45	COP	2026-02-27	722	\N	1
723	CTA723	1	963692.28	COP	2026-02-27	723	\N	1
724	CTA724	1	15757.80	COP	2026-02-27	724	\N	1
725	CTA725	1	812054.56	COP	2026-02-27	725	\N	1
726	CTA726	1	330657.39	COP	2026-02-27	726	\N	1
727	CTA727	1	347397.65	COP	2026-02-27	727	\N	1
728	CTA728	1	405718.08	COP	2026-02-27	728	\N	1
729	CTA729	1	987975.11	COP	2026-02-27	729	\N	1
730	CTA730	1	912.66	COP	2026-02-27	730	\N	1
731	CTA731	1	989405.92	COP	2026-02-27	731	\N	1
732	CTA732	1	99438.14	COP	2026-02-27	732	\N	1
733	CTA733	1	899125.40	COP	2026-02-27	733	\N	1
734	CTA734	1	620610.54	COP	2026-02-27	734	\N	1
735	CTA735	1	309581.62	COP	2026-02-27	735	\N	1
736	CTA736	1	917172.65	COP	2026-02-27	736	\N	1
737	CTA737	1	838309.37	COP	2026-02-27	737	\N	1
738	CTA738	1	621795.07	COP	2026-02-27	738	\N	1
739	CTA739	1	445720.37	COP	2026-02-27	739	\N	1
740	CTA740	1	925167.46	COP	2026-02-27	740	\N	1
741	CTA741	1	747678.93	COP	2026-02-27	741	\N	1
742	CTA742	1	304103.08	COP	2026-02-27	742	\N	1
743	CTA743	1	96188.48	COP	2026-02-27	743	\N	1
744	CTA744	1	194598.85	COP	2026-02-27	744	\N	1
745	CTA745	1	319804.17	COP	2026-02-27	745	\N	1
746	CTA746	1	381722.14	COP	2026-02-27	746	\N	1
747	CTA747	1	521939.13	COP	2026-02-27	747	\N	1
748	CTA748	1	394045.91	COP	2026-02-27	748	\N	1
749	CTA749	1	824049.21	COP	2026-02-27	749	\N	1
750	CTA750	1	960711.42	COP	2026-02-27	750	\N	1
751	CTA751	1	136810.34	COP	2026-02-27	751	\N	1
752	CTA752	1	954517.31	COP	2026-02-27	752	\N	1
753	CTA753	1	21352.71	COP	2026-02-27	753	\N	1
754	CTA754	1	870441.95	COP	2026-02-27	754	\N	1
755	CTA755	1	406798.58	COP	2026-02-27	755	\N	1
756	CTA756	1	734425.53	COP	2026-02-27	756	\N	1
757	CTA757	1	574029.96	COP	2026-02-27	757	\N	1
758	CTA758	1	707548.15	COP	2026-02-27	758	\N	1
759	CTA759	1	822700.01	COP	2026-02-27	759	\N	1
760	CTA760	1	225339.56	COP	2026-02-27	760	\N	1
761	CTA761	1	593045.08	COP	2026-02-27	761	\N	1
762	CTA762	1	580905.50	COP	2026-02-27	762	\N	1
763	CTA763	1	315560.68	COP	2026-02-27	763	\N	1
764	CTA764	1	365174.22	COP	2026-02-27	764	\N	1
765	CTA765	1	129491.36	COP	2026-02-27	765	\N	1
766	CTA766	1	639618.71	COP	2026-02-27	766	\N	1
767	CTA767	1	983163.71	COP	2026-02-27	767	\N	1
768	CTA768	1	624625.91	COP	2026-02-27	768	\N	1
769	CTA769	1	963243.96	COP	2026-02-27	769	\N	1
770	CTA770	1	998699.03	COP	2026-02-27	770	\N	1
771	CTA771	1	963586.47	COP	2026-02-27	771	\N	1
772	CTA772	1	699824.47	COP	2026-02-27	772	\N	1
773	CTA773	1	33930.54	COP	2026-02-27	773	\N	1
774	CTA774	1	226831.46	COP	2026-02-27	774	\N	1
775	CTA775	1	938692.35	COP	2026-02-27	775	\N	1
776	CTA776	1	159721.68	COP	2026-02-27	776	\N	1
777	CTA777	1	436730.59	COP	2026-02-27	777	\N	1
778	CTA778	1	497409.25	COP	2026-02-27	778	\N	1
779	CTA779	1	551675.22	COP	2026-02-27	779	\N	1
780	CTA780	1	165041.68	COP	2026-02-27	780	\N	1
781	CTA781	1	368862.30	COP	2026-02-27	781	\N	1
782	CTA782	1	160446.68	COP	2026-02-27	782	\N	1
783	CTA783	1	378209.06	COP	2026-02-27	783	\N	1
784	CTA784	1	425164.18	COP	2026-02-27	784	\N	1
785	CTA785	1	425591.74	COP	2026-02-27	785	\N	1
786	CTA786	1	887360.99	COP	2026-02-27	786	\N	1
787	CTA787	1	804068.04	COP	2026-02-27	787	\N	1
788	CTA788	1	125997.40	COP	2026-02-27	788	\N	1
789	CTA789	1	666582.30	COP	2026-02-27	789	\N	1
790	CTA790	1	37330.38	COP	2026-02-27	790	\N	1
791	CTA791	1	390493.22	COP	2026-02-27	791	\N	1
792	CTA792	1	433677.10	COP	2026-02-27	792	\N	1
793	CTA793	1	557507.84	COP	2026-02-27	793	\N	1
794	CTA794	1	851135.07	COP	2026-02-27	794	\N	1
795	CTA795	1	247816.99	COP	2026-02-27	795	\N	1
796	CTA796	1	681038.24	COP	2026-02-27	796	\N	1
797	CTA797	1	438605.55	COP	2026-02-27	797	\N	1
798	CTA798	1	189746.35	COP	2026-02-27	798	\N	1
799	CTA799	1	845419.47	COP	2026-02-27	799	\N	1
800	CTA800	1	764881.93	COP	2026-02-27	800	\N	1
801	CTA801	1	867096.70	COP	2026-02-27	801	\N	1
802	CTA802	1	964474.50	COP	2026-02-27	802	\N	1
803	CTA803	1	370411.74	COP	2026-02-27	803	\N	1
804	CTA804	1	704036.15	COP	2026-02-27	804	\N	1
805	CTA805	1	291446.37	COP	2026-02-27	805	\N	1
806	CTA806	1	596821.53	COP	2026-02-27	806	\N	1
807	CTA807	1	280442.47	COP	2026-02-27	807	\N	1
808	CTA808	1	774769.64	COP	2026-02-27	808	\N	1
809	CTA809	1	867078.95	COP	2026-02-27	809	\N	1
810	CTA810	1	185107.33	COP	2026-02-27	810	\N	1
811	CTA811	1	202391.96	COP	2026-02-27	811	\N	1
812	CTA812	1	134484.01	COP	2026-02-27	812	\N	1
813	CTA813	1	622749.93	COP	2026-02-27	813	\N	1
814	CTA814	1	408916.56	COP	2026-02-27	814	\N	1
815	CTA815	1	805270.21	COP	2026-02-27	815	\N	1
816	CTA816	1	867955.84	COP	2026-02-27	816	\N	1
817	CTA817	1	239220.04	COP	2026-02-27	817	\N	1
818	CTA818	1	331230.81	COP	2026-02-27	818	\N	1
819	CTA819	1	830632.31	COP	2026-02-27	819	\N	1
820	CTA820	1	635377.32	COP	2026-02-27	820	\N	1
821	CTA821	1	267230.43	COP	2026-02-27	821	\N	1
822	CTA822	1	123467.09	COP	2026-02-27	822	\N	1
823	CTA823	1	338705.55	COP	2026-02-27	823	\N	1
824	CTA824	1	88369.25	COP	2026-02-27	824	\N	1
825	CTA825	1	625014.92	COP	2026-02-27	825	\N	1
826	CTA826	1	216257.29	COP	2026-02-27	826	\N	1
827	CTA827	1	83400.43	COP	2026-02-27	827	\N	1
828	CTA828	1	888280.05	COP	2026-02-27	828	\N	1
829	CTA829	1	681557.22	COP	2026-02-27	829	\N	1
830	CTA830	1	74831.67	COP	2026-02-27	830	\N	1
831	CTA831	1	161030.83	COP	2026-02-27	831	\N	1
832	CTA832	1	900883.23	COP	2026-02-27	832	\N	1
833	CTA833	1	843301.00	COP	2026-02-27	833	\N	1
834	CTA834	1	405241.34	COP	2026-02-27	834	\N	1
835	CTA835	1	557971.95	COP	2026-02-27	835	\N	1
836	CTA836	1	177313.78	COP	2026-02-27	836	\N	1
837	CTA837	1	545485.40	COP	2026-02-27	837	\N	1
838	CTA838	1	645634.35	COP	2026-02-27	838	\N	1
839	CTA839	1	442108.60	COP	2026-02-27	839	\N	1
840	CTA840	1	49250.78	COP	2026-02-27	840	\N	1
841	CTA841	1	725107.81	COP	2026-02-27	841	\N	1
842	CTA842	1	677753.94	COP	2026-02-27	842	\N	1
843	CTA843	1	827554.33	COP	2026-02-27	843	\N	1
844	CTA844	1	336928.35	COP	2026-02-27	844	\N	1
845	CTA845	1	999553.20	COP	2026-02-27	845	\N	1
846	CTA846	1	163636.80	COP	2026-02-27	846	\N	1
847	CTA847	1	165168.30	COP	2026-02-27	847	\N	1
848	CTA848	1	271185.73	COP	2026-02-27	848	\N	1
849	CTA849	1	757455.44	COP	2026-02-27	849	\N	1
850	CTA850	1	596359.68	COP	2026-02-27	850	\N	1
851	CTA851	1	271233.66	COP	2026-02-27	851	\N	1
852	CTA852	1	408071.25	COP	2026-02-27	852	\N	1
853	CTA853	1	125627.60	COP	2026-02-27	853	\N	1
854	CTA854	1	728054.97	COP	2026-02-27	854	\N	1
855	CTA855	1	404182.28	COP	2026-02-27	855	\N	1
856	CTA856	1	601079.31	COP	2026-02-27	856	\N	1
857	CTA857	1	210709.50	COP	2026-02-27	857	\N	1
858	CTA858	1	112026.28	COP	2026-02-27	858	\N	1
859	CTA859	1	912759.06	COP	2026-02-27	859	\N	1
860	CTA860	1	70743.59	COP	2026-02-27	860	\N	1
861	CTA861	1	306176.06	COP	2026-02-27	861	\N	1
862	CTA862	1	397039.85	COP	2026-02-27	862	\N	1
863	CTA863	1	218821.36	COP	2026-02-27	863	\N	1
864	CTA864	1	92158.30	COP	2026-02-27	864	\N	1
865	CTA865	1	971380.00	COP	2026-02-27	865	\N	1
866	CTA866	1	423695.10	COP	2026-02-27	866	\N	1
867	CTA867	1	981835.57	COP	2026-02-27	867	\N	1
868	CTA868	1	129397.04	COP	2026-02-27	868	\N	1
869	CTA869	1	320625.91	COP	2026-02-27	869	\N	1
870	CTA870	1	351965.68	COP	2026-02-27	870	\N	1
871	CTA871	1	239619.03	COP	2026-02-27	871	\N	1
872	CTA872	1	502443.48	COP	2026-02-27	872	\N	1
873	CTA873	1	967193.14	COP	2026-02-27	873	\N	1
874	CTA874	1	914208.49	COP	2026-02-27	874	\N	1
875	CTA875	1	500826.31	COP	2026-02-27	875	\N	1
876	CTA876	1	90732.74	COP	2026-02-27	876	\N	1
877	CTA877	1	143890.62	COP	2026-02-27	877	\N	1
878	CTA878	1	758734.65	COP	2026-02-27	878	\N	1
879	CTA879	1	438142.04	COP	2026-02-27	879	\N	1
880	CTA880	1	647345.63	COP	2026-02-27	880	\N	1
881	CTA881	1	101709.54	COP	2026-02-27	881	\N	1
882	CTA882	1	349132.83	COP	2026-02-27	882	\N	1
883	CTA883	1	295933.70	COP	2026-02-27	883	\N	1
884	CTA884	1	833064.06	COP	2026-02-27	884	\N	1
885	CTA885	1	107633.54	COP	2026-02-27	885	\N	1
886	CTA886	1	110639.56	COP	2026-02-27	886	\N	1
887	CTA887	1	608647.90	COP	2026-02-27	887	\N	1
888	CTA888	1	886755.37	COP	2026-02-27	888	\N	1
889	CTA889	1	385396.68	COP	2026-02-27	889	\N	1
890	CTA890	1	419464.89	COP	2026-02-27	890	\N	1
891	CTA891	1	937088.96	COP	2026-02-27	891	\N	1
892	CTA892	1	823199.48	COP	2026-02-27	892	\N	1
893	CTA893	1	388950.33	COP	2026-02-27	893	\N	1
894	CTA894	1	481580.95	COP	2026-02-27	894	\N	1
895	CTA895	1	221937.20	COP	2026-02-27	895	\N	1
896	CTA896	1	718892.12	COP	2026-02-27	896	\N	1
897	CTA897	1	633776.29	COP	2026-02-27	897	\N	1
898	CTA898	1	202028.96	COP	2026-02-27	898	\N	1
899	CTA899	1	850437.74	COP	2026-02-27	899	\N	1
900	CTA900	1	236866.98	COP	2026-02-27	900	\N	1
901	CTA901	1	247477.61	COP	2026-02-27	901	\N	1
902	CTA902	1	561792.51	COP	2026-02-27	902	\N	1
903	CTA903	1	635621.42	COP	2026-02-27	903	\N	1
904	CTA904	1	208659.25	COP	2026-02-27	904	\N	1
905	CTA905	1	705832.15	COP	2026-02-27	905	\N	1
906	CTA906	1	831990.56	COP	2026-02-27	906	\N	1
907	CTA907	1	517503.64	COP	2026-02-27	907	\N	1
908	CTA908	1	534547.44	COP	2026-02-27	908	\N	1
909	CTA909	1	660413.99	COP	2026-02-27	909	\N	1
910	CTA910	1	972979.74	COP	2026-02-27	910	\N	1
911	CTA911	1	51180.33	COP	2026-02-27	911	\N	1
912	CTA912	1	590775.27	COP	2026-02-27	912	\N	1
913	CTA913	1	643341.52	COP	2026-02-27	913	\N	1
914	CTA914	1	263207.46	COP	2026-02-27	914	\N	1
915	CTA915	1	549097.99	COP	2026-02-27	915	\N	1
916	CTA916	1	126026.11	COP	2026-02-27	916	\N	1
917	CTA917	1	673932.76	COP	2026-02-27	917	\N	1
918	CTA918	1	470741.71	COP	2026-02-27	918	\N	1
919	CTA919	1	973105.75	COP	2026-02-27	919	\N	1
920	CTA920	1	730746.74	COP	2026-02-27	920	\N	1
921	CTA921	1	932121.76	COP	2026-02-27	921	\N	1
922	CTA922	1	950850.46	COP	2026-02-27	922	\N	1
923	CTA923	1	608505.51	COP	2026-02-27	923	\N	1
924	CTA924	1	409740.94	COP	2026-02-27	924	\N	1
925	CTA925	1	135642.18	COP	2026-02-27	925	\N	1
926	CTA926	1	655644.49	COP	2026-02-27	926	\N	1
927	CTA927	1	274609.71	COP	2026-02-27	927	\N	1
928	CTA928	1	361108.05	COP	2026-02-27	928	\N	1
929	CTA929	1	835551.76	COP	2026-02-27	929	\N	1
930	CTA930	1	136028.62	COP	2026-02-27	930	\N	1
931	CTA931	1	368783.67	COP	2026-02-27	931	\N	1
932	CTA932	1	238582.18	COP	2026-02-27	932	\N	1
933	CTA933	1	754898.41	COP	2026-02-27	933	\N	1
934	CTA934	1	625265.06	COP	2026-02-27	934	\N	1
935	CTA935	1	554481.08	COP	2026-02-27	935	\N	1
936	CTA936	1	327006.27	COP	2026-02-27	936	\N	1
937	CTA937	1	621690.72	COP	2026-02-27	937	\N	1
938	CTA938	1	188706.32	COP	2026-02-27	938	\N	1
939	CTA939	1	704041.43	COP	2026-02-27	939	\N	1
940	CTA940	1	505119.77	COP	2026-02-27	940	\N	1
941	CTA941	1	839623.85	COP	2026-02-27	941	\N	1
942	CTA942	1	244902.78	COP	2026-02-27	942	\N	1
943	CTA943	1	544213.65	COP	2026-02-27	943	\N	1
944	CTA944	1	888486.14	COP	2026-02-27	944	\N	1
945	CTA945	1	719128.57	COP	2026-02-27	945	\N	1
946	CTA946	1	621622.85	COP	2026-02-27	946	\N	1
947	CTA947	1	798535.95	COP	2026-02-27	947	\N	1
948	CTA948	1	622334.25	COP	2026-02-27	948	\N	1
949	CTA949	1	762876.27	COP	2026-02-27	949	\N	1
950	CTA950	1	222129.28	COP	2026-02-27	950	\N	1
951	CTA951	1	545116.52	COP	2026-02-27	951	\N	1
952	CTA952	1	563503.90	COP	2026-02-27	952	\N	1
953	CTA953	1	869689.75	COP	2026-02-27	953	\N	1
954	CTA954	1	705713.48	COP	2026-02-27	954	\N	1
955	CTA955	1	917157.64	COP	2026-02-27	955	\N	1
956	CTA956	1	615895.11	COP	2026-02-27	956	\N	1
957	CTA957	1	558962.69	COP	2026-02-27	957	\N	1
958	CTA958	1	896457.76	COP	2026-02-27	958	\N	1
959	CTA959	1	958668.98	COP	2026-02-27	959	\N	1
960	CTA960	1	219975.84	COP	2026-02-27	960	\N	1
961	CTA961	1	914408.72	COP	2026-02-27	961	\N	1
962	CTA962	1	771947.95	COP	2026-02-27	962	\N	1
963	CTA963	1	600055.42	COP	2026-02-27	963	\N	1
964	CTA964	1	795728.92	COP	2026-02-27	964	\N	1
965	CTA965	1	999760.02	COP	2026-02-27	965	\N	1
966	CTA966	1	558021.64	COP	2026-02-27	966	\N	1
967	CTA967	1	299242.49	COP	2026-02-27	967	\N	1
968	CTA968	1	872013.18	COP	2026-02-27	968	\N	1
969	CTA969	1	215493.17	COP	2026-02-27	969	\N	1
970	CTA970	1	863461.25	COP	2026-02-27	970	\N	1
971	CTA971	1	502878.10	COP	2026-02-27	971	\N	1
972	CTA972	1	524636.60	COP	2026-02-27	972	\N	1
973	CTA973	1	447374.96	COP	2026-02-27	973	\N	1
974	CTA974	1	611876.15	COP	2026-02-27	974	\N	1
975	CTA975	1	499991.25	COP	2026-02-27	975	\N	1
976	CTA976	1	319172.90	COP	2026-02-27	976	\N	1
977	CTA977	1	69017.90	COP	2026-02-27	977	\N	1
978	CTA978	1	5662.36	COP	2026-02-27	978	\N	1
979	CTA979	1	138351.17	COP	2026-02-27	979	\N	1
980	CTA980	1	313123.90	COP	2026-02-27	980	\N	1
981	CTA981	1	26709.46	COP	2026-02-27	981	\N	1
982	CTA982	1	45446.51	COP	2026-02-27	982	\N	1
983	CTA983	1	353577.44	COP	2026-02-27	983	\N	1
984	CTA984	1	354519.52	COP	2026-02-27	984	\N	1
985	CTA985	1	898335.27	COP	2026-02-27	985	\N	1
986	CTA986	1	125671.95	COP	2026-02-27	986	\N	1
987	CTA987	1	283136.50	COP	2026-02-27	987	\N	1
988	CTA988	1	352395.67	COP	2026-02-27	988	\N	1
989	CTA989	1	890520.20	COP	2026-02-27	989	\N	1
990	CTA990	1	292237.64	COP	2026-02-27	990	\N	1
991	CTA991	1	565857.60	COP	2026-02-27	991	\N	1
992	CTA992	1	599463.41	COP	2026-02-27	992	\N	1
993	CTA993	1	419170.40	COP	2026-02-27	993	\N	1
994	CTA994	1	339947.00	COP	2026-02-27	994	\N	1
995	CTA995	1	546858.48	COP	2026-02-27	995	\N	1
996	CTA996	1	636063.81	COP	2026-02-27	996	\N	1
997	CTA997	1	960252.03	COP	2026-02-27	997	\N	1
998	CTA998	1	814395.00	COP	2026-02-27	998	\N	1
999	CTA999	1	652538.20	COP	2026-02-27	999	\N	1
1000	CTA1000	1	358714.80	COP	2026-02-27	1000	\N	1
\.


--
-- TOC entry 5104 (class 0 OID 16638)
-- Dependencies: 222
-- Data for Name: estado_general; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estado_general (id_estado, nombre_estado, tipo_estado) FROM stdin;
1	Activo	GENERAL
2	Inactivo	GENERAL
3	Bloqueado	GENERAL
4	En estudio	PRESTAMO
5	Aprobado	PRESTAMO
6	Rechazado	PRESTAMO
7	Desembolsado	PRESTAMO
8	Pendiente	TRANSFERENCIA
9	Ejecutada	TRANSFERENCIA
10	Vencida	TRANSFERENCIA
\.


--
-- TOC entry 5116 (class 0 OID 16769)
-- Dependencies: 234
-- Data for Name: prestamo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prestamo (id_prestamo, id_producto, monto_solicitado, monto_aprobado, tasa_interes, plazo_meses, fecha_creacion, fecha_aprobacion, fecha_desembolso, id_persona, id_empresa, id_cuenta_desembolso, id_analista, id_estado) FROM stdin;
1	3	34419206.97	12493034.50	12.50	24	2026-02-27	\N	\N	491	\N	\N	\N	4
2	3	13943163.17	19469279.79	12.50	24	2026-02-27	\N	\N	988	\N	\N	\N	4
3	3	27265325.27	13696989.64	12.50	24	2026-02-27	\N	\N	955	\N	\N	\N	4
4	3	48767198.82	24212395.01	12.50	24	2026-02-27	\N	\N	279	\N	\N	\N	4
5	3	37257956.99	35459005.60	12.50	24	2026-02-27	\N	\N	738	\N	\N	\N	4
6	3	19230749.53	31436265.64	12.50	24	2026-02-27	\N	\N	312	\N	\N	\N	4
7	3	41998657.94	7136617.44	12.50	24	2026-02-27	\N	\N	528	\N	\N	\N	4
8	3	22387364.82	31547348.76	12.50	24	2026-02-27	\N	\N	526	\N	\N	\N	4
9	3	14598460.26	27206231.88	12.50	24	2026-02-27	\N	\N	7	\N	\N	\N	4
10	3	19803776.89	27262006.22	12.50	24	2026-02-27	\N	\N	300	\N	\N	\N	4
11	3	26174694.05	8701121.03	12.50	24	2026-02-27	\N	\N	900	\N	\N	\N	4
12	3	31518727.70	17590377.67	12.50	24	2026-02-27	\N	\N	183	\N	\N	\N	4
13	3	37327714.39	13285997.19	12.50	24	2026-02-27	\N	\N	769	\N	\N	\N	4
14	3	26242564.78	25555844.22	12.50	24	2026-02-27	\N	\N	898	\N	\N	\N	4
15	3	42335145.69	22878122.98	12.50	24	2026-02-27	\N	\N	472	\N	\N	\N	4
16	3	36975555.09	25904093.72	12.50	24	2026-02-27	\N	\N	78	\N	\N	\N	4
17	3	33366668.62	12062605.54	12.50	24	2026-02-27	\N	\N	520	\N	\N	\N	4
18	3	38766529.51	36884915.76	12.50	24	2026-02-27	\N	\N	884	\N	\N	\N	4
19	3	45430162.49	39509879.69	12.50	24	2026-02-27	\N	\N	980	\N	\N	\N	4
20	3	26098495.81	2081773.39	12.50	24	2026-02-27	\N	\N	540	\N	\N	\N	4
21	3	15823975.42	15890414.38	12.50	24	2026-02-27	\N	\N	251	\N	\N	\N	4
22	3	3552681.07	6913217.14	12.50	24	2026-02-27	\N	\N	717	\N	\N	\N	4
23	3	36976088.61	3356588.61	12.50	24	2026-02-27	\N	\N	170	\N	\N	\N	4
24	3	46963292.96	37596195.08	12.50	24	2026-02-27	\N	\N	136	\N	\N	\N	4
25	3	9453839.39	24405959.69	12.50	24	2026-02-27	\N	\N	901	\N	\N	\N	4
26	3	46149745.74	13185315.85	12.50	24	2026-02-27	\N	\N	310	\N	\N	\N	4
27	3	38060208.03	28200923.30	12.50	24	2026-02-27	\N	\N	742	\N	\N	\N	4
28	3	3145831.45	22668544.16	12.50	24	2026-02-27	\N	\N	934	\N	\N	\N	4
29	3	4519317.09	18616978.87	12.50	24	2026-02-27	\N	\N	191	\N	\N	\N	4
30	3	4306402.96	32800709.59	12.50	24	2026-02-27	\N	\N	265	\N	\N	\N	4
31	3	16177682.00	32649687.86	12.50	24	2026-02-27	\N	\N	491	\N	\N	\N	4
32	3	28680998.25	15567537.82	12.50	24	2026-02-27	\N	\N	994	\N	\N	\N	4
33	3	5177748.25	17648038.88	12.50	24	2026-02-27	\N	\N	712	\N	\N	\N	4
34	3	10208641.69	22981827.07	12.50	24	2026-02-27	\N	\N	368	\N	\N	\N	4
35	3	7216821.64	1347774.23	12.50	24	2026-02-27	\N	\N	419	\N	\N	\N	4
36	3	18379378.45	24150402.95	12.50	24	2026-02-27	\N	\N	551	\N	\N	\N	4
37	3	19702823.83	23199306.01	12.50	24	2026-02-27	\N	\N	318	\N	\N	\N	4
38	3	15228423.41	37037578.82	12.50	24	2026-02-27	\N	\N	443	\N	\N	\N	4
39	3	18319490.38	26786485.64	12.50	24	2026-02-27	\N	\N	614	\N	\N	\N	4
40	3	13832679.59	14274223.11	12.50	24	2026-02-27	\N	\N	981	\N	\N	\N	4
41	3	7423416.42	18643742.78	12.50	24	2026-02-27	\N	\N	905	\N	\N	\N	4
42	3	29238704.11	5323602.24	12.50	24	2026-02-27	\N	\N	817	\N	\N	\N	4
43	3	28298951.13	33180369.76	12.50	24	2026-02-27	\N	\N	99	\N	\N	\N	4
44	3	30507360.96	28482515.34	12.50	24	2026-02-27	\N	\N	654	\N	\N	\N	4
45	3	30077454.26	23550269.58	12.50	24	2026-02-27	\N	\N	459	\N	\N	\N	4
46	3	10536885.12	29432445.52	12.50	24	2026-02-27	\N	\N	672	\N	\N	\N	4
47	3	15419458.75	33989107.36	12.50	24	2026-02-27	\N	\N	843	\N	\N	\N	4
48	3	39800411.06	38905804.84	12.50	24	2026-02-27	\N	\N	799	\N	\N	\N	4
49	3	43290881.54	22559563.99	12.50	24	2026-02-27	\N	\N	370	\N	\N	\N	4
50	3	36847818.71	14641418.99	12.50	24	2026-02-27	\N	\N	355	\N	\N	\N	4
51	3	40998825.25	33289414.70	12.50	24	2026-02-27	\N	\N	450	\N	\N	\N	4
52	3	1266777.96	25977850.68	12.50	24	2026-02-27	\N	\N	277	\N	\N	\N	4
53	3	20573487.39	5804969.96	12.50	24	2026-02-27	\N	\N	885	\N	\N	\N	4
54	3	36252651.14	25043241.26	12.50	24	2026-02-27	\N	\N	390	\N	\N	\N	4
55	3	8596072.57	16793748.60	12.50	24	2026-02-27	\N	\N	371	\N	\N	\N	4
56	3	25874941.18	8002176.02	12.50	24	2026-02-27	\N	\N	895	\N	\N	\N	4
57	3	3775939.29	11205589.11	12.50	24	2026-02-27	\N	\N	446	\N	\N	\N	4
58	3	35414284.85	3547376.76	12.50	24	2026-02-27	\N	\N	432	\N	\N	\N	4
59	3	11953284.37	15016009.36	12.50	24	2026-02-27	\N	\N	963	\N	\N	\N	4
60	3	12788157.84	2588068.17	12.50	24	2026-02-27	\N	\N	704	\N	\N	\N	4
61	3	3556271.95	26453633.42	12.50	24	2026-02-27	\N	\N	975	\N	\N	\N	4
62	3	15445097.26	12813625.15	12.50	24	2026-02-27	\N	\N	774	\N	\N	\N	4
63	3	34656666.43	35357151.37	12.50	24	2026-02-27	\N	\N	606	\N	\N	\N	4
64	3	39959612.39	34822667.83	12.50	24	2026-02-27	\N	\N	656	\N	\N	\N	4
65	3	48414141.38	23872058.81	12.50	24	2026-02-27	\N	\N	193	\N	\N	\N	4
66	3	43945766.98	17267784.28	12.50	24	2026-02-27	\N	\N	77	\N	\N	\N	4
67	3	14924400.82	797351.77	12.50	24	2026-02-27	\N	\N	227	\N	\N	\N	4
68	3	38048628.76	6997013.13	12.50	24	2026-02-27	\N	\N	116	\N	\N	\N	4
69	3	36445929.07	36153542.18	12.50	24	2026-02-27	\N	\N	222	\N	\N	\N	4
70	3	27448626.43	4298876.40	12.50	24	2026-02-27	\N	\N	153	\N	\N	\N	4
71	3	13325561.62	36751848.22	12.50	24	2026-02-27	\N	\N	964	\N	\N	\N	4
72	3	33493497.25	11979913.07	12.50	24	2026-02-27	\N	\N	770	\N	\N	\N	4
73	3	47427666.72	9477649.86	12.50	24	2026-02-27	\N	\N	84	\N	\N	\N	4
74	3	25105072.84	16578915.12	12.50	24	2026-02-27	\N	\N	691	\N	\N	\N	4
75	3	21438888.15	468196.48	12.50	24	2026-02-27	\N	\N	597	\N	\N	\N	4
76	3	42016143.06	36507161.66	12.50	24	2026-02-27	\N	\N	58	\N	\N	\N	4
77	3	39014986.67	33347466.96	12.50	24	2026-02-27	\N	\N	623	\N	\N	\N	4
78	3	44642899.52	8150818.86	12.50	24	2026-02-27	\N	\N	979	\N	\N	\N	4
79	3	28898542.55	12665212.83	12.50	24	2026-02-27	\N	\N	450	\N	\N	\N	4
80	3	24085959.70	15356624.63	12.50	24	2026-02-27	\N	\N	782	\N	\N	\N	4
81	3	49939818.58	36220973.28	12.50	24	2026-02-27	\N	\N	944	\N	\N	\N	4
82	3	16926758.83	14784057.31	12.50	24	2026-02-27	\N	\N	357	\N	\N	\N	4
83	3	31227288.41	14663102.81	12.50	24	2026-02-27	\N	\N	261	\N	\N	\N	4
84	3	40875466.52	9050884.21	12.50	24	2026-02-27	\N	\N	536	\N	\N	\N	4
85	3	24043867.98	5645464.60	12.50	24	2026-02-27	\N	\N	499	\N	\N	\N	4
86	3	20866789.89	20093801.43	12.50	24	2026-02-27	\N	\N	768	\N	\N	\N	4
87	3	40644635.40	30602891.93	12.50	24	2026-02-27	\N	\N	486	\N	\N	\N	4
88	3	43698923.27	34876544.83	12.50	24	2026-02-27	\N	\N	87	\N	\N	\N	4
89	3	15820190.08	14906876.46	12.50	24	2026-02-27	\N	\N	315	\N	\N	\N	4
90	3	41586083.67	32307117.63	12.50	24	2026-02-27	\N	\N	476	\N	\N	\N	4
91	3	18946490.19	21929265.08	12.50	24	2026-02-27	\N	\N	193	\N	\N	\N	4
92	3	32852030.29	30688437.72	12.50	24	2026-02-27	\N	\N	444	\N	\N	\N	4
93	3	44757274.33	4400004.58	12.50	24	2026-02-27	\N	\N	812	\N	\N	\N	4
94	3	41269250.74	38959639.83	12.50	24	2026-02-27	\N	\N	632	\N	\N	\N	4
95	3	17397492.64	33177733.76	12.50	24	2026-02-27	\N	\N	151	\N	\N	\N	4
96	3	4325151.51	4591877.10	12.50	24	2026-02-27	\N	\N	532	\N	\N	\N	4
97	3	4454445.16	4562649.78	12.50	24	2026-02-27	\N	\N	415	\N	\N	\N	4
98	3	34072661.40	28882722.36	12.50	24	2026-02-27	\N	\N	879	\N	\N	\N	4
99	3	22588869.93	34268138.67	12.50	24	2026-02-27	\N	\N	645	\N	\N	\N	4
100	3	23606572.57	32329129.72	12.50	24	2026-02-27	\N	\N	245	\N	\N	\N	4
101	3	6733857.32	21706045.44	12.50	24	2026-02-27	\N	\N	749	\N	\N	\N	4
102	3	25713748.26	872089.33	12.50	24	2026-02-27	\N	\N	910	\N	\N	\N	4
103	3	2816039.17	31521114.79	12.50	24	2026-02-27	\N	\N	251	\N	\N	\N	4
104	3	12768655.63	33041125.43	12.50	24	2026-02-27	\N	\N	890	\N	\N	\N	4
105	3	40180205.84	24861597.67	12.50	24	2026-02-27	\N	\N	589	\N	\N	\N	4
106	3	13390506.03	1916235.32	12.50	24	2026-02-27	\N	\N	908	\N	\N	\N	4
107	3	29600491.39	6811499.21	12.50	24	2026-02-27	\N	\N	44	\N	\N	\N	4
108	3	44663578.73	3342188.79	12.50	24	2026-02-27	\N	\N	568	\N	\N	\N	4
109	3	46680909.80	31988303.66	12.50	24	2026-02-27	\N	\N	953	\N	\N	\N	4
110	3	37860461.98	26004506.30	12.50	24	2026-02-27	\N	\N	173	\N	\N	\N	4
111	3	25624335.54	35572128.98	12.50	24	2026-02-27	\N	\N	388	\N	\N	\N	4
112	3	15887248.05	6803721.47	12.50	24	2026-02-27	\N	\N	897	\N	\N	\N	4
113	3	28951175.84	36107833.86	12.50	24	2026-02-27	\N	\N	809	\N	\N	\N	4
114	3	43050092.87	2091030.65	12.50	24	2026-02-27	\N	\N	815	\N	\N	\N	4
115	3	47060558.51	34769351.42	12.50	24	2026-02-27	\N	\N	339	\N	\N	\N	4
116	3	2845552.02	33702358.63	12.50	24	2026-02-27	\N	\N	482	\N	\N	\N	4
117	3	43546309.34	11860058.23	12.50	24	2026-02-27	\N	\N	731	\N	\N	\N	4
118	3	45372640.88	33324077.64	12.50	24	2026-02-27	\N	\N	514	\N	\N	\N	4
119	3	41312586.92	5320016.48	12.50	24	2026-02-27	\N	\N	333	\N	\N	\N	4
120	3	1598232.78	29269318.63	12.50	24	2026-02-27	\N	\N	887	\N	\N	\N	4
121	3	40803768.85	3811847.28	12.50	24	2026-02-27	\N	\N	88	\N	\N	\N	4
122	3	11045096.43	12903697.39	12.50	24	2026-02-27	\N	\N	632	\N	\N	\N	4
123	3	43164283.36	34049115.27	12.50	24	2026-02-27	\N	\N	462	\N	\N	\N	4
124	3	2692286.86	10620801.73	12.50	24	2026-02-27	\N	\N	448	\N	\N	\N	4
125	3	34440891.71	9489847.45	12.50	24	2026-02-27	\N	\N	558	\N	\N	\N	4
126	3	345531.92	37257766.75	12.50	24	2026-02-27	\N	\N	745	\N	\N	\N	4
127	3	22061422.73	4540074.99	12.50	24	2026-02-27	\N	\N	291	\N	\N	\N	4
128	3	23500885.31	35757157.25	12.50	24	2026-02-27	\N	\N	582	\N	\N	\N	4
129	3	14345863.13	18520196.59	12.50	24	2026-02-27	\N	\N	512	\N	\N	\N	4
130	3	4736667.54	29083652.22	12.50	24	2026-02-27	\N	\N	417	\N	\N	\N	4
131	3	15248204.19	18399409.79	12.50	24	2026-02-27	\N	\N	979	\N	\N	\N	4
132	3	1937755.06	19610285.88	12.50	24	2026-02-27	\N	\N	835	\N	\N	\N	4
133	3	9738540.61	7886225.55	12.50	24	2026-02-27	\N	\N	999	\N	\N	\N	4
134	3	16728154.59	14935757.82	12.50	24	2026-02-27	\N	\N	982	\N	\N	\N	4
135	3	46695789.05	16456777.76	12.50	24	2026-02-27	\N	\N	437	\N	\N	\N	4
136	3	20568440.19	8351953.04	12.50	24	2026-02-27	\N	\N	557	\N	\N	\N	4
137	3	28566395.32	29040035.89	12.50	24	2026-02-27	\N	\N	663	\N	\N	\N	4
138	3	29528820.77	50277.07	12.50	24	2026-02-27	\N	\N	701	\N	\N	\N	4
139	3	20650635.69	30440200.76	12.50	24	2026-02-27	\N	\N	949	\N	\N	\N	4
140	3	25999477.28	28711943.24	12.50	24	2026-02-27	\N	\N	595	\N	\N	\N	4
141	3	27719020.11	25717252.40	12.50	24	2026-02-27	\N	\N	503	\N	\N	\N	4
142	3	13392343.01	16799940.91	12.50	24	2026-02-27	\N	\N	811	\N	\N	\N	4
143	3	30502203.73	19212173.49	12.50	24	2026-02-27	\N	\N	215	\N	\N	\N	4
144	3	43456151.26	14408793.34	12.50	24	2026-02-27	\N	\N	749	\N	\N	\N	4
145	3	30158399.01	27257188.09	12.50	24	2026-02-27	\N	\N	833	\N	\N	\N	4
146	3	6275192.94	34836848.96	12.50	24	2026-02-27	\N	\N	227	\N	\N	\N	4
147	3	37700883.75	25781185.20	12.50	24	2026-02-27	\N	\N	480	\N	\N	\N	4
148	3	46270570.10	233127.81	12.50	24	2026-02-27	\N	\N	469	\N	\N	\N	4
149	3	419741.30	2557852.97	12.50	24	2026-02-27	\N	\N	602	\N	\N	\N	4
150	3	42928186.50	14239197.97	12.50	24	2026-02-27	\N	\N	930	\N	\N	\N	4
151	3	29535961.23	16362739.92	12.50	24	2026-02-27	\N	\N	875	\N	\N	\N	4
152	3	46063158.71	14526728.02	12.50	24	2026-02-27	\N	\N	586	\N	\N	\N	4
153	3	26824183.19	5848662.11	12.50	24	2026-02-27	\N	\N	376	\N	\N	\N	4
154	3	6115092.54	358816.84	12.50	24	2026-02-27	\N	\N	799	\N	\N	\N	4
155	3	24500739.98	15228786.79	12.50	24	2026-02-27	\N	\N	469	\N	\N	\N	4
156	3	20412130.46	29644985.68	12.50	24	2026-02-27	\N	\N	401	\N	\N	\N	4
157	3	11044290.90	37596233.22	12.50	24	2026-02-27	\N	\N	173	\N	\N	\N	4
158	3	4927457.43	25795850.45	12.50	24	2026-02-27	\N	\N	767	\N	\N	\N	4
159	3	15223535.08	3060247.31	12.50	24	2026-02-27	\N	\N	542	\N	\N	\N	4
160	3	45110595.88	1061471.74	12.50	24	2026-02-27	\N	\N	579	\N	\N	\N	4
161	3	14113495.88	17282751.90	12.50	24	2026-02-27	\N	\N	244	\N	\N	\N	4
162	3	24126729.80	14161266.61	12.50	24	2026-02-27	\N	\N	437	\N	\N	\N	4
163	3	7755096.63	5049775.64	12.50	24	2026-02-27	\N	\N	756	\N	\N	\N	4
164	3	22624142.89	25390937.69	12.50	24	2026-02-27	\N	\N	943	\N	\N	\N	4
165	3	42516651.75	10467051.50	12.50	24	2026-02-27	\N	\N	89	\N	\N	\N	4
166	3	20920382.94	26342790.31	12.50	24	2026-02-27	\N	\N	862	\N	\N	\N	4
167	3	34669241.07	1759259.71	12.50	24	2026-02-27	\N	\N	762	\N	\N	\N	4
168	3	39783534.20	35217336.01	12.50	24	2026-02-27	\N	\N	817	\N	\N	\N	4
169	3	39343697.16	38356503.10	12.50	24	2026-02-27	\N	\N	207	\N	\N	\N	4
170	3	23786829.77	13259867.64	12.50	24	2026-02-27	\N	\N	821	\N	\N	\N	4
171	3	41530275.64	37388699.87	12.50	24	2026-02-27	\N	\N	617	\N	\N	\N	4
172	3	32279553.87	30643979.90	12.50	24	2026-02-27	\N	\N	50	\N	\N	\N	4
173	3	32733570.23	33006917.94	12.50	24	2026-02-27	\N	\N	507	\N	\N	\N	4
174	3	18517421.05	12710516.49	12.50	24	2026-02-27	\N	\N	382	\N	\N	\N	4
175	3	31737955.26	11399186.43	12.50	24	2026-02-27	\N	\N	221	\N	\N	\N	4
176	3	16304892.64	8751866.25	12.50	24	2026-02-27	\N	\N	784	\N	\N	\N	4
177	3	4229830.79	38831587.12	12.50	24	2026-02-27	\N	\N	958	\N	\N	\N	4
178	3	47780411.46	8805287.97	12.50	24	2026-02-27	\N	\N	972	\N	\N	\N	4
179	3	36707787.17	12569748.81	12.50	24	2026-02-27	\N	\N	974	\N	\N	\N	4
180	3	22099528.90	14558915.41	12.50	24	2026-02-27	\N	\N	933	\N	\N	\N	4
181	3	9394027.56	11175441.12	12.50	24	2026-02-27	\N	\N	991	\N	\N	\N	4
182	3	24817776.48	25326645.76	12.50	24	2026-02-27	\N	\N	890	\N	\N	\N	4
183	3	25470719.28	27172300.18	12.50	24	2026-02-27	\N	\N	385	\N	\N	\N	4
184	3	29497143.48	10695504.41	12.50	24	2026-02-27	\N	\N	138	\N	\N	\N	4
185	3	24517911.28	27439790.32	12.50	24	2026-02-27	\N	\N	792	\N	\N	\N	4
186	3	24802346.28	35691909.84	12.50	24	2026-02-27	\N	\N	142	\N	\N	\N	4
187	3	11941576.30	6093226.21	12.50	24	2026-02-27	\N	\N	151	\N	\N	\N	4
188	3	37547414.79	9528787.60	12.50	24	2026-02-27	\N	\N	43	\N	\N	\N	4
189	3	35847008.67	27689392.24	12.50	24	2026-02-27	\N	\N	970	\N	\N	\N	4
190	3	27756917.81	36663584.28	12.50	24	2026-02-27	\N	\N	929	\N	\N	\N	4
191	3	6268005.56	28669760.92	12.50	24	2026-02-27	\N	\N	628	\N	\N	\N	4
192	3	16086925.14	35632829.99	12.50	24	2026-02-27	\N	\N	41	\N	\N	\N	4
193	3	10132184.64	18318504.71	12.50	24	2026-02-27	\N	\N	605	\N	\N	\N	4
194	3	3845170.02	36700268.57	12.50	24	2026-02-27	\N	\N	992	\N	\N	\N	4
195	3	33277259.88	9661951.05	12.50	24	2026-02-27	\N	\N	929	\N	\N	\N	4
196	3	46086625.23	13758931.83	12.50	24	2026-02-27	\N	\N	964	\N	\N	\N	4
197	3	695886.06	5290201.07	12.50	24	2026-02-27	\N	\N	617	\N	\N	\N	4
198	3	22498321.47	25869574.60	12.50	24	2026-02-27	\N	\N	43	\N	\N	\N	4
199	3	28823186.86	31112697.31	12.50	24	2026-02-27	\N	\N	607	\N	\N	\N	4
200	3	36018676.85	5940861.07	12.50	24	2026-02-27	\N	\N	592	\N	\N	\N	4
201	3	32849280.64	8268231.51	12.50	24	2026-02-27	\N	\N	184	\N	\N	\N	4
202	3	2313291.13	24064286.01	12.50	24	2026-02-27	\N	\N	98	\N	\N	\N	4
203	3	31394407.39	320253.71	12.50	24	2026-02-27	\N	\N	616	\N	\N	\N	4
204	3	4496656.29	6733502.82	12.50	24	2026-02-27	\N	\N	476	\N	\N	\N	4
205	3	44568739.27	9443121.17	12.50	24	2026-02-27	\N	\N	599	\N	\N	\N	4
206	3	15817374.38	20140919.24	12.50	24	2026-02-27	\N	\N	267	\N	\N	\N	4
207	3	7600330.52	29769969.86	12.50	24	2026-02-27	\N	\N	740	\N	\N	\N	4
208	3	46599417.11	5914533.68	12.50	24	2026-02-27	\N	\N	879	\N	\N	\N	4
209	3	9356551.57	16085204.48	12.50	24	2026-02-27	\N	\N	380	\N	\N	\N	4
210	3	17961095.76	10114316.55	12.50	24	2026-02-27	\N	\N	503	\N	\N	\N	4
211	3	26259800.09	1868673.16	12.50	24	2026-02-27	\N	\N	244	\N	\N	\N	4
212	3	35857399.27	26695025.47	12.50	24	2026-02-27	\N	\N	109	\N	\N	\N	4
213	3	16841628.52	175816.62	12.50	24	2026-02-27	\N	\N	819	\N	\N	\N	4
214	3	25927841.98	32990789.06	12.50	24	2026-02-27	\N	\N	737	\N	\N	\N	4
215	3	47712899.76	14437721.64	12.50	24	2026-02-27	\N	\N	544	\N	\N	\N	4
216	3	19088511.88	30718556.99	12.50	24	2026-02-27	\N	\N	389	\N	\N	\N	4
217	3	25510981.52	38542569.90	12.50	24	2026-02-27	\N	\N	843	\N	\N	\N	4
218	3	48694876.39	36286456.80	12.50	24	2026-02-27	\N	\N	375	\N	\N	\N	4
219	3	10316663.51	36180998.23	12.50	24	2026-02-27	\N	\N	825	\N	\N	\N	4
220	3	19065327.96	16039822.58	12.50	24	2026-02-27	\N	\N	333	\N	\N	\N	4
221	3	22115732.98	11656348.38	12.50	24	2026-02-27	\N	\N	175	\N	\N	\N	4
222	3	49423318.35	30698098.34	12.50	24	2026-02-27	\N	\N	877	\N	\N	\N	4
223	3	46241622.18	3830335.26	12.50	24	2026-02-27	\N	\N	362	\N	\N	\N	4
224	3	35722536.33	25453584.35	12.50	24	2026-02-27	\N	\N	411	\N	\N	\N	4
225	3	12326666.82	4687950.97	12.50	24	2026-02-27	\N	\N	652	\N	\N	\N	4
226	3	3178617.17	29130953.53	12.50	24	2026-02-27	\N	\N	793	\N	\N	\N	4
227	3	12542353.15	32637695.86	12.50	24	2026-02-27	\N	\N	780	\N	\N	\N	4
228	3	47011027.05	26063824.42	12.50	24	2026-02-27	\N	\N	168	\N	\N	\N	4
229	3	38652898.81	23789256.18	12.50	24	2026-02-27	\N	\N	119	\N	\N	\N	4
230	3	1988858.95	8275625.35	12.50	24	2026-02-27	\N	\N	45	\N	\N	\N	4
231	3	1194632.38	29753611.33	12.50	24	2026-02-27	\N	\N	888	\N	\N	\N	4
232	3	46579041.20	29228730.17	12.50	24	2026-02-27	\N	\N	607	\N	\N	\N	4
233	3	2364297.41	9885627.12	12.50	24	2026-02-27	\N	\N	54	\N	\N	\N	4
234	3	1419242.56	33330985.50	12.50	24	2026-02-27	\N	\N	712	\N	\N	\N	4
235	3	47180072.14	29129073.63	12.50	24	2026-02-27	\N	\N	925	\N	\N	\N	4
236	3	49398917.32	16442962.01	12.50	24	2026-02-27	\N	\N	188	\N	\N	\N	4
237	3	19540836.44	18820282.75	12.50	24	2026-02-27	\N	\N	889	\N	\N	\N	4
238	3	23742594.85	12769142.80	12.50	24	2026-02-27	\N	\N	488	\N	\N	\N	4
239	3	10081529.53	11869389.67	12.50	24	2026-02-27	\N	\N	349	\N	\N	\N	4
240	3	44577324.57	5002376.03	12.50	24	2026-02-27	\N	\N	606	\N	\N	\N	4
241	3	11860117.51	33004278.52	12.50	24	2026-02-27	\N	\N	143	\N	\N	\N	4
242	3	13089241.78	33230337.23	12.50	24	2026-02-27	\N	\N	449	\N	\N	\N	4
243	3	39861926.82	29302718.21	12.50	24	2026-02-27	\N	\N	609	\N	\N	\N	4
244	3	10192590.73	4197376.55	12.50	24	2026-02-27	\N	\N	876	\N	\N	\N	4
245	3	30171643.06	34815077.92	12.50	24	2026-02-27	\N	\N	189	\N	\N	\N	4
246	3	18693156.32	7948910.40	12.50	24	2026-02-27	\N	\N	793	\N	\N	\N	4
247	3	18004587.51	11197516.39	12.50	24	2026-02-27	\N	\N	537	\N	\N	\N	4
248	3	22598324.81	14344504.29	12.50	24	2026-02-27	\N	\N	87	\N	\N	\N	4
249	3	44305507.20	29862172.35	12.50	24	2026-02-27	\N	\N	152	\N	\N	\N	4
250	3	43983322.53	8263326.47	12.50	24	2026-02-27	\N	\N	543	\N	\N	\N	4
251	3	25801245.01	28955465.23	12.50	24	2026-02-27	\N	\N	592	\N	\N	\N	4
252	3	2921395.54	14176144.46	12.50	24	2026-02-27	\N	\N	430	\N	\N	\N	4
253	3	2999610.53	38766988.28	12.50	24	2026-02-27	\N	\N	582	\N	\N	\N	4
254	3	48718031.95	29780865.89	12.50	24	2026-02-27	\N	\N	657	\N	\N	\N	4
255	3	45634105.33	35411336.14	12.50	24	2026-02-27	\N	\N	262	\N	\N	\N	4
256	3	48055370.94	12438841.93	12.50	24	2026-02-27	\N	\N	937	\N	\N	\N	4
257	3	1416867.70	32489704.08	12.50	24	2026-02-27	\N	\N	144	\N	\N	\N	4
258	3	10296990.86	18889433.72	12.50	24	2026-02-27	\N	\N	381	\N	\N	\N	4
259	3	9607810.48	7003254.53	12.50	24	2026-02-27	\N	\N	525	\N	\N	\N	4
260	3	37797683.71	5682410.08	12.50	24	2026-02-27	\N	\N	530	\N	\N	\N	4
261	3	49529829.73	12383610.03	12.50	24	2026-02-27	\N	\N	233	\N	\N	\N	4
262	3	12407321.78	21724009.70	12.50	24	2026-02-27	\N	\N	157	\N	\N	\N	4
263	3	33739024.83	23234076.91	12.50	24	2026-02-27	\N	\N	633	\N	\N	\N	4
264	3	12968947.11	8987186.31	12.50	24	2026-02-27	\N	\N	185	\N	\N	\N	4
265	3	44446008.93	7403751.96	12.50	24	2026-02-27	\N	\N	521	\N	\N	\N	4
266	3	18734403.37	6634321.94	12.50	24	2026-02-27	\N	\N	338	\N	\N	\N	4
267	3	45019938.31	24046195.35	12.50	24	2026-02-27	\N	\N	334	\N	\N	\N	4
268	3	4220549.30	34115570.78	12.50	24	2026-02-27	\N	\N	205	\N	\N	\N	4
269	3	663278.44	19056698.89	12.50	24	2026-02-27	\N	\N	143	\N	\N	\N	4
270	3	26726159.14	11655932.60	12.50	24	2026-02-27	\N	\N	517	\N	\N	\N	4
271	3	19228149.66	22842187.53	12.50	24	2026-02-27	\N	\N	799	\N	\N	\N	4
272	3	14500725.01	4201176.28	12.50	24	2026-02-27	\N	\N	15	\N	\N	\N	4
273	3	15599558.70	20355334.82	12.50	24	2026-02-27	\N	\N	686	\N	\N	\N	4
274	3	33108918.46	1096182.57	12.50	24	2026-02-27	\N	\N	558	\N	\N	\N	4
275	3	41309056.68	11871921.79	12.50	24	2026-02-27	\N	\N	982	\N	\N	\N	4
276	3	47632355.24	35892229.79	12.50	24	2026-02-27	\N	\N	942	\N	\N	\N	4
277	3	5613697.34	20510632.57	12.50	24	2026-02-27	\N	\N	509	\N	\N	\N	4
278	3	18662622.31	18226527.72	12.50	24	2026-02-27	\N	\N	123	\N	\N	\N	4
279	3	42315619.62	12237443.17	12.50	24	2026-02-27	\N	\N	880	\N	\N	\N	4
280	3	31731079.51	10264921.40	12.50	24	2026-02-27	\N	\N	321	\N	\N	\N	4
281	3	38662895.83	24641491.73	12.50	24	2026-02-27	\N	\N	367	\N	\N	\N	4
282	3	15346696.36	20518003.95	12.50	24	2026-02-27	\N	\N	291	\N	\N	\N	4
283	3	22798315.72	5176278.93	12.50	24	2026-02-27	\N	\N	937	\N	\N	\N	4
284	3	6225344.52	26382299.10	12.50	24	2026-02-27	\N	\N	907	\N	\N	\N	4
285	3	19637717.54	5735968.95	12.50	24	2026-02-27	\N	\N	174	\N	\N	\N	4
286	3	39575658.63	23228750.53	12.50	24	2026-02-27	\N	\N	362	\N	\N	\N	4
287	3	47546499.57	36943393.03	12.50	24	2026-02-27	\N	\N	282	\N	\N	\N	4
288	3	3209492.99	16934582.44	12.50	24	2026-02-27	\N	\N	518	\N	\N	\N	4
289	3	14397112.19	9030786.43	12.50	24	2026-02-27	\N	\N	853	\N	\N	\N	4
290	3	18691161.56	26014445.35	12.50	24	2026-02-27	\N	\N	670	\N	\N	\N	4
291	3	18586574.04	18887796.41	12.50	24	2026-02-27	\N	\N	124	\N	\N	\N	4
292	3	32233680.32	31964844.05	12.50	24	2026-02-27	\N	\N	387	\N	\N	\N	4
293	3	12601225.89	24005965.81	12.50	24	2026-02-27	\N	\N	620	\N	\N	\N	4
294	3	44308025.94	28264383.60	12.50	24	2026-02-27	\N	\N	235	\N	\N	\N	4
295	3	37501874.41	3385424.41	12.50	24	2026-02-27	\N	\N	726	\N	\N	\N	4
296	3	17184244.55	19077241.15	12.50	24	2026-02-27	\N	\N	167	\N	\N	\N	4
297	3	6443224.56	233162.57	12.50	24	2026-02-27	\N	\N	927	\N	\N	\N	4
298	3	11812384.22	32096408.88	12.50	24	2026-02-27	\N	\N	426	\N	\N	\N	4
299	3	30320937.77	10868843.64	12.50	24	2026-02-27	\N	\N	184	\N	\N	\N	4
300	3	14795041.91	27022822.27	12.50	24	2026-02-27	\N	\N	168	\N	\N	\N	4
301	3	40315736.96	29420615.83	12.50	24	2026-02-27	\N	\N	231	\N	\N	\N	4
302	3	40687798.73	18146693.68	12.50	24	2026-02-27	\N	\N	297	\N	\N	\N	4
303	3	1967594.29	35069528.50	12.50	24	2026-02-27	\N	\N	534	\N	\N	\N	4
304	3	24053133.23	24690271.71	12.50	24	2026-02-27	\N	\N	26	\N	\N	\N	4
305	3	44737125.78	8147115.40	12.50	24	2026-02-27	\N	\N	649	\N	\N	\N	4
306	3	4552981.97	33692100.03	12.50	24	2026-02-27	\N	\N	77	\N	\N	\N	4
307	3	21293769.36	6242494.51	12.50	24	2026-02-27	\N	\N	676	\N	\N	\N	4
308	3	39592771.91	31974681.07	12.50	24	2026-02-27	\N	\N	501	\N	\N	\N	4
309	3	2654329.13	16230979.79	12.50	24	2026-02-27	\N	\N	225	\N	\N	\N	4
310	3	14489391.12	29575469.25	12.50	24	2026-02-27	\N	\N	449	\N	\N	\N	4
311	3	42044507.17	7748695.88	12.50	24	2026-02-27	\N	\N	473	\N	\N	\N	4
312	3	15205865.50	14896657.25	12.50	24	2026-02-27	\N	\N	281	\N	\N	\N	4
313	3	20416464.68	19256321.71	12.50	24	2026-02-27	\N	\N	555	\N	\N	\N	4
314	3	12831396.11	8748571.06	12.50	24	2026-02-27	\N	\N	138	\N	\N	\N	4
315	3	37112884.04	34436592.46	12.50	24	2026-02-27	\N	\N	692	\N	\N	\N	4
316	3	23789592.65	4243284.21	12.50	24	2026-02-27	\N	\N	374	\N	\N	\N	4
317	3	13323752.76	12402782.06	12.50	24	2026-02-27	\N	\N	582	\N	\N	\N	4
318	3	27147008.99	20457948.06	12.50	24	2026-02-27	\N	\N	347	\N	\N	\N	4
319	3	6543763.06	29910329.87	12.50	24	2026-02-27	\N	\N	851	\N	\N	\N	4
320	3	49517982.30	26441755.80	12.50	24	2026-02-27	\N	\N	453	\N	\N	\N	4
321	3	18749236.40	31207071.30	12.50	24	2026-02-27	\N	\N	599	\N	\N	\N	4
322	3	6226299.93	6477883.86	12.50	24	2026-02-27	\N	\N	543	\N	\N	\N	4
323	3	45715696.98	30829783.39	12.50	24	2026-02-27	\N	\N	867	\N	\N	\N	4
324	3	31614423.02	27521668.18	12.50	24	2026-02-27	\N	\N	871	\N	\N	\N	4
325	3	39987643.92	18817764.04	12.50	24	2026-02-27	\N	\N	51	\N	\N	\N	4
326	3	39320769.89	31784536.21	12.50	24	2026-02-27	\N	\N	279	\N	\N	\N	4
327	3	11746671.91	22454517.14	12.50	24	2026-02-27	\N	\N	470	\N	\N	\N	4
328	3	19081428.59	15139946.50	12.50	24	2026-02-27	\N	\N	730	\N	\N	\N	4
329	3	41715565.35	613962.31	12.50	24	2026-02-27	\N	\N	543	\N	\N	\N	4
330	3	45315851.36	2024406.35	12.50	24	2026-02-27	\N	\N	782	\N	\N	\N	4
331	3	18344209.26	1456231.71	12.50	24	2026-02-27	\N	\N	869	\N	\N	\N	4
332	3	6214542.74	20985497.34	12.50	24	2026-02-27	\N	\N	728	\N	\N	\N	4
333	3	39105735.98	24055231.36	12.50	24	2026-02-27	\N	\N	831	\N	\N	\N	4
334	3	27188474.48	3645162.23	12.50	24	2026-02-27	\N	\N	954	\N	\N	\N	4
335	3	41457056.23	4892367.41	12.50	24	2026-02-27	\N	\N	877	\N	\N	\N	4
336	3	30942051.89	913756.34	12.50	24	2026-02-27	\N	\N	946	\N	\N	\N	4
337	3	8080654.54	7958209.50	12.50	24	2026-02-27	\N	\N	836	\N	\N	\N	4
338	3	38547986.75	25243277.29	12.50	24	2026-02-27	\N	\N	840	\N	\N	\N	4
339	3	46550726.70	2803033.34	12.50	24	2026-02-27	\N	\N	311	\N	\N	\N	4
340	3	33600423.98	12600034.81	12.50	24	2026-02-27	\N	\N	755	\N	\N	\N	4
341	3	37111700.77	26938924.45	12.50	24	2026-02-27	\N	\N	454	\N	\N	\N	4
342	3	17922950.44	9193851.32	12.50	24	2026-02-27	\N	\N	498	\N	\N	\N	4
343	3	6901774.56	13422792.67	12.50	24	2026-02-27	\N	\N	562	\N	\N	\N	4
344	3	37869720.05	12667827.67	12.50	24	2026-02-27	\N	\N	799	\N	\N	\N	4
345	3	46200522.39	37094763.23	12.50	24	2026-02-27	\N	\N	94	\N	\N	\N	4
346	3	45248851.54	25351570.90	12.50	24	2026-02-27	\N	\N	791	\N	\N	\N	4
347	3	42720690.83	18599253.38	12.50	24	2026-02-27	\N	\N	890	\N	\N	\N	4
348	3	22529889.01	32998505.68	12.50	24	2026-02-27	\N	\N	720	\N	\N	\N	4
349	3	43999894.96	286770.73	12.50	24	2026-02-27	\N	\N	236	\N	\N	\N	4
350	3	22782062.84	34267781.03	12.50	24	2026-02-27	\N	\N	915	\N	\N	\N	4
351	3	33202430.01	8313521.35	12.50	24	2026-02-27	\N	\N	735	\N	\N	\N	4
352	3	24922067.50	26839704.56	12.50	24	2026-02-27	\N	\N	214	\N	\N	\N	4
353	3	22346474.54	17143562.97	12.50	24	2026-02-27	\N	\N	657	\N	\N	\N	4
354	3	41184393.99	36604919.41	12.50	24	2026-02-27	\N	\N	923	\N	\N	\N	4
355	3	6078937.47	20438954.43	12.50	24	2026-02-27	\N	\N	701	\N	\N	\N	4
356	3	39380789.26	11747696.83	12.50	24	2026-02-27	\N	\N	323	\N	\N	\N	4
357	3	22946726.49	39297568.96	12.50	24	2026-02-27	\N	\N	15	\N	\N	\N	4
358	3	8996967.56	12472241.70	12.50	24	2026-02-27	\N	\N	869	\N	\N	\N	4
359	3	1319122.49	38665654.76	12.50	24	2026-02-27	\N	\N	181	\N	\N	\N	4
360	3	8420384.57	13815701.53	12.50	24	2026-02-27	\N	\N	556	\N	\N	\N	4
361	3	35271089.40	39890569.75	12.50	24	2026-02-27	\N	\N	288	\N	\N	\N	4
362	3	1047392.26	39146048.43	12.50	24	2026-02-27	\N	\N	449	\N	\N	\N	4
363	3	31501227.56	11404355.52	12.50	24	2026-02-27	\N	\N	543	\N	\N	\N	4
364	3	19682148.88	3401151.66	12.50	24	2026-02-27	\N	\N	446	\N	\N	\N	4
365	3	9755560.21	19262092.55	12.50	24	2026-02-27	\N	\N	146	\N	\N	\N	4
366	3	15039981.47	861943.95	12.50	24	2026-02-27	\N	\N	944	\N	\N	\N	4
367	3	32238391.99	16884883.39	12.50	24	2026-02-27	\N	\N	629	\N	\N	\N	4
368	3	1360628.03	20801268.35	12.50	24	2026-02-27	\N	\N	133	\N	\N	\N	4
369	3	12406817.58	17683080.23	12.50	24	2026-02-27	\N	\N	531	\N	\N	\N	4
370	3	43689827.80	17238940.84	12.50	24	2026-02-27	\N	\N	894	\N	\N	\N	4
371	3	24137878.96	8179911.27	12.50	24	2026-02-27	\N	\N	839	\N	\N	\N	4
372	3	48575308.20	22988797.44	12.50	24	2026-02-27	\N	\N	968	\N	\N	\N	4
373	3	12418930.09	15861814.88	12.50	24	2026-02-27	\N	\N	547	\N	\N	\N	4
374	3	45237467.39	26790617.28	12.50	24	2026-02-27	\N	\N	344	\N	\N	\N	4
375	3	23190596.68	4125146.51	12.50	24	2026-02-27	\N	\N	375	\N	\N	\N	4
376	3	25837729.32	659705.84	12.50	24	2026-02-27	\N	\N	183	\N	\N	\N	4
377	3	48293262.76	5165460.97	12.50	24	2026-02-27	\N	\N	527	\N	\N	\N	4
378	3	4166569.78	12820520.15	12.50	24	2026-02-27	\N	\N	670	\N	\N	\N	4
379	3	42379967.74	23122274.88	12.50	24	2026-02-27	\N	\N	549	\N	\N	\N	4
380	3	47707691.66	16315737.82	12.50	24	2026-02-27	\N	\N	783	\N	\N	\N	4
381	3	31685126.68	31006228.03	12.50	24	2026-02-27	\N	\N	819	\N	\N	\N	4
382	3	15232062.60	365971.98	12.50	24	2026-02-27	\N	\N	921	\N	\N	\N	4
383	3	49038229.48	30908733.67	12.50	24	2026-02-27	\N	\N	669	\N	\N	\N	4
384	3	38012988.76	19694585.35	12.50	24	2026-02-27	\N	\N	843	\N	\N	\N	4
385	3	17243637.69	39480499.73	12.50	24	2026-02-27	\N	\N	74	\N	\N	\N	4
386	3	5138527.30	2124294.48	12.50	24	2026-02-27	\N	\N	369	\N	\N	\N	4
387	3	14746478.52	27178322.37	12.50	24	2026-02-27	\N	\N	126	\N	\N	\N	4
388	3	38534884.86	18826512.50	12.50	24	2026-02-27	\N	\N	572	\N	\N	\N	4
389	3	42441633.44	1507008.13	12.50	24	2026-02-27	\N	\N	581	\N	\N	\N	4
390	3	26920844.90	36758961.26	12.50	24	2026-02-27	\N	\N	830	\N	\N	\N	4
391	3	20490984.82	20505308.49	12.50	24	2026-02-27	\N	\N	980	\N	\N	\N	4
392	3	13581171.90	9478171.72	12.50	24	2026-02-27	\N	\N	754	\N	\N	\N	4
393	3	20924507.01	37266877.50	12.50	24	2026-02-27	\N	\N	743	\N	\N	\N	4
394	3	15324067.44	9739453.53	12.50	24	2026-02-27	\N	\N	800	\N	\N	\N	4
395	3	25334504.64	17499751.45	12.50	24	2026-02-27	\N	\N	729	\N	\N	\N	4
396	3	22683895.05	4153124.22	12.50	24	2026-02-27	\N	\N	134	\N	\N	\N	4
397	3	45520855.09	983151.78	12.50	24	2026-02-27	\N	\N	967	\N	\N	\N	4
398	3	38321828.60	4064847.11	12.50	24	2026-02-27	\N	\N	565	\N	\N	\N	4
399	3	44776076.54	29749280.90	12.50	24	2026-02-27	\N	\N	952	\N	\N	\N	4
400	3	6100829.23	25583959.83	12.50	24	2026-02-27	\N	\N	762	\N	\N	\N	4
401	3	35056394.31	12131514.22	12.50	24	2026-02-27	\N	\N	554	\N	\N	\N	4
402	3	14598210.70	15036716.45	12.50	24	2026-02-27	\N	\N	832	\N	\N	\N	4
403	3	49306608.89	30090429.93	12.50	24	2026-02-27	\N	\N	281	\N	\N	\N	4
404	3	17814607.78	31301967.15	12.50	24	2026-02-27	\N	\N	337	\N	\N	\N	4
405	3	47011772.40	29059862.45	12.50	24	2026-02-27	\N	\N	876	\N	\N	\N	4
406	3	31061805.81	4148975.88	12.50	24	2026-02-27	\N	\N	169	\N	\N	\N	4
407	3	36433278.30	30345452.93	12.50	24	2026-02-27	\N	\N	506	\N	\N	\N	4
408	3	12842229.15	34412713.99	12.50	24	2026-02-27	\N	\N	589	\N	\N	\N	4
409	3	25051308.53	37599552.46	12.50	24	2026-02-27	\N	\N	52	\N	\N	\N	4
410	3	26791814.05	8778519.89	12.50	24	2026-02-27	\N	\N	82	\N	\N	\N	4
411	3	8464525.97	33756623.19	12.50	24	2026-02-27	\N	\N	548	\N	\N	\N	4
412	3	46935871.51	23234022.88	12.50	24	2026-02-27	\N	\N	217	\N	\N	\N	4
413	3	26038694.63	31540688.64	12.50	24	2026-02-27	\N	\N	542	\N	\N	\N	4
414	3	40636265.91	5288148.11	12.50	24	2026-02-27	\N	\N	681	\N	\N	\N	4
415	3	7493520.92	14769120.91	12.50	24	2026-02-27	\N	\N	186	\N	\N	\N	4
416	3	40149838.57	24011532.41	12.50	24	2026-02-27	\N	\N	914	\N	\N	\N	4
417	3	19934985.18	5810896.05	12.50	24	2026-02-27	\N	\N	370	\N	\N	\N	4
418	3	15902296.93	11829688.73	12.50	24	2026-02-27	\N	\N	417	\N	\N	\N	4
419	3	37642784.07	29519712.73	12.50	24	2026-02-27	\N	\N	650	\N	\N	\N	4
420	3	5880652.31	6028315.32	12.50	24	2026-02-27	\N	\N	555	\N	\N	\N	4
421	3	10231400.45	11807874.43	12.50	24	2026-02-27	\N	\N	500	\N	\N	\N	4
422	3	25251827.80	35663616.73	12.50	24	2026-02-27	\N	\N	889	\N	\N	\N	4
423	3	28649976.64	16924221.09	12.50	24	2026-02-27	\N	\N	111	\N	\N	\N	4
424	3	11077476.81	15293922.87	12.50	24	2026-02-27	\N	\N	905	\N	\N	\N	4
425	3	12104071.81	32130470.16	12.50	24	2026-02-27	\N	\N	656	\N	\N	\N	4
426	3	32656888.41	20481781.36	12.50	24	2026-02-27	\N	\N	509	\N	\N	\N	4
427	3	29923547.22	609240.50	12.50	24	2026-02-27	\N	\N	95	\N	\N	\N	4
428	3	22959132.06	1356605.33	12.50	24	2026-02-27	\N	\N	205	\N	\N	\N	4
429	3	32227759.65	17571520.21	12.50	24	2026-02-27	\N	\N	693	\N	\N	\N	4
430	3	17599043.97	16193314.15	12.50	24	2026-02-27	\N	\N	115	\N	\N	\N	4
431	3	24854844.88	37735751.26	12.50	24	2026-02-27	\N	\N	86	\N	\N	\N	4
432	3	46810749.12	17303846.27	12.50	24	2026-02-27	\N	\N	519	\N	\N	\N	4
433	3	8340305.10	7802319.14	12.50	24	2026-02-27	\N	\N	283	\N	\N	\N	4
434	3	3363196.75	9064299.64	12.50	24	2026-02-27	\N	\N	200	\N	\N	\N	4
435	3	46503216.45	6208216.86	12.50	24	2026-02-27	\N	\N	817	\N	\N	\N	4
436	3	48586986.89	26524132.00	12.50	24	2026-02-27	\N	\N	729	\N	\N	\N	4
437	3	21696965.75	31289287.20	12.50	24	2026-02-27	\N	\N	215	\N	\N	\N	4
438	3	1519684.52	22055750.66	12.50	24	2026-02-27	\N	\N	499	\N	\N	\N	4
439	3	16826167.74	8891236.67	12.50	24	2026-02-27	\N	\N	977	\N	\N	\N	4
440	3	33422561.59	2737503.27	12.50	24	2026-02-27	\N	\N	446	\N	\N	\N	4
441	3	17073386.12	27629472.36	12.50	24	2026-02-27	\N	\N	794	\N	\N	\N	4
442	3	15356041.84	23476082.92	12.50	24	2026-02-27	\N	\N	122	\N	\N	\N	4
443	3	21631912.64	1949125.46	12.50	24	2026-02-27	\N	\N	282	\N	\N	\N	4
444	3	1183094.37	36039426.80	12.50	24	2026-02-27	\N	\N	221	\N	\N	\N	4
445	3	47169232.17	33191672.91	12.50	24	2026-02-27	\N	\N	959	\N	\N	\N	4
446	3	36767816.28	24022057.94	12.50	24	2026-02-27	\N	\N	94	\N	\N	\N	4
447	3	42065757.89	14669027.60	12.50	24	2026-02-27	\N	\N	127	\N	\N	\N	4
448	3	16780902.10	22976031.27	12.50	24	2026-02-27	\N	\N	445	\N	\N	\N	4
449	3	46201832.04	31332768.79	12.50	24	2026-02-27	\N	\N	677	\N	\N	\N	4
450	3	436982.84	20532647.09	12.50	24	2026-02-27	\N	\N	806	\N	\N	\N	4
451	3	43749232.13	37240291.27	12.50	24	2026-02-27	\N	\N	70	\N	\N	\N	4
452	3	12422057.74	18969013.04	12.50	24	2026-02-27	\N	\N	317	\N	\N	\N	4
453	3	18505617.66	9846131.14	12.50	24	2026-02-27	\N	\N	487	\N	\N	\N	4
454	3	9821213.29	37964697.90	12.50	24	2026-02-27	\N	\N	122	\N	\N	\N	4
455	3	4924865.38	37132583.56	12.50	24	2026-02-27	\N	\N	791	\N	\N	\N	4
456	3	36658706.33	36384048.22	12.50	24	2026-02-27	\N	\N	930	\N	\N	\N	4
457	3	25850177.98	13364754.93	12.50	24	2026-02-27	\N	\N	754	\N	\N	\N	4
458	3	27164501.74	18069454.40	12.50	24	2026-02-27	\N	\N	303	\N	\N	\N	4
459	3	26957627.05	20285680.91	12.50	24	2026-02-27	\N	\N	507	\N	\N	\N	4
460	3	29953248.45	488185.86	12.50	24	2026-02-27	\N	\N	683	\N	\N	\N	4
461	3	44167041.82	27546426.52	12.50	24	2026-02-27	\N	\N	513	\N	\N	\N	4
462	3	27407087.02	9127493.41	12.50	24	2026-02-27	\N	\N	647	\N	\N	\N	4
463	3	35097148.49	18281352.99	12.50	24	2026-02-27	\N	\N	319	\N	\N	\N	4
464	3	38630327.50	18779335.55	12.50	24	2026-02-27	\N	\N	600	\N	\N	\N	4
465	3	9259522.81	28885750.53	12.50	24	2026-02-27	\N	\N	929	\N	\N	\N	4
466	3	40827702.14	25148831.08	12.50	24	2026-02-27	\N	\N	491	\N	\N	\N	4
467	3	26507879.85	17714701.37	12.50	24	2026-02-27	\N	\N	715	\N	\N	\N	4
468	3	20842860.38	3802278.62	12.50	24	2026-02-27	\N	\N	658	\N	\N	\N	4
469	3	40876569.54	16982998.15	12.50	24	2026-02-27	\N	\N	911	\N	\N	\N	4
470	3	10116906.02	761071.19	12.50	24	2026-02-27	\N	\N	443	\N	\N	\N	4
471	3	7490412.94	31462522.67	12.50	24	2026-02-27	\N	\N	747	\N	\N	\N	4
472	3	43860161.26	17868247.99	12.50	24	2026-02-27	\N	\N	753	\N	\N	\N	4
473	3	14377368.33	7123217.35	12.50	24	2026-02-27	\N	\N	177	\N	\N	\N	4
474	3	19840082.94	12647955.00	12.50	24	2026-02-27	\N	\N	748	\N	\N	\N	4
475	3	21623191.90	5742952.55	12.50	24	2026-02-27	\N	\N	374	\N	\N	\N	4
476	3	8514573.66	9021263.89	12.50	24	2026-02-27	\N	\N	397	\N	\N	\N	4
477	3	32295968.04	22143735.28	12.50	24	2026-02-27	\N	\N	387	\N	\N	\N	4
478	3	1462007.46	27334226.01	12.50	24	2026-02-27	\N	\N	186	\N	\N	\N	4
479	3	17691079.28	215323.12	12.50	24	2026-02-27	\N	\N	745	\N	\N	\N	4
480	3	49667847.06	30397328.03	12.50	24	2026-02-27	\N	\N	232	\N	\N	\N	4
481	3	5616265.38	20212359.31	12.50	24	2026-02-27	\N	\N	298	\N	\N	\N	4
482	3	22011779.74	32725826.19	12.50	24	2026-02-27	\N	\N	178	\N	\N	\N	4
483	3	38079529.00	32031951.59	12.50	24	2026-02-27	\N	\N	670	\N	\N	\N	4
484	3	13627913.84	20697073.77	12.50	24	2026-02-27	\N	\N	739	\N	\N	\N	4
485	3	1469519.33	28353361.88	12.50	24	2026-02-27	\N	\N	263	\N	\N	\N	4
486	3	31572307.01	31566956.04	12.50	24	2026-02-27	\N	\N	629	\N	\N	\N	4
487	3	5943813.80	27155107.62	12.50	24	2026-02-27	\N	\N	274	\N	\N	\N	4
488	3	16521331.11	5980139.42	12.50	24	2026-02-27	\N	\N	660	\N	\N	\N	4
489	3	38422653.65	34308928.10	12.50	24	2026-02-27	\N	\N	723	\N	\N	\N	4
490	3	5070801.42	2919829.66	12.50	24	2026-02-27	\N	\N	242	\N	\N	\N	4
491	3	24477158.63	38506534.95	12.50	24	2026-02-27	\N	\N	921	\N	\N	\N	4
492	3	10330418.33	35597915.81	12.50	24	2026-02-27	\N	\N	596	\N	\N	\N	4
493	3	42200942.51	7749042.36	12.50	24	2026-02-27	\N	\N	159	\N	\N	\N	4
494	3	10471672.10	18481778.99	12.50	24	2026-02-27	\N	\N	910	\N	\N	\N	4
495	3	30485703.38	24487001.61	12.50	24	2026-02-27	\N	\N	190	\N	\N	\N	4
496	3	39058650.42	26883331.35	12.50	24	2026-02-27	\N	\N	480	\N	\N	\N	4
497	3	37431005.00	15100050.99	12.50	24	2026-02-27	\N	\N	466	\N	\N	\N	4
498	3	28355458.89	31297487.22	12.50	24	2026-02-27	\N	\N	421	\N	\N	\N	4
499	3	11053511.76	17158850.64	12.50	24	2026-02-27	\N	\N	978	\N	\N	\N	4
500	3	32287304.68	31232182.29	12.50	24	2026-02-27	\N	\N	626	\N	\N	\N	4
\.


--
-- TOC entry 5106 (class 0 OID 16647)
-- Dependencies: 224
-- Data for Name: producto_bancario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.producto_bancario (id_producto, nombre_producto, categoria, requiere_aprobacion) FROM stdin;
1	Cuenta Ahorros	Cuenta	f
2	Cuenta Corriente	Cuenta	f
3	Prestamo Personal	Prestamo	t
4	Prestamo Empresarial	Prestamo	t
\.


--
-- TOC entry 5102 (class 0 OID 16629)
-- Dependencies: 220
-- Data for Name: rol; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rol (id_rol, nombre_rol) FROM stdin;
1	CLIENTE_PERSONA
2	CLIENTE_EMPRESA
3	EMPLEADO_VENTANILLA
4	EMPLEADO_COMERCIAL
5	EMPLEADO_EMPRESA
6	SUPERVISOR_EMPRESA
7	ANALISTA_INTERNO
\.


--
-- TOC entry 5118 (class 0 OID 16812)
-- Dependencies: 236
-- Data for Name: transferencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transferencia (id_transferencia, id_cuenta_origen, id_cuenta_destino, monto, fecha_creacion, fecha_aprobacion, id_usuario_creador, id_usuario_aprobador, id_estado) FROM stdin;
1	314	364	37102.55	2026-02-27 23:41:14.46239	\N	947	\N	8
2	596	917	72758.91	2026-02-27 23:41:14.46239	\N	585	\N	8
3	638	501	68427.17	2026-02-27 23:41:14.46239	\N	746	\N	8
4	656	79	98455.83	2026-02-27 23:41:14.46239	\N	174	\N	8
5	437	385	11386.78	2026-02-27 23:41:14.46239	\N	980	\N	8
6	922	802	4743.76	2026-02-27 23:41:14.46239	\N	780	\N	8
7	149	247	1889.01	2026-02-27 23:41:14.46239	\N	308	\N	8
8	611	682	48009.65	2026-02-27 23:41:14.46239	\N	675	\N	8
9	795	983	21594.51	2026-02-27 23:41:14.46239	\N	914	\N	8
10	31	913	2193.25	2026-02-27 23:41:14.46239	\N	452	\N	8
11	598	256	30759.40	2026-02-27 23:41:14.46239	\N	352	\N	8
12	612	572	19813.81	2026-02-27 23:41:14.46239	\N	469	\N	8
13	19	798	45905.71	2026-02-27 23:41:14.46239	\N	156	\N	8
14	985	418	92731.85	2026-02-27 23:41:14.46239	\N	795	\N	8
15	666	370	66364.94	2026-02-27 23:41:14.46239	\N	910	\N	8
16	796	428	57999.74	2026-02-27 23:41:14.46239	\N	276	\N	8
17	798	572	39463.53	2026-02-27 23:41:14.46239	\N	561	\N	8
18	403	112	84592.76	2026-02-27 23:41:14.46239	\N	252	\N	8
19	118	410	49747.93	2026-02-27 23:41:14.46239	\N	995	\N	8
20	385	31	65731.02	2026-02-27 23:41:14.46239	\N	12	\N	8
21	116	175	42356.24	2026-02-27 23:41:14.46239	\N	94	\N	8
22	501	537	63269.01	2026-02-27 23:41:14.46239	\N	685	\N	8
23	857	851	87269.34	2026-02-27 23:41:14.46239	\N	712	\N	8
24	258	273	72806.33	2026-02-27 23:41:14.46239	\N	340	\N	8
25	507	104	62869.09	2026-02-27 23:41:14.46239	\N	491	\N	8
26	197	600	70679.01	2026-02-27 23:41:14.46239	\N	352	\N	8
27	603	661	26873.59	2026-02-27 23:41:14.46239	\N	253	\N	8
28	580	232	33248.45	2026-02-27 23:41:14.46239	\N	535	\N	8
29	670	997	96502.33	2026-02-27 23:41:14.46239	\N	440	\N	8
30	146	604	49094.92	2026-02-27 23:41:14.46239	\N	823	\N	8
31	397	68	28348.59	2026-02-27 23:41:14.46239	\N	86	\N	8
32	103	472	34929.61	2026-02-27 23:41:14.46239	\N	960	\N	8
33	35	528	17238.74	2026-02-27 23:41:14.46239	\N	121	\N	8
34	353	715	70749.61	2026-02-27 23:41:14.46239	\N	613	\N	8
35	178	336	21960.49	2026-02-27 23:41:14.46239	\N	960	\N	8
36	847	482	91039.85	2026-02-27 23:41:14.46239	\N	459	\N	8
37	455	194	52779.37	2026-02-27 23:41:14.46239	\N	317	\N	8
38	79	938	61335.37	2026-02-27 23:41:14.46239	\N	335	\N	8
39	350	669	73016.13	2026-02-27 23:41:14.46239	\N	242	\N	8
40	928	519	2532.88	2026-02-27 23:41:14.46239	\N	485	\N	8
41	751	977	59280.63	2026-02-27 23:41:14.46239	\N	526	\N	8
42	183	72	1919.84	2026-02-27 23:41:14.46239	\N	328	\N	8
43	435	676	43745.22	2026-02-27 23:41:14.46239	\N	83	\N	8
44	17	946	12750.11	2026-02-27 23:41:14.46239	\N	426	\N	8
45	910	933	35056.36	2026-02-27 23:41:14.46239	\N	60	\N	8
46	831	687	94319.44	2026-02-27 23:41:14.46239	\N	131	\N	8
47	566	57	83997.62	2026-02-27 23:41:14.46239	\N	818	\N	8
48	228	7	62432.72	2026-02-27 23:41:14.46239	\N	78	\N	8
49	939	855	31744.17	2026-02-27 23:41:14.46239	\N	53	\N	8
50	751	158	91813.52	2026-02-27 23:41:14.46239	\N	240	\N	8
51	187	235	12274.32	2026-02-27 23:41:14.46239	\N	355	\N	8
52	517	211	27891.43	2026-02-27 23:41:14.46239	\N	860	\N	8
53	318	927	7555.80	2026-02-27 23:41:14.46239	\N	182	\N	8
54	631	352	48462.57	2026-02-27 23:41:14.46239	\N	633	\N	8
55	800	891	18044.73	2026-02-27 23:41:14.46239	\N	854	\N	8
56	32	145	85327.39	2026-02-27 23:41:14.46239	\N	891	\N	8
57	39	112	5892.47	2026-02-27 23:41:14.46239	\N	271	\N	8
58	852	773	87784.10	2026-02-27 23:41:14.46239	\N	611	\N	8
59	530	321	28092.90	2026-02-27 23:41:14.46239	\N	304	\N	8
60	114	61	50855.17	2026-02-27 23:41:14.46239	\N	506	\N	8
61	523	208	44618.33	2026-02-27 23:41:14.46239	\N	512	\N	8
62	284	792	2726.78	2026-02-27 23:41:14.46239	\N	422	\N	8
63	37	157	38496.77	2026-02-27 23:41:14.46239	\N	721	\N	8
64	664	703	16355.69	2026-02-27 23:41:14.46239	\N	583	\N	8
65	254	543	21542.18	2026-02-27 23:41:14.46239	\N	835	\N	8
66	113	793	58321.66	2026-02-27 23:41:14.46239	\N	854	\N	8
67	419	383	91281.91	2026-02-27 23:41:14.46239	\N	308	\N	8
68	680	614	28207.18	2026-02-27 23:41:14.46239	\N	173	\N	8
69	829	43	26727.79	2026-02-27 23:41:14.46239	\N	13	\N	8
70	486	15	74048.96	2026-02-27 23:41:14.46239	\N	949	\N	8
71	407	251	3896.34	2026-02-27 23:41:14.46239	\N	120	\N	8
72	415	718	62894.31	2026-02-27 23:41:14.46239	\N	252	\N	8
73	25	117	73402.31	2026-02-27 23:41:14.46239	\N	979	\N	8
74	876	484	31225.58	2026-02-27 23:41:14.46239	\N	993	\N	8
75	883	104	30182.96	2026-02-27 23:41:14.46239	\N	850	\N	8
76	700	425	29105.38	2026-02-27 23:41:14.46239	\N	167	\N	8
77	834	73	97372.66	2026-02-27 23:41:14.46239	\N	787	\N	8
78	721	14	65143.84	2026-02-27 23:41:14.46239	\N	907	\N	8
79	295	871	70712.71	2026-02-27 23:41:14.46239	\N	972	\N	8
80	724	144	89290.16	2026-02-27 23:41:14.46239	\N	54	\N	8
81	155	484	11825.05	2026-02-27 23:41:14.46239	\N	325	\N	8
82	135	855	56402.12	2026-02-27 23:41:14.46239	\N	222	\N	8
83	834	183	14107.24	2026-02-27 23:41:14.46239	\N	493	\N	8
84	191	721	24230.12	2026-02-27 23:41:14.46239	\N	230	\N	8
85	634	625	74075.88	2026-02-27 23:41:14.46239	\N	717	\N	8
86	159	748	12072.08	2026-02-27 23:41:14.46239	\N	525	\N	8
87	965	196	34472.40	2026-02-27 23:41:14.46239	\N	168	\N	8
88	479	776	67549.60	2026-02-27 23:41:14.46239	\N	458	\N	8
89	332	911	84249.47	2026-02-27 23:41:14.46239	\N	81	\N	8
90	149	387	72132.15	2026-02-27 23:41:14.46239	\N	553	\N	8
91	427	613	78411.76	2026-02-27 23:41:14.46239	\N	550	\N	8
92	273	246	93038.85	2026-02-27 23:41:14.46239	\N	907	\N	8
93	72	18	20196.87	2026-02-27 23:41:14.46239	\N	368	\N	8
94	45	958	64026.55	2026-02-27 23:41:14.46239	\N	717	\N	8
95	658	527	79045.73	2026-02-27 23:41:14.46239	\N	728	\N	8
96	591	737	46759.26	2026-02-27 23:41:14.46239	\N	410	\N	8
97	414	94	42521.98	2026-02-27 23:41:14.46239	\N	265	\N	8
98	972	729	49344.42	2026-02-27 23:41:14.46239	\N	237	\N	8
99	122	602	98742.45	2026-02-27 23:41:14.46239	\N	938	\N	8
100	102	815	95983.90	2026-02-27 23:41:14.46239	\N	848	\N	8
101	792	14	21093.07	2026-02-27 23:41:14.46239	\N	298	\N	8
102	599	914	58919.58	2026-02-27 23:41:14.46239	\N	12	\N	8
103	898	874	31651.76	2026-02-27 23:41:14.46239	\N	900	\N	8
104	911	133	16105.20	2026-02-27 23:41:14.46239	\N	893	\N	8
105	33	703	99262.93	2026-02-27 23:41:14.46239	\N	559	\N	8
106	50	854	30967.08	2026-02-27 23:41:14.46239	\N	123	\N	8
107	254	385	12186.29	2026-02-27 23:41:14.46239	\N	281	\N	8
108	458	809	94765.64	2026-02-27 23:41:14.46239	\N	774	\N	8
109	596	613	91429.51	2026-02-27 23:41:14.46239	\N	582	\N	8
110	91	185	69201.19	2026-02-27 23:41:14.46239	\N	104	\N	8
111	330	208	12120.54	2026-02-27 23:41:14.46239	\N	946	\N	8
112	949	743	1171.47	2026-02-27 23:41:14.46239	\N	728	\N	8
113	853	8	82661.68	2026-02-27 23:41:14.46239	\N	686	\N	8
114	694	521	75689.77	2026-02-27 23:41:14.46239	\N	59	\N	8
115	138	202	57539.93	2026-02-27 23:41:14.46239	\N	205	\N	8
116	874	117	48498.25	2026-02-27 23:41:14.46239	\N	767	\N	8
117	905	48	21208.47	2026-02-27 23:41:14.46239	\N	597	\N	8
118	394	646	20090.47	2026-02-27 23:41:14.46239	\N	245	\N	8
119	10	12	72939.36	2026-02-27 23:41:14.46239	\N	758	\N	8
120	807	476	96656.58	2026-02-27 23:41:14.46239	\N	96	\N	8
121	687	61	35074.13	2026-02-27 23:41:14.46239	\N	980	\N	8
122	245	829	5143.06	2026-02-27 23:41:14.46239	\N	557	\N	8
123	125	945	2258.23	2026-02-27 23:41:14.46239	\N	703	\N	8
124	851	715	88766.87	2026-02-27 23:41:14.46239	\N	84	\N	8
125	302	378	57064.46	2026-02-27 23:41:14.46239	\N	192	\N	8
126	60	969	562.23	2026-02-27 23:41:14.46239	\N	54	\N	8
127	300	176	78723.94	2026-02-27 23:41:14.46239	\N	413	\N	8
128	247	943	45821.59	2026-02-27 23:41:14.46239	\N	925	\N	8
129	990	222	1601.75	2026-02-27 23:41:14.46239	\N	506	\N	8
130	285	188	18643.72	2026-02-27 23:41:14.46239	\N	245	\N	8
131	644	426	79317.80	2026-02-27 23:41:14.46239	\N	522	\N	8
132	36	975	24286.37	2026-02-27 23:41:14.46239	\N	747	\N	8
133	508	251	40818.29	2026-02-27 23:41:14.46239	\N	859	\N	8
134	594	202	58363.44	2026-02-27 23:41:14.46239	\N	879	\N	8
135	976	151	62235.73	2026-02-27 23:41:14.46239	\N	480	\N	8
136	587	673	20606.35	2026-02-27 23:41:14.46239	\N	726	\N	8
137	861	594	13217.16	2026-02-27 23:41:14.46239	\N	422	\N	8
138	724	751	9682.96	2026-02-27 23:41:14.46239	\N	365	\N	8
139	981	261	3778.97	2026-02-27 23:41:14.46239	\N	709	\N	8
140	15	504	14908.48	2026-02-27 23:41:14.46239	\N	762	\N	8
141	868	943	96674.41	2026-02-27 23:41:14.46239	\N	158	\N	8
142	765	187	29127.25	2026-02-27 23:41:14.46239	\N	427	\N	8
143	384	271	70419.81	2026-02-27 23:41:14.46239	\N	251	\N	8
144	777	59	49977.66	2026-02-27 23:41:14.46239	\N	563	\N	8
145	899	30	52582.15	2026-02-27 23:41:14.46239	\N	631	\N	8
146	780	632	11756.98	2026-02-27 23:41:14.46239	\N	882	\N	8
147	169	266	66693.83	2026-02-27 23:41:14.46239	\N	439	\N	8
148	772	568	49441.72	2026-02-27 23:41:14.46239	\N	779	\N	8
149	782	262	32251.65	2026-02-27 23:41:14.46239	\N	63	\N	8
150	474	419	4227.90	2026-02-27 23:41:14.46239	\N	423	\N	8
151	296	32	18933.20	2026-02-27 23:41:14.46239	\N	671	\N	8
152	291	934	33292.40	2026-02-27 23:41:14.46239	\N	216	\N	8
153	341	617	37143.18	2026-02-27 23:41:14.46239	\N	726	\N	8
154	997	804	30685.05	2026-02-27 23:41:14.46239	\N	390	\N	8
155	248	992	92505.43	2026-02-27 23:41:14.46239	\N	364	\N	8
156	496	358	51390.10	2026-02-27 23:41:14.46239	\N	904	\N	8
157	226	30	10576.99	2026-02-27 23:41:14.46239	\N	43	\N	8
158	680	423	87107.55	2026-02-27 23:41:14.46239	\N	323	\N	8
159	770	320	92680.43	2026-02-27 23:41:14.46239	\N	784	\N	8
160	351	713	5168.84	2026-02-27 23:41:14.46239	\N	86	\N	8
161	514	950	1696.03	2026-02-27 23:41:14.46239	\N	377	\N	8
162	75	767	34474.33	2026-02-27 23:41:14.46239	\N	685	\N	8
163	677	377	55253.00	2026-02-27 23:41:14.46239	\N	414	\N	8
164	941	95	70896.87	2026-02-27 23:41:14.46239	\N	482	\N	8
165	120	108	38695.16	2026-02-27 23:41:14.46239	\N	256	\N	8
166	185	249	71305.43	2026-02-27 23:41:14.46239	\N	487	\N	8
167	914	743	77914.77	2026-02-27 23:41:14.46239	\N	264	\N	8
168	274	95	37714.71	2026-02-27 23:41:14.46239	\N	982	\N	8
169	569	427	57434.98	2026-02-27 23:41:14.46239	\N	469	\N	8
170	150	492	72900.98	2026-02-27 23:41:14.46239	\N	14	\N	8
171	93	605	9544.22	2026-02-27 23:41:14.46239	\N	655	\N	8
172	298	22	18853.40	2026-02-27 23:41:14.46239	\N	228	\N	8
173	2	716	11632.36	2026-02-27 23:41:14.46239	\N	793	\N	8
174	717	986	45595.62	2026-02-27 23:41:14.46239	\N	332	\N	8
175	969	364	71116.17	2026-02-27 23:41:14.46239	\N	438	\N	8
176	677	741	45290.39	2026-02-27 23:41:14.46239	\N	660	\N	8
177	677	49	26714.32	2026-02-27 23:41:14.46239	\N	755	\N	8
178	397	276	9536.14	2026-02-27 23:41:14.46239	\N	738	\N	8
179	846	991	66148.86	2026-02-27 23:41:14.46239	\N	345	\N	8
180	708	416	26385.73	2026-02-27 23:41:14.46239	\N	443	\N	8
181	170	83	20436.04	2026-02-27 23:41:14.46239	\N	487	\N	8
182	230	352	19684.87	2026-02-27 23:41:14.46239	\N	31	\N	8
183	832	680	30518.75	2026-02-27 23:41:14.46239	\N	527	\N	8
184	812	422	66251.71	2026-02-27 23:41:14.46239	\N	971	\N	8
185	489	283	98521.88	2026-02-27 23:41:14.46239	\N	585	\N	8
186	388	786	13467.95	2026-02-27 23:41:14.46239	\N	71	\N	8
187	960	516	27703.40	2026-02-27 23:41:14.46239	\N	571	\N	8
188	984	175	89490.42	2026-02-27 23:41:14.46239	\N	112	\N	8
189	352	159	52498.50	2026-02-27 23:41:14.46239	\N	457	\N	8
190	681	465	44155.35	2026-02-27 23:41:14.46239	\N	272	\N	8
191	436	513	67977.83	2026-02-27 23:41:14.46239	\N	167	\N	8
192	782	234	87190.22	2026-02-27 23:41:14.46239	\N	47	\N	8
193	294	370	51186.24	2026-02-27 23:41:14.46239	\N	185	\N	8
194	317	355	30329.77	2026-02-27 23:41:14.46239	\N	940	\N	8
195	862	129	32989.21	2026-02-27 23:41:14.46239	\N	654	\N	8
196	830	909	20352.56	2026-02-27 23:41:14.46239	\N	123	\N	8
197	190	875	56246.35	2026-02-27 23:41:14.46239	\N	589	\N	8
198	812	465	34555.48	2026-02-27 23:41:14.46239	\N	384	\N	8
199	872	886	14639.25	2026-02-27 23:41:14.46239	\N	490	\N	8
200	260	272	60400.38	2026-02-27 23:41:14.46239	\N	342	\N	8
201	985	247	40088.35	2026-02-27 23:41:14.46239	\N	512	\N	8
202	320	66	10207.11	2026-02-27 23:41:14.46239	\N	933	\N	8
203	83	352	76442.51	2026-02-27 23:41:14.46239	\N	644	\N	8
204	588	453	20719.24	2026-02-27 23:41:14.46239	\N	759	\N	8
205	257	870	5756.73	2026-02-27 23:41:14.46239	\N	551	\N	8
206	222	394	83214.23	2026-02-27 23:41:14.46239	\N	567	\N	8
207	566	101	20287.14	2026-02-27 23:41:14.46239	\N	139	\N	8
208	954	342	69593.16	2026-02-27 23:41:14.46239	\N	651	\N	8
209	470	712	37985.82	2026-02-27 23:41:14.46239	\N	567	\N	8
210	476	301	6043.58	2026-02-27 23:41:14.46239	\N	559	\N	8
211	854	596	98280.91	2026-02-27 23:41:14.46239	\N	66	\N	8
212	991	422	54479.58	2026-02-27 23:41:14.46239	\N	420	\N	8
213	776	656	44957.13	2026-02-27 23:41:14.46239	\N	752	\N	8
214	340	208	35570.74	2026-02-27 23:41:14.46239	\N	88	\N	8
215	566	439	77403.12	2026-02-27 23:41:14.46239	\N	84	\N	8
216	409	115	55415.07	2026-02-27 23:41:14.46239	\N	847	\N	8
217	968	973	78576.53	2026-02-27 23:41:14.46239	\N	708	\N	8
218	422	29	59453.79	2026-02-27 23:41:14.46239	\N	985	\N	8
219	224	406	41570.63	2026-02-27 23:41:14.46239	\N	34	\N	8
220	692	802	79005.87	2026-02-27 23:41:14.46239	\N	681	\N	8
221	758	909	58989.70	2026-02-27 23:41:14.46239	\N	27	\N	8
222	754	10	35888.08	2026-02-27 23:41:14.46239	\N	937	\N	8
223	860	991	70566.66	2026-02-27 23:41:14.46239	\N	692	\N	8
224	457	349	68008.79	2026-02-27 23:41:14.46239	\N	250	\N	8
225	657	971	51350.37	2026-02-27 23:41:14.46239	\N	973	\N	8
226	216	721	85352.36	2026-02-27 23:41:14.46239	\N	894	\N	8
227	507	684	80231.49	2026-02-27 23:41:14.46239	\N	418	\N	8
228	638	951	25239.66	2026-02-27 23:41:14.46239	\N	869	\N	8
229	183	767	44096.17	2026-02-27 23:41:14.46239	\N	343	\N	8
230	909	929	11483.43	2026-02-27 23:41:14.46239	\N	179	\N	8
231	444	653	82106.23	2026-02-27 23:41:14.46239	\N	281	\N	8
232	236	843	40554.87	2026-02-27 23:41:14.46239	\N	100	\N	8
233	651	137	36190.66	2026-02-27 23:41:14.46239	\N	616	\N	8
234	127	234	3258.70	2026-02-27 23:41:14.46239	\N	505	\N	8
235	18	917	90483.62	2026-02-27 23:41:14.46239	\N	700	\N	8
236	100	777	68191.18	2026-02-27 23:41:14.46239	\N	759	\N	8
237	744	4	6396.03	2026-02-27 23:41:14.46239	\N	27	\N	8
238	214	366	98124.58	2026-02-27 23:41:14.46239	\N	695	\N	8
239	156	23	41984.40	2026-02-27 23:41:14.46239	\N	952	\N	8
240	884	334	98175.70	2026-02-27 23:41:14.46239	\N	475	\N	8
241	763	682	77962.49	2026-02-27 23:41:14.46239	\N	687	\N	8
242	683	285	34830.40	2026-02-27 23:41:14.46239	\N	623	\N	8
243	278	614	17248.21	2026-02-27 23:41:14.46239	\N	584	\N	8
244	323	644	12836.75	2026-02-27 23:41:14.46239	\N	112	\N	8
245	64	637	47852.66	2026-02-27 23:41:14.46239	\N	182	\N	8
246	496	898	44181.60	2026-02-27 23:41:14.46239	\N	637	\N	8
247	803	337	83740.26	2026-02-27 23:41:14.46239	\N	331	\N	8
248	133	959	19318.25	2026-02-27 23:41:14.46239	\N	4	\N	8
249	133	741	20541.05	2026-02-27 23:41:14.46239	\N	483	\N	8
250	724	438	371.14	2026-02-27 23:41:14.46239	\N	253	\N	8
251	236	581	37214.82	2026-02-27 23:41:14.46239	\N	252	\N	8
252	362	684	33575.19	2026-02-27 23:41:14.46239	\N	488	\N	8
253	195	274	75714.32	2026-02-27 23:41:14.46239	\N	924	\N	8
254	750	18	27203.07	2026-02-27 23:41:14.46239	\N	77	\N	8
255	624	10	32178.84	2026-02-27 23:41:14.46239	\N	363	\N	8
256	933	306	15411.65	2026-02-27 23:41:14.46239	\N	436	\N	8
257	637	867	75532.69	2026-02-27 23:41:14.46239	\N	744	\N	8
258	157	480	4448.98	2026-02-27 23:41:14.46239	\N	826	\N	8
259	162	315	92013.57	2026-02-27 23:41:14.46239	\N	54	\N	8
260	988	130	64395.87	2026-02-27 23:41:14.46239	\N	608	\N	8
261	690	625	3306.61	2026-02-27 23:41:14.46239	\N	73	\N	8
262	244	742	22031.65	2026-02-27 23:41:14.46239	\N	660	\N	8
263	657	208	15194.08	2026-02-27 23:41:14.46239	\N	985	\N	8
264	734	738	52214.15	2026-02-27 23:41:14.46239	\N	961	\N	8
265	11	690	74042.51	2026-02-27 23:41:14.46239	\N	36	\N	8
266	818	747	10790.27	2026-02-27 23:41:14.46239	\N	254	\N	8
267	131	991	9917.69	2026-02-27 23:41:14.46239	\N	137	\N	8
268	314	164	89119.91	2026-02-27 23:41:14.46239	\N	105	\N	8
269	15	994	88232.45	2026-02-27 23:41:14.46239	\N	126	\N	8
270	793	698	20797.39	2026-02-27 23:41:14.46239	\N	997	\N	8
271	208	364	65490.64	2026-02-27 23:41:14.46239	\N	162	\N	8
272	402	313	41443.50	2026-02-27 23:41:14.46239	\N	2	\N	8
273	19	410	2800.39	2026-02-27 23:41:14.46239	\N	803	\N	8
274	210	38	7728.29	2026-02-27 23:41:14.46239	\N	64	\N	8
275	258	99	44727.50	2026-02-27 23:41:14.46239	\N	204	\N	8
276	494	92	42551.11	2026-02-27 23:41:14.46239	\N	403	\N	8
277	841	607	14823.02	2026-02-27 23:41:14.46239	\N	112	\N	8
278	511	209	15025.40	2026-02-27 23:41:14.46239	\N	297	\N	8
279	394	850	6993.24	2026-02-27 23:41:14.46239	\N	646	\N	8
280	837	563	93423.55	2026-02-27 23:41:14.46239	\N	620	\N	8
281	718	798	23716.88	2026-02-27 23:41:14.46239	\N	980	\N	8
282	933	786	90365.56	2026-02-27 23:41:14.46239	\N	184	\N	8
283	912	979	77231.31	2026-02-27 23:41:14.46239	\N	336	\N	8
284	759	484	77787.97	2026-02-27 23:41:14.46239	\N	189	\N	8
285	434	964	61044.49	2026-02-27 23:41:14.46239	\N	293	\N	8
286	883	731	88484.17	2026-02-27 23:41:14.46239	\N	121	\N	8
287	399	482	6609.42	2026-02-27 23:41:14.46239	\N	574	\N	8
288	422	957	61720.86	2026-02-27 23:41:14.46239	\N	751	\N	8
289	573	777	97738.99	2026-02-27 23:41:14.46239	\N	106	\N	8
290	146	880	77822.38	2026-02-27 23:41:14.46239	\N	43	\N	8
291	445	854	22007.37	2026-02-27 23:41:14.46239	\N	978	\N	8
292	848	341	69044.72	2026-02-27 23:41:14.46239	\N	722	\N	8
293	914	644	72519.53	2026-02-27 23:41:14.46239	\N	812	\N	8
294	936	954	90108.18	2026-02-27 23:41:14.46239	\N	303	\N	8
295	994	985	14350.89	2026-02-27 23:41:14.46239	\N	315	\N	8
296	248	363	20967.25	2026-02-27 23:41:14.46239	\N	987	\N	8
297	846	855	13703.71	2026-02-27 23:41:14.46239	\N	915	\N	8
298	470	607	87261.59	2026-02-27 23:41:14.46239	\N	186	\N	8
299	652	908	84090.49	2026-02-27 23:41:14.46239	\N	152	\N	8
300	192	863	15579.96	2026-02-27 23:41:14.46239	\N	869	\N	8
301	714	663	27772.26	2026-02-27 23:41:14.46239	\N	744	\N	8
302	628	246	23884.63	2026-02-27 23:41:14.46239	\N	589	\N	8
303	385	680	21675.24	2026-02-27 23:41:14.46239	\N	67	\N	8
304	256	215	21791.96	2026-02-27 23:41:14.46239	\N	439	\N	8
305	19	118	50400.72	2026-02-27 23:41:14.46239	\N	632	\N	8
306	80	353	76483.20	2026-02-27 23:41:14.46239	\N	163	\N	8
307	254	733	88422.56	2026-02-27 23:41:14.46239	\N	681	\N	8
308	648	501	31751.52	2026-02-27 23:41:14.46239	\N	287	\N	8
309	905	475	68766.46	2026-02-27 23:41:14.46239	\N	308	\N	8
310	525	985	22215.60	2026-02-27 23:41:14.46239	\N	117	\N	8
311	351	955	57866.99	2026-02-27 23:41:14.46239	\N	738	\N	8
312	299	957	17408.97	2026-02-27 23:41:14.46239	\N	553	\N	8
313	297	929	23414.48	2026-02-27 23:41:14.46239	\N	445	\N	8
314	445	3	37043.93	2026-02-27 23:41:14.46239	\N	939	\N	8
315	105	954	14597.65	2026-02-27 23:41:14.46239	\N	138	\N	8
316	391	909	2159.05	2026-02-27 23:41:14.46239	\N	627	\N	8
317	172	744	55204.17	2026-02-27 23:41:14.46239	\N	922	\N	8
318	317	132	29750.36	2026-02-27 23:41:14.46239	\N	249	\N	8
319	463	710	95398.68	2026-02-27 23:41:14.46239	\N	574	\N	8
320	251	95	11035.65	2026-02-27 23:41:14.46239	\N	375	\N	8
321	897	564	89960.91	2026-02-27 23:41:14.46239	\N	573	\N	8
322	433	231	21158.30	2026-02-27 23:41:14.46239	\N	880	\N	8
323	342	402	15604.41	2026-02-27 23:41:14.46239	\N	491	\N	8
324	685	779	98511.68	2026-02-27 23:41:14.46239	\N	193	\N	8
325	899	270	73867.44	2026-02-27 23:41:14.46239	\N	518	\N	8
326	699	165	64583.75	2026-02-27 23:41:14.46239	\N	372	\N	8
327	446	131	37810.98	2026-02-27 23:41:14.46239	\N	439	\N	8
328	831	742	2046.03	2026-02-27 23:41:14.46239	\N	951	\N	8
329	243	790	35022.02	2026-02-27 23:41:14.46239	\N	12	\N	8
330	985	17	80832.13	2026-02-27 23:41:14.46239	\N	370	\N	8
331	735	547	33167.27	2026-02-27 23:41:14.46239	\N	786	\N	8
332	665	522	30293.53	2026-02-27 23:41:14.46239	\N	112	\N	8
333	30	612	85010.30	2026-02-27 23:41:14.46239	\N	296	\N	8
334	221	109	35058.13	2026-02-27 23:41:14.46239	\N	621	\N	8
335	877	633	63400.47	2026-02-27 23:41:14.46239	\N	794	\N	8
336	350	87	47322.06	2026-02-27 23:41:14.46239	\N	309	\N	8
337	707	165	61811.26	2026-02-27 23:41:14.46239	\N	657	\N	8
338	725	1000	709.46	2026-02-27 23:41:14.46239	\N	97	\N	8
339	211	734	84373.00	2026-02-27 23:41:14.46239	\N	602	\N	8
340	432	392	18826.26	2026-02-27 23:41:14.46239	\N	521	\N	8
341	5	851	84157.04	2026-02-27 23:41:14.46239	\N	236	\N	8
342	203	294	58712.43	2026-02-27 23:41:14.46239	\N	766	\N	8
343	74	182	87034.63	2026-02-27 23:41:14.46239	\N	441	\N	8
344	521	879	95861.50	2026-02-27 23:41:14.46239	\N	489	\N	8
345	918	803	72367.03	2026-02-27 23:41:14.46239	\N	640	\N	8
346	501	80	73720.99	2026-02-27 23:41:14.46239	\N	910	\N	8
347	282	178	82198.01	2026-02-27 23:41:14.46239	\N	806	\N	8
348	774	998	52809.69	2026-02-27 23:41:14.46239	\N	811	\N	8
349	321	516	85484.91	2026-02-27 23:41:14.46239	\N	61	\N	8
350	709	817	49965.75	2026-02-27 23:41:14.46239	\N	991	\N	8
351	649	606	603.88	2026-02-27 23:41:14.46239	\N	598	\N	8
352	692	678	698.49	2026-02-27 23:41:14.46239	\N	257	\N	8
353	482	957	19685.62	2026-02-27 23:41:14.46239	\N	761	\N	8
354	752	102	32590.73	2026-02-27 23:41:14.46239	\N	441	\N	8
355	592	955	71652.01	2026-02-27 23:41:14.46239	\N	108	\N	8
356	186	955	67105.09	2026-02-27 23:41:14.46239	\N	450	\N	8
357	335	906	70536.87	2026-02-27 23:41:14.46239	\N	284	\N	8
358	190	739	50634.90	2026-02-27 23:41:14.46239	\N	381	\N	8
359	124	403	4334.77	2026-02-27 23:41:14.46239	\N	613	\N	8
360	963	54	70112.64	2026-02-27 23:41:14.46239	\N	120	\N	8
361	568	843	56121.45	2026-02-27 23:41:14.46239	\N	560	\N	8
362	825	412	20674.21	2026-02-27 23:41:14.46239	\N	139	\N	8
363	546	142	42566.73	2026-02-27 23:41:14.46239	\N	257	\N	8
364	162	12	94606.45	2026-02-27 23:41:14.46239	\N	430	\N	8
365	449	722	99879.35	2026-02-27 23:41:14.46239	\N	720	\N	8
366	636	409	12886.91	2026-02-27 23:41:14.46239	\N	880	\N	8
367	569	671	90015.00	2026-02-27 23:41:14.46239	\N	44	\N	8
368	535	976	99984.42	2026-02-27 23:41:14.46239	\N	593	\N	8
369	5	923	10130.81	2026-02-27 23:41:14.46239	\N	176	\N	8
370	924	459	81581.83	2026-02-27 23:41:14.46239	\N	116	\N	8
371	893	952	84208.97	2026-02-27 23:41:14.46239	\N	582	\N	8
372	144	7	88548.72	2026-02-27 23:41:14.46239	\N	910	\N	8
373	631	442	7220.17	2026-02-27 23:41:14.46239	\N	825	\N	8
374	710	127	16156.07	2026-02-27 23:41:14.46239	\N	28	\N	8
375	8	813	22784.47	2026-02-27 23:41:14.46239	\N	427	\N	8
376	225	879	1044.41	2026-02-27 23:41:14.46239	\N	159	\N	8
377	148	827	6387.39	2026-02-27 23:41:14.46239	\N	54	\N	8
378	907	168	25236.37	2026-02-27 23:41:14.46239	\N	703	\N	8
379	780	858	37264.56	2026-02-27 23:41:14.46239	\N	665	\N	8
380	154	7	79370.61	2026-02-27 23:41:14.46239	\N	557	\N	8
381	304	350	44781.95	2026-02-27 23:41:14.46239	\N	76	\N	8
382	850	117	51098.91	2026-02-27 23:41:14.46239	\N	590	\N	8
383	147	649	16898.53	2026-02-27 23:41:14.46239	\N	320	\N	8
384	362	730	33101.18	2026-02-27 23:41:14.46239	\N	540	\N	8
385	396	596	58350.92	2026-02-27 23:41:14.46239	\N	901	\N	8
386	343	871	89917.37	2026-02-27 23:41:14.46239	\N	107	\N	8
387	443	126	75174.99	2026-02-27 23:41:14.46239	\N	834	\N	8
388	799	318	10754.52	2026-02-27 23:41:14.46239	\N	777	\N	8
389	205	13	47549.39	2026-02-27 23:41:14.46239	\N	779	\N	8
390	649	414	49519.65	2026-02-27 23:41:14.46239	\N	806	\N	8
391	747	648	57270.77	2026-02-27 23:41:14.46239	\N	322	\N	8
392	900	643	68882.75	2026-02-27 23:41:14.46239	\N	437	\N	8
393	334	390	95620.79	2026-02-27 23:41:14.46239	\N	767	\N	8
394	349	226	50846.58	2026-02-27 23:41:14.46239	\N	323	\N	8
395	17	889	91676.24	2026-02-27 23:41:14.46239	\N	679	\N	8
396	655	390	75773.59	2026-02-27 23:41:14.46239	\N	15	\N	8
397	705	485	32694.97	2026-02-27 23:41:14.46239	\N	387	\N	8
398	709	216	89581.54	2026-02-27 23:41:14.46239	\N	149	\N	8
399	808	82	90643.32	2026-02-27 23:41:14.46239	\N	20	\N	8
400	702	66	47000.81	2026-02-27 23:41:14.46239	\N	925	\N	8
401	941	220	98558.97	2026-02-27 23:41:14.46239	\N	263	\N	8
402	638	330	78039.16	2026-02-27 23:41:14.46239	\N	815	\N	8
403	92	774	33169.36	2026-02-27 23:41:14.46239	\N	629	\N	8
404	555	515	29921.20	2026-02-27 23:41:14.46239	\N	364	\N	8
405	664	989	39341.67	2026-02-27 23:41:14.46239	\N	835	\N	8
406	183	221	37891.05	2026-02-27 23:41:14.46239	\N	518	\N	8
407	230	157	68394.79	2026-02-27 23:41:14.46239	\N	974	\N	8
408	911	776	24224.33	2026-02-27 23:41:14.46239	\N	912	\N	8
409	685	998	89954.45	2026-02-27 23:41:14.46239	\N	165	\N	8
410	432	229	7355.45	2026-02-27 23:41:14.46239	\N	859	\N	8
411	316	802	96733.68	2026-02-27 23:41:14.46239	\N	90	\N	8
412	631	881	5515.99	2026-02-27 23:41:14.46239	\N	429	\N	8
413	275	402	96941.50	2026-02-27 23:41:14.46239	\N	469	\N	8
414	657	514	34947.20	2026-02-27 23:41:14.46239	\N	698	\N	8
415	419	797	85185.50	2026-02-27 23:41:14.46239	\N	439	\N	8
416	499	4	49198.47	2026-02-27 23:41:14.46239	\N	829	\N	8
417	572	761	29132.60	2026-02-27 23:41:14.46239	\N	247	\N	8
418	260	238	62544.37	2026-02-27 23:41:14.46239	\N	205	\N	8
419	255	205	24798.07	2026-02-27 23:41:14.46239	\N	569	\N	8
420	952	553	96066.80	2026-02-27 23:41:14.46239	\N	379	\N	8
421	812	464	6689.55	2026-02-27 23:41:14.46239	\N	347	\N	8
422	88	646	18619.84	2026-02-27 23:41:14.46239	\N	279	\N	8
423	792	698	4751.66	2026-02-27 23:41:14.46239	\N	516	\N	8
424	356	168	7840.74	2026-02-27 23:41:14.46239	\N	708	\N	8
425	751	399	52118.76	2026-02-27 23:41:14.46239	\N	849	\N	8
426	725	832	4078.85	2026-02-27 23:41:14.46239	\N	790	\N	8
427	987	168	11291.57	2026-02-27 23:41:14.46239	\N	158	\N	8
428	975	532	63337.83	2026-02-27 23:41:14.46239	\N	218	\N	8
429	699	703	93774.21	2026-02-27 23:41:14.46239	\N	612	\N	8
430	515	596	29252.16	2026-02-27 23:41:14.46239	\N	396	\N	8
431	785	448	47780.56	2026-02-27 23:41:14.46239	\N	587	\N	8
432	632	263	4096.51	2026-02-27 23:41:14.46239	\N	341	\N	8
433	406	714	39077.21	2026-02-27 23:41:14.46239	\N	705	\N	8
434	731	688	58046.43	2026-02-27 23:41:14.46239	\N	89	\N	8
435	459	291	66396.47	2026-02-27 23:41:14.46239	\N	994	\N	8
436	570	484	23552.72	2026-02-27 23:41:14.46239	\N	647	\N	8
437	884	90	16859.19	2026-02-27 23:41:14.46239	\N	819	\N	8
438	183	198	96153.23	2026-02-27 23:41:14.46239	\N	509	\N	8
439	317	12	48055.84	2026-02-27 23:41:14.46239	\N	695	\N	8
440	594	803	58953.93	2026-02-27 23:41:14.46239	\N	366	\N	8
441	35	31	73729.53	2026-02-27 23:41:14.46239	\N	195	\N	8
442	187	959	51341.77	2026-02-27 23:41:14.46239	\N	396	\N	8
443	356	23	65956.89	2026-02-27 23:41:14.46239	\N	382	\N	8
444	891	617	11262.61	2026-02-27 23:41:14.46239	\N	955	\N	8
445	55	465	17271.83	2026-02-27 23:41:14.46239	\N	602	\N	8
446	674	579	91871.64	2026-02-27 23:41:14.46239	\N	378	\N	8
447	675	411	94679.93	2026-02-27 23:41:14.46239	\N	966	\N	8
448	811	687	96419.62	2026-02-27 23:41:14.46239	\N	910	\N	8
449	221	773	79018.68	2026-02-27 23:41:14.46239	\N	581	\N	8
450	963	740	2342.24	2026-02-27 23:41:14.46239	\N	100	\N	8
451	212	18	37813.62	2026-02-27 23:41:14.46239	\N	217	\N	8
452	247	125	18148.73	2026-02-27 23:41:14.46239	\N	513	\N	8
453	208	479	36398.81	2026-02-27 23:41:14.46239	\N	618	\N	8
454	1	746	61850.78	2026-02-27 23:41:14.46239	\N	184	\N	8
455	663	279	82675.25	2026-02-27 23:41:14.46239	\N	130	\N	8
456	918	823	2197.54	2026-02-27 23:41:14.46239	\N	211	\N	8
457	794	902	72502.70	2026-02-27 23:41:14.46239	\N	520	\N	8
458	329	558	96626.35	2026-02-27 23:41:14.46239	\N	827	\N	8
459	68	376	10729.22	2026-02-27 23:41:14.46239	\N	20	\N	8
460	163	63	49551.53	2026-02-27 23:41:14.46239	\N	408	\N	8
461	702	550	67774.09	2026-02-27 23:41:14.46239	\N	687	\N	8
462	865	440	18490.20	2026-02-27 23:41:14.46239	\N	822	\N	8
463	71	436	4924.96	2026-02-27 23:41:14.46239	\N	827	\N	8
464	152	65	56711.42	2026-02-27 23:41:14.46239	\N	693	\N	8
465	967	866	44034.53	2026-02-27 23:41:14.46239	\N	205	\N	8
466	478	103	37439.20	2026-02-27 23:41:14.46239	\N	497	\N	8
467	600	698	51317.56	2026-02-27 23:41:14.46239	\N	582	\N	8
468	66	398	15411.02	2026-02-27 23:41:14.46239	\N	592	\N	8
469	73	232	20518.59	2026-02-27 23:41:14.46239	\N	660	\N	8
470	631	296	3059.40	2026-02-27 23:41:14.46239	\N	361	\N	8
471	782	579	45410.55	2026-02-27 23:41:14.46239	\N	291	\N	8
472	845	905	70968.11	2026-02-27 23:41:14.46239	\N	481	\N	8
473	49	639	45865.99	2026-02-27 23:41:14.46239	\N	472	\N	8
474	400	849	38521.54	2026-02-27 23:41:14.46239	\N	815	\N	8
475	966	954	10933.95	2026-02-27 23:41:14.46239	\N	980	\N	8
476	256	481	28548.16	2026-02-27 23:41:14.46239	\N	829	\N	8
477	912	175	36423.16	2026-02-27 23:41:14.46239	\N	644	\N	8
478	603	767	2951.68	2026-02-27 23:41:14.46239	\N	498	\N	8
479	684	142	73471.80	2026-02-27 23:41:14.46239	\N	135	\N	8
480	804	326	81805.32	2026-02-27 23:41:14.46239	\N	137	\N	8
481	68	604	40942.81	2026-02-27 23:41:14.46239	\N	258	\N	8
482	767	229	58121.73	2026-02-27 23:41:14.46239	\N	350	\N	8
483	219	724	27000.36	2026-02-27 23:41:14.46239	\N	622	\N	8
484	957	954	28470.59	2026-02-27 23:41:14.46239	\N	407	\N	8
485	280	415	50805.99	2026-02-27 23:41:14.46239	\N	751	\N	8
486	159	249	17086.62	2026-02-27 23:41:14.46239	\N	14	\N	8
487	266	418	41152.24	2026-02-27 23:41:14.46239	\N	226	\N	8
488	849	583	48635.63	2026-02-27 23:41:14.46239	\N	452	\N	8
489	585	887	33696.82	2026-02-27 23:41:14.46239	\N	628	\N	8
490	755	871	75325.20	2026-02-27 23:41:14.46239	\N	425	\N	8
491	556	924	21983.31	2026-02-27 23:41:14.46239	\N	944	\N	8
492	933	185	64770.09	2026-02-27 23:41:14.46239	\N	850	\N	8
493	772	666	59497.93	2026-02-27 23:41:14.46239	\N	751	\N	8
494	119	554	13874.20	2026-02-27 23:41:14.46239	\N	813	\N	8
495	80	778	19435.32	2026-02-27 23:41:14.46239	\N	436	\N	8
496	803	557	22485.82	2026-02-27 23:41:14.46239	\N	772	\N	8
497	445	964	60568.30	2026-02-27 23:41:14.46239	\N	520	\N	8
498	784	52	58934.93	2026-02-27 23:41:14.46239	\N	628	\N	8
499	440	661	8820.27	2026-02-27 23:41:14.46239	\N	446	\N	8
500	677	57	98303.53	2026-02-27 23:41:14.46239	\N	504	\N	8
501	651	837	74871.90	2026-02-27 23:41:14.46239	\N	580	\N	8
502	268	636	49214.95	2026-02-27 23:41:14.46239	\N	213	\N	8
503	652	274	40510.16	2026-02-27 23:41:14.46239	\N	731	\N	8
504	76	474	78541.99	2026-02-27 23:41:14.46239	\N	634	\N	8
505	922	104	92844.25	2026-02-27 23:41:14.46239	\N	335	\N	8
506	245	405	99294.03	2026-02-27 23:41:14.46239	\N	288	\N	8
507	486	25	72412.18	2026-02-27 23:41:14.46239	\N	43	\N	8
508	785	871	48068.14	2026-02-27 23:41:14.46239	\N	220	\N	8
509	840	906	80171.31	2026-02-27 23:41:14.46239	\N	248	\N	8
510	901	203	39125.49	2026-02-27 23:41:14.46239	\N	643	\N	8
511	434	982	97424.31	2026-02-27 23:41:14.46239	\N	221	\N	8
512	828	984	60689.71	2026-02-27 23:41:14.46239	\N	419	\N	8
513	946	576	21803.76	2026-02-27 23:41:14.46239	\N	203	\N	8
514	587	530	27779.73	2026-02-27 23:41:14.46239	\N	563	\N	8
515	436	587	59615.18	2026-02-27 23:41:14.46239	\N	781	\N	8
516	47	801	89059.13	2026-02-27 23:41:14.46239	\N	832	\N	8
517	682	732	23618.77	2026-02-27 23:41:14.46239	\N	892	\N	8
518	50	700	61616.65	2026-02-27 23:41:14.46239	\N	305	\N	8
519	663	14	24700.60	2026-02-27 23:41:14.46239	\N	280	\N	8
520	463	640	46181.46	2026-02-27 23:41:14.46239	\N	860	\N	8
521	308	97	58783.90	2026-02-27 23:41:14.46239	\N	138	\N	8
522	158	544	48203.94	2026-02-27 23:41:14.46239	\N	851	\N	8
523	507	25	56983.13	2026-02-27 23:41:14.46239	\N	673	\N	8
524	120	610	17174.42	2026-02-27 23:41:14.46239	\N	656	\N	8
525	914	352	45138.66	2026-02-27 23:41:14.46239	\N	411	\N	8
526	116	692	42769.58	2026-02-27 23:41:14.46239	\N	771	\N	8
527	119	599	63904.83	2026-02-27 23:41:14.46239	\N	333	\N	8
528	837	883	60283.00	2026-02-27 23:41:14.46239	\N	268	\N	8
529	718	532	70898.47	2026-02-27 23:41:14.46239	\N	441	\N	8
530	753	541	80034.38	2026-02-27 23:41:14.46239	\N	933	\N	8
531	73	777	55822.67	2026-02-27 23:41:14.46239	\N	849	\N	8
532	984	981	77195.39	2026-02-27 23:41:14.46239	\N	670	\N	8
533	90	342	4319.64	2026-02-27 23:41:14.46239	\N	915	\N	8
534	230	796	96718.26	2026-02-27 23:41:14.46239	\N	248	\N	8
535	618	402	22181.30	2026-02-27 23:41:14.46239	\N	544	\N	8
536	178	161	63358.73	2026-02-27 23:41:14.46239	\N	916	\N	8
537	404	792	50004.71	2026-02-27 23:41:14.46239	\N	42	\N	8
538	304	350	73986.44	2026-02-27 23:41:14.46239	\N	959	\N	8
539	636	79	95147.83	2026-02-27 23:41:14.46239	\N	31	\N	8
540	364	692	93982.14	2026-02-27 23:41:14.46239	\N	191	\N	8
541	282	669	53658.71	2026-02-27 23:41:14.46239	\N	421	\N	8
542	498	334	81713.32	2026-02-27 23:41:14.46239	\N	814	\N	8
543	25	541	43042.46	2026-02-27 23:41:14.46239	\N	367	\N	8
544	888	617	98759.68	2026-02-27 23:41:14.46239	\N	53	\N	8
545	966	752	402.15	2026-02-27 23:41:14.46239	\N	463	\N	8
546	504	723	32503.68	2026-02-27 23:41:14.46239	\N	842	\N	8
547	634	929	6354.66	2026-02-27 23:41:14.46239	\N	316	\N	8
548	882	474	79140.14	2026-02-27 23:41:14.46239	\N	243	\N	8
549	256	909	57025.73	2026-02-27 23:41:14.46239	\N	958	\N	8
550	467	424	14274.48	2026-02-27 23:41:14.46239	\N	747	\N	8
551	300	855	33905.24	2026-02-27 23:41:14.46239	\N	574	\N	8
552	861	864	87538.24	2026-02-27 23:41:14.46239	\N	648	\N	8
553	341	507	81536.45	2026-02-27 23:41:14.46239	\N	177	\N	8
554	754	162	20189.26	2026-02-27 23:41:14.46239	\N	91	\N	8
555	370	92	59090.50	2026-02-27 23:41:14.46239	\N	170	\N	8
556	365	386	67827.16	2026-02-27 23:41:14.46239	\N	190	\N	8
557	398	850	19676.94	2026-02-27 23:41:14.46239	\N	710	\N	8
558	418	792	48379.94	2026-02-27 23:41:14.46239	\N	212	\N	8
559	536	748	35809.78	2026-02-27 23:41:14.46239	\N	204	\N	8
560	97	979	99303.93	2026-02-27 23:41:14.46239	\N	91	\N	8
561	204	893	50105.78	2026-02-27 23:41:14.46239	\N	55	\N	8
562	732	613	34618.67	2026-02-27 23:41:14.46239	\N	922	\N	8
563	673	961	56717.22	2026-02-27 23:41:14.46239	\N	398	\N	8
564	190	678	28956.34	2026-02-27 23:41:14.46239	\N	504	\N	8
565	830	103	83873.01	2026-02-27 23:41:14.46239	\N	537	\N	8
566	729	828	80043.28	2026-02-27 23:41:14.46239	\N	896	\N	8
567	787	329	67977.06	2026-02-27 23:41:14.46239	\N	212	\N	8
568	266	493	30992.86	2026-02-27 23:41:14.46239	\N	398	\N	8
569	312	937	66298.21	2026-02-27 23:41:14.46239	\N	153	\N	8
570	873	40	93161.51	2026-02-27 23:41:14.46239	\N	219	\N	8
571	896	394	6020.16	2026-02-27 23:41:14.46239	\N	970	\N	8
572	234	576	97902.94	2026-02-27 23:41:14.46239	\N	939	\N	8
573	97	478	47579.82	2026-02-27 23:41:14.46239	\N	642	\N	8
574	421	139	12661.43	2026-02-27 23:41:14.46239	\N	319	\N	8
575	884	534	84225.53	2026-02-27 23:41:14.46239	\N	116	\N	8
576	686	752	41929.14	2026-02-27 23:41:14.46239	\N	616	\N	8
577	366	342	32588.24	2026-02-27 23:41:14.46239	\N	887	\N	8
578	676	327	94826.88	2026-02-27 23:41:14.46239	\N	632	\N	8
579	597	556	53893.23	2026-02-27 23:41:14.46239	\N	354	\N	8
580	98	642	80668.72	2026-02-27 23:41:14.46239	\N	857	\N	8
581	172	304	21977.46	2026-02-27 23:41:14.46239	\N	725	\N	8
582	793	810	33161.22	2026-02-27 23:41:14.46239	\N	130	\N	8
583	444	240	9937.29	2026-02-27 23:41:14.46239	\N	402	\N	8
584	460	65	21704.31	2026-02-27 23:41:14.46239	\N	742	\N	8
585	774	442	28303.19	2026-02-27 23:41:14.46239	\N	104	\N	8
586	625	10	13766.32	2026-02-27 23:41:14.46239	\N	249	\N	8
587	843	686	93599.39	2026-02-27 23:41:14.46239	\N	57	\N	8
588	427	839	65932.02	2026-02-27 23:41:14.46239	\N	149	\N	8
589	18	955	1615.24	2026-02-27 23:41:14.46239	\N	962	\N	8
590	917	922	79140.73	2026-02-27 23:41:14.46239	\N	915	\N	8
591	708	414	9865.11	2026-02-27 23:41:14.46239	\N	858	\N	8
592	855	229	98322.31	2026-02-27 23:41:14.46239	\N	912	\N	8
593	871	806	26060.41	2026-02-27 23:41:14.46239	\N	799	\N	8
594	54	757	62342.23	2026-02-27 23:41:14.46239	\N	117	\N	8
595	50	865	78334.85	2026-02-27 23:41:14.46239	\N	370	\N	8
596	425	321	42997.49	2026-02-27 23:41:14.46239	\N	522	\N	8
597	373	508	46941.31	2026-02-27 23:41:14.46239	\N	173	\N	8
598	596	387	49190.34	2026-02-27 23:41:14.46239	\N	67	\N	8
599	774	686	2728.75	2026-02-27 23:41:14.46239	\N	676	\N	8
600	272	800	53727.07	2026-02-27 23:41:14.46239	\N	154	\N	8
601	328	690	12947.41	2026-02-27 23:41:14.46239	\N	542	\N	8
602	490	640	82891.85	2026-02-27 23:41:14.46239	\N	797	\N	8
603	739	330	38169.50	2026-02-27 23:41:14.46239	\N	231	\N	8
604	595	421	75770.76	2026-02-27 23:41:14.46239	\N	267	\N	8
605	12	497	65028.62	2026-02-27 23:41:14.46239	\N	423	\N	8
606	293	782	8157.49	2026-02-27 23:41:14.46239	\N	711	\N	8
607	652	860	97719.34	2026-02-27 23:41:14.46239	\N	426	\N	8
608	370	731	4750.86	2026-02-27 23:41:14.46239	\N	426	\N	8
609	941	371	13702.81	2026-02-27 23:41:14.46239	\N	473	\N	8
610	665	835	73993.44	2026-02-27 23:41:14.46239	\N	911	\N	8
611	707	115	92668.19	2026-02-27 23:41:14.46239	\N	713	\N	8
612	409	276	55225.88	2026-02-27 23:41:14.46239	\N	314	\N	8
613	527	258	76551.83	2026-02-27 23:41:14.46239	\N	439	\N	8
614	679	500	49291.44	2026-02-27 23:41:14.46239	\N	533	\N	8
615	796	903	59287.53	2026-02-27 23:41:14.46239	\N	491	\N	8
616	979	65	50352.46	2026-02-27 23:41:14.46239	\N	115	\N	8
617	752	776	93862.99	2026-02-27 23:41:14.46239	\N	850	\N	8
618	868	195	72761.54	2026-02-27 23:41:14.46239	\N	851	\N	8
619	255	14	98569.81	2026-02-27 23:41:14.46239	\N	10	\N	8
620	226	514	99073.43	2026-02-27 23:41:14.46239	\N	507	\N	8
621	538	467	65593.06	2026-02-27 23:41:14.46239	\N	368	\N	8
622	406	202	31584.83	2026-02-27 23:41:14.46239	\N	909	\N	8
623	139	437	45201.53	2026-02-27 23:41:14.46239	\N	851	\N	8
624	622	260	53424.22	2026-02-27 23:41:14.46239	\N	934	\N	8
625	115	625	53076.88	2026-02-27 23:41:14.46239	\N	22	\N	8
626	763	855	63409.20	2026-02-27 23:41:14.46239	\N	557	\N	8
627	663	394	2463.43	2026-02-27 23:41:14.46239	\N	297	\N	8
628	720	339	30554.38	2026-02-27 23:41:14.46239	\N	623	\N	8
629	256	356	57118.51	2026-02-27 23:41:14.46239	\N	748	\N	8
630	529	246	29500.65	2026-02-27 23:41:14.46239	\N	233	\N	8
631	722	330	58470.58	2026-02-27 23:41:14.46239	\N	251	\N	8
632	339	133	61621.07	2026-02-27 23:41:14.46239	\N	317	\N	8
633	115	637	36100.07	2026-02-27 23:41:14.46239	\N	464	\N	8
634	926	119	25454.16	2026-02-27 23:41:14.46239	\N	375	\N	8
635	67	464	48773.10	2026-02-27 23:41:14.46239	\N	113	\N	8
636	481	36	43198.27	2026-02-27 23:41:14.46239	\N	363	\N	8
637	13	693	27843.43	2026-02-27 23:41:14.46239	\N	629	\N	8
638	916	980	72590.89	2026-02-27 23:41:14.46239	\N	739	\N	8
639	679	435	21408.92	2026-02-27 23:41:14.46239	\N	546	\N	8
640	250	999	19189.58	2026-02-27 23:41:14.46239	\N	579	\N	8
641	905	307	17239.85	2026-02-27 23:41:14.46239	\N	259	\N	8
642	281	955	85036.13	2026-02-27 23:41:14.46239	\N	769	\N	8
643	99	563	93982.84	2026-02-27 23:41:14.46239	\N	741	\N	8
644	292	665	94559.47	2026-02-27 23:41:14.46239	\N	216	\N	8
645	203	27	87444.83	2026-02-27 23:41:14.46239	\N	121	\N	8
646	350	209	78820.56	2026-02-27 23:41:14.46239	\N	654	\N	8
647	103	749	47755.84	2026-02-27 23:41:14.46239	\N	168	\N	8
648	754	383	99259.27	2026-02-27 23:41:14.46239	\N	643	\N	8
649	874	228	82818.06	2026-02-27 23:41:14.46239	\N	89	\N	8
650	594	996	60167.11	2026-02-27 23:41:14.46239	\N	153	\N	8
651	995	319	26081.57	2026-02-27 23:41:14.46239	\N	153	\N	8
652	552	858	32548.41	2026-02-27 23:41:14.46239	\N	28	\N	8
653	191	942	1661.67	2026-02-27 23:41:14.46239	\N	614	\N	8
654	998	720	35535.86	2026-02-27 23:41:14.46239	\N	281	\N	8
655	857	78	22855.73	2026-02-27 23:41:14.46239	\N	99	\N	8
656	764	725	99687.72	2026-02-27 23:41:14.46239	\N	622	\N	8
657	963	8	19531.59	2026-02-27 23:41:14.46239	\N	241	\N	8
658	999	593	1279.96	2026-02-27 23:41:14.46239	\N	508	\N	8
659	740	829	11776.45	2026-02-27 23:41:14.46239	\N	207	\N	8
660	926	125	33164.84	2026-02-27 23:41:14.46239	\N	980	\N	8
661	795	906	70773.32	2026-02-27 23:41:14.46239	\N	495	\N	8
662	299	552	27006.38	2026-02-27 23:41:14.46239	\N	805	\N	8
663	511	193	62404.55	2026-02-27 23:41:14.46239	\N	190	\N	8
664	904	408	94071.37	2026-02-27 23:41:14.46239	\N	647	\N	8
665	119	872	56423.42	2026-02-27 23:41:14.46239	\N	257	\N	8
666	296	589	21913.87	2026-02-27 23:41:14.46239	\N	634	\N	8
667	582	614	27156.95	2026-02-27 23:41:14.46239	\N	110	\N	8
668	697	894	2182.31	2026-02-27 23:41:14.46239	\N	922	\N	8
669	58	65	14561.37	2026-02-27 23:41:14.46239	\N	357	\N	8
670	801	682	71103.78	2026-02-27 23:41:14.46239	\N	707	\N	8
671	328	410	45577.68	2026-02-27 23:41:14.46239	\N	300	\N	8
672	241	202	98061.84	2026-02-27 23:41:14.46239	\N	937	\N	8
673	864	687	58091.35	2026-02-27 23:41:14.46239	\N	646	\N	8
674	712	618	27193.31	2026-02-27 23:41:14.46239	\N	827	\N	8
675	728	47	62195.09	2026-02-27 23:41:14.46239	\N	661	\N	8
676	320	82	62107.97	2026-02-27 23:41:14.46239	\N	507	\N	8
677	961	246	60187.94	2026-02-27 23:41:14.46239	\N	77	\N	8
678	32	495	98141.44	2026-02-27 23:41:14.46239	\N	510	\N	8
679	278	672	43184.53	2026-02-27 23:41:14.46239	\N	907	\N	8
680	886	958	84864.22	2026-02-27 23:41:14.46239	\N	238	\N	8
681	641	404	89943.30	2026-02-27 23:41:14.46239	\N	918	\N	8
682	445	959	52252.69	2026-02-27 23:41:14.46239	\N	157	\N	8
683	587	97	49601.97	2026-02-27 23:41:14.46239	\N	770	\N	8
684	207	489	99524.85	2026-02-27 23:41:14.46239	\N	765	\N	8
685	912	247	83499.48	2026-02-27 23:41:14.46239	\N	595	\N	8
686	599	974	63859.01	2026-02-27 23:41:14.46239	\N	290	\N	8
687	691	650	15833.29	2026-02-27 23:41:14.46239	\N	719	\N	8
688	478	394	39047.39	2026-02-27 23:41:14.46239	\N	421	\N	8
689	638	354	957.91	2026-02-27 23:41:14.46239	\N	245	\N	8
690	992	727	72216.67	2026-02-27 23:41:14.46239	\N	794	\N	8
691	65	477	30633.81	2026-02-27 23:41:14.46239	\N	639	\N	8
692	764	28	8848.39	2026-02-27 23:41:14.46239	\N	494	\N	8
693	698	267	36277.53	2026-02-27 23:41:14.46239	\N	608	\N	8
694	634	113	32536.73	2026-02-27 23:41:14.46239	\N	493	\N	8
695	661	384	85250.31	2026-02-27 23:41:14.46239	\N	536	\N	8
696	619	235	25563.52	2026-02-27 23:41:14.46239	\N	797	\N	8
697	502	757	39347.05	2026-02-27 23:41:14.46239	\N	885	\N	8
698	403	470	46674.92	2026-02-27 23:41:14.46239	\N	778	\N	8
699	278	98	78224.71	2026-02-27 23:41:14.46239	\N	785	\N	8
700	974	554	56957.83	2026-02-27 23:41:14.46239	\N	953	\N	8
701	566	929	98241.62	2026-02-27 23:41:14.46239	\N	388	\N	8
702	96	12	3958.68	2026-02-27 23:41:14.46239	\N	486	\N	8
703	470	368	21193.98	2026-02-27 23:41:14.46239	\N	293	\N	8
704	476	671	448.67	2026-02-27 23:41:14.46239	\N	509	\N	8
705	42	719	52301.25	2026-02-27 23:41:14.46239	\N	393	\N	8
706	16	215	22350.77	2026-02-27 23:41:14.46239	\N	773	\N	8
707	841	648	95090.60	2026-02-27 23:41:14.46239	\N	794	\N	8
708	77	595	43988.73	2026-02-27 23:41:14.46239	\N	273	\N	8
709	988	42	7046.20	2026-02-27 23:41:14.46239	\N	87	\N	8
710	384	111	53926.12	2026-02-27 23:41:14.46239	\N	605	\N	8
711	292	372	14388.93	2026-02-27 23:41:14.46239	\N	405	\N	8
712	809	476	44204.15	2026-02-27 23:41:14.46239	\N	884	\N	8
713	738	991	16169.04	2026-02-27 23:41:14.46239	\N	302	\N	8
714	512	912	30489.09	2026-02-27 23:41:14.46239	\N	986	\N	8
715	781	941	39690.98	2026-02-27 23:41:14.46239	\N	579	\N	8
716	296	985	73386.48	2026-02-27 23:41:14.46239	\N	640	\N	8
717	598	678	55538.47	2026-02-27 23:41:14.46239	\N	200	\N	8
718	824	590	59512.78	2026-02-27 23:41:14.46239	\N	977	\N	8
719	613	369	61164.09	2026-02-27 23:41:14.46239	\N	699	\N	8
720	648	48	7936.64	2026-02-27 23:41:14.46239	\N	883	\N	8
721	675	423	98830.62	2026-02-27 23:41:14.46239	\N	514	\N	8
722	92	492	8298.85	2026-02-27 23:41:14.46239	\N	751	\N	8
723	259	337	75254.95	2026-02-27 23:41:14.46239	\N	115	\N	8
724	301	363	25800.44	2026-02-27 23:41:14.46239	\N	172	\N	8
725	978	157	40253.40	2026-02-27 23:41:14.46239	\N	207	\N	8
726	958	642	54627.43	2026-02-27 23:41:14.46239	\N	614	\N	8
727	587	637	40398.40	2026-02-27 23:41:14.46239	\N	861	\N	8
728	284	110	90269.48	2026-02-27 23:41:14.46239	\N	54	\N	8
729	58	803	11690.98	2026-02-27 23:41:14.46239	\N	405	\N	8
730	346	614	31392.58	2026-02-27 23:41:14.46239	\N	971	\N	8
731	58	700	94473.11	2026-02-27 23:41:14.46239	\N	692	\N	8
732	227	944	73620.88	2026-02-27 23:41:14.46239	\N	980	\N	8
733	93	313	16412.18	2026-02-27 23:41:14.46239	\N	75	\N	8
734	245	536	98122.18	2026-02-27 23:41:14.46239	\N	483	\N	8
735	914	422	20636.91	2026-02-27 23:41:14.46239	\N	651	\N	8
736	719	962	76886.99	2026-02-27 23:41:14.46239	\N	392	\N	8
737	818	735	42953.05	2026-02-27 23:41:14.46239	\N	752	\N	8
738	694	561	56062.03	2026-02-27 23:41:14.46239	\N	123	\N	8
739	798	682	92348.83	2026-02-27 23:41:14.46239	\N	540	\N	8
740	198	519	23996.33	2026-02-27 23:41:14.46239	\N	630	\N	8
741	211	941	75484.33	2026-02-27 23:41:14.46239	\N	805	\N	8
742	245	721	82072.99	2026-02-27 23:41:14.46239	\N	271	\N	8
743	263	983	60574.25	2026-02-27 23:41:14.46239	\N	564	\N	8
744	909	257	1522.36	2026-02-27 23:41:14.46239	\N	902	\N	8
745	507	491	88958.30	2026-02-27 23:41:14.46239	\N	731	\N	8
746	125	798	84313.76	2026-02-27 23:41:14.46239	\N	547	\N	8
747	457	577	8488.46	2026-02-27 23:41:14.46239	\N	685	\N	8
748	718	921	48866.98	2026-02-27 23:41:14.46239	\N	811	\N	8
749	50	287	6460.34	2026-02-27 23:41:14.46239	\N	170	\N	8
750	590	40	11305.30	2026-02-27 23:41:14.46239	\N	184	\N	8
751	677	204	62862.15	2026-02-27 23:41:14.46239	\N	935	\N	8
752	107	855	70355.62	2026-02-27 23:41:14.46239	\N	32	\N	8
753	688	851	94842.12	2026-02-27 23:41:14.46239	\N	251	\N	8
754	979	340	4728.95	2026-02-27 23:41:14.46239	\N	185	\N	8
755	750	254	65293.56	2026-02-27 23:41:14.46239	\N	399	\N	8
756	479	338	98795.96	2026-02-27 23:41:14.46239	\N	50	\N	8
757	502	117	48678.45	2026-02-27 23:41:14.46239	\N	534	\N	8
758	193	907	87413.63	2026-02-27 23:41:14.46239	\N	112	\N	8
759	66	167	42161.38	2026-02-27 23:41:14.46239	\N	131	\N	8
760	7	32	42854.68	2026-02-27 23:41:14.46239	\N	258	\N	8
761	209	898	97831.39	2026-02-27 23:41:14.46239	\N	677	\N	8
762	915	999	96454.35	2026-02-27 23:41:14.46239	\N	6	\N	8
763	15	691	88839.85	2026-02-27 23:41:14.46239	\N	358	\N	8
764	356	848	2185.61	2026-02-27 23:41:14.46239	\N	602	\N	8
765	441	648	17677.72	2026-02-27 23:41:14.46239	\N	777	\N	8
766	872	877	66958.60	2026-02-27 23:41:14.46239	\N	959	\N	8
767	632	792	5522.43	2026-02-27 23:41:14.46239	\N	866	\N	8
768	825	872	44965.14	2026-02-27 23:41:14.46239	\N	893	\N	8
769	242	972	32687.73	2026-02-27 23:41:14.46239	\N	323	\N	8
770	206	533	90632.66	2026-02-27 23:41:14.46239	\N	966	\N	8
771	478	880	63776.00	2026-02-27 23:41:14.46239	\N	236	\N	8
772	554	80	53272.36	2026-02-27 23:41:14.46239	\N	972	\N	8
773	731	792	48003.21	2026-02-27 23:41:14.46239	\N	677	\N	8
774	833	326	1952.88	2026-02-27 23:41:14.46239	\N	792	\N	8
775	245	934	55753.34	2026-02-27 23:41:14.46239	\N	521	\N	8
776	261	3	71575.04	2026-02-27 23:41:14.46239	\N	571	\N	8
777	230	873	12909.93	2026-02-27 23:41:14.46239	\N	159	\N	8
778	271	928	60189.35	2026-02-27 23:41:14.46239	\N	457	\N	8
779	529	472	63074.47	2026-02-27 23:41:14.46239	\N	75	\N	8
780	687	704	39145.85	2026-02-27 23:41:14.46239	\N	306	\N	8
781	737	647	73255.49	2026-02-27 23:41:14.46239	\N	820	\N	8
782	510	421	50913.79	2026-02-27 23:41:14.46239	\N	370	\N	8
783	716	373	16503.06	2026-02-27 23:41:14.46239	\N	910	\N	8
784	974	671	21452.15	2026-02-27 23:41:14.46239	\N	788	\N	8
785	80	561	34822.48	2026-02-27 23:41:14.46239	\N	539	\N	8
786	609	466	90320.09	2026-02-27 23:41:14.46239	\N	286	\N	8
787	122	132	46795.16	2026-02-27 23:41:14.46239	\N	464	\N	8
788	56	905	98786.12	2026-02-27 23:41:14.46239	\N	201	\N	8
789	838	291	91022.46	2026-02-27 23:41:14.46239	\N	411	\N	8
790	130	63	32200.91	2026-02-27 23:41:14.46239	\N	684	\N	8
791	587	23	24985.87	2026-02-27 23:41:14.46239	\N	419	\N	8
792	382	601	87247.96	2026-02-27 23:41:14.46239	\N	213	\N	8
793	313	436	64154.57	2026-02-27 23:41:14.46239	\N	773	\N	8
794	651	833	15616.92	2026-02-27 23:41:14.46239	\N	682	\N	8
795	649	787	85987.14	2026-02-27 23:41:14.46239	\N	618	\N	8
796	352	571	95116.84	2026-02-27 23:41:14.46239	\N	821	\N	8
797	734	231	64682.89	2026-02-27 23:41:14.46239	\N	326	\N	8
798	956	562	93520.01	2026-02-27 23:41:14.46239	\N	967	\N	8
799	336	913	90081.17	2026-02-27 23:41:14.46239	\N	405	\N	8
800	693	753	39067.38	2026-02-27 23:41:14.46239	\N	671	\N	8
801	711	23	26022.63	2026-02-27 23:41:14.46239	\N	358	\N	8
802	699	717	4419.97	2026-02-27 23:41:14.46239	\N	668	\N	8
803	386	843	93088.00	2026-02-27 23:41:14.46239	\N	928	\N	8
804	477	621	67498.40	2026-02-27 23:41:14.46239	\N	642	\N	8
805	23	167	65033.37	2026-02-27 23:41:14.46239	\N	863	\N	8
806	628	33	15895.02	2026-02-27 23:41:14.46239	\N	416	\N	8
807	282	79	97969.71	2026-02-27 23:41:14.46239	\N	587	\N	8
808	595	697	36431.47	2026-02-27 23:41:14.46239	\N	20	\N	8
809	482	790	18967.74	2026-02-27 23:41:14.46239	\N	673	\N	8
810	659	659	3612.46	2026-02-27 23:41:14.46239	\N	249	\N	8
811	247	913	74081.85	2026-02-27 23:41:14.46239	\N	387	\N	8
812	482	636	64004.76	2026-02-27 23:41:14.46239	\N	466	\N	8
813	837	610	78368.88	2026-02-27 23:41:14.46239	\N	496	\N	8
814	753	524	47525.04	2026-02-27 23:41:14.46239	\N	322	\N	8
815	74	940	9500.15	2026-02-27 23:41:14.46239	\N	330	\N	8
816	436	806	41778.64	2026-02-27 23:41:14.46239	\N	909	\N	8
817	200	63	5900.31	2026-02-27 23:41:14.46239	\N	74	\N	8
818	279	601	51087.84	2026-02-27 23:41:14.46239	\N	545	\N	8
819	597	79	27288.21	2026-02-27 23:41:14.46239	\N	284	\N	8
820	963	852	25475.12	2026-02-27 23:41:14.46239	\N	328	\N	8
821	728	126	85715.42	2026-02-27 23:41:14.46239	\N	159	\N	8
822	693	924	70878.24	2026-02-27 23:41:14.46239	\N	591	\N	8
823	388	367	71897.97	2026-02-27 23:41:14.46239	\N	44	\N	8
824	456	786	43318.87	2026-02-27 23:41:14.46239	\N	850	\N	8
825	361	56	33761.99	2026-02-27 23:41:14.46239	\N	898	\N	8
826	800	555	84026.30	2026-02-27 23:41:14.46239	\N	859	\N	8
827	647	305	3745.70	2026-02-27 23:41:14.46239	\N	6	\N	8
828	577	286	30301.35	2026-02-27 23:41:14.46239	\N	578	\N	8
829	278	438	69507.85	2026-02-27 23:41:14.46239	\N	776	\N	8
830	623	140	127.10	2026-02-27 23:41:14.46239	\N	856	\N	8
831	777	661	27036.26	2026-02-27 23:41:14.46239	\N	817	\N	8
832	498	557	61927.14	2026-02-27 23:41:14.46239	\N	599	\N	8
833	886	513	17549.06	2026-02-27 23:41:14.46239	\N	137	\N	8
834	848	525	81713.50	2026-02-27 23:41:14.46239	\N	445	\N	8
835	884	850	30220.31	2026-02-27 23:41:14.46239	\N	807	\N	8
836	24	997	62203.72	2026-02-27 23:41:14.46239	\N	936	\N	8
837	124	193	74927.19	2026-02-27 23:41:14.46239	\N	683	\N	8
838	826	530	58573.59	2026-02-27 23:41:14.46239	\N	814	\N	8
839	955	639	17068.96	2026-02-27 23:41:14.46239	\N	768	\N	8
840	300	515	99914.71	2026-02-27 23:41:14.46239	\N	81	\N	8
841	713	811	68456.40	2026-02-27 23:41:14.46239	\N	137	\N	8
842	434	901	13772.42	2026-02-27 23:41:14.46239	\N	609	\N	8
843	134	285	36657.52	2026-02-27 23:41:14.46239	\N	837	\N	8
844	505	184	51030.13	2026-02-27 23:41:14.46239	\N	426	\N	8
845	704	243	53620.72	2026-02-27 23:41:14.46239	\N	151	\N	8
846	492	575	7107.11	2026-02-27 23:41:14.46239	\N	776	\N	8
847	728	16	30164.85	2026-02-27 23:41:14.46239	\N	878	\N	8
848	307	262	55276.49	2026-02-27 23:41:14.46239	\N	986	\N	8
849	692	27	33581.57	2026-02-27 23:41:14.46239	\N	199	\N	8
850	54	151	11929.34	2026-02-27 23:41:14.46239	\N	480	\N	8
851	112	124	79842.35	2026-02-27 23:41:14.46239	\N	422	\N	8
852	566	688	51082.87	2026-02-27 23:41:14.46239	\N	615	\N	8
853	468	730	22301.58	2026-02-27 23:41:14.46239	\N	42	\N	8
854	320	742	64853.24	2026-02-27 23:41:14.46239	\N	609	\N	8
855	857	486	93784.74	2026-02-27 23:41:14.46239	\N	808	\N	8
856	641	558	37146.27	2026-02-27 23:41:14.46239	\N	379	\N	8
857	97	19	60219.53	2026-02-27 23:41:14.46239	\N	496	\N	8
858	762	551	33217.83	2026-02-27 23:41:14.46239	\N	719	\N	8
859	584	864	3425.75	2026-02-27 23:41:14.46239	\N	800	\N	8
860	385	95	77848.59	2026-02-27 23:41:14.46239	\N	961	\N	8
861	309	244	3828.78	2026-02-27 23:41:14.46239	\N	574	\N	8
862	586	829	52849.02	2026-02-27 23:41:14.46239	\N	826	\N	8
863	871	979	83660.22	2026-02-27 23:41:14.46239	\N	505	\N	8
864	842	382	75525.60	2026-02-27 23:41:14.46239	\N	138	\N	8
865	933	81	89152.10	2026-02-27 23:41:14.46239	\N	428	\N	8
866	892	769	38954.95	2026-02-27 23:41:14.46239	\N	380	\N	8
867	710	638	81504.81	2026-02-27 23:41:14.46239	\N	744	\N	8
868	333	966	85727.49	2026-02-27 23:41:14.46239	\N	90	\N	8
869	132	932	86559.44	2026-02-27 23:41:14.46239	\N	381	\N	8
870	846	236	49350.50	2026-02-27 23:41:14.46239	\N	369	\N	8
871	651	388	15386.42	2026-02-27 23:41:14.46239	\N	459	\N	8
872	926	201	75578.10	2026-02-27 23:41:14.46239	\N	433	\N	8
873	748	953	16678.95	2026-02-27 23:41:14.46239	\N	339	\N	8
874	713	651	5060.16	2026-02-27 23:41:14.46239	\N	878	\N	8
875	689	926	73102.79	2026-02-27 23:41:14.46239	\N	162	\N	8
876	374	330	61163.30	2026-02-27 23:41:14.46239	\N	843	\N	8
877	696	89	9374.48	2026-02-27 23:41:14.46239	\N	146	\N	8
878	170	412	9605.15	2026-02-27 23:41:14.46239	\N	129	\N	8
879	137	29	11947.19	2026-02-27 23:41:14.46239	\N	90	\N	8
880	536	133	78655.25	2026-02-27 23:41:14.46239	\N	825	\N	8
881	984	629	80797.36	2026-02-27 23:41:14.46239	\N	71	\N	8
882	619	700	37166.30	2026-02-27 23:41:14.46239	\N	625	\N	8
883	773	52	54588.97	2026-02-27 23:41:14.46239	\N	652	\N	8
884	119	26	17794.05	2026-02-27 23:41:14.46239	\N	727	\N	8
885	267	40	87105.86	2026-02-27 23:41:14.46239	\N	736	\N	8
886	778	288	50475.81	2026-02-27 23:41:14.46239	\N	30	\N	8
887	40	680	62129.53	2026-02-27 23:41:14.46239	\N	759	\N	8
888	3	623	97129.61	2026-02-27 23:41:14.46239	\N	18	\N	8
889	167	53	57214.36	2026-02-27 23:41:14.46239	\N	320	\N	8
890	644	147	37392.73	2026-02-27 23:41:14.46239	\N	581	\N	8
891	434	828	65152.09	2026-02-27 23:41:14.46239	\N	523	\N	8
892	232	329	65964.78	2026-02-27 23:41:14.46239	\N	409	\N	8
893	544	252	88817.33	2026-02-27 23:41:14.46239	\N	1000	\N	8
894	4	485	55676.58	2026-02-27 23:41:14.46239	\N	858	\N	8
895	403	565	10894.42	2026-02-27 23:41:14.46239	\N	120	\N	8
896	395	818	39623.06	2026-02-27 23:41:14.46239	\N	437	\N	8
897	903	946	18902.87	2026-02-27 23:41:14.46239	\N	122	\N	8
898	572	24	84968.98	2026-02-27 23:41:14.46239	\N	725	\N	8
899	899	720	44058.29	2026-02-27 23:41:14.46239	\N	962	\N	8
900	640	44	77014.26	2026-02-27 23:41:14.46239	\N	496	\N	8
901	30	202	25088.52	2026-02-27 23:41:14.46239	\N	160	\N	8
902	596	483	43705.15	2026-02-27 23:41:14.46239	\N	980	\N	8
903	435	245	6727.56	2026-02-27 23:41:14.46239	\N	427	\N	8
904	622	266	44240.91	2026-02-27 23:41:14.46239	\N	234	\N	8
905	956	529	49024.69	2026-02-27 23:41:14.46239	\N	397	\N	8
906	289	810	86731.21	2026-02-27 23:41:14.46239	\N	388	\N	8
907	33	196	34425.44	2026-02-27 23:41:14.46239	\N	475	\N	8
908	941	696	57761.38	2026-02-27 23:41:14.46239	\N	464	\N	8
909	345	196	57276.60	2026-02-27 23:41:14.46239	\N	871	\N	8
910	685	7	92301.11	2026-02-27 23:41:14.46239	\N	437	\N	8
911	519	405	99502.66	2026-02-27 23:41:14.46239	\N	683	\N	8
912	610	853	65252.23	2026-02-27 23:41:14.46239	\N	809	\N	8
913	579	857	24538.58	2026-02-27 23:41:14.46239	\N	168	\N	8
914	11	404	98566.16	2026-02-27 23:41:14.46239	\N	984	\N	8
915	873	521	70178.17	2026-02-27 23:41:14.46239	\N	197	\N	8
916	648	937	76594.32	2026-02-27 23:41:14.46239	\N	610	\N	8
917	183	644	37176.78	2026-02-27 23:41:14.46239	\N	272	\N	8
918	806	503	43645.43	2026-02-27 23:41:14.46239	\N	801	\N	8
919	236	390	72405.32	2026-02-27 23:41:14.46239	\N	432	\N	8
920	980	988	28524.42	2026-02-27 23:41:14.46239	\N	987	\N	8
921	742	880	95424.89	2026-02-27 23:41:14.46239	\N	596	\N	8
922	508	549	41757.99	2026-02-27 23:41:14.46239	\N	789	\N	8
923	515	922	30463.33	2026-02-27 23:41:14.46239	\N	402	\N	8
924	421	769	89598.63	2026-02-27 23:41:14.46239	\N	947	\N	8
925	400	368	76679.99	2026-02-27 23:41:14.46239	\N	658	\N	8
926	339	59	68741.27	2026-02-27 23:41:14.46239	\N	852	\N	8
927	28	316	4585.01	2026-02-27 23:41:14.46239	\N	55	\N	8
928	335	468	27717.39	2026-02-27 23:41:14.46239	\N	47	\N	8
929	768	975	15857.09	2026-02-27 23:41:14.46239	\N	278	\N	8
930	658	929	87989.36	2026-02-27 23:41:14.46239	\N	53	\N	8
931	582	230	60794.03	2026-02-27 23:41:14.46239	\N	120	\N	8
932	341	753	25021.14	2026-02-27 23:41:14.46239	\N	826	\N	8
933	969	242	44513.97	2026-02-27 23:41:14.46239	\N	422	\N	8
934	39	544	11213.89	2026-02-27 23:41:14.46239	\N	625	\N	8
935	610	210	42339.07	2026-02-27 23:41:14.46239	\N	203	\N	8
936	410	825	28891.65	2026-02-27 23:41:14.46239	\N	10	\N	8
937	324	698	48217.53	2026-02-27 23:41:14.46239	\N	513	\N	8
938	164	862	20731.08	2026-02-27 23:41:14.46239	\N	305	\N	8
939	79	709	76176.27	2026-02-27 23:41:14.46239	\N	861	\N	8
940	631	108	4496.95	2026-02-27 23:41:14.46239	\N	22	\N	8
941	117	145	9349.22	2026-02-27 23:41:14.46239	\N	815	\N	8
942	691	723	14488.84	2026-02-27 23:41:14.46239	\N	908	\N	8
943	58	572	17157.30	2026-02-27 23:41:14.46239	\N	215	\N	8
944	530	613	47741.20	2026-02-27 23:41:14.46239	\N	529	\N	8
945	993	190	32068.35	2026-02-27 23:41:14.46239	\N	740	\N	8
946	203	22	66569.97	2026-02-27 23:41:14.46239	\N	800	\N	8
947	66	766	26936.59	2026-02-27 23:41:14.46239	\N	976	\N	8
948	543	218	49295.33	2026-02-27 23:41:14.46239	\N	343	\N	8
949	603	617	36264.68	2026-02-27 23:41:14.46239	\N	927	\N	8
950	905	330	3346.48	2026-02-27 23:41:14.46239	\N	433	\N	8
951	845	305	77683.55	2026-02-27 23:41:14.46239	\N	668	\N	8
952	133	172	75573.39	2026-02-27 23:41:14.46239	\N	551	\N	8
953	253	677	48461.90	2026-02-27 23:41:14.46239	\N	243	\N	8
954	317	942	91963.87	2026-02-27 23:41:14.46239	\N	835	\N	8
955	636	45	36723.82	2026-02-27 23:41:14.46239	\N	259	\N	8
956	707	661	72755.21	2026-02-27 23:41:14.46239	\N	950	\N	8
957	840	155	41860.59	2026-02-27 23:41:14.46239	\N	937	\N	8
958	257	195	43650.78	2026-02-27 23:41:14.46239	\N	343	\N	8
959	690	422	98076.11	2026-02-27 23:41:14.46239	\N	638	\N	8
960	700	884	26918.88	2026-02-27 23:41:14.46239	\N	521	\N	8
961	103	818	61376.41	2026-02-27 23:41:14.46239	\N	401	\N	8
962	333	787	13926.32	2026-02-27 23:41:14.46239	\N	221	\N	8
963	43	590	66047.20	2026-02-27 23:41:14.46239	\N	78	\N	8
964	653	449	43377.86	2026-02-27 23:41:14.46239	\N	364	\N	8
965	826	405	19462.67	2026-02-27 23:41:14.46239	\N	609	\N	8
966	633	980	90397.13	2026-02-27 23:41:14.46239	\N	150	\N	8
967	818	368	31792.13	2026-02-27 23:41:14.46239	\N	723	\N	8
968	966	245	85959.00	2026-02-27 23:41:14.46239	\N	830	\N	8
969	447	697	88033.49	2026-02-27 23:41:14.46239	\N	307	\N	8
970	132	560	82321.45	2026-02-27 23:41:14.46239	\N	260	\N	8
971	4	701	14497.19	2026-02-27 23:41:14.46239	\N	194	\N	8
972	809	556	69472.15	2026-02-27 23:41:14.46239	\N	657	\N	8
973	377	475	27358.07	2026-02-27 23:41:14.46239	\N	923	\N	8
974	425	758	42815.38	2026-02-27 23:41:14.46239	\N	953	\N	8
975	388	581	75425.21	2026-02-27 23:41:14.46239	\N	970	\N	8
976	883	663	35345.42	2026-02-27 23:41:14.46239	\N	728	\N	8
977	617	764	9467.19	2026-02-27 23:41:14.46239	\N	43	\N	8
978	84	758	98704.17	2026-02-27 23:41:14.46239	\N	258	\N	8
979	14	413	81040.81	2026-02-27 23:41:14.46239	\N	230	\N	8
980	761	580	6792.92	2026-02-27 23:41:14.46239	\N	29	\N	8
981	604	426	10127.24	2026-02-27 23:41:14.46239	\N	144	\N	8
982	6	592	28687.23	2026-02-27 23:41:14.46239	\N	497	\N	8
983	336	618	71244.49	2026-02-27 23:41:14.46239	\N	295	\N	8
984	761	410	45102.40	2026-02-27 23:41:14.46239	\N	767	\N	8
985	249	866	94164.15	2026-02-27 23:41:14.46239	\N	383	\N	8
986	45	250	80343.22	2026-02-27 23:41:14.46239	\N	3	\N	8
987	125	473	28431.60	2026-02-27 23:41:14.46239	\N	728	\N	8
988	139	7	74131.73	2026-02-27 23:41:14.46239	\N	514	\N	8
989	97	899	94855.54	2026-02-27 23:41:14.46239	\N	455	\N	8
990	420	163	4566.86	2026-02-27 23:41:14.46239	\N	695	\N	8
991	317	414	22337.02	2026-02-27 23:41:14.46239	\N	766	\N	8
992	719	869	58516.25	2026-02-27 23:41:14.46239	\N	127	\N	8
993	450	392	2434.29	2026-02-27 23:41:14.46239	\N	944	\N	8
994	334	955	59586.34	2026-02-27 23:41:14.46239	\N	357	\N	8
995	564	797	17723.64	2026-02-27 23:41:14.46239	\N	977	\N	8
996	995	269	4904.81	2026-02-27 23:41:14.46239	\N	972	\N	8
997	276	738	58933.37	2026-02-27 23:41:14.46239	\N	184	\N	8
998	907	736	42438.64	2026-02-27 23:41:14.46239	\N	368	\N	8
999	35	75	88161.50	2026-02-27 23:41:14.46239	\N	409	\N	8
1000	304	684	43989.28	2026-02-27 23:41:14.46239	\N	38	\N	8
\.


--
-- TOC entry 5112 (class 0 OID 16703)
-- Dependencies: 230
-- Data for Name: usuario_sistema; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario_sistema (id_usuario, username, password, id_rol, id_persona, id_empresa, id_estado) FROM stdin;
1	user1	123456	1	1	\N	1
2	user2	123456	1	2	\N	1
3	user3	123456	1	3	\N	1
4	user4	123456	1	4	\N	1
5	user5	123456	1	5	\N	1
6	user6	123456	1	6	\N	1
7	user7	123456	1	7	\N	1
8	user8	123456	1	8	\N	1
9	user9	123456	1	9	\N	1
10	user10	123456	1	10	\N	1
11	user11	123456	1	11	\N	1
12	user12	123456	1	12	\N	1
13	user13	123456	1	13	\N	1
14	user14	123456	1	14	\N	1
15	user15	123456	1	15	\N	1
16	user16	123456	1	16	\N	1
17	user17	123456	1	17	\N	1
18	user18	123456	1	18	\N	1
19	user19	123456	1	19	\N	1
20	user20	123456	1	20	\N	1
21	user21	123456	1	21	\N	1
22	user22	123456	1	22	\N	1
23	user23	123456	1	23	\N	1
24	user24	123456	1	24	\N	1
25	user25	123456	1	25	\N	1
26	user26	123456	1	26	\N	1
27	user27	123456	1	27	\N	1
28	user28	123456	1	28	\N	1
29	user29	123456	1	29	\N	1
30	user30	123456	1	30	\N	1
31	user31	123456	1	31	\N	1
32	user32	123456	1	32	\N	1
33	user33	123456	1	33	\N	1
34	user34	123456	1	34	\N	1
35	user35	123456	1	35	\N	1
36	user36	123456	1	36	\N	1
37	user37	123456	1	37	\N	1
38	user38	123456	1	38	\N	1
39	user39	123456	1	39	\N	1
40	user40	123456	1	40	\N	1
41	user41	123456	1	41	\N	1
42	user42	123456	1	42	\N	1
43	user43	123456	1	43	\N	1
44	user44	123456	1	44	\N	1
45	user45	123456	1	45	\N	1
46	user46	123456	1	46	\N	1
47	user47	123456	1	47	\N	1
48	user48	123456	1	48	\N	1
49	user49	123456	1	49	\N	1
50	user50	123456	1	50	\N	1
51	user51	123456	1	51	\N	1
52	user52	123456	1	52	\N	1
53	user53	123456	1	53	\N	1
54	user54	123456	1	54	\N	1
55	user55	123456	1	55	\N	1
56	user56	123456	1	56	\N	1
57	user57	123456	1	57	\N	1
58	user58	123456	1	58	\N	1
59	user59	123456	1	59	\N	1
60	user60	123456	1	60	\N	1
61	user61	123456	1	61	\N	1
62	user62	123456	1	62	\N	1
63	user63	123456	1	63	\N	1
64	user64	123456	1	64	\N	1
65	user65	123456	1	65	\N	1
66	user66	123456	1	66	\N	1
67	user67	123456	1	67	\N	1
68	user68	123456	1	68	\N	1
69	user69	123456	1	69	\N	1
70	user70	123456	1	70	\N	1
71	user71	123456	1	71	\N	1
72	user72	123456	1	72	\N	1
73	user73	123456	1	73	\N	1
74	user74	123456	1	74	\N	1
75	user75	123456	1	75	\N	1
76	user76	123456	1	76	\N	1
77	user77	123456	1	77	\N	1
78	user78	123456	1	78	\N	1
79	user79	123456	1	79	\N	1
80	user80	123456	1	80	\N	1
81	user81	123456	1	81	\N	1
82	user82	123456	1	82	\N	1
83	user83	123456	1	83	\N	1
84	user84	123456	1	84	\N	1
85	user85	123456	1	85	\N	1
86	user86	123456	1	86	\N	1
87	user87	123456	1	87	\N	1
88	user88	123456	1	88	\N	1
89	user89	123456	1	89	\N	1
90	user90	123456	1	90	\N	1
91	user91	123456	1	91	\N	1
92	user92	123456	1	92	\N	1
93	user93	123456	1	93	\N	1
94	user94	123456	1	94	\N	1
95	user95	123456	1	95	\N	1
96	user96	123456	1	96	\N	1
97	user97	123456	1	97	\N	1
98	user98	123456	1	98	\N	1
99	user99	123456	1	99	\N	1
100	user100	123456	1	100	\N	1
101	user101	123456	1	101	\N	1
102	user102	123456	1	102	\N	1
103	user103	123456	1	103	\N	1
104	user104	123456	1	104	\N	1
105	user105	123456	1	105	\N	1
106	user106	123456	1	106	\N	1
107	user107	123456	1	107	\N	1
108	user108	123456	1	108	\N	1
109	user109	123456	1	109	\N	1
110	user110	123456	1	110	\N	1
111	user111	123456	1	111	\N	1
112	user112	123456	1	112	\N	1
113	user113	123456	1	113	\N	1
114	user114	123456	1	114	\N	1
115	user115	123456	1	115	\N	1
116	user116	123456	1	116	\N	1
117	user117	123456	1	117	\N	1
118	user118	123456	1	118	\N	1
119	user119	123456	1	119	\N	1
120	user120	123456	1	120	\N	1
121	user121	123456	1	121	\N	1
122	user122	123456	1	122	\N	1
123	user123	123456	1	123	\N	1
124	user124	123456	1	124	\N	1
125	user125	123456	1	125	\N	1
126	user126	123456	1	126	\N	1
127	user127	123456	1	127	\N	1
128	user128	123456	1	128	\N	1
129	user129	123456	1	129	\N	1
130	user130	123456	1	130	\N	1
131	user131	123456	1	131	\N	1
132	user132	123456	1	132	\N	1
133	user133	123456	1	133	\N	1
134	user134	123456	1	134	\N	1
135	user135	123456	1	135	\N	1
136	user136	123456	1	136	\N	1
137	user137	123456	1	137	\N	1
138	user138	123456	1	138	\N	1
139	user139	123456	1	139	\N	1
140	user140	123456	1	140	\N	1
141	user141	123456	1	141	\N	1
142	user142	123456	1	142	\N	1
143	user143	123456	1	143	\N	1
144	user144	123456	1	144	\N	1
145	user145	123456	1	145	\N	1
146	user146	123456	1	146	\N	1
147	user147	123456	1	147	\N	1
148	user148	123456	1	148	\N	1
149	user149	123456	1	149	\N	1
150	user150	123456	1	150	\N	1
151	user151	123456	1	151	\N	1
152	user152	123456	1	152	\N	1
153	user153	123456	1	153	\N	1
154	user154	123456	1	154	\N	1
155	user155	123456	1	155	\N	1
156	user156	123456	1	156	\N	1
157	user157	123456	1	157	\N	1
158	user158	123456	1	158	\N	1
159	user159	123456	1	159	\N	1
160	user160	123456	1	160	\N	1
161	user161	123456	1	161	\N	1
162	user162	123456	1	162	\N	1
163	user163	123456	1	163	\N	1
164	user164	123456	1	164	\N	1
165	user165	123456	1	165	\N	1
166	user166	123456	1	166	\N	1
167	user167	123456	1	167	\N	1
168	user168	123456	1	168	\N	1
169	user169	123456	1	169	\N	1
170	user170	123456	1	170	\N	1
171	user171	123456	1	171	\N	1
172	user172	123456	1	172	\N	1
173	user173	123456	1	173	\N	1
174	user174	123456	1	174	\N	1
175	user175	123456	1	175	\N	1
176	user176	123456	1	176	\N	1
177	user177	123456	1	177	\N	1
178	user178	123456	1	178	\N	1
179	user179	123456	1	179	\N	1
180	user180	123456	1	180	\N	1
181	user181	123456	1	181	\N	1
182	user182	123456	1	182	\N	1
183	user183	123456	1	183	\N	1
184	user184	123456	1	184	\N	1
185	user185	123456	1	185	\N	1
186	user186	123456	1	186	\N	1
187	user187	123456	1	187	\N	1
188	user188	123456	1	188	\N	1
189	user189	123456	1	189	\N	1
190	user190	123456	1	190	\N	1
191	user191	123456	1	191	\N	1
192	user192	123456	1	192	\N	1
193	user193	123456	1	193	\N	1
194	user194	123456	1	194	\N	1
195	user195	123456	1	195	\N	1
196	user196	123456	1	196	\N	1
197	user197	123456	1	197	\N	1
198	user198	123456	1	198	\N	1
199	user199	123456	1	199	\N	1
200	user200	123456	1	200	\N	1
201	user201	123456	1	201	\N	1
202	user202	123456	1	202	\N	1
203	user203	123456	1	203	\N	1
204	user204	123456	1	204	\N	1
205	user205	123456	1	205	\N	1
206	user206	123456	1	206	\N	1
207	user207	123456	1	207	\N	1
208	user208	123456	1	208	\N	1
209	user209	123456	1	209	\N	1
210	user210	123456	1	210	\N	1
211	user211	123456	1	211	\N	1
212	user212	123456	1	212	\N	1
213	user213	123456	1	213	\N	1
214	user214	123456	1	214	\N	1
215	user215	123456	1	215	\N	1
216	user216	123456	1	216	\N	1
217	user217	123456	1	217	\N	1
218	user218	123456	1	218	\N	1
219	user219	123456	1	219	\N	1
220	user220	123456	1	220	\N	1
221	user221	123456	1	221	\N	1
222	user222	123456	1	222	\N	1
223	user223	123456	1	223	\N	1
224	user224	123456	1	224	\N	1
225	user225	123456	1	225	\N	1
226	user226	123456	1	226	\N	1
227	user227	123456	1	227	\N	1
228	user228	123456	1	228	\N	1
229	user229	123456	1	229	\N	1
230	user230	123456	1	230	\N	1
231	user231	123456	1	231	\N	1
232	user232	123456	1	232	\N	1
233	user233	123456	1	233	\N	1
234	user234	123456	1	234	\N	1
235	user235	123456	1	235	\N	1
236	user236	123456	1	236	\N	1
237	user237	123456	1	237	\N	1
238	user238	123456	1	238	\N	1
239	user239	123456	1	239	\N	1
240	user240	123456	1	240	\N	1
241	user241	123456	1	241	\N	1
242	user242	123456	1	242	\N	1
243	user243	123456	1	243	\N	1
244	user244	123456	1	244	\N	1
245	user245	123456	1	245	\N	1
246	user246	123456	1	246	\N	1
247	user247	123456	1	247	\N	1
248	user248	123456	1	248	\N	1
249	user249	123456	1	249	\N	1
250	user250	123456	1	250	\N	1
251	user251	123456	1	251	\N	1
252	user252	123456	1	252	\N	1
253	user253	123456	1	253	\N	1
254	user254	123456	1	254	\N	1
255	user255	123456	1	255	\N	1
256	user256	123456	1	256	\N	1
257	user257	123456	1	257	\N	1
258	user258	123456	1	258	\N	1
259	user259	123456	1	259	\N	1
260	user260	123456	1	260	\N	1
261	user261	123456	1	261	\N	1
262	user262	123456	1	262	\N	1
263	user263	123456	1	263	\N	1
264	user264	123456	1	264	\N	1
265	user265	123456	1	265	\N	1
266	user266	123456	1	266	\N	1
267	user267	123456	1	267	\N	1
268	user268	123456	1	268	\N	1
269	user269	123456	1	269	\N	1
270	user270	123456	1	270	\N	1
271	user271	123456	1	271	\N	1
272	user272	123456	1	272	\N	1
273	user273	123456	1	273	\N	1
274	user274	123456	1	274	\N	1
275	user275	123456	1	275	\N	1
276	user276	123456	1	276	\N	1
277	user277	123456	1	277	\N	1
278	user278	123456	1	278	\N	1
279	user279	123456	1	279	\N	1
280	user280	123456	1	280	\N	1
281	user281	123456	1	281	\N	1
282	user282	123456	1	282	\N	1
283	user283	123456	1	283	\N	1
284	user284	123456	1	284	\N	1
285	user285	123456	1	285	\N	1
286	user286	123456	1	286	\N	1
287	user287	123456	1	287	\N	1
288	user288	123456	1	288	\N	1
289	user289	123456	1	289	\N	1
290	user290	123456	1	290	\N	1
291	user291	123456	1	291	\N	1
292	user292	123456	1	292	\N	1
293	user293	123456	1	293	\N	1
294	user294	123456	1	294	\N	1
295	user295	123456	1	295	\N	1
296	user296	123456	1	296	\N	1
297	user297	123456	1	297	\N	1
298	user298	123456	1	298	\N	1
299	user299	123456	1	299	\N	1
300	user300	123456	1	300	\N	1
301	user301	123456	1	301	\N	1
302	user302	123456	1	302	\N	1
303	user303	123456	1	303	\N	1
304	user304	123456	1	304	\N	1
305	user305	123456	1	305	\N	1
306	user306	123456	1	306	\N	1
307	user307	123456	1	307	\N	1
308	user308	123456	1	308	\N	1
309	user309	123456	1	309	\N	1
310	user310	123456	1	310	\N	1
311	user311	123456	1	311	\N	1
312	user312	123456	1	312	\N	1
313	user313	123456	1	313	\N	1
314	user314	123456	1	314	\N	1
315	user315	123456	1	315	\N	1
316	user316	123456	1	316	\N	1
317	user317	123456	1	317	\N	1
318	user318	123456	1	318	\N	1
319	user319	123456	1	319	\N	1
320	user320	123456	1	320	\N	1
321	user321	123456	1	321	\N	1
322	user322	123456	1	322	\N	1
323	user323	123456	1	323	\N	1
324	user324	123456	1	324	\N	1
325	user325	123456	1	325	\N	1
326	user326	123456	1	326	\N	1
327	user327	123456	1	327	\N	1
328	user328	123456	1	328	\N	1
329	user329	123456	1	329	\N	1
330	user330	123456	1	330	\N	1
331	user331	123456	1	331	\N	1
332	user332	123456	1	332	\N	1
333	user333	123456	1	333	\N	1
334	user334	123456	1	334	\N	1
335	user335	123456	1	335	\N	1
336	user336	123456	1	336	\N	1
337	user337	123456	1	337	\N	1
338	user338	123456	1	338	\N	1
339	user339	123456	1	339	\N	1
340	user340	123456	1	340	\N	1
341	user341	123456	1	341	\N	1
342	user342	123456	1	342	\N	1
343	user343	123456	1	343	\N	1
344	user344	123456	1	344	\N	1
345	user345	123456	1	345	\N	1
346	user346	123456	1	346	\N	1
347	user347	123456	1	347	\N	1
348	user348	123456	1	348	\N	1
349	user349	123456	1	349	\N	1
350	user350	123456	1	350	\N	1
351	user351	123456	1	351	\N	1
352	user352	123456	1	352	\N	1
353	user353	123456	1	353	\N	1
354	user354	123456	1	354	\N	1
355	user355	123456	1	355	\N	1
356	user356	123456	1	356	\N	1
357	user357	123456	1	357	\N	1
358	user358	123456	1	358	\N	1
359	user359	123456	1	359	\N	1
360	user360	123456	1	360	\N	1
361	user361	123456	1	361	\N	1
362	user362	123456	1	362	\N	1
363	user363	123456	1	363	\N	1
364	user364	123456	1	364	\N	1
365	user365	123456	1	365	\N	1
366	user366	123456	1	366	\N	1
367	user367	123456	1	367	\N	1
368	user368	123456	1	368	\N	1
369	user369	123456	1	369	\N	1
370	user370	123456	1	370	\N	1
371	user371	123456	1	371	\N	1
372	user372	123456	1	372	\N	1
373	user373	123456	1	373	\N	1
374	user374	123456	1	374	\N	1
375	user375	123456	1	375	\N	1
376	user376	123456	1	376	\N	1
377	user377	123456	1	377	\N	1
378	user378	123456	1	378	\N	1
379	user379	123456	1	379	\N	1
380	user380	123456	1	380	\N	1
381	user381	123456	1	381	\N	1
382	user382	123456	1	382	\N	1
383	user383	123456	1	383	\N	1
384	user384	123456	1	384	\N	1
385	user385	123456	1	385	\N	1
386	user386	123456	1	386	\N	1
387	user387	123456	1	387	\N	1
388	user388	123456	1	388	\N	1
389	user389	123456	1	389	\N	1
390	user390	123456	1	390	\N	1
391	user391	123456	1	391	\N	1
392	user392	123456	1	392	\N	1
393	user393	123456	1	393	\N	1
394	user394	123456	1	394	\N	1
395	user395	123456	1	395	\N	1
396	user396	123456	1	396	\N	1
397	user397	123456	1	397	\N	1
398	user398	123456	1	398	\N	1
399	user399	123456	1	399	\N	1
400	user400	123456	1	400	\N	1
401	user401	123456	1	401	\N	1
402	user402	123456	1	402	\N	1
403	user403	123456	1	403	\N	1
404	user404	123456	1	404	\N	1
405	user405	123456	1	405	\N	1
406	user406	123456	1	406	\N	1
407	user407	123456	1	407	\N	1
408	user408	123456	1	408	\N	1
409	user409	123456	1	409	\N	1
410	user410	123456	1	410	\N	1
411	user411	123456	1	411	\N	1
412	user412	123456	1	412	\N	1
413	user413	123456	1	413	\N	1
414	user414	123456	1	414	\N	1
415	user415	123456	1	415	\N	1
416	user416	123456	1	416	\N	1
417	user417	123456	1	417	\N	1
418	user418	123456	1	418	\N	1
419	user419	123456	1	419	\N	1
420	user420	123456	1	420	\N	1
421	user421	123456	1	421	\N	1
422	user422	123456	1	422	\N	1
423	user423	123456	1	423	\N	1
424	user424	123456	1	424	\N	1
425	user425	123456	1	425	\N	1
426	user426	123456	1	426	\N	1
427	user427	123456	1	427	\N	1
428	user428	123456	1	428	\N	1
429	user429	123456	1	429	\N	1
430	user430	123456	1	430	\N	1
431	user431	123456	1	431	\N	1
432	user432	123456	1	432	\N	1
433	user433	123456	1	433	\N	1
434	user434	123456	1	434	\N	1
435	user435	123456	1	435	\N	1
436	user436	123456	1	436	\N	1
437	user437	123456	1	437	\N	1
438	user438	123456	1	438	\N	1
439	user439	123456	1	439	\N	1
440	user440	123456	1	440	\N	1
441	user441	123456	1	441	\N	1
442	user442	123456	1	442	\N	1
443	user443	123456	1	443	\N	1
444	user444	123456	1	444	\N	1
445	user445	123456	1	445	\N	1
446	user446	123456	1	446	\N	1
447	user447	123456	1	447	\N	1
448	user448	123456	1	448	\N	1
449	user449	123456	1	449	\N	1
450	user450	123456	1	450	\N	1
451	user451	123456	1	451	\N	1
452	user452	123456	1	452	\N	1
453	user453	123456	1	453	\N	1
454	user454	123456	1	454	\N	1
455	user455	123456	1	455	\N	1
456	user456	123456	1	456	\N	1
457	user457	123456	1	457	\N	1
458	user458	123456	1	458	\N	1
459	user459	123456	1	459	\N	1
460	user460	123456	1	460	\N	1
461	user461	123456	1	461	\N	1
462	user462	123456	1	462	\N	1
463	user463	123456	1	463	\N	1
464	user464	123456	1	464	\N	1
465	user465	123456	1	465	\N	1
466	user466	123456	1	466	\N	1
467	user467	123456	1	467	\N	1
468	user468	123456	1	468	\N	1
469	user469	123456	1	469	\N	1
470	user470	123456	1	470	\N	1
471	user471	123456	1	471	\N	1
472	user472	123456	1	472	\N	1
473	user473	123456	1	473	\N	1
474	user474	123456	1	474	\N	1
475	user475	123456	1	475	\N	1
476	user476	123456	1	476	\N	1
477	user477	123456	1	477	\N	1
478	user478	123456	1	478	\N	1
479	user479	123456	1	479	\N	1
480	user480	123456	1	480	\N	1
481	user481	123456	1	481	\N	1
482	user482	123456	1	482	\N	1
483	user483	123456	1	483	\N	1
484	user484	123456	1	484	\N	1
485	user485	123456	1	485	\N	1
486	user486	123456	1	486	\N	1
487	user487	123456	1	487	\N	1
488	user488	123456	1	488	\N	1
489	user489	123456	1	489	\N	1
490	user490	123456	1	490	\N	1
491	user491	123456	1	491	\N	1
492	user492	123456	1	492	\N	1
493	user493	123456	1	493	\N	1
494	user494	123456	1	494	\N	1
495	user495	123456	1	495	\N	1
496	user496	123456	1	496	\N	1
497	user497	123456	1	497	\N	1
498	user498	123456	1	498	\N	1
499	user499	123456	1	499	\N	1
500	user500	123456	1	500	\N	1
501	user501	123456	1	501	\N	1
502	user502	123456	1	502	\N	1
503	user503	123456	1	503	\N	1
504	user504	123456	1	504	\N	1
505	user505	123456	1	505	\N	1
506	user506	123456	1	506	\N	1
507	user507	123456	1	507	\N	1
508	user508	123456	1	508	\N	1
509	user509	123456	1	509	\N	1
510	user510	123456	1	510	\N	1
511	user511	123456	1	511	\N	1
512	user512	123456	1	512	\N	1
513	user513	123456	1	513	\N	1
514	user514	123456	1	514	\N	1
515	user515	123456	1	515	\N	1
516	user516	123456	1	516	\N	1
517	user517	123456	1	517	\N	1
518	user518	123456	1	518	\N	1
519	user519	123456	1	519	\N	1
520	user520	123456	1	520	\N	1
521	user521	123456	1	521	\N	1
522	user522	123456	1	522	\N	1
523	user523	123456	1	523	\N	1
524	user524	123456	1	524	\N	1
525	user525	123456	1	525	\N	1
526	user526	123456	1	526	\N	1
527	user527	123456	1	527	\N	1
528	user528	123456	1	528	\N	1
529	user529	123456	1	529	\N	1
530	user530	123456	1	530	\N	1
531	user531	123456	1	531	\N	1
532	user532	123456	1	532	\N	1
533	user533	123456	1	533	\N	1
534	user534	123456	1	534	\N	1
535	user535	123456	1	535	\N	1
536	user536	123456	1	536	\N	1
537	user537	123456	1	537	\N	1
538	user538	123456	1	538	\N	1
539	user539	123456	1	539	\N	1
540	user540	123456	1	540	\N	1
541	user541	123456	1	541	\N	1
542	user542	123456	1	542	\N	1
543	user543	123456	1	543	\N	1
544	user544	123456	1	544	\N	1
545	user545	123456	1	545	\N	1
546	user546	123456	1	546	\N	1
547	user547	123456	1	547	\N	1
548	user548	123456	1	548	\N	1
549	user549	123456	1	549	\N	1
550	user550	123456	1	550	\N	1
551	user551	123456	1	551	\N	1
552	user552	123456	1	552	\N	1
553	user553	123456	1	553	\N	1
554	user554	123456	1	554	\N	1
555	user555	123456	1	555	\N	1
556	user556	123456	1	556	\N	1
557	user557	123456	1	557	\N	1
558	user558	123456	1	558	\N	1
559	user559	123456	1	559	\N	1
560	user560	123456	1	560	\N	1
561	user561	123456	1	561	\N	1
562	user562	123456	1	562	\N	1
563	user563	123456	1	563	\N	1
564	user564	123456	1	564	\N	1
565	user565	123456	1	565	\N	1
566	user566	123456	1	566	\N	1
567	user567	123456	1	567	\N	1
568	user568	123456	1	568	\N	1
569	user569	123456	1	569	\N	1
570	user570	123456	1	570	\N	1
571	user571	123456	1	571	\N	1
572	user572	123456	1	572	\N	1
573	user573	123456	1	573	\N	1
574	user574	123456	1	574	\N	1
575	user575	123456	1	575	\N	1
576	user576	123456	1	576	\N	1
577	user577	123456	1	577	\N	1
578	user578	123456	1	578	\N	1
579	user579	123456	1	579	\N	1
580	user580	123456	1	580	\N	1
581	user581	123456	1	581	\N	1
582	user582	123456	1	582	\N	1
583	user583	123456	1	583	\N	1
584	user584	123456	1	584	\N	1
585	user585	123456	1	585	\N	1
586	user586	123456	1	586	\N	1
587	user587	123456	1	587	\N	1
588	user588	123456	1	588	\N	1
589	user589	123456	1	589	\N	1
590	user590	123456	1	590	\N	1
591	user591	123456	1	591	\N	1
592	user592	123456	1	592	\N	1
593	user593	123456	1	593	\N	1
594	user594	123456	1	594	\N	1
595	user595	123456	1	595	\N	1
596	user596	123456	1	596	\N	1
597	user597	123456	1	597	\N	1
598	user598	123456	1	598	\N	1
599	user599	123456	1	599	\N	1
600	user600	123456	1	600	\N	1
601	user601	123456	1	601	\N	1
602	user602	123456	1	602	\N	1
603	user603	123456	1	603	\N	1
604	user604	123456	1	604	\N	1
605	user605	123456	1	605	\N	1
606	user606	123456	1	606	\N	1
607	user607	123456	1	607	\N	1
608	user608	123456	1	608	\N	1
609	user609	123456	1	609	\N	1
610	user610	123456	1	610	\N	1
611	user611	123456	1	611	\N	1
612	user612	123456	1	612	\N	1
613	user613	123456	1	613	\N	1
614	user614	123456	1	614	\N	1
615	user615	123456	1	615	\N	1
616	user616	123456	1	616	\N	1
617	user617	123456	1	617	\N	1
618	user618	123456	1	618	\N	1
619	user619	123456	1	619	\N	1
620	user620	123456	1	620	\N	1
621	user621	123456	1	621	\N	1
622	user622	123456	1	622	\N	1
623	user623	123456	1	623	\N	1
624	user624	123456	1	624	\N	1
625	user625	123456	1	625	\N	1
626	user626	123456	1	626	\N	1
627	user627	123456	1	627	\N	1
628	user628	123456	1	628	\N	1
629	user629	123456	1	629	\N	1
630	user630	123456	1	630	\N	1
631	user631	123456	1	631	\N	1
632	user632	123456	1	632	\N	1
633	user633	123456	1	633	\N	1
634	user634	123456	1	634	\N	1
635	user635	123456	1	635	\N	1
636	user636	123456	1	636	\N	1
637	user637	123456	1	637	\N	1
638	user638	123456	1	638	\N	1
639	user639	123456	1	639	\N	1
640	user640	123456	1	640	\N	1
641	user641	123456	1	641	\N	1
642	user642	123456	1	642	\N	1
643	user643	123456	1	643	\N	1
644	user644	123456	1	644	\N	1
645	user645	123456	1	645	\N	1
646	user646	123456	1	646	\N	1
647	user647	123456	1	647	\N	1
648	user648	123456	1	648	\N	1
649	user649	123456	1	649	\N	1
650	user650	123456	1	650	\N	1
651	user651	123456	1	651	\N	1
652	user652	123456	1	652	\N	1
653	user653	123456	1	653	\N	1
654	user654	123456	1	654	\N	1
655	user655	123456	1	655	\N	1
656	user656	123456	1	656	\N	1
657	user657	123456	1	657	\N	1
658	user658	123456	1	658	\N	1
659	user659	123456	1	659	\N	1
660	user660	123456	1	660	\N	1
661	user661	123456	1	661	\N	1
662	user662	123456	1	662	\N	1
663	user663	123456	1	663	\N	1
664	user664	123456	1	664	\N	1
665	user665	123456	1	665	\N	1
666	user666	123456	1	666	\N	1
667	user667	123456	1	667	\N	1
668	user668	123456	1	668	\N	1
669	user669	123456	1	669	\N	1
670	user670	123456	1	670	\N	1
671	user671	123456	1	671	\N	1
672	user672	123456	1	672	\N	1
673	user673	123456	1	673	\N	1
674	user674	123456	1	674	\N	1
675	user675	123456	1	675	\N	1
676	user676	123456	1	676	\N	1
677	user677	123456	1	677	\N	1
678	user678	123456	1	678	\N	1
679	user679	123456	1	679	\N	1
680	user680	123456	1	680	\N	1
681	user681	123456	1	681	\N	1
682	user682	123456	1	682	\N	1
683	user683	123456	1	683	\N	1
684	user684	123456	1	684	\N	1
685	user685	123456	1	685	\N	1
686	user686	123456	1	686	\N	1
687	user687	123456	1	687	\N	1
688	user688	123456	1	688	\N	1
689	user689	123456	1	689	\N	1
690	user690	123456	1	690	\N	1
691	user691	123456	1	691	\N	1
692	user692	123456	1	692	\N	1
693	user693	123456	1	693	\N	1
694	user694	123456	1	694	\N	1
695	user695	123456	1	695	\N	1
696	user696	123456	1	696	\N	1
697	user697	123456	1	697	\N	1
698	user698	123456	1	698	\N	1
699	user699	123456	1	699	\N	1
700	user700	123456	1	700	\N	1
701	user701	123456	1	701	\N	1
702	user702	123456	1	702	\N	1
703	user703	123456	1	703	\N	1
704	user704	123456	1	704	\N	1
705	user705	123456	1	705	\N	1
706	user706	123456	1	706	\N	1
707	user707	123456	1	707	\N	1
708	user708	123456	1	708	\N	1
709	user709	123456	1	709	\N	1
710	user710	123456	1	710	\N	1
711	user711	123456	1	711	\N	1
712	user712	123456	1	712	\N	1
713	user713	123456	1	713	\N	1
714	user714	123456	1	714	\N	1
715	user715	123456	1	715	\N	1
716	user716	123456	1	716	\N	1
717	user717	123456	1	717	\N	1
718	user718	123456	1	718	\N	1
719	user719	123456	1	719	\N	1
720	user720	123456	1	720	\N	1
721	user721	123456	1	721	\N	1
722	user722	123456	1	722	\N	1
723	user723	123456	1	723	\N	1
724	user724	123456	1	724	\N	1
725	user725	123456	1	725	\N	1
726	user726	123456	1	726	\N	1
727	user727	123456	1	727	\N	1
728	user728	123456	1	728	\N	1
729	user729	123456	1	729	\N	1
730	user730	123456	1	730	\N	1
731	user731	123456	1	731	\N	1
732	user732	123456	1	732	\N	1
733	user733	123456	1	733	\N	1
734	user734	123456	1	734	\N	1
735	user735	123456	1	735	\N	1
736	user736	123456	1	736	\N	1
737	user737	123456	1	737	\N	1
738	user738	123456	1	738	\N	1
739	user739	123456	1	739	\N	1
740	user740	123456	1	740	\N	1
741	user741	123456	1	741	\N	1
742	user742	123456	1	742	\N	1
743	user743	123456	1	743	\N	1
744	user744	123456	1	744	\N	1
745	user745	123456	1	745	\N	1
746	user746	123456	1	746	\N	1
747	user747	123456	1	747	\N	1
748	user748	123456	1	748	\N	1
749	user749	123456	1	749	\N	1
750	user750	123456	1	750	\N	1
751	user751	123456	1	751	\N	1
752	user752	123456	1	752	\N	1
753	user753	123456	1	753	\N	1
754	user754	123456	1	754	\N	1
755	user755	123456	1	755	\N	1
756	user756	123456	1	756	\N	1
757	user757	123456	1	757	\N	1
758	user758	123456	1	758	\N	1
759	user759	123456	1	759	\N	1
760	user760	123456	1	760	\N	1
761	user761	123456	1	761	\N	1
762	user762	123456	1	762	\N	1
763	user763	123456	1	763	\N	1
764	user764	123456	1	764	\N	1
765	user765	123456	1	765	\N	1
766	user766	123456	1	766	\N	1
767	user767	123456	1	767	\N	1
768	user768	123456	1	768	\N	1
769	user769	123456	1	769	\N	1
770	user770	123456	1	770	\N	1
771	user771	123456	1	771	\N	1
772	user772	123456	1	772	\N	1
773	user773	123456	1	773	\N	1
774	user774	123456	1	774	\N	1
775	user775	123456	1	775	\N	1
776	user776	123456	1	776	\N	1
777	user777	123456	1	777	\N	1
778	user778	123456	1	778	\N	1
779	user779	123456	1	779	\N	1
780	user780	123456	1	780	\N	1
781	user781	123456	1	781	\N	1
782	user782	123456	1	782	\N	1
783	user783	123456	1	783	\N	1
784	user784	123456	1	784	\N	1
785	user785	123456	1	785	\N	1
786	user786	123456	1	786	\N	1
787	user787	123456	1	787	\N	1
788	user788	123456	1	788	\N	1
789	user789	123456	1	789	\N	1
790	user790	123456	1	790	\N	1
791	user791	123456	1	791	\N	1
792	user792	123456	1	792	\N	1
793	user793	123456	1	793	\N	1
794	user794	123456	1	794	\N	1
795	user795	123456	1	795	\N	1
796	user796	123456	1	796	\N	1
797	user797	123456	1	797	\N	1
798	user798	123456	1	798	\N	1
799	user799	123456	1	799	\N	1
800	user800	123456	1	800	\N	1
801	user801	123456	1	801	\N	1
802	user802	123456	1	802	\N	1
803	user803	123456	1	803	\N	1
804	user804	123456	1	804	\N	1
805	user805	123456	1	805	\N	1
806	user806	123456	1	806	\N	1
807	user807	123456	1	807	\N	1
808	user808	123456	1	808	\N	1
809	user809	123456	1	809	\N	1
810	user810	123456	1	810	\N	1
811	user811	123456	1	811	\N	1
812	user812	123456	1	812	\N	1
813	user813	123456	1	813	\N	1
814	user814	123456	1	814	\N	1
815	user815	123456	1	815	\N	1
816	user816	123456	1	816	\N	1
817	user817	123456	1	817	\N	1
818	user818	123456	1	818	\N	1
819	user819	123456	1	819	\N	1
820	user820	123456	1	820	\N	1
821	user821	123456	1	821	\N	1
822	user822	123456	1	822	\N	1
823	user823	123456	1	823	\N	1
824	user824	123456	1	824	\N	1
825	user825	123456	1	825	\N	1
826	user826	123456	1	826	\N	1
827	user827	123456	1	827	\N	1
828	user828	123456	1	828	\N	1
829	user829	123456	1	829	\N	1
830	user830	123456	1	830	\N	1
831	user831	123456	1	831	\N	1
832	user832	123456	1	832	\N	1
833	user833	123456	1	833	\N	1
834	user834	123456	1	834	\N	1
835	user835	123456	1	835	\N	1
836	user836	123456	1	836	\N	1
837	user837	123456	1	837	\N	1
838	user838	123456	1	838	\N	1
839	user839	123456	1	839	\N	1
840	user840	123456	1	840	\N	1
841	user841	123456	1	841	\N	1
842	user842	123456	1	842	\N	1
843	user843	123456	1	843	\N	1
844	user844	123456	1	844	\N	1
845	user845	123456	1	845	\N	1
846	user846	123456	1	846	\N	1
847	user847	123456	1	847	\N	1
848	user848	123456	1	848	\N	1
849	user849	123456	1	849	\N	1
850	user850	123456	1	850	\N	1
851	user851	123456	1	851	\N	1
852	user852	123456	1	852	\N	1
853	user853	123456	1	853	\N	1
854	user854	123456	1	854	\N	1
855	user855	123456	1	855	\N	1
856	user856	123456	1	856	\N	1
857	user857	123456	1	857	\N	1
858	user858	123456	1	858	\N	1
859	user859	123456	1	859	\N	1
860	user860	123456	1	860	\N	1
861	user861	123456	1	861	\N	1
862	user862	123456	1	862	\N	1
863	user863	123456	1	863	\N	1
864	user864	123456	1	864	\N	1
865	user865	123456	1	865	\N	1
866	user866	123456	1	866	\N	1
867	user867	123456	1	867	\N	1
868	user868	123456	1	868	\N	1
869	user869	123456	1	869	\N	1
870	user870	123456	1	870	\N	1
871	user871	123456	1	871	\N	1
872	user872	123456	1	872	\N	1
873	user873	123456	1	873	\N	1
874	user874	123456	1	874	\N	1
875	user875	123456	1	875	\N	1
876	user876	123456	1	876	\N	1
877	user877	123456	1	877	\N	1
878	user878	123456	1	878	\N	1
879	user879	123456	1	879	\N	1
880	user880	123456	1	880	\N	1
881	user881	123456	1	881	\N	1
882	user882	123456	1	882	\N	1
883	user883	123456	1	883	\N	1
884	user884	123456	1	884	\N	1
885	user885	123456	1	885	\N	1
886	user886	123456	1	886	\N	1
887	user887	123456	1	887	\N	1
888	user888	123456	1	888	\N	1
889	user889	123456	1	889	\N	1
890	user890	123456	1	890	\N	1
891	user891	123456	1	891	\N	1
892	user892	123456	1	892	\N	1
893	user893	123456	1	893	\N	1
894	user894	123456	1	894	\N	1
895	user895	123456	1	895	\N	1
896	user896	123456	1	896	\N	1
897	user897	123456	1	897	\N	1
898	user898	123456	1	898	\N	1
899	user899	123456	1	899	\N	1
900	user900	123456	1	900	\N	1
901	user901	123456	1	901	\N	1
902	user902	123456	1	902	\N	1
903	user903	123456	1	903	\N	1
904	user904	123456	1	904	\N	1
905	user905	123456	1	905	\N	1
906	user906	123456	1	906	\N	1
907	user907	123456	1	907	\N	1
908	user908	123456	1	908	\N	1
909	user909	123456	1	909	\N	1
910	user910	123456	1	910	\N	1
911	user911	123456	1	911	\N	1
912	user912	123456	1	912	\N	1
913	user913	123456	1	913	\N	1
914	user914	123456	1	914	\N	1
915	user915	123456	1	915	\N	1
916	user916	123456	1	916	\N	1
917	user917	123456	1	917	\N	1
918	user918	123456	1	918	\N	1
919	user919	123456	1	919	\N	1
920	user920	123456	1	920	\N	1
921	user921	123456	1	921	\N	1
922	user922	123456	1	922	\N	1
923	user923	123456	1	923	\N	1
924	user924	123456	1	924	\N	1
925	user925	123456	1	925	\N	1
926	user926	123456	1	926	\N	1
927	user927	123456	1	927	\N	1
928	user928	123456	1	928	\N	1
929	user929	123456	1	929	\N	1
930	user930	123456	1	930	\N	1
931	user931	123456	1	931	\N	1
932	user932	123456	1	932	\N	1
933	user933	123456	1	933	\N	1
934	user934	123456	1	934	\N	1
935	user935	123456	1	935	\N	1
936	user936	123456	1	936	\N	1
937	user937	123456	1	937	\N	1
938	user938	123456	1	938	\N	1
939	user939	123456	1	939	\N	1
940	user940	123456	1	940	\N	1
941	user941	123456	1	941	\N	1
942	user942	123456	1	942	\N	1
943	user943	123456	1	943	\N	1
944	user944	123456	1	944	\N	1
945	user945	123456	1	945	\N	1
946	user946	123456	1	946	\N	1
947	user947	123456	1	947	\N	1
948	user948	123456	1	948	\N	1
949	user949	123456	1	949	\N	1
950	user950	123456	1	950	\N	1
951	user951	123456	1	951	\N	1
952	user952	123456	1	952	\N	1
953	user953	123456	1	953	\N	1
954	user954	123456	1	954	\N	1
955	user955	123456	1	955	\N	1
956	user956	123456	1	956	\N	1
957	user957	123456	1	957	\N	1
958	user958	123456	1	958	\N	1
959	user959	123456	1	959	\N	1
960	user960	123456	1	960	\N	1
961	user961	123456	1	961	\N	1
962	user962	123456	1	962	\N	1
963	user963	123456	1	963	\N	1
964	user964	123456	1	964	\N	1
965	user965	123456	1	965	\N	1
966	user966	123456	1	966	\N	1
967	user967	123456	1	967	\N	1
968	user968	123456	1	968	\N	1
969	user969	123456	1	969	\N	1
970	user970	123456	1	970	\N	1
971	user971	123456	1	971	\N	1
972	user972	123456	1	972	\N	1
973	user973	123456	1	973	\N	1
974	user974	123456	1	974	\N	1
975	user975	123456	1	975	\N	1
976	user976	123456	1	976	\N	1
977	user977	123456	1	977	\N	1
978	user978	123456	1	978	\N	1
979	user979	123456	1	979	\N	1
980	user980	123456	1	980	\N	1
981	user981	123456	1	981	\N	1
982	user982	123456	1	982	\N	1
983	user983	123456	1	983	\N	1
984	user984	123456	1	984	\N	1
985	user985	123456	1	985	\N	1
986	user986	123456	1	986	\N	1
987	user987	123456	1	987	\N	1
988	user988	123456	1	988	\N	1
989	user989	123456	1	989	\N	1
990	user990	123456	1	990	\N	1
991	user991	123456	1	991	\N	1
992	user992	123456	1	992	\N	1
993	user993	123456	1	993	\N	1
994	user994	123456	1	994	\N	1
995	user995	123456	1	995	\N	1
996	user996	123456	1	996	\N	1
997	user997	123456	1	997	\N	1
998	user998	123456	1	998	\N	1
999	user999	123456	1	999	\N	1
1000	user1000	123456	1	1000	\N	1
\.


--
-- TOC entry 5136 (class 0 OID 0)
-- Dependencies: 237
-- Name: bitacora_operaciones_id_bitacora_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bitacora_operaciones_id_bitacora_seq', 1000, true);


--
-- TOC entry 5137 (class 0 OID 0)
-- Dependencies: 227
-- Name: cliente_empresa_id_empresa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cliente_empresa_id_empresa_seq', 200, true);


--
-- TOC entry 5138 (class 0 OID 0)
-- Dependencies: 225
-- Name: cliente_persona_id_persona_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cliente_persona_id_persona_seq', 1000, true);


--
-- TOC entry 5139 (class 0 OID 0)
-- Dependencies: 231
-- Name: cuenta_bancaria_id_cuenta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cuenta_bancaria_id_cuenta_seq', 1000, true);


--
-- TOC entry 5140 (class 0 OID 0)
-- Dependencies: 221
-- Name: estado_general_id_estado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estado_general_id_estado_seq', 10, true);


--
-- TOC entry 5141 (class 0 OID 0)
-- Dependencies: 233
-- Name: prestamo_id_prestamo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prestamo_id_prestamo_seq', 500, true);


--
-- TOC entry 5142 (class 0 OID 0)
-- Dependencies: 223
-- Name: producto_bancario_id_producto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.producto_bancario_id_producto_seq', 4, true);


--
-- TOC entry 5143 (class 0 OID 0)
-- Dependencies: 219
-- Name: rol_sistema_id_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rol_sistema_id_rol_seq', 7, true);


--
-- TOC entry 5144 (class 0 OID 0)
-- Dependencies: 235
-- Name: transferencia_id_transferencia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transferencia_id_transferencia_seq', 1000, true);


--
-- TOC entry 5145 (class 0 OID 0)
-- Dependencies: 229
-- Name: usuario_sistema_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_sistema_id_usuario_seq', 1000, true);


--
-- TOC entry 4930 (class 2606 OID 16881)
-- Name: bitacora_op bitacora_operaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitacora_op
    ADD CONSTRAINT bitacora_operaciones_pkey PRIMARY KEY (id_bitacora);


--
-- TOC entry 4920 (class 2606 OID 16691)
-- Name: cliente_empresa cliente_empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente_empresa
    ADD CONSTRAINT cliente_empresa_pkey PRIMARY KEY (id_empresa);


--
-- TOC entry 4918 (class 2606 OID 16671)
-- Name: cliente_person cliente_persona_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente_person
    ADD CONSTRAINT cliente_persona_pkey PRIMARY KEY (id_persona);


--
-- TOC entry 4924 (class 2606 OID 16747)
-- Name: cuenta_bancaria cuenta_bancaria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_bancaria
    ADD CONSTRAINT cuenta_bancaria_pkey PRIMARY KEY (id_cuenta);


--
-- TOC entry 4914 (class 2606 OID 16645)
-- Name: estado_general estado_general_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_general
    ADD CONSTRAINT estado_general_pkey PRIMARY KEY (id_estado);


--
-- TOC entry 4926 (class 2606 OID 16780)
-- Name: prestamo prestamo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestamo
    ADD CONSTRAINT prestamo_pkey PRIMARY KEY (id_prestamo);


--
-- TOC entry 4916 (class 2606 OID 16656)
-- Name: producto_bancario producto_bancario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto_bancario
    ADD CONSTRAINT producto_bancario_pkey PRIMARY KEY (id_producto);


--
-- TOC entry 4912 (class 2606 OID 16636)
-- Name: rol rol_sistema_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rol
    ADD CONSTRAINT rol_sistema_pkey PRIMARY KEY (id_rol);


--
-- TOC entry 4928 (class 2606 OID 16824)
-- Name: transferencia transferencia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transferencia
    ADD CONSTRAINT transferencia_pkey PRIMARY KEY (id_transferencia);


--
-- TOC entry 4922 (class 2606 OID 16713)
-- Name: usuario_sistema usuario_sistema_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_sistema
    ADD CONSTRAINT usuario_sistema_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 4953 (class 2606 OID 16882)
-- Name: bitacora_op bitacora_operaciones_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitacora_op
    ADD CONSTRAINT bitacora_operaciones_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario_sistema(id_usuario);


--
-- TOC entry 4932 (class 2606 OID 16697)
-- Name: cliente_empresa cliente_empresa_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente_empresa
    ADD CONSTRAINT cliente_empresa_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES public.estado_general(id_estado);


--
-- TOC entry 4933 (class 2606 OID 16692)
-- Name: cliente_empresa cliente_empresa_id_representante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente_empresa
    ADD CONSTRAINT cliente_empresa_id_representante_fkey FOREIGN KEY (id_representante) REFERENCES public.cliente_person(id_persona);


--
-- TOC entry 4931 (class 2606 OID 16672)
-- Name: cliente_person cliente_persona_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente_person
    ADD CONSTRAINT cliente_persona_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES public.estado_general(id_estado);


--
-- TOC entry 4938 (class 2606 OID 16758)
-- Name: cuenta_bancaria cuenta_bancaria_id_empresa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_bancaria
    ADD CONSTRAINT cuenta_bancaria_id_empresa_fkey FOREIGN KEY (id_empresa) REFERENCES public.cliente_empresa(id_empresa);


--
-- TOC entry 4939 (class 2606 OID 16763)
-- Name: cuenta_bancaria cuenta_bancaria_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_bancaria
    ADD CONSTRAINT cuenta_bancaria_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES public.estado_general(id_estado);


--
-- TOC entry 4940 (class 2606 OID 16753)
-- Name: cuenta_bancaria cuenta_bancaria_id_persona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_bancaria
    ADD CONSTRAINT cuenta_bancaria_id_persona_fkey FOREIGN KEY (id_persona) REFERENCES public.cliente_person(id_persona);


--
-- TOC entry 4941 (class 2606 OID 16748)
-- Name: cuenta_bancaria cuenta_bancaria_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuenta_bancaria
    ADD CONSTRAINT cuenta_bancaria_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.producto_bancario(id_producto);


--
-- TOC entry 4942 (class 2606 OID 16801)
-- Name: prestamo prestamo_id_analista_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestamo
    ADD CONSTRAINT prestamo_id_analista_fkey FOREIGN KEY (id_analista) REFERENCES public.usuario_sistema(id_usuario);


--
-- TOC entry 4943 (class 2606 OID 16796)
-- Name: prestamo prestamo_id_cuenta_desembolso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestamo
    ADD CONSTRAINT prestamo_id_cuenta_desembolso_fkey FOREIGN KEY (id_cuenta_desembolso) REFERENCES public.cuenta_bancaria(id_cuenta);


--
-- TOC entry 4944 (class 2606 OID 16791)
-- Name: prestamo prestamo_id_empresa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestamo
    ADD CONSTRAINT prestamo_id_empresa_fkey FOREIGN KEY (id_empresa) REFERENCES public.cliente_empresa(id_empresa);


--
-- TOC entry 4945 (class 2606 OID 16806)
-- Name: prestamo prestamo_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestamo
    ADD CONSTRAINT prestamo_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES public.estado_general(id_estado);


--
-- TOC entry 4946 (class 2606 OID 16786)
-- Name: prestamo prestamo_id_persona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestamo
    ADD CONSTRAINT prestamo_id_persona_fkey FOREIGN KEY (id_persona) REFERENCES public.cliente_person(id_persona);


--
-- TOC entry 4947 (class 2606 OID 16781)
-- Name: prestamo prestamo_id_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prestamo
    ADD CONSTRAINT prestamo_id_producto_fkey FOREIGN KEY (id_producto) REFERENCES public.producto_bancario(id_producto);


--
-- TOC entry 4948 (class 2606 OID 16830)
-- Name: transferencia transferencia_id_cuenta_destino_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transferencia
    ADD CONSTRAINT transferencia_id_cuenta_destino_fkey FOREIGN KEY (id_cuenta_destino) REFERENCES public.cuenta_bancaria(id_cuenta);


--
-- TOC entry 4949 (class 2606 OID 16825)
-- Name: transferencia transferencia_id_cuenta_origen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transferencia
    ADD CONSTRAINT transferencia_id_cuenta_origen_fkey FOREIGN KEY (id_cuenta_origen) REFERENCES public.cuenta_bancaria(id_cuenta);


--
-- TOC entry 4950 (class 2606 OID 16845)
-- Name: transferencia transferencia_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transferencia
    ADD CONSTRAINT transferencia_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES public.estado_general(id_estado);


--
-- TOC entry 4951 (class 2606 OID 16840)
-- Name: transferencia transferencia_id_usuario_aprobador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transferencia
    ADD CONSTRAINT transferencia_id_usuario_aprobador_fkey FOREIGN KEY (id_usuario_aprobador) REFERENCES public.usuario_sistema(id_usuario);


--
-- TOC entry 4952 (class 2606 OID 16835)
-- Name: transferencia transferencia_id_usuario_creador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transferencia
    ADD CONSTRAINT transferencia_id_usuario_creador_fkey FOREIGN KEY (id_usuario_creador) REFERENCES public.usuario_sistema(id_usuario);


--
-- TOC entry 4934 (class 2606 OID 16724)
-- Name: usuario_sistema usuario_sistema_id_empresa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_sistema
    ADD CONSTRAINT usuario_sistema_id_empresa_fkey FOREIGN KEY (id_empresa) REFERENCES public.cliente_empresa(id_empresa);


--
-- TOC entry 4935 (class 2606 OID 16729)
-- Name: usuario_sistema usuario_sistema_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_sistema
    ADD CONSTRAINT usuario_sistema_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES public.estado_general(id_estado);


--
-- TOC entry 4936 (class 2606 OID 16719)
-- Name: usuario_sistema usuario_sistema_id_persona_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_sistema
    ADD CONSTRAINT usuario_sistema_id_persona_fkey FOREIGN KEY (id_persona) REFERENCES public.cliente_person(id_persona);


--
-- TOC entry 4937 (class 2606 OID 16714)
-- Name: usuario_sistema usuario_sistema_id_rol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_sistema
    ADD CONSTRAINT usuario_sistema_id_rol_fkey FOREIGN KEY (id_rol) REFERENCES public.rol(id_rol);


-- Completed on 2026-03-01 11:39:19

--
-- PostgreSQL database dump complete
--

\unrestrict 3GSy5astwyqEguoeund2TrychbBICvcemH7BakSQjmSAMskIJgdkXYNS37fId8o

