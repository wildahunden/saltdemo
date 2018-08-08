nginx:
  pkg.installed:
    - name: nginx

nginx.conf:
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source: salt://nginx/files/nginx.conf

nginx-service-enabled:
  service.running:
    - name: nginx
    - enable: true

