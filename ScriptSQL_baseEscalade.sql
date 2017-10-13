
CREATE SEQUENCE public.cotation_id_cotation_seq;

CREATE TABLE public.cotation (
                id_cotation INTEGER NOT NULL DEFAULT nextval('public.cotation_id_cotation_seq'),
                type_escalade VARCHAR(200) NOT NULL,
                CONSTRAINT cotation_pk PRIMARY KEY (id_cotation)
);


ALTER SEQUENCE public.cotation_id_cotation_seq OWNED BY public.cotation.id_cotation;

CREATE SEQUENCE public.profil_id_profil_seq;

CREATE TABLE public.profil (
                id_profil INTEGER NOT NULL DEFAULT nextval('public.profil_id_profil_seq'),
                passw VARCHAR(250) NOT NULL,
                login VARCHAR(100) NOT NULL,
                CONSTRAINT profil_pk PRIMARY KEY (id_profil)
);


ALTER SEQUENCE public.profil_id_profil_seq OWNED BY public.profil.id_profil;

CREATE SEQUENCE public.grimpeur_id_grimpeur_seq;

CREATE TABLE public.grimpeur (
                id_grimpeur INTEGER NOT NULL DEFAULT nextval('public.grimpeur_id_grimpeur_seq'),
                id_profil INTEGER NOT NULL,
                nom_grimpeur VARCHAR(100) NOT NULL,
                prenom_grimpeur VARCHAR(100) NOT NULL,
                adresse_grimpeur VARCHAR(200),
                CONSTRAINT grimpeur_pk PRIMARY KEY (id_grimpeur)
);


ALTER SEQUENCE public.grimpeur_id_grimpeur_seq OWNED BY public.grimpeur.id_grimpeur;

CREATE SEQUENCE public.commentaire_id_com_seq;

CREATE TABLE public.commentaire (
                id_com INTEGER NOT NULL DEFAULT nextval('public.commentaire_id_com_seq'),
                id_grimpeur INTEGER NOT NULL,
                libelle_com TEXT NOT NULL,
                date_com DATE NOT NULL,
                CONSTRAINT commentaire_pk PRIMARY KEY (id_com)
);


ALTER SEQUENCE public.commentaire_id_com_seq OWNED BY public.commentaire.id_com;

CREATE SEQUENCE public.site_id_site_seq;

CREATE TABLE public.site (
                id_site INTEGER NOT NULL DEFAULT nextval('public.site_id_site_seq'),
                nom_site VARCHAR(150) NOT NULL,
                exposition VARCHAR(100) NOT NULL,
                classement VARCHAR(200) NOT NULL,
                coordonnee VARCHAR(300) NOT NULL,
                CONSTRAINT site_pk PRIMARY KEY (id_site)
);


ALTER SEQUENCE public.site_id_site_seq OWNED BY public.site.id_site;

CREATE SEQUENCE public.secteur_id_secteur_seq;

CREATE TABLE public.secteur (
                id_secteur INTEGER NOT NULL DEFAULT nextval('public.secteur_id_secteur_seq'),
                id_site INTEGER NOT NULL,
                nom_secteur VARCHAR(200) NOT NULL,
                CONSTRAINT secteur_pk PRIMARY KEY (id_secteur)
);


ALTER SEQUENCE public.secteur_id_secteur_seq OWNED BY public.secteur.id_secteur;

CREATE SEQUENCE public.voie_id_voie_seq;

CREATE TABLE public.voie (
                id_voie INTEGER NOT NULL DEFAULT nextval('public.voie_id_voie_seq'),
                id_secteur INTEGER NOT NULL,
                id_cotation INTEGER NOT NULL,
                nom_voie VARCHAR(200) NOT NULL,
                orientation VARCHAR(300) NOT NULL,
                type_effort VARCHAR(250),
                altitude NUMERIC NOT NULL,
                nbr_longueur INTEGER NOT NULL,
                CONSTRAINT voie_pk PRIMARY KEY (id_voie)
);


ALTER SEQUENCE public.voie_id_voie_seq OWNED BY public.voie.id_voie;

CREATE SEQUENCE public.topo_id_topo_seq;

CREATE TABLE public.topo (
                id_topo INTEGER NOT NULL DEFAULT nextval('public.topo_id_topo_seq'),
                id_grimpeur INTEGER NOT NULL,
                nom_topo VARCHAR(100) NOT NULL,
                nbr_page INTEGER NOT NULL,
                nbr_photo INTEGER,
                CONSTRAINT topo_pk PRIMARY KEY (id_topo)
);


ALTER SEQUENCE public.topo_id_topo_seq OWNED BY public.topo.id_topo;

CREATE TABLE public.topo_site (
                id_site INTEGER NOT NULL,
                id_topo INTEGER NOT NULL,
                CONSTRAINT topo_site_pk PRIMARY KEY (id_site, id_topo)
);


CREATE TABLE public.reservation (
                id_topo INTEGER NOT NULL,
                id_grimpeur INTEGER NOT NULL,
                date_resa DATE NOT NULL,
                CONSTRAINT reservation_pk PRIMARY KEY (id_topo, id_grimpeur)
);


ALTER TABLE public.voie ADD CONSTRAINT cotation_voie_fk
FOREIGN KEY (id_cotation)
REFERENCES public.cotation (id_cotation)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.grimpeur ADD CONSTRAINT profil_grimpeur_fk
FOREIGN KEY (id_profil)
REFERENCES public.profil (id_profil)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.topo ADD CONSTRAINT grimpeur_topo_fk
FOREIGN KEY (id_grimpeur)
REFERENCES public.grimpeur (id_grimpeur)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commentaire ADD CONSTRAINT grimpeur_commentaire_fk
FOREIGN KEY (id_grimpeur)
REFERENCES public.grimpeur (id_grimpeur)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.reservation ADD CONSTRAINT grimpeur_reservation_fk
FOREIGN KEY (id_grimpeur)
REFERENCES public.grimpeur (id_grimpeur)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.secteur ADD CONSTRAINT site_secteur_fk
FOREIGN KEY (id_site)
REFERENCES public.site (id_site)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.topo_site ADD CONSTRAINT site_topo_site_fk
FOREIGN KEY (id_site)
REFERENCES public.site (id_site)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.voie ADD CONSTRAINT secteur_voie_fk
FOREIGN KEY (id_secteur)
REFERENCES public.secteur (id_secteur)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.reservation ADD CONSTRAINT topo_reservation_fk
FOREIGN KEY (id_topo)
REFERENCES public.topo (id_topo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.topo_site ADD CONSTRAINT topo_topo_site_fk
FOREIGN KEY (id_topo)
REFERENCES public.topo (id_topo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;