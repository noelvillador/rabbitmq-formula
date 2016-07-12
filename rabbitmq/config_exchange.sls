{% from "rabbitmq/map.jinja" import rabbitmq with context %}

{%- for name, exchange in rabbitmq.get("exchanges", {}).items() %}
rabbitmq_exchange_{{ name }}:
  rabbitmq_exchange.present:
    - name: {{ exchange.name }}
    - vhost: {{ exchange.vhost }}
    - typename: {{ exchange.type }}
    - durable: {{ exchange.durable }}
    - auto_delete: {{ exchange.auto_delete }}
    - internal: {{ exchange.internal }}
    - require:
      - service: rabbitmq_service
{% endfor %}
