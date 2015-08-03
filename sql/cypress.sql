-- The Cypress Databse

CREATE TABLE designs (
  id SERIAL PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE systems (
  id SERIAL PRIMARY KEY,
  name ltree NOT NULL
);

CREATE TABLE ids (
  id SERIAL PRIMARY KEY,
  name text NOT NULL,
  sys_id integer REFERENCES systems ON DELETE CASCADE NOT NULL,
  design_id integer REFERENCES designs ON DELETE CASCADE NOT NULL
);

CREATE TABLE positions (
  id SERIAL PRIMARY KEY,
  x float,
  y float,
  z float
);

CREATE TABLE packet_conductors (
  id SERIAL PRIMARY KEY,
  capacity integer,
  latency integer
);

CREATE TABLE network_hosts (
  id integer PRIMARY KEY REFERENCES ids ON DELETE CASCADE
);

CREATE TABLE interfaces (
  id SERIAL PRIMARY KEY,
  name text,
  host_id integer REFERENCES network_hosts ON DELETE CASCADE NOT NULL,
  packet_conductor_id integer REFERENCES packet_conductors
);

CREATE TABLE computers (
  id integer PRIMARY KEY REFERENCES network_hosts ON DELETE CASCADE,
  os text NOT NULL,
  start_script text
);

/*
CREATE TABLE routers (
  name text NOT NULL,
  sys ltree NOT NULL,
  capacity numeric default 1000 NOT NULL,
  latency numeric default 0 NOT NULL,
  FOREIGN KEY (name, sys) REFERENCES network_hosts ON DELETE CASCADE,
  PRIMARY KEY (name, sys)
);

CREATE TABLE switches (
  name text NOT NULL,
  sys ltree NOT NULL,
  capacity numeric default 1000 NOT NULL,
  latency numeric default 0 NOT NULL,
  FOREIGN KEY (name, sys) REFERENCES network_hosts ON DELETE CASCADE,
  PRIMARY KEY (name, sys)
);

CREATE TABLE lan_links (
  name text NOT NULL,
  capacity numeric default 1000 NOT NULL,
  a_name text NOT NULL,
  a_sys ltree NOT NULL,
  b_name text NOT NULL,
  b_sys ltree NOT NULL,
  FOREIGN KEY (a_name, a_sys) REFERENCES network_hosts(name, sys) ON DELETE CASCADE,
  FOREIGN KEY (b_name, b_sys) REFERENCES network_hosts(name, sys) ON DELETE CASCADE,
  PRIMARY KEY (a_name, a_sys, b_name, b_sys)
);

CREATE TABLE wan_links (
  name text NOT NULL,
  capacity numeric default 1000 NOT NULL,
  latency numeric default 7 NOT NULL,
  a_name text NOT NULL,
  a_sys ltree NOT NULL,
  b_name text NOT NULL,
  b_sys ltree NOT NULL,
  FOREIGN KEY (a_name, a_sys) REFERENCES routers(name, sys) ON DELETE CASCADE,
  FOREIGN KEY (b_name, b_sys) REFERENCES routers(name, sys) ON DELETE CASCADE,
  PRIMARY KEY (a_name, a_sys, b_name, b_sys)
);



INSERT INTO systems VALUES ('system47');
*/
