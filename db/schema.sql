\restrict 0KW0tcN52jGHb8xtNZsuYxO0xvpXwlRB6jSXagZwyC8o3kBV9tt3XWy78BNrH4k

-- Dumped from database version 18.1 (Debian 18.1-1.pgdg13+2)
-- Dumped by pg_dump version 18.1

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

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: vector; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS vector WITH SCHEMA public;


--
-- Name: EXTENSION vector; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION vector IS 'vector data type and ivfflat and hnsw access methods';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: movie; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.movie (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    imdb_id character varying(256) NOT NULL,
    type text NOT NULL,
    primary_title text NOT NULL,
    original_title text,
    primary_image jsonb,
    start_year integer,
    runtime_seconds integer,
    genres text[] NOT NULL,
    rating jsonb,
    plot text NOT NULL,
    embedding public.vector(1536),
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: raw_movie_api; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.raw_movie_api (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    movie_external_id character varying(255),
    payload jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: raw_movie_embedding; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.raw_movie_embedding (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    movie_external_id character varying(256),
    input_text text NOT NULL,
    embedding public.vector(1536) NOT NULL,
    embedded_at timestamp with time zone DEFAULT now()
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: movie movie_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movie
    ADD CONSTRAINT movie_pkey PRIMARY KEY (id);


--
-- Name: raw_movie_api raw_movie_api_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.raw_movie_api
    ADD CONSTRAINT raw_movie_api_pkey PRIMARY KEY (id);


--
-- Name: raw_movie_embedding raw_movie_embedding_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.raw_movie_embedding
    ADD CONSTRAINT raw_movie_embedding_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: movie_embedding_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX movie_embedding_idx ON public.movie USING hnsw (embedding public.vector_l2_ops);


--
-- PostgreSQL database dump complete
--

\unrestrict 0KW0tcN52jGHb8xtNZsuYxO0xvpXwlRB6jSXagZwyC8o3kBV9tt3XWy78BNrH4k


--
-- Dbmate schema migrations
--

INSERT INTO public.schema_migrations (version) VALUES
    ('20231004084927'),
    ('20251123103329'),
    ('20251123103505'),
    ('20251123103817'),
    ('20251123104154');
