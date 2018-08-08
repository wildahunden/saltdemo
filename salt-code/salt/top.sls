base:
  '*': 
    - common
    - ssh
    - users
  'webserver*'
    - httpd
  'minion*'
    - nginx
