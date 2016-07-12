{% from "rabbitmq/map.jinja" import rabbitmq with context %}


{%- for name in rabbitmq.get("vhost", []) %}
rabbitmq_vhost_{{ name }}:
  rabbitmq_vhost.present:
    - name: {{ name }}
    - require:
      - service: rabbitmq_service
{% endfor %}
