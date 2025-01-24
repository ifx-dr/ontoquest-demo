--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1 (OnGres 16.1-build-6.31)
-- Dumped by pg_dump version 16.4

-- Started on 2025-01-24 18:41:37

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
-- TOC entry 7 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA IF NOT EXISTS public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3521 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 305 (class 1255 OID 16469)
-- Name: df(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION IF NOT EXISTS public.df(path text) RETURNS SETOF text
    LANGUAGE plpython3u
    AS $$
  import subprocess
  try:
    result = subprocess.run(['df', '-B1', '--output=source,target,fstype,size,avail,itotal,iavail', path], timeout=1, stdout=subprocess.PIPE, stderr=subprocess.PIPE, encoding='UTF-8')
  except:
    return ['- ' + path + ' - - - - - timeout']
  if result.returncode == 0:
    return result.stdout.split('\n')[1:2]
  else:
    return ['- ' + path + ' - - - - - ' + result.stderr.replace(' ', '\\s')]
$$;


ALTER FUNCTION public.df(path text) OWNER TO postgres;

--
-- TOC entry 306 (class 1255 OID 16470)
-- Name: mounts(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.mounts() RETURNS SETOF text
    LANGUAGE plpython3u
    AS $$
  import subprocess
  return subprocess.run(['cat', '/proc/mounts'], stdout=subprocess.PIPE, encoding='UTF-8').stdout.split('\n')
$$;


ALTER FUNCTION public.mounts() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 231 (class 1259 OID 16850)
-- Name: challenges; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.challenges (
    id integer NOT NULL,
    challenge character varying(10000),
    xp_reward integer,
    name character varying(10000)
);


ALTER TABLE public.challenges OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16849)
-- Name: challenges_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.challenges_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.challenges_id_seq OWNER TO postgres;

--
-- TOC entry 3522 (class 0 OID 0)
-- Dependencies: 230
-- Name: challenges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.challenges_id_seq OWNED BY public.challenges.id;


--
-- TOC entry 243 (class 1259 OID 16917)
-- Name: definition_scores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.definition_scores (
    id integer NOT NULL,
    class_name character varying(150),
    definition character varying(10000),
    score double precision,
    agreements integer,
    disagreements integer,
    latest_review integer,
    split_review boolean,
    is_default boolean
);


ALTER TABLE public.definition_scores OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 16916)
-- Name: definition_scores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.definition_scores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.definition_scores_id_seq OWNER TO postgres;

--
-- TOC entry 3523 (class 0 OID 0)
-- Dependencies: 242
-- Name: definition_scores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.definition_scores_id_seq OWNED BY public.definition_scores.id;


--
-- TOC entry 225 (class 1259 OID 16816)
-- Name: department_ontology_association; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department_ontology_association (
    id integer NOT NULL,
    department character varying(150) NOT NULL,
    ontology_id integer NOT NULL
);


ALTER TABLE public.department_ontology_association OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16814)
-- Name: department_ontology_association_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.department_ontology_association_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.department_ontology_association_id_seq OWNER TO postgres;

--
-- TOC entry 3524 (class 0 OID 0)
-- Dependencies: 223
-- Name: department_ontology_association_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.department_ontology_association_id_seq OWNED BY public.department_ontology_association.id;


--
-- TOC entry 224 (class 1259 OID 16815)
-- Name: department_ontology_association_ontology_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.department_ontology_association_ontology_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.department_ontology_association_ontology_id_seq OWNER TO postgres;

--
-- TOC entry 3525 (class 0 OID 0)
-- Dependencies: 224
-- Name: department_ontology_association_ontology_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.department_ontology_association_ontology_id_seq OWNED BY public.department_ontology_association.ontology_id;


--
-- TOC entry 249 (class 1259 OID 16943)
-- Name: extended_user_definitions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.extended_user_definitions (
    id integer NOT NULL,
    profile_id integer NOT NULL,
    profile_class character varying(150),
    profile_definition character varying(10000),
    action_type character varying(50),
    revised_definition character varying(10000),
    alternative_name character varying(100),
    abbreviation character varying(100),
    german_name character varying(100),
    example character varying(10000),
    ontology_iri character varying(250)
);


ALTER TABLE public.extended_user_definitions OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 16941)
-- Name: extended_user_definitions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.extended_user_definitions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.extended_user_definitions_id_seq OWNER TO postgres;

--
-- TOC entry 3526 (class 0 OID 0)
-- Dependencies: 247
-- Name: extended_user_definitions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.extended_user_definitions_id_seq OWNED BY public.extended_user_definitions.id;


--
-- TOC entry 248 (class 1259 OID 16942)
-- Name: extended_user_definitions_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.extended_user_definitions_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.extended_user_definitions_profile_id_seq OWNER TO postgres;

--
-- TOC entry 3527 (class 0 OID 0)
-- Dependencies: 248
-- Name: extended_user_definitions_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.extended_user_definitions_profile_id_seq OWNED BY public.extended_user_definitions.profile_id;


--
-- TOC entry 238 (class 1259 OID 16881)
-- Name: game_information; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_information (
    id integer NOT NULL,
    profile_id integer NOT NULL,
    department character varying(150),
    ontology_id integer,
    num_questions integer,
    random_word character varying(150),
    random_definition character varying(10000)
);


ALTER TABLE public.game_information OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16879)
-- Name: game_information_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.game_information_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.game_information_id_seq OWNER TO postgres;

--
-- TOC entry 3528 (class 0 OID 0)
-- Dependencies: 236
-- Name: game_information_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.game_information_id_seq OWNED BY public.game_information.id;


--
-- TOC entry 237 (class 1259 OID 16880)
-- Name: game_information_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.game_information_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.game_information_profile_id_seq OWNER TO postgres;

--
-- TOC entry 3529 (class 0 OID 0)
-- Dependencies: 237
-- Name: game_information_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.game_information_profile_id_seq OWNED BY public.game_information.profile_id;


--
-- TOC entry 222 (class 1259 OID 16806)
-- Name: ontology; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ontology (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    description character varying(10000),
    image_url character varying(255),
    ontology_url character varying(255)
);


ALTER TABLE public.ontology OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16805)
-- Name: ontology_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ontology_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ontology_id_seq OWNER TO postgres;

--
-- TOC entry 3530 (class 0 OID 0)
-- Dependencies: 221
-- Name: ontology_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ontology_id_seq OWNED BY public.ontology.id;


--
-- TOC entry 229 (class 1259 OID 16838)
-- Name: profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profile (
    id integer NOT NULL,
    username character varying(150),
    profile_picture character varying(150),
    level integer,
    xp integer,
    user_id integer
);


ALTER TABLE public.profile OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16837)
-- Name: profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.profile_id_seq OWNER TO postgres;

--
-- TOC entry 3531 (class 0 OID 0)
-- Dependencies: 228
-- Name: profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.profile_id_seq OWNED BY public.profile.id;


--
-- TOC entry 241 (class 1259 OID 16902)
-- Name: used_word; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.used_word (
    id integer NOT NULL,
    profile_id integer NOT NULL,
    word_uri character varying
);


ALTER TABLE public.used_word OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16900)
-- Name: used_word_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.used_word_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.used_word_id_seq OWNER TO postgres;

--
-- TOC entry 3532 (class 0 OID 0)
-- Dependencies: 239
-- Name: used_word_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.used_word_id_seq OWNED BY public.used_word.id;


--
-- TOC entry 240 (class 1259 OID 16901)
-- Name: used_word_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.used_word_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.used_word_profile_id_seq OWNER TO postgres;

--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 240
-- Name: used_word_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.used_word_profile_id_seq OWNED BY public.used_word.profile_id;


--
-- TOC entry 227 (class 1259 OID 16829)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    email character varying(150),
    password character varying(150),
    first_name character varying(150)
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16861)
-- Name: user_challenges; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_challenges (
    id integer NOT NULL,
    user_id integer NOT NULL,
    challenge_id integer NOT NULL,
    completed boolean
);


ALTER TABLE public.user_challenges OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16860)
-- Name: user_challenges_challenge_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_challenges_challenge_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_challenges_challenge_id_seq OWNER TO postgres;

--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 234
-- Name: user_challenges_challenge_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_challenges_challenge_id_seq OWNED BY public.user_challenges.challenge_id;


--
-- TOC entry 232 (class 1259 OID 16858)
-- Name: user_challenges_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_challenges_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_challenges_id_seq OWNER TO postgres;

--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 232
-- Name: user_challenges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_challenges_id_seq OWNED BY public.user_challenges.id;


--
-- TOC entry 233 (class 1259 OID 16859)
-- Name: user_challenges_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_challenges_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_challenges_user_id_seq OWNER TO postgres;

--
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 233
-- Name: user_challenges_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_challenges_user_id_seq OWNED BY public.user_challenges.user_id;


--
-- TOC entry 246 (class 1259 OID 16927)
-- Name: user_definitions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_definitions (
    id integer NOT NULL,
    profile_id integer NOT NULL,
    profile_class character varying(150),
    profile_definition character varying(10000),
    action_type character varying(50),
    revised_definition character varying(10000)
);


ALTER TABLE public.user_definitions OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 16925)
-- Name: user_definitions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_definitions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_definitions_id_seq OWNER TO postgres;

--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 244
-- Name: user_definitions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_definitions_id_seq OWNED BY public.user_definitions.id;


--
-- TOC entry 245 (class 1259 OID 16926)
-- Name: user_definitions_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_definitions_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_definitions_profile_id_seq OWNER TO postgres;

--
-- TOC entry 3538 (class 0 OID 0)
-- Dependencies: 245
-- Name: user_definitions_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_definitions_profile_id_seq OWNED BY public.user_definitions.profile_id;


--
-- TOC entry 226 (class 1259 OID 16828)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_seq OWNER TO postgres;

