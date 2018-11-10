--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 10.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
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


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: follower
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO follower;

--
-- Name: followers; Type: TABLE; Schema: public; Owner: follower
--

CREATE TABLE public.followers (
    id bigint NOT NULL,
    user_id bigint,
    follower_id bigint,
    CONSTRAINT user_id_cannot_be_equal_follower_id_check CHECK ((user_id <> follower_id))
);


ALTER TABLE public.followers OWNER TO follower;

--
-- Name: followers_id_seq; Type: SEQUENCE; Schema: public; Owner: follower
--

CREATE SEQUENCE public.followers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.followers_id_seq OWNER TO follower;

--
-- Name: followers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: follower
--

ALTER SEQUENCE public.followers_id_seq OWNED BY public.followers.id;


--
-- Name: groups; Type: TABLE; Schema: public; Owner: follower
--

CREATE TABLE public.groups (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.groups OWNER TO follower;

--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: follower
--

CREATE SEQUENCE public.groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groups_id_seq OWNER TO follower;

--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: follower
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: follower
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO follower;

--
-- Name: users; Type: TABLE; Schema: public; Owner: follower
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying,
    group_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    followers_count integer DEFAULT 0
);


ALTER TABLE public.users OWNER TO follower;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: follower
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO follower;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: follower
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: followers id; Type: DEFAULT; Schema: public; Owner: follower
--

ALTER TABLE ONLY public.followers ALTER COLUMN id SET DEFAULT nextval('public.followers_id_seq'::regclass);


--
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: follower
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: follower
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: follower
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: followers followers_pkey; Type: CONSTRAINT; Schema: public; Owner: follower
--

ALTER TABLE ONLY public.followers
    ADD CONSTRAINT followers_pkey PRIMARY KEY (id);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: follower
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: follower
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: follower
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_followers_on_follower_id; Type: INDEX; Schema: public; Owner: follower
--

CREATE INDEX index_followers_on_follower_id ON public.followers USING btree (follower_id);


--
-- Name: index_followers_on_user_id; Type: INDEX; Schema: public; Owner: follower
--

CREATE INDEX index_followers_on_user_id ON public.followers USING btree (user_id);


--
-- Name: index_followers_on_user_id_and_follower_id; Type: INDEX; Schema: public; Owner: follower
--

CREATE UNIQUE INDEX index_followers_on_user_id_and_follower_id ON public.followers USING btree (user_id, follower_id);


--
-- Name: index_users_on_group_id; Type: INDEX; Schema: public; Owner: follower
--

CREATE INDEX index_users_on_group_id ON public.users USING btree (group_id);


--
-- Name: followers fk_rails_3d258d3942; Type: FK CONSTRAINT; Schema: public; Owner: follower
--

ALTER TABLE ONLY public.followers
    ADD CONSTRAINT fk_rails_3d258d3942 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: followers fk_rails_5b83ba9503; Type: FK CONSTRAINT; Schema: public; Owner: follower
--

ALTER TABLE ONLY public.followers
    ADD CONSTRAINT fk_rails_5b83ba9503 FOREIGN KEY (follower_id) REFERENCES public.users(id);


--
-- Name: users fk_rails_f40b3f4da6; Type: FK CONSTRAINT; Schema: public; Owner: follower
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rails_f40b3f4da6 FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- PostgreSQL database dump complete
--

