include:
  - rabbitmq.install
  - rabbitmq.config
{% if grains['os'] == 'CentOS' %}
  - epel
{% endif %}
