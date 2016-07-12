{% from "rabbitmq/map.jinja" import rabbitmq with context %}

{%- for name, binding in rabbitmq.get("bindings", {}).items() %}
rabbitmq_binding_{{ name }}:
  rabbitmq_binding.present:
    - source: {{ binding.source }}
    - vhost: {{ binding.vhost }}
    - destination: {{ binding.destination }}
    - destination_type: {{ binding.destination_type }}
    - routing_key: {{ binding.routing_key }}
    - require:
      - service: rabbitmq_service
{% endfor %}
