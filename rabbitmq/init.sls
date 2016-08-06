include:
{% if grains['os'] == 'CentOS' %}
  - epel
{% endif %}
  - rabbitmq.install
  - rabbitmq.configure
  - rabbitmq.service
  - rabbitmq.config
  - rabbitmq.config_vhost
  - rabbitmq.config_user
  - rabbitmq.config_bindings
  - rabbitmq.config_queue
  - rabbitmq.config_exchange
