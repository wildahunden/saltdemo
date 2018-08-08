mariadb-server:
  pkg.installed:
    - name: mariadb-server

python-mysqldb:
  pkg.installed:
    - name: python-mysqldb

mysql-service-enabled:
  service.running:
    - name: mysql
    - enable: true

root-password-set:
  mysql_query.run:
    - database: mysql
    - query: UPDATE user SET Password=PASSWORD('{{ salt['pillar.get']('mysql:lookup:rootDBPassword') }}') WHERE User='root';
    - connection_user: root
    - require:
      - pkg: mariadb-server
      - pkg: python-mysqldb

root-password-flush:
  mysql_query.run:
    - database: mysql
    - query: FLUSH PRIVILEGES;
    - connection_user: root
    - require:
      - pkg: mariadb-server
      - pkg: python-mysqldb
