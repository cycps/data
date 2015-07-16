-- The Cypress Databse

CREATE TABLE systems (
  name ltree NOT NULL PRIMARY KEY
);

CREATE TABLE network_hosts (
  name text NOT NULL,
  sys ltree REFERENCES systems NOT NULL,
  PRIMARY KEY (name, sys)
);

CREATE TABLE computers (
  name text NOT NULL,
  sys ltree NOT NULL,
  os text NOT NULL,
  start_script text,
  FOREIGN KEY (name, sys) REFERENCES network_hosts,
  PRIMARY KEY (name, sys)
);

CREATE TABLE routers (
  name text NOT NULL,
  sys ltree NOT NULL,
  capacity numeric default 1000 NOT NULL,
  latency numeric default 0 NOT NULL,
  FOREIGN KEY (name, sys) REFERENCES network_hosts,
  PRIMARY KEY (name, sys)
);

CREATE TABLE switches (
  name text NOT NULL,
  sys ltree NOT NULL,
  capacity numeric default 1000 NOT NULL,
  latency numeric default 0 NOT NULL,
  FOREIGN KEY (name, sys) REFERENCES network_hosts,
  PRIMARY KEY (name, sys)
);

CREATE TABLE lan_links (
  name text NOT NULL,
  capacity numeric default 1000 NOT NULL,
  a_name text NOT NULL,
  a_sys ltree NOT NULL,
  b_name text NOT NULL,
  b_sys ltree NOT NULL,
  FOREIGN KEY (a_name, a_sys) REFERENCES network_hosts(name, sys),
  FOREIGN KEY (b_name, b_sys) REFERENCES network_hosts(name, sys),
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
  FOREIGN KEY (a_name, a_sys) REFERENCES routers(name, sys),
  FOREIGN KEY (b_name, b_sys) REFERENCES routers(name, sys),
  PRIMARY KEY (a_name, a_sys, b_name, b_sys)
);