--
-- TOC entry 3539 (class 0 OID 0)
-- Dependencies: 226
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- TOC entry 3296 (class 2604 OID 16853)
-- Name: challenges id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.challenges ALTER COLUMN id SET DEFAULT nextval('public.challenges_id_seq'::regclass);


--
-- TOC entry 3304 (class 2604 OID 16920)
-- Name: definition_scores id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.definition_scores ALTER COLUMN id SET DEFAULT nextval('public.definition_scores_id_seq'::regclass);


--
-- TOC entry 3292 (class 2604 OID 16819)
-- Name: department_ontology_association id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department_ontology_association ALTER COLUMN id SET DEFAULT nextval('public.department_ontology_association_id_seq'::regclass);


--
-- TOC entry 3293 (class 2604 OID 16820)
-- Name: department_ontology_association ontology_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department_ontology_association ALTER COLUMN ontology_id SET DEFAULT nextval('public.department_ontology_association_ontology_id_seq'::regclass);


--
-- TOC entry 3307 (class 2604 OID 16946)
-- Name: extended_user_definitions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.extended_user_definitions ALTER COLUMN id SET DEFAULT nextval('public.extended_user_definitions_id_seq'::regclass);


--
-- TOC entry 3308 (class 2604 OID 16947)
-- Name: extended_user_definitions profile_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.extended_user_definitions ALTER COLUMN profile_id SET DEFAULT nextval('public.extended_user_definitions_profile_id_seq'::regclass);


--
-- TOC entry 3300 (class 2604 OID 16884)
-- Name: game_information id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_information ALTER COLUMN id SET DEFAULT nextval('public.game_information_id_seq'::regclass);


--
-- TOC entry 3301 (class 2604 OID 16885)
-- Name: game_information profile_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_information ALTER COLUMN profile_id SET DEFAULT nextval('public.game_information_profile_id_seq'::regclass);


--
-- TOC entry 3291 (class 2604 OID 16809)
-- Name: ontology id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ontology ALTER COLUMN id SET DEFAULT nextval('public.ontology_id_seq'::regclass);


--
-- TOC entry 3295 (class 2604 OID 16841)
-- Name: profile id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profile ALTER COLUMN id SET DEFAULT nextval('public.profile_id_seq'::regclass);


--
-- TOC entry 3302 (class 2604 OID 16905)
-- Name: used_word id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.used_word ALTER COLUMN id SET DEFAULT nextval('public.used_word_id_seq'::regclass);


--
-- TOC entry 3303 (class 2604 OID 16906)
-- Name: used_word profile_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.used_word ALTER COLUMN profile_id SET DEFAULT nextval('public.used_word_profile_id_seq'::regclass);


--
-- TOC entry 3294 (class 2604 OID 16832)
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- TOC entry 3297 (class 2604 OID 16864)
-- Name: user_challenges id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_challenges ALTER COLUMN id SET DEFAULT nextval('public.user_challenges_id_seq'::regclass);


--
-- TOC entry 3298 (class 2604 OID 16865)
-- Name: user_challenges user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_challenges ALTER COLUMN user_id SET DEFAULT nextval('public.user_challenges_user_id_seq'::regclass);


--
-- TOC entry 3299 (class 2604 OID 16866)
-- Name: user_challenges challenge_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_challenges ALTER COLUMN challenge_id SET DEFAULT nextval('public.user_challenges_challenge_id_seq'::regclass);


--
-- TOC entry 3305 (class 2604 OID 16930)
-- Name: user_definitions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_definitions ALTER COLUMN id SET DEFAULT nextval('public.user_definitions_id_seq'::regclass);


--
-- TOC entry 3306 (class 2604 OID 16931)
-- Name: user_definitions profile_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_definitions ALTER COLUMN profile_id SET DEFAULT nextval('public.user_definitions_profile_id_seq'::regclass);


--
-- TOC entry 3497 (class 0 OID 16850)
-- Dependencies: 231
-- Data for Name: challenges; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.challenges (id, challenge, xp_reward, name) FROM stdin;
\.


