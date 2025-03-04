--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 16.6 (Ubuntu 16.6-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: PopovK; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA "PopovK";


ALTER SCHEMA "PopovK" OWNER TO admin;

--
-- Name: albert; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA albert;


ALTER SCHEMA albert OWNER TO admin;

--
-- Name: anyaS; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA "anyaS";


ALTER SCHEMA "anyaS" OWNER TO admin;

--
-- Name: artem; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA artem;


ALTER SCHEMA artem OWNER TO admin;

--
-- Name: egor; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA egor;


ALTER SCHEMA egor OWNER TO admin;

--
-- Name: gosha; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA gosha;


ALTER SCHEMA gosha OWNER TO admin;

--
-- Name: igor; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA igor;


ALTER SCHEMA igor OWNER TO admin;

--
-- Name: matvey; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA matvey;


ALTER SCHEMA matvey OWNER TO admin;

--
-- Name: svetlana; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA svetlana;


ALTER SCHEMA svetlana OWNER TO admin;

--
-- Name: vebos; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA vebos;


ALTER SCHEMA vebos OWNER TO admin;

--
-- Name: yulya; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA yulya;


ALTER SCHEMA yulya OWNER TO admin;

--
-- Name: measurment_params_seq; Type: SEQUENCE; Schema: PopovK; Owner: admin
--

CREATE SEQUENCE "PopovK".measurment_params_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "PopovK".measurment_params_seq OWNER TO admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: measurement; Type: TABLE; Schema: PopovK; Owner: admin
--

CREATE TABLE "PopovK".measurement (
    id integer DEFAULT nextval('"PopovK".measurment_params_seq'::regclass) NOT NULL,
    measurement_type_id integer NOT NULL,
    measurement_batch_id integer NOT NULL,
    height numeric(8,2),
    temperature numeric(8,2),
    pressure numeric(8,2),
    windspeed numeric(8,2),
    winddirection numeric(8,2),
    speedbullet numeric(8,2)
);


ALTER TABLE "PopovK".measurement OWNER TO admin;

--
-- Name: measurement_batch_seq; Type: SEQUENCE; Schema: PopovK; Owner: admin
--

CREATE SEQUENCE "PopovK".measurement_batch_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "PopovK".measurement_batch_seq OWNER TO admin;

--
-- Name: measurement_batch; Type: TABLE; Schema: PopovK; Owner: admin
--

CREATE TABLE "PopovK".measurement_batch (
    id integer DEFAULT nextval('"PopovK".measurement_batch_seq'::regclass) NOT NULL,
    startperiod timestamp without time zone DEFAULT now(),
    positionx numeric(3,2),
    positiony numeric(3,2),
    username character varying(100)
);


ALTER TABLE "PopovK".measurement_batch OWNER TO admin;

--
-- Name: measurement_type; Type: TABLE; Schema: PopovK; Owner: admin
--

CREATE TABLE "PopovK".measurement_type (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE "PopovK".measurement_type OWNER TO admin;

--
-- Name: Batch; Type: TABLE; Schema: albert; Owner: admin
--

CREATE TABLE albert."Batch" (
    id integer NOT NULL,
    start_period timestamp without time zone DEFAULT now(),
    "positionX" numeric,
    "positionY" numeric(3,2),
    username character varying(100)
);


ALTER TABLE albert."Batch" OWNER TO admin;

--
-- Name: Type; Type: TABLE; Schema: albert; Owner: admin
--

CREATE TABLE albert."Type" (
    id integer NOT NULL,
    "Name" character varying(100)
);


ALTER TABLE albert."Type" OWNER TO admin;

--
-- Name: batch_seq; Type: SEQUENCE; Schema: albert; Owner: admin
--

CREATE SEQUENCE albert.batch_seq
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE albert.batch_seq OWNER TO admin;

--
-- Name: batch_seq; Type: SEQUENCE OWNED BY; Schema: albert; Owner: admin
--

ALTER SEQUENCE albert.batch_seq OWNED BY albert."Batch".id;


--
-- Name: measurment; Type: TABLE; Schema: albert; Owner: admin
--

CREATE TABLE albert.measurment (
    id integer NOT NULL,
    measurment_type_id integer NOT NULL,
    batch_id integer NOT NULL,
    "Height" numeric(8,2),
    "Temperature" numeric(8,2),
    "Pressure" numeric(8,2),
    "Wind_speed" numeric(8,2),
    "Wind_direction" numeric(8,2),
    "Bullet_speed" numeric(8,2)
);


ALTER TABLE albert.measurment OWNER TO admin;

--
-- Name: measurment_seq; Type: SEQUENCE; Schema: albert; Owner: admin
--

CREATE SEQUENCE albert.measurment_seq
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE albert.measurment_seq OWNER TO admin;

--
-- Name: measurment_seq; Type: SEQUENCE OWNED BY; Schema: albert; Owner: admin
--

ALTER SEQUENCE albert.measurment_seq OWNED BY albert.measurment.id;


--
-- Name: measurment_batch_seq; Type: SEQUENCE; Schema: anyaS; Owner: admin
--

CREATE SEQUENCE "anyaS".measurment_batch_seq
    START WITH 5
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "anyaS".measurment_batch_seq OWNER TO admin;

--
-- Name: measurment_batch; Type: TABLE; Schema: anyaS; Owner: admin
--

CREATE TABLE "anyaS".measurment_batch (
    id integer DEFAULT nextval('"anyaS".measurment_batch_seq'::regclass) NOT NULL,
    startperiod timestamp without time zone DEFAULT now(),
    positionx numeric,
    positiony numeric,
    username character varying(100)
);


ALTER TABLE "anyaS".measurment_batch OWNER TO admin;

--
-- Name: measurment_params_seq; Type: SEQUENCE; Schema: anyaS; Owner: admin
--

CREATE SEQUENCE "anyaS".measurment_params_seq
    START WITH 5
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "anyaS".measurment_params_seq OWNER TO admin;

--
-- Name: measurment_params; Type: TABLE; Schema: anyaS; Owner: admin
--

CREATE TABLE "anyaS".measurment_params (
    id integer DEFAULT nextval('"anyaS".measurment_params_seq'::regclass) NOT NULL,
    measurment_type_id integer NOT NULL,
    measurment_bath_id integer NOT NULL,
    height numeric,
    temperature numeric,
    pressure numeric,
    windspeed numeric,
    winddirection numeric,
    speedbullet numeric
);


ALTER TABLE "anyaS".measurment_params OWNER TO admin;

--
-- Name: measurment_type; Type: TABLE; Schema: anyaS; Owner: admin
--

CREATE TABLE "anyaS".measurment_type (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE "anyaS".measurment_type OWNER TO admin;

--
-- Name: measurment_batch; Type: TABLE; Schema: egor; Owner: admin
--

CREATE TABLE egor.measurment_batch (
    id integer NOT NULL,
    start_period timestamp without time zone DEFAULT now(),
    position_x numeric(3,2),
    position_y numeric(3,2),
    username character varying(100)
);


ALTER TABLE egor.measurment_batch OWNER TO admin;

--
-- Name: measurment_batch_seq; Type: SEQUENCE; Schema: egor; Owner: admin
--

CREATE SEQUENCE egor.measurment_batch_seq
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE egor.measurment_batch_seq OWNER TO admin;

--
-- Name: measurment_batch_seq; Type: SEQUENCE OWNED BY; Schema: egor; Owner: admin
--

ALTER SEQUENCE egor.measurment_batch_seq OWNED BY egor.measurment_batch.id;


--
-- Name: measurment_params; Type: TABLE; Schema: egor; Owner: admin
--

CREATE TABLE egor.measurment_params (
    id integer NOT NULL,
    measurment_type_id integer NOT NULL,
    measurment_batch_id integer NOT NULL,
    height numeric(8,2),
    temperature numeric(8,2),
    pressure numeric(8,2),
    wind_speed numeric(8,2),
    wind_direction numeric(8,2),
    bullet_speed numeric(8,2)
);


ALTER TABLE egor.measurment_params OWNER TO admin;

--
-- Name: measurment_params_seq; Type: SEQUENCE; Schema: egor; Owner: admin
--

CREATE SEQUENCE egor.measurment_params_seq
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE egor.measurment_params_seq OWNER TO admin;

--
-- Name: measurment_params_seq; Type: SEQUENCE OWNED BY; Schema: egor; Owner: admin
--

ALTER SEQUENCE egor.measurment_params_seq OWNED BY egor.measurment_params.id;


--
-- Name: measurment_type; Type: TABLE; Schema: egor; Owner: admin
--

CREATE TABLE egor.measurment_type (
    id integer NOT NULL,
    equip_type character varying(100)
);


ALTER TABLE egor.measurment_type OWNER TO admin;

--
-- Name: devices; Type: TABLE; Schema: gosha; Owner: admin
--

CREATE TABLE gosha.devices (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100)
);


ALTER TABLE gosha.devices OWNER TO admin;

--
-- Name: history; Type: TABLE; Schema: gosha; Owner: admin
--

CREATE TABLE gosha.history (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    input_id uuid NOT NULL,
    data timestamp with time zone DEFAULT now() NOT NULL,
    logitude numeric(4,2) NOT NULL,
    latitude numeric(4,2) NOT NULL,
    device_id uuid NOT NULL
);


ALTER TABLE gosha.history OWNER TO admin;

--
-- Name: inputs; Type: TABLE; Schema: gosha; Owner: admin
--

CREATE TABLE gosha.inputs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    height numeric(8,2) NOT NULL,
    temperature numeric(8,2) NOT NULL,
    pressure numeric(8,2) NOT NULL,
    wind_speed numeric(8,2) NOT NULL,
    wind_direction numeric(8,2) NOT NULL,
    bullet_speed numeric(8,2) NOT NULL
);


ALTER TABLE gosha.inputs OWNER TO admin;

--
-- Name: user; Type: TABLE; Schema: gosha; Owner: admin
--

CREATE TABLE gosha."user" (
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE gosha."user" OWNER TO admin;

--
-- Name: measurment_batch_seq; Type: SEQUENCE; Schema: igor; Owner: admin
--

CREATE SEQUENCE igor.measurment_batch_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE igor.measurment_batch_seq OWNER TO admin;

--
-- Name: measurment_batch; Type: TABLE; Schema: igor; Owner: admin
--

CREATE TABLE igor.measurment_batch (
    id integer DEFAULT nextval('igor.measurment_batch_seq'::regclass) NOT NULL,
    startperiod timestamp without time zone DEFAULT now(),
    positionx numeric(3,2),
    positiony numeric(3,2),
    username character varying(100)
);


ALTER TABLE igor.measurment_batch OWNER TO admin;

--
-- Name: measurment_params_seq; Type: SEQUENCE; Schema: igor; Owner: admin
--

CREATE SEQUENCE igor.measurment_params_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE igor.measurment_params_seq OWNER TO admin;

--
-- Name: measurment_params; Type: TABLE; Schema: igor; Owner: admin
--

CREATE TABLE igor.measurment_params (
    id integer DEFAULT nextval('igor.measurment_params_seq'::regclass) NOT NULL,
    measurment_type_id integer NOT NULL,
    measurment_bath_id integer NOT NULL,
    height numeric(8,2),
    temperature numeric(8,2),
    pressure numeric(8,2),
    windspeed numeric(8,2),
    winddirection numeric(8,2),
    speedbullet numeric(8,2)
);


ALTER TABLE igor.measurment_params OWNER TO admin;

--
-- Name: measurment_type; Type: TABLE; Schema: igor; Owner: admin
--

CREATE TABLE igor.measurment_type (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE igor.measurment_type OWNER TO admin;

--
-- Name: input_data; Type: TABLE; Schema: matvey; Owner: admin
--

CREATE TABLE matvey.input_data (
    type "char"[],
    temp bigint,
    height bigint,
    direction bigint,
    speed bigint,
    pressure bigint
);


ALTER TABLE matvey.input_data OWNER TO admin;

--
-- Name: measurement_batch; Type: TABLE; Schema: matvey; Owner: admin
--

CREATE TABLE matvey.measurement_batch (
    id integer NOT NULL,
    startperiod timestamp without time zone DEFAULT now(),
    positionx numeric(3,2),
    positiony numeric(3,2),
    username character varying(100)
);


ALTER TABLE matvey.measurement_batch OWNER TO admin;

--
-- Name: measurement_batch_seq; Type: SEQUENCE; Schema: matvey; Owner: admin
--

CREATE SEQUENCE matvey.measurement_batch_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE matvey.measurement_batch_seq OWNER TO admin;

--
-- Name: measurement_batch_seq; Type: SEQUENCE OWNED BY; Schema: matvey; Owner: admin
--

ALTER SEQUENCE matvey.measurement_batch_seq OWNED BY matvey.measurement_batch.id;


--
-- Name: measurement_params_seq; Type: SEQUENCE; Schema: matvey; Owner: admin
--

CREATE SEQUENCE matvey.measurement_params_seq
    START WITH 5
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE matvey.measurement_params_seq OWNER TO admin;

--
-- Name: measurement_params; Type: TABLE; Schema: matvey; Owner: admin
--

CREATE TABLE matvey.measurement_params (
    id integer DEFAULT nextval('matvey.measurement_params_seq'::regclass) NOT NULL,
    measurement_type_id integer NOT NULL,
    measurement_batch_id integer NOT NULL,
    height numeric(8,2),
    temperature numeric(8,2),
    pressure numeric(8,2),
    windspeed numeric(8,2),
    winddirection numeric(8,2),
    speedbullet numeric(8,2)
);


ALTER TABLE matvey.measurement_params OWNER TO admin;

--
-- Name: measurement_type; Type: TABLE; Schema: matvey; Owner: admin
--

CREATE TABLE matvey.measurement_type (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE matvey.measurement_type OWNER TO admin;

--
-- Name: batch_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.batch_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.batch_seq OWNER TO admin;

--
-- Name: measurement_params_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.measurement_params_seq
    START WITH 5
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.measurement_params_seq OWNER TO admin;

--
-- Name: measurment_batch; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.measurment_batch (
    id integer NOT NULL,
    startperiod timestamp without time zone DEFAULT now(),
    positionx numeric(3,2),
    positiony numeric(3,2),
    username character varying(100)
);


ALTER TABLE public.measurment_batch OWNER TO admin;

--
-- Name: measurment_batch_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.measurment_batch_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.measurment_batch_seq OWNER TO admin;

--
-- Name: measurment_batch_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.measurment_batch_seq OWNED BY public.measurment_batch.id;


--
-- Name: measurment_betch_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.measurment_betch_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.measurment_betch_seq OWNER TO admin;

--
-- Name: measurment_params_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.measurment_params_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.measurment_params_seq OWNER TO admin;

--
-- Name: measurment_params; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.measurment_params (
    id integer DEFAULT nextval('public.measurment_params_seq'::regclass) NOT NULL,
    measurment_type_id integer NOT NULL,
    measurment_bath_id integer NOT NULL,
    height numeric(8,2),
    temperature numeric(8,2),
    pressure numeric(8,2),
    windspeed numeric(8,2),
    winddirection numeric(8,2),
    speedbullet numeric(8,2)
);


ALTER TABLE public.measurment_params OWNER TO admin;

--
-- Name: measurment_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.measurment_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.measurment_seq OWNER TO admin;

--
-- Name: measurment_type; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.measurment_type (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE public.measurment_type OWNER TO admin;

--
-- Name: input_data; Type: TABLE; Schema: svetlana; Owner: admin
--

CREATE TABLE svetlana.input_data (
    height integer DEFAULT 100,
    temperature integer DEFAULT 15,
    pressure integer DEFAULT 750,
    wind_direction integer DEFAULT 0,
    wind_speed integer DEFAULT 0,
    range_of_demolition_bullets integer DEFAULT 0
);


ALTER TABLE svetlana.input_data OWNER TO admin;

--
-- Name: measurments_batch; Type: TABLE; Schema: svetlana; Owner: admin
--

CREATE TABLE svetlana.measurments_batch (
    id integer NOT NULL,
    startperiod timestamp without time zone DEFAULT now(),
    positionx numeric(3,2),
    positiony numeric(3,2),
    username character varying(100)
);


ALTER TABLE svetlana.measurments_batch OWNER TO admin;

--
-- Name: measurment_batch_seq; Type: SEQUENCE; Schema: svetlana; Owner: admin
--

CREATE SEQUENCE svetlana.measurment_batch_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE svetlana.measurment_batch_seq OWNER TO admin;

--
-- Name: measurment_batch_seq; Type: SEQUENCE OWNED BY; Schema: svetlana; Owner: admin
--

ALTER SEQUENCE svetlana.measurment_batch_seq OWNED BY svetlana.measurments_batch.id;


--
-- Name: measurment_params; Type: TABLE; Schema: svetlana; Owner: admin
--

CREATE TABLE svetlana.measurment_params (
    id integer DEFAULT 23 NOT NULL,
    measument_type_id integer DEFAULT 2 NOT NULL,
    measument_bath_id integer DEFAULT 1 NOT NULL,
    height numeric(8,2) DEFAULT 100,
    temperature numeric(8,2) DEFAULT 0,
    pressure numeric(8,2) DEFAULT 750,
    windspeed numeric(8,2) DEFAULT 14,
    winddirection numeric(8,2) DEFAULT 20,
    speedbullet numeric(8,2) DEFAULT 20
);


ALTER TABLE svetlana.measurment_params OWNER TO admin;

--
-- Name: measurment_type; Type: TABLE; Schema: svetlana; Owner: admin
--

CREATE TABLE svetlana.measurment_type (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE svetlana.measurment_type OWNER TO admin;

--
-- Name: measurement_history; Type: TABLE; Schema: vebos; Owner: admin
--

CREATE TABLE vebos.measurement_history (
    id integer NOT NULL,
    start_period timestamp without time zone DEFAULT now(),
    position_x numeric(3,2),
    position_y numeric(3,2),
    username character varying(100)
);


ALTER TABLE vebos.measurement_history OWNER TO admin;

--
-- Name: measure_history; Type: SEQUENCE; Schema: vebos; Owner: admin
--

CREATE SEQUENCE vebos.measure_history
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE vebos.measure_history OWNER TO admin;

--
-- Name: measure_history; Type: SEQUENCE OWNED BY; Schema: vebos; Owner: admin
--

ALTER SEQUENCE vebos.measure_history OWNED BY vebos.measurement_history.id;


--
-- Name: measurement_params; Type: TABLE; Schema: vebos; Owner: admin
--

CREATE TABLE vebos.measurement_params (
    id integer NOT NULL,
    measurement_type_id integer NOT NULL,
    measurement_history_id integer NOT NULL,
    height numeric(8,2) DEFAULT 100,
    temperature numeric(8,2) DEFAULT 15,
    pressure numeric(8,2) DEFAULT 750,
    wind_speed numeric(8,2) DEFAULT 0,
    wind_direction numeric(8,2) DEFAULT 0,
    bullet_speed numeric(8,2)
);


ALTER TABLE vebos.measurement_params OWNER TO admin;

--
-- Name: measure_params_seq; Type: SEQUENCE; Schema: vebos; Owner: admin
--

CREATE SEQUENCE vebos.measure_params_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE vebos.measure_params_seq OWNER TO admin;

--
-- Name: measure_params_seq; Type: SEQUENCE OWNED BY; Schema: vebos; Owner: admin
--

ALTER SEQUENCE vebos.measure_params_seq OWNED BY vebos.measurement_params.id;


--
-- Name: measurement_table; Type: TABLE; Schema: vebos; Owner: admin
--

CREATE TABLE vebos.measurement_table (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE vebos.measurement_table OWNER TO admin;

--
-- Name: input_data; Type: TABLE; Schema: yulya; Owner: admin
--

CREATE TABLE yulya.input_data (
    temperature integer DEFAULT 15,
    height integer DEFAULT 100,
    pressure integer DEFAULT 750,
    wind_direction integer DEFAULT 0,
    wind_speed integer DEFAULT 0,
    range_of_demolition_bullets integer DEFAULT 0
);


ALTER TABLE yulya.input_data OWNER TO admin;

--
-- Name: measurment; Type: TABLE; Schema: yulya; Owner: admin
--

CREATE TABLE yulya.measurment (
    id integer NOT NULL,
    username character varying(100)
);


ALTER TABLE yulya.measurment OWNER TO admin;

--
-- Name: measurment_betch; Type: TABLE; Schema: yulya; Owner: admin
--

CREATE TABLE yulya.measurment_betch (
    id integer NOT NULL,
    startperiod timestamp without time zone DEFAULT now(),
    positionx numeric(3,2),
    positiony numeric(3,2),
    username character varying(100)
);


ALTER TABLE yulya.measurment_betch OWNER TO admin;

--
-- Name: measurment_betch_seq; Type: SEQUENCE; Schema: yulya; Owner: admin
--

CREATE SEQUENCE yulya.measurment_betch_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE yulya.measurment_betch_seq OWNER TO admin;

--
-- Name: measurment_betch_seq; Type: SEQUENCE OWNED BY; Schema: yulya; Owner: admin
--

ALTER SEQUENCE yulya.measurment_betch_seq OWNED BY yulya.measurment_betch.id;


--
-- Name: measurment_params; Type: TABLE; Schema: yulya; Owner: admin
--

CREATE TABLE yulya.measurment_params (
    id integer NOT NULL,
    measurment_type_id integer DEFAULT 1 NOT NULL,
    measurment_betch_id integer DEFAULT 1 NOT NULL,
    height numeric(8,2) DEFAULT 100,
    temperature numeric(8,2) DEFAULT 15,
    pressure numeric(8,2) DEFAULT 750,
    wind_speed numeric(8,2) DEFAULT 14,
    wind_direction numeric(8,2) DEFAULT 20,
    range_of_demolition_bullet numeric(8,2) DEFAULT 20
);


ALTER TABLE yulya.measurment_params OWNER TO admin;

--
-- Name: measurment_params_seq; Type: SEQUENCE; Schema: yulya; Owner: admin
--

CREATE SEQUENCE yulya.measurment_params_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE yulya.measurment_params_seq OWNER TO admin;

--
-- Name: measurment_params_seq; Type: SEQUENCE OWNED BY; Schema: yulya; Owner: admin
--

ALTER SEQUENCE yulya.measurment_params_seq OWNED BY yulya.measurment_params.id;


--
-- Name: Batch id; Type: DEFAULT; Schema: albert; Owner: admin
--

ALTER TABLE ONLY albert."Batch" ALTER COLUMN id SET DEFAULT nextval('albert.batch_seq'::regclass);


--
-- Name: measurment id; Type: DEFAULT; Schema: albert; Owner: admin
--

ALTER TABLE ONLY albert.measurment ALTER COLUMN id SET DEFAULT nextval('albert.measurment_seq'::regclass);


--
-- Name: measurement_batch id; Type: DEFAULT; Schema: matvey; Owner: admin
--

ALTER TABLE ONLY matvey.measurement_batch ALTER COLUMN id SET DEFAULT nextval('matvey.measurement_batch_seq'::regclass);


--
-- Name: measurment_batch id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.measurment_batch ALTER COLUMN id SET DEFAULT nextval('public.measurment_batch_seq'::regclass);


--
-- Name: measurement_history id; Type: DEFAULT; Schema: vebos; Owner: admin
--

ALTER TABLE ONLY vebos.measurement_history ALTER COLUMN id SET DEFAULT nextval('vebos.measure_history'::regclass);


--
-- Name: measurement_params id; Type: DEFAULT; Schema: vebos; Owner: admin
--

ALTER TABLE ONLY vebos.measurement_params ALTER COLUMN id SET DEFAULT nextval('vebos.measure_params_seq'::regclass);


--
-- Name: measurment_betch id; Type: DEFAULT; Schema: yulya; Owner: admin
--

ALTER TABLE ONLY yulya.measurment_betch ALTER COLUMN id SET DEFAULT nextval('yulya.measurment_betch_seq'::regclass);


--
-- Name: measurment_params id; Type: DEFAULT; Schema: yulya; Owner: admin
--

ALTER TABLE ONLY yulya.measurment_params ALTER COLUMN id SET DEFAULT nextval('yulya.measurment_params_seq'::regclass);


--
-- Data for Name: measurement; Type: TABLE DATA; Schema: PopovK; Owner: admin
--

COPY "PopovK".measurement (id, measurement_type_id, measurement_batch_id, height, temperature, pressure, windspeed, winddirection, speedbullet) FROM stdin;
1	1	1	30.34	15.60	767.00	4.70	2.00	345.00
2	2	2	10.34	18.60	776.00	7.70	5.00	745.00
\.


--
-- Data for Name: measurement_batch; Type: TABLE DATA; Schema: PopovK; Owner: admin
--

COPY "PopovK".measurement_batch (id, startperiod, positionx, positiony, username) FROM stdin;
1	2025-01-31 10:20:00	2.50	2.60	Potatov
2	2025-01-31 10:30:00	7.50	1.60	Tomatov
\.


--
-- Data for Name: measurement_type; Type: TABLE DATA; Schema: PopovK; Owner: admin
--

COPY "PopovK".measurement_type (id, name) FROM stdin;
1	ДМК
2	ВР
\.


--
-- Data for Name: Batch; Type: TABLE DATA; Schema: albert; Owner: admin
--

COPY albert."Batch" (id, start_period, "positionX", "positionY", username) FROM stdin;
1	2025-01-31 02:34:47.196165	1.6	1.90	soldier1
2	2025-01-31 02:34:47.196165	3.6	5.90	soldier2
\.


--
-- Data for Name: Type; Type: TABLE DATA; Schema: albert; Owner: admin
--

COPY albert."Type" (id, "Name") FROM stdin;
1	ДМК
2	ВР
\.


--
-- Data for Name: measurment; Type: TABLE DATA; Schema: albert; Owner: admin
--

COPY albert.measurment (id, measurment_type_id, batch_id, "Height", "Temperature", "Pressure", "Wind_speed", "Wind_direction", "Bullet_speed") FROM stdin;
1	1	1	100.00	15.00	750.00	0.00	0.00	\N
2	2	2	100.00	15.00	750.00	0.00	\N	45.00
\.


--
-- Data for Name: measurment_batch; Type: TABLE DATA; Schema: anyaS; Owner: admin
--

COPY "anyaS".measurment_batch (id, startperiod, positionx, positiony, username) FROM stdin;
2	2025-01-31 10:20:00	1	2	name
1	2025-01-31 10:40:00	1	5	name2
5	2025-01-31 03:30:46.637482	\N	\N	valex
\.


--
-- Data for Name: measurment_params; Type: TABLE DATA; Schema: anyaS; Owner: admin
--

COPY "anyaS".measurment_params (id, measurment_type_id, measurment_bath_id, height, temperature, pressure, windspeed, winddirection, speedbullet) FROM stdin;
1	1	1	100	12	790	35	1	23
2	1	1	100	12	790	35	1	23
\.


--
-- Data for Name: measurment_type; Type: TABLE DATA; Schema: anyaS; Owner: admin
--

COPY "anyaS".measurment_type (id, name) FROM stdin;
1	ДМК
2	Ружье
\.


--
-- Data for Name: measurment_batch; Type: TABLE DATA; Schema: egor; Owner: admin
--

COPY egor.measurment_batch (id, start_period, position_x, position_y, username) FROM stdin;
1	2025-01-31 10:20:00	6.00	5.00	Ivan
2	2025-02-15 10:20:00	9.00	8.00	Tom
\.


--
-- Data for Name: measurment_params; Type: TABLE DATA; Schema: egor; Owner: admin
--

COPY egor.measurment_params (id, measurment_type_id, measurment_batch_id, height, temperature, pressure, wind_speed, wind_direction, bullet_speed) FROM stdin;
1	1	1	100.00	15.00	750.00	0.00	0.00	0.00
2	2	2	100.00	12.00	34.00	0.00	0.20	45.00
\.


--
-- Data for Name: measurment_type; Type: TABLE DATA; Schema: egor; Owner: admin
--

COPY egor.measurment_type (id, equip_type) FROM stdin;
1	ДМК
2	ВР
\.


--
-- Data for Name: devices; Type: TABLE DATA; Schema: gosha; Owner: admin
--

COPY gosha.devices (id, name) FROM stdin;
62322ef0-d836-407b-87d9-2b619597d405	ВМ
fe50f5eb-9632-4e4e-9bce-aba7edd29a83	ДМК
\.


--
-- Data for Name: history; Type: TABLE DATA; Schema: gosha; Owner: admin
--

COPY gosha.history (id, user_id, input_id, data, logitude, latitude, device_id) FROM stdin;
a5195e5e-6c4a-4b0f-8d92-1363633d5af0	653ac021-0dbd-4564-8cdc-fb206fee0bd8	e094646b-571f-40e0-91fb-c6cfdfac57f9	2025-01-31 02:17:30.611947+00	3.00	3.00	62322ef0-d836-407b-87d9-2b619597d405
\.


--
-- Data for Name: inputs; Type: TABLE DATA; Schema: gosha; Owner: admin
--

COPY gosha.inputs (id, height, temperature, pressure, wind_speed, wind_direction, bullet_speed) FROM stdin;
e094646b-571f-40e0-91fb-c6cfdfac57f9	100.00	24.50	750.00	5.00	0.20	450.00
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: gosha; Owner: admin
--

COPY gosha."user" (id) FROM stdin;
653ac021-0dbd-4564-8cdc-fb206fee0bd8
\.


--
-- Data for Name: measurment_batch; Type: TABLE DATA; Schema: igor; Owner: admin
--

COPY igor.measurment_batch (id, startperiod, positionx, positiony, username) FROM stdin;
1	2025-01-31 02:15:40.734814	3.00	2.00	Igor
2	2025-01-31 03:22:18.441795	\N	\N	valex
\.


--
-- Data for Name: measurment_params; Type: TABLE DATA; Schema: igor; Owner: admin
--

COPY igor.measurment_params (id, measurment_type_id, measurment_bath_id, height, temperature, pressure, windspeed, winddirection, speedbullet) FROM stdin;
2	1	1	100.00	20.00	12.00	21.00	8.00	\N
\.


--
-- Data for Name: measurment_type; Type: TABLE DATA; Schema: igor; Owner: admin
--

COPY igor.measurment_type (id, name) FROM stdin;
1	ДМК
2	BP
\.


--
-- Data for Name: input_data; Type: TABLE DATA; Schema: matvey; Owner: admin
--

COPY matvey.input_data (type, temp, height, direction, speed, pressure) FROM stdin;
\.


--
-- Data for Name: measurement_batch; Type: TABLE DATA; Schema: matvey; Owner: admin
--

COPY matvey.measurement_batch (id, startperiod, positionx, positiony, username) FROM stdin;
1	2025-01-31 10:20:00	1.00	1.00	matvey
2	2025-01-31 10:20:00	1.00	1.00	matvey
3	2025-01-31 03:36:53.154426	\N	\N	mmm
\.


--
-- Data for Name: measurement_params; Type: TABLE DATA; Schema: matvey; Owner: admin
--

COPY matvey.measurement_params (id, measurement_type_id, measurement_batch_id, height, temperature, pressure, windspeed, winddirection, speedbullet) FROM stdin;
1	1	1	100.00	12.00	34.00	45.00	0.20	0.00
2	2	2	100.00	12.00	34.00	0.00	0.20	0.00
\.


--
-- Data for Name: measurement_type; Type: TABLE DATA; Schema: matvey; Owner: admin
--

COPY matvey.measurement_type (id, name) FROM stdin;
1	ДМК
2	ВР
\.


--
-- Data for Name: measurment_batch; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.measurment_batch (id, startperiod, positionx, positiony, username) FROM stdin;
1	2025-01-31 03:17:42.075059	\N	\N	valex
2	2025-01-31 03:18:11.045871	\N	\N	valex
\.


--
-- Data for Name: measurment_params; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.measurment_params (id, measurment_type_id, measurment_bath_id, height, temperature, pressure, windspeed, winddirection, speedbullet) FROM stdin;
\.


--
-- Data for Name: measurment_type; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.measurment_type (id, name) FROM stdin;
\.


--
-- Data for Name: input_data; Type: TABLE DATA; Schema: svetlana; Owner: admin
--

COPY svetlana.input_data (height, temperature, pressure, wind_direction, wind_speed, range_of_demolition_bullets) FROM stdin;
100	15	750	0	0	0
\.


--
-- Data for Name: measurment_params; Type: TABLE DATA; Schema: svetlana; Owner: admin
--

COPY svetlana.measurment_params (id, measument_type_id, measument_bath_id, height, temperature, pressure, windspeed, winddirection, speedbullet) FROM stdin;
23	2	1	100.00	0.00	750.00	14.00	20.00	20.00
\.


--
-- Data for Name: measurment_type; Type: TABLE DATA; Schema: svetlana; Owner: admin
--

COPY svetlana.measurment_type (id, name) FROM stdin;
1	ДМК
\.


--
-- Data for Name: measurments_batch; Type: TABLE DATA; Schema: svetlana; Owner: admin
--

COPY svetlana.measurments_batch (id, startperiod, positionx, positiony, username) FROM stdin;
1	2025-01-31 10:20:00	2.21	3.20	user_1
\.


--
-- Data for Name: measurement_history; Type: TABLE DATA; Schema: vebos; Owner: admin
--

COPY vebos.measurement_history (id, start_period, position_x, position_y, username) FROM stdin;
1	2025-01-31 10:20:00	\N	\N	ole
2	2025-01-31 11:20:00	\N	\N	ole
3	2025-01-31 11:24:00	\N	\N	olena
\.


--
-- Data for Name: measurement_params; Type: TABLE DATA; Schema: vebos; Owner: admin
--

COPY vebos.measurement_params (id, measurement_type_id, measurement_history_id, height, temperature, pressure, wind_speed, wind_direction, bullet_speed) FROM stdin;
1	1	1	100.00	15.00	75.00	15.00	15.00	10.00
2	2	1	100.00	16.00	72.00	14.00	15.00	10.00
3	2	1	100.00	14.00	72.00	14.00	25.00	10.00
\.


--
-- Data for Name: measurement_table; Type: TABLE DATA; Schema: vebos; Owner: admin
--

COPY vebos.measurement_table (id, name) FROM stdin;
1	ДМК
2	ВР
\.


--
-- Data for Name: input_data; Type: TABLE DATA; Schema: yulya; Owner: admin
--

COPY yulya.input_data (temperature, height, pressure, wind_direction, wind_speed, range_of_demolition_bullets) FROM stdin;
15	100	750	2	3	1
\.


--
-- Data for Name: measurment; Type: TABLE DATA; Schema: yulya; Owner: admin
--

COPY yulya.measurment (id, username) FROM stdin;
1	ДМК
\.


--
-- Data for Name: measurment_betch; Type: TABLE DATA; Schema: yulya; Owner: admin
--

COPY yulya.measurment_betch (id, startperiod, positionx, positiony, username) FROM stdin;
1	2025-01-31 10:20:00	2.12	3.10	user_1
5	2025-01-31 03:35:16.76184	\N	\N	user_2
6	2025-01-31 03:35:26.039122	\N	\N	user_2
\.


--
-- Data for Name: measurment_params; Type: TABLE DATA; Schema: yulya; Owner: admin
--

COPY yulya.measurment_params (id, measurment_type_id, measurment_betch_id, height, temperature, pressure, wind_speed, wind_direction, range_of_demolition_bullet) FROM stdin;
1	1	1	100.00	15.00	750.00	2.01	3.07	1.00
\.


--
-- Name: measurement_batch_seq; Type: SEQUENCE SET; Schema: PopovK; Owner: admin
--

SELECT pg_catalog.setval('"PopovK".measurement_batch_seq', 1, false);


--
-- Name: measurment_params_seq; Type: SEQUENCE SET; Schema: PopovK; Owner: admin
--

SELECT pg_catalog.setval('"PopovK".measurment_params_seq', 1, false);


--
-- Name: batch_seq; Type: SEQUENCE SET; Schema: albert; Owner: admin
--

SELECT pg_catalog.setval('albert.batch_seq', 3, false);


--
-- Name: measurment_seq; Type: SEQUENCE SET; Schema: albert; Owner: admin
--

SELECT pg_catalog.setval('albert.measurment_seq', 3, false);


--
-- Name: measurment_batch_seq; Type: SEQUENCE SET; Schema: anyaS; Owner: admin
--

SELECT pg_catalog.setval('"anyaS".measurment_batch_seq', 5, true);


--
-- Name: measurment_params_seq; Type: SEQUENCE SET; Schema: anyaS; Owner: admin
--

SELECT pg_catalog.setval('"anyaS".measurment_params_seq', 5, false);


--
-- Name: measurment_batch_seq; Type: SEQUENCE SET; Schema: egor; Owner: admin
--

SELECT pg_catalog.setval('egor.measurment_batch_seq', 3, false);


--
-- Name: measurment_params_seq; Type: SEQUENCE SET; Schema: egor; Owner: admin
--

SELECT pg_catalog.setval('egor.measurment_params_seq', 3, false);


--
-- Name: measurment_batch_seq; Type: SEQUENCE SET; Schema: igor; Owner: admin
--

SELECT pg_catalog.setval('igor.measurment_batch_seq', 2, true);


--
-- Name: measurment_params_seq; Type: SEQUENCE SET; Schema: igor; Owner: admin
--

SELECT pg_catalog.setval('igor.measurment_params_seq', 1, false);


--
-- Name: measurement_batch_seq; Type: SEQUENCE SET; Schema: matvey; Owner: admin
--

SELECT pg_catalog.setval('matvey.measurement_batch_seq', 3, true);


--
-- Name: measurement_params_seq; Type: SEQUENCE SET; Schema: matvey; Owner: admin
--

SELECT pg_catalog.setval('matvey.measurement_params_seq', 5, false);


--
-- Name: batch_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.batch_seq', 1, false);


--
-- Name: measurement_params_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.measurement_params_seq', 5, false);


--
-- Name: measurment_batch_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.measurment_batch_seq', 2, true);


--
-- Name: measurment_betch_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.measurment_betch_seq', 1, false);


--
-- Name: measurment_params_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.measurment_params_seq', 1, false);


--
-- Name: measurment_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.measurment_seq', 1, false);


--
-- Name: measurment_batch_seq; Type: SEQUENCE SET; Schema: svetlana; Owner: admin
--

SELECT pg_catalog.setval('svetlana.measurment_batch_seq', 2, true);


--
-- Name: measure_history; Type: SEQUENCE SET; Schema: vebos; Owner: admin
--

SELECT pg_catalog.setval('vebos.measure_history', 3, true);


--
-- Name: measure_params_seq; Type: SEQUENCE SET; Schema: vebos; Owner: admin
--

SELECT pg_catalog.setval('vebos.measure_params_seq', 3, true);


--
-- Name: measurment_betch_seq; Type: SEQUENCE SET; Schema: yulya; Owner: admin
--

SELECT pg_catalog.setval('yulya.measurment_betch_seq', 6, true);


--
-- Name: measurment_params_seq; Type: SEQUENCE SET; Schema: yulya; Owner: admin
--

SELECT pg_catalog.setval('yulya.measurment_params_seq', 1, false);


--
-- Name: measurement_batch measurement_batch_pkey; Type: CONSTRAINT; Schema: PopovK; Owner: admin
--

ALTER TABLE ONLY "PopovK".measurement_batch
    ADD CONSTRAINT measurement_batch_pkey PRIMARY KEY (id);


--
-- Name: measurement measurement_pkey; Type: CONSTRAINT; Schema: PopovK; Owner: admin
--

ALTER TABLE ONLY "PopovK".measurement
    ADD CONSTRAINT measurement_pkey PRIMARY KEY (id);


--
-- Name: measurement_type measurement_type_pkey; Type: CONSTRAINT; Schema: PopovK; Owner: admin
--

ALTER TABLE ONLY "PopovK".measurement_type
    ADD CONSTRAINT measurement_type_pkey PRIMARY KEY (id);


--
-- Name: Batch History_pkey; Type: CONSTRAINT; Schema: albert; Owner: admin
--

ALTER TABLE ONLY albert."Batch"
    ADD CONSTRAINT "History_pkey" PRIMARY KEY (id);


--
-- Name: Type Type_pkey; Type: CONSTRAINT; Schema: albert; Owner: admin
--

ALTER TABLE ONLY albert."Type"
    ADD CONSTRAINT "Type_pkey" PRIMARY KEY (id);


--
-- Name: measurment measurment_pkey; Type: CONSTRAINT; Schema: albert; Owner: admin
--

ALTER TABLE ONLY albert.measurment
    ADD CONSTRAINT measurment_pkey PRIMARY KEY (id);


--
-- Name: measurment_batch measurment_batch_pkey; Type: CONSTRAINT; Schema: anyaS; Owner: admin
--

ALTER TABLE ONLY "anyaS".measurment_batch
    ADD CONSTRAINT measurment_batch_pkey PRIMARY KEY (id);


--
-- Name: measurment_params measurment_params_pkey; Type: CONSTRAINT; Schema: anyaS; Owner: admin
--

ALTER TABLE ONLY "anyaS".measurment_params
    ADD CONSTRAINT measurment_params_pkey PRIMARY KEY (id);


--
-- Name: measurment_type measurment_type_pkey; Type: CONSTRAINT; Schema: anyaS; Owner: admin
--

ALTER TABLE ONLY "anyaS".measurment_type
    ADD CONSTRAINT measurment_type_pkey PRIMARY KEY (id);


--
-- Name: measurment_batch batch_pkey; Type: CONSTRAINT; Schema: egor; Owner: admin
--

ALTER TABLE ONLY egor.measurment_batch
    ADD CONSTRAINT batch_pkey PRIMARY KEY (id);


--
-- Name: measurment_params measument_param_pkey; Type: CONSTRAINT; Schema: egor; Owner: admin
--

ALTER TABLE ONLY egor.measurment_params
    ADD CONSTRAINT measument_param_pkey PRIMARY KEY (id);


--
-- Name: measurment_type measument_table_pkey; Type: CONSTRAINT; Schema: egor; Owner: admin
--

ALTER TABLE ONLY egor.measurment_type
    ADD CONSTRAINT measument_table_pkey PRIMARY KEY (id);


--
-- Name: history history_pkey; Type: CONSTRAINT; Schema: gosha; Owner: admin
--

ALTER TABLE ONLY gosha.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (id);


--
-- Name: inputs inputs_pkey; Type: CONSTRAINT; Schema: gosha; Owner: admin
--

ALTER TABLE ONLY gosha.inputs
    ADD CONSTRAINT inputs_pkey PRIMARY KEY (id);


--
-- Name: devices meassures_pkey; Type: CONSTRAINT; Schema: gosha; Owner: admin
--

ALTER TABLE ONLY gosha.devices
    ADD CONSTRAINT meassures_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: gosha; Owner: admin
--

ALTER TABLE ONLY gosha."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: measurment_batch measurment_batch_pkey; Type: CONSTRAINT; Schema: igor; Owner: admin
--

ALTER TABLE ONLY igor.measurment_batch
    ADD CONSTRAINT measurment_batch_pkey PRIMARY KEY (id);


--
-- Name: measurment_params measurment_params_pkey; Type: CONSTRAINT; Schema: igor; Owner: admin
--

ALTER TABLE ONLY igor.measurment_params
    ADD CONSTRAINT measurment_params_pkey PRIMARY KEY (id);


--
-- Name: measurment_type measurment_type_pkey; Type: CONSTRAINT; Schema: igor; Owner: admin
--

ALTER TABLE ONLY igor.measurment_type
    ADD CONSTRAINT measurment_type_pkey PRIMARY KEY (id);


--
-- Name: measurement_batch measurement_batch_pkey; Type: CONSTRAINT; Schema: matvey; Owner: admin
--

ALTER TABLE ONLY matvey.measurement_batch
    ADD CONSTRAINT measurement_batch_pkey PRIMARY KEY (id);


--
-- Name: measurement_params measurement_params_pkey; Type: CONSTRAINT; Schema: matvey; Owner: admin
--

ALTER TABLE ONLY matvey.measurement_params
    ADD CONSTRAINT measurement_params_pkey PRIMARY KEY (id);


--
-- Name: measurement_type measurement_type_pkey; Type: CONSTRAINT; Schema: matvey; Owner: admin
--

ALTER TABLE ONLY matvey.measurement_type
    ADD CONSTRAINT measurement_type_pkey PRIMARY KEY (id);


--
-- Name: measurment_batch measurment_batch_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.measurment_batch
    ADD CONSTRAINT measurment_batch_pkey PRIMARY KEY (id);


--
-- Name: measurment_params measurment_params_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.measurment_params
    ADD CONSTRAINT measurment_params_pkey PRIMARY KEY (id);


--
-- Name: measurment_type measurment_type_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.measurment_type
    ADD CONSTRAINT measurment_type_pkey PRIMARY KEY (id);


--
-- Name: measurments_batch batch_pkey; Type: CONSTRAINT; Schema: svetlana; Owner: admin
--

ALTER TABLE ONLY svetlana.measurments_batch
    ADD CONSTRAINT batch_pkey PRIMARY KEY (id);


--
-- Name: measurment_type data_variance_pkey; Type: CONSTRAINT; Schema: svetlana; Owner: admin
--

ALTER TABLE ONLY svetlana.measurment_type
    ADD CONSTRAINT data_variance_pkey PRIMARY KEY (id);


--
-- Name: measurment_params params_pkey; Type: CONSTRAINT; Schema: svetlana; Owner: admin
--

ALTER TABLE ONLY svetlana.measurment_params
    ADD CONSTRAINT params_pkey PRIMARY KEY (id);


--
-- Name: measurement_history measurement_history_pkey; Type: CONSTRAINT; Schema: vebos; Owner: admin
--

ALTER TABLE ONLY vebos.measurement_history
    ADD CONSTRAINT measurement_history_pkey PRIMARY KEY (id);


--
-- Name: measurement_params measurement_params_pkey; Type: CONSTRAINT; Schema: vebos; Owner: admin
--

ALTER TABLE ONLY vebos.measurement_params
    ADD CONSTRAINT measurement_params_pkey PRIMARY KEY (id);


--
-- Name: measurement_table measurement_table_pkey; Type: CONSTRAINT; Schema: vebos; Owner: admin
--

ALTER TABLE ONLY vebos.measurement_table
    ADD CONSTRAINT measurement_table_pkey PRIMARY KEY (id);


--
-- Name: measurment_betch measurment_betch_pkey; Type: CONSTRAINT; Schema: yulya; Owner: admin
--

ALTER TABLE ONLY yulya.measurment_betch
    ADD CONSTRAINT measurment_betch_pkey PRIMARY KEY (id);


--
-- Name: measurment_params measurment_params_pkey; Type: CONSTRAINT; Schema: yulya; Owner: admin
--

ALTER TABLE ONLY yulya.measurment_params
    ADD CONSTRAINT measurment_params_pkey PRIMARY KEY (id);


--
-- Name: measurment measurment_pkey; Type: CONSTRAINT; Schema: yulya; Owner: admin
--

ALTER TABLE ONLY yulya.measurment
    ADD CONSTRAINT measurment_pkey PRIMARY KEY (id);


--
-- Name: history devices; Type: FK CONSTRAINT; Schema: gosha; Owner: admin
--

ALTER TABLE ONLY gosha.history
    ADD CONSTRAINT devices FOREIGN KEY (device_id) REFERENCES gosha.devices(id) NOT VALID;


--
-- Name: history inputs; Type: FK CONSTRAINT; Schema: gosha; Owner: admin
--

ALTER TABLE ONLY gosha.history
    ADD CONSTRAINT inputs FOREIGN KEY (input_id) REFERENCES gosha.inputs(id);


--
-- Name: history users; Type: FK CONSTRAINT; Schema: gosha; Owner: admin
--

ALTER TABLE ONLY gosha.history
    ADD CONSTRAINT users FOREIGN KEY (user_id) REFERENCES gosha."user"(id);


--
-- PostgreSQL database dump complete
--

