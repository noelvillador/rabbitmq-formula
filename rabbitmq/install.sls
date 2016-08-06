{% from "rabbitmq/map.jinja" import rabbitmq with context %}



rabbitmq_pkg:
  pkg.installed:
    - name: 'rabbitmq-server'
    {%- if rabbitmq.get('version', False) %}
    - version: {{ rabbitmq.get('version', '') }}
    {%- endif %}
    {%- if rabbitmq.get('use_http_source', False) %}
    - sources:
      - rabbitmq-server: {{ rabbitmq.source_url }}
    {%- endif %}
{%- if grains['os'] == 'CentOS' %}
    - require:
      - sls: epel
{%- endif %}


rabbitmq_binary_tool_env:
  file.symlink:
    - makedirs: True
    - name: /usr/local/bin/rabbitmq-env
    - target: /usr/lib/rabbitmq/bin/rabbitmq-env
    - require:
      - pkg: rabbitmq_pkg

rabbitmq_binary_tool_plugins:
  file.symlink:
    - makedirs: True
    - name: /usr/local/bin/rabbitmq-plugins
    - target: /usr/lib/rabbitmq/bin/rabbitmq-plugins
    - require:
      - pkg: rabbitmq_pkg