--
-- TOC entry 3509 (class 0 OID 16917)
-- Dependencies: 243
-- Data for Name: definition_scores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.definition_scores (id, class_name, definition, score, agreements, disagreements, latest_review, split_review, is_default) FROM stdin;
1	Order	An order signifies a formal request or instruction for the procurement, distribution, or delivery of products or services within the supply chain. It encompasses customer orders, replenishment orders, or split orders initiated to fulfill demand, replenish inventory, or redistribute products.	1	1	0	0	f	f
2	Order	In the supply chain context, an order represents a formal directive or request for the acquisition, distribution, or movement of products or services. It includes customer orders, replenishment orders, or split orders issued to meet demand, manage inventory, or facilitate product allocation.	0	0	0	0	f	f
3	Customer	A customer represents an individual, organization, or entity that purchases or engages with products or services offered within the supply chain. It encompasses buyers, end-users, retailers, or entities procuring goods or services within the supply chain network.	2.1	2	0	0	f	f
4	Customer	In the supply chain context, a customer signifies an individual, organization, or entity that procures, consumes, or engages with products or services. It includes wholesalers, retailers, end-users, or entities involved in the procurement and consumption of goods within the supply chain.	0	0	0	0	f	f
5	Customer	Customers (or consumers) are individuals or organizations that purchase and use a product or service. A customer may be an organization (a producer or distributor) that purchases a product in order to incorporate it into another product that they in turn sell to their customers (ultimate customers).	0	0	0	0	f	f
6	CustomerPlant	A customer plant denotes a physical location, facility, or entity operated by a customer within the supply chain. It encompasses distribution centers, manufacturing facilities, or operational sites managed by customers to facilitate order fulfillment and product management.	0	0	0	0	f	f
7	CustomerPlant	Within the supply chain, a customer plant represents a specific facility, warehouse, or operational site managed by a customer to handle order receipt, inventory management, and product distribution. It includes distribution centers, manufacturing plants, or fulfillment hubs operated by customers.	2.1	2	0	0	f	f
8	Product	A product refers to a physical item or service that is available for purchase, distribution, or utilization within the supply chain. It encompasses merchandise, parts, or services that are produced, exchanged, or utilized within the network of the supply chain.	0	1	1	0	f	f
9	Product	A product represents a tangible item or service offered for sale, distribution, or use within the supply chain. It encompasses goods, components, or services that are manufactured, traded, or consumed within the supply chain network.	1	1	0	0	f	f
10	Product	In the context of the supply chain, a product refers to a distinct item, part, or service involved in manufacturing, distribution, or consumption processes. It includes physical goods, components, or services that are integral to supply chain operations and customer fulfillment.	0	0	0	0	f	f
11	ReplenishmentOrder	A replenishment order signifies a directive for the resupply or replenishment of products or inventory within the supply chain. It encompasses orders initiated by customer plants, distribution centers, or manufacturers to replenish stock, manage inventory levels, or fulfill supply chain requirements.	1	1	0	0	f	f
12	ReplenishmentOrder	Within the supply chain, a replenishment order represents a formal instruction for restocking, refilling, or replenishing inventory levels. It includes orders issued by customer plants, distribution centers, or manufacturers to maintain adequate stock, manage inventory, or meet supply chain demands.	0	0	0	0	f	f
13	CustomerOrder	A customer order represents a specific request placed by a customer for the procurement of products or services. It encompasses orders initiated by customers to fulfill demand, replenish inventory, or acquire goods for consumption or resale within the supply chain network.	1	1	0	0	f	f
14	CustomerOrder	In the supply chain context, a customer order denotes a formal request placed by a customer for the acquisition of products or services. It includes orders initiated by customers to meet demand, manage inventory, or fulfill procurement requirements within the supply chain.	0	0	0	0	f	f
15	SplitOrder	A split order denotes a customized directive for the division or allocation of products or services into multiple segments or destinations within the supply chain. It encompasses tailored orders designed to distribute or allocate products to specific recipients, locations, or channels based on customized requirements.	1	1	0	0	f	f
16	SplitOrder	In the supply chain context, a split order represents a specialized instruction for the partitioning, segregation, or allocation of products into distinct segments or destinations. It includes customized orders tailored to distribute or allocate products to specific recipients, locations, or channels based on specific requirements.	1.9859999999999998	3	1	0	f	f
17	Microcontroller	A microcontroller is a programmable device that integrates a processor, memory, and input/output interfaces to control and interact with external devices and systems.	1	1	0	0	f	f
18	Microcontroller	A microcontroller is a small computer on a single integrated circuit (IC) that contains a processor, memory, and input/output peripherals.	0	0	0	0	f	f
19	Microcontroller_Feature	A microcontroller feature is a hardware or software component of a microcontroller that enables it to perform a particular task or function, such as data conversion, communication, or control.	1	1	0	0	f	f
20	Microcontroller_Feature	A microcontroller feature is a specific capability or functionality provided by a microcontroller, such as analog-to-digital conversion, serial communication, or pulse-width modulation.	0	0	0	0	f	f
21	Microcontroller_Application	A microcontroller application is a software or firmware program that runs on a microcontroller to control and interact with external devices, sensors, and actuators.	1	1	0	0	f	f
22	Microcontroller_Application	A microcontroller application is a specific use case or project that utilizes a microcontroller to perform a particular function or set of functions.	0	0	0	0	f	f
23	Analog-to-Digital_Converter	An analog-to-digital converter is a device that translates continuous analog signals into discrete digital values, allowing microcontrollers to read and process analog data.	0	0	0	0	f	f
24	Analog-to-Digital_Converter	An analog-to-digital converter is a microcontroller feature that converts analog signals from sensors or other devices into digital signals that can be processed by the microcontroller.	0	0	0	0	f	f
25	Embedded_System	An embedded system is a combination of computer hardware and software designed to perform a specific function or set of functions, often with real-time constraints.	0	0	0	0	f	f
26	Embedded_System	An embedded system is a microcontroller-based system that is integrated into a larger device or system, such as a consumer appliance, industrial machine, or automotive system.	1	1	0	0	f	f
27	Industrial_Automation	Industrial automation refers to the use of control systems, such as microcontrollers and programmable logic controllers (PLCs), to monitor and control industrial processes and machinery.	0	0	0	0	f	f
29	ObservationCollection	An Observation Collection has at least one member, and may have one of any of the other seven properties mentioned in restrictions.	0	0	0	0	f	f
30	TemporalEntity	A temporal interval or instant.	0	0	0	0	f	f
31	SampleRelationship	Members of this class represent a relationship between a sample and another.	0	0	0	0	f	f
32	Deployment	Describes the Deployment of one or more Systems for a particular purpose. Deployment may be done on a Platform.	0	0	0	0	f	f
33	System	System is a unit of abstraction for pieces of infrastructure that implement Procedures. A System may have components, its subsystems, which are other systems.	0	0	0	0	f	f
34	Stimulus	An event in the real world that 'triggers' the Sensor. The properties associated to the Stimulus may be different to the eventual observed ObservableProperty. It is the event, not the object, that triggers the Sensor.	0	0	0	0	f	f
35	Property	A quality of an entity. An aspect of an entity that is intrinsic to and cannot exist without the entity.	0	0	0	0	f	f
36	Input	Any information that is provided to a Procedure for its use.	0	0	0	0	f	f
37	OversamplingRate	Specifies the number of sensor measurements used internally to generate one sensor output result. (Oversampling rate = OSR)	0	0	0	0	f	f
39	OperatingProperty	An identifiable characteristic that represents how the System operates under the specified Conditions. May describe power ranges, power sources, standard configurations, attachments and the like.	0	0	0	0	f	f
41	SurvivalProperty	An identifiable characteristic that represents the extent of the System's useful life under the specified Conditions. May describe for example total battery life or number of recharges, or, for Sensors that are used only a fixed number of times, the number of Observations that can be made before the sensing capability is depleted.	0	0	0	0	f	f
42	SystemCapability	Describes normal measurement, actuation, sampling properties such as accuracy, range, precision, etc. Of a System under some specified Conditions such as temperature range. The capabilities specified here are those that affect the primary purpose of the System, while those in OperatingRange represent the system's normal operating environment, including Conditions that don't affect the Observations or the Actuations.	0	0	0	0	f	f
43	SystemProperty	An identifiable and observable characteristic that represents the system's ability to operate its primary purpose: a sensor to make Observations, an Actuator to make Actuations, or a Sampler to make Sampling.	0	0	0	0	f	f
44	Condition	Used to specify ranges for qualities that act as Condition on a Systems' operation.	0	0	0	0	f	f
45	RelationshipNature	Nature of a relationship (between samples) - Members of this class indicate the nature of a relationship between two samples.	0	0	0	0	f	f
46	Accuracy	The closeness of agreement between the Result of an Observation (resp. The command of an Actuation) and the true value of the observed ObservableProperty (resp. Of the acted on ActuableProperty) under the defined Conditions.	0	0	0	0	f	f
47	ActuationRange	The range of property values that can be the Result of an Actuation under the defined Conditions.	0	0	0	0	f	f
48	BatteryLifetime	Total useful life of a System's battery in the specified Conditions.	0	0	0	0	f	f
49	DetectionLimit	An observed value for which the probability of falsely claiming the absence of a component in a material is beta, given a probability alpha of falsely claiming its presence.	0	0	0	0	f	f
50	Drift	As a Sensor Property: a continuous or incremental change in the reported values of Observations over time for an unchanging Property under the defined Conditions. As an Actuator Property: a continuous or incremental change in the true value of the acted on ActuableProperty over time for an unchanging command under the defined Conditions.	0	0	0	0	f	f
51	Frequency	The smallest possible time between one Observation, Actuation, or Sampling and the next, under the defined Conditions.	0	0	0	0	f	f
52	Latency	The time between a command for an Observation and the Sensor providing a Result, under the defined Conditions.	0	0	0	0	f	f
53	MaintenanceSchedule	Schedule of maintenance for a System in the specified Conditions.	0	0	0	0	f	f
54	MeasurementRange	The set of values that the Sensor can return as the Result of an Observation under the defined Conditions with the defined system properties.	0	0	0	0	f	f
55	OperatingPowerRange	Power range in which System is expected to operate in the specified.	0	0	0	0	f	f
56	Precision	As a sensor capability: The closeness of agreement between replicate Observations on an unchanged or similar quality value: i.e., a measure of a Sensor's ability to consistently reproduce an Observation, under the defined Conditions.	0	0	0	0	f	f
57	Resolution	As an actuator capability: The closeness of agreement between replicate Actuations for an unchanged or similar command: i.e., a measure of an Actuator's ability to consistently reproduce an Actuations, under the defined Conditions.	0	0	0	0	f	f
58	ResponseTime	As a Sensor Property: the time between a (step) change in the value of an observed ObservableProperty and a Sensor (possibly with specified error) 'settling' on an observed value, under the defined Conditions.	0	0	0	0	f	f
59	Selectivity	As an Actuator Property: the time between a (step) change in the command of an Actuator and the 'settling' of the value of the acted on ActuatableProperty, under the defined Conditions.	0	0	0	0	f	f
60	Sensitivity	As a Sensor Property: Sensitivity is the quotient of the change in a Result of Observations and the corresponding change in a value of an ObservableProperty being observed, under the defined Conditions.	0	0	0	0	f	f
61	SystemLifetime	The System continues to operate as defined using SystemCapability. If, however, the SurvivalRange is violated, the System is 'damaged' and SystemCapability specifications may no longer hold.	0	0	0	0	f	f
63	Battery_CO2_Savings_Enabler	CO2 Savings refers to several solutions that might reduce carbon emissions throughout the course of a Lithiu-Ion battery's lifespan.	0	0	0	0	f	f
66	BMS_Functional_Block	A Functional Block is a component of the battery management system.	0	0	0	0	f	f
67	Vehicle	A vehicle is a machine with wheels and an engine, used for transporting people or goods.	0	0	0	0	f	f
68	BatteryManagementSystem_Company	https://nuvationenergy.com/battery-management-systems/	0	0	0	0	f	f
70	Battery_Cell	Cells are fundamental electrochemical unit, or assembly of electrodes, separators, electrolyte, container, and terminals, that serves as a source of electrical energy by directly converting chemical energy. In this case, the cells are all of the type Li-Ion.	0	0	0	0	f	f
73	Battery_Cooling_System	A battery cooling system is part of a battery pack. Its purpose is to cool, but also to heat if needed, the battery modules in the battery pack.	0	0	0	0	f	f
74	Semiconductor	Semiconductor is an eletronic device which electrical conductivity value is between an insulator and a conductor. In this case, constitutes the battery management system.	0	0	0	0	f	f
75	Voltage_Class	The voltage class is the most important property of batteries. It is often used to separate batteries into different classes, like HV battery for High Voltage battery. Hence, the voltage classes are modelled in this ontology explicitely.	0	0	0	0	f	f
77	Lithium-Ferrophosphate_Battery_Management_System	Full name: Lithium-Ferrophosphate Battery Management System	0	0	0	0	f	f
82	Semiconductor_Company	Company responsible for the manufacturing of semiconductors.	0	0	0	0	f	f
83	Battery_Voltage_Class	Class that allows to classify batteries according to their voltage. Most important sub class is High Voltage Battery (HV battery). But there are low voltage batteries as well.	0	0	0	0	f	f
89	Enhanced_Flooded_Battery	Enhanced Flooded Batteries (EFB) are optimized and power-enhanced versions of SLI batteries.	0	0	0	0	f	f
90	Nickel_Metal_Hydride_Accumulator	Nickel_Metal_Hydride_Accumulator	0	0	0	0	f	f
109	Process	A process has an output and possibly inputs, and for a compositive process, describes the temporal and dataflow dependencies and relationships amongst its parts.	0	0	0	0	f	f
110	Process_Input	Any information that is provided a Procedure for its use.	0	0	0	0	f	f
112	TheDeviceOutput	the device output is a piece of information (value), the value itself being represented by an The device function value.	0	0	0	0	f	f
113	Device	A device is a physical piece of technology - a system in a box. Devices may of course be build of smaller devices and software components."	0	0	0	0	f	f
93	Starting_Lighting_Ignition_Battery	SLI- (Starting, Lighting, Ignition) Batteries are the simplest types of car batteries. They are appropriate for cars without start-stopp technology and with low to medium number of electronic consumers.	0	0	0	0	f	f
94	Longer_Lifespan	Longer life cycle refers to the number of extra cycles of the battery due good handling throught its lifecycle. It is a way of CO2 savings.	0	0	0	0	f	f
95	Optimized_Charging	Second life means that the Lithium-Ion battery has ceased its main activity, in this case powering an electric car, however, it is still able to be used for other purposes.	0	0	0	0	f	f
103	GeometricDimension	"Describes the Dimensions of any Physical Object (Length, Wisth, Height)"	0	0	0	0	f	f
104	ApplicationArea	The different application ares that the product can be used.	0	0	0	0	f	f
105	Control_Method	It is the method used to turn on, turn off , increaseing, and decreasing output current/voltage.	0	0	0	0	f	f
106	SiC_MOSFET	Silicon Carbide Metal Oxide Semiconductor Field Effect Transistor (SiC MOSFET): It is a transistor: It is used for switching or amplifying the electronics signals or electric power.	0	0	0	0	f	f
107	System	System is a unit of abstraction for pieces of infrastructure that implements procedure. A System may have components, its subsystems, which are other systems."	0	0	0	0	f	f
108	Deployment	The ongoing Process of Entities (for the purposes of this ontology, mainly the Infineon device) deployed for a particular purpose. For example, a particular Sensor deployed on a Platform, or a whole network of Sensors deployed for an observation campaign. The deployment may have sub processes, such as installation, maintenance, addition, and decomissioning and removal.	0	0	0	0	f	f
138	Customer_Plant	Manufacturing site where the cusomer procuces goods	0	0	0	0	f	f
114	Situation	A view, consistent with ('satisfying') a Description, on a set of entities. It can also be seen as a 'relational context' created by an observer on the basis of a 'frame' (i.e. a Description). For example, a PlanExecution is a context including some actions executed by agents according to certain parameters and expected tasks to be achieved from a Plan; a DiagnosedSituation is a context of observed entities that is interpreted on the basis of a Diagnosis, etc. Situation is also able to represent reified n-ary relations, where isSettingFor is the top-level relation for all binary projections of the n-ary relation. If used in a transformation pattern for n-ary relations, the designer should take care of creating only one subclass of Situation for each n-ary relation, otherwise the 'identification constraint' (Calvanese et al., IJCAI 2001) could be violated.	0	0	0	0	f	f
115	Information_Object	A piece of information, such as a musical composition, a text, a word, a picture, independently from how it is concretely realized.	0	0	0	0	f	f
116	Quality	Any aspect of an Entity (but not a part of it), which cannot exist without that Entity. For example, the way the surface of a specific PhysicalObject looks like is a Quality, while the encoding of that Quality into e.g. a PhysicalAttribute should be modeled as a Region. From the design viewpoint, the Quality-Region distinction is useful only when individual aspects of an Entity are considered in a domain of discourse. For example, in an automotive context, it would be irrelevant to consider the aspects of car windows for a specific car, unless the factory wants to check a specific window against design parameters (anomaly detection). On the other hand, in an antiques context, the individual aspects for a specific piece of furniture are a major focus of attention, and may constitute the actual added value, because the design parameters for old furniture are often not fixed, and may not be viewed as 'anomalies'.	0	0	0	0	f	f
117	Documents	The document class presents those things which are, broadly conceived, "documents''. It should contain the manuals and the data sheet of the devices.	0	0	0	0	f	f
118	Deployment-related_Process	Place to group all the various Processes related to Deployment. For example, as well as Deployment, installation, maintenance, deployment of the further devices and the like would all be classified under DeploymentRelatedProcess.	0	0	0	0	f	f
120	Entity	Anything: real, possible, or imaginary, which some modeller wants to talk about for some purpose.	0	0	0	0	f	f
122	Interface	A common boundary or interconnection between systems, equipment, concepts, or human beings	0	0	0	0	f	f
123	Object	Any physical, social, or mental object, or a substance	0	0	0	0	f	f
124	Package	A package is the housing for a chip (or several chips) and provides electrical contacts. It is an interconnect in between chip-pads and the interface to the PCB board. A package is characterized by its outline (drawing) and its materials.	0	0	0	0	f	f
128	Allocation	Allocation is a process used in order management in times when demand exceeds available supply.	0	0	0	0	f	f
129	Supply	This is the total amount of specific products that is available to customers. Supply has the dimensions quantity, time, location, product, including aggregation of all dimensions. Supply is defined as inventory or plan replenishment.	0	0	0	0	f	f
130	Order_Confirmation	A notification  that an order has been received and accepted	0	0	0	0	f	f
131	Open_Order	An order that has been placed, but not yet fulfilled or completed	0	0	0	0	f	f
132	Order_Line_Item	A single item  that is part of a larger order. It represents a specific product or service that a customer has ordered, along with its associated details.	0	0	0	0	f	f
133	Open_Order_Book	A continuously updated  record of all outstanding sell orders	0	0	0	0	f	f
134	Contact_Person_Data	Data of the contact person	0	0	0	0	f	f
135	Customer_Data	Customer data such as address and company name	0	0	0	0	f	f
136	Supplier_Data	Data about the supplier such as name, location, address	0	0	0	0	f	f
137	Customer	A customer is an business that purchases another company's goods or services.	0	0	0	0	f	f
139	Supplier	A supplier is a company or organization that provides goods, services, or materials to another entity	0	0	0	0	f	f
140	Order_Change_Request	A request to modify an existing order that has not yet been fulfilled	0	0	0	0	f	f
141	Action	The process of doing something	0	0	0	0	f	f
142	UserAction	Activity taken by user	0	0	0	0	f	f
143	Demand_Fulfillment	The process of meeting a customer’s demand for product or services by fulfilling their request.	0	0	0	0	f	f
144	Customer_Data	My new definition	1	1	0	0	f	f
505	SwitchingValue	The value of the result of the method (procedures) of the device function. The result is an information object that encodes some value for a feature. \nFor example:\n-If we consider the observation is the method used for sensing of the sensors, then the observation has a result which is the output of the sensor,\n-If -If we consider the amplification is the method used for boosting of the power converter, then the amplification has a result which is the output of the  power converter,	0	0	0	0	f	f
506	Switching_Frequency	No definition available	0	0	0	0	f	t
507	The_process_name_of_the_device_function	It is a process that results in the estimation, or calculation, of the value of a device output. \nUsually it derived from the name of the device for example:\nSensor process: sensing: Sensing is a process that results in the estimation, or calculation, of the value of a phenomenon.\n\nBoost Converter process: boosting: is a process that results in the estimation, or calculation, of the value of a amplified voltage.	0	0	0	0	f	f
508	Utilities	No definition available	0	0	0	0	f	t
509	Voltage-Controlled	No definition available	0	0	0	0	f	t
510	Weight	No definition available	0	0	0	0	f	t
511	Width	No definition available	0	0	0	0	f	t
512	Software&Services	No definition available	0	0	0	0	f	t
513	SupplyDemandMatch	No definition available	0	0	0	0	f	t
514	SupplyPicture	No definition available	0	0	0	0	f	t
515	OrdersReschedule	No definition available	0	0	0	0	f	t
516	MarketingDemands	No definition available	0	0	0	0	f	t
517	SalesDemands	No definition available	0	0	0	0	f	t
518	OrderLineItem	No definition available	0	0	0	0	f	t
519	OpenOrderBook	No definition available	0	0	0	0	f	t
520	Orders	No definition available	0	0	0	0	f	t
521	ATP	No definition available	0	0	0	0	f	t
522	PrioritizedOrders	No definition available	0	0	0	0	f	t
523	CLM	No definition available	0	0	0	0	f	t
524	TargetAllocation	No definition available	0	0	0	0	f	t
525	AATP	No definition available	0	0	0	0	f	t
526	ordersScheduleLine	No definition available	0	0	0	0	f	t
527	Stocks	No definition available	0	0	0	0	f	t
528	OperationalDemand	No definition available	0	0	0	0	f	t
529	Forecast	No definition available	0	0	0	0	f	t
530	Customers	No definition available	0	0	0	0	f	t
531	nEWs	No definition available	0	0	0	0	f	t
532	CapacityBottleneck	No definition available	0	0	0	0	f	t
533	PrioritizedDemand	No definition available	0	0	0	0	f	t
534	AggregatedCapacity	No definition available	0	0	0	0	f	t
535	Promise	No definition available	0	0	0	0	f	t
536	BottleneckResource	No definition available	0	0	0	0	f	t
537	Confirmation	No definition available	0	0	0	0	f	t
538	ResourceCapacity	No definition available	0	0	0	0	f	t
539	AP_FCST	No definition available	0	0	0	0	f	t
540	BufferStockOrders	No definition available	0	0	0	0	f	t
541	ConsignmentOrders	No definition available	0	0	0	0	f	t
542	DB	No definition available	0	0	0	0	f	t
543	DC	No definition available	0	0	0	0	f	t
544	EDIForecast	No definition available	0	0	0	0	f	t
545	GeneralCustomers	No definition available	0	0	0	0	f	t
546	HP_Forecast	No definition available	0	0	0	0	f	t
547	MaxStock	No definition available	0	0	0	0	f	t
548	SSO_Stocks	No definition available	0	0	0	0	f	t
549	MinStock	No definition available	0	0	0	0	f	t
550	NP_Forecast	No definition available	0	0	0	0	f	t
551	OP_Forecast	No definition available	0	0	0	0	f	t
552	PrivateCustomers	No definition available	0	0	0	0	f	t
553	RampUpStock	No definition available	0	0	0	0	f	t
554	RetainedStock	No definition available	0	0	0	0	f	t
555	SafetyStock	No definition available	0	0	0	0	f	t
556	StandardOrders	No definition available	0	0	0	0	f	t
557	WIP	No definition available	0	0	0	0	f	t
558	Agent	"The Agent class is the class of agents; things that do stuff. A well known sub-class is Person, representing people. Other kinds of agents include Organization and Group.\n\nThe Agent class is useful in a few places in FOAF where Person would have been overly specific. For example, the IM chat ID properties such as jabberID are typically associated with people, but sometimes belong to software bots."	0	0	0	0	f	f
559	Observation	No definition available	0	0	0	0	f	t
560	Actuation	No definition available	0	0	0	0	f	t
561	Sampling	No definition available	0	0	0	0	f	t
562	Output	Any information that is reported from a Procedure.	0	0	0	0	f	f
563	OperatingRange	"Describes normal OperatingProperties of a System under some specified Conditions. For example, to the power requirement or maintenance schedule of a System under a specified temperature range.\nIn the absence of OperatingProperties, it simply describes the Conditions in which a System is expected to operate."	0	0	0	0	f	f
564	SurvivalRange	"Describes SurvivalProperties of a System under some specified Conditions. For example, the lifetime of a System under a specified temperature range.\nIn the absence of SurvivalProperties, simply describes the Conditions a System can be exposed to without damage. For example, the temperature range a System can withstand before being considered damaged."	0	0	0	0	f	f
565	Vocabulary	No definition available	0	0	0	0	f	t
566	SupplyChain	No definition available	0	0	0	0	f	t
567	Sensor	No definition available	0	0	0	0	f	t
568	TemperatureSensor	No definition available	0	0	0	0	f	t
569	InfraredTemperatureSensor	No definition available	0	0	0	0	f	t
570	ThermocoupleTemperatureSensor	No definition available	0	0	0	0	f	t
340	Battery_Management_System	A battery management system is, according to Infineon´s definition, a set of "electronic control circuits that monitor and regulate the charging and discharge of batteries." It supervises parameters such as the temperature, voltages, capacity, state of charge, power consumption, charging cycles. (Source: https://www.infineon.com/cms/en/applications/solutions/battery-management-system/ )\n\nAccording to VDMA and RWTH Aachen, the Battery Management System controls the cooling system, the slave PCBs of the battery modules, and the high voltage system.\n\nThese two definitions are compatible, as the first one determines the purpose of the BMS, and the second one the control hierarchy.\n\nBMS consist of one BMS master module which is a physcial part of the battery pack (beside the battery modules) and a set of BMS slave modules, one in each battery module.	0	0	0	0	f	f
341	Battery_CO2_Savings_Enabler	HB (2023-06-25): \n\nI renamed this class to ..._Enabler, as subclasses like longer lifespan enable CO2 savings, but they are not CO2 savings themselves. \n\nThe class hierarchy is an "isA"-Hierarchy: so every element of a subclass is automatically also an element of the superclass. \n\nFor this reason, I also removed the object property enables_CO2_saving, as the intention of this object property is already fulfilled by the class hierarchy here. \n\nFurthermore, I introduced a new class Transportation_CO2_Savings_Enabler and moved the subclass Electric_Means_Transportation to this class. The justification for this is that electric means transportation is very different from the battery CO2 savings enablers.\n\nThe whole topic of modelling CO2 savings in the context of e-Mobility needs to be further discussed!	0	0	0	0	f	f
342	BMS_Constructive_Block	A Battery Management System consists of a BMS master which is a physical part of the battery pack (outside and different from the battery modules) and BMS slaves, which are part of battery modules. \nThat is, a BMS of a battery pack consists of one BMS master and N BMS slaves where N is the number of battery modules of the battery pack.\n\nThe constructive decomposition needs to be treates separately from the functional decomposition (functional blocks).	0	0	0	0	f	f
343	Car_Battery	No definition available	0	0	0	0	f	t
344	Battery_Module	A battery module contains several battery cells. \nA battery pack contains several battery modules and a BMS (and further components).	0	0	0	0	f	f
345	BatteryCell_Company	No definition available	0	0	0	0	f	t
346	Battery_Pack	A battery pack is a set of battery modules, a BMS and several further components.\nThe main components of a battery pack are:\n- battery modules, including a BMS slave each\n- high-voltage module\n- Battery Management System Master \n- cooling system\n- wiring \n\nA battery pack has three main interfaces to outside systems: \n- coolant connection\n- CAN interface\n- Service Plug and Power Supply.	0	0	0	0	f	f
347	Battery_Module_Housing	No definition available	0	0	0	0	f	t
348	Battery_Module_Company	No definition available	0	0	0	0	f	t
349	High_Voltage_Battery	No definition available	0	0	0	0	f	t
350	Traction_Battery	Traction Batteries are car batteries with high voltage, that supply the electric traction motors of e-cars. \nHence, traction batteries are both car batteries and high voltage batteries. This leads inevitably to a multiple inheritance situation for this class.	0	0	0	0	f	f
351	Battery_Pack_Housing	No definition available	0	0	0	0	f	t
352	Battery_Pack_Company	No definition available	0	0	0	0	f	t
353	Battery_Company	No definition available	0	0	0	0	f	t
354	Battery_Type	No definition available	0	0	0	0	f	t
355	Current_Sensing	No definition available	0	0	0	0	f	t
356	Current_Sensor	No definition available	0	0	0	0	f	t
357	High_Voltage_Class	No definition available	0	0	0	0	f	t
358	Onboard_Electronics_Network_Battery	No definition available	0	0	0	0	f	t
359	Low_Voltage_Class	No definition available	0	0	0	0	f	t
360	Battery_High_Voltage_System	A battery high voltage system is part of a battery pack. \nIt consists of relay, fuses, pre-charge and current measuring system, insulation monitoring etc.\n\nThe High-voltage system and the BMS are different entities, both physically and regarding their functionality. \nHowever, there seem to exist strong interdependencies between these systems. \nAccording to VDMA and RWTH Aachen the BMS controls the high-voltage system. \n\nAnd, it seems that also the high-voltage system contains semiconductors!!	0	0	0	0	f	f
361	Battery_Pack_HV_System_Component	No definition available	0	0	0	0	f	t
362	Lithium-Ferrophosphate_Battery_Module	No definition available	0	0	0	0	f	t
363	Lithium-Ferrophosphate_Battery_Cell	Battery cell of Lithium-Ferrophosphate batteries. \n\nThe cathodes of LiFePO4 batteries consist of Lithium-Ferrophosphate.\n\nTypical cell currency is 3.2 to 3.3 Volt.	0	0	0	0	f	f
364	Lithium-Ferrophosphate_Battery_Pack	No definition available	0	0	0	0	f	t
365	LFP_Traction_Battery	LFP batteries are not so widely used as traction batteries of cars as traditional Li-Ion batteries or Lithium-Polymere batteries. \nThe main disadvantage of LFP batteries is the lower cell voltage of 3.2 to 3.3 Volt compared to 3.6 V of Li-Ion cells with Lithium-Cobalt basis and 3.7 V of Lithium-Polymere cells). \nBut they have significant advantages in terms of safety, as they cannot come into a thermic interference ("thermisches Durchgehen") and hence cannot start to burn from thereselves. \n\nTesla tested LFP traction batteries for its Model 3, and BYD started to use them widely. BYD produces LFP cells by themselves. They also offer the first E-bus with LFP traction battery.	0	0	0	0	f	f
366	Li-Ion_Battery_Management_System	No definition available	0	0	0	0	f	t
367	Li-Ion_Battery_Module	No definition available	0	0	0	0	f	t
368	Lithium-Ion_Battery_Cell	The base technology in Lithium-Ion cells are cathods from Lithium-Cobalt(III)-Oxid (LiCoO2).\n\nTypical cell currency is 3.6 Volt.	0	0	0	0	f	f
369	Lithium-Ion_Battery_Pack	No definition available	0	0	0	0	f	t
370	Lithium-Ion_High_Voltage_Battery	No definition available	0	0	0	0	f	t
371	Lithium-Ion_Traction_Battery	A Lithium-Ion traction battery of an e-car is both a traction battery and a Lithium-Ion battery. \nHence, this class is subclass of two different classes, on the one hand of a car battery and on the other hand of a battery type. \nSo it inherits properties from the "purpose" class as well as of the "type" class.	0	0	0	0	f	f
372	Battery_Control_Unit	No definition available	0	0	0	0	f	t
374	Cell_Supervision	No definition available	0	0	0	0	f	t
375	Multichannel_Battery_Monitoring_Integrated_Circuit	No definition available	0	0	0	0	f	t
376	Pack_Monitoring	No definition available	0	0	0	0	f	t
377	Multichannel_Controller_Integrated_Circuit	No definition available	0	0	0	0	f	t
378	Power_Management_Integrated_Circuit	No definition available	0	0	0	0	f	t
379	Pressure_Sensor	No definition available	0	0	0	0	f	t
380	Electric_Vehicle	No definition available	0	0	0	0	f	t
381	Electric_Passenger_Car	No definition available	0	0	0	0	f	t
382	Isolated_Communication	No definition available	0	0	0	0	f	t
383	UART_Transceiver_Integrated_Circuit	No definition available	0	0	0	0	f	t
384	Car_Company	No definition available	0	0	0	0	f	t
385	Battery_Module_Construction_Type	No definition available	0	0	0	0	f	t
386	Industrial_Company	No definition available	0	0	0	0	f	t
387	Transportation_CO2_Savings_Enabler	No definition available	0	0	0	0	f	t
388	Lithium-Ferrophosphate_Battery	Lithium-Eisenphosphat-Batterien (LiFePO4):\nDie vielen technischen Vorteile der innovativen Lithium-Technologie waren bislang meist nur bei Versorgungsbatterien zu finden, so zum Beispiel auch bei der Traction-LFP-Serie von Accurat. Mit der Accurat Impulse LFP nutzen Sie diese innovative Technologie nun auch als Starterbatterie für ihr Fahrzeug.\n\nDie Lithium-Eisenphosphat-Batterien, kurz LiFePO4 oder LFP genannt, gelten als die sichersten Lithium-Batterien und setzen neue Maßstäbe im Bereich der Starterbatterien. In Standard-Batteriegehäusen sind diese Batterien sofort einsatzbereit und 1:1 gegen herkömmliche Blei-, EFB- oder AGM-Batterien austauschbar.\n\nDer extrem geringe Innenwiderstand der LFP-Batterien bewirkt eine einzigartige Hochstromfähigkeit. Hierdurch kann die Lichtmaschine ihres Fahrzeugs die Batterie in kürzerer Zeit mit deutlich höheren Strömen aufladen.\n\nOb Leistungsabgabe, Ausdauer, Schnellladefähigkeit, Gewicht oder Kapazität – eine Accurat Impulse LFP punktet mit vielen technischen Vorzügen, die eine zuverlässige Stromversorgung garantieren.\n\nAccurat Impulse Batterien mit LFP-Technologie überzeugen mit ihrer Leistung, Gewicht – und Sicherheit. Dank ihrer Bauart und dem intelligenten Batterie-Management-System (BMS) sind alle Modelle geschützt vor Überladung, Kurzschluss und Überhitzung. Lithium-Batterien können Sie so überall problemlos verbauen – auch bei Umgebungstemperaturen von über 50 °C. Und dank ihrer geringen Selbstentladung lassen Sie sich ganz einfach lagern – garantiert ohne Gasung.\n\nSource: Accurat (https://www.autobatterienbilliger.de/Accurat-Impulse-I20L3-Lithium-Autobatterie-20Ah-LiFePO4)	0	0	0	0	f	f
389	Lithium-Ion_Battery	A Lithium-Ion Battery consists of a set of battery packs and a battery management system.\n\nThe base technology in Lithium-Ion batteries are Lithium-Ion cells with Lithium-Cobalt(III)-Oxid (LiCoO2).	0	0	0	0	f	f
390	Nickel_Cadmium_Accumulator	No definition available	0	0	0	0	f	t
391	Absorbant_Glass_Mat_Battery	The AGM battery is versatile, powerful and designed for high demands. At its core, the structure of an AGM is no different from that of a wet battery. However, the electrolyte in an AGM is no longer free-floating but bound in a special glass fiber separator - hence the name "absorbent glass mat". The large contact area achieved in this way contributes to the high power output and also makes the battery leak-proof. Due to its design, the battery is hermetically sealed. This special feature enables the internal recombination of oxygen and hydrogen, so that there is no loss of water. To protect against impermissible overpressure, the individual battery cells are equipped with a safety overpressure valve, so that safety is guaranteed even in the event of a fault.\n\nThe AGM battery also has significant advantages over simple starter batteries in terms of service life. An AGM battery can handle three times as many charging cycles as a conventional starter battery. Another advantage of the AGM battery is that it is position-independent, since the material integration of the electrolyte means that no liquid can leak out. Even if the battery housing breaks, no battery acid can leak out.\n\nAn AGM battery is the ideal energy storage system for vehicles with automatic start-stop systems with braking energy recovery (recuperation), since a conventional starter battery cannot meet the high performance requirements of these systems. But the AGM battery is also the right choice for cars that have a high energy demand and a large number of electrical consumers on board.\n\nSource: Varta (https://batteryworld.varta-automotive.com/de-de/batterietypen-sli-efb-agm-unterschiede)	0	0	0	0	f	f
392	BMS_Master_Module	No definition available	0	0	0	0	f	t
393	BMS_Slave_Module	A BMS slave module is physical part of a battery module and logically part of the Battery Management System of the battery pack. \nThe BMS consists of one BMS master and one BMS slave for each battery module.\n\nA BMS slave can either consist of a slave circuit board and several temperature and voltage sensors and a contacting unit, \nor can be a completely integrated system. The latter is modeled in this ontology as class Semiconductor - Multichannel_Battery_Monitoring_IC with an Infineon product as instance.	0	0	0	0	f	f
394	Battery_Electric_Bus	No definition available	0	0	0	0	f	t
395	Electric_Bus	No definition available	0	0	0	0	f	t
396	Battery_Electric_Truck	No definition available	0	0	0	0	f	t
397	Electric_Truck	No definition available	0	0	0	0	f	t
398	Conventional_Bus	No definition available	0	0	0	0	f	t
399	Conventional_Vehicle	No definition available	0	0	0	0	f	t
400	Conventional_Light_Commercial_Vehicle	No definition available	0	0	0	0	f	t
401	Conventional_Passenger_Car	No definition available	0	0	0	0	f	t
402	Conventional_Truck	No definition available	0	0	0	0	f	t
403	Current_Measuring_System	No definition available	0	0	0	0	f	t
404	Electric_Means_Transportation	No definition available	0	0	0	0	f	t
440	Switcher	No definition available	0	0	0	0	f	t
441	Infineon_Device	Should defined as its function for example:\n\n-Sensor\n-Power Converter \n-Microcontroller \n\nThen must be defined what the device it is, for exmaple:\n-A sensing device is a device that implments sensing.	0	0	0	0	f	f
442	Maximum_Junction_Temperature	No definition available	0	0	0	0	f	t
496	PowerConverters	No definition available	0	0	0	0	f	t
405	Enhanced_Flooded_Battery	Die EFB-Batterie – viele Ladezyklen und lange Lebensdauer\n\nDie EFB-Batterie ist eine optimierte und leistungsgesteigerte Version der Nassbatterie. Das Kürzel „EFB“ steht für „enhanced flooded battery“. Auch hier sind die Platten mit einem mikroporösen Separator voneinander isoliert. Zwischen Platte und Separator befindet sich zudem ein Polyester-Scrim. Dieses Material hilft, das aktive Material der Platten zu stabilisieren und die Lebensdauer der Batterie zu verlängern. Die EFB-Batterie überzeugt durch eine hohe Zahl an möglichen Ladezyklen und bietet mehr als doppelt so hohe Teilentladungs- und Tiefentladungsleistung im Vergleich mit konventionellen Batterien.\n\nOft wird die EFB-Batterie in Fahrzeugen mit einfacher Start-Stopp-Automatik verbaut. Aufgrund der überlegenen Leistung wird aber auch vermehrt beim Ersatz der herkömmlichen Blei-Säure zu einer Batterie mit EFB-Technologie gegriffen.	0	0	0	0	f	f
406	Fuel_Cell_Electric_Bus	No definition available	0	0	0	0	f	t
407	Fuel_Cell_Electric_Car	No definition available	0	0	0	0	f	t
408	Fully_Electric_Car	No definition available	0	0	0	0	f	t
409	Plugin_Hybrid_Car	No definition available	0	0	0	0	f	t
410	Fuel_Cell_Electric_Truck	No definition available	0	0	0	0	f	t
411	Fuse	No definition available	0	0	0	0	f	t
412	Insulation_Monitoring	No definition available	0	0	0	0	f	t
413	LFP_BMS_Master_Module	No definition available	0	0	0	0	f	t
414	LFP_BMS_Slave_Module	No definition available	0	0	0	0	f	t
415	LFP_Onboard_Electronics_Battery	No definition available	0	0	0	0	f	t
416	Lead_Acid_Battery	Lead-Acid-Batteries (Blei-Säure-Batterien) are traditional car onboard electronics batteries. \nThey are included in this ontology just as a second battery type different from Lithium-Ion batteries.	0	0	0	0	f	f
417	Lead_Acid_Onboard_Electronics_Battery	No definition available	0	0	0	0	f	t
418	Starting_Lighting_Ignition_Battery	Die Nassbatterie (SLI) – bewährt und wirtschaftlich\n\nEine konventionelle Starterbatterie besteht aus sechs Batteriezellen. Eine Batteriezelle, auch Plattenblock genannt, besteht aus einem positiven und einem negativen Plattensatz, die wiederum aus mehreren Elektroden bestehen.\nEine positive Elektrode setzt sich aus aktiver Masse aus Bleioxid und einem positiven Gitter aus einer Bleilegierung zusammen. Die Gittergerüste verleihen den Elektroden eine solide Struktur und dienen gleichzeitig als Stromleiter. Die aktive Masse ist in einen Elektrolyt, ein Gemisch aus Säure und destilliertem Wasser, getaucht.\nEine negative Elektrode setzt sich ebenfalls aus aktiver Masse, hier jedoch bestehend aus purem Blei, und einem negativen Gitter zusammen. Getrennt werden die Elektroden unterschiedlicher Ladung von einem Separator. Durch eine Parallelschaltung der einzelnen Platten in den Zellen wird die benötigte Kapazität einer Batterie erreicht. Aus der Reihenschaltung der einzelnen Zellen ergibt sich die benötigte Spannungsladung von 12 Volt.\n\nHerkömmliche Batterien, wie Blei-Säure-Batterien, gehören zur gängigsten Batterietype. Diese Technologie wird häufig als SLI bezeichnet, was auf die Hauptaufgabe einer Batterie im Fahrzeug zurückgeht: Starting, Lighting, Ignition (Start, Licht, Zündung). Sie eigenen sich für Fahrzeuge ohne Start-Stopp-Technologie und einer moderaten Anzahl von elektrischen Verbrauchern.	0	0	0	0	f	f
419	Li-Ion_BMS_Master_Module	No definition available	0	0	0	0	f	t
420	Li-Ion_BMS_Slave_Module	No definition available	0	0	0	0	f	t
421	Lithium-Ferrophosphate_High_Voltage_Battery	No definition available	0	0	0	0	f	t
422	Lithium-Ion_Onboard_Electronics_Battery	No definition available	0	0	0	0	f	t
423	Pouch_Cell_Battery_Module_Type	It is important to note that the pouch cells expands/shrinks in its thickness during the charging or discharging cycle.\n● Each pouch cell is inserted into a frame.\n● Due to the swelling of the cells, the frames are arrested flexible by springs.\n● Cooling in a pouch module is optional and can be served by either convective or liquid coolant.\n● For example, pouch cells can be serial connected and cooled via U-profiles.	0	0	0	0	f	f
424	Prismatic_Cell_Battery_Module_Type	Prismatic cells can be installed without remaining gaps.\n● The individual cells are glued together.\n● The adhesive film serves both as electrical and thermal insulator in the event of an accident.\n● The cells are clamped with a bandage and/or a plastic or metal housing.	0	0	0	0	f	f
425	Round_Cell_Battery_Module_Type	In the architecture of a round cell module, the cells are fixed by the module case.\n● The space between the cells can be used by a cooling system or direct cooling.\n● The metal housing prevents the cell from swelling.\n● At module level, the cells can be connected both serial and parallel.\n● The cells are contacted via a metal plate on both sides.	0	0	0	0	f	f
426	Pre_Charge_Measuring_System	No definition available	0	0	0	0	f	t
427	Relay	No definition available	0	0	0	0	f	t
428	Trolley_Bus	A trolleybus (also known as trolley bus, trolley coach, trackless trolley, trackless tram – in the 1910s and 1920s[1] – or trolley[2][3]) is an electric bus that draws power from dual overhead wires (generally suspended from roadside posts) using spring-loaded trolley poles. Two wires, and two trolley poles, are required to complete the electrical circuit. This differs from a tram or streetcar, which normally uses the track as the return path, needing only one wire and one pole (or pantograph). They are also distinct from other kinds of electric buses, which usually rely on batteries. Power is most commonly supplied as 600-volt direct current, but there are exceptions.\n\nCurrently, around 300 trolleybus systems are in operation, in cities and towns in 43 countries.[4] Altogether, more than 800 trolleybus systems have existed, but not more than about 400 concurrently	0	0	0	0	f	f
429	Trolley_Truck	No definition available	0	0	0	0	f	t
430	Serial_Peripheral_Interface	No definition available	0	0	0	0	f	t
431	Customer_Plant_Data	No definition available	0	0	0	0	f	t
432	The_Application_Voltage	No definition available	0	0	0	0	f	t
433	Drain_Voltagea	No definition available	0	0	0	0	f	t
434	Depletion_Mode	No definition available	0	0	0	0	f	t
435	Variable_Resistance	No definition available	0	0	0	0	f	t
436	On-State_Power_loss	No definition available	0	0	0	0	f	t
437	DrainCurrent	No definition available	0	0	0	0	f	t
438	On-State_Resistance	No definition available	0	0	0	0	f	t
439	Enhancement	No definition available	0	0	0	0	f	t
443	The_method_of_the_device_function	The function of the devices has a method ( Procedure to estimate or calculate a value), for example:\nThe Senor its function is the sensing, the sensing method is the observation\nThe Boost converter ( a type of the power converter) its function is boosting, the boosting method is the amplification.  \n\nAct of carrying out an (the method) Procedure to estimate or calculate a value of a property of a FeatureOfInterest. Links to an the methodProperty to describe what the result is an estimate of, and to a FeatureOfInterest to detail what that proeprty was associated with.\n\nExample: The activity of estimating the intensity of an earthquake using the Mercalli intensity scale is an Observation as is measuring the moment magnitude, i.e., the energy released by said earthquake."	0	0	0	0	f	f
444	Semiconductors	No definition available	0	0	0	0	f	t
445	Products	The superclass of all classes describing products or services types, either by nature or purpose. Examples for such subclasses are "TV set", "vacuum cleaner", etc. An instance of this class can be either an actual product or service (gr:Individual), a placeholder instance for unknown instances of a mass-produced commodity (gr:SomeItems), or a model / prototype specification (gr:ProductOrServiceModel). When in doubt, use gr:SomeItems.\n\nExamples: \na) MyCellphone123, i.e. my personal, tangible cell phone (gr:Individual)\nb) Siemens1234, i.e. the Siemens cell phone make and model 1234 (gr:ProductOrServiceModel)\nc) dummyCellPhone123 as a placeholder for actual instances of a certain kind of cell phones (gr:SomeItems)	0	0	0	0	f	f
446	Device_Configuration	No definition available	0	0	0	0	f	t
448	Device_Elements	No definition available	0	0	0	0	f	t
449	SemiconductorProduct(its_name)_DataSheet	No definition available	0	0	0	0	f	t
450	On-State_Voltage	No definition available	0	0	0	0	f	t
451	Threshold_Voltage	No definition available	0	0	0	0	f	t
452	Region_of_Operation	No definition available	0	0	0	0	f	t
453	Process_Output	Any information that is reported from a Procedure.	0	0	0	0	f	f
454	Platform	An Entity to which other Entities can be attached - particularly semiconductor products and other platforms.\n\nExample: A post might act as the platform, a body might act as a platform for an attached device.	0	0	0	0	f	f
455	Operation_Mode	No definition available	0	0	0	0	f	t
456	Resistance	No definition available	0	0	0	0	f	t
457	Junction_Temperature	No definition available	0	0	0	0	f	t
458	Semiconductors&SemiconductorEquipment	No definition available	0	0	0	0	f	t
459	N-Channel_Configuration	No definition available	0	0	0	0	f	t
460	Postive_(+)	No definition available	0	0	0	0	f	t
461	P-channel_Configuration	No definition available	0	0	0	0	f	t
462	Negative_(-)	No definition available	0	0	0	0	f	t
463	Operating_Property	No definition available	0	0	0	0	f	t
464	Physical_Object	No definition available	0	0	0	0	f	t
465	Abstract	Any Entity that cannot be located in space-time.\n\nExample: mathematical entities: formal semantics elements, regions within dimensional spaces, etc."	0	0	0	0	f	f
466	Blocking_Capability	No definition available	0	0	0	0	f	t
467	Blocking_Voltage	No definition available	0	0	0	0	f	t
468	CommunicationServices	No definition available	0	0	0	0	f	t
469	IndutrialSector	The collection of all localized groups of enterprises that are producers of industrial commodities, in which each such group together forms the major industrial sector for the region. 'Industrial commodities' includes MechanicalDevices and basic industrial materials. Examples include 'the world industrial sector', the 'industrial sector of China'. The Chinese water pump industry would not be an exemplar of IndustrialEconomicSector but would rather be a sub-industry (see subIndustries) of it. On the other hand, chinese water pump manufacturers would be considered groupMembers of 'the industrial sector of China'.\n\nThis classification is done by The Global Industry Classification Standard (GICS) is an industry taxonomy developed in 1999 by MSCI and Standard & Poor's (S&P) for use by the global financial community. The GICS structure consists of 11 sectors, 24 industry groups, 68 industries and 157 sub-industries[1] into which S&P has categorized all major public companies	0	0	0	0	f	f
470	Constant_Resistance	No definition available	0	0	0	0	f	t
471	ConsumerDiscretionary	No definition available	0	0	0	0	f	t
472	ConsumerStaples	No definition available	0	0	0	0	f	t
473	InformationEntity	No definition available	0	0	0	0	f	t
474	Drain	No definition available	0	0	0	0	f	t
475	Drain-Source_Voltage	No definition available	0	0	0	0	f	t
476	Electric_Vehicle_Charging	No definition available	0	0	0	0	f	t
477	ElectronicComponents	No definition available	0	0	0	0	f	t
478	ElectronicEquipment,Instruments&Components	No definition available	0	0	0	0	f	t
479	TechnologyHardware&Equipment	No definition available	0	0	0	0	f	t
480	Energy	No definition available	0	0	0	0	f	t
481	Energy_Storage	No definition available	0	0	0	0	f	t
482	Financial	No definition available	0	0	0	0	f	t
483	Gate	No definition available	0	0	0	0	f	t
484	GateDriver	No definition available	0	0	0	0	f	t
485	Healthcare	No definition available	0	0	0	0	f	t
486	Height	No definition available	0	0	0	0	f	t
487	Industrials	No definition available	0	0	0	0	f	t
488	InformationTechnology	No definition available	0	0	0	0	f	t
489	Leakage_Current	No definition available	0	0	0	0	f	t
490	Length	No definition available	0	0	0	0	f	t
491	Materials	No definition available	0	0	0	0	f	t
492	Microcontroller	No definition available	0	0	0	0	f	t
493	Off-State_Region	No definition available	0	0	0	0	f	t
494	On-State_Region	No definition available	0	0	0	0	f	t
495	Voltage	No definition available	0	0	0	0	f	t
497	Price	No definition available	0	0	0	0	f	t
498	RealEstate	No definition available	0	0	0	0	f	t
499	Saturation_Region	No definition available	0	0	0	0	f	t
500	Triode/Constant_Resistance_Region	No definition available	0	0	0	0	f	t
501	Sensors	No definition available	0	0	0	0	f	t
502	Social_Object	Act of carrying out an (Observation) Procedure to estimate or calculate a value of a property of a FeatureOfInterest. Links to an ObservableProperty to describe what the result is an estimate of, and to a FeatureOfInterest to detail what that proeprty was associated with.\n\nExample: The activity of estimating the intensity of an earthquake using the Mercalli intensity scale is an Observation as is measuring the moment magnitude, i.e., the energy released by said earthquake.	0	0	0	0	f	f
503	Solar_Energy	No definition available	0	0	0	0	f	t
504	Source	No definition available	0	0	0	0	f	t
\.


