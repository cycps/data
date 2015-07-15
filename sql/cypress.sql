CREATE TABLE systems (
  name ltree NOT NULL PRIMARY KEY,
)

CREATE TABLE network_hosts (
  name text NOT NULL,
  sys text REFERENCES systems NOT NULL
  PRIMARY KEY (name, sys)
);

CREATE TABLE computers (
  PRIMARY KEY (name, sys) references network_hosts(name, sys)
  os text NOT NULL
);

CREATE TABLE switches (
  PRIMARY KEY (name, sys) references network_hosts(name, sys)
  capacity numeric default 1000 NOT NULL,
  latency numeric default 0 NOT NULL
  PRIMARY KEY (name, sys)
);

CREATE TABLE routers (
  PRIMARY KEY (name, sys) references network_hosts(name, sys)
  capacity numeric default 1000 NOT NULL
);

CREATE TABLE lan_links (
  name text NOT NULL,
  FOREIGN KEY (a_name, a_sys) REFERENCES network_hosts(name, sys)
  FOREIGN KEY (b_name, b_sys) REFERENCES network_hosts(name, sys)
  capacity numeric default 1000 NOT NULL
  PRIMARY KEY (a_name, a_sys, b_name, b_sys)
);

CREATE TABLE wan_links (
  name text NOT NULL,
  FOREIGN KEY (a_name, a_sys) REFERENCES routers(name, sys)
  FOREIGN KEY (b_name, b_sys) REFERENCES routers(name, sys)
  capacity numeric default 1000 NOT NULL,
  latency numeric default 7 NOT NULL
  PRIMARY KEY (a_name, a_sys, b_name, b_sys)
);
