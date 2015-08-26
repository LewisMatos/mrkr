--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

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
-- Name: links; Type: TABLE; Schema: public; Owner: cranium; Tablespace: 
--

CREATE TABLE links (
    id integer NOT NULL,
    uri text
);


ALTER TABLE links OWNER TO cranium;

--
-- Name: links_id_seq; Type: SEQUENCE; Schema: public; Owner: cranium
--

CREATE SEQUENCE links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE links_id_seq OWNER TO cranium;

--
-- Name: links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cranium
--

ALTER SEQUENCE links_id_seq OWNED BY links.id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: cranium; Tablespace: 
--

CREATE TABLE permissions (
    userid integer,
    projectid integer,
    permissions boolean DEFAULT false
);


ALTER TABLE permissions OWNER TO cranium;

--
-- Name: projectlinks; Type: TABLE; Schema: public; Owner: cranium; Tablespace: 
--

CREATE TABLE projectlinks (
    projectid integer NOT NULL,
    linkid integer NOT NULL,
    userid integer NOT NULL,
    date_added timestamp without time zone DEFAULT ('now'::text)::date
);


ALTER TABLE projectlinks OWNER TO cranium;

--
-- Name: projects; Type: TABLE; Schema: public; Owner: cranium; Tablespace: 
--

CREATE TABLE projects (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE projects OWNER TO cranium;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: cranium
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE projects_id_seq OWNER TO cranium;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cranium
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: cranium; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    username text
);


ALTER TABLE users OWNER TO cranium;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: cranium
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO cranium;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cranium
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cranium
--

ALTER TABLE ONLY links ALTER COLUMN id SET DEFAULT nextval('links_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cranium
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cranium
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: links; Type: TABLE DATA; Schema: public; Owner: cranium
--

COPY links (id, uri) FROM stdin;
1	http://www.postgresql.org/docs/8.2/static/functions-datetime.html#FUNCTIONS-DATETIME-CURRENT
\.


--
-- Name: links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cranium
--

SELECT pg_catalog.setval('links_id_seq', 2, true);


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: cranium
--

COPY permissions (userid, projectid, permissions) FROM stdin;
1	1	t
\.


--
-- Data for Name: projectlinks; Type: TABLE DATA; Schema: public; Owner: cranium
--

COPY projectlinks (projectid, linkid, userid, date_added) FROM stdin;
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: cranium
--

COPY projects (id, name) FROM stdin;
1	mrkr
\.


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cranium
--

SELECT pg_catalog.setval('projects_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: cranium
--

COPY users (id, username) FROM stdin;
1	Cranium
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cranium
--

SELECT pg_catalog.setval('users_id_seq', 1, true);


--
-- Name: links_pkey; Type: CONSTRAINT; Schema: public; Owner: cranium; Tablespace: 
--

ALTER TABLE ONLY links
    ADD CONSTRAINT links_pkey PRIMARY KEY (id);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: public; Owner: cranium; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: cranium; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: permissions_projectid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cranium
--

ALTER TABLE ONLY permissions
    ADD CONSTRAINT permissions_projectid_fkey FOREIGN KEY (projectid) REFERENCES projects(id);


--
-- Name: permissions_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cranium
--

ALTER TABLE ONLY permissions
    ADD CONSTRAINT permissions_userid_fkey FOREIGN KEY (userid) REFERENCES users(id);


--
-- Name: projectlinks_linkid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cranium
--

ALTER TABLE ONLY projectlinks
    ADD CONSTRAINT projectlinks_linkid_fkey FOREIGN KEY (linkid) REFERENCES links(id);


--
-- Name: projectlinks_projectid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cranium
--

ALTER TABLE ONLY projectlinks
    ADD CONSTRAINT projectlinks_projectid_fkey FOREIGN KEY (projectid) REFERENCES projects(id);


--
-- Name: projectlinks_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cranium
--

ALTER TABLE ONLY projectlinks
    ADD CONSTRAINT projectlinks_userid_fkey FOREIGN KEY (userid) REFERENCES users(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: cranium
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM cranium;
GRANT ALL ON SCHEMA public TO cranium;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