--
-- TOC entry 3491 (class 0 OID 16816)
-- Dependencies: 225
-- Data for Name: department_ontology_association; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department_ontology_association (id, department, ontology_id) FROM stdin;
1	CSC (Corporate Supply Chain)	1
2	CSC (Corporate Supply Chain)	2
3	GIP (Green Industrial Power)	3
4	PSS (Power & Sensor Systems)	4
5	PSS (Power & Sensor Systems)	5
\.


--
-- TOC entry 3515 (class 0 OID 16943)
-- Dependencies: 249
-- Data for Name: extended_user_definitions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.extended_user_definitions (id, profile_id, profile_class, profile_definition, action_type, revised_definition, alternative_name, abbreviation, german_name, example, ontology_iri) FROM stdin;
1	1	Customer_Data	Customer data such as address and company name	entered	My new definition	alternative name	abbreviation	German Name	Example	http://www.w3id.org/ecsel-dr-OM#
\.


--
-- TOC entry 3504 (class 0 OID 16881)
-- Dependencies: 238
-- Data for Name: game_information; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_information (id, profile_id, department, ontology_id, num_questions, random_word, random_definition) FROM stdin;
1	1	CSC (Corporate Supply Chain)	3	5	Supply	This is the total amount of specific products that is available to customers. Supply has the dimensions quantity, time, location, product, including aggregation of all dimensions. Supply is defined as inventory or plan replenishment.
\.


