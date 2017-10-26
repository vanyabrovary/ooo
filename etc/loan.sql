CREATE DATABASE oo;
CREATE USER oo WITH password 'ooo';
GRANT ALL ON DATABASE oo TO oo;

CREATE TYPE loan_type       AS ENUM ('offer','request');
CREATE TYPE loan_state      AS ENUM ('new','open','cancelled','success');
CREATE TYPE currency_code   AS ENUM ('BTC','USD','EUR','USDT');
CREATE TYPE loan_term_type  AS ENUM ('d','m','y');

CREATE TABLE loan (
    "id" serial PRIMARY KEY,
    "type" loan_type not null,
    "client_id" integer ,
    "email" character varying(255) not null,
    "created_at" timestamp without time zone not null default timezone('utc'::text, now()),
    "opened_at" timestamp without time zone,
    "cancelled_at" timestamp without time zone,
    "state" loan_state not null default 'new'::loan_state,
    "principal_amount" numeric(16,8),
    "principal_currency" currency_code not null,
    "term_type" loan_term_type not null,
    "term" smallint not null,
    "interest_rate" numeric(5,2) not null,
    "ltv_initial" numeric(5,2) not null,
    "ltv_margin_call" numeric(5,2) not null,
    "ltv_collateral_sale" numeric(5,2) not null,
    "collateral_currency" currency_code not null
);

CREATE INDEX "loan_type"                ON "loan" ("type");
CREATE INDEX "loan_client_id"           ON "loan" ("client_id");
CREATE INDEX "loan_state"               ON "loan" ("state");
CREATE INDEX "loan_term_type"           ON "loan" ("term_type");
CREATE INDEX "loan_collateral_currency" ON "loan" ("collateral_currency");

ALTER TABLE loan ADD CHECK (principal_amount  >= 27 AND principal_amount <= 19000);
ALTER TABLE loan ADD CHECK (ltv_initial         > 0 AND ltv_initial         < 100);
ALTER TABLE loan ADD CHECK (ltv_margin_call     > 0 AND ltv_margin_call     < 100);
ALTER TABLE loan ADD CHECK (ltv_collateral_sale > 0 AND ltv_collateral_sale < 100);
ALTER TABLE loan ADD CHECK (interest_rate       > 0 AND interest_rate       < 100);
ALTER TABLE loan ADD CHECK (ltv_initial < ltv_margin_call AND ltv_margin_call < ltv_collateral_sale);

CREATE TABLE "client" (
    "id" serial NOT NULL,
    "name" character varying(255) NOT NULL,
    "email" character varying(255) NOT NULL
);

ALTER TABLE "client"
ADD CONSTRAINT "client_id" PRIMARY KEY ("id"),
ADD CONSTRAINT "client_name" UNIQUE ("name"),
ADD CONSTRAINT "client_email" UNIQUE ("email");