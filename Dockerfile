FROM ubuntu:15.04
RUN apt-get update && apt-get install -y \
  vim \
  tmux \
  postgresql \
  postgresql-contrib 

RUN sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /etc/postgresql/9.4/main/postgresql.conf
RUN bash -c " echo 'host    all             all             172.17.42.1/16           trust' >> /etc/postgresql/9.4/main/pg_hba.conf "
RUN bash -c " echo 'host    all             all             ::1/128           trust' >> /etc/postgresql/9.4/main/pg_hba.conf "
RUN bash -c " echo 'host    all             all             127.0.0.1/32           trust' >> /etc/postgresql/9.4/main/pg_hba.conf "
RUN bash -c " echo 'local    all             postgres        md5' >> /etc/postgresql/9.4/main/pg_hba.conf "
RUN sed -i "s/exit 101/exit 0/" /usr/sbin/policy-rc.d
RUN mkdir -p /cypress/

ADD sql/* /cypress/

USER postgres
RUN /etc/init.d/postgresql start && /cypress/createCypDB.sh
CMD ["/usr/lib/postgresql/9.4/bin/postgres", "-D", "/var/lib/postgresql/9.4/main", "-c", "config_file=/etc/postgresql/9.4/main/postgresql.conf"]