--
-- TOC entry 3488 (class 0 OID 16806)
-- Dependencies: 222
-- Data for Name: ontology; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ontology (id, name, description, image_url, ontology_url) FROM stdin;
1	Bms System V5.04 Dr	This ontology deals with the domain BMS System v5.04	picture/ontologies_pictures/bms_system_v5.04_DR.jpg	bms_system_v5.04_DR.rdf
2	Microcontroller	This ontology deals with the domain microcontroller.	picture/ontologies_pictures/microcontroller.jpg	microcontroller.rdf
3	Ordermanagement	This ontology deals with the domain order management.	picture/ontologies_pictures/OrderManagement.jpg	OrderManagement.rdf
4	Power	Power2Power is an European co-funded innovation project on Semiconductor Industry with the goal of conducting the research and development of innovative power semiconductors with more power density and energy efficiency	picture/ontologies_pictures/Power.jpg	Power.rdf
5	Sc Planning	This ontology represents how Infineon’s Supply Chain Planning works and which role deviations play in this process.	picture/ontologies_pictures/SC_Planning.jpg	SC_Planning.rdf
6	Sensor	This ontology deals with the domain sensor.	picture/ontologies_pictures/sensor.jpg	sensor.rdf
7	Supplychain	This ontology deals with the domain SupplyChain.	picture/ontologies_pictures/supplychain.jpg	supplychain.rdf
8	Your Ontology	\N	picture/ontologies_pictures/YOUR_ONTOLOGY.jpg	YOUR_ONTOLOGY.rdf
\.


