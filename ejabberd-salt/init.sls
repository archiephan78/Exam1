ejabberd:
  pkg.installed:
    - name: ejabberd
 
check status service:
  service.running:
    - name: ejabberd
    - enable: true
    - require:
      - pkg: ejabberd
# user:
#   - root

Config file ejabberd.yml:
  file.managed:
    - name: /etc/ejabberd/ejabberd.yml
    - source: salt://ejabberd/ejabberd.yml
    - mode: 0644
    - template: jinja
    - require:
      - service: check status service

#Restart service:
#  cmd.run:
#    - name: service ejabberd restart
#    - require:
#      - file: Config file ejabberd.yml

Create user:
  cmd.run:
    - name: ejabberdctl register chungphan localhost 123456
#    - require:
#     - cmd: Restart service
