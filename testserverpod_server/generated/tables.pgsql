--
-- Class Article as table articles
--

CREATE TABLE "articles" (
  "id" serial,
  "title" text NOT NULL,
  "content" text NOT NULL,
  "created" timestamp without time zone NOT NULL,
  "updated" timestamp without time zone NOT NULL,
  "isPrime" boolean NOT NULL
);

ALTER TABLE ONLY "articles"
  ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


