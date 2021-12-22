--
-- PostgreSQL database dump
--

-- Dumped from database version 13.5
-- Dumped by pg_dump version 14.1

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: comment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comment (
    id integer NOT NULL,
    conference_id integer NOT NULL,
    author character varying(255) NOT NULL,
    text text NOT NULL,
    email character varying(255) NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    photo_filename character varying(255) DEFAULT NULL::character varying
);


--
-- Name: comment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: conference; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.conference (
    id integer NOT NULL,
    city character varying(255) NOT NULL,
    year character varying(4) NOT NULL,
    is_international boolean NOT NULL
);


--
-- Name: conference_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.conference_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: doctrine_migration_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.doctrine_migration_versions (
    version character varying(191) NOT NULL,
    executed_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    execution_time integer
);


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.comment (id, conference_id, author, text, email, created_at, photo_filename) FROM stdin;
\.


--
-- Data for Name: conference; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.conference (id, city, year, is_international) FROM stdin;
\.


--
-- Data for Name: doctrine_migration_versions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.doctrine_migration_versions (version, executed_at, execution_time) FROM stdin;
DoctrineMigrations\\Version20211221221752	2021-12-21 22:23:19	124
\.


--
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.comment_id_seq', 1, false);


--
-- Name: conference_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.conference_id_seq', 1, false);


--
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- Name: conference conference_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conference
    ADD CONSTRAINT conference_pkey PRIMARY KEY (id);


--
-- Name: doctrine_migration_versions doctrine_migration_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.doctrine_migration_versions
    ADD CONSTRAINT doctrine_migration_versions_pkey PRIMARY KEY (version);


--
-- Name: idx_9474526c604b8382; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_9474526c604b8382 ON public.comment USING btree (conference_id);


--
-- Name: comment fk_9474526c604b8382; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT fk_9474526c604b8382 FOREIGN KEY (conference_id) REFERENCES public.conference(id);


--
-- PostgreSQL database dump complete
--

