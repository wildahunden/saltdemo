httpd:
  pkg.installed:
    - name: httpd
  service.running:
    - name: httpd
    - enable: true

'echo DKW >> /var/www/html/index.html':
  cmd.run
