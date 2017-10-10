{% from "tika/map.jinja" import tika with context -%}
{% set tika_pkg = tika.web_package ~ '-' ~ tika.version ~ '.' ~ tika.web_extension %}
{% set tika_url = tika.baseurl ~ '/' ~ tika_pkg %}

tika_user:
  user.present:
    - name: {{ tika.user }}
    - home: /opt/tika
    - system: True
    - createhome: False
    - nologinit: True
    - fullname: 'Tika Server'
    - shell: /sbin/nologin

tika_dir:
  file.directory:
    - name: /opt/tika
    - user: {{ tika.user }}
    - group: {{ tika.user }}
    - mode: 0755

tika_get:
  file.managed:
    - name: /opt/tika/{{ tika_pkg }}
    - source:
      - http://repository.sys.bawue.net/local/artifacts/{{ tika_pkg }}
      - {{ tika_url }}
    - source_hash: d25c1851b3d448cc025666a6193cc1636ab412ecc5bea40e31431a16fe472fed
    - user: root
    - group: root
    - mode: 644
    - if_missing: /opt/tika/{{ tika_pkg }}
