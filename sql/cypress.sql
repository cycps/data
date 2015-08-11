-- The Cypress Databse

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name text UNIQUE NOT NULL,
  pwh text NOT NULL
);

CREATE TABLE designs (
  id SERIAL PRIMARY KEY,
  owner integer REFERENCES users NOT NULL,
  name text NOT NULL,
  UNIQUE (owner, name)
);

CREATE TABLE systems (
  id SERIAL PRIMARY KEY,
  design_id integer REFERENCES designs ON DELETE CASCADE NOT NULL,
  name ltree NOT NULL,
  UNIQUE (design_id, name)
);

CREATE TABLE ids (
  id SERIAL PRIMARY KEY,
  name text NOT NULL,
  sys_id integer REFERENCES systems ON DELETE CASCADE NOT NULL,
  UNIQUE (name, sys_id)
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
  packet_conductor_id integer REFERENCES packet_conductors NOT NULL,
  UNIQUE (name, host_id)
);

CREATE TABLE computers (
  id integer PRIMARY KEY REFERENCES network_hosts ON DELETE CASCADE,
  os text NOT NULL,
  start_script text,
  position_id integer REFERENCES positions NOT NULL
);

CREATE TABLE models (
  id integer PRIMARY KEY REFERENCES ids ON DELETE CASCADE,
  position_id integer REFERENCES positions NOT NULL,
  params text DEFAULT '',
  equations text DEFAULT ''
);

CREATE TABLE saxs (
  id integer PRIMARY KEY REFERENCES ids ON DELETE CASCADE,
  position_id integer REFERENCES positions NOT NULL,
  sense text DEFAULT '',
  actuate text DEFAULT ''
);

CREATE TABLE plinks (
  id integer PRIMARY KEY REFERENCES ids ON DELETE CASCADE,
  endpoint_a_id integer REFERENCES ids ON DELETE CASCADE NOT NULL,
  endpoint_b_id integer REFERENCES ids ON DELETE CASCADE NOT NULL,
  epa_bindings text DEFAULT '',
  epb_bindings text DEFAULT ''
);

CREATE TABLE routers (
  id integer PRIMARY KEY REFERENCES network_hosts ON DELETE CASCADE,
  packet_conductor_id integer REFERENCES packet_conductors NOT NULL,
  position_id integer REFERENCES positions NOT NULL
);

CREATE TABLE switches (
  id integer PRIMARY KEY REFERENCES ids ON DELETE CASCADE,
  packet_conductor_id integer REFERENCES packet_conductors,
  position_id integer REFERENCES positions NOT NULL
);

CREATE TABLE links (
  id integer PRIMARY KEY REFERENCES ids ON DELETE CASCADE,
  packet_conductor_id integer REFERENCES packet_conductors,
  endpoint_a_id integer REFERENCES network_hosts ON DELETE CASCADE NOT NULL,
  interface_a_id integer REFERENCES interfaces ON DELETE CASCADE NOT NULL,
  endpoint_b_id integer REFERENCES network_hosts ON DELETE CASCADE NOT NULL,
  interface_b_id integer REFERENCES interfaces ON DELETE CASCADE NOT NULL
);


INSERT INTO users (name, pwh) VALUES ('murphy', crypt('muffins', gen_salt('bf')));

