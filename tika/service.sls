{% from "tika/map.jinja" import tika with context -%}

tika_sysconfig_file:
  file.managed:
    - name: /etc/sysconfig/tika
    - source: salt://tika/files/tika.sysconfig
    - user: root
    - group: root
    - mode: 0644
    - template: jinja

tika_service_file:
  file.managed:
    - name: /etc/systemd/system/tika.service
    - source: salt://tika/files/tika.service
    - template: jinja
    - user: root
    - group: root
    - mode: 0644

tika_service:
  service.running:
    - name: tika
    - enable: True
    - reload: False
    - require:
      - file: tika_sysconfig_file
      - file: tika_service_file
      - file: tika_get
    - watch:
      - file: /etc/sysconfig/tika
