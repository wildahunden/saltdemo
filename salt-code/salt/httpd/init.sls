httpd:
  pkg.installed:
    - name: httpd

httpd-service-enabled:
  service.running:
    - name: httpd
    - enable: true
