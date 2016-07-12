{% from "rabbitmq/map.jinja" import rabbitmq with context %}

{%- for name, queue in rabbitmq.get("queues", {}).items() %}
rabbitmq_queue_{{ name }}:
  rabbitmq_queue.present:
    - name: {{ queue.name }}
    - vhost: {{ queue.vhost }}
    - durable: {{ queue.durable }}
    - auto_delete: {{ queue.auto_delete }}
    - require:
      - service: rabbitmq_service
{% endfor %}
