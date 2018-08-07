ssh:
  file.managed:
    - name: /etc/ssh/sshd_config
    - source:  salt://ssh/files/sshd_config
