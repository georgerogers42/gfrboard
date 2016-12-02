--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: boards; Type: TABLE; Schema: public; Owner: gfr
--

CREATE TABLE boards (
    id integer NOT NULL,
    name character varying NOT NULL
);


--
-- Name: boards_id_seq; Type: SEQUENCE; Schema: public; Owner: gfr
--

CREATE SEQUENCE boards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: boards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gfr
--

ALTER SEQUENCE boards_id_seq OWNED BY boards.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: gfr
--

CREATE TABLE posts (
    id integer NOT NULL,
    thread_id integer NOT NULL,
    contents text NOT NULL,
    posted timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: gfr
--

CREATE SEQUENCE posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gfr
--

ALTER SEQUENCE posts_id_seq OWNED BY posts.id;


--
-- Name: threads; Type: TABLE; Schema: public; Owner: gfr
--

CREATE TABLE threads (
    id integer NOT NULL,
    board_id integer NOT NULL,
    title character varying NOT NULL,
    contents text NOT NULL,
    posted timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT title_non_empty CHECK (((title)::text <> ''::text))
);


--
-- Name: threads_id_seq; Type: SEQUENCE; Schema: public; Owner: gfr
--

CREATE SEQUENCE threads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: threads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gfr
--

ALTER SEQUENCE threads_id_seq OWNED BY threads.id;


--
-- Name: boards id; Type: DEFAULT; Schema: public; Owner: gfr
--

ALTER TABLE ONLY boards ALTER COLUMN id SET DEFAULT nextval('boards_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: gfr
--

ALTER TABLE ONLY posts ALTER COLUMN id SET DEFAULT nextval('posts_id_seq'::regclass);


--
-- Name: threads id; Type: DEFAULT; Schema: public; Owner: gfr
--

ALTER TABLE ONLY threads ALTER COLUMN id SET DEFAULT nextval('threads_id_seq'::regclass);


--
-- Data for Name: boards; Type: TABLE DATA; Schema: public; Owner: gfr
--

COPY boards (id, name) FROM stdin;
1	pol
\.


--
-- Name: boards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gfr
--

SELECT pg_catalog.setval('boards_id_seq', 1, true);


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: gfr
--

COPY posts (id, thread_id, contents, posted) FROM stdin;
\.


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gfr
--

SELECT pg_catalog.setval('posts_id_seq', 5, true);


--
-- Data for Name: threads; Type: TABLE DATA; Schema: public; Owner: gfr
--

COPY threads (id, board_id, title, contents, posted) FROM stdin;
7	1	Iron	*Maiden*	2016-12-02 16:28:42.590462
\.


--
-- Name: threads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gfr
--

SELECT pg_catalog.setval('threads_id_seq', 7, true);


--
-- Name: boards boards_name_key; Type: CONSTRAINT; Schema: public; Owner: gfr
--

ALTER TABLE ONLY boards
    ADD CONSTRAINT boards_name_key UNIQUE (name);


--
-- Name: boards boards_pkey; Type: CONSTRAINT; Schema: public; Owner: gfr
--

ALTER TABLE ONLY boards
    ADD CONSTRAINT boards_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: gfr
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: threads threads_pkey; Type: CONSTRAINT; Schema: public; Owner: gfr
--

ALTER TABLE ONLY threads
    ADD CONSTRAINT threads_pkey PRIMARY KEY (id);


--
-- Name: threads threads_title_contents_key; Type: CONSTRAINT; Schema: public; Owner: gfr
--

ALTER TABLE ONLY threads
    ADD CONSTRAINT threads_title_contents_key UNIQUE (title, contents);


--
-- Name: posts posts_thread_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gfr
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_thread_id_fkey FOREIGN KEY (thread_id) REFERENCES threads(id) ON DELETE CASCADE;


--
-- Name: threads threads_board_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gfr
--

ALTER TABLE ONLY threads
    ADD CONSTRAINT threads_board_id_fkey FOREIGN KEY (board_id) REFERENCES boards(id);


--
-- PostgreSQL database dump complete
--

