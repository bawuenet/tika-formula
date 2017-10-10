---
{% from "tika/map.jinja" import tika with context -%}

tika_install_dependencies:
  pkg.installed:
    - pkgs: {{ tika.deps }}
