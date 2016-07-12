{% from "rabbitmq/map.jinja" import rabbitmq with context %}

{%- for name, plugin in rabbitmq.get("plugin", {}).items() %}
plugin_{{ name }}:
  rabbitmq_plugin:
    - name: {{ name }}
    {% for value in plugin %}
    - {{ value }}
    {% endfor %}
    - runas: root
    - require:
      - pkg: rabbitmq-server
      - file: rabbitmq_binary_tool_plugins
    - watch_in:
      - service: rabbitmq_service
{% endfor %}

{%- for name, policy in rabbitmq.get("policy", {}).items() %}
policy_{{ name }}:
  rabbitmq_policy.present:
    - name: {{ name }}
    {% for value in policy %}
    - {{ value }}
    {% endfor %}
    - require:
      - service: rabbitmq_service
{% endfor %}

# need to create users and then vhosts
