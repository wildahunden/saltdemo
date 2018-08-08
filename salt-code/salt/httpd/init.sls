httpd:
  pkg.installed:
    - name: httpd
  service.running:
    - name: httpd
    - enable: true

"echo '<html><head></head><body><pre><code>' > /var/www/html/index.html":
  cmd.run

'hostname -f >> /var/www/html/index.html':
  cmd.run

"echo '' >> /var/www/html/index.html":
  cmd.run

"cat /etc/os-release >> /var/www/html/index.html":
  cmd.run

'echo DKW >> /var/www/html/index.html':
  cmd.run

"echo '</code></pre></body></html>' >> /var/www/html/index.html":
  cmd.run
