httpd:
  pkg.installed:
    - name: httpd
  service.running:
    - name: httpd
    - enable: true
