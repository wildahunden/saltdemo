redis-server:
  cmd.run:
    - name: |
        cd /tmp
        wget -c http://download.redis.io/redis-stable.tar.gz
        tar xvf redis-stable.tar.gz
        cd redis-stable
        make
        cp /src/redis-cli /usr/local/bin/
        make install
        cd utils
        ./install_server.sh
    - cwd: /tmp
    - shell: /bin/bash
    - timeout: 300
    - unless: test -x /usr/local/bin/redis-cli