--
-- TOC entry 3495 (class 0 OID 16838)
-- Dependencies: 229
-- Data for Name: profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profile (id, username, profile_picture, level, xp, user_id) FROM stdin;
1	Nils	picture/user_profile/user2-removebg-preview.png	15	12660	1
2	Tim	picture/user_profile/user1-removebg-preview.png	0	0	2
3	Marie	picture/user_profile/user1-removebg-preview.png	0	24	3
4	Syha	picture/user_profile/user1-removebg-preview.png	1	110	4
5	Jon	picture/user_profile/user1-removebg-preview.png	0	0	1
6	Demo	picture/user_profile/user1-removebg-preview.png	0	0	6
\.


--
-- TOC entry 3507 (class 0 OID 16902)
-- Dependencies: 241
-- Data for Name: used_word; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.used_word (id, profile_id, word_uri) FROM stdin;
1	1	http://www.w3id.org/ecsel-dr-OM#Customer_Data
2	2	http://www.w3id.org/ecsel-dr-OM#Supply
\.


--
-- TOC entry 3493 (class 0 OID 16829)
-- Dependencies: 227
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, email, password, first_name) FROM stdin;
1	nils@gmail.com	pbkdf2:sha256:600000$AQZjXuClZdWr7PRb$6d22cbeb17e2a776d29318ef9b71b2bac296c4033b13d78564cc3b5316a76332	Nils
2	tim@gmail.com	pbkdf2:sha256:600000$pZTTiAtqySeePd6E$f896c8dc3b0317099ab6d871bef00a701718eb8a3978228b74cc936d3e1cd031	Tim
3	marie@gmail.com	pbkdf2:sha256:600000$8DKqUWsppIDgXyOd$54de10d235243b01745a09c265a7fb4b551d79e172f35f6c9a88767b47a15de6	Marie
4	abcd@gmail.com	pbkdf2:sha256:600000$HuxL2dxHa3qQDZ0O$2b2d38b973a8575593ea6b72deba47f3eddd171116fae17cfb109b9a40881d24	Syha
5	jon.legorburu@infineon.com	pbkdf2:sha256:600000$zaesaVlpgSdBbxkt$9c3eb417dcc8e7d3a3b0befac2a8e685a4bbf22b13f500a5862d346e60418853	Jon
6	demo@demo	pbkdf2:sha256:600000$4jVexYbsYLV1Onv5$33e25e7e50057d0ac327c84a7408c76de88f7d851ec2eb643b9e2be345a0236d	Demo
\.


