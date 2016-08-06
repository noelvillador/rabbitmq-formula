/etc/rabbitmq/rabbitmq.config:
  file.managed:
    - user: root
    - group: root
    - mode: 0644
    - source: salt://rabbitmq/file/rabbitmq.template.template
    - template: jinja