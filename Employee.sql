CREATE TABLE employee (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  employeeid character varying(5) NOT NULL DEFAULT(''), -- We think this has been limited to 5 numerical characters by switching to a character instead of an int
  firstname character varying(128) NOT NULL DEFAULT(''),
  lastname character varying(128) NOT NULL DEFAULT(''),
  --password bytea NOT NULL DEFAULT(''),  -- original line of code
  password character varying(256) NOT NULL DEFAULT('a'), -- This reflects table on heroku 2/16/21 3:31pm
  active boolean NOT NULL DEFAULT(FALSE), 
  classification int NOT NULL DEFAULT(0),
  managerid uuid NOT NULL DEFAULT CAST('00000000-0000-0000-0000-000000000000' AS uuid),
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT employee_pkey PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

--  A cheap way to prevent malicious actors from using employee IDs to determine
-- how many employees are in your company. Obviously this is not foolproof.
CREATE SEQUENCE employee_employeeid_seq AS int START WITH 253 INCREMENT BY 7 OWNED BY employee.employeeid;

ALTER TABLE employee ALTER employeeid SET DEFAULT nextval('employee_employeeid_seq');

CREATE INDEX ix_employee_employeeid
  ON employee
  USING btree(employeeid);

-- Adding Three Records to employee table
INSERT INTO employee (id, employeeid, firstname, lastname, classification, managerid, password) VALUES (
      gen_random_uuid()
    , 'M0001'  -- employeeid (5 characters)
    , 'Antoni' -- first name
    , 'Jones' -- last name
    , 2 -- classification 2 is manager
    , gen_random_uuid() -- managerid uuid
    , 'a' -- password as character
);
INSERT INTO employee (id, employeeid, firstname, lastname, classification) VALUES (
      gen_random_uuid()
    , 'M0001'  -- employeeid (5 characters)
    , 'Manny' -- first name
    , 'Hustler' -- last name
    , 1 -- classification 1 is cashier
);
INSERT INTO employee (id, employeeid, firstname, lastname, classification, managerid, password) VALUES (
      gen_random_uuid()
    , 'S0001'  -- employeeid (5 characters)
    , 'Russell' -- first name
    , 'Tover' -- last name
    , 3 -- classification 1 is shift-manager
    , gen_random_uuid() -- managerid uuid
    , 'b' -- password as character
);
-----
CREATE TABLE activeuser (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  employeeid uuid NOT NULL,
  name character varying(256) NOT NULL DEFAULT(''),
  classification int NOT NULL DEFAULT(0),
  sessionkey character varying(128) NOT NULL DEFAULT(''), -- Removed a space after varying to fix an error
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT activeuser_pkey PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

CREATE INDEX ix_activeuser_employeeid
  ON activeuser
  USING btree(employeeid);

CREATE INDEX ix_activeuser_sessionkey
  ON activeuser
  USING btree(sessionkey);

-- commit to the same branch
