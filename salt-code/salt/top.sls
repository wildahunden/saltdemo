base:
  '*': 
    - common
  'webserver*':
    - httpd
  'minion*':
    - nginx
    - users
    - ssh
