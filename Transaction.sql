-- ALTER TABLE product DROP COLUMN price;
 ALTER TABLE product
   ADD COLUMN price bigint NOT NULL DEFAULT(0);

-- DROP TABLE transaction;
CREATE TABLE transaction (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  cashierid uuid NOT NULL DEFAULT CAST('00000000-0000-0000-0000-000000000000' AS uuid),
  total bigint NOT NULL DEFAULT(0), -- There are many ways to represent monetary values, this is one: the number of cents
  transactiontype int NOT NULL DEFAULT(0),
  transactionreferenceid uuid NOT NULL DEFAULT CAST('00000000-0000-0000-0000-000000000000' AS uuid),
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT transaction_pkey PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

-- DROP TABLE transactionentry;
CREATE TABLE transactionentry (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  transactionid uuid NOT NULL DEFAULT CAST('00000000-0000-0000-0000-000000000000' AS uuid),
  productid uuid NOT NULL DEFAULT CAST('00000000-0000-0000-0000-000000000000' AS uuid),
  quantity decimal(15, 4) NOT NULL DEFAULT(0),
  price bigint NOT NULL DEFAULT(0), -- There are many ways to represent monetary values, this is one: the number of cents
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT transactionentry_pkey PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);