--
-- TOC entry 3501 (class 0 OID 16861)
-- Dependencies: 235
-- Data for Name: user_challenges; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_challenges (id, user_id, challenge_id, completed) FROM stdin;
\.


--
-- TOC entry 3512 (class 0 OID 16927)
-- Dependencies: 246
-- Data for Name: user_definitions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_definitions (id, profile_id, profile_class, profile_definition, action_type, revised_definition) FROM stdin;
1	1	Customer_Data	Customer data such as address and company name	entered	My new definition
\.


--
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 230
-- Name: challenges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.challenges_id_seq', 1, false);


--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 242
-- Name: definition_scores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.definition_scores_id_seq', 570, true);


--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 223
-- Name: department_ontology_association_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.department_ontology_association_id_seq', 5, true);


--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 224
-- Name: department_ontology_association_ontology_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.department_ontology_association_ontology_id_seq', 5, true);


--
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 247
-- Name: extended_user_definitions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.extended_user_definitions_id_seq', 1, true);


--
-- TOC entry 3545 (class 0 OID 0)
-- Dependencies: 248
-- Name: extended_user_definitions_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.extended_user_definitions_profile_id_seq', 1, true);


--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 236
-- Name: game_information_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.game_information_id_seq', 1, true);


--
-- TOC entry 3547 (class 0 OID 0)
-- Dependencies: 237
-- Name: game_information_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.game_information_profile_id_seq', 1, true);


