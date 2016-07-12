{% from "rabbitmq/map.jinja" import rabbitmq with context %}

{%- for name, user in rabbitmq.get("user", {}).items() %}
rabbitmq_user_{{ name }}:
  rabbitmq_user.present:
    - name: {{ name }}
    {% for value in user %}
    - {{ value }}
    {% endfor %}
    - require:
      - service: rabbitmq_service
      - sls: rabbitmq.config_vhost
{% endfor %}