--
-- TOC entry 3548 (class 0 OID 0)
-- Dependencies: 221
-- Name: ontology_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ontology_id_seq', 8, true);


--
-- TOC entry 3549 (class 0 OID 0)
-- Dependencies: 228
-- Name: profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profile_id_seq', 6, true);


--
-- TOC entry 3550 (class 0 OID 0)
-- Dependencies: 239
-- Name: used_word_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.used_word_id_seq', 2, true);


--
-- TOC entry 3551 (class 0 OID 0)
-- Dependencies: 240
-- Name: used_word_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.used_word_profile_id_seq', 2, true);


--
-- TOC entry 3552 (class 0 OID 0)
-- Dependencies: 234
-- Name: user_challenges_challenge_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_challenges_challenge_id_seq', 1, false);


--
-- TOC entry 3553 (class 0 OID 0)
-- Dependencies: 232
-- Name: user_challenges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_challenges_id_seq', 1, false);


--
-- TOC entry 3554 (class 0 OID 0)
-- Dependencies: 233
-- Name: user_challenges_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_challenges_user_id_seq', 1, false);


--
-- TOC entry 3555 (class 0 OID 0)
-- Dependencies: 244
-- Name: user_definitions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_definitions_id_seq', 1, true);


--
-- TOC entry 3556 (class 0 OID 0)
-- Dependencies: 245
-- Name: user_definitions_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_definitions_profile_id_seq', 1, true);


--
-- TOC entry 3557 (class 0 OID 0)
-- Dependencies: 226
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 6, true);


--
-- TOC entry 3320 (class 2606 OID 16857)
-- Name: challenges challenges_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.challenges
    ADD CONSTRAINT challenges_pkey PRIMARY KEY (id);


--
-- TOC entry 3328 (class 2606 OID 16924)
-- Name: definition_scores definition_scores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.definition_scores
    ADD CONSTRAINT definition_scores_pkey PRIMARY KEY (id);


--
-- TOC entry 3312 (class 2606 OID 16822)
-- Name: department_ontology_association department_ontology_association_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department_ontology_association
    ADD CONSTRAINT department_ontology_association_pkey PRIMARY KEY (id);


--
-- TOC entry 3332 (class 2606 OID 16951)
-- Name: extended_user_definitions extended_user_definitions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.extended_user_definitions
    ADD CONSTRAINT extended_user_definitions_pkey PRIMARY KEY (id);


--
-- TOC entry 3324 (class 2606 OID 16889)
-- Name: game_information game_information_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_information
    ADD CONSTRAINT game_information_pkey PRIMARY KEY (id);


--
-- TOC entry 3310 (class 2606 OID 16813)
-- Name: ontology ontology_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ontology
    ADD CONSTRAINT ontology_pkey PRIMARY KEY (id);


--
-- TOC entry 3318 (class 2606 OID 16843)
-- Name: profile profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_pkey PRIMARY KEY (id);


--
-- TOC entry 3326 (class 2606 OID 16910)
-- Name: used_word used_word_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.used_word
    ADD CONSTRAINT used_word_pkey PRIMARY KEY (id);


--
-- TOC entry 3322 (class 2606 OID 16868)
-- Name: user_challenges user_challenges_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_challenges
    ADD CONSTRAINT user_challenges_pkey PRIMARY KEY (id);


--
-- TOC entry 3330 (class 2606 OID 16935)
-- Name: user_definitions user_definitions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_definitions
    ADD CONSTRAINT user_definitions_pkey PRIMARY KEY (id);


--
-- TOC entry 3314 (class 2606 OID 16836)
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- TOC entry 3316 (class 2606 OID 16834)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 3333 (class 2606 OID 16823)
-- Name: department_ontology_association department_ontology_association_ontology_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department_ontology_association
    ADD CONSTRAINT department_ontology_association_ontology_id_fkey FOREIGN KEY (ontology_id) REFERENCES public.ontology(id);


--
-- TOC entry 3341 (class 2606 OID 16952)
-- Name: extended_user_definitions extended_user_definitions_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.extended_user_definitions
    ADD CONSTRAINT extended_user_definitions_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES public.profile(id);


--
-- TOC entry 3337 (class 2606 OID 16895)
-- Name: game_information game_information_ontology_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_information
    ADD CONSTRAINT game_information_ontology_id_fkey FOREIGN KEY (ontology_id) REFERENCES public.ontology(id);


--
-- TOC entry 3338 (class 2606 OID 16890)
-- Name: game_information game_information_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_information
    ADD CONSTRAINT game_information_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES public.profile(id);


--
-- TOC entry 3334 (class 2606 OID 16844)
-- Name: profile profile_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- TOC entry 3339 (class 2606 OID 16911)
-- Name: used_word used_word_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.used_word
    ADD CONSTRAINT used_word_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES public.profile(id);


--
-- TOC entry 3335 (class 2606 OID 16874)
-- Name: user_challenges user_challenges_challenge_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_challenges
    ADD CONSTRAINT user_challenges_challenge_id_fkey FOREIGN KEY (challenge_id) REFERENCES public.challenges(id);


--
-- TOC entry 3336 (class 2606 OID 16869)
-- Name: user_challenges user_challenges_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_challenges
    ADD CONSTRAINT user_challenges_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- TOC entry 3340 (class 2606 OID 16936)
-- Name: user_definitions user_definitions_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_definitions
    ADD CONSTRAINT user_definitions_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES public.profile(id) ON DELETE CASCADE;


-- Completed on 2025-01-24 18:41:40

--
-- PostgreSQL database dump complete
--